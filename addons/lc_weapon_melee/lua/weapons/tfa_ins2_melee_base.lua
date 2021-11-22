SWEP.Base = "tfa_melee_base"

SWEP.Category = "LostCity Edged Weapons"
SWEP.PrintName = "Melee Base"
SWEP.UseHands = true

SWEP.ViewModelFOV = 56
SWEP.ViewModel = "error.mdl"
SWEP.WorldModel = "error.mdl"

SWEP.CameraOffset = Angle(0, 0, 0)
SWEP.Offset = {
	Pos = {
		Up = -2.5,
		Right = 1,
		Forward = 3.5
	},
	Ang = {
		Up = 0,
		Right = 90,
		Forward = 0
	},
	Scale = 1
}

SWEP.HoldType = "knife"
SWEP.Spawnable = false
SWEP.AdminOnly = false

SWEP.Primary.Damage = 40

SWEP.Primary.MaxCombo = -1
SWEP.Primary.Attacks = {
	{
		["act"] = ACT_VM_HITCENTER, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 16 * 3, -- Trace distance
		["dir"] = Vector(40, 15, 0), -- Trace arc cast
		["dmg"] = SWEP.Primary.Damage, --Damage
		["dmgtype"] = DMG_SLASH, --DMG_SLASH,DMG_CRUSH, etc.
		["delay"] = 7 / 30, --Delay
		["spr"] = false, --Allow attack while sprinting?
		["snd"] = "TFA_INS2.MELEE.Swing", -- unplayable your ass
		["snd_delay"] = 7 / 30,
		["viewpunch"] = Angle(0, 0, 0), --viewpunch angle
		["end"] = 0.9, --time before next attack
		["hull"] = 16, --Hullsize
		["direction"] = "R", --Swing dir,
		["hitflesh"] = "TFA_INS2.MELEE.HitFlesh",
		["hitworld"] = "TFA_INS2.MELEE.HitWorld",
		["combotime"] = 0
	}
}

SWEP.AllowSprintAttack = false

SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_ANI
SWEP.SprintAnimation = {
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ,
		["value"] = "sprint",
		["is_idle"] = true
	}
}
SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(0, 0, 0)

DEFINE_BASECLASS(SWEP.Base)

function SWEP:SecondaryAttack()
	-- nothing here
end

function SWEP:RemoveAltAttack()
	if self.AltAttack then
		self.AltAttack = nil
	end
end

function SWEP:Think2(...)
	self:RemoveAltAttack()

	BaseClass.Think2(self, ...)
end
