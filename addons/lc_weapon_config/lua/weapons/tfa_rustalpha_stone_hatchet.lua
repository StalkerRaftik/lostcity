SWEP.Base = "tfa_rustalpha_meleebase"

SWEP.Category = "LostCity Edged Weapons"
SWEP.Spawnable = (TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.5) and (TFA and TFA.RUSTALPHA ~= nil)
SWEP.AdminOnly = false

SWEP.Author = "YuRaNnNzZZ"
SWEP.PrintName = "Каменный топор [Edged Weapons]"

SWEP.Type = "Melee Weapon"
SWEP.Type_Displayed = "Tool"

SWEP.ViewModel = "models/weapons/yurie_rustalpha/c-vm-stonehatchet.mdl"
SWEP.WorldModel = "models/weapons/yurie_rustalpha/wm-stonehatchet.mdl"

SWEP.ViewModelFOV = 54
SWEP.UseHands = true

SWEP.HoldType = "melee"

SWEP.Offset = {
	Pos = {
		Up = 0,
		Right = 1.5,
		Forward = 3
	},
	Ang = {
		Up = 0,
		Right = 0,
		Forward = 180
	},
	Scale = 1
}

SWEP.Idle_Mode = TFA.Enum.IDLE_LUA

SWEP.Primary.Damage = 19

SWEP.EventTable = {
	[ACT_VM_DRAW] = {
		{time = 0, type = "sound", value = Sound("YURIE_RUSTALPHA.Draw")}
	},
}

SWEP.Primary.MaxCombo = -1
SWEP.Primary.Attacks = {
	{
		["act"] = ACT_VM_SWINGMISS, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 16 * 3, -- Trace distance
		["dir"] = Vector(0, 0, 0), -- Trace arc cast
		["dmg"] = SWEP.Primary.Damage, --Damage
		["dmgtype"] = DMG_CLUB, --DMG_SLASH,DMG_CRUSH, etc.
		["delay"] = 12 / 30, --Delay
		["spr"] = false, --Allow attack while sprinting?
		["snd"] = Sound("YURIE_RUSTALPHA.Melee.Swing"),
		["snd_delay"] = 0.15,
		["viewpunch"] = Angle(0, 0, 0), --viewpunch angle
		["end"] = 0.9, --time before next attack
		["hull"] = 16, --Hullsize
		["direction"] = "F", --Swing dir,
		["hitflesh"] = "",
		["hitworld"] = "",
		["combotime"] = 0
	}
}

SWEP.AllowSprintAttack = false
SWEP.RunSightsPos = Vector(0, 0, -6) * 1.3
SWEP.RunSightsAng = Vector(0, 0, 0)

-- SWEP.InspectPos = Vector(-3.25, -9, -5.5)
-- SWEP.InspectAng = Vector(34, -24, 12)

SWEP.SwingHitAnimation = ACT_VM_SWINGHIT