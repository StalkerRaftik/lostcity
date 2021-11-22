SWEP.Base				= "tfa_gun_base"
SWEP.Category				= "LostCity Weapon First SR" --The category.  Please, just choose something generic or something I've already done if you plan on only doing like one swep..
SWEP.Manufacturer = "Kalashnikov Concern" --Gun Manufactrer (e.g. Hoeckler and Koch )
SWEP.Author				= "YuRaNnNzZZ" --Author Tooltip
SWEP.Contact				= "" --Contact Info Tooltip
SWEP.Purpose				= "" --Purpose Tooltip
SWEP.Instructions				= "" --Instructions Tooltip
SWEP.Spawnable				= (TFA and TFA.INS2) and true or false -- INSTALL SHARED PARTS
SWEP.AdminSpawnable			= true --Can an adminstrator spawn this?  Does not tie into your admin mod necessarily, unless its coded to allow for GMod's default ranks somewhere in its code.  Evolve and ULX should work, but try to use weapon restriction rather than these.
SWEP.DrawCrosshair			= false		-- Draw the crosshair?
SWEP.DrawCrosshairIS = false --Draw the crosshair in ironsights?
SWEP.PrintName				= "Makarov PM [First SR]"		-- Weapon name (Shown on HUD)
SWEP.Slot				= 1				-- Slot in the weapon selection menu.  Subtract 1, as this starts at 0.
SWEP.SlotPos				= 74			-- Position in the slot
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.Weight				= 30			-- This controls how "good" the weapon is for autopickup.

--[[WEAPON HANDLING]]--
SWEP.Primary.Sound = Sound("TFA_INS2.PM.1") -- This is the sound of the weapon, when you shoot.
SWEP.Primary.SilencedSound = Sound("TFA_INS2.PM.2") -- This is the sound of the weapon, when silenced.
SWEP.Primary.Damage = 18 -- Damage, in standard damage points.
SWEP.Primary.Force = nil --Force value, leave nil to autocalc
SWEP.Primary.Knockback = 0 --Autodetected if nil; this is the velocity kickback
SWEP.Primary.HullSize = 0 --Big bullets, increase this value.  They increase the hull size of the hitscan bullet.
SWEP.Primary.NumShots = 1 --The number of shots the weapon fires.  SWEP.Shotgun is NOT required for this to be >1.
SWEP.Primary.Automatic = false -- Automatic/Semi Auto
SWEP.Primary.RPM = 500 -- This is in Rounds Per Minute / RPM
SWEP.Primary.Velocity = 315 -- m/s

SWEP.FiresUnderwater = false

