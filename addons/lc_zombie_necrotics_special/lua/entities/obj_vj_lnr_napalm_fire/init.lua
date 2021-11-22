AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/props_junk/garbage_glassbottle003a.mdl"} -- The models it should spawn with | Picks a random one from the table
ENT.SolidType = SOLID_VPHYSICS
ENT.RemoveOnHit = true -- Should it remove itself when it touches something? | It will run the hit sound, place a decal, etc.
ENT.DoesRadiusDamage = true -- Should it do a blast damage when it hits something?
ENT.RadiusDamageRadius = 70 -- How far the damage go? The farther away it's from its enemy, the less damage it will do | Counted in world units
ENT.RadiusDamage = 15 -- How much damage should it deal? Remember this is a radius damage, therefore it will do less damage the farther away the entity is from its enemy
ENT.RadiusDamageUseRealisticRadius = true -- Should the damage decrease the farther away the enemy is from the position that the projectile hit?
ENT.RadiusDamageType = DMG_BURN -- Damage type
ENT.RadiusDamageForce = 10 -- Put the force amount it should apply | false = Don't apply any force
ENT.DecalTbl_DeathDecals = {"Scorch"}
ENT.SoundTbl_OnCollide = {"ambient/fire/ignite.wav"}
ENT.FireLength = 7.2
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Draw()
	self.Entity:SetNoDraw( true )
end

function ENT:CustomPhysicsObjectOnInitialize(phys)
	phys:Wake()
	phys:EnableGravity(true)
	phys:SetBuoyancyRatio(0)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DeathEffects(data,phys)
	self.ExplosionLight1 = ents.Create("light_dynamic")
	self.ExplosionLight1:SetKeyValue("brightness", "1")
	self.ExplosionLight1:SetKeyValue("distance", "100")
	self.ExplosionLight1:SetLocalPos(data.HitPos)
	self.ExplosionLight1:SetLocalAngles(self:GetAngles())
	self.ExplosionLight1:Fire("Color", "255 0 0")
	self.ExplosionLight1:SetParent(self)
	self.ExplosionLight1:Spawn()
	self.ExplosionLight1:Activate()
	self.ExplosionLight1:Fire("TurnOn", "", 0)
	self:DeleteOnRemove(self.ExplosionLight1)
	
	local flame = ents.Create( "info_particle_system" )
	flame:SetKeyValue( "effect_name","env_fire_small" )
	flame:SetPos(self:GetPos())
	flame:Spawn()
	flame:Activate() 
	flame:Fire( "Start", "", 0 )
	flame:Fire( "Kill", "", self.FireLength )
	
	local flame2 = ents.Create( "info_particle_system" )
	flame2:SetKeyValue( "effect_name","env_fire_small" )
	flame2:SetPos( self:GetPos() + self:GetRight()*20 )
	flame2:Spawn()
	flame2:Activate() 
	flame2:Fire( "Start", "", 0 )
	flame2:Fire( "Kill", "", self.FireLength )
	
	local flame3 = ents.Create( "info_particle_system" )
	flame3:SetKeyValue( "effect_name","env_fire_small" )
	flame3:SetPos( self:GetPos() + self:GetRight()*-20 )
	flame3:Spawn()
	flame3:Activate() 
	flame3:Fire( "Start", "", 0 )
	flame3:Fire( "Kill", "", self.FireLength )
	
	local flame4 = ents.Create( "info_particle_system" )
	flame4:SetKeyValue( "effect_name","env_fire_small" )
	flame4:SetPos( self:GetPos() + self:GetForward() *20)
	flame4:Spawn()
	flame4:Activate() 
	flame4:Fire( "Start", "", 0 )
	flame4:Fire( "Kill", "", self.FireLength )
	
	local flame5 = ents.Create( "info_particle_system" )
	flame5:SetKeyValue( "effect_name","env_fire_small" )
	flame5:SetPos( self:GetPos() + self:GetForward() *-20)
	flame5:Spawn()
	flame5:Activate() 
	flame5:Fire( "Start", "", 0 )
	flame5:Fire( "Kill", "", self.FireLength )
	for _,v in ipairs(ents.FindInSphere(self:GetPos(),150)) do
		if v:IsValid() && (v:Health() != nil && v:Health() > 0) then
			v:Ignite(7,0)
		end
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/