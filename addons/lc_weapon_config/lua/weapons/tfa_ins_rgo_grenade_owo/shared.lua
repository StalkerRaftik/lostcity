// MISC
SWEP.Base					= "tfa_ins2_nade_base"
SWEP.Category				= "LostCity Edged Weapons"
SWEP.Author					= "The Master MLG"
SWEP.Manufacturer = "Project BAZALT" --Gun Manufactrer (e.g. Hoeckler and Koch )
SWEP.Contact				= ""
SWEP.PrintName				= "Осколочная граната"
SWEP.Purpose				= "Make the motherland great again, blast them."
SWEP.Type				    = "Soviet Fragmentation Hand Grenade"
SWEP.Slot					= 4
SWEP.SlotPos				= 99
SWEP.DrawAmmo				= true
SWEP.DrawCrosshair			= false
SWEP.Weight					= 2
SWEP.AutoSwitchTo				= true
SWEP.AutoSwitchFrom			= true
SWEP.HoldType 				= "grenade"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.Sprint_Mode 				= TFA.Enum.LOCOMOTION_ANI
SWEP.SelectiveFire = false

// VIEWMODEL
SWEP.ViewModelFOV				= 65
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/v_rgo.mdl"

// WORLDMODEL
SWEP.WorldModel				= "models/weapons/w_rgo.mdl"

// NADE STUFF
SWEP.Primary.RPM				= 30
SWEP.Primary.ClipSize			= 1
SWEP.Primary.DefaultClip		= 3
SWEP.Primary.Automatic			= false
SWEP.Primary.Ammo				= "grenade"
SWEP.Primary.Round 			= ("tfa_ins_rgo_grenade")
SWEP.Velocity = 1500
SWEP.Velocity_Underhand = 780
SWEP.Delay = 0.23
SWEP.DelayCooked = 0.24
SWEP.Delay_Underhand = 0.245
SWEP.CookStartDelay = 1
SWEP.UnderhandEnabled = true
SWEP.CookingEnabled = true
SWEP.CookTimer = 3

SWEP.Offset = {
	Pos = {
		Up = -1.1,
		Right = 1.4,
		Forward = 2.595
	},
	Ang = {
		Up = -1.043,
		Right = 0,
		Forward = 180,
	},
	Scale = 1
} --Procedural world model animation, defaulted for CS:S purposes.

SWEP.WElements = {
	["ref"] = { type = "Model", model = SWEP.WorldModel, bone = "oof", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.9, 0.9, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = true, active = false },
        ["laser"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/w_laser_sec.mdl", bone = "ATTACH_Laser", rel = "ref", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = true, active = false },
        ["suppressor"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/w_sil_pistol.mdl", bone = "ATTACH_Muzzle", rel = "ref", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false, bonemerge = true },
}

SWEP.SprintAnimation = {
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ,
		["value"] = "base_sprint",
		["is_idle"] = true
	}
}

SWEP.InspectPos 				= Vector(4, -3.619, -0.787)
SWEP.InspectAng 				= Vector(22.386, 34.417, 5)
