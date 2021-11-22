SWEP.PrintName = "Sawnoff Enfield [Second SR]"
SWEP.Author = "Fleshy Mammal"
SWEP.Contact = ""
SWEP.Purpose = "lol fuck off"
SWEP.Instructions = ""

SWEP.Category = "LostCity Weapon Second SR"

--[[VIEWMODEL BLOWBACK]]--
SWEP.BlowbackEnabled = true --Enable Blowback?
SWEP.BlowbackVector = Vector(0,-3.5,0) --Vector to move bone <or root> relative to bone <or view> orientation.
SWEP.BlowbackCurrentRoot = 0 --Amount of blowback currently, for root
SWEP.BlowbackCurrent = 0 --Amount of blowback currently, for bones
SWEP.Blowback_Only_Iron = true --Only do blowback on ironsights
SWEP.Blowback_PistolMode = true --Do we recover from blowback when empty?
SWEP.Blowback_Shell_Enabled = false --Shoot shells through blowback animations
SWEP.Blowback_Shell_Effect = "RifleShellEject"--Which shell effect to use

SWEP.Spawnable= true
SWEP.AdminSpawnable= true
SWEP.AdminOnly = false
SWEP.CSMuzzleFlashes = true

SWEP.MuzzleAttachment = 1
SWEP.ShellAttachment = 2 

-- Shell eject override
SWEP.LuaShellEject = false --Enable shell ejection through lua?
SWEP.LuaShellEjectDelay = 0 --The delay to actually eject things
SWEP.LuaShellModel = nil --The model to use for ejected shells
SWEP.LuaShellScale = nil --The model scale to use for ejected shells
SWEP.LuaShellYaw = nil --The model yaw rotation ( relative ) to use for ejected shells

SWEP.HoldType = "ar2"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/fml/da_brit/c_lil_enfield.mdl"
SWEP.WorldModel = "models/weapons/w_smg1.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false
SWEP.ViewModelBoneMods = {
	["Weapon_Shell"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(45, 0, 0) },	
	["Weapon_Muzzle"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 90, 0) },	
	["A_Optic"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 180, 0) },	
}

SWEP.PumpAction = {
    ["type"] = TFA.Enum.ANIMATION_SEQ,
    ["value"] = "bolt",
	["value_is"] = "bolt"
}

SWEP.EventTable = {
[ACT_VM_PULLBACK_LOW] = {
{time = 4 / 10, type = "lua", value = function(self) self:EventShell() end, client = true, server = true},
},
[ACT_VM_RELOAD_EMPTY] = {
{time = 4 / 10, type = "lua", value = function(self) self:EventShell() end, client = true, server = true},
},
}

