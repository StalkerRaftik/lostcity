AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_lnrspecials/titan.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJC_Data = {
	CameraMode = 1, -- Sets the default camera mode | 1 = Third Person, 2 = First Person
	ThirdP_Offset = Vector(40, 20, -50), -- The offset for the controller when the camera is in third person
	FirstP_Bone = "ValveBiped.Bip01_Head1", -- If left empty, the base will attempt to calculate a position for first person
	FirstP_Offset = Vector(0, 0, 5), -- The offset for the controller when the camera is in first person
}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.HasRangeAttack = true
ENT.RangeUseAttachmentForPos = true
ENT.RangeAttackEntityToSpawn = "obj_vj_lnr_infection_spit_bomb" 
ENT.AnimTbl_RangeAttack = {"vjseq_Idle_Yell","vjseq_Idle_Yell","vjseq_Idle_Yell","vjseq_Idle_Yell"}
ENT.RangeUseAttachmentForPosID = "mouth"
ENT.NextRangeAttackTime = 6
ENT.TimeUntilRangeAttackProjectileRelease = 0.6
--ENT.RangeAttackExtraTimers = {0.8,1.2,1.4,1.6,1.8,2.0}
ENT.GeneralSoundPitch1 = 60
ENT.GeneralSoundPitch2 = 60
---------------------------------------------------------------------------------------------------------------------------------------------
-- custom
ENT.LNR_VirusInfection = true
ENT.LNR_IsWalker = true
ENT.Titan_LowHP = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPreInitialize() 
self.StartHealth = self.StartHealth * GetConVarNumber("VJ_LNR_Walker_HealthModifier")	
self:SetHealth(self.StartHealth)
self.MeleeAttackDamage = self.MeleeAttackDamage * GetConVarNumber("VJ_LNR_Walker_DamageModifier")

if GetConVarNumber("VJ_LNR_Infection") == 0 then 
		self.LNR_VirusInfection = false 
end	

if GetConVarNumber("VJ_LNR_Alert") == 0 then 
		self.CallForHelp = false
end

if GetConVarNumber("VJ_LNR_DeathAnimations") == 0 then 
		self.HasDeathAnimation = false	
end
	if GetConVarNumber("vj_npc_noidleparticle") == 0 then
		local eyeglow1 = ents.Create("env_sprite")
		eyeglow1:SetKeyValue("model","vj_base/sprites/vj_glow1.vmt")
		eyeglow1:SetKeyValue("scale","0.02")
		eyeglow1:SetKeyValue("rendermode","5")
		eyeglow1:SetKeyValue("rendercolor","255 255 0 255")
		eyeglow1:SetKeyValue("spawnflags","1") -- If animated
		eyeglow1:SetParent(self)
		eyeglow1:Fire("SetParentAttachment","eye1",0)
		eyeglow1:Spawn()
		eyeglow1:Activate()
		self:DeleteOnRemove(eyeglow1)
end	
	self:SetCanPlayMusic(false)
	self:SetNW2Int("NextSpecialT",CurTime())
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_BleedEnemy(TheHitEntity) 
if GetConVarNumber("vj_LNR_InfectionDamage") == 1 then 
self.MeleeAttackBleedEnemyTime = GetConVarNumber("vj_LNR_BleedTime")
timer.Simple(GetConVarNumber("vj_LNR_BleedTime"),function()
end)
end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_SlowPlayer(TheHitEntity) 
self.SlowPlayerOnMeleeAttackTime = self.SlowPlayerOnMeleeAttackTime * GetConVarNumber("vj_LNR_SlowTime")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackCode_GetShootPos(projectile)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "step" then
		self:FootStepSoundCode()
	end
	if key == "melee" then
		self:MeleeAttackCode()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnChangeMovementType(movType)	
	if VJ_AnimationExists(self,ACT_JUMP) == true then self:CapabilitiesRemove(bit.bor(CAP_MOVE_JUMP)) end
	if VJ_AnimationExists(self,ACT_CLIMB_UP) == true then self:CapabilitiesRemove(bit.bor(CAP_MOVE_CLIMB)) end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackCode_GetShootPos(TheProjectile)
	return (self:GetEnemy():GetPos() - self:LocalToWorld(Vector(70,0,0)))*2 + self:GetUp()*80
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomRangeAttackCode_BeforeProjectileSpawn(TheProjectile)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomRangeAttackCode_AfterProjectileSpawn(TheProjectile)
	self:SetNW2Int("NextSpecialT",CurTime() +10)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo,hitgroup)
if dmginfo:GetDamageType(DMG_BULLET) or dmginfo:GetDamageType(DMG_SLASH) then
		dmginfo:ScaleDamage(0.50)
		if self.HasSounds == true && self.HasImpactSounds == true then VJ_EmitSound(self,"vj_impact_metal/bullet_metal/metalsolid"..math.random(1,10)..".wav",70) end
		local attacker = dmginfo:GetAttacker()
		if math.random(1,3) == 1 then
			dmginfo:ScaleDamage(0.60)
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
	
	if self.Titan_LowHP == false && (self.StartHealth -4000 > self:Health()) then
		        self.Titan_LowHP = true
				self.FootStepTimeRun = 0.24
				self.AnimTbl_Run = {ACT_RUN}
				self.LNR_IsWalker = false
				self:SetSkin(1)
end      
		if GetConVarNumber("vj_npc_noidleparticle") == 0 then
		local eyeglow1 = ents.Create("env_sprite")
		eyeglow1:SetKeyValue("model","vj_base/sprites/vj_glow1.vmt")
		eyeglow1:SetKeyValue("scale","0.01")
		eyeglow1:SetKeyValue("rendermode","5")
		eyeglow1:SetKeyValue("rendercolor","255 255 0 255")
		eyeglow1:SetKeyValue("spawnflags","1") -- If animated
		eyeglow1:SetParent(self)
		eyeglow1:Fire("SetParentAttachment","eye1",0)
		eyeglow1:Spawn()
		eyeglow1:Activate()
		self:DeleteOnRemove(eyeglow1)
	end	
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2018 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/