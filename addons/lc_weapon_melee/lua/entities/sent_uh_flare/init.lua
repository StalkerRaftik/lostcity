AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	self:SetModel("models/pg_props/pg_obj/pg_flare.mdl")
	
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:DrawShadow( false )
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetUseType( SIMPLE_USE )
	
	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:Wake()
		phys:SetMass(6)
	end
end

function ENT:Throw(ply)
	self:SetOn(true)
	self:EmitSound("UH.Flare.Burn")
	self:SetSkin( 1 )
	self.DieTime = ply:GetNWFloat("UH_FlareTime")
	
	ply:SetNWFloat("UH_FlareTime", 0)
	ply:SetNWFloat("UH_Flare", false)
	
	local ang = ply:EyeAngles()
	ang:RotateAroundAxis(ang:Right(), 15)
	
	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:ApplyForceCenter(ang:Forward() * 3500)
		phys:AddAngleVelocity(Vector(0,360,0))
	end
end

function ENT:OnRemove()
	self:StopSound("UH.Flare.Burn")
end

function ENT:Touch( ent )
	if !ent:IsOnFire() then
		ent:Ignite(10)
	end
end

function ENT:Use(ply)
	local wep = ply:GetActiveWeapon()
	if IsValid(wep) and wep:GetNWBool("Reloading") then return end
	if !ply:GetNWBool("UH_Flare") and string.find(wep.Base or "", "weapon_uh_base") and !wep.IsBolt and !wep.IsPump and !wep.TwoHanded and GetConVar("uh_sv_flare"):GetBool() then
		ply:SetNWFloat("UH_FlareTime", self.DieTime or (CurTime() + 120))
		ply:SetNWFloat("UH_Flare", true)
		
		ply:SetNWBool("UH_ArmGone", true)
		ply:EmitSound("UH.Flare.Burn")
		
		wep:SetNWBool("Zooming", false)
		
		net.Start("UH_Flare")
			net.WriteEntity(ply)
			net.WriteBool(true)
		net.Send(ply)
		
		if ply:GetNWBool("UH_Flashlight") then
			ply:SetNWBool("UH_Flashlight", false)
			ply:EmitSound("uh/flashlight.wav")
			
			net.Start("UH_Flashlight")
				net.WriteEntity(ply)
				net.WriteBool(false)
			net.Broadcast()
		end
		
		self:Remove()
	else
		if !self:GetOn() then
			self:SetOn(true)
			self:EmitSound("UH.Flare.Burn")
			self:SetSkin( 1 )
			self.DieTime = CurTime() + 120
		end
		if self:IsPlayerHolding() then return end
		ply:PickupObject(self)
	end
end

function ENT:Think()
	if self.DieTime and self.DieTime < CurTime() then
		SafeRemoveEntity( self )
	end
end