SWEP.Base = "tfa_gun_base"
SWEP.Category = "LostCity Weapon Homemade"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.Slot = 0

SWEP.Type = "Compound Bow"
SWEP.PrintName = "Hunting Bow [Homemade]"

SWEP.ViewModel			= "models/weapons/v_tfa_sf2_bow.mdl" --Viewmodel path
SWEP.ViewModelFOV = 70
SWEP.ViewModelFOVDefault = 70

SWEP.WorldModel			= "models/weapons/w_tfa_sf2_bow.mdl" --Viewmodel path
SWEP.HoldType = "smg"
SWEP.ThirdPersonReloadDisable = true

SWEP.ProjectileEntity = "tfbow_arrow" --Entity to shoot
SWEP.ProjectileVelocity = 2600 --Entity to shoot's velocity
SWEP.ProjectileModel = "models/weapons/w_tfa_sf2_arrow.mdl" --Entity to shoot's model

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -4,
        Right = 1,
        Forward = 15,
        },
        Ang = {
        Up = 0.5,
        Right = -5,
        Forward = 178
        },
		Scale = 1.1
}

SWEP.Scoped = false

SWEP.Shotgun = false
SWEP.ShellTime = 0.75

SWEP.DisableChambering = true
SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 0

SWEP.Primary.Sound = "SF2Bow.Single"
SWEP.Primary.Ammo = "tfbow_arrow"
SWEP.Primary.Automatic = false
SWEP.Primary.RPM = 150
SWEP.Primary.Damage = 43
SWEP.Primary.NumShots = 1
SWEP.Primary.Spread		= .02					--This is hip-fire acuracy.  Less is more (1 is horribly awful, .0001 is close to perfect)
SWEP.Primary.IronAccuracy = .005	-- Ironsight accuracy, should be the same for shotguns
SWEP.SelectiveFire = false

SWEP.Primary.KickUp			= 0.6					-- This is the maximum upwards recoil (rise)
SWEP.Primary.KickDown			= 0.5					-- This is the maximum downwards recoil (skeet)
SWEP.Primary.KickHorizontal			= 0.25					-- This is the maximum sideways recoil (no real term)
SWEP.Primary.StaticRecoilFactor = 0.4 	--Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.  This is also affected by a convar that defaults to 0.5.

SWEP.Primary.SpreadMultiplierMax = 4.5 --How far the spread can expand when you shoot.
SWEP.Primary.SpreadIncrement = 0.7 --What percentage of the modifier is added on, per shot.
SWEP.Primary.SpreadRecovery = 4.5 --How much the spread recovers, per second.

SWEP.Secondary.IronFOV = 70 --Ironsights FOV (90 = same)
SWEP.BoltAction = false --Un-sight after shooting?
SWEP.BoltTimerOffset = 0.25 --How long do we remain in ironsights after shooting?

SWEP.IronSightsPos = Vector(-7.38, 0, -2.78)
SWEP.IronSightsAng = Vector(12.663, 2.111, -33.77)

SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(-7.993, 7.5, 9.093)


SWEP.InspectionPos = Vector(12.8, -10.653, -4.19)
SWEP.InspectionAng = Vector(36.389, 48.549, 22.513)

SWEP.Primary.Range = 16*164.042*12 -- The distance the bullet can travel in source units.  Set to -1 to autodetect based on damage/rpm.
SWEP.Primary.RangeFalloff = 0.8 -- The percentage of the range the bullet damage starts to fall off at.  Set to 0.8, for example, to start falling off after 80% of the range.

SWEP.DoMuzzleFlash = false
SWEP.MuzzleFlashEffect = ""
SWEP.Tracer = ""

SWEP.UseHands = true
SWEP.ProceduralHoslterEnabled = true