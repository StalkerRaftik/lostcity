ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.Spawnable		= false
ENT.AdminSpawnable	= false


ENT.MyModel = "models/weapons/w_rgo.mdl"
ENT.MyModelScale = 1
ENT.Damage = 260
ENT.Radius = 350
if SERVER then

	AddCSLuaFile()

	function ENT:Initialize()

		local model = self.MyModel and self.MyModel 
		
		self.Class = self:GetClass()
		
		self:SetModel(model)
		
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:DrawShadow(true)
		self:SetCollisionGroup(COLLISION_GROUP_NONE)
		self:SetHealth(1)
		self:SetModelScale(self.MyModelScale,0)
		self.isready = false
		
		local phys = self:GetPhysicsObject()
		
		if (phys:IsValid()) then
			phys:Wake()
		end
	end
	function ENT:PhysicsCollide(data, physobj)
		if self.isready ~= true then
			self.isready = true
			timer.Simple( 3, function()
				local owent = self.Owner and self.Owner or self
				util.BlastDamage(self,owent,self:GetPos(),self.Radius,self.Damage)
				local fx = EffectData()
				fx:SetOrigin(self:GetPos())
				fx:SetNormal(data.HitNormal)
				util.Effect("Explosion",fx)
				self:Remove()
			end)
		end
	end
end

if CLIENT then
	
	function ENT:Draw()
		self:DrawModel()
	end

end