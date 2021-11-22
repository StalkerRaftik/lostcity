SWEP.Base = "tfa_bow_base"
SWEP.Category = "LostCity Weapon Homemade" --The category.  Please, just choose something generic or something I've already done if you plan on only doing like one swep.
SWEP.Author = "TFA" --Author Tooltip
SWEP.Contact = "" --Contact Info Tooltip
SWEP.Purpose = "" --Purpose Tooltip
SWEP.Instructions = "" --Instructions Tooltip
SWEP.Spawnable = (TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.5) and (TFA and TFA.RUSTALPHA ~= nil) --Can you, as a normal user, spawn this?
SWEP.AdminSpawnable = true --Can an adminstrator spawn this?  Does not tie into your admin mod necessarily, unless its coded to allow for GMod's default ranks somewhere in its code.  Evolve and ULX should work, but try to use weapon restriction rather than these.
SWEP.DrawCrosshair = false -- Draw the crosshair?
SWEP.PrintName = "Деревянный лук [Homemade]" -- Weapon name (Shown on HUD) 
SWEP.Slot = 2 -- Slot in the weapon selection menu.  Subtract 1, as this starts at 0.
SWEP.SlotPos = 73 -- Position in the slot
SWEP.DrawAmmo = true -- Should draw the default HL2 ammo counter if enabled in the GUI.
SWEP.DrawWeaponInfoBox = false -- Should draw the weapon info box
SWEP.BounceWeaponIcon = false -- Should the weapon icon bounce?
SWEP.AutoSwitchTo = true -- Auto switch to if we pick it up
SWEP.AutoSwitchFrom = true -- Auto switch from if you pick up a better weapon
SWEP.Weight = 30 -- This controls how "good" the weapon is for autopickup.
SWEP.Type = "Bow"
--[[WEAPON HANDLING]]
--
--Firing related
SWEP.Primary.Sound = Sound("YURIE_RUSTALPHA.BOW.1") -- This is the sound of the weapon, when you shoot.
SWEP.Primary.PenetrationMultiplier = 1 --Change the amount of something this gun can penetrate through
SWEP.Primary.Damage = 19 -- Damage, in standard damage points.
SWEP.DamageType = nil --See DMG enum.  This might be DMG_SHOCK, DMG_BURN, DMG_BULLET, etc.
SWEP.Primary.NumShots = 1 --The number of shots the weapon fires.  SWEP.Shotgun is NOT required for this to be >1.
SWEP.Primary.Automatic = false -- Automatic/Semi Auto
SWEP.Primary.RPM = 40 -- This is in Rounds Per Minute / RPM
SWEP.FiresUnderwater = false
SWEP.CanBeSilenced = true --Can we silence?  Requires animations.
SWEP.Silenced = true --Silenced by default?
-- Selective Fire Stuff
SWEP.SelectiveFire = false --Allow selecting your firemode?
SWEP.DisableBurstFire = false --Only auto/single?
SWEP.OnlyBurstFire = false --No auto, only burst/single?
SWEP.DefaultFireMode = "" --Default to auto or whatev
SWEP.FireModeName = "Bow"
--Ammo Related
SWEP.Primary.ClipSize = -1 -- This is the size of a clip
SWEP.Primary.DefaultClip = 0 -- This is the number of bullets the gun gives you, counting a clip as defined directly above.
SWEP.Primary.Ammo = "tfbow_arrow" -- What kind of ammo.  Options, besides custom, include pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, and AirboatGun.  
--Pistol, buckshot, and slam like to ricochet. Use AirboatGun for a light metal peircing shotgun pellets
SWEP.DisableChambering = false --Disable round-in-the-chamber
--Recoil Related
SWEP.Primary.KickUp = 0.55 -- This is the maximum upwards recoil (rise)
SWEP.Primary.KickDown = 0.34 -- This is the maximum downwards recoil (skeet)
SWEP.Primary.KickHorizontal = 0.26 -- This is the maximum sideways recoil (no real term)
SWEP.Primary.StaticRecoilFactor = 0.9 --Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.  This is also affected by a convar that defaults to 0.5.
--Firing Cone Related
SWEP.Primary.SpreadBase = .05
SWEP.Primary.Spread = .05 --This is hip-fire acuracy.  Less is more (1 is horribly awful, .0001 is close to perfect)
SWEP.Primary.IronAccuracy = .005 -- Ironsight accuracy, should be the same for shotguns
SWEP.Primary.Velocity = 80
--Unless you can do this manually, autodetect it.  If you decide to manually do these, uncomment this block and remove this line.
--SWEP.Primary.SpreadMultiplierMax = 10 --How far the spread can expand when you shoot.
--SWEP.Primary.SpreadIncrement = 1.75 --What percentage of the modifier is added on, per shot.
--SWEP.Primary.SpreadRecovery = 10 --How much the spread recovers, per second.
--[[VIEWMODEL]]
--
SWEP.ViewModel = "models/weapons/yurie_rustalpha/c-vm-huntingbow.mdl" --Viewmodel path
SWEP.ViewModelFOV = 54 -- This controls how big the viewmodel looks.  Less is more.
SWEP.ViewModelScale			= 1.3
SWEP.ViewModelFlip = false -- Set this to true for CSS models, or false for everything else (with a righthanded viewmodel.)
SWEP.UseHands = true --Use gmod c_arms system.
SWEP.Idle_Mode = TFA.Enum.IDLE_LUA
--[[WORLDMODEL]]
--
SWEP.WorldModel = "models/weapons/yurie_rustalpha/wm-huntingbow.mdl" -- Weapon world model path
SWEP.HoldType = "smg" -- This is how others view you carrying the weapon. Options include:

