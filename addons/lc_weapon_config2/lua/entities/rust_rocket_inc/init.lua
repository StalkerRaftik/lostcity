AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	local mdl = self:GetModel()

	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	local phys = self:GetPhysicsObject()
	self:NextThink(CurTime() + 0.1)

	if phys:IsValid() then
		phys:Wake()
		phys:SetMass(1)
	end


	self:SetUseType(SIMPLE_USE)
	self:EmitSound( "darky_rust.rocket-engine-loop" )
	-- self.snd = self:StartLoopingSound("darky_rust.rocket-engine-loop")

	self.damage = self.damage or 15
	self.beep = self.beep or false

	self.DestroyTime = CurTime() + 20
end



function ENT:Think()
	self:NextThink(CurTime() + 0.1)
	if CurTime() > self.DestroyTime then
		self:Remove()
		self:StopSound("darky_rust.rocket-engine-loop")
	end
end


function ENT:PhysicsCollide(data, phys)
	timer.Simple(0,function()
		if IsValid(self) then
			self:Explode()
		end
	end)
end

function ENT:Explode()
	self:StopSound("darky_rust.rocket-engine-loop")

	if not IsValid(self.owner) then
		self:Remove()
		return
	end
	ParticleEffect( "rust_big_explosion", self:GetPos()+self:GetUp()*20, Angle( 0, 0, 0 ) )

	util.ScreenShake(self:GetPos(), 10, 1, 2, 1000)
	util.BlastDamage(self, self.owner, self:GetPos(), self.radius, self.damage)
	local effectdata = EffectData()
	effectdata:SetOrigin(self:GetPos())
	effectdata:SetFlags(4)
	util.Effect("Explosion", effectdata)

	self:EmitSound("TFA_RUST_RPG")

	for i=1, math.random(3,5) do
		local i = ents.Create("rust_fire_ent")
		if i:IsValid() then
			i:SetPos(self:GetPos())
			i:Spawn()
			i:GetPhysicsObject():SetVelocity(VectorRand()*150)
			ParticleEffectAttach("rust_fire_ent", PATTACH_ABSORIGIN_FOLLOW, i, 0)
		end
	end

	self:Remove()
end




function ENT:Use(ply, caller)
end