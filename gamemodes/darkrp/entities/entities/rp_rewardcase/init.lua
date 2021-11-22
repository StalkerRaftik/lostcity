AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props/CS_militia/caseofbeer01.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	local phys = self:GetPhysicsObject()
	
	if phys:IsValid() then
		phys:Wake()
	end

end

function ENT:Use(activator, caller)
	if activator:IsPlayer() then
		local phys = self:GetPhysicsObject()
		print("YES")
		for i = 1, 1 do
			if (phys:IsValid()) then
				phys:ApplyForceOffset( Vector( 0, 0, math.random(11,19) ), Vector( 0, 0, math.random(9,18)) )
			end
		end
	end
end

