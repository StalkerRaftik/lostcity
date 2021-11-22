SWEP.Category				= "LostCity Weapon First SR"
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "M3 Grease Gun [First SR]"		-- Weapon name (Shown on HUD)
SWEP.Slot				= 2				-- Slot in the weapon selection menu
SWEP.SlotPos				= 73			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox		= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   	= false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= false		-- Set false if you want no crosshair from hip
SWEP.Weight				= 30			-- Rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.BoltAction				= false		-- Is this a bolt action rifle?
SWEP.HoldType 				= "smg"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles
SWEP.SelectiveFire		= true --Allow selecting your firemode?
SWEP.DisableBurstFire	= true --Only auto/single?
SWEP.OnlyBurstFire		= false --No auto, only burst/single?

SWEP.ViewModelFOV			= 65
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/tfa_doi/v_m3greasegun.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/tfa_doi/w_m3greasegun.mdl"	-- Weapon world model
SWEP.UseHands = true
SWEP.VMPos = Vector(0,0,0) --The viewmodel positional offset, constantly.  Subtract this from any other modifications to viewmodel position.
SWEP.VMAng = Vector(0,0,0) --The viewmodel angular offset, constantly.   Subtract this from any other modifications to viewmodel angle.
SWEP.VMPos_Additive = false --Set to false for an easier time using VMPos. If true, VMPos will act as a constant delta ON TOP OF ironsights, run, whateverelse

SWEP.Base 				= "tfa_gun_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.Primary.Sound			= Sound("Weapon_m3grease.1")		-- script that calls the primary fire sound
SWEP.Primary.RPM				= 200		-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 20		-- Size of a clip
SWEP.Primary.DefaultClip			= 0	-- Bullets you start with
SWEP.Primary.KickUp				= 0.42				-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.33			-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.24		-- Maximum up recoil (stock)
SWEP.Primary.StaticRecoilFactor = 1.79
SWEP.Primary.Automatic			= true		-- Automatic/Semi Auto
SWEP.DisableChambering = true
SWEP.Primary.Ammo			= "pistol"	-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun


SWEP.data 				= {}
SWEP.data.ironsights		= 1

SWEP.Primary.NumShots	= 1		--how many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 18	--base damage per bullet
SWEP.Primary.Spread		= .047	--define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .018 -- ironsight accuracy, should be the same for shotguns

SWEP.Secondary.IronFOV = 70

-- enter iron sight info and bone mod info below


SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -9,
        Right = 5.5,
        Forward = -7,
        },
        Ang = {
        Up = -2,
        Right = -5,
        Forward = 180
        },
		Scale = 1
}


SWEP.IronSightsPos = Vector(-2.51, -0.5, 1.289)
SWEP.IronSightsAng = Vector(0, 0, 5.627)

SWEP.RunSightsPos = Vector(3.5162, -2.1172, -1.2396)
SWEP.RunSightsAng = Vector(-8.5271, 62.8941, -16.827)

--SWEP.InspectPos = Vector(7.519, -15.502, 0.819)
--SWEP.InspectAng = Vector(36.583, 53.466, 34.472)

--SWEP.NearWallSightsPos = Vector(3.344, -5.34, -2.671)-- Vector(0, -12.085, -4.237)
--SWEP.NearWallSightsAng = Vector(-20.048, 68.24, -40.635)--Vector(70, 0, 0)

SWEP.BlowbackEnabled = false
SWEP.BlowbackVector = Vector(0,-2,0.0)
SWEP.Blowback_Shell_Effect = "ShellEject"

SWEP.LuaShellEject = true

SWEP.IronRecoilMultiplier=0.6 --Multiply recoil by this factor when we're in ironsights.  This is proportional, not inversely.
SWEP.CrouchRecoilMultiplier=0.5  --Multiply recoil by this factor when we're crouching.  This is proportional, not inversely.
SWEP.JumpRecoilMultiplier=1.3  --Multiply recoil by this factor when we're crouching.  This is proportional, not inversely.
SWEP.WallRecoilMultiplier=1.1  --Multiply recoil by this factor when we're changing state e.g. not completely ironsighted.  This is proportional, not inversely.
