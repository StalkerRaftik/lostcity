SWEP.Base = "tfa_gun_base"

SWEP.PrintName = "Гранатомёт [Other]"
SWEP.Author = "Darky"
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.Instructions = ""

SWEP.Category = "LostCity Weapon Other"

--[[VIEWMODEL BLOWBACK]]--
SWEP.BlowbackEnabled = false --Enable Blowback?
SWEP.BlowbackVector = Vector(0,-3.5,0) --Vector to move bone <or root> relative to bone <or view> orientation.
SWEP.BlowbackCurrentRoot = 0 --Amount of blowback currently, for root
SWEP.BlowbackCurrent = 0 --Amount of blowback currently, for bones
SWEP.BlowbackBoneMods = {
}

SWEP.Spawnable= true
SWEP.AdminSpawnable= true
SWEP.AdminOnly = false
SWEP.CSMuzzleFlashes = false
SWEP.MuzzleFlashEffect = nil

SWEP.MuzzleAttachment			= "0"						-- "1" CSS models / "muzzle" hl2 models
SWEP.ShellAttachment			= "1"						-- "2" CSS models / "shell" hl2 models
SWEP.MuzzleFlashEnabled 		= true


-- Shell eject override
SWEP.LuaShellEject = false --Enable shell ejection through lua?
SWEP.LuaShellEjectDelay = 0 --The delay to actually eject things
SWEP.LuaShellModel = nil --The model to use for ejected shells
SWEP.LuaShellScale = nil --The model scale to use for ejected shells
SWEP.LuaShellYaw = nil --The model yaw rotation ( relative ) to use for ejected shells


SWEP.HoldType = "shotgun"
SWEP.ViewModelFOV = 60
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/darky_m/rust/c_grenadelauncher.mdl"
SWEP.WorldModel = "models/weapons/darky_m/rust/w_grenadelauncher.mdl"

SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.ViewModelBoneMods = {
}

SWEP.Akimbo = false
SWEP.Shotgun = true


SWEP.Secondary.BashLength = 54
SWEP.Secondary.BashDelay = 7/60
SWEP.Secondary.BashDamage = 30



SWEP.IronSightsPos = Vector(-5.919, -6.89, 4.763)
SWEP.IronSightsAng = Vector(-4.45, -1.241, 8.677)

SWEP.IronSightsPos_msHolosight =  Vector(-5.685, -6.89, 3.58)
SWEP.IronSightsAng_msHolosight = Vector(-4.45, -1.241, 8.677)

SWEP.IronSightsPos_Holo =  Vector(-5.775, -6.89, 4.13)
SWEP.IronSightsAng_Holo = Vector(-4.45, -1.241, 8.677)

SWEP.IronSightsPos_8xscope = Vector(-5.874, -3.89, 4.36)
SWEP.IronSightsAng_8xscope = Vector(-4.45, -1.241, 8.677)

SWEP.IronSightsPos_4xscope =  Vector(-5.899, -3.89, 4.539)
SWEP.IronSightsAng_4xscope = Vector(-4.45, -1.241, 8.677)

SWEP.RunSightsPos = Vector(1.222, 0, -1.415)
SWEP.RunSightsAng = Vector(-16.848, -1.236, -3.247)

SWEP.Attachments = {
	[1] = {atts = {"darky_rust_gl_shotgun","darky_rust_gl_smoke"}},
	[2] = {atts = {"darky_rust_ms_holosight", "darky_rust_holo", "darky_rust_4x", "darky_rust_8x"}},
	[3] = {atts = {"darky_rust_laser", "darky_rust_flash"}},
}


local rust_holo_material = Material( "models/darky_m/rust_weapons/mods/holosight.reticle.standard.png" )
local rust_ms_material = Material( "models/darky_m/rust_weapons/mods/xhair_highvis.png" )

