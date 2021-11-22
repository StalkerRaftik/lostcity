-- Variables that are used on both client and server
SWEP.Gun = ("tfa_gtav_railgun")					-- must be the name of your swep
if (GetConVar(SWEP.Gun.."_allowed")) != nil then
	if not (GetConVar(SWEP.Gun.."_allowed"):GetBool()) then SWEP.Base = "tfa_blacklisted" SWEP.PrintName = SWEP.Gun return end
end
SWEP.Category				= "LostCity Weapon DWZ"
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "Railgun [DWZ Weapon]"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 1				-- Slot in the weapon selection menu
SWEP.SlotPos				= 73		-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= false		-- set false if you want no crosshair
SWEP.Weight				= 30			-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "ar2"		-- how others view you carrying the weapon
SWEP.UseHands = true

SWEP.ViewModelFOV			= 65
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/c_tfa_gtav_railgun.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_tfa_gtav_railgun.mdl"	-- Weapon world model
SWEP.Base				= "tfa_gun_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false

SWEP.Primary.Sound			= Sound("TFA_GTAV_Railgun.1")		-- Script that calls the primary fire sound
SWEP.Primary.RPM			= 1 			-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 1		-- Size of a clip
SWEP.Primary.DefaultClip		= 0		-- Bullets you start with
SWEP.Primary.KickUp				= 2		-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.9		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.0		-- Maximum up recoil (stock)
SWEP.Primary.StaticRecoilFactor  = 1.45 
SWEP.Primary.Automatic			= false		-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "ar2"

SWEP.MoveSpeed = 0.185 --Multiply the player's movespeed by this.
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed  * 0.02 --Multiply the player's movespeed by this when sighting.

SWEP.Secondary.IronFOV			= 45		-- How much you 'zoom' in. Less is more! 	

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 1

SWEP.Primary.NumShots	= 1		-- How many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 4000	-- Base damage per bullet
SWEP.Primary.Spread		= .00001	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .00001 -- Ironsight accuracy, should be the same for shotguns

-- Enter iron sight info and bone mod info below

SWEP.SightsPos = Vector(-2.681-0.4, -3, 0.039+1)
SWEP.SightsAng = Vector(0.1, 0, 0)
SWEP.RunSightsPos = Vector(12.255, -10.433, 4.02)
SWEP.RunSightsAng = Vector(7.034, 83, 25.848)
SWEP.InspectPos = Vector(24.6, -12.473, 9.079)
SWEP.InspectAng = Vector(85, 63.317, 95)

SWEP.DisableIdleAnimations = false
SWEP.InspectionLoop = true --Setting false will cancel inspection once the animation is done.  CS:GO style.
SWEP.ForceEmptyFireOff = true

SWEP.Primary.Range = 100/0.305*16*1000

SWEP.Primary.SpreadIncrement = 1
SWEP.Primary.SpreadRecovery = 4
SWEP.Primary.SpreadMultiplierMax = 4

SWEP.CustomMuzzleFlash = true
SWEP.AutoDetectMuzzleAttachment = false
SWEP.MuzzleFlashEffect = "tfa_muzzleflash_energy" --Change to a string of your muzzle flash effect

SWEP.AllowViewAttachment = true

SWEP.DamageType = bit.bor(DMG_SHOCK,DMG_BURN,DMG_BLAST)--bit.bor(DMG_DISSOLVE,DMG_BURN,DMG_SHOCK)

SWEP.VMPos = Vector(0.4, -2, -1)
SWEP.VMAng = Vector(0, 0, 0)

SWEP.DisableChambering = true

SWEP.EventTable = {
	[ACT_VM_RELOAD] = {
		{ ['time'] = 0.3, ['type'] = "sound", ['value'] = "TFA_GTAV_Railgun.Tonal", ['client'] = true, ['server'] = false },
		{ ['time'] = 1.5, ['type'] = "sound", ['value'] = "TFA_GTAV_Railgun.Bright", ['client'] = true, ['server'] = false }
	}
}

SWEP.Offset = {
        Pos = {
        Up = -4.5,
        Right = 0.6,
        Forward = 14,
        },
        Ang = {
        Up = -1,
        Right = -3,
        Forward = 178
        },
		Scale = 0.7
}

SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_L_Wrist"] = { scale = Vector(1, 0.8, 1), pos = Vector(0, 0, 0), angle = Angle(1.544, 4.635, -45.439) },
	["ValveBiped.Bip01_L_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, -30.907) },
	["Left2"] = { scale = Vector(0.7, 1, 1), pos = Vector(0, -0, 0), angle = Angle(0, 5, 0) },
	["Left1"] = { scale = Vector(0.7, 1, 1), pos = Vector(0.3, 0, -0.1), angle = Angle(-9.814,-2.636, 30.086) },
	["ValveBiped.Bip01_L_Finger0"] = { scale = Vector(1.2, 1.2, 1.2), pos = Vector(-0.258, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_Finger01"] = { scale = Vector(1.2, 1.2, 1.2), pos = Vector(0, 0.2, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_Finger02"] = { scale = Vector(1.2, 1.2, 1.2), pos = Vector(0, 0.1, 0), angle = Angle(20, 30, 10) }
}

SWEP.RailIsEmptyOld = false

local greencol = Color(0,200,0,255)

local redcol = Color(200,0,0,255)

SWEP.RTMaterialOverride = 2

SWEP.RTOpaque = true

SWEP.RTCode = function( self, mat )
	local empty = (self:Clip1()<=0)
	render.OverrideAlphaWriteEnable( true, true)
	surface.SetDrawColor( empty and redcol or greencol )
	surface.DrawRect(-512,-512,1024,1024)
end

function SWEP:Think()

	local empty = (self:Clip1()<=0)	
	if self.RailIsEmptyOld != empty then
		self:SetSkin( empty and 1 or 0)
	end
	self.RailIsEmptyOld = empty

end