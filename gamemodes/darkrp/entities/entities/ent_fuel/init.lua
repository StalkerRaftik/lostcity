AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/illusion/eftcontainers/gasoline.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetHealth( 10 )
	self:SetUseType(SIMPLE_USE)
	
	local phys = self:GetPhysicsObject()
	if phys and phys:IsValid() then
		phys:Wake()
	end
end

function ENT:PhysicsCollide(data, physobj)

end

function ENT:Use(activator, caller)
	if not activator:IsPlayer() then return end

	for k,v in pairs(ents.FindInSphere( activator:GetPos(), 30 )) do 
		if v:GetClass() == "gmod_sent_vehicle_fphysics_base" then
			v:SetFuel( v:GetFuel() + 15 )

			return true
		end
	end

	DarkRP.notify(activator, 1, 4, "Рядом нет машин")
	return false
end

function ENT:OnTakeDamage(dmg)
self:SetHealth(self:Health() - dmg:GetDamage())
if self:Health() <= 0 then 
self.Entity:Remove() end
end