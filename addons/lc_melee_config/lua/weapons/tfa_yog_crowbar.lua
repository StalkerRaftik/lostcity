SWEP.Base = "tfa_melee_base"
DEFINE_BASECLASS(SWEP.Base)

if TFA and TFA.AddSound then
	TFA.AddSound("YURIE_CUSTOMS.YOG_CROWBAR.Draw", CHAN_STATIC, 1, 65, 100, "weapons/yurie_customs/yog_crowbar/deploy.wav")
end

if killicon and killicon.Add then
	killicon.Add("tfa_yog_crowbar", "vgui/killicons/tfa_yog_crowbar", Color(255, 80, 0, 191))
end

SWEP.PrintName = "Потрошитель [Edged Weapons]"
SWEP.Category = "LostCity Edged Weapons"
SWEP.Author = "Yogensia, Lynx9810, YuRaNnNzZZ"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.5
SWEP.AdminOnly = false
SWEP.DrawCrosshair = false

SWEP.ViewModelFOV = 54
SWEP.ViewModel = "models/weapons/yurie_customs/v_yog_crowbar.mdl"
SWEP.UseHands = true

SWEP.WorldModel = "models/weapons/yurie_customs/w_yog_crowbar.mdl"
SWEP.HoldType = "melee"

SWEP.Primary.Sound = Sound("Weapon_Crowbar.Single")
SWEP.Primary.Sound_Hit = Sound("Weapon_Crowbar.Melee_Hit")

SWEP.EventTable = {
	[ACT_VM_DRAW] = {
		{time = 0, type = "snd", value = "YURIE_CUSTOMS.YOG_CROWBAR.Draw"}
	}
}

SWEP.ImpactDecal = ""

SWEP.Primary.Damage = 31
SWEP.Primary.DamageType = bit.bor(DMG_CLUB, DMG_SLASH)
SWEP.Primary.Attacks = {
	{
		["act"] = ACT_VM_MISSRIGHT, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 75, -- Trace distance
		["src"] = Vector(0, 0, 0), -- Trace source; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dir"] = Vector(0, 12, 0), -- Trace direction/length; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dmg"] = SWEP.Primary.Damage, --Damage
		["dmgtype"] = SWEP.Primary.DamageType,
		["delay"] = 3 / 30, --Delay
		["spr"] = true, --Allow attack while sprinting?
		["snd"] = SWEP.Primary.Sound, -- Sound ID
		["hitflesh"] = SWEP.Primary.Sound_Hit,
		["hitworld"] = SWEP.Primary.Sound_Hit,
		["viewpunch"] = Angle(1, 2, 0), --viewpunch angle
		["end"] = 0.4, --time before next attack
		["hull"] = 10, --Hullsize
		["callback"] = function(tbl, wep, tr)
			if not tr.Hit then return end
			wep:PlaySwing(ACT_VM_HITRIGHT)
		end,
	},
	{
		["act"] = ACT_VM_MISSCENTER, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 75, -- Trace distance
		["src"] = Vector(0, 0, 0), -- Trace source; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dir"] = Vector(0, 12, 0), -- Trace direction/length; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dmg"] = SWEP.Primary.Damage, --Damage
		["dmgtype"] = SWEP.Primary.DamageType,
		["delay"] = 2 / 30, --Delay
		["spr"] = true, --Allow attack while sprinting?
		["snd"] = SWEP.Primary.Sound, -- Sound ID
		["hitflesh"] = SWEP.Primary.Sound_Hit,
		["hitworld"] = SWEP.Primary.Sound_Hit,
		["viewpunch"] = Angle(2, 0, 0), --viewpunch angle
		["end"] = 0.4, --time before next attack
		["hull"] = 10, --Hullsize
		["callback"] = function(tbl, wep, tr)
			if not tr.Hit then return end
			wep:PlaySwing(ACT_VM_HITCENTER)
		end,
	},
}
SWEP.Primary.RPM = 40 / 0.4

SWEP.AllowSprintAttack = true
SWEP.Secondary.CanBash = false

SWEP.Primary.MaxCombo = 0
SWEP.Secondary.MaxCombo = 0

SWEP.Offset = {
	Pos = {
		Up = -3,
		Right = 1.5,
		Forward = 3
	},
	Ang = {
		Up = 180,
		Right = 90,
		Forward = 0
	},
	Scale = 1
}

SWEP.AltAttack = false
SWEP.SecondaryAttack = function() return false end

SWEP.Customize_Mode = TFA.Enum.LOCOMOTION_ANI
SWEP.CustomizeAnimation = { loop = { type = TFA.Enum.ANIMATION_SEQ, value = "inspect", is_idle = true } }
