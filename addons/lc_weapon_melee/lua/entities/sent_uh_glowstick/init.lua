AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	self:SetModel("models/pg_props/pg_obj/pg_glow_stick.mdl")
	
	self:SetSkin( math.random(0,4)*2 )
	
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:DrawShadow( false )
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetUseType( SIMPLE_USE )
	
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
		phys:SetMass(6)
	end
end

function ENT:Think()
	if self.DieTime and self.DieTime < CurTime() then
		SafeRemoveEntity( self )
	end
end

function ENT:Use(ply)
	if !self:GetOn() then
		self:SetOn(true)
		self:SetSkin( self:GetSkin() + 1 )
		self.DieTime = CurTime() + 120
		self:EmitSound("uh/glowstick.wav", 100, 100, 1, CHAN_USER_BASE)
	end
	if self:IsPlayerHolding() then return end
	ply:PickupObject(self)
end