AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/uh_hpspray.mdl")
	
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
end

function ENT:Use(ply, caller)
	local hp,maxhp = ply:Health(),ply:GetMaxHealth()
	if hp >= maxhp then return end
	ply:SetHealth( math.min(hp + 5, maxhp) )
	ply:EmitSound("UH.Medspray")
	self:Remove()
end