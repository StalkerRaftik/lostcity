
if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
end

SWEP.Base 					 =      "weapon_modify_base"

SWEP.PrintName	             =      "Наручники"			
SWEP.Author			         =      ""
SWEP.Instructions		     =      ""
SWEP.Purpose 		         =      ""

SWEP.Spawnable               =      true
SWEP.AdminOnly               =      false

SWEP.Primary.ClipSize		 =      -1
SWEP.Primary.DefaultClip	 =      -1
SWEP.Primary.Automatic		 =      false
SWEP.Primary.Ammo		     =      "none"

SWEP.Secondary.ClipSize		 =      -1
SWEP.Secondary.DefaultClip	 =      -1
SWEP.Secondary.Automatic	 =      false
SWEP.Secondary.Ammo		     =      "none"

--Misc Settings
SWEP.Weight			         =      5
SWEP.AutoSwitchTo		     =      true
SWEP.AutoSwitchFrom		     =      true
SWEP.Slot			         =      3
SWEP.SlotPos			     =      2
SWEP.DrawAmmo			     =      false
SWEP.DrawCrosshair		     =      false
SWEP.FiresUnderwater         =      false

SWEP.HoldType 				= "duel"
SWEP.ViewModelFOV 			= 70
SWEP.ViewModelFlip 			= false
SWEP.ViewModel 				= "models/katharsmodels/handcuffs/handcuffs-1.mdl"
SWEP.WorldModel 			= "models/katharsmodels/handcuffs/handcuffs-1.mdl"

SWEP.HoldPos 				= Vector( 0, 1, 0 )
SWEP.HoldAng 				= Vector( -20, 0, 15 )

SWEP.ViewAng 				= Vector( 0, -10, 0 )
SWEP.ViewPos 				= Vector( 5, 10, -3 )

SWEP.TimeToCuff = 2 // 5 seconds to cuff

function SWEP:OnHit( ent )
	if (ent:GetClass() == "prop_ragdoll" and ent.RagdollPlayer) then
		if ( !self:CanCuffTarget( ent ) ) then return end
		self:SetNWEntity( "cuffing", ent )
		self:SetNWInt( "cuffing_time", CurTime() + self.TimeToCuff )
		return
	end
	print(1)
	if ( !ent:IsPlayer() ) then return end
	print(2)
	local wep = ent:isZiptied()
	if IsValid(wep) then
		wep:Break()
		return
	end
	print(3)
	if ( IsValid( self:GetNWEntity("cuffing") ) ) then return end
	
	local wep = ent:isHandcuffed()
	if IsValid(wep) then
		wep:Break( self )
		return
	end
	print(4)
	if ( !self:CanCuffTarget( ent ) ) then return end
	print(5)
	if ( self.Owner:getNumHandcuffed() >= 5 ) then
		self.Owner:ChatPrint( "Вы можете арестовывать только 5 человек одновременно" )
		return
	end
	print(6)
 	self:SetNWEntity( "cuffing", ent )
	self:SetNWInt( "cuffing_time", CurTime() + self.TimeToCuff )
end

function SWEP:StopCuff()
	self:SetNWEntity( "cuffing", NULL )
	self:SetNWInt( "cuffing_time", 0 )
end	

local box_w = 200
local box_h = 40

function SWEP:DrawHUD()
	local time = self:GetNWInt( "cuffing_time" )
	
	if ( time > CurTime() ) then
		local perc = 1 - ( ( time - CurTime() ) / self.TimeToCuff )
		
		local x = ( ScrW()/2 ) - ( box_w/2 )
		local y = ScrH() - box_h*2
		
		draw.RoundedBox( 0, x, y, box_w, box_h, Color( 0, 0, 0, 200 ) )
		draw.RoundedBox( 0, x+2, y+2, (box_w-4)*perc, box_h-4, Color( 230, 60, 60 ) )
		draw.SimpleText( "Надеваю наручники", "font_base_24", (box_w/2) + x, (box_h/2)+y, color_white, 1, 1 )
	end
end

function SWEP:Holster()
	if ( SERVER ) then 
		self:StopCuff()
	end
	
	return true
end

function SWEP:FinishCuff()
	local target = self:GetNWEntity( "cuffing" )
	
	if ( IsValid( target ) ) then
		if (target:GetClass() == "prop_ragdoll" and target.RagdollPlayer) then
			target.RagdollPlayer.m_bWasCuffed = true
		else
			local wep = target:Give( "weapon_handcuffed" )
			wep.handcuffer = self.Owner
			target:SetActiveWeapon( target:GetWeapon("weapon_handcuffed") )
			hook.Call( "GamemodePlayerDragCuffedPlayer", GAMEMODE, self.Owner, target )
			self:SetNWEntity("Dragging", target)
		end
	end
	
	self:EmitSound("items/ammocrate_close.wav", 65)
	self:StopCuff()
