AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Initialize()
	self:SetModel("models/fless/befall/autoinjector.mdl")
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
		timer.Create( "BloodRegen4", 0.5, 6, function() 
			activator:SetHealth(math.Clamp(activator:Health() + 5, 0, activator:GetMaxHealth())) 
			if activator:Health() == activator:GetMaxHealth() then timer.Remove( "BloodRegen4" ) end
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