AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_lnrhl2/lnr_hev_corpse.mdl"} 
ENT.HasItemDropsOnDeath = true 
ENT.ItemDropsOnDeathChance = 2
ENT.ItemDropsOnDeath_EntityList = {"item_battery"}
ENT.LN_Run = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
if math.random(1,3) == 1 then
self.light = ents.Create("env_projectedtexture")
self.light:SetLocalPos( self:GetPos() + Vector(0,0,0) )
self.light:SetLocalAngles( self:GetAngles() + Angle(0,0,0) )
self.light:SetKeyValue('lightcolor', "255 255 255")
self.light:SetKeyValue('lightfov', '30')
self.light:SetKeyValue('farz', '1000')
self.light:SetKeyValue('nearz', '10')
self.light:SetKeyValue('shadowquality', '0')
self.light:Input( 'SpotlightTexture', NULL, NULL, "effects/flashlight001")
self.light:SetOwner(self)
self.light:SetParent(self)
self.light:Spawn()
self.light:Activate()
self.light:Fire("setparentattachment", "chest")
self.light:DeleteOnRemove(self.light)

local glow1 = ents.Create("env_sprite")
		glow1:SetKeyValue("model","sprites/light_ignorez.vmt")
		glow1:SetKeyValue("scale","0.2")
		glow1:SetKeyValue("rendermode","3")
		glow1:SetKeyValue("rendercolor","255 255 255")
		glow1:SetKeyValue("spawnflags","0.1") -- If animated
		glow1:SetParent(self)
		glow1:Fire("SetParentAttachment","chest",0)
		glow1:Spawn()
		glow1:Activate()
		self:DeleteOnRemove(glow1)
		self:DeleteOnRemove(glow1)
end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetUpGibesOnDeath(dmginfo,hitgroup)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo,hitgroup,GetCorpse)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink_AIEnabled()
if math.random(1,120) == 1 then
VJ_EmitSound(self,"vj_lnrhl2/hevzombie/hzv"..math.random(1,14)..".wav",70) end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo,hitgroup)
	if (dmginfo:IsBulletDamage()) && hitgroup == HITGROUP_CHEST or hitgroup == HITGROUP_STOMACH or hitgroup == HITGROUP_RIGHTLEG or hitgroup == HITGROUP_LEFTLEG or hitgroup == HITGROUP_RIGHTARM or hitgroup == HITGROUP_LEFTARM then
		dmginfo:ScaleDamage(0.60)
		if self.HasSounds == true && self.HasImpactSounds == true then VJ_EmitSound(self,"vj_impact_metal/bullet_metal/metalsolid"..math.random(1,10)..".wav",70) end
		local attacker = dmginfo:GetAttacker()
		if math.random(1,3) == 1 then
			dmginfo:ScaleDamage(0.50)
			self.DamageSpark1 = ents.Create("env_spark")
			self.DamageSpark1:SetKeyValue("Magnitude","1")
			self.DamageSpark1:SetKeyValue("Spark Trail Length","1")
			self.DamageSpark1:SetPos(dmginfo:GetDamagePosition())
			self.DamageSpark1:SetAngles(self:GetAngles())
			//self.DamageSpark1:Fire("LightColor", "255 255 255")
			self.DamageSpark1:SetParent(self)
			self.DamageSpark1:Spawn()
			self.DamageSpark1:Activate()
			self.DamageSpark1:Fire("StartSpark", "", 0)
			self.DamageSpark1:Fire("StopSpark", "", 0.001)
			self:DeleteOnRemove(self.DamageSpark1)
   end
end
	if hitgroup == HITGROUP_HEAD && GetConVarNumber("vj_LNR_Headshot") == 1 then
		dmginfo:SetDamage(self:Health())
   end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPriorToKilled(dmginfo,hitgroup)		
VJ_EmitSound(self,"vj_lnrhl2/hevzombie/hev_dead_shutdown01.wav",70) 	
VJ_EmitSound(self,"vj_lnrhl2/hevzombie/flatline.wav",70) 		
end 
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove() 
self.StopSound(self,"vj_lnrhl2/hevzombie/hzv"..math.random(1,14)..".wav")
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/