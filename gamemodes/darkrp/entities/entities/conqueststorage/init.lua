AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")


function ENT:Initialize()
	self:SetModel('models/props/CS_militia/crate_extrasmallmill.mdl')
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetNVar("FlagOwner", "Ничей", NETWORK_PROTOCOL_PUBLIC)

	self.IsStorage = true
	self.inv = {}	
	self.inv[INV_WEAPON] = {}
	self.inv[INV_ENTITY] = {}
	self.inv[INV_FOOD] = {}
	self.inv[INV_PROP] = {}
	self.inv[INV_HATS] = {}
	self.inv[INV_CLOTHES] = {}
end



function ENT:Use(activator)
	if not activator:IsPlayer() or not activator:GetEyeTrace().Entity == self then return end

	if self.inv then
		net.Start("Inventory.StorageLookup")
			net.WriteEntity(self)
			net.WriteTable(self.inv)
		net.Send(activator)
	end

end

function ENT:OnTakeDamage(dmg)

end


