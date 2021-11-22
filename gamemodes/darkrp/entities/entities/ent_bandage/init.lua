AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/bandage/bandage.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetHealth( 100 )
	self:SetUseType(SIMPLE_USE)
	
	local phys = self:GetPhysicsObject()
	if phys and phys:IsValid() then
		phys:Wake()
	end
end

function ENT:PhysicsCollide(data, physobj)

end

function ENT:Use(activator, caller)
	if activator:IsPlayer() then
		self:Remove()
		self:EmitSound(Sound("entities/bandage.wav"),70,100)
		activator:StopBleeding()
		timer.Create( "BloodRegen", 2, 5, function()
		 activator:SetHealth(math.Clamp(activator:Health() + 2, 0, activator:GetMaxHealth()))  
		 if activator:Health() == activator:GetMaxHealth() then timer.Remove( "BloodRegen" ) end
		end )
	end
end

function ENT:OnTakeDamage(dmg)
self:SetHealth(self:Health() - dmg:GetDamage())
if self:Health() <= 0 then 
self.Entity:Remove() end
end