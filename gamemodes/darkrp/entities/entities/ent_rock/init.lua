AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Initialize()
	self:SetModel("models/props/CS_militia/militiarock05.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetHealth( 100 )
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	local phys = self:GetPhysicsObject()
	if phys and phys:IsValid() then
		phys:Wake()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:PhysicsCollide(data, physobj)

end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnTakeDamage(dmg)
	local ply = dmg:GetAttacker()
	local wep = ply:GetActiveWeapon()
	if wep:GetClass() ~= "tfa_rustalpha_pickaxe" then return end

	local rand = math.random(1,10)

	if rand == 10 then
		ply:AddItem(INV_ENTITY, "sulfur")
	elseif rand >= 6 then
		ply:AddItem(INV_ENTITY, "coil")
	else
		ply:AddItem(INV_ENTITY, "stone")
	end

	self:SetHealth(self:Health() - 10)
	if self:Health() <= 0 then 
		if self.id then
			rp.LootSystem.Rocks[self.id].exist = false
		end
		self.Entity:Remove() 
	end
end 