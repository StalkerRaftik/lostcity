-- Variables that are used on both client and server
SWEP.Gun = ("tfa_ins_sandstorm_tariq") -- must be the name of your swep but NO CAPITALS!
SWEP.Category				= "LostCity Weapon First SR" --Category where you will find your weapons
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellAttachment			= "shell" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.Manufacturer = "Tariq" --Gun Manufactrer (e.g. Hoeckler and Koch )
SWEP.Author				= "The Master MLG"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.PrintName				= "Tariq [First SR]"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 1				-- Slot in the weapon selection menu
SWEP.SlotPos				= 3			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox		= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   	= false		-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= false		-- set false if you want no crosshair
SWEP.Weight					= 35		-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "pistol"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg makes for good sniper rifles

SWEP.ViewModelFOV			= 68
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/v_tariq.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_tariq.mdl"	-- Weapon world model
SWEP.Base				= "tfa_gun_base" --the Base this weapon will work on. PLEASE RENAME THE BASE! 
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false
SWEP.ShowWorldModel			= true
SWEP.UseHands = true

SWEP.Primary.Sound			= Sound("weapons/tfa_ins_sandstorm_tariq/tariq_fp.wav")
SWEP.Primary.SilencedSound			= Sound("weapons/tfa_ins_sandstorm_tariq/tariq_suppressed_fp.wav")		-- Script that calls the primary fire sound
SWEP.Primary.RPM			= 475		-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 10		-- Size of a clip
SWEP.Primary.DefaultClip		= 0		-- Bullets you start with
SWEP.Primary.KickUp			= 0.85		-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.55		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.21		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= false	-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "pistol"			-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. 
--Use AirboatGun for a light metal peircing shotgun pellets
SWEP.SelectiveFire		= false

SWEP.Secondary.IronFOV			= 70		-- How much you 'zoom' in. Less is more! 	

SWEP.data 				= {}				--The starting firemode

SWEP.Primary.Damage		= 19	-- Base damage per bullet
SWEP.Primary.Spread		= .020	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .014 -- Ironsight accuracy, should be the same for shotguns

-- Enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(-2.401, 0, 1.24)
SWEP.IronSightsAng = Vector(0.444, 0, 0)
SWEP.InspectPos = Vector(5.135, -5.059, -1.649)
SWEP.InspectAng = Vector(10.17, 29.819, 0)

SWEP.Offset = {
	Pos = {
		Up = -1.2,
		Right = 1.394,
		Forward = 4.295
	},
	Ang = {
		Up = 0,
		Right = 0,
		Forward = 180,
	},
	Scale = 0.9
} --Procedural world model animation, defaulted for CS:S purposes.

SWEP.VElements = {
                        ["suppressor"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/a_suppressor_pistol.mdl", bone = "A_Suppressor", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 90, 180), size = Vector(0.7, 0.7, 0.7), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false },
                        ["mag"] = { type = "Model", model = "models/weapons/upgrades/a_magazine_tariq_8.mdl", bone = "b_wpn_mag", rel = "", pos = Vector(-0.29, 0, 0), angle = Angle(0, 0, 180), size = Vector(0.76, 0.76, 0.76), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = true, active = true },
                        ["mag_ext"] = { type = "Model", model = "models/weapons/upgrades/a_magazine_tariq_15.mdl", bone = "b_wpn_mag", rel = "", pos = Vector(-0.29, 0, 0), angle = Angle(0, 0, 180), size = Vector(0.76, 0.76, 0.76), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = true, active = false },
                        ["laser_beam"] = { type = "Model", model = "models/tfa/lbeam.mdl", bone = "A_Underbarrel", rel = "laser", pos = Vector(0, 0, -0.392), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false },
	                ["laser"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/a_laser_mak.mdl", bone = "A_Underbarrel", rel = "", pos = Vector(-1, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false }

}

SWEP.WElements = {
	["ref"] = { type = "Model", model = SWEP.WorldModel, bone = "oof", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.9, 0.9, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = true, active = false },
        ["mag"] = { type = "Model", model = "models/weapons/upgrades/w_magazine_tariq_8.mdl", bone = "W_PIS_MAGAZINE", rel = "", pos = Vector(-0.29, 0, 0), angle = Angle(0, 0, 180), size = Vector(0.76, 0.76, 0.76), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = true, active = true },
        ["mag_ext"] = { type = "Model", model = "models/weapons/upgrades/owo/w_magazine_tariq_15.mdl", bone = "W_PIS_MAGAZINE", rel = "", pos = Vector(-0.29, 0, 0), angle = Angle(0, 0, 180), size = Vector(0.76, 0.76, 0.76), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = true, active = false },
        ["laser"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/a_laser_mak.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8.225, 1.383, -1.15), angle = Angle(0, 0, 0), size = Vector(0.55, 0.55, 0.55), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
        ["suppressor"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/w_sil_pistol.mdl", bone = "ATTACH_Muzzle", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 90, 180), size = Vector(0.7, 0.7, 0.7), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false, bonemerge = true },
}

SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_HYBRID -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA

SWEP.BlowbackEnabled = false
SWEP.BlowbackVector = Vector(0,-2,0.0)
SWEP.Blowback_Shell_Effect = "ShellEject"

SWEP.LuaShellEject = true

SWEP.ViewModelBoneMods = {
	["L Hand"] = { scale = Vector(0.7, 0.7, 0.7), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
        ["R Hand"] = { scale = Vector(0.7, 0.7, 0.7), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
        ["A_Underbarrel"] = { scale = Vector(0.8, 0.8, 0.8), pos = Vector(0, -1, -0.1), angle = Angle(0, 0, 0) },
}

SWEP.Attachments = {
                        [1] = { offset = { 0, 0 }, atts = { "ins2_br_supp" }, order = 1 },
                        [2] = { offset = { 0, 0 }, atts = { "ins2_mag_ext_pistol" }, order = 2 },
                        [3] = { offset = { 0, 0 }, atts = { "am_match", "am_gib" }, order = 3 },
                        [4] = { offset = { 0, 0 }, atts = { "ins2_ub_laser" }, order = 4 },
}

SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_ANI -- ANI = mdl, HYBRID = ani + lua, Lua = lua only

SWEP.SprintAnimation = {
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "base_sprint", --Number for act, String/Number for sequence
		["value_empty"] = "empty_sprint",
		["is_idle"] = true
	}
}

SWEP.LaserSightModAttachment = 5