-- Variables that are used on both client and server
SWEP.Gun = ("tfa_nam_m60") -- must be the name of your swep but NO CAPITALS!
SWEP.Category				= "LostCity Weapon MEDUSA" --Category where you will find your weapons
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellAttachment			= "shell"	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.Author				= "U.S.A Army"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.PrintName				= "M60 [MEDUSA Weapon]"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 2				-- Slot in the weapon selection menu
SWEP.SlotPos				= 3			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox		= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   	= false		-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= false		-- set false if you want no crosshair
SWEP.Weight					= 35		-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "ar2"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg makes for good sniper rifles

SWEP.ViewModelFOV			= 54
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/v_nam_m60.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_nam_m60.mdl"	-- Weapon world model
SWEP.Base				= "tfa_gun_base" --the Base this weapon will work on. PLEASE RENAME THE BASE! 
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false
SWEP.UseHands = true
SWEP.MoveSpeed = 0.33 --Multiply the player's movespeed by this.
SWEP.DisableChambering = true
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed  * 0.32 --Multiply the player's movespeed by this when sighting.

SWEP.Primary.Sound			= Sound("weapons/tfa_nam_m60/m60_fp.wav")
SWEP.Primary.RPM			= 689			-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 80		-- Size of a clip
SWEP.Primary.DefaultClip		= 0		-- Bullets you start with
SWEP.Primary.KickUp				= 1.19		-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.6		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.35		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= true	-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "ar2"			-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. 
--Use AirboatGun for a light metal peircing shotgun pellets
SWEP.SelectiveFire		= false
SWEP.CanBeSilenced		= false
SWEP.Bodygroups_V = nil --{
	--[0] = 1,
	--[1] = 4,
	--[2] = etc.
--}

SWEP.Secondary.IronFOV			= 70		-- How much you 'zoom' in. Less is more! 	

SWEP.data 				= {}				--The starting firemode

SWEP.Primary.Damage		= 36	-- Base damage per bullet
SWEP.Primary.Spread		= .016	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .010 -- Ironsight accuracy, should be the same for shotguns

-- Enter iron sight info and bone mod info below
SWEP.SightsPos = Vector(-1.759, -3.779, 0.66)
SWEP.SightsAng = Vector(0, 0, 0)
SWEP.InspectPos = Vector(7.76, -5.178, 0.016)
SWEP.InspectAng = Vector(1, 37.277, 3.2)

SWEP.MuzzleAttachmentSilenced = 3
SWEP.LaserSightModAttachment = 1
SWEP.LaserSightModWorldAttachment = 0
SWEP.Blowback_Shell_Effect = "RifleShellEject" --Which shell effect to use
SWEP.LuaShellEject = true --Enable shell ejection through lua?
SWEP.LuaShellEjectDelay = 0 --The delay to actually eject things
SWEP.LuaShellEffect = "RifleShellEject" --The effect used for shell ejection; Defaults to that used for blowback

SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_HYBRID -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_ANI -- ANI = mdl, HYBRID = ani + lua, Lua = lua only

SWEP.SprintAnimation = {
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "base_sprint", --Number for act, String/Number for sequence
		["value_empty"] = "empty_sprint",
		["is_idle"] = true
	}
}

SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_Spine4"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(1.297, -1.167, 0) }
}

SWEP.MuzzleAttachmentSilenced = 3
SWEP.LaserSightModAttachment = 1

SWEP.Offset = {
	Pos = {
		Up = -1.2,
		Right = 0.8,
		Forward = 2.3
	},
	Ang = {
		Up = 0,
		Right = -5.844,
		Forward = 180
	},
	Scale = 0.9
} --Procedural world model animation, defaulted for CS:S purposes.

SWEP.WElements = {
	["ref"] = { type = "Model", model = SWEP.WorldModel, bone = "oof", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = true, active = false },
}

DEFINE_BASECLASS( SWEP.Base )  -- oh i mean cool bodygroup thing ... hehe .. .

SWEP.BeltBG = 10
SWEP.BeltMax = 9

SWEP.EventTable = {
	[ACT_VM_RELOAD] = {
		{ ["time"] = 100 / 31.5, ["type"] = "lua", ["value"] = function(self)
			self.Bodygroups_V[ self.BeltBG ] = math.Clamp( self:Ammo1() + self:Clip1(), 0, self.BeltMax )
		end}
	},
	[ACT_VM_RELOAD_DEPLOYED] = {
		{ ["time"] = 100 / 31.5, ["type"] = "lua", ["value"] = function(self)
			self.Bodygroups_V[ self.BeltBG ] = math.Clamp( self:Ammo1() + self:Clip1(), 0, self.BeltMax )
		end}
	},
	[ACT_VM_RELOAD_EMPTY] = {
		{ ["time"] = 140 / 31.5, ["type"] = "lua", ["value"] = function(self)
			self.Bodygroups_V[ self.BeltBG ] = math.Clamp( self:Ammo1() + self:Clip1(), 0, self.BeltMax )
		end}
	}
}

function SWEP:Think2( ... )
	if self:GetStatus() ~= TFA.GetStatus("reloading") then
		self.Bodygroups_V[ self.BeltBG ] = math.Clamp( self:Clip1(), 0, self.BeltMax )
	end
	return BaseClass.Think2( self, ... )
end

function SWEP:ChooseReloadAnim( ... )
	if self:Clip1() > 0 and self:Clip1() < self.BeltMax  then
		return self:SendViewModelAnim(ACT_VM_RELOAD_DEPLOYED)
	else
		return BaseClass.ChooseReloadAnim( self, ... )
	end
end