AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	self:SetModel("models/weapons/w_eq_fraggrenade.mdl")
	
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
	
	self.SplodeTime = CurTime() + 2.5
end

function ENT:Think()
	if (self.SplodeTime or 0) < CurTime() and !self.Sploded then
		self:Explosion()
	end
end

function ENT:OnTakeDamage( dmginfo )
	if !self.Sploded then
		self:Explosion()
	end
end

function ENT:Explosion()
	self.Sploded = true
	
	local effectdata = EffectData()
	effectdata:SetOrigin(self:GetPos())
	util.Effect("HelicopterMegaBomb", effectdata)
	util.Effect("Explosion", effectdata)
	
	util.BlastDamage(self, self.Owner, self:GetPos(), 220, 125)
	
	util.ScreenShake(self:GetPos(), 5, 0.1, 1.5, 260)
	
	self:EmitSound("ambient/explosions/explode_" .. math.random(1, 4) .. ".wav", self.Pos, 100, 100 )
	
	self:Remove()
end

function ENT:PhysicsCollide(data,phys)
	if !IsValid(data.HitEntity) or data.HitEntity:GetClass() != "func_breakable" then
		phys:SetVelocity( phys:GetVelocity()*0.99 )
	end
	if data.Speed > 50 then
		self:EmitSound( "weapons/hegrenade/he_bounce-1.wav", 75, 100, 1, CHAN_USER_BASE )
	end
end