SWEP.VElements = {
	["ms_holosight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_ms_holosight.mdl", bone = "barrel", rel = "", pos = Vector(0.05, -4+1.8, 4.0-2), angle = Angle(180, -90, -90), size = Vector(1.15, 1.15, 1.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["ms_holosight_xhair"] = { type = "Quad", bone = "barrel", rel = "ms_holosight", pos = Vector(0.519, 0, 0), angle = Angle(-90, 0, 90), size = 0.01, active = false, draw_func = function()   surface.SetDrawColor(255,255,255,255) surface.SetMaterial( rust_ms_material ) surface.DrawTexturedRect(-70, -70, 140, 140) end },

	["holosight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_holo.mdl", bone = "barrel", rel = "", pos = Vector(-0.125+0.05, -3.5+1.8, 4.0-2), angle = Angle(180, -90, 0), size = Vector(0.9, 0.9, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["holosight_lens"] = { type = "Quad", bone = "barrel", rel = "holosight", pos = Vector(0.47, -0.123, 0.3), angle = Angle(0, -90, 0), size = 0.01, active = false, draw_func = function()     surface.SetDrawColor(255,0,0,255) surface.SetMaterial( rust_holo_material ) surface.DrawTexturedRect(-40, -40, 80, 80) end },
	["8xscope"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_8xScope.mdl", bone = "barrel", rel = "", pos = Vector(0.05, -2.4+1.8, 6.7-3), angle = Angle(180, 0, -90), size = Vector(1, 0.7, 1), color = Color(255, 255, 255, 255), surpresslightning = false, materials = {"","","!tfa_rtmaterial"}, skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["4xscope"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_reddot.mdl", bone = "barrel", rel = "", pos = Vector(0.3, -4.3+1.8, 4.0-2), angle = Angle(0, 0, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, materials = {"","","!tfa_rtmaterial"}, skin = 0, bonemerge = false, active = false, bodygroup = {} },
	
	["lasersight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_laser.mdl", bone = "barrel", rel = "", pos = Vector(1.5+1, -1.9+4.5, 19-5), angle = Angle(0, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["flashlight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_flash.mdl", bone = "barrel", rel = "", pos = Vector(2.19+1, -2.25+4.5, 19-5), angle = Angle(0, 0, 180), size = Vector(1.1, 1.1, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["laser_beam"] = { type = "Model", model = "models/tfa/lbeam.mdl", bone = "barrel", rel = "lasersight", pos = Vector(0.5,0,-1), angle = Angle(-90, 0, 0), size = Vector(2, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = false, active = false },

}

SWEP.WElements = {
	["w_offset"] = { type = "Quad", bone = "main", rel = "", pos = Vector(7, 0.7, -6.7), angle = Angle(0, -90, -100), size = 1, active = true, draw_func = nil },
	["ms_holosight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_ms_holosight.mdl", bone = "barrel", rel = "w_offset", pos = Vector(0.05, -4+1.8, 4.0-2), angle = Angle(180, -90, -90), size = Vector(1.15, 1.15, 1.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["holosight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_holo.mdl", bone = "barrel", rel = "w_offset", pos = Vector(-0.125+0.05, -3.5+1.8, 4.0-2), angle = Angle(180, -90, 0), size = Vector(0.9, 0.9, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["8xscope"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_8xScope.mdl", bone = "barrel", rel = "w_offset", pos = Vector(0.05, -2.4+1.8, 6.7-3), angle = Angle(180, 0, -90), size = Vector(1, 0.7, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["4xscope"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_reddot.mdl", bone = "barrel", rel = "w_offset", pos = Vector(0.3, -4.3+1.8, 4.0-2), angle = Angle(0, 0, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	
	["lasersight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_laser.mdl", bone = "barrel", rel = "w_offset", pos = Vector(1.5+1, -1.9+4.5, 19-5), angle = Angle(0, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["flashlight"] = { type = "Model", model = "models/weapons/darky_m/rust/mod_flash.mdl", bone = "barrel", rel = "w_offset", pos = Vector(2.19+1, -2.25+4.5, 19-5), angle = Angle(0, 0, 180), size = Vector(1.1, 1.1, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["laser_dot"] = { type = "Sprite", sprite = "effects/tfalaserdot", bone = "main", rel = "lasersight", pos = Vector(0.4, 0, -2), size = { x = 4, y = 4 }, color = Color(255, 0, 0, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false, active = false},
	["flash_sprite"] = { type = "Sprite", sprite = "effects/blueflare1", bone = "main", rel = "flashlight", pos = Vector(0.3, 0, -4), size = { x = 15, y = 15 }, color = Color(255, 255, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false, active = false}
}



SWEP.RTOpaque	= true
SWEP.LaserDistance = 4000
SWEP.LaserDistanceVisual = 4000


SWEP.Type = "Grenade launcher"

SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = true

SWEP.Slot = 4
SWEP.SlotPos = 74
 
SWEP.UseHands = true

SWEP.FiresUnderwater = true

SWEP.DrawCrosshair = true

SWEP.DrawAmmo = true

SWEP.ReloadSound = ""

SWEP.BoltAction = false 


SWEP.Primary.IronAccuracy_SG = .075

SWEP.Primary.KickUp = 2.2 -- This is the maximum upwards recoil (rise)
SWEP.Primary.KickDown = 2.1 -- This is the maximum downwards recoil (skeet)
SWEP.Primary.KickHorizontal = 0.05 -- This is the maximum sideways recoil (no real term)
SWEP.Primary.StaticRecoilFactor = 0.5 --Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.  This is also affected by a convar that defaults to 0.5.
--Firing Cone Related
SWEP.Primary.Spread = .03 --This is hip-fire acuracy.  Less is more (1 is horribly awful, .0001 is close to perfect)
SWEP.Primary.IronAccuracy = .03 -- Ironsight accuracy, should be the same for shotguns
--Unless you can do this manually, autodetect it.  If you decide to manually do these, uncomment this block and remove this line.
SWEP.Primary.SpreadMultiplierMax = 4 --How far the spread can expand when you shoot. Example val: 2.5
SWEP.Primary.SpreadIncrement = 0.25 --What percentage of the modifier is added on, per shot.  Example val: 1/3.5
SWEP.Primary.SpreadRecovery = 5 --How much the spread recovers, per second. Example val: 3
--Range Related
SWEP.Primary.Range = (980 * 1) -- The distance the bullet can travel in source units.  Set to -1 to autodetect based on damage/rpm.
SWEP.Primary.RangeFalloff = 0.2 -- The percentage of the range the bullet damage starts to fall off at.  Set to 0.8, for example, to start falling off after 80% of the range.
--Misc
SWEP.CrouchAccuracyMultiplier = 0.8 --Less is more.  Accuracy * 0.5 = Twice as accurate, Accuracy * 0.1 = Ten times as accurate
--Movespeed
SWEP.MoveSpeed = 0.8 --Multiply the player's movespeed by this.
SWEP.IronSightsMoveSpeed = 0.75 --Multiply the player's movespeed by this when sighting.
-- Selective Fire Stuff
SWEP.SelectiveFire = false --Allow selecting your firemode?
SWEP.DisableBurstFire = true --Only auto/single?
SWEP.OnlyBurstFire = false --No auto, only burst/single?

SWEP.IronSightTime = 0.4

SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0,0,0)
SWEP.VMPos_Additive = false --Set to false for an easier time using VMPos. If true, VMPos will act as a constant delta ON TOP OF ironsights, run, whateverelse

SWEP.Primary.Sound = "darky_rust.grenade-launcher-attack" -- This is the sound of the weapon, when you shoot.

SWEP.Primary.Damage = 90
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.ClipSize = 6
SWEP.Primary.NumShots = 1
SWEP.Primary.Ammo = "SMG1_Grenade"
SWEP.Primary.DefaultClip = 6
SWEP.Primary.Automatic = false
SWEP.Primary.Recoil = 1
SWEP.Primary.RPM = 150
SWEP.Primary.Force = 1

SWEP.Secondary.ClipSize = 0
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"


	-- [ Iron_Sights ]
	SWEP.data 					= {}
	SWEP.data.ironsights 			= 1
	SWEP.Secondary.IronFOV 		= 60
	SWEP.IronSightsSensitivity 		= 1							-- 0.XX = XX%
						-- Scale of the reticle overlay





--[[INSPECTION]]--
-- SWEP.InspectPos = Vector(0, -4, -10)
-- SWEP.InspectAng = Vector(45, 0, 0)
SWEP.InspectPos = nil
SWEP.InspectAng = nil

--[[SPRINTING]]--
SWEP.RunSightsPos = Vector(1, 0, 1)
SWEP.RunSightsAng = Vector(-18, 0, 0)

SWEP.Sights_Mode = TFA.Enum.ANI -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Sprint_Mode = TFA.Enum.Lua -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation

SWEP.ShellAttachment			 = "shell" 		              -- Should be "2" for CSS models or "shell" for hl2 models
SWEP.MuzzleAttachment			 = "0" 	              -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.MuzzleFlashEnabled          = true                       -- Enable muzzle flash
SWEP.MuzzleFlashEffect           = "tfa_muzzleflash_shotgun"
SWEP.MuzzleAttachmentRaw         = nil                        -- This will override whatever string you gave.  This is the raw attachment number.  This is overridden or created when a gun makes a muzzle event.
SWEP.AutoDetectMuzzleAttachment  = false                      -- For multi-barrel weapons, detect the proper attachment?
SWEP.SmokeParticle               = nil                        -- Smoke particle (ID within the PCF), defaults to something else based on holdtype; "" to disable
SWEP.EjectionSmokeEnabled        = false
SWEP.DisableChambering = true
-- Shell eject override
SWEP.LuaShellEject               = false                      -- Enable shell ejection through lua?
SWEP.LuaShellEjectDelay          = 0
SWEP.LuaShellScale = 2
SWEP.LuaShellModel = "models/weapons/darky_m/rust/shotgun_shell_handmade.mdl"
SWEP.LuaShellEffect              = "RifleShellEject"          -- The effect used for shell ejection; Defaults to that used for blowback
-- SWEP.LuaShellYaw = 180
-- Tracer Stuff
SWEP.TracerName 		         = nil 	                      -- Change to a string of your tracer name.  Can be custom. There is a nice example at https://github.com/garrynewman/garrysmod/blob/master/garrysmod/gamemodes/base/entities/effects/tooltracer.lua
SWEP.TracerCount  = 0 	

SWEP.IronAnimation = {
}
DEFINE_BASECLASS(SWEP.Base)

SWEP.Primary.Radius		= 212

SWEP.Primary.Projectile = "rust_glammo"
SWEP.Primary.ProjectileModel = "models/weapons/darky_m/rust/gl_ammo.mdl"
SWEP.Primary.ProjectileVelocity = 1800

function SWEP:ShootBulletInformation()
	if self:IsAttached("darky_rust_gl_shotgun") then
		BaseClass.ShootBulletInformation(self)
	else
		if SERVER then
			if not self:IsValid() then return end

			local ent = ents.Create(self:GetStat("Primary.Projectile"))
			
			if ent:IsValid() then
				local aimcone = 0
				local dir
				local ang = self.Owner:EyeAngles()
				ang:RotateAroundAxis(ang:Right(), -aimcone / 2 + math.Rand(0, aimcone))
				ang:RotateAroundAxis(ang:Up(), -aimcone / 2 + math.Rand(0, aimcone))
				dir = ang:Forward()
				ent:SetPos(self.Owner:GetShootPos())
				ent.Owner = self.Owner
				ent:SetAngles(ang)

				ent:SetModel(self:GetStat("Primary.ProjectileModel"))
				ent:SetPhysicsAttacker(self:GetOwner())
				ent:SetOwner(self:GetOwner())
				ent.damage = self:GetStat("Primary.Damage")
				ent.radius = self:GetStat("Primary.Radius")
				ent.owner = self:GetOwner()
				ent:Spawn()
				
				local phys = ent:GetPhysicsObject()

				if IsValid(phys) then
					phys:SetVelocity(dir * self:GetStat("Primary.ProjectileVelocity"))
				end

				self:GetOwner():SetAnimation(PLAYER_ATTACK1)
			end
		end
	end
end
