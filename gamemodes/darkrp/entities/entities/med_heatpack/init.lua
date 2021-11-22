AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_rpd/medical_iv.mdl")
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
		timer.Create( "HeatpackUse"..activator:SteamID64(), 6, 10, function() 
			activator:SetNVar('Temperature', math.Clamp( activator:GetNVar('Temperature') + 5, 0, 100))
		end )
	end
end

function ENT:OnTakeDamage(dmg)
	self:SetHealth(self:Health() - dmg:GetDamage())
	if self:Health() <= 0 then self.Entity:Remove() end
end 


function ENT:PhysicsCollide(data, physobj) end