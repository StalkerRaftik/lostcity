AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Initialize()
	self:SetModel("models/snowzgmod/payday2/armour/armourrthigh.mdl")
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
function ENT:Use(activator, caller)
	if activator:IsPlayer() then
		self:EmitSound(Sound("entities/medkit.wav"),70,100)
		activator:SprintEnable()
        activator:SetWalkSpeed(100)
        activator:SetJumpPower(160)
        activator:GetNVar("Legbroken")
        activator:SetNVar("Legbroken", false, NETWORK_PROTOCOL_PUBLIC)
		timer.Create( "BloodRegen2", 3, 2, function() 
			activator:SetHealth(math.Clamp(activator:Health() + 5, 0, activator:GetMaxHealth())) 
			if activator:Health() == activator:GetMaxHealth() then timer.Remove( "BloodRegen2" ) end
		end )
		self:Remove()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnTakeDamage(dmg)
self:SetHealth(self:Health() - dmg:GetDamage())
if self:Health() <= 0 then 
self.Entity:Remove() end
end 