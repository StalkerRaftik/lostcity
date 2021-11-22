local hudcolor = Color(255, 255, 255, 255)

if killicon and killicon.Add then
	killicon.Add("tfa_shovel", "vgui/hud/kill/tfa_shovel", hudcolor)
end

if IsMounted( "left4dead2" ) then

	SWEP.Base = "tfa_melee_base"
	SWEP.Category = "LostCity Edged Weapons"
	SWEP.PrintName = "Лопата [Edged Weapons]"
	SWEP.Manufacturer = "L4D2 Community Update Team"
	SWEP.ViewModel = "models/weapons/melee/v_shovel.mdl"
	SWEP.ViewModelFOV = 60 -- L4D2 default is 51
	SWEP.VMPos = Vector(-1, -2, -1)
	SWEP.UseHands = true
	SWEP.CameraOffset = Angle(0, 0, 0)
	SWEP.WorldModel = "models/weapons/melee/w_shovel.mdl"
	SWEP.HoldType = "melee2"
	SWEP.Primary.Directional = true
	SWEP.Spawnable = true
	SWEP.AdminOnly = false
	SWEP.DisableIdleAnimations = false
	
	SWEP.Primary.Attacks = {
		{
			["act"] = ACT_VM_PRIMARYATTACK, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
			["len"] = 16 * 4.5, -- Trace distance
			["dir"] = Vector(100, 0, 0), -- Trace arc cast
			["dmg"] = 34 * 1, --Damage
			["dmgtype"] = DMG_SLASH, --DMG_SLASH,DMG_CRUSH, etc.
			["delay"] = 0.2, --Delay
			["spr"] = true, --Allow attack while sprinting?
			["snd"] = "Shovel.Miss", -- Sound ID
			["snd_delay"] = 0.2,
			["viewpunch"] = Angle(1, -1, 0), --viewpunch angle
			["end"] = 0.9, --time before next attack
			["hull"] = 16, --Hullsize
			["direction"] = "L", --Swing dir,
			["hitflesh"] = "Shovel.ImpactFlesh",
			["hitworld"] = "Shovel.ImpactWorld",
			["combotime"] = 0.1
		},
		{
			["act"] = ACT_VM_HITLEFT, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
			["len"] = 16 * 4.5, -- Trace distance
			["dir"] = Vector(-75, 0, 0), -- Trace arc cast
			["dmg"] = 40 * 1, --Damage
			["dmgtype"] = DMG_SLASH, --DMG_SLASH,DMG_CRUSH, etc.
			["delay"] = 0.2, --Delay
			["spr"] = true, --Allow attack while sprinting?
			["snd"] = "Shovel.Miss", -- Sound ID
			["snd_delay"] = 0.2,
			["viewpunch"] = Angle(1, 5, 0), --viewpunch angle
			["end"] = 0.9, --time before next attack
			["hull"] = 16, --Hullsize
			["direction"] = "L", --Swing dir,
			["hitflesh"] = "Shovel.ImpactFlesh",
			["hitworld"] = "Shovel.ImpactWorld",
			["combotime"] = 0.1
		},
		{
			["act"] = ACT_VM_PRIMARYATTACK, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
			["len"] = 16 * 4.5, -- Trace distance
			["dir"] = Vector(0, 30, 10), -- Trace arc cast
			["dmg"] = 40 * 1, --Damage
			["dmgtype"] = DMG_SLASH, --DMG_SLASH,DMG_CRUSH, etc.
			["delay"] = 0.2, --Delay
			["spr"] = true, --Allow attack while sprinting?
			["snd"] = "Shovel.Miss", -- Sound ID
			["snd_delay"] = 0.2,
			["viewpunch"] = Angle(-5, 0, 2), --viewpunch angle
			["end"] = 0.9, --time before next attack
			["hull"] = 16, --Hullsize
			["direction"] = "L", --Swing dir,
			["hitflesh"] = "Shovel.ImpactFlesh",
			["hitworld"] = "Shovel.ImpactWorld"
		}
	}

	SWEP.Secondary.Attacks = {
	{
			["act"] = ACT_VM_SECONDARYATTACK, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
			["len"] = 16 * 4.5, -- Trace distance
			["dir"] = Vector(0, 20, -70), -- Trace arc cast
			["dmg"] = 10, --Damage
			["dmgtype"] = DMG_CRUSH, --DMG_SLASH,DMG_CRUSH, etc.
			["delay"] = 0.3, --Delay
			["spr"] = true, --Allow attack while sprinting?
			["snd"] = "Weapon.Swing", -- Sound ID
			["snd_delay"] = 0.3,
			["viewpunch"] = Angle(5, 0, 0), --viewpunch angle
			["end"] = 0.9, --time before next attack
			["hull"] = 16, --Hullsize
			["direction"] = "F", --Swing dir,
			["hitflesh"] = "Weapon.HitInfected",
			["hitworld"] = "Melee.HitWorld",
			["combotime"] = 0.1
		}
	}

	SWEP.AllowSprintAttack = true

	-- SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_HYBRID-- ANI = mdl, Hybrid = ani + lua, Lua = lua only
	-- SWEP.SprintAnimation = {
		-- ["loop"] = {
			-- ["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
			-- ["value"] = "sprint_loop", --Number for act, String/Number for sequence
			-- ["is_idle"] = true
		-- },--looping animation
		-- ["out"] = {
			-- ["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
			-- ["value"] = "sprint_out", --Number for act, String/Number for sequence
			-- ["transition"] = true
		-- } --Outward transition
	-- }
	SWEP.RunSightsPos = Vector(0, 0, 0)
	SWEP.RunSightsAng = Vector(-10, -2.5, 2.5)


	SWEP.CanBlock = false
	-- SWEP.BlockAnimation = {
		-- ["in"] = {
			-- ["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
			-- ["value"] = ACT_VM_DEPLOY, --Number for act, String/Number for sequence
			-- ["transition"] = true
		-- }, --Inward transition
		-- ["loop"] = {
			-- ["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
			-- ["value"] = ACT_VM_IDLE_DEPLOYED, --Number for act, String/Number for sequence
			-- ["is_idle"] = true
		-- },--looping animation
		-- ["hit"] = {
			-- ["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
			-- ["value"] = ACT_VM_RELOAD_DEPLOYED, --Number for act, String/Number for sequence
			-- ["is_idle"] = true
		-- },--when you get hit and block it
		-- ["out"] = {
			-- ["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
			-- ["value"] = ACT_VM_UNDEPLOY, --Number for act, String/Number for sequence
			-- ["transition"] = true
		-- } --Outward transition
	-- }
	SWEP.BlockCone = 100 --Think of the player's view direction as being the middle of a sector, with the sector's angle being this
	SWEP.BlockDamageMaximum = 0.0 --Multiply damage by this for a maximumly effective block
	SWEP.BlockDamageMinimum = 0.5 --Multiply damage by this for a minimumly effective block
	SWEP.BlockTimeWindow = 0.5 --Time to absorb maximum damage
	SWEP.BlockTimeFade = 0.5 --Time for blocking to do minimum damage.  Does not include block window
	SWEP.BlockSound = "Melee.HitWorld"
	SWEP.BlockDamageCap = 80
	SWEP.BlockDamageTypes = {
		DMG_SLASH,DMG_CLUB
	}

	SWEP.Secondary.CanBash = true
	SWEP.Secondary.BashDamage = 60
	SWEP.Secondary.BashDelay = 0.1
	SWEP.Secondary.BashLength = 16 * 3

	SWEP.SequenceLengthOverride = {
		[ACT_VM_HITCENTER] = 0.8
	}

	SWEP.ViewModelBoneMods = {
			["ValveBiped.weapon_bone"] = {
			scale = Vector(1, 1, 1),
			pos = Vector(0, 0, 0),
			angle = Angle(0, 0, 0)
		},
			["ValveBiped.Bip01_L_thumbroot"] = {
			scale = Vector(1, 1, 1),
			pos = Vector(0, 0, 0),
			angle = Angle(0, 0, 180)
		},
			["ValveBiped.Bip01_L_Finger0"] = {
			scale = Vector(1, 1, 1),
			pos = Vector(0, 0, 0),
			angle = Angle(-10, 5, 180)
		},
			["ValveBiped.Bip01_L_Finger01"] = {
			scale = Vector(1, 1, 1),
			pos = Vector(0, 0, 0),
			angle = Angle(0, 90, 0)
		},
			["ValveBiped.Bip01_L_Finger02"] = {
			scale = Vector(1, 1, 1),
			pos = Vector(0, 0, 0),
			angle = Angle(0, 90, 0)
		},
			["ValveBiped.Bip01_R_thumbroot"] = {
			scale = Vector(1, 1, 1),
			pos = Vector(0, 0, 0),
			angle = Angle(0, 0, 180)
		},	
			["ValveBiped.Bip01_R_Finger0"] = {
			scale = Vector(1, 1, 1),
			pos = Vector(0, 0, 0),
			angle = Angle(0, 25, 180)
		},
			["ValveBiped.Bip01_R_Finger01"] = {
			scale = Vector(1, 1, 1),
			pos = Vector(0, 0, 0),
			angle = Angle(-10, 110, 0)
		},
			["ValveBiped.Bip01_R_Finger02"] = {
			scale = Vector(1, 1, 1),
			pos = Vector(0, 0, 0),
			angle = Angle(0, 65, 0)
		}
	}
end