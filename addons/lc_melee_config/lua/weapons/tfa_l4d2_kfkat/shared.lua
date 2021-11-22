SWEP.Base = "tfa_melee_base"
SWEP.Category = "LostCity Edged Weapons"
SWEP.PrintName = "Катана [Edged Weapons]"

SWEP.ViewModel = "models/weapons/tfa_l4d2/c_kf2_katana.mdl"
SWEP.ViewModelFOV = 65
SWEP.VMPos = Vector(0,-3,-1)
SWEP.UseHands = true
SWEP.CameraOffset = Angle(0,-2,0)

SWEP.InspectPos = Vector(17.184, -4.891, -11.652) - SWEP.VMPos
SWEP.InspectAng = Vector(70, 46.431, 70)

SWEP.WorldModel = "models/weapons/tfa_l4d2/w_kf2_katana.mdl"
SWEP.HoldType = "melee2"

SWEP.Primary.Directional = true

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.DisableIdleAnimations = false

SWEP.Primary.Attacks = {
	{
		['act'] = ACT_VM_HITLEFT, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		['len'] = 16*4.8, -- Trace distance
		['dir'] = Vector(-65,0,0), -- Trace arc cast
		['dmg'] = 80, --Damage
		['dmgtype'] = DMG_SLASH, --DMG_SLASH,DMG_CRUSH, etc.
		['delay'] = 0.4, --Delay
		['spr'] = true, --Allow attack while sprinting?
		['snd'] = "TFA_L4D2_KF2_KATANA.Swing", -- Sound ID
		['snd_delay'] = 0.26,
		["viewpunch"] = Angle(1,-5,0), --viewpunch angle
		['end'] = 0.8, --time before next attack
		['hull'] = 16, --Hullsize
		['direction'] = "L", --Swing dir,
		['hitflesh'] = "TFA_L4D2_KF2_KATANA.HitFlesh",
		['hitworld'] = "TFA_L4D2_KF2_KATANA.HitWorld"
	},
	{
		['act'] = ACT_VM_MISSLEFT, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		['len'] = 16*4.8, -- Trace distance
		['dir'] = Vector(-65,0,0), -- Trace arc cast
		['dmg'] = 82, --Damage
		['dmgtype'] = DMG_SLASH, --DMG_SLASH,DMG_CRUSH, etc.
		['delay'] = 0.45, --Delay
		['spr'] = true, --Allow attack while sprinting?
		['snd'] = "TFA_L4D2_KF2_KATANA.Swing", -- Sound ID
		['snd_delay'] = 0.35,
		["viewpunch"] = Angle(1,-5,0), --viewpunch angle
		['end'] = 1.2, --time before next attack
		['hull'] = 16, --Hullsize
		['direction'] = "L", --Swing dir
		['hitflesh'] = "TFA_L4D2_KF2_KATANA.HitFlesh",
		['hitworld'] = "TFA_L4D2_KF2_KATANA.HitWorld"
	},
	{
		['act'] = ACT_VM_HITRIGHT, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		['len'] = 16*4.8, -- Trace distance
		['dir'] = Vector(65,0,0), -- Trace arc cast
		['dmg'] = 83, --Damage
		['dmgtype'] = DMG_SLASH, --DMG_SLASH,DMG_CRUSH, etc.
		['delay'] = 0.4, --Delay
		['spr'] = true, --Allow attack while sprinting?
		['snd'] = "TFA_L4D2_KF2_KATANA.Swing", -- Sound ID
		['snd_delay'] = 0.35,
		["viewpunch"] = Angle(1,5,0), --viewpunch angle
		['end'] = 1.2, --time before next attack
		['hull'] = 16, --Hullsize
		['direction'] = "R", --Swing dir
		['hitflesh'] = "TFA_L4D2_KF2_KATANA.HitFlesh",
		['hitworld'] = "TFA_L4D2_KF2_KATANA.HitWorld"
	},
	{
		['act'] = ACT_VM_MISSRIGHT, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		['len'] = 16*4.8, -- Trace distance
		['dir'] = Vector(65,0,0), -- Trace arc cast
		['dmg'] = 120, --Damage
		['dmgtype'] = DMG_SLASH, --DMG_SLASH,DMG_CRUSH, etc.
		['delay'] = 0.45, --Delay
		['spr'] = true, --Allow attack while sprinting?
		['snd'] = "TFA_L4D2_KF2_KATANA.Swing", -- Sound ID
		['snd_delay'] = 0.26,
		["viewpunch"] = Angle(1,5,0), --viewpunch angle
		['end'] = 1.2, --time before next attack
		['hull'] = 16, --Hullsize
		['direction'] = "R", --Swing dir
		['hitflesh'] = "TFA_L4D2_KF2_KATANA.HitFlesh",
		['hitworld'] = "TFA_L4D2_KF2_KATANA.HitWorld"
	}
}

SWEP.Secondary.Attacks = {}


SWEP.Secondary.CanBash = true
SWEP.Secondary.BashDamage = 50