SWEP.WElements = {
	["E"] = { type = "Model", model = "models/weapons/fml/da_brit/c_lil_enfield.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-7.54, 4.934, -3.442), angle = Angle(-10, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.VElements = {
	["sights_folded"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/a_standard_m40.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "rail_sights", pos = Vector(0.758, 0, 0.678), angle = Angle(0, 180, 0), size = Vector(0.25, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false },
	["rail_sights"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/a_mount_galil.mdl", bone = "Weapon_Main", rel = "", pos = Vector(3.401, -2.043, 0), angle = Angle(0, -90, -90), size = Vector(1, 1, 0.75), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false },
	["suppressor"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/a_suppressor_sec.mdl", bone = "Weapon_Main", rel = "", pos = Vector(3.351, -9.771, 0), angle = Angle(0, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false },

	["scope_2xrds"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/a_optic_aimp2x.mdl", bone = "A_Optic", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false, bonemerge = true },
	["scope_c79"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/a_optic_elcan.mdl", bone = "A_Optic", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false, bonemerge = true },
	["scope_po4x"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/a_optic_po4x24.mdl", bone = "A_Optic", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false, bonemerge = true },
	["scope_mx4"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/a_optic_m40.mdl", bone = "A_Optic", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false, bonemerge = true },
	
	["sight_kobra"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/a_optic_kobra_l.mdl", bone = "A_Optic", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false, bonemerge = true },
	["sight_kobra_lens"] = (TFA.INS2 and TFA.INS2.GetHoloSightReticle) and TFA.INS2.GetHoloSightReticle("sight_kobra") or nil,
	["sight_eotech"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/a_optic_eotech.mdl", bone = "A_Optic", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false, bonemerge = true },
	["sight_eotech_lens"] = (TFA.INS2 and TFA.INS2.GetHoloSightReticle) and TFA.INS2.GetHoloSightReticle("sight_eotech") or nil,
	["sight_rds"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/a_optic_aimpoint.mdl", bone = "A_Optic", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false, bonemerge = true },
	["sight_rds_lens"] = (TFA.INS2 and TFA.INS2.GetHoloSightReticle) and TFA.INS2.GetHoloSightReticle("sight_rds") or nil,
}

SWEP.IronSightsPos = Vector(-3.6, -5, 0.759)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.IronSightsPos_Folded = Vector(-3.645, -5, -0.373)
SWEP.IronSightsAng_Folded = Vector(0.216, 0, 0)

SWEP.IronSightsPos_EOTech = Vector(-3.625, -7.5, -0.575)
SWEP.IronSightsAng_EOTech = Vector(-0.2, 0, 0)

SWEP.IronSightsPos_Kobra = Vector(-3.625, -7.5, -0.575)
SWEP.IronSightsAng_Kobra = Vector(-0.2, 0, 0)

SWEP.IronSightsPos_RDS = Vector(-3.625, -7.5, -0.575)
SWEP.IronSightsAng_RDS = Vector(-0.2, 0, 0)

SWEP.IronSightsPos_2XRDS = Vector(-3.623, -6.5, -0.548)
SWEP.IronSightsAng_2XRDS = Vector(0, 0, 0)
SWEP.Secondary.IronFOV_2XRDS = 50

SWEP.IronSightsPos_C79 = Vector(-3.625, -6.5, -0.986)
SWEP.IronSightsAng_C79 = Vector(0, 0, 0)
SWEP.Secondary.IronFOV_C79 = 50

SWEP.IronSightsPos_PO4X = Vector(-3.579, -6.5, -0.429)
SWEP.IronSightsAng_PO4X = Vector(0, 0, 0)
SWEP.Secondary.IronFOV_PO4X = 50

SWEP.IronSightsPos_MX4 = Vector(-3.641, -4, -0.093)
SWEP.IronSightsAng_MX4 = Vector(0, 0, 0)
SWEP.Secondary.IronFOV_MX4 = 40

SWEP.Attachments = {
	[1] = { offset = { 0, 0 }, atts = { "ins2_br_supp", "r6s_h_barrel", "r6s_muzzle_2", "r6s_flashhider_2" }, order = 1 },
	[7] = { offset = { 0, 0 }, atts = { "ins2_si_folded", "ins2_si_kobra", "ins2_si_eotech", "ins2_si_rds", "ins2_si_2xrds", "ins2_si_c79", "ins2_si_po4x" , "ins2_si_mx4" }, order = 2 },
	[2] = { offset = { 0, 0 }, atts = { "am_ap", "am_hp" }, order = 5 },				
}

SWEP.RTOpaque	= true

SWEP.DisableChambering = true

SWEP.SequenceRateOverride = {
	[ACT_VM_RELOAD_EMPTY] = 1,
	[ACT_VM_RELOAD] = 1,	
	[ACT_VM_PRIMARYATTACK] = 1.25,		
}

SWEP.LaserSightModAttachment = 1

SWEP.Type = "Sniper Rifle"

SWEP.FireModeName = "Bolt Action"

SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = true

SWEP.Slot = 4
SWEP.SlotPos = 1
 
SWEP.UseHands = true

SWEP.FiresUnderwater = true

SWEP.DrawCrosshair = false

SWEP.DrawAmmo = true

SWEP.ReloadSound = ""

SWEP.Base = "tfa_gun_base"

SWEP.Primary.IronAccuracy_SG = .075

--Recoil Related
SWEP.Primary.KickUp = 1.77 -- This is the maximum upwards recoil (rise)
SWEP.Primary.KickDown			= 0.92
SWEP.Primary.KickHorizontal = 0.55
SWEP.Primary.StaticRecoilFactor = 1.66 --Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.  This is also affected by a convar that defaults to 0.5.
--Firing Cone Related
SWEP.Primary.Spread = .08 --This is hip-fire acuracy.  Less is more (1 is horribly awful, .0001 is close to perfect)
SWEP.Primary.IronAccuracy = .0015 -- Ironsight accuracy, should be the same for shotguns
--Unless you can do this manually, autodetect it.  If you decide to manually do these, uncomment this block and remove this line.
SWEP.Primary.SpreadMultiplierMax = 2 --How far the spread can expand when you shoot. Example val: 2.5
SWEP.Primary.SpreadIncrement = 2.5 --What percentage of the modifier is added on, per shot.  Example val: 1/3.5
SWEP.Primary.SpreadRecovery = 10 --How much the spread recovers, per second. Example val: 3
--Range Related
SWEP.Primary.Range = (980 * 16) -- The distance the bullet can travel in source units.  Set to -1 to autodetect based on damage/rpm.
SWEP.Primary.RangeFalloff = 0.8 -- The percentage of the range the bullet damage starts to fall off at.  Set to 0.8, for example, to start falling off after 80% of the range.
--Misc
SWEP.CrouchAccuracyMultiplier = 0.3 --Less is more.  Accuracy * 0.5 = Twice as accurate, Accuracy * 0.1 = Ten times as accurate
--Movespeed
SWEP.MoveSpeed = 0.85 --Multiply the player's movespeed by this.
SWEP.IronSightsMoveSpeed = 0.75 --Multiply the player's movespeed by this when sighting.

SWEP.IronSightTime = 0.35

SWEP.VMPos = Vector(-1, 0, -0.5)
SWEP.VMAng = Vector(0,0, -10)
SWEP.VMPos_Additive = false --Set to false for an easier time using VMPos. If true, VMPos will act as a constant delta ON TOP OF ironsights, run, whateverelse

SWEP.Primary.Damage_SG = 12

SWEP.Primary.Ammo_Rifle = "ar2"
SWEP.Primary.Ammo_SG = "buckshot"
SWEP.Primary.Ammo_50cal = "SniperPenetratedRound"

SWEP.Primary.Sound = Sound("fml_lil_e.pew")
SWEP.Primary.SilencedSound = Sound("TFA_INS2_AKM.2") -- This is the sound of the weapon, when silenced.
SWEP.Primary.Damage = 34
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.ClipSize = 5
SWEP.Primary.Ammo = "SniperPenetratedRound"
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = true
SWEP.Primary.Recoil = 1
SWEP.Primary.RPM = 180
SWEP.Primary.Force = 1

SWEP.Primary.PenetrationMultiplier = 10 --Change the amount of something this gun can penetrate through

SWEP.Secondary.ClipSize = 0
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.Secondary.IronFOV = 80

--[[INSPECTION]]--
SWEP.InspectPos = Vector(8.079, -3.517, -0.721)
SWEP.InspectAng = Vector(13.678, 36.644, 15.503)

--[[SPRINTING]]--
SWEP.RunSightsPos =  Vector(0.2, -6.311, -2.76)
SWEP.RunSightsAng = Vector(-18.504, 39.773, -39.616)