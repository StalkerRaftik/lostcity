SWEP.Base = "tfa_rustalpha_meleebase"

SWEP.Category = "LostCity Edged Weapons"
SWEP.Spawnable = (TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.5) and (TFA and TFA.RUSTALPHA ~= nil)
SWEP.AdminOnly = false

SWEP.Author = "YuRaNnNzZZ"
SWEP.PrintName = "Самодельная кирка [Edged Weapons]"

SWEP.Type = "Melee Weapon"
SWEP.Type_Displayed = "Tool"

SWEP.ViewModel = "models/weapons/yurie_rustalpha/c-vm-pickaxe.mdl"
SWEP.UseHands = true
SWEP.WorldModel = "models/weapons/yurie_rustalpha/wm-pickaxe.mdl"
SWEP.HoldType = "melee2"
SWEP.Offset = {
	Pos = {
		Up = -3,
		Right = 1,
		Forward = 4
	},
	Ang = {
		Up = 0,
		Right = 10,
		Forward = 180
	},
	Scale = 0.9
}

SWEP.ViewModelFOV = 54

SWEP.Primary.Damage = 60

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
		["delay"] = 0.85, --Delay
		["spr"] = false, --Allow attack while sprinting?
		["snd"] = Sound("YURIE_RUSTALPHA.Melee.Swing"),
		["snd_delay"] = 0.85,
		["viewpunch"] = Angle(0, 0, 0), --viewpunch angle
		["end"] = 2, --time before next attack
		["hull"] = 16, --Hullsize
		["direction"] = "F", --Swing dir,
		["hitflesh"] = "",
		["hitworld"] = "",
		["combotime"] = 0
	}
}

SWEP.AllowSprintAttack = false
SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(-20, 0, 0)

-- SWEP.InspectPos = Vector(-3.25, -9, -5.5)
-- SWEP.InspectAng = Vector(34, -24, 12)