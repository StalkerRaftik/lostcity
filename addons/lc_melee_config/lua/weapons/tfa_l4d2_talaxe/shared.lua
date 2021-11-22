SWEP.Base = "tfa_melee_base"
SWEP.Category = "LostCity Edged Weapons"
SWEP.PrintName = "Складной топор [Edged Weapons]"
SWEP.ViewModel = "models/weapons/tfa_l4d2/c_talosaxe.mdl"
SWEP.ViewModelFOV = 65
SWEP.VMPos = Vector(0, -1, -1)
SWEP.UseHands = true
SWEP.CameraOffset = Angle(0, -2, 0)
SWEP.InspectPos = Vector(-0.952, -17.069, -11.044) - SWEP.VMPos
SWEP.InspectAng = Vector(70, -0.413, 0.788)
SWEP.WorldModel = "models/weapons/tfa_l4d2/w_talosaxe.mdl"
SWEP.HoldType = "melee2"
SWEP.Primary.Directional = true
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.DisableIdleAnimations = false

SWEP.Primary.Attacks = {
	{
		['act'] = ACT_VM_HITLEFT, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		['len'] = 16 * 4, -- Trace distance
		['dir'] = Vector(-35, 0, 40), -- Trace arc cast
		['dmg'] = 56, --Damage
		['dmgtype'] = DMG_SLASH, --DMG_SLASH,DMG_CRUSH, etc.
		['delay'] = 0.45, --Delay
		['spr'] = true, --Allow attack while sprinting?
		['snd'] = "TFA_L4D2_TALOSAXE.Swing", -- Sound ID
		['snd_delay'] = 0.2,
		["viewpunch"] = Angle(-5, 5, 0), --viewpunch angle
		['end'] = 0.95, --time before next attack
		['hull'] = 16, --Hullsize
		['direction'] = "LB", --Swing dir,
		['hitflesh'] = "TFA_L4D2_TALOSAXE.HitFlesh",
		['hitworld'] = "TFA_L4D2_TALOSAXE.HitWorld"
	},
	{
		['act'] = ACT_VM_HITRIGHT, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		['len'] = 16 * 4, -- Trace distance
		['dir'] = Vector(35, 0, 40), -- Trace arc cast
		['dmg'] = 63, --Damage
		['dmgtype'] = DMG_SLASH, --DMG_SLASH,DMG_CRUSH, etc.
		['delay'] = 0.35, --Delay
		['spr'] = true, --Allow attack while sprinting?
		['snd'] = "TFA_L4D2_TALOSAXE.Swing", -- Sound ID
		['snd_delay'] = 0.2,
		["viewpunch"] = Angle(-5, -5, 0), --viewpunch angle
		['end'] = 0.95, --time before next attack
		['hull'] = 16, --Hullsize
		['direction'] = "RB", --Swing dir,
		['hitflesh'] = "TFA_L4D2_TALOSAXE.HitFlesh",
		['hitworld'] = "TFA_L4D2_TALOSAXE.HitWorld"
	},
	{
		['act'] = ACT_VM_SWINGHARD, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		['len'] = 16 * 4, -- Trace distance
		['dir'] = Vector(-35, 0, -35), -- Trace arc cast
		['dmg'] = 69, --Damage
		['dmgtype'] = DMG_SLASH, --DMG_SLASH,DMG_CRUSH, etc.
		['delay'] = 0.375, --Delay
		['spr'] = true, --Allow attack while sprinting?
		['snd'] = "TFA_L4D2_TALOSAXE.Swing", -- Sound ID
		['snd_delay'] = 0.2,
		["viewpunch"] = Angle(5, 5, 0), --viewpunch angle
		['end'] = 0.95, --time before next attack
		['hull'] = 16, --Hullsize
		['direction'] = "L", --Swing dir,
		['hitflesh'] = "TFA_L4D2_TALOSAXE.HitFlesh",
		['hitworld'] = "TFA_L4D2_TALOSAXE.HitWorld"
	},
	{
		['act'] = ACT_VM_SWINGMISS, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		['len'] = 16 * 4, -- Trace distance
		['dir'] = Vector(35, 0, -35), -- Trace arc cast
		['dmg'] = 150, --Damage
		['dmgtype'] = DMG_SLASH, --DMG_SLASH,DMG_CRUSH, etc.
		['delay'] = 0.375, --Delay
		['spr'] = true, --Allow attack while sprinting?
		['snd'] = "TFA_L4D2_TALOSAXE.Swing", -- Sound ID
		['snd_delay'] = 0.2,
		["viewpunch"] = Angle(5, -5, 0), --viewpunch angle
		['end'] = 0.95, --time before next attack
		['hull'] = 16, --Hullsize
		['direction'] = "R", --Swing dir,
		['hitflesh'] = "TFA_L4D2_TALOSAXE.HitFlesh",
		['hitworld'] = "TFA_L4D2_TALOSAXE.HitWorld"
	},
	{
		['act'] = ACT_VM_MISSRIGHT, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		['len'] = 16 * 4, -- Trace distance
		['dir'] = Vector(65, 0, 0), -- Trace arc cast
		['dmg'] = 150, --Damage
		['dmgtype'] = DMG_SLASH, --DMG_SLASH,DMG_CRUSH, etc.
		['delay'] = 0.375, --Delay
		['spr'] = true, --Allow attack while sprinting?
		['snd'] = "TFA_L4D2_TALOSAXE.Swing", -- Sound ID
		['snd_delay'] = 0.2,
		["viewpunch"] = Angle(1, -10, 0), --viewpunch angle
		['end'] = 0.95, --time before next attack
		['hull'] = 16, --Hullsize
		['direction'] = "R", --Swing dir,
		['hitflesh'] = "TFA_L4D2_TALOSAXE.HitFlesh",
		['hitworld'] = "TFA_L4D2_TALOSAXE.HitWorld"
	},
	{
		['act'] = ACT_VM_MISSLEFT, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		['len'] = 16 * 4, -- Trace distance
		['dir'] = Vector(-65, 0, 0), -- Trace arc cast
		['dmg'] = 150, --Damage
		['dmgtype'] = DMG_SLASH, --DMG_SLASH,DMG_CRUSH, etc.
		['delay'] = 0.375, --Delay
		['spr'] = true, --Allow attack while sprinting?
		['snd'] = "TFA_L4D2_TALOSAXE.Swing", -- Sound ID
		['snd_delay'] = 0.2,
		["viewpunch"] = Angle(1, 10, 0), --viewpunch angle
		['end'] = 0.95, --time before next attack
		['hull'] = 16, --Hullsize
		['direction'] = "L", --Swing dir,
		['hitflesh'] = "TFA_L4D2_TALOSAXE.HitFlesh",
		['hitworld'] = "TFA_L4D2_TALOSAXE.HitWorld"
	},
	{
		['act'] = ACT_VM_HITCENTER2, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		['len'] = 16 * 4.25, -- Trace distance
		['dir'] = Vector(0 , 25, -55), -- Trace arc cast
		['dmg'] = 150, --Damage
		['dmgtype'] = DMG_SLASH, --DMG_SLASH,DMG_CRUSH, etc.
		['delay'] = 0.375, --Delay
		['spr'] = true, --Allow attack while sprinting?
		['snd'] = "TFA_L4D2_TALOSAXE.Swing", -- Sound ID
		['snd_delay'] = 0.2,
		["viewpunch"] = Angle(10, -1, 0), --viewpunch angle
		['end'] = 0.95, --time before next attack
		['hull'] = 16, --Hullsize
		['direction'] = "F", --Swing dir,
		['hitflesh'] = "TFA_L4D2_TALOSAXE.HitFlesh",
		['hitworld'] = "TFA_L4D2_TALOSAXE.HitWorld"
	},
	{
		['act'] = ACT_VM_MISSCENTER, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		['len'] = 16 * 4.25, -- Trace distance
		['dir'] = Vector(0 , 25, -55), -- Trace arc cast
		['dmg'] = 150, --Damage
		['dmgtype'] = DMG_SLASH, --DMG_SLASH,DMG_CRUSH, etc.
		['delay'] = 0.375, --Delay
		['spr'] = true, --Allow attack while sprinting?
		['snd'] = "TFA_L4D2_TALOSAXE.Swing", -- Sound ID
		['snd_delay'] = 0.2,
		["viewpunch"] = Angle(10, -1, 0), --viewpunch angle
		['end'] = 0.95, --time before next attack
		['hull'] = 16, --Hullsize
		['direction'] = "F", --Swing dir,
		['hitflesh'] = "TFA_L4D2_TALOSAXE.HitFlesh",
		['hitworld'] = "TFA_L4D2_TALOSAXE.HitWorld"
	}
}

SWEP.Secondary.Attacks = {}
SWEP.Secondary.CanBash = true
SWEP.Secondary.BashDamage = 30

SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_R_Finger1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 5, 0) },
	["ValveBiped.Bip01_R_Finger2"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 15, 0) },
	["ValveBiped.Bip01_R_Finger21"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 10, 0) },
	["ValveBiped.Bip01_R_Finger3"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(4.943, 13.078, -2.875) },
	["ValveBiped.Bip01_R_Finger31"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 10, 0) },
	["ValveBiped.Bip01_R_Finger4"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 25.33, 10.729) },
	["ValveBiped.Bip01_R_Finger41"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 6.151, 0) }
}
