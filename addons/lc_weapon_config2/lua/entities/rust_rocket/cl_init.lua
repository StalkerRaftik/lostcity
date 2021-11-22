include("shared.lua")

function ENT:Draw()
	self:DrawModel()
end

function ENT:Think()
	if GetConVar("tfa_rust_rocket_trails"):GetBool() then
		ParticleEffect("generic_smoke", self:GetPos(), Angle(0,0,0), self)
	end
end