--Ammo Related
SWEP.Primary.ClipSize = 7 -- This is the size of a clip
SWEP.Primary.DefaultClip = 0 -- This is the number of bullets the gun gives you, counting a clip as defined directly above.
SWEP.Primary.Ammo = "pistol" -- What kind of ammo.  Options, besides custom, include pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, and AirboatGun.
--Pistol, buckshot, and slam like to ricochet. Use AirboatGun for a light metal peircing shotgun pellets
SWEP.Primary.AmmoConsumption = 1 --Ammo consumed per shot
SWEP.DisableChambering = false --Disable round-in-the-chamber
--Recoil Related
SWEP.Primary.KickUp = 0.75 -- This is the maximum upwards recoil (rise)
SWEP.Primary.KickDown = 0.48 -- This is the maximum downwards recoil (skeet)
SWEP.Primary.KickHorizontal = 0.28 -- This is the maximum sideways recoil (no real term)
SWEP.Primary.StaticRecoilFactor = 0.45 --Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.  This is also affected by a convar that defaults to 0.5.
--Firing Cone Related
SWEP.Primary.Spread = .015 --This is hip-fire acuracy.  Less is more (1 is horribly awful, .0001 is close to perfect)
SWEP.Primary.IronAccuracy = .005 -- Ironsight accuracy, should be the same for shotguns
--Unless you can do this manually, autodetect it.  If you decide to manually do these, uncomment this block and remove this line.
SWEP.Primary.SpreadMultiplierMax = 4--How far the spread can expand when you shoot. Example val: 2.5
SWEP.Primary.SpreadIncrement = 0.85 --What percentage of the modifier is added on, per shot.  Example val: 1/3.5
SWEP.Primary.SpreadRecovery = 4 --How much the spread recovers, per second. Example val: 3
--Range Related
SWEP.Primary.Range = 0.35 * (3280.84 * 16) -- The distance the bullet can travel in source units.  Set to -1 to autodetect based on damage/rpm.
SWEP.Primary.RangeFalloff = 5 / 35 -- The percentage of the range the bullet damage starts to fall off at.  Set to 0.8, for example, to start falling off after 80% of the range.
--Misc
SWEP.IronRecoilMultiplier = 0.66 --Multiply recoil by this factor when we're in ironsights.  This is proportional, not inversely.
SWEP.CrouchAccuracyMultiplier = 0.85 --Less is more.  Accuracy * 0.5 = Twice as accurate, Accuracy * 0.1 = Ten times as accurate
--[[VIEWMODEL]]--
SWEP.ViewModel			= "models/weapons/tfa_ins2/c_pm.mdl" --Viewmodel path
SWEP.ViewModelFOV			= 70		-- This controls how big the viewmodel looks.  Less is more.
SWEP.ViewModelFlip			= false		-- Set this to true for CSS models, or false for everything else (with a righthanded viewmodel.)
SWEP.UseHands = true --Use gmod c_arms system.
-- SWEP.VMPos = Vector(-0.25, -0.15, -0.75)
SWEP.VMPos = Vector(-0.75, -0.15, -0.75) * 1.3
SWEP.VMPos_Additive = false --Set to false for an easier time using VMPos. If true, VMPos will act as a constant delta ON TOP OF ironsights, run, whateverelse
--[[WORLDMODEL]]--
SWEP.WorldModel			= "models/weapons/tfa_ins2/w_pm.mdl" -- Weapon world model path
SWEP.HoldType = "pistol" -- This is how others view you carrying the weapon. Options include:
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive
-- You're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles
SWEP.Offset = {
	Pos = {
		Up = -1.5,
		Right = 1.5,
		Forward = 4.5
	},
	Ang = {
		Up = -1,
		Right = -5,
		Forward = 178
	},
	Scale = 1
} --Procedural world model animation, defaulted for CS:S purposes.
--[[SPRINTING]]--
SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(0, 0, 0)
--[[SAFETY]]--
SWEP.SafetyPos = Vector(4, -3, 0.75)
SWEP.SafetyAng = Vector(-32, 45, -20)
--[[IRONSIGHTS]]--
SWEP.data = {}
SWEP.data.ironsights = 1 --Enable Ironsights
SWEP.Secondary.IronFOV = 80 -- How much you 'zoom' in. Less is more!  Don't have this be <= 0.  A good value for ironsights is like 70.
SWEP.IronSightsPos = Vector(-2.15, 0, 0.353)
SWEP.IronSightsAng = Vector(0.39, -0.01, 0)
--[[INSPECTION]]--
-- SWEP.InspectPos = Vector(9.78, -9.658, -2.241) --Vector(0,0,0) --Replace with a vector, in style of ironsights position, to be used for inspection
-- SWEP.InspectAng = Vector(24.622, 42.915, 15.477) --Vector(0,0,0) --Replace with a vector, in style of ironsights angle, to be used for inspection
SWEP.InspectPos = Vector(8, -8, -2.5)
SWEP.InspectAng = Vector(24, 42, 15)
--[[ANIMATION]]--
SWEP.StatusLengthOverride = {
	[ACT_VM_RELOAD] = 64 / 30,
	[ACT_VM_RELOAD_EMPTY] = 64 / 30,
	["base_reload_extmag"] = 64 / 30,
	["base_reload_empty_extmag"] = 64 / 30,
} --Changes the status delay of a given animation; only used on reloads.  Otherwise, use SequenceLengthOverride or one of the others

SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_HYBRID -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_ANI -- ANI = mdl, HYBRID = ani + lua, Lua = lua only

--MDL Animations Below
SWEP.IronAnimation = {
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "base_idle", --Number for act, String/Number for sequence
		["value_empty"] = "iron_empty"
	},
	["shoot"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_PRIMARYATTACK_1, --Number for act, String/Number for sequence
		["value_last"] = ACT_VM_PRIMARYATTACK_2,
		["value_empty"] = ACT_VM_PRIMARYATTACK_3
	} --What do you think
}

