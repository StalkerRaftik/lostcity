AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/fless/befall/morphine.mdl")
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
		if timer.Exists("AntiradTimer"..activator:SteamID64()) then
			timer.Remove("AntiradTimer")
		end

		self:EmitSound(Sound("entities/medkit.wav"),70,100)
		if not activator.radiation then return end

		timer.Create( "AntiradTimer"..activator:SteamID64(), 6, 10, function() 
			activator.radiation = math.Clamp(activator.radiation - 200, 0, 10000) 
			if activator.radiation == 0 then timer.Remove( "AntiradTimer"..activator:SteamID64() ) end
		end )
	end
end

function ENT:OnTakeDamage(dmg)
	self:SetHealth(self:Health() - dmg:GetDamage())
	if self:Health() <= 0 then self.Entity:Remove() end
end 


function ENT:PhysicsCollide(data, physobj) end