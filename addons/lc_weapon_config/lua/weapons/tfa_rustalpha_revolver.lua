SWEP.Base				= "tfa_rustalpha_gunbase"
SWEP.Category			= "LostCity Weapon Homemade" --The category.  Please, just choose something generic or something I've already done if you plan on only doing like one swep..
SWEP.Manufacturer		= "" --Gun Manufactrer (e.g. Hoeckler and Koch )
SWEP.Author				= "YuRaNnNzZZ" --Author Tooltip
SWEP.Contact			= "" --Contact Info Tooltip
SWEP.Purpose			= "" --Purpose Tooltip
SWEP.Instructions		= "" --Instructions Tooltip
SWEP.Spawnable			= (TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.5) and (TFA and TFA.RUSTALPHA ~= nil) --Can you, as a normal user, spawn this?
SWEP.AdminSpawnable		= true --Can an adminstrator spawn this?  Does not tie into your admin mod necessarily, unless its coded to allow for GMod's default ranks somewhere in its code.  Evolve and ULX should work, but try to use weapon restriction rather than these.
SWEP.DrawCrosshair		= false		-- Draw the crosshair?
SWEP.DrawCrosshairIS	= false --Draw the crosshair in ironsights?
SWEP.PrintName			= "Cамодельный револьвер [Homemade]"		-- Weapon name (Shown on HUD)
SWEP.Slot				= 1				-- Slot in the weapon selection menu.  Subtract 1, as this starts at 0.
SWEP.SlotPos			= 74			-- Position in the slot
SWEP.AutoSwitchTo		= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom		= true		-- Auto switch from if you pick up a better weapon
SWEP.Weight				= 30			-- This controls how "good" the weapon is for autopickup.

SWEP.Type = "Revolver"
SWEP.Type_Displayed = "Handmade Weapon"

