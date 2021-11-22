sound.Add({	name		= "V92_Uni_QuickMove",
	channel		= CHAN_WEAPON,
	level		= 100,
	volume		= 1.0,
	pitch		= { 95, 105 },
	sound		= "jessev92/weapons/univ/throw_gren.wav",
})

sound.Add({	name		= "V92_Uni_Draw",
	channel		= CHAN_BODY,
	level		= 75,
	volume		= 1.0,
	pitch		= { 95, 105 },
	sound		= "jessev92/weapons/univ/draw1.wav",
})

sound.Add({	name		= "V92_Uni_Holster",
	channel		= CHAN_BODY,
	level		= 75,
	volume		= 1.0,
	pitch		= { 95, 105 },
	sound		= "jessev92/weapons/univ/holster1.wav",
})

local detector_ai_maxrange = CreateConVar( 'detector_ai_maxrange', '2000', { FCVAR_REPLICATED, FCVAR_ARCHIVE } )

SWEP.PrintName			= "Дозиметр"			
SWEP.Slot				= 3
SWEP.SlotPos			= 1
SWEP.Category = "Detectors"
SWEP.Author	= "Subleader and AirBlack"
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.Instructions = ""	
SWEP.Base	= "base_sweps_detector"
SWEP.HoldType = "slam"
SWEP.ViewModelFOV = 65
SWEP.ViewModelFlip = true
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/c_grenade.mdl"
SWEP.WorldModel = "models/tfa/pistolshell.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.Spawnable	= true
SWEP.AdminSpawnable	= true

SWEP.UseDel = CurTime()

function SWEP:IdleTiming()
end

SWEP.Primary.Delay				= 0
SWEP.Primary.Recoil				= 0
SWEP.Primary.Damage				= 0
SWEP.Primary.NumShots			= 0
SWEP.Primary.Cone				= 0	
SWEP.Primary.ClipSize			= 1
SWEP.Primary.DefaultClip		= 25
SWEP.Primary.Automatic   		= false
SWEP.Primary.Ammo         		= "pistol"
SWEP.Secondary.Delay			= 0
SWEP.Secondary.Recoil			= 0
SWEP.Secondary.Damage			= 0
SWEP.Secondary.NumShots			= 0
SWEP.Secondary.Cone		  		= 0
SWEP.Secondary.ClipSize			= -1
SWEP.Secondary.DefaultClip		= -1
SWEP.Secondary.Automatic   		= false
SWEP.Secondary.Ammo         	= "none"

SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_R_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(1.652, 7.097, 5.008), angle = Angle(-12.851, 25.636, 25.993) },
	["ValveBiped.Grenade_body"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}

SWEP.IronSightsPos = Vector(0, 0, 0)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.VElements = {
	["v_element"] = { type = "Model", model = "models/lt_c/alienisolation/track3r/motion_track3r.mdl", bone = "ValveBiped.Grenade_body", rel = "", pos = Vector(0, -22.467, 0), angle = Angle(0, 20, 180), size = Vector(1.75, 1.75, 1.75), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["w_element"] = { type = "Model", model = "models/lt_c/alienisolation/track3r/motion_track3r.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.937, 1.258, 0), angle = Angle(6.796, -11.094, -178.243), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

function SWEP:PrimaryAttack()
end
function SWEP:SecondaryAttack()
end




function SWEP:Deploy()
	timer.Simple( 0.75, function()	
	end)
	return true
end

local entities = {}
entities["rp_newradiation"] = true

SWEP.LastBeep = 0
SWEP.cooldown = 0
SWEP.anoms = {}
function SWEP:Think()
	if CLIENT then return end
	if CurTime() < self.LastBeep then return end

	if CurTime() > self.cooldown then
		self.cooldown = CurTime() + 3
		anoms = {}
		for k,v in pairs(ents.GetAll()) do
			if entities[string.lower(v:GetClass())]then
				table.insert(anoms, v)
			end
		end
	end

	-- local dist = detector_ai_maxrange:GetFloat() + 1
	-- local ent = nil
	local dist
	for k,v in pairs(anoms) do
		if not IsValid(v) then continue end

		local pos = v:GetPos()

		local plypos = self.Owner:GetPos()
		dist = pos:Distance(plypos)

		-- local dek = pos - self.Owner:GetShootPos()
		-- local aimvec = self.Owner:GetAimVector()
		-- local sos = dek:GetNormalized()
		-- local dot = sos:Dot(aimvec)
		-- local clampdot = (1-math.Clamp(dot, 0, 0.5))
		-- if v:GetPos():Distance(self.Owner:GetPos())*clampdot < dist then
		-- 	dist = v:GetPos():Distance(self.Owner:GetPos())*clampdot
		-- 	ent = v
		-- end
	end
	if dist and dist < 2000 then
		if self.LastBeep + dist/1000 - CurTime() <= 0 then
			self.LastBeep = CurTime() + 0.3
			self.Owner:EmitSound("weapons/motiontracker_blep02.wav", SNDLVL_55dB)
			//math.Clamp(250-dist/2,50,250)
		end
	end
end