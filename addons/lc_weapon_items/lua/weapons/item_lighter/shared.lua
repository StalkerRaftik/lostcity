if SERVER then
	AddCSLuaFile()
	SWEP.Weight = 5
	SWEP.AutoSwitchTo = false
	SWEP.AutoSwitchFrom = false
else
	SWEP.PrintName = "Зажигалка"
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
	SWEP.ViewModelFOV = 70
	SWEP.ViewModelFlip = false
	SWEP.DrawSecondaryAmmo = false
end

game.AddParticles("particles/lighter.pcf")
PrecacheParticleSystem("lighter_flame")

SWEP.Author = "Unrealomega"
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.Instructions = "Left Click: Fire."

SWEP.ViewModel = "models/weapons/c_lighter.mdl"
SWEP.WorldModel = "models/weapons/w_lighter_fix.mdl"
SWEP.UseHands	= true

SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.Sounds_Draw = Sound("lighter/lighter_draw.wav")
SWEP.Sounds_Holster = Sound("lighter/lighter_holster.wav")
SWEP.HoldType = "pistol"
SWEP.HoldTypeOff = "normal"

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

function SWEP:Initialize()

	self:SetWeaponHoldType( self.HoldType )

end

function SWEP:Holster()
	local vmodel = self.Owner:GetViewModel()
	if IsValid(vmodel) then
		vmodel:StopParticles()
	end
	self:EmitSound(self.Sounds_Holster, 100, 100)
	return true
end

function SWEP:Deploy()
	timer.Simple(0.001, function()
		self:SetNWBool("Light", true)
	end, self)
	self:SendWeaponAnim(ACT_VM_DRAW)
	ParticleEffectAttach( "lighter_flame", PATTACH_POINT_FOLLOW, self.Owner:GetViewModel(), 1 )
	self:EmitSound(self.Sounds_Draw, 100, 100)
	return true
end

function SWEP:PrimaryAttack()
	if !self:CanPrimaryAttack() then return end
	
	self:ToggleLighter()
	
	self:SetNextPrimaryFire(CurTime() + self:SequenceDuration())
end

function SWEP:CanPrimaryAttack()
	return self:GetNextPrimaryFire() <= CurTime()
end

function SWEP:SecondaryAttack()
	if !self:CanSecondaryAttack() || !self:IsLit() then return end
	
	local pos = self.Owner:EyePos()
	local trace = util.TraceLine({
			["start"] = pos,
			["endpos"] = pos + (self.Owner:GetAimVector() * 128),
			["filter"] = self.Owner
		})
	
	if trace.Hit && IsValid(trace.Entity) && !trace.Entity:IsWorld() then
		local success = false		
		
		if trace.Entity:GetClass() == "ent_candle" then
			if SERVER then
				local action = !trace.Entity:IsLit()
				
				if action then // If it's going to light the candle, it should do the animation.
					self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
				end
				
				setLight(trace.Entity, action) // Toggle
			end
			success = true
		end
		
		if success then
			self:SetNextPrimaryFire(CurTime() + 1)
		end
	end
end

function SWEP:CanSecondaryAttack()
	return self:CanPrimaryAttack()
end

function SWEP:Reload() end

function SWEP:ToggleLighter()
	
	if self:IsLit() then
		// Put Lighter away
		self:SendWeaponAnim(ACT_VM_HOLSTER)
		self:EmitSound(self.Sounds_Holster, 100, 100)
		
		self:SetWeaponHoldType( self.HoldTypeOff )
		
		timer.Simple(self:SequenceDuration(), function()
				self.Owner:GetViewModel():StopParticles()
				self:SetNWBool("Light", false)
		end, self)
	else			
		// Take Lighter Out
		self:SendWeaponAnim(ACT_VM_DRAW)
		self:SetNWBool("Light", true)
		
		ParticleEffectAttach( "lighter_flame", PATTACH_POINT_FOLLOW, self.Owner:GetViewModel(), 1 )
		self:EmitSound(self.Sounds_Draw, 100, 100)
		
		self:SetWeaponHoldType( self.HoldType )
		
		timer.Simple(self:SequenceDuration(), function()
				self:SendWeaponAnim(ACT_VM_IDLE)
		end, self)
	end
end

function SWEP:IsLit()
	return self:GetNWBool("Light", true)
end

function SWEP:GetLightColor()
	return 212, 131, 43
end

local m_DrawInstruction = false
local m_Crosshair = Material("effects/softglow")

function SWEP:DrawHUD()
	local pos = LocalPlayer():EyePos()
	local trace = util.TraceLine({
			["start"] = pos, 
			["endpos"] = pos + (LocalPlayer():GetAimVector() * 128), 
			["filter"] = LocalPlayer()
		})
			
	if trace.Fraction < 1 then
		local alpha, pos, size = (1 - trace.Fraction) * 255, trace.HitPos:ToScreen(), ScreenScale(8)
		local radius = size / 2				
			
		if self:IsLit() && trace.Hit && IsValid(trace.Entity) && trace.Entity:GetClass() == "ent_candle" then
			draw.SimpleText("Secondary: " .. ((trace.Entity:IsLit() && "Extinguish") || "Light"), "HudHintTextLarge", pos.x, pos.y + radius + 10, COLOR_BLUE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end		
	end	
end

if CLIENT then

function SWEP:Think()
	if self:IsLit() then
	
		local dlight = DynamicLight( self:EntIndex() .. "_lighter" )
				
		if dlight then
			/*local pos = self:GetAttachment(self:LookupAttachment("lighter_fire_point"))
				
			if pos then					
				pos = pos.Pos
			else
				pos = self.Owner:EyePos()
			end*/
					
			dlight.Pos = self.Owner:EyePos()
			dlight.r = 212
			dlight.g = 131
			dlight.b = 43
			dlight.Brightness = 2
			dlight.Size = 128
			//dlight.Decay = dlight.Size * 5
			dlight.DieTime = CurTime() + .01
			dlight.Style = 1
		end

	end
			
	self:NextThink(CurTime() + .01)
	return true
end

	function SWEP:ShouldDropOnDie()
		return false
	end
end