--[[WEAPON HANDLING]]--
SWEP.Primary.Sound = Sound("YURIE_RUSTALPHA.REVOLVER.1") -- This is the sound of the weapon, when you shoot.
SWEP.Primary.SilencedSound = Sound("YURIE_RUSTALPHA.REVOLVER.2") -- This is the sound of the weapon, when silenced.
SWEP.Primary.PenetrationMultiplier = 1 --Change the amount of something this gun can penetrate through
SWEP.Primary.Damage = 11 -- Damage, in standard damage points.
SWEP.Primary.DamageTypeHandled = true --true will handle damagetype in base
SWEP.Primary.DamageType = nil --See DMG enum.  This might be DMG_SHOCK, DMG_BURN, DMG_BULLET, etc.  Leave nil to autodetect.  DMG_AIRBOAT opens doors.
SWEP.Primary.Force = nil --Force value, leave nil to autocalc
SWEP.Primary.Knockback = 0 --Autodetected if nil; this is the velocity kickback
SWEP.Primary.HullSize = 0 --Big bullets, increase this value.  They increase the hull size of the hitscan bullet.
SWEP.Primary.NumShots = 1 --The number of shots the weapon fires.  SWEP.Shotgun is NOT required for this to be >1.
SWEP.Primary.Automatic = false -- Automatic/Semi Auto
SWEP.Primary.RPM = 12 / 0.2 -- This is in Rounds Per Minute / RPM
SWEP.Primary.DryFireDelay = nil --How long you have to wait after firing your last shot before a dryfire animation can play.  Leave nil for full empty attack length.  Can also use SWEP.StatusLength[ ACT_VM_BLABLA ]
SWEP.Primary.BurstDelay = nil -- Delay between bursts, leave nil to autocalculate
SWEP.FiresUnderwater = false
--Miscelaneous Sounds
SWEP.IronInSound = nil --Sound to play when ironsighting in?  nil for default
SWEP.IronOutSound = nil --Sound to play when ironsighting out?  nil for default
--Silencing
SWEP.CanBeSilenced = false --Can we silence?  Requires animations.
SWEP.Silenced = false --Silenced by default?
-- Selective Fire Stuff
SWEP.SelectiveFire = false --Allow selecting your firemode?
SWEP.DisableBurstFire = true --Only auto/single?
SWEP.OnlyBurstFire = false --No auto, only burst/single?
--Ammo Related
SWEP.Primary.ClipSize = 3 -- This is the size of a clip
SWEP.Primary.DefaultClip = 0 -- This is the number of bullets the gun gives you, counting a clip as defined directly above.
SWEP.Primary.Ammo = "357" -- What kind of ammo.  Options, besides custom, include pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, and AirboatGun.
SWEP.Primary.AmmoConsumption = 1 --Ammo consumed per shot
--Pistol, buckshot, and slam like to ricochet. Use AirboatGun for a light metal peircing shotgun pellets
SWEP.DisableChambering = true --Disable round-in-the-chamber
--Recoil Related
SWEP.Primary.KickUp = 0.94 -- This is the maximum upwards recoil (rise)
SWEP.Primary.KickDown = .52 -- This is the maximum downwards recoil (skeet)
SWEP.Primary.KickHorizontal = 0.34 -- This is the maximum sideways recoil (no real term)
SWEP.Primary.StaticRecoilFactor = 1.14 --Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.  This is also affected by a convar that defaults to 0.5.
--Firing Cone Related
SWEP.Primary.Spread = .034 --This is hip-fire acuracy.  Less is more (1 is horribly awful, .0001 is close to perfect)
SWEP.Primary.IronAccuracy = .057 -- Ironsight accuracy, should be the same for shotguns
--Unless you can do this manually, autodetect it.  If you decide to manually do these, uncomment this block and remove this line.
SWEP.Primary.SpreadMultiplierMax = 30 --How far the spread can expand when you shoot. Example val: 2.5
SWEP.Primary.SpreadIncrement = 0.5 --What percentage of the modifier is added on, per shot.  Example val: 1/3.5
SWEP.Primary.SpreadRecovery = 4 --How much the spread recovers, per second. Example val: 3
--Range Related
SWEP.Primary.Range = 0.08 * (3280.84 * 16) -- The distance the bullet can travel in source units.  Set to -1 to autodetect based on damage/rpm.
SWEP.Primary.RangeFalloff = 1 -- The percentage of the range the bullet damage starts to fall off at.  Set to 0.8, for example, to start falling off after 80% of the range.
--Penetration Related
SWEP.MaxPenetrationCounter = 4 --The maximum number of ricochets.  To prevent stack overflows.
--Misc
SWEP.IronRecoilMultiplier = 0.65 --Multiply recoil by this factor when we're in ironsights.  This is proportional, not inversely.
SWEP.CrouchAccuracyMultiplier = 0.8 --Less is more.  Accuracy * 0.5 = Twice as accurate, Accuracy * 0.1 = Ten times as accurate
--Movespeed
SWEP.MoveSpeed = 0.95 --Multiply the player's movespeed by this.
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.9 --Multiply the player's movespeed by this when sighting.
--[[VIEWMODEL]]--
SWEP.ViewModel			= "models/weapons/yurie_rustalpha/c-vm-revolver.mdl" --Viewmodel path
SWEP.ViewModelFOV			= 54		-- This controls how big the viewmodel looks.  Less is more.
SWEP.ViewModelFlip			= false		-- Set this to true for CSS models, or false for everything else (with a righthanded viewmodel.)
SWEP.UseHands = true --Use gmod c_arms system.
SWEP.ViewModelScale	= 1.3
SWEP.VMPos = Vector(0,0,0) --The viewmodel positional offset, constantly.  Subtract this from any other modifications to viewmodel position.
SWEP.VMAng = Vector(0,0,0) --The viewmodel angular offset, constantly.   Subtract this from any other modifications to viewmodel angle.
SWEP.VMPos_Additive = false --Set to false for an easier time using VMPos. If true, VMPos will act as a constant delta ON TOP OF ironsights, run, whateverelse
SWEP.CenteredPos = nil --The viewmodel positional offset, used for centering.  Leave nil to autodetect using ironsights.
SWEP.CenteredAng = nil --The viewmodel angular offset, used for centering.  Leave nil to autodetect using ironsights.
SWEP.Bodygroups_V = nil
--[[WORLDMODEL]]--
SWEP.WorldModel			= "models/weapons/yurie_rustalpha/wm-revolver.mdl" -- Weapon world model path
SWEP.Bodygroups_W = nil
SWEP.HoldType = "revolver" -- This is how others view you carrying the weapon. Options include:
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive
-- You're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles
SWEP.Offset = {
	Pos = {
		Up = -2.5,
		Right = 1,
		Forward = 7
	},
	Ang = {
		Up = 1,
		Right = -4,
		Forward = 178
	},
	Scale = 1
} --Procedural world model animation, defaulted for CS:S purposes.
SWEP.ThirdPersonReloadDisable = false --Disable third person reload?  True disables.
--[[SCOPES]]--
SWEP.IronSightsSensitivity = 1 --Useful for a RT scope.  Change this to 0.25 for 25% sensitivity.  This is if normal FOV compenstaion isn't your thing for whatever reason, so don't change it for normal scopes.
SWEP.BoltAction = false --Unscope/sight after you shoot?
SWEP.Scoped = false --Draw a scope overlay?
SWEP.ScopeOverlayThreshold = 0.875 --Percentage you have to be sighted in to see the scope.
SWEP.BoltTimerOffset = 0.25 --How long you stay sighted in after shooting, with a bolt action.
SWEP.ScopeScale = 0.5 --Scale of the scope overlay
SWEP.ReticleScale = 0.7 --Scale of the reticle overlay
--GDCW Overlay Options.  Only choose one.
SWEP.Secondary.UseACOG = false --Overlay option
SWEP.Secondary.UseMilDot = false --Overlay option
SWEP.Secondary.UseSVD = false --Overlay option
SWEP.Secondary.UseParabolic = false --Overlay option
SWEP.Secondary.UseElcan = false --Overlay option
SWEP.Secondary.UseGreenDuplex = false --Overlay option
SWEP.Secondary.ScopeTable = nil
--[[SHOTGUN CODE]]--
SWEP.Shotgun = false --Enable shotgun style reloading.
SWEP.ShotgunEmptyAnim = false --Enable emtpy reloads on shotguns?
SWEP.ShotgunEmptyAnim_Shell = true --Enable insertion of a shell directly into the chamber on empty reload?
SWEP.ShellTime = .35 -- For shotguns, how long it takes to insert a shell.
--[[SPRINTING]]--
-- SWEP.RunSightsPos = Vector(8.25, -4.25, -3.5) * SWEP.ViewModelScale
-- SWEP.RunSightsAng = Vector(0, 35, -10)
SWEP.RunSightsPos = Vector(8.75, -5.5, -5.75) * SWEP.ViewModelScale
SWEP.RunSightsAng = Vector(0, 40, -18.75)
--[[IRONSIGHTS]]--
SWEP.data = {}
SWEP.data.ironsights = 1 --Enable Ironsights
SWEP.Secondary.IronFOV = 75 -- How much you 'zoom' in. Less is more!  Don't have this be <= 0.  A good value for ironsights is like 70.
SWEP.IronSightsPos = Vector(-2.89, 0, 0.575) * SWEP.ViewModelScale
SWEP.IronSightsAng = Vector(0.062, -2.65, 1.85)

