AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	self.Owner = self.Owner
	
	self:SetModel("models/items/ar2_grenade.mdl")
	
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:DrawShadow( false )
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
		phys:SetMass(6.5)
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