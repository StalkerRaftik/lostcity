AddCSLuaFile()

ENT.Type             = "anim"
ENT.Base             = "base_anim"
ENT.PrintName        = "Фильтр противогаза"
ENT.Category		= "METRO GASMASK"
ENT.Spawnable = true  
ENT.AdminOnly = false  


-- function ENT:SpawnFunction( ply, tr )
-- 	if not tr.Hit then return end

-- 	local spawnpos = tr.HitPos + tr.HitNormal * 25

-- 	local ent = ents.Create( "sent_soccerball" )
-- 	ent:SetPos( spawnpos )
-- 	ent:Spawn()
-- 	return ent
-- end

function ENT:Initialize()
	if SERVER then
		self:SetLagCompensated( true )	--players can shoot at us even with their shitty ping!
		self:SetUseType( SIMPLE_USE )	--don't let players spam +use on us, that's rude
		self:SetModel( "models/teebeutel/metro/objects/gasmask_filter.mdl" )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )

		self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	end
end


-- function ENT:Use( activator )

-- end