SWEP.Secondary.IronFOV_Holosight = 75
SWEP.IronSightsPos_Holosight = Vector(-2.89, 0, -0.575) * SWEP.ViewModelScale
SWEP.IronSightsAng_Holosight = Vector(-0.718, -2.913, 1.85)
--[[INSPECTION]]--
SWEP.InspectPos = Vector(10, -8, -2) * SWEP.ViewModelScale
SWEP.InspectAng = Vector(24, 42, 16)
--[[VIEWMODEL ANIMATION HANDLING]]--
SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.

SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation
SWEP.SprintBobMult = 0.75

--[[EFFECTS]]--
--Attachments
SWEP.MuzzleAttachment			= "muzzle" 		-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellAttachment			= "plsNO" 		-- Should be "2" for CSS models or "shell" for hl2 models
SWEP.MuzzleFlashEnabled = true --Enable muzzle flash
SWEP.MuzzleAttachmentRaw = nil --This will override whatever string you gave.  This is the raw attachment number.  This is overridden or created when a gun makes a muzzle event.
SWEP.AutoDetectMuzzleAttachment = false --For multi-barrel weapons, detect the proper attachment?
SWEP.MuzzleFlashEffect = "tfa_muzzleflash_revolver" --Change to a string of your muzzle flash effect.  Copy/paste one of the existing from the base.
SWEP.SmokeParticle = nil --Smoke particle (ID within the PCF), defaults to something else based on holdtype; "" to disable
SWEP.EjectionSmokeEnabled = true --Disable automatic ejection smoke
--Shell eject override
SWEP.LuaShellEject = false --Enable shell ejection through lua?
SWEP.LuaShellEjectDelay = 0 --The delay to actually eject things
SWEP.LuaShellEffect = nil --The effect used for shell ejection; Defaults to that used for blowback
--Tracer Stuff
SWEP.TracerName 		= nil 	--Change to a string of your tracer name.  Can be custom. There is a nice example at https://github.com/garrynewman/garrysmod/blob/master/garrysmod/gamemodes/base/entities/effects/tooltracer.lua
SWEP.TracerCount 		= 3 	--0 disables, otherwise, 1 in X chance
--Impact Effects
SWEP.ImpactEffect = nil--Impact Effect
SWEP.ImpactDecal = nil--Impact Decal

