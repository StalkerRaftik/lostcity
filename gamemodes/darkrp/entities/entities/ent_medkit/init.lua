AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/firstaid/item_firstaid.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetHealth( 100 )
	
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
		self:EmitSound(Sound("entities/medkit.wav"),70,100)
		activator:StopBleeding()
		activator:SetRunSpeed(250)
        activator:SprintEnable()
        activator:SetJumpPower(160)
        activator:GetNVar("Legbroken")
        activator:SetNVar("Legbroken", false, NETWORK_PROTOCOL_PUBLIC)
		timer.Create( "BloodRegen2", 3, 10, function() 
			activator:SetHealth(math.Clamp(activator:Health() + 7, 0, activator:GetMaxHealth())) 
			if activator:Health() == activator:GetMaxHealth() then timer.Remove( "BloodRegen2" ) end
		end )
	end
end

function ENT:OnTakeDamage(dmg)
self:SetHealth(self:Health() - dmg:GetDamage())
if self:Health() <= 0 then 
self.Entity:Remove() end
end 
