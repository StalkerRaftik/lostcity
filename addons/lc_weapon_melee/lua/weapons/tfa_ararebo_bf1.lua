SWEP.Category				= "LostCity Edged Weapons"
SWEP.Author				= "The Master MLG"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.PrintName				= "Ararebo [Edged Weapons]"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 0				-- Slot in the weapon selection menu
SWEP.SlotPos				= 27			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= false		-- set false if you want no crosshair
SWEP.Weight				= 30			-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "melee2"		-- how others view you carrying the weapon
SWEP.Type = "Melee"
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/v_ararebo_bf1.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_ararebo.mdl"	-- Weapon world model
SWEP.ShowWorldModel			= true
SWEP.Base				= "tfa_knife_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false

SWEP.Offset = {
	Pos = {
		Up = 0.25,
		Right = 0.5,
		Forward = 4
	},
	Ang = {
		Up = -1,
		Right = -15,
		Forward = 178
	},
	Scale = 1.0
}

SWEP.ViewModelFOV			= 89		-- This controls how big the viewmodel looks.  Less is more.
SWEP.ViewModelFlip			= false		-- Set this to true for CSS models, or false for everything else (with a righthanded viewmodel.)
SWEP.UseHands = true --Use gmod c_arms system.

SWEP.SlashTable = {"base_attack_1", "base_attack_2"} --Table of possible hull sequences
SWEP.StabTable = {"base_attack_3"} --Table of possible hull sequences
SWEP.StabMissTable = {"base_attack_3"} --Table of possible hull sequences

SWEP.Primary.RPM = 75 --Primary Slashs per minute
SWEP.Secondary.RPM = 50 --Secondary stabs per minute
SWEP.Primary.Delay = 0.3 --Delay for hull (primary)
SWEP.Secondary.Delay = 0.4 --Delay for hull (secondary)
SWEP.Primary.Damage = 68
SWEP.Secondary.Damage = 105

SWEP.Primary.Ammo = ""
SWEP.Primary.ClipSize = -1

SWEP.Primary.Sound = Sound("weapons/trench_club/weapon_melee_01.wav") --Sounds
SWEP.KnifeShink = Sound("weapons/trench_club/melee_bash_hitworld_01.wav")
SWEP.KnifeSlash = Sound("weapons/trench_club/melee_bash_hit_flesh_06.wav")
SWEP.KnifeStab = Sound("weapons/trench_club/melee_bash_hit_flesh_06.wav")

SWEP.ViewModelBoneMods = {
        ["R Hand"] = { scale = Vector(0.8, 0.8, 0.8), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
        ["L Hand"] = { scale = Vector(0.8, 0.8, 0.8), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}

SWEP.Primary.Length = 95
SWEP.Secondary.Length = 95

SWEP.VMPos = Vector(0,0,0)
SWEP.VMAng = Vector(0,0,0)

--
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_ANI -- ANI = mdl, HYBRID = ani + lua, Lua = lua only

SWEP.SprintAnimation = {
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "base_sprint", --Number for act, String/Number for sequence
		["is_idle"] = true
	}
}

SWEP.InspectPos 				= Vector(4, -3.619, -2.987)
SWEP.InspectAng 				= Vector(22.386, 34.417, 5)
