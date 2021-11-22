AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	self:SetModel("models/pg_props/pg_obj/pg_glow_stick_pack.mdl")
	
	self:SetSkin( math.random(0,4) )
	
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

function ENT:Use(ply)
	if self.b_removed then return end
	self.b_removed = true
	local stick = ents.Create("sent_uh_glowstick")
	stick:SetPos( self:GetPos() )
	stick:SetAngles( self:GetAngles() )
	stick:Spawn()
	stick:Activate()
	
	self:Remove()
	ply:PickupObject(stick)
end