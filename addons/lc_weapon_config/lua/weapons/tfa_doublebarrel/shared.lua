-- Variables that are used on both client and server
SWEP.Gun = ("tfa_doublebarrel") -- must be the name of your swep but NO CAPITALS!
SWEP.Category				= "LostCity Weapon Second SR"
SWEP.Manufacturer = "Vietnamese Army" --Gun Manufactrer (e.g. Hoeckler and Koch )
SWEP.Author				= "The Master MLG"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "1" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "Winchester Model 21 [Second SR]"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 3				-- Slot in the weapon selection menu
SWEP.SlotPos				= 11			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox		= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   	= false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= false		-- Set false if you want no crosshair from hip
SWEP.Weight				= 30			-- Rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "shotgun"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.ViewModelFOV			= 54
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/v_nam_doublebarrel.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_doublebarrel_new.mdl"	-- Weapon world model
SWEP.Base 				= "tfa_bash_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.Secondary.CanBash = true
SWEP.UseHands = true
SWEP.DisableChambering = true
SWEP.Primary.DamageType = DMG_BUCKSHOT --See DMG enum.  This might be DMG_SHOCK, DMG_BURN, DMG_BULLET, etc.  Leave nil to autodetect.  DMG_AIRBOAT opens doors.
SWEP.Primary.PenetrationMultiplier = 1

SWEP.Primary.Sound			= Sound("weapons/tfa_doublebarrel/double_barrel_fp.wav")		-- script that calls the primary fire sound
SWEP.Primary.RPM				= 85		-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 2		-- Size of a clip
SWEP.Primary.DefaultClip			= 0	-- Bullets you start with
SWEP.Primary.KickUp				= 1.45			-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.87		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.003		-- Maximum up recoil (stock)
SWEP.Primary.StaticRecoilFactor = 3 --Amount of recoil to directly apply to EyeAngl
SWEP.Primary.Automatic			= false		-- Automatic/Semi Auto
SWEP.Primary.Ammo			= "buckshot"	-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.data 				= {}
SWEP.data.ironsights		= 1
SWEP.Secondary.IronFOV			= 83

SWEP.Primary.NumShots	= 5		--how many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 9	--base damage per bullet
SWEP.Primary.Spread		= .095	--define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .065 -- ironsight accuracy, should be the same for shotguns
SWEP.AutoDetectMuzzleAttachment = false --For multi-barrel weapons, detect the proper attachment?

SWEP.InspectPos = Vector(6.244, -3.553, -0.051)
SWEP.InspectAng = Vector(0.569, 42.803, 0.925)

SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_ANI -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Primary.AmmoConsumption = 1

SWEP.SprintAnimation = {
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "base_sprint", --Number for act, String/Number for sequence
		["is_idle"] = true
	}
}

SWEP.Offset = {
	Pos = {
		Up = -1.455,
		Right = 1.456,
		Forward = 4.5
	},
	Ang = {
		Up = -175.099,
		Right = 190,
		Forward = -0
	},
	Scale = 0.944
} --Procedural world model animation, defaulted for CS:S purposes.


-- enter iron sight info and bone mod info below

SWEP.SightsPos = Vector(-1.719, -4.785, 1.536)
SWEP.SightsAng = Vector(0.012, 0, 0)

