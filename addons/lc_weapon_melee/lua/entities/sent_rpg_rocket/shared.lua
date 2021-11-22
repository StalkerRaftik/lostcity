ENT.Type = "anim"
ENT.PrintName = "MGL Grenade"
ENT.Author = ""
ENT.Contact	= ""
ENT.Purpose = ""
ENT.Instructions = ""

function ENT:PhysicsCollide(data, phys)
	if SERVER then
		self:Explosion()
	end
end
