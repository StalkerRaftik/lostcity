AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/bloocobalt/l4d/items/w_eq_adrenaline.mdl")
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

function ENT:Use(activator, caller)
	if activator:IsPlayer() then
		self:Remove()
		self:EmitSound(Sound("entities/medkit.wav"),70,100)
		activator:SetNVar("SprintBoost", 30, NETWORK_PROTOCOL_PUBLIC)
		timer.Simple( 120, function() activator:SetNVar("SprintBoost", 0, NETWORK_PROTOCOL_PUBLIC) end)
		activator:SetHealth(math.Clamp(activator:Health() + 5, 0, activator:GetMaxHealth())) 
	end
end

function ENT:OnTakeDamage(dmg)
	self:SetHealth(self:Health() - dmg:GetDamage())
	if self:Health() <= 0 then self.Entity:Remove() end
end 


function ENT:PhysicsCollide(data, physobj) end