SWEP.SprintAnimation = {
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "base_sprint", --Number for act, String/Number for sequence
		["value_empty"] = "empty_sprint",
		["is_idle"] = true
	}
}
--[[EFFECTS]]--
--Attachments
SWEP.MuzzleFlashEnabled = true --Enable muzzle flash
SWEP.MuzzleAttachment			= "muzzle" 		-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.MuzzleFlashEffect = "tfa_muzzleflash_pistol" --Change to a string of your muzzle flash effect.  Copy/paste one of the existing from the base.
--Shell eject override
SWEP.ShellAttachment			= "shell" 		-- Should be "2" for CSS models or "shell" for hl2 models
SWEP.LuaShellEject = true --Enable shell ejection through lua?
SWEP.LuaShellEjectDelay = 0 --The delay to actually eject things
SWEP.LuaShellEffect = "ShellEject" --The effect used for shell ejection; Defaults to that used for blowback
--[[EVENT TABLE]]--
local m_C = math.Clamp
function SWEP:UpdateBeltBG(vm)
	local target = self:Clip1()

	if self:GetStatus() == TFA.Enum.STATUS_RELOADING then -- we predict next clip1 when reloading
		target = self:Clip1() + self:Ammo1()
	end

	if self.IsChambered then -- we draw (clip1 - 1) bullets if weapon is chambered
		target = target - 1
	end

	self.Bodygroups_V["Belt"] = m_C(target, 0, self:GetMaxClip1()) -- assuming we have at least (nax clip1 with upgrades) meshes in Belt bodygroup (first one is blank or empty mag insides)
end

SWEP.EventTable = {
	["base_ready"] = {
		{["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_INS2.PistolDraw")},
		{["time"] = 8 / 30, ["type"] = "sound", ["value"] = Sound("TFA_INS2.PM.Safety")},
		{["time"] = 13 / 30, ["type"] = "sound", ["value"] = Sound("TFA_INS2.PM.Boltback")},
		{["time"] = 20 / 30, ["type"] = "sound", ["value"] = Sound("TFA_INS2.PM.Boltrelease")},
		{["time"] = 19 / 30, ["type"] = "lua", ["value"] = function(wep, vm) wep.IsChambered = true end}, -- first draw chamber state
	},
	["base_draw"] = {
		{["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_INS2.PistolDraw")},
	},
	["base_holster"] = {
		{["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_INS2.PistolHolster")},
	},
	["base_dryfire"] = {
		{["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_INS2.PM.Empty")},
	},
	["base_reload"] = {
		{["time"] = 22 / 30, ["type"] = "sound", ["value"] = Sound("TFA_INS2.PM.Magrelease")},
		{["time"] = 27 / 30, ["type"] = "sound", ["value"] = Sound("TFA_INS2.PM.Magout")},
		{["time"] = 53 / 30, ["type"] = "sound", ["value"] = Sound("TFA_INS2.PM.Magin")},
		{["time"] = 64 / 30, ["type"] = "sound", ["value"] = Sound("TFA_INS2.PM.MagHit")},

		{["time"] = 45 / 30, ["type"] = "lua", ["value"] = SWEP.UpdateBeltBG}, -- mag change frame manual call
	},
	["base_reload_empty"] = {
		{["time"] = 22 / 30, ["type"] = "sound", ["value"] = Sound("TFA_INS2.PM.Magrelease")},
		{["time"] = 27 / 30, ["type"] = "sound", ["value"] = Sound("TFA_INS2.PM.Magout")},
		{["time"] = 53 / 30, ["type"] = "sound", ["value"] = Sound("TFA_INS2.PM.Magin")},
		{["time"] = 64 / 30, ["type"] = "sound", ["value"] = Sound("TFA_INS2.PM.MagHit")},
		{["time"] = 72 / 30, ["type"] = "sound", ["value"] = Sound("TFA_INS2.PM.Boltrelease")},

		{["time"] = 0, ["type"] = "lua", ["value"] = function(wep, vm) wep.IsChambered = false end}, -- resetting chamber at start because weapon's empty
		{["time"] = 45 / 30, ["type"] = "lua", ["value"] = SWEP.UpdateBeltBG}, -- mag change frame manual call
		{["time"] = 70 / 30, ["type"] = "lua", ["value"] = function(wep, vm) wep.IsChambered = true end}, -- updating chamber state (after actual reload status, handled by Think2)
	},
	["base_reload_extmag"] = {
		{["time"] = 22 / 30, ["type"] = "sound", ["value"] = Sound("TFA_INS2.PM.Magrelease")},
		{["time"] = 27 / 30, ["type"] = "sound", ["value"] = Sound("TFA_INS2.PM.Magout")},
		{["time"] = 53 / 30, ["type"] = "sound", ["value"] = Sound("TFA_INS2.PM.Magin")},
		{["time"] = 64 / 30, ["type"] = "sound", ["value"] = Sound("TFA_INS2.PM.MagHit")},

		{["time"] = 45 / 30, ["type"] = "lua", ["value"] = SWEP.UpdateBeltBG},
	},
	["base_reload_empty_extmag"] = {
		{["time"] = 22 / 30, ["type"] = "sound", ["value"] = Sound("TFA_INS2.PM.Magrelease")},
		{["time"] = 27 / 30, ["type"] = "sound", ["value"] = Sound("TFA_INS2.PM.Magout")},
		{["time"] = 53 / 30, ["type"] = "sound", ["value"] = Sound("TFA_INS2.PM.Magin")},
		{["time"] = 64 / 30, ["type"] = "sound", ["value"] = Sound("TFA_INS2.PM.MagHit")},
		{["time"] = 72 / 30, ["type"] = "sound", ["value"] = Sound("TFA_INS2.PM.Boltrelease")},

		{["time"] = 0, ["type"] = "lua", ["value"] = function(wep, vm) wep.IsChambered = false end},
		{["time"] = 45 / 30, ["type"] = "lua", ["value"] = SWEP.UpdateBeltBG},
		{["time"] = 70 / 30, ["type"] = "lua", ["value"] = function(wep, vm) wep.IsChambered = true end},
	},
	["empty_draw"] = {
		{["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_INS2.PistolDraw")},
	},
	["empty_holster"] = {
		{["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_INS2.PistolHolster")},
	},
	["iron_dryfire"] = {
		{["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_INS2.PM.Empty")},
	},

	["base_firelast"] = {
		{["time"] = 0.01, ["type"] = "sound", ["value"] = Sound("TFA_INS2.PM.SlideLock"), ["server"] = false, ["client"] = true},
	},
	["iron_fire_last"] = {
		{["time"] = 0.01, ["type"] = "sound", ["value"] = Sound("TFA_INS2.PM.SlideLock"), ["server"] = false, ["client"] = true},
	},
}

