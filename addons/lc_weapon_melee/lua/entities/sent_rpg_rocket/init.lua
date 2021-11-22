AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	self:SetModel("models/weapons/w_rockete_launch.mdl")
	
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:DrawShadow( false )
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
		phys:SetMass( 1 )
		phys:EnableGravity( false )
	end
end

function ENT:PhysicsUpdate( phys )
	phys:ApplyForceCenter( self:GetForward() * 1000 )
	if self:GetAngles().p < 0 then
		phys:AddAngleVelocity( Vector(0, 0.1, 0) )
	end
end

function ENT:Explosion()
	local effectdata = EffectData()
	effectdata:SetOrigin(self:GetPos())
	util.Effect("HelicopterMegaBomb", effectdata)
	util.Effect("Explosion", effectdata)

	util.BlastDamage(self, self.Owner, self:GetPos(), 280, 185)
	util.ScreenShake(self:GetPos(), 1000, 5, 1.5, 650)

	self:EmitSound("ambient/explosions/explode_"..math.random(1, 4)..".wav", self.Pos, 100, 100 )

	self:Remove()
end