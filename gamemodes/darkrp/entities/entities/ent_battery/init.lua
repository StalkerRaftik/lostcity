AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/illusion/eftcontainers/aabattery.mdl")
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
	for k,v in pairs(activator.inv[INV_ENTITY]["flashlight"]) do
		if not v.power then
			v.power = 0
		end
		if v.power < 100 then
			if v.count and v.count > 1 then
				v.count = v.count - 1
				local tbl = {}
				activator:AddItem(INV_ENTITY, "flashlight", {count = 1, power = 50})
			else
				v.power = math.Clamp(v.power + 50, 0, 100)
			end
			break 
		end
	end
	activator:UpdateInventory()
end

function ENT:OnTakeDamage(dmg)
self:SetHealth(self:Health() - dmg:GetDamage())
if self:Health() <= 0 then 
self.Entity:Remove() end
end