--[[ATTACHMENTS]]--
SWEP.Attachments = {
	[1] = { atts = { "ins2_br_supp" } },
	[2] = { atts = { "am_match", "am_magnum" } },
	[3] = { atts = { "ins2_ub_laser", "ins2_ub_flashlight" } },
	[4] = { atts = { "ins2_mag_ext_pistol" } },
	[5] = { atts = { "ins2_pm_alt", "ins2_pm_soviet", "ins2_pm_honorary" } }
}
SWEP.AttachmentDependencies = {}
SWEP.AttachmentExclusions = {}

local wscale = Vector(1, 1, 1) * 1 / 1.3

SWEP.ViewModelBoneMods = {
	["A_Suppressor"] = { ["pos"] = Vector(0, -0.3, 0), ["angle"] = Angle(0, 0, 0), ["scale"] = wscale },
	["A_Underbarrel"] = { ["pos"] = Vector(0, 0.5, 0), ["angle"] = Angle(0, 0, 0), ["scale"] = wscale }
}

SWEP.Bodygroups_V = {
	[1] = 0,
}

SWEP.VElements = {
	["mag"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/a_magazine_pm_8.mdl", bone = "", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = true, active = true },
	["mag_ext"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/a_magazine_pm_15.mdl", bone = "", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = true, active = false },

	["suppressor"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/a_suppressor_pistol.mdl", bone = "", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = true, active = false },

	["laser"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/a_laser_mak.mdl", bone = "", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = true, active = false },
	["laser_beam"] = { type = "Model", model = "models/tfa/lbeam.mdl", bone = "A_Beam", rel = "laser", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(2, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false },

	["flashlight"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/a_flashlight_mak.mdl", bone = "", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = true, active = false },
}

SWEP.WElements = {
	["mag"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/w_magazine_pm_8.mdl", bone = "", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = true, active = true },
	["mag_ext"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/w_magazine_pm_15.mdl", bone = "", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = true, active = false },

	["suppressor"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/w_sil_pistol.mdl", bone = "ATTACH_Muzzle", rel = "ref", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = true, active = false },
	["laser"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/w_laser_sec.mdl", bone = "ATTACH_Laser", rel = "ref", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = true, active = false },
}

SWEP.MuzzleAttachmentSilenced = 2
SWEP.LaserSightModAttachment = 1
SWEP.LaserSightModAttachmentWorld = 4

DEFINE_BASECLASS( SWEP.Base )

function SWEP:Think2(...)
	if self:GetStatus() ~= TFA.Enum.STATUS_RELOADING then
		self:UpdateBeltBG()
	end

	return BaseClass.Think2(self, ...)
end

-- Feel free to reuse bodygroup belt/magazine code as long as me and TFA get proper credits for it ~ YuRaNnNzZZ
