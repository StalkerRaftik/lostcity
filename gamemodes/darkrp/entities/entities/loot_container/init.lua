AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

util.AddNetworkString("Inventory.StorageLookup")

-- ENT.Model = "models/props_junk/wood_crate002a.mdl"

function ENT:Initialize()
	-- self:SetModel(self.Model)

	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	local phys = self:GetPhysicsObject()
	
	if phys:IsValid() then
	
		phys:Wake()
		
	end

	self.IsStorage = true
	self.inv = {}	
	self.inv[INV_WEAPON] = {}
	self.inv[INV_ENTITY] = {}
	self.inv[INV_FOOD] = {}
	self.inv[INV_PROP] = {}
	self.inv[INV_HATS] = {}
	self.inv[INV_CLOTHES] = {}
	self:SetStorageName("box")
end

function ENT:UpdateInventory(activator)
	net.Start("Inventory.StorageLookup")
		net.WriteEntity(self)
		net.WriteTable(self.inv)
	net.Send(activator)
end

function ENT:Use(activator)
	if (activator.lastPickup or 0) < CurTime() && activator:IsPlayer() && activator:GetEyeTrace().Entity == self && self:Check(activator, INV_ACT_LOOKUP) then
		activator.lastPickup = CurTime() + 0.3

		if self.CustomUseCheck and self.CustomUseCheck(activator) == false then return end

		local searchvars = {'Хм...', 'Обыскиваю...', 'Ищу...', 'Осматриваю...'}

		local func = function(ply)
			if self.UpdateInventory then self:UpdateInventory(ply) end
		end
		activator:StartProgressBar(3, func, table.Random(searchvars))

	end
end

function UpdateInventory(activator, ent)
	net.Start("Inventory.StorageLookup")
		net.WriteEntity(ent)
		net.WriteTable(ent.inv)
	net.Send(activator)
end

function ENT:OnTakeDamage(dmg)
end

function ENT:Check(ply, action)
	return true
end

function ENT:OnUse(ply, action)

end