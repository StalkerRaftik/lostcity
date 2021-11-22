
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	self.Entity:SetModel( "models/props/de_train/Barrel.mdl" )
	self.Entity:SetMoveCollide(COLLISION_GROUP_PROJECTILE)
	self.Entity:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:GetPhysicsObject():SetMass(5)
	self.Entity:GetPhysicsObject():SetDragCoefficient( 0)
	self.Entity:DrawShadow(false)

	self:SetHealth(120)

	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end

	self.delay = 0
end

function ENT:SetEntityOwner(ent)
	self:SetOwner(ent)
	self.entOwner = ent
end

function ENT:PhysicsCollide(data, physobj)
	return true
end

function ENT:OnRemove()

end

function ENT:OnTakeDamage( dmginfo )
	print(self:Health())
	self:SetHealth(self:Health() - dmginfo:GetDamage())
	if self:Health() < 0 then
		if self.removed == true then return end
		self.removed = true

		util.BlastDamage(self,dmginfo:GetAttacker(),self:GetPos(),350,200)
		effectdata = EffectData()
		effectdata:SetOrigin(self:GetPos())
		effectdata:SetScale(5)
		effectdata:SetMagnitude(5)
		util.Effect("Explosion", effectdata)

		self:Remove()
	end
end

local radsounds = {
	'player/geiger1.wav',
	'player/geiger2.wav',
	'player/geiger3.wav',
}

function ENT:Think()
	if self.delay < CurTime() then
		for _, ply in pairs(player.GetAll()) do
			if self:GetPos():DistToSqr(ply:GetPos()) > 2000*2000 then continue end

			hook.Run( "RadiationGasMaskChecker", ply)

			-- if ply:HasGasmask() then return end
			if ply:GetNWInt("FilterDuration") >= 0 then return end

			local RadDose = 50 + 50*( 1 - ( self:GetPos():Distance(ply:GetPos())/100/20 ) )
			ply:SetRadiation(ply:GetRadiation() + RadDose)
			ply:ShowGuide("Radiation")
		end
		self.delay = CurTime() + 10
	end
end


