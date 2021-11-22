SWEP.Base = "tfa_melee_base"
SWEP.Category = "LostCity Edged Weapons"
SWEP.PrintName = "Сувенирный нож [Edged Weapons]"
SWEP.ViewModel = "models/weapons/c_xiandagger.mdl"
SWEP.ViewModelFOV = 56
SWEP.UseHands = true
SWEP.CameraOffset = Angle(0, 0, 0)
SWEP.WorldModel = "models/weapons/w_xiandagger.mdl"
SWEP.Offset = {
	Pos = {
		Up = -2,
		Right = 0.5,
		Forward = 3.5
	},
	Ang = {
		Up = -1,
		Right = 5,
		Forward = 170
	},
	Scale = 1.3
}
SWEP.HoldType = "knife"
SWEP.Primary.Directional = true
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Primary.Attacks = {
	{
		["act"] = ACT_VM_HITRIGHT, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 16 * 3, -- Trace distance
		["dir"] = Vector(32, 16, 8), -- Trace arc cast
		["dmg"] = 32, --Damage
		["dmgtype"] = DMG_SLASH, --DMG_SLASH,DMG_CRUSH, etc.
		["delay"] = 7 / 30, --Delay
		["spr"] = true, --Allow attack while sprinting?
		["snd"] = "TFA_XIAN.Swing", -- Sound ID
		["snd_delay"] = 5 / 30,
		["viewpunch"] = Angle(-1, -5, 0), --viewpunch angle
		["end"] = 20 / 30, --time before next attack
		["hull"] = 16, --Hullsize
		["direction"] = "R", --Swing dir,
		["hitflesh"] = "TFA_XIAN.HitFlesh",
		["hitworld"] = "TFA_XIAN.HitWorld",
		["combotime"] = 0.2
	},
	{
		["act"] = ACT_VM_HITLEFT, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 16 * 3, -- Trace distance
		["dir"] = Vector(32, 16, -32), -- Trace arc cast
		["dmg"] = 40, --Damage
		["dmgtype"] = DMG_SLASH, --DMG_SLASH,DMG_CRUSH, etc.
		["delay"] = 7 / 30, --Delay
		["spr"] = true, --Allow attack while sprinting?
		["snd"] = "TFA_XIAN.Swing", -- Sound ID
		["snd_delay"] = 5 / 30,
		["viewpunch"] = Angle(3, -5, 0), --viewpunch angle
		["end"] = 20 / 30, --time before next attack
		["hull"] = 16, --Hullsize
		["direction"] = "R", --Swing dir,
		["hitflesh"] = "TFA_XIAN.HitFlesh",
		["hitworld"] = "TFA_XIAN.HitWorld",
		["combotime"] = 0.2
	},
	{
		["act"] = ACT_VM_HITCENTER, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 16 * 3, -- Trace distance
		["dir"] = Vector(0, 16, 32), -- Trace arc cast
		["dmg"] = 42, --Damage
		["dmgtype"] = DMG_SLASH, --DMG_SLASH,DMG_CRUSH, etc.
		["delay"] = 7 / 30, --Delay
		["spr"] = true, --Allow attack while sprinting?
		["snd"] = "TFA_XIAN.Swing", -- Sound ID
		["snd_delay"] = 5 / 30,
		["viewpunch"] = Angle(-5,0,0), --viewpunch angle
		["end"] = 20 / 30, --time before next attack
		["hull"] = 16, --Hullsize
		["direction"] = "B", --Swing dir,
		["hitflesh"] = "TFA_XIAN.HitFlesh",
		["hitworld"] = "TFA_XIAN.HitWorld",
		["combotime"] = 0.2
	}
}

SWEP.AllowSprintAttack = false

SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_ANI -- ANI = mdl, Hybrid = ani + lua, Lua = lua only
SWEP.SprintAnimation = {
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "sprint", --Number for act, String/Number for sequence
		["is_idle"] = true
	}
}
SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(-25, -2.5, 2.5)


SWEP.CanBlock = false
SWEP.BlockAnimation = {
}

SWEP.Secondary.CanBash = false