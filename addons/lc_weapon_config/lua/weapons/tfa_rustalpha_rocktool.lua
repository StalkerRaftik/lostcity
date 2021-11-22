SWEP.Base = "tfa_rustalpha_meleebase"

SWEP.Category = "LostCity Edged Weapons"
SWEP.Spawnable = (TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.5) and (TFA and TFA.RUSTALPHA ~= nil)
SWEP.AdminOnly = false

SWEP.Author = "YuRaNnNzZZ"
SWEP.PrintName = "Камень [Edged Weapons]"
SWEP.ViewModel = "models/weapons/yurie_rustalpha/c-vm-rock.mdl"
SWEP.WorldModel = "models/weapons/yurie_rustalpha/wm-rock.mdl"
SWEP.UseHands = true

SWEP.Type = "Melee Weapon"
SWEP.Type_Displayed = "Tool"

SWEP.ViewModelFOV = 54

SWEP.ViewModelBoneMods = {
	-- ["fpsarms"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 90, 90) }
}

SWEP.Primary.Damage = 12

SWEP.EventTable = {
	[ACT_VM_DRAW] = {
		{time = 0, type = "sound", value = Sound("YURIE_RUSTALPHA.Draw")}
	},
}

SWEP.StatusLengthOverride = {
	[ACT_VM_DRAW] = 0.75,
}

SWEP.Primary.MaxCombo = -1
SWEP.Primary.Attacks = {
	{
		["act"] = ACT_VM_PRIMARYATTACK, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 16 * 3, -- Trace distance
		["dir"] = Vector(0, 0, 0), -- Trace arc cast
		["dmg"] = SWEP.Primary.Damage, --Damage
		["dmgtype"] = DMG_CRUSH, --DMG_SLASH,DMG_CRUSH, etc.
		["delay"] = 1.25, --Delay
		["spr"] = false, --Allow attack while sprinting?
		["snd"] = Sound("YURIE_RUSTALPHA.Melee.Swing"),
		["snd_delay"] = 1.15,
		["viewpunch"] = Angle(0, 0, 0), --viewpunch angle
		["end"] = 1.95, --time before next attack
		["hull"] = 16, --Hullsize
		["direction"] = "F", --Swing dir,
		["hitflesh"] = "",
		["hitworld"] = "",
		["combotime"] = 0
	}
}

SWEP.AllowSprintAttack = false
SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(-15, 0, 0)

SWEP.InspectPos = Vector(0, 0, 0)
SWEP.InspectAng = Vector(0, 0, 0)

SWEP.HoldType = "melee2"

SWEP.Offset = {
	Pos = {
		Up = 2,
		Right = 2,
		Forward = 1.5
	},
	Ang = {
		Up = 0,
		Right = 0,
		Forward = 90
	},
	Scale = 1
}