include('shared.lua')

function ENT:Draw()

self:DrawModel()

end

function ENT:OnRemove()
end

function ENT:Initialize()
pos = self:GetPos()

self.emitter = ParticleEmitter( pos )
end

function ENT:Think()
		 	pos = self:GetPos()	
end
