AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2012-2018 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/spitball_small.mdl","models/spitball_medium.mdl","models/spitball_medium.mdl"} -- The models it should spawn with | Picks a random one from the table
ENT.DecalTbl_DeathDecals = {"VJ_AcidSlime1"}
ENT.SoundTbl_Idle = {"vj_acid/acid_idle1.wav"}
ENT.SoundTbl_OnCollide = {"vj_acid/acid_splat.wav"}
ENT.DoesRadiusDamage = true -- Should it do a blast damage when it hits something?
ENT.RadiusDamageRadius = 180 -- How far the damage go? The farther away it's from its enemy, the less damage it will do | Counted in world units
ENT.RadiusDamage = 10 -- How much damage should it deal? Remember this is a radius damage, therefore it will do less damage the farther away the entity is from its enemy
ENT.RadiusDamageUseRealisticRadius = true -- Should the damage decrease the farther away the enemy is from the position that the projectile hit?
ENT.RadiusDamageType = DMG_ACID-- Damage type
ENT.DoesDirectDamage = false -- Should it do a direct damage when it hits something?
ENT.DirectDamage = 10 -- How much damage should it do when it hits something
ENT.DirectDamageType = DMG_ACID -- Damage type
-- custom
ENT.LN_VirusInfection = true
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomPhysicsObjectOnInitialize(phys)
	phys:Wake()
	//phys:SetMass(1)
	phys:SetBuoyancyRatio(0)
	phys:EnableDrag(false)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	ParticleEffectAttach("antlion_spit_trail", PATTACH_ABSORIGIN_FOLLOW, self, 0)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	ParticleEffectAttach("antlion_spit", PATTACH_ABSORIGIN_FOLLOW, self, 0)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DeathEffects(data,phys)
	local effectdata = EffectData()
	effectdata:SetOrigin(data.HitPos)
	effectdata:SetScale( 1 )
	util.Effect("StriderBlood",effectdata)
	util.Effect("StriderBlood",effectdata)
	util.Effect("StriderBlood",effectdata)
	ParticleEffect("antlion_gib_02_floaters", data.HitPos, Angle(0,0,0), nil)
	ParticleEffect("antlion_gib_01_juice", data.HitPos, Angle(0,0,0), nil)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DoKilledEnemy(victim,attacker,inflictor)	
if victim.IsVJBaseSNPC == true then
                victim.HasDeathRagdoll = false
				
elseif victim:IsPlayer() then
				if IsValid(victim:GetRagdollEntity()) then
					victim:GetRagdollEntity():Remove()
				end				
            end

   victim:Remove()
   
end	
/*-----------------------------------------------
	*** Copyright (c) 2012-2018 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/