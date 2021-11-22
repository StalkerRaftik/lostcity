-- Variables that are used on both client and server
SWEP.Gun = ("tfa_ww2_karabin1938") -- must be the name of your swep but NO CAPITALS!
SWEP.Category				= "LostCity Weapon Second SR" --Category where you will find your weapons
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellAttachment			= "shell" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.Manufacturer = "Panstwowa Fabryka Karabinow" --Gun Manufactrer (e.g. Hoeckler and Koch )
SWEP.Author				= "The Master MLG"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.PrintName				= "Karabin 1938 [Second SR]"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 2				-- Slot in the weapon selection menu
SWEP.SlotPos				= 3			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox		= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   	= false		-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= false		-- set false if you want no crosshair
SWEP.Weight					= 35		-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "ar2"		-- how others view you carrying the weapon
SWEP.Type = "Semiautomatic Rifle"
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg makes for good sniper rifles

SWEP.ViewModelFOV			= 62
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/v_karabin_1938.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_karabin1938.mdl"	-- Weapon world model
SWEP.Base				= "tfa_bash_base" --the Base this weapon will work on. PLEASE RENAME THE BASE! 
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false
SWEP.ShowWorldModel			= true
SWEP.UseHands = true

SWEP.Primary.Sound			= Sound("weapons/tfa_ww2_karabin1938/karabin1938_fire.wav")
SWEP.Primary.RPM			= 140 			-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 10	-- Size of a clip
SWEP.Primary.DefaultClip		= 0		-- Bullets you start with
SWEP.Primary.KickUp			= 1.18	-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.615		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.220		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= false	-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "ar2"			-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
SWEP.Primary.StaticRecoilFactor = 1.25 --Amount of recoil to directly apply to EyeAngles. Enter what fraction or percentage (in decimal form) you want. This is also affected by a convar that defaults to 0.5.
SWEP.IronRecoilMultiplier = 0.72
SWEP.MoveSpeed = 0.88 --Multiply the player's movespeed by this.
SWEP.DisableChambering = true
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed  * 0.86 --Multiply the player's movespeed by this when sighting.
-- Pistol, buckshot, and slam always ricochet. 
--Use AirboatGun for a light metal peircing shotgun pellets
SWEP.SelectiveFire		= false
SWEP.DisableBurstFire = false --Only auto/single?

SWEP.Secondary.BashDamage = 30
SWEP.Secondary.BashSound = Sound("weapons/tfa_ww2_karabin1938/brassknuckle_melee_03.wav")
SWEP.Secondary.BashHitSound = Sound("weapons/tfa_ww2_karabin1938/brassknuckle_melee_flesh_01.wav")
SWEP.Secondary.BashHitSound_Flesh = Sound("weapons/tfa_ww2_karabin1938/brassknuckle_melee_flesh_01.wav")

SWEP.Secondary.IronFOV			= 78		-- How much you 'zoom' in. Less is more! 	

SWEP.data 				= {}				--The starting firemode

SWEP.Primary.Damage		= 31	-- Base damage per bullet
SWEP.Primary.Spread		= .0175	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .0075 -- Ironsight accuracy, should be the same for shotguns

-- Enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(-2.84, 0, 1.279)
SWEP.IronSightsAng = Vector(0.704, 0, 0)
SWEP.RunSightsPos = Vector(4.762, -4.238, -0.717)
SWEP.RunSightsAng = Vector(-6.743, 46.284, 0)
SWEP.InspectPos = Vector(7.76, -2, 0.016)
SWEP.InspectAng = Vector(1, 37.277, 3.2)

SWEP.Offset = {
	Pos = {
		Up = -3.126,
		Right = 0.347,
		Forward = 14
	},
	Ang = {
		Up = 0,
		Right = -10.869,
		Forward = 180,
	},
	Scale = 1
} --Procedural world model animation, defaulted for CS:S purposes.


SWEP.WElements = {
	["ref"] = { type = "Model", model = SWEP.WorldModel, bone = "oof", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.9, 0.9, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = true, active = false }
}

SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_HYBRID -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA

SWEP.BlowbackEnabled = true --Enable Blowback?
SWEP.BlowbackVector = Vector(0,-1,0) --Vector to move bone <or root> relative to bone <or view> orientation.
SWEP.BlowbackCurrentRoot = 0 --Amount of blowback currently, for root
SWEP.BlowbackCurrent = 0 --Amount of blowback currently, for bones
SWEP.BlowbackBoneMods = {
	["bolt"] = { scale = Vector(1, 1, 1), pos = Vector(-4.61, 0, 0), angle = Angle(0, 0, 0) },
        ["ValveBiped.Bip01_L_Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(0.196, 0, 0), angle = Angle(0, 0, 0) }
}
SWEP.Blowback_Shell_Enabled = true
SWEP.Blowback_Shell_Effect = "RifleShellEject"-- ShotgunShellEject shotgun or ShellEject for a SMG    

SWEP.LuaShellEject = true

SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_ANI -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.SprintAnimation = {
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "base_sprint", --Number for act, String/Number for sequence
		["is_idle"] = true
	}
}