--[[VIEWMODEL BLOWBACK]]--
SWEP.BlowbackEnabled = true --Enable Blowback?
SWEP.BlowbackVector = Vector(0.1, -1, -2) * SWEP.ViewModelScale --Vector to move bone <or root> relative to bone <or view> orientation.
SWEP.BlowbackAngle = Angle(8, 0, 0)
SWEP.BlowbackCurrentRoot = 0 --Amount of blowback currently, for root
SWEP.BlowbackCurrent = 0 --Amount of blowback currently, for bones
SWEP.BlowbackBoneMods = {
	["v_revolver_hammer"] = { scale = Vector(1, 1, 1), pos = Vector(1, 0, 0) * SWEP.ViewModelScale, angle = Angle(0, 0, 0) },
	["v_revolver_cylinder"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 47.25) }
} --Viewmodel bone mods via SWEP Creation Kit
SWEP.Blowback_Only_Iron = true --Only do blowback on ironsights
SWEP.Blowback_PistolMode = false --Do we recover from blowback when empty?
SWEP.Blowback_Shell_Enabled = true --Shoot shells through blowback animations
SWEP.Blowback_Shell_Effect = "ShellEject"--Which shell effect to use

--[[EVENT TABLE]]--
SWEP.EventTable = {
	[ACT_VM_DRAW] = {
		{time = 0, type = "sound", value = Sound("YURIE_RUSTALPHA.REVOLVER.Draw")}
	},
	[ACT_VM_RELOAD] = {
		{time = 0, type = "sound", value = Sound("YURIE_RUSTALPHA.REVOLVER.Reload")}
	},
}
--[[RENDER TARGET]]--
SWEP.RTMaterialOverride = nil
SWEP.RTOpaque = false
SWEP.RTCode = nil
--[[AKIMBO]]--
SWEP.Akimbo = false
SWEP.AnimCycle = 0
--[[ATTACHMENTS]]--
SWEP.VElements = nil
SWEP.WElements = nil
SWEP.Attachments = {
	[1] = {atts = {"rustalpha_silencer"}},
	[2] = {atts = {"rustalpha_holo_sight"}},
	-- [3] = {atts = {"rustalpha_flashlight"}},
	-- [4] = {atts = {"rustalpha_laser_sight"}},
}

SWEP.AttachmentDependencies = {}
SWEP.AttachmentExclusions = {}

SWEP.VElements = {
	["holo_sight"] = { type = "Model", model = "models/weapons/yurie_rustalpha/vm-mod-holosight.mdl", bone = "v_revolver_hinge", rel = "", pos = Vector(2.5, -1.75, 0) * SWEP.ViewModelScale, angle = Angle(0, 90, 90), size = Vector(1, 1, 1) * SWEP.ViewModelScale, color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false },
	["silencer"] = { type = "Model", model = "models/weapons/yurie_rustalpha/vm-mod-silencer.mdl", bone = "v_revolver_hinge", rel = "", pos = Vector(1.92, 3.925, 0) * SWEP.ViewModelScale, angle = Angle(0, -90, -90), size = Vector(1, 1, 1) * SWEP.ViewModelScale, color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false },
}

SWEP.WElements = {
	["holo_sight"] = { type = "Model", model = "models/weapons/yurie_rustalpha/vm-mod-holosight.mdl", bone = "v_revolver_hinge", rel = "", pos = Vector(2.5, -1.75, 0), angle = Angle(0, 90, 90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {[1] = 1}, active = false },
	["silencer"] = { type = "Model", model = "models/weapons/yurie_rustalpha/vm-mod-silencer.mdl", bone = "v_revolver_hinge", rel = "", pos = Vector(1.92, 3.925, 0), angle = Angle(0, -90, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false },
}

SWEP.StatusLengthOverride = {
	[ACT_VM_DRAW] = 1,
	[ACT_VM_RELOAD] = 2,
}