end

function SWEP:CanCuffTarget( ent )
	if (ent:GetClass() == "prop_ragdoll" and ent.RagdollPlayer) then
		return not ent.RagdollPlayer.m_bWasCuffed
	end

	if ( ent:HasWeapon( "weapon_handcuffed" ) ) then 
		return false
	end
	
	if ( ent:GetPos():Distance( self.Owner:GetPos() ) >= 150 ) then
		return false 
	end
	
	return true
end

function SWEP:Think()
	if ( CLIENT ) then return end
	
	local target = self:GetNWEntity( "cuffing" )
	
	if ( IsValid( target ) ) then		
		if ( !self:CanCuffTarget( target ) ) then
			self:StopCuff()
		else
			local time = self:GetNWInt( "cuffing_time" ) 
		
			if ( time < CurTime() ) then
				self:FinishCuff()
			end
		end
	end
	
	self:NextThink( CurTime() + 1 )
	return true
end

function SWEP:SecondaryAttack()
	self:SetNextSecondaryFire( CurTime() + self.PrimaryWait )
	
	if ( CLIENT ) then return end
	
	local ent = self.Owner:GetEyeTrace().Entity
	
	if ( !IsValid( ent ) or ent:GetPos():Distance( self.Owner:GetPos() ) >= 300 ) then
		-- self:OnMiss( ent )
		return
	end	
	
	if not ent:IsPlayer() then return end
	
	local cuffs = ent:isHandcuffed()
	if IsValid( cuffs ) then
		//drag
		if IsValid( cuffs.handcuffer ) then
			cuffs.handcuffer = NULL
			self:SetNWEntity( "Dragging", NULL )
			hook.Call( "GamemodePlayerUnDragCuffedPlayer", GAMEMODE, self.Owner, cuffs.Owner )
		else
			cuffs.handcuffer = self.Owner
			self:SetNWEntity( "Dragging", cuffs.Owner )
			hook.Call( "GamemodePlayerDragCuffedPlayer", GAMEMODE, self.Owner, cuffs.Owner )
		end
	end
end

if CLIENT then return end
function SWEP:Initialize()
	timer.Simple( 0, function()
		if not IsValid( self.Owner ) then return end
		self.m_pPlayer = self.Owner
	end )
end

function SWEP:OnRemove()
	if IsValid( self.m_pPlayer ) then
    self.m_pPlayer:SetWalkSpeed(rp.cfg.WalkSpeed)
    self.m_pPlayer:SetRunSpeed(rp.cfg.RunSpeed)
	end
end

hook.Add( "PlayerSwitchWeapon", "CuffCheck", function( pPlayer )
	if pPlayer:HasWeapon( "weapon_handcuffed" ) then return true end
end )

hook.Add( "GamemodePlayerDragCuffedPlayer", "CufferMoveDeBuff", function( pPlayer, pDragged )
    pDragged:SetWalkSpeed(pDragged:GetWalkSpeed()/2)
    pDragged:SetRunSpeed(pDragged:GetRunSpeed()/2)
end )

hook.Add( "GamemodePlayerUnDragCuffedPlayer", "CufferMoveDeBuff", function( pPlayer, pDragged )
    pDragged:SetWalkSpeed(rp.cfg.WalkSpeed)
    pDragged:SetRunSpeed(rp.cfg.RunSpeed)
end )

--Reset move speed for everyone with cuffs when someone is uncuffed
hook.Add( "GamemodeOnPlayerUnCuffed", "CufferMoveDeBuff", function( pPlayer )
	for k, v in pairs( player.GetAll() ) do
		if not v:HasWeapon( "weapon_handcuffer" ) then continue end
		local wep = v:GetWeapon( "weapon_handcuffer" )

		if IsValid( wep:GetNWEntity("Dragging") ) then
			local other = wep:GetNWEntity( "Dragging" ):GetWeapon( "weapon_handcuffed" )

			if IsValid( other ) and not other.m_bRemoving then
    		pPlayer:SetWalkSpeed(pPlayer:GetWalkSpeed()/2)
        pPlayer:SetRunSpeed(pPlayer:GetRunSpeed()/2)
			else
        pPlayer:SetWalkSpeed(rp.cfg.WalkSpeed)
        pPlayer:SetRunSpeed(rp.cfg.RunSpeed)
			end
		end
	end
end )

-- hook.Add("CanPlayerEnterVehicle", "BlockVehicleForCuffedPalyer", function(ply,veh)
--   if ply:HasWeapon( "weapon_handcuffed" ) then 
--     DarkRP.notify(ply, 4, NOTIFY_ERROR, "Вы арестованы!")
--     return false 
--   end
-- end)
