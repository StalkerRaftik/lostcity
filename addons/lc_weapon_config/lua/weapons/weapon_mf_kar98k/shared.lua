-- Variables that are used on both client and server
SWEP.Gun = ("tfa_winchester73") -- must be the name of your swep but NO CAPITALS!

SWEP.Category				= "LostCity Weapon Third SR"
SWEP.Author				= "Zayn"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "Kar-98k [Third SR]"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 2				-- Slot in the weapon selection menu
SWEP.SlotPos				= 41			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= false		-- set false if you want no crosshair
SWEP.Weight				= 3			-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "ar2"	-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= true
SWEP.ViewModel				= "models/weapons/v_swep_kar.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_swep_kar.mdl"	-- Weapon world model
SWEP.Base 				= "tfa_shotty_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.Primary.Sound			= Sound("Weapon_Kar.Single")		-- script that calls the primary fire sound
SWEP.Primary.RPM				= 66		-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 1			-- Size of a clip
SWEP.Primary.DefaultClip			= 0	-- Default number of bullets in a clip
SWEP.Primary.KickUp			= 1.2				-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.86		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal			= 0.1	-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= false		-- Automatic/Semi Auto
SWEP.Primary.Ammo			= "AirboatGun"	-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.Secondary.IronFOV			= 60		-- How much you 'zoom' in. Less is more! 
SWEP.ShellTime			= .54

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 1

SWEP.Primary.NumShots	= 1		-- How many bullets to shoot per trigger pull, AKA pellets
SWEP.Primary.Damage		= 43	-- Base damage per bullet
SWEP.Primary.Spread		= .03	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .023	-- Ironsight accuracy, should be the same for shotguns
-- Because irons don't magically give you less pellet spread!, but this isn't a shotgun so whatever, man!

-- Enter iron sight info and bone mod info below
SWEP.ViewAnimAngleFix = Angle(0,0,0)
SWEP.NewOriginPos 		= Vector (0, 0, 0)
SWEP.NewOriginAng		= Vector (0, 0, 0)
SWEP.IronSightsPos = Vector (1.8241, 0, 1.5131)
SWEP.IronSightsAng = Vector (0.4909, 0.2073, 0)
SWEP.RunArmOffset = Vector (-3.3304, 0, -0.1625)
SWEP.RunArmAngle = Vector (-19.595, -23.3951, 0)
SWEP.RunSightsPos = Vector (-2.3095, -3.0514, 2.3965)
SWEP.RunSightsAng = Vector (-19.8471, -33.9181, 10)

function SWEP:DrawWorldModel()

	local hand, offset, rotate

	if not IsValid(self.Owner) then
		self:DrawModel()
		return
	end

	hand = self.Owner:GetAttachment(self.Owner:LookupAttachment("anim_attachment_rh"))

	offset = hand.Ang:Right() * 1 + hand.Ang:Forward() * -2 + hand.Ang:Up() * 1

	hand.Ang:RotateAroundAxis(hand.Ang:Right(), 10)
	hand.Ang:RotateAroundAxis(hand.Ang:Forward(), 10)
	hand.Ang:RotateAroundAxis(hand.Ang:Up(), 0)

	self:SetRenderOrigin(hand.Pos + offset)
	self:SetRenderAngles(hand.Ang)

	self:DrawModel()

	if (CLIENT) then
		self:SetModelScale(1,1,1)
	   end
	end 

SWEP.ViewModelBoneMods = {
	["shell"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}

SWEP.FireModeName = "Bolt-Action"

if (gmod.GetGamemode().Name == "Murderthon 9000") then

	SWEP.Slot		= 1				-- Slot in the weapon selection menu
	SWEP.Weight		= 3			-- rank relative ot other weapons. bigger is better

end

if GetConVar("sv_tfa_default_clip") == nil then
	print("sv_tfa_default_clip is missing!  You might've hit the lua limit.  Contact the SWEP author(s).")
else
	if GetConVar("sv_tfa_default_clip"):GetInt() != -1 then
		SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * GetConVar("sv_tfa_default_clip"):GetInt()
	end
end

if GetConVar("sv_tfa_unique_slots") != nil then
	if not (GetConVar("sv_tfa_unique_slots"):GetBool()) then 
		SWEP.SlotPos = 2
	end
end