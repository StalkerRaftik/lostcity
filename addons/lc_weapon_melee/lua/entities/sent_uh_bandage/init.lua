AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/pg_props/pg_obj/pg_bandage.mdl")
	
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
end

function ENT:Use(ply, caller)
	local hp,maxhp = ply:Health(),ply:GetMaxHealth()
	if hp >= maxhp then return end
	ply:SetHealth( math.min(hp + 1, maxhp) )
	--[[if ply:GetNWBool("UH_Bleeding") then
		ply:SetNWBool("UH_Bleeding", false)
	end]]--
	ply:EmitSound("UH.Bandage")
	self:Remove()
end