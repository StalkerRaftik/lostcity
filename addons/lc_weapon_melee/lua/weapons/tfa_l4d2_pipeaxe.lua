SWEP.Base = "tfa_melee_base"
SWEP.Author = "YuRaNnNzZZ"
SWEP.Category = "LostCity Edged Weapons"
SWEP.PrintName = "Улучшенная труба [Edged Weapons]"
SWEP.ViewModel = "models/weapons/tfa_l4d2/c_pipeaxe.mdl"
SWEP.ViewModelFOV = 60
SWEP.VMPos = Vector(-1, -2, -1)
SWEP.UseHands = true
SWEP.WorldModel = "models/weapons/tfa_l4d2/w_pipeaxe.mdl"
SWEP.HoldType = "melee2"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4
SWEP.AdminOnly = false

SWEP.Primary.Sound = Sound("TFA_L4D2.PIPEAXE.Swing")
SWEP.Primary.Sound_HitFlesh = Sound("TFA_L4D2.PIPEAXE.HitFlesh")
SWEP.Primary.Sound_HitWorld = Sound("TFA_L4D2.PIPEAXE.HitWorld")

SWEP.Primary.Directional = true
SWEP.Primary.Damage = 69
SWEP.Primary.Attacks = {
	{
		["act"] = ACT_VM_PRIMARYATTACK, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 8 * 4.5, -- Trace distance
		["dir"] = Vector(-75, 20, -5), -- Trace arc cast
		["dmg"] = SWEP.Primary.Damage, --Damage
		["dmgtype"] = DMG_SLASH, --DMG_SLASH,DMG_CRUSH, etc.
		["delay"] = 0.28, --Delay
		["spr"] = true, --Allow attack while sprinting?
		["snd"] = SWEP.Primary.Sound, -- Sound ID
		["snd_delay"] = 0.22,
		["viewpunch"] = Angle(10, 20, 0), --viewpunch angle
		["end"] = 0.8, --time before next attack
		["hull"] = 10, --Hullsize
		["direction"] = "L", --Swing dir,
		["hitflesh"] = SWEP.Primary.Sound_HitFlesh,
		["hitworld"] = SWEP.Primary.Sound_HitWorld,
		["combotime"] = 0.1
	},
	{
		["act"] = ACT_VM_HITLEFT, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 8 * 4.5, -- Trace distance
		["dir"] = Vector(80, 20, -50), -- Trace arc cast
		["dmg"] = SWEP.Primary.Damage, --Damage
		["dmgtype"] = DMG_SLASH, --DMG_SLASH,DMG_CRUSH, etc.
		["delay"] = 0.26, --Delay
		["spr"] = true, --Allow attack while sprinting?
		["snd"] = SWEP.Primary.Sound, -- Sound ID
		["snd_delay"] = 0.22,
		["viewpunch"] = Angle(10, -20, 0), --viewpunch angle
		["end"] = 0.8, --time before next attack
		["hull"] = 10, --Hullsize
		["direction"] = "R", --Swing dir,
		["hitflesh"] = SWEP.Primary.Sound_HitFlesh,
		["hitworld"] = SWEP.Primary.Sound_HitWorld,
		["combotime"] = 0.1
	}
}
SWEP.Primary.RPM_Displayed = 1488

SWEP.AllowSprintAttack = true
SWEP.Secondary.CanBash = true
SWEP.Secondary.BashDamageType = DMG_CRUSH

SWEP.Offset = {
	Pos = {
		Up = -1,
		Right = 1.5,
		Forward = 3.5
	},
	Ang = {
		Up = 0,
		Right = 0,
		Forward = 175
	},
	Scale = 1
}

DEFINE_BASECLASS(SWEP.Base)

function SWEP:ReplaceAltAttack()
	if self.AltAttack then
		self.SecondaryAttack = self.AltAttack
		self.AltAttack = nil
	end
end

function SWEP:Think2(...)
	self:ReplaceAltAttack()

	BaseClass.Think2(self, ...)
end
