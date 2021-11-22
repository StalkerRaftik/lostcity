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
ENT.RadiusDamageType = DMG_RADIATION -- Damage type
ENT.RadiusDamageForce = 10 -- Put the force amount it should apply | false = Don't apply any force
ENT.DecalTbl_DeathDecals = {"Scorch"}
--ENT.SoundTbl_OnCollide = {"weapons/radiationthrower/explosion.mp3"}
ENT.RadLength = 1.2
-- custom
ENT.LN_VirusInfection = true
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
	--self.ExplosionLight1 = ents.Create("light_dynamic")
	--self.ExplosionLight1:SetKeyValue("brightness", "1")
	--self.ExplosionLight1:SetKeyValue("distance", "100")
	--self.ExplosionLight1:SetLocalPos(data.HitPos)
	--self.ExplosionLight1:SetLocalAngles(self:GetAngles())
	--self.ExplosionLight1:Fire("Color", "255 0 0")
	--self.ExplosionLight1:SetParent(self)
	--self.ExplosionLight1:Spawn()
	--self.ExplosionLight1:Activate()
	--self.ExplosionLight1:Fire("TurnOn", "", 0)
	--self:DeleteOnRemove(self.ExplosionLight1)
	
	local radiation = ents.Create( "info_particle_system" )
	radiation:SetKeyValue( "effect_name","smoke_exhaust_01" )
	radiation:SetPos(self:GetPos())
	radiation:Spawn()
	radiation:Activate() 
	radiation:Fire( "Start", "", 0 )
	radiation:Fire( "Kill", "", self.RadLength )
	
	local radiation2 = ents.Create( "info_particle_system" )
	radiation2:SetKeyValue( "effect_name","smoke_exhaust_01" )
	radiation2:SetPos( self:GetPos() + self:GetRight()*20 )
	radiation2:Spawn()
	radiation2:Activate() 
	radiation2:Fire( "Start", "", 0 )
	radiation2:Fire( "Kill", "", self.RadLength )
	
	local radiation3 = ents.Create( "info_particle_system" )
	radiation3:SetKeyValue( "effect_name","smoke_exhaust_01" )
	radiation3:SetPos( self:GetPos() + self:GetRight()*-20 )
	radiation3:Spawn()
	radiation3:Activate() 
	radiation3:Fire( "Start", "", 0 )
	radiation3:Fire( "Kill", "", self.RadLength )
	
	local radiation4 = ents.Create( "info_particle_system" )
	radiation4:SetKeyValue( "effect_name","smoke_exhaust_01" )
	radiation4:SetPos( self:GetPos() + self:GetForward() *20)
	radiation4:Spawn()
	radiation4:Activate() 
	radiation4:Fire( "Start", "", 0 )
	radiation4:Fire( "Kill", "", self.RadLength )
	
	local radiation5 = ents.Create( "info_particle_system" )
	radiation5:SetKeyValue( "effect_name","smoke_exhaust_01" )
	radiation5:SetPos( self:GetPos() + self:GetForward() *-20)
	radiation5:Spawn()
	radiation5:Activate() 
	radiation5:Fire( "Start", "", 0 )
	radiation5:Fire( "Kill", "", self.RadLength )
	
	for _,v in ipairs(ents.FindInSphere(self:GetPos(),150)) do
	timer.Create("LNR_Radiation"..self:EntIndex(), 1.5, 6, function()
		if v:IsValid(LNR_Radiation) && (v:Health() != nil && v:Health() > 0) then
			v:TakeDamage(50,self)
			
			end
		end)
	end
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
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/