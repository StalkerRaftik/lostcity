include("shared.lua")
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

function ENT:Initialize()
	self:SetModel("models/mosi/fallout4/props/aid/medx.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	local phys = self:GetPhysicsObject()
		phys:Wake()

	self:SetUseType(SIMPLE_USE)
end

function ENT:Use(activator)
	if activator:IsValid() and activator:IsPlayer() then
		if activator.infected then
			if activator.stage != 3 then
				activator.infected = false
			end
		end
		self:EmitSound(Sound("entities/medkit.wav"),70,100)
		self:Remove()
	end
end
