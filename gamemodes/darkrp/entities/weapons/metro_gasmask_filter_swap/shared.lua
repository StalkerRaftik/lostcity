SWEP.Base				= "metro2033_swep_base"


SWEP.Category				= "Metro Gasmask"
SWEP.Author				= "Hobo_Gus"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.PrintName				= "FILTER SWAP"		
SWEP.Slot				= 99				
SWEP.SlotPos				= 23			
SWEP.DrawAmmo				= false		
SWEP.DrawWeaponInfoBox			= false		
SWEP.BounceWeaponIcon   		= 	false	
SWEP.DrawCrosshair			= false			
SWEP.AutoSwitchTo			= true		
SWEP.AutoSwitchFrom			= true		
SWEP.HoldType 				= "normal"		

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= true
SWEP.ViewModel				= "models/weapons/metroll/v_gasmask.mdl"
SWEP.WorldModel				= ""		
SWEP.ShowWorldModel			= false
SWEP.ShowViewModel = false

SWEP.Spawnable				= false
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false

SWEP.PrimarySound			= Sound("vsv/shoot-1.wav")			

SWEP.Primary.Damage = 30
SWEP.Primary.TakeAmmo = -1
SWEP.Primary.ClipSize = 0
SWEP.Primary.Ammo = "ar2"
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Spread = 1	
SWEP.Primary.Cone = 0.4
SWEP.IronCone = .2
SWEP.DefaultCone = 0.4
SWEP.Primary.NumberofShots = 1
SWEP.Primary.Automatic = true
SWEP.Primary.Recoil = 1.5
SWEP.Primary.Delay = 0.10
SWEP.Primary.Force = 3

SWEP.IronSights = true
SWEP.Sprint = true

SWEP.DisableMuzzle = 1

SWEP.Tracer = 6
SWEP.CustomTracerName = "Tracer"
SWEP.ShotEffect = "muzzle_riflev2"

--SWEP.SightsPos = Vector(2.7, -4.624, 1.759)
--SWEP.SightsAng = Vector(0, 0, 0)
SWEP.IronSightsPos = Vector(2.7, -4.624, 1.759)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.RunPos = Vector(-1.841, -3.386, 0.708)
SWEP.RunAng = Vector(-7.441, -41.614, 0)

SWEP.HolsterT = false

SWEP.ViewModelBoneMods = {

}

local punch = false

function SWEP:Deploy()
punch = false
self.Owner:SetNWInt("checkfilter", CurTime() + 5)
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK_EMPTY )--ACT_VM_FIDGET
	self.Owner:EmitSound("gasmask/change_filter.wav")
	--self.Owner:ViewPunch( Angle( 3,0,0 ) )
	self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() )
	self:SetHoldType( self.HoldType )	
	self.Primary.Cone = self.DefaultCone
	self.HolsterT = false
	self.Weapon:SetNWInt("Reloading", CurTime() + self:SequenceDuration() )
	self.Weapon:SetNWString( "AniamtionName", "none" )
	self.Weapon:SetNWString( "PreventNearWall", false )
	--self.Owner:SetNWInt( "breathholdtime_hg", self.BreathHoldingTime )
	timer.Simple(0.9, function() punch = true if SERVER then self.Owner:SetNWInt("FilterDuration", 240) self.Owner:SetNWInt("Filter", 1) self.Owner:RemoveItem(INV_ENTITY, "rp_gasmaskfilter") end end)
	timer.Simple(self:SequenceDuration(), function()
		if self.Weapon == nil then return end
			self.Owner:EmitSound("gasmask/watch_timer_set.wav")
			if SERVER then
				self.HolsterT = true
				if self.Owner:GetNWString("gasmask_lastwepon") != nil and self.Owner:HasWeapon(self.Owner:GetNWString("gasmask_lastwepon")) then
					self.Owner:SelectWeapon( self.Owner:GetNWString("gasmask_lastwepon") )
					self.Owner:StripWeapon( "metro_gasmask_filter_swap" )
				end
			end
	end)
	
	local ply = self.Owner
	
	return true
end

function SWEP:Think()
	if punch == true then
		self.Owner:SetViewPunchAngles( Angle(0,0,math.sin(CurTime()*10)) ) 
	end
end

function SWEP:Holster()
return self.HolsterT
end

function SWEP:PrimaryAttack()
end