-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive
-- You're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles
--Procedural world model animation, defaulted for CS:S purposes.
SWEP.Offset = {
	Pos = {
		Up = -3.5,
		Right = 1.6,
		Forward = 14
	},
	Ang = {
		Up = -5,
		Right = -10,
		Forward = 180
	},
	Scale = 1
}

SWEP.ThirdPersonReloadDisable = false --Disable third person reload?  True disables.
--[[SPRINTING]]
--
SWEP.RunSightsPos = Vector(0.5, -3, -9.5) * SWEP.ViewModelScale
SWEP.RunSightsAng = Vector(12.75, -13, 37.5)
--[[IRONSIGHTS]]
--
SWEP.data = {}
SWEP.data.ironsights = 0 --Enable Ironsights
SWEP.Secondary.IronFOV = 60 -- How much you 'zoom' in. Less is more!  Don't have this be <= 0.  A good value for ironsights is like 70.
SWEP.IronSightsPos = Vector(0,0,0)
SWEP.IronSightsAng = Vector(0,0,0)
--If you really want, you can remove things from SWEP.actlist and manually enable animations and set their lengths.
SWEP.SequenceEnabled = {} --Self explanitory.  This can forcefully enable or disable a certain ACT_VM
SWEP.SequenceLength = {} --This controls the length of a certain ACT_VM
SWEP.SequenceLengthOverride = {} --Override this if you want to change the length of a sequence but not the next idle 
SWEP.StatusLengthOverride = {}
--[[EFFECTS]]
--
--Muzzle Flash
SWEP.MuzzleAttachment = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
--SWEP.MuzzleAttachmentRaw = 1 --This will override whatever string you gave.  This is the raw attachment number.  This is overridden or created when a gun makes a muzzle event.
SWEP.ShellAttachment = "2" -- Should be "2" for CSS models or "shell" for hl2 models
SWEP.DoMuzzleFlash = false --Do a muzzle flash?
SWEP.CustomMuzzleFlash = false --Disable muzzle anim events and use our custom flashes?
SWEP.AutoDetectMuzzleAttachment = true --For multi-barrel weapons, detect the proper attachment?
SWEP.MuzzleFlashEffect = ""
SWEP.MuzzleFlashEffectSilenced = ""
--Tracer Stuff
SWEP.Tracer = 0 --Bullet tracer.  TracerName overrides this.
SWEP.TracerCount = 3 --0 disables, otherwise, 1 in X chance
SWEP.TracerLua = false --Use lua effect, TFA Muzzle syntax.  Currently obsolete.
SWEP.TracerDelay = 0.01 --Delay for lua tracer effect
--[[EVENT TABLE]]
SWEP.EventTable = {
	[ACT_VM_DRAW] = {
		{time = 0, type = "sound", value = Sound("YURIE_RUSTALPHA.BOW.Draw")}
	},
	[ACT_VM_DEPLOY] = {
		{time = 0, type = "sound", value = Sound("YURIE_RUSTALPHA.BOW.DrawArrow")}
	},
	[ACT_VM_UNDEPLOY] = {
		{time = 0, type = "sound", value = Sound("YURIE_RUSTALPHA.BOW.DrawCancel")}
	},
}

--[[ballistics customs]]--

SWEP.BulletModel = "models/weapons/yurie_rustalpha/worldarrow.mdl"

DEFINE_BASECLASS(SWEP.Base)

if SERVER and TFA.SendRustHitMarker then
	SWEP.SendHitMarker = TFA.SendRustHitMarker
end

function SWEP:Think2(...)
	BaseClass.Think2(self, ...)

	if IsFirstTimePredicted() or game.SinglePlayer() then
		self.Primary.SpreadBase = self.Primary.SpreadBase or self:GetStat("Primary.Spread")
		-- print(self, math.Clamp(self:GetCharge() - self.ChargeThreshold, 0, 1 - self.ChargeThreshold) / (1 - self.ChargeThreshold))
		local targ = self:GetShaking() and self.Primary.SpreadShake or Lerp(math.Clamp(self:GetCharge() - self.ChargeThreshold, 0, 1 - self.ChargeThreshold) / (1 - self.ChargeThreshold), self:GetStat("Primary.SpreadBase"), self:GetStat("Primary.IronAccuracy"))
		self.Primary.Spread = math.Approach(self.Primary.Spread, targ, (targ - self.Primary.Spread) * FrameTime() * 25)
		self:ClearStatCache("Primary.Spread")
	end
end