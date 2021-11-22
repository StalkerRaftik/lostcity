AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_lnrhl2/ElitePolice.mdl","models/vj_lnrhl2/police.mdl","models/vj_lnrhl2/combine_super_soldier.mdl","models/vj_lnrhl2/combine_soldier_prisonguard.mdl","models/vj_lnrhl2/combine_soldier.mdl"} 
ENT.MeleeAttackDamage = math.Rand(5,8)
ENT.HasDeathAnimation = false
ENT.AttackProps = false 
ENT.PushProps = false
ENT.HasLeapAttack = false
ENT.CanFlinch = 1
ENT.HitGroupFlinching_DefaultWhenNotHit = false
ENT.HitGroupFlinching_Values = {{HitGroup = {HITGROUP_HEAD}, Animation = {"vjges_flinch_head_01","vjges_flinch_head_02"}}, {HitGroup = {HITGROUP_STOMACH}, Animation = {"vjges_flinch_stomach_01","vjges_flinch_stomach_02"}}, {HitGroup = {HITGROUP_CHEST}, Animation = {"vjges_flinch_01","vjges_flinch_02"}}, {HitGroup = {HITGROUP_LEFTARM}, Animation = {"vjges_flinch_shoulder_l"}}, {HitGroup = {HITGROUP_RIGHTARM}, Animation = {"vjges_flinch_shoulder_r"}}, {HitGroup = {HITGROUP_LEFTLEG}, Animation = {"vjges_flinch_back_01"}}, {HitGroup = {HITGROUP_RIGHTLEG}, Animation = {"vjges_flinch_back_01"}}}
ENT.VJC_Data = {
	CameraMode = 1, -- Sets the default camera mode | 1 = Third Person, 2 = First Person
	ThirdP_Offset = Vector(45, 20, -15), -- The offset for the controller when the camera is in third person
	FirstP_Bone = "ValveBiped.Bip01_Head1", -- If left empty, the base will attempt to calculate a position for first person
	FirstP_Offset = Vector(10, 0, -5),  -- The offset for the controller when the camera is in first person
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
if self:GetModel() == "models/vj_lnrhl2/police.mdl" && self.LN_Armor == true then
self.LN_Armor = false
self:SetHealth(150)
self.SoundTbl_CombatIdle = {"vj_lnrhl2/cp/idle1.wav","vj_lnrhl2/cp/idle2.wav","vj_lnrhl2/cp/idle3.wav","vj_lnrhl2/cp/idle4.wav","vj_lnrhl2/cp/idle5.wav","vj_lnrhl2/cp/idle6.wav"}
self.SoundTbl_Idle = {"vj_lnrhl2/cp/idle1.wav","vj_lnrhl2/cp/idle2.wav","vj_lnrhl2/cp/idle3.wav","vj_lnrhl2/cp/idle4.wav","vj_lnrhl2/cp/idle5.wav","vj_lnrhl2/cp/idle6.wav"}
self.SoundTbl_Alert = {"vj_lnrhl2/cp/alert1.wav","vj_lnrhl2/cp/alert2.wav","vj_lnrhl2/cp/alert3.wav"}
self.SoundTbl_Pain = {"vj_lnrhl2/cp/pain1.wav","vj_lnrhl2/cp/pain2.wav","vj_lnrhl2/cp/pain3.wav","vj_lnrhl2/cp/pain4.wav"}
self.SoundTbl_Death = {"vj_lnrhl2/cp/die1.wav","vj_lnrhl2/cp/die2.wav","vj_lnrhl2/cp/die3.wav","vj_lnrhl2/cp/die4.wav"}
self.SoundTbl_BeforeMeleeAttack = {"vj_lnrhl2/cp/attack1.wav","vj_lnrhl2/cp/attack2.wav","vj_lnrhl2/cp/attack3.wav","vj_lnrhl2/cp/attack4.wav","vj_lnrhl2/cp/attack6.wav"}
self.SoundTbl_LeapAttackJump = {"vj_lnrhl2/cp/attack1.wav","vj_lnrhl2/cp/attack2.wav","vj_lnrhl2/cp/attack3.wav","vj_lnrhl2/cp/attack4.wav","vj_lnrhl2/cp/attack6.wav"}

elseif self:GetModel() == "models/vj_lnrhl2/elitepolice.mdl" then
self:SetHealth(175)
self.SoundTbl_CombatIdle = {"vj_lnrhl2/cp/idle1.wav","vj_lnrhl2/cp/idle2.wav","vj_lnrhl2/cp/idle3.wav","vj_lnrhl2/cp/idle4.wav","vj_lnrhl2/cp/idle5.wav","vj_lnrhl2/cp/idle6.wav"}
self.SoundTbl_Idle = {"vj_lnrhl2/cp/idle1.wav","vj_lnrhl2/cp/idle2.wav","vj_lnrhl2/cp/idle3.wav","vj_lnrhl2/cp/idle4.wav","vj_lnrhl2/cp/idle5.wav","vj_lnrhl2/cp/idle6.wav"}
self.SoundTbl_Alert = {"vj_lnrhl2/cp/alert1.wav","vj_lnrhl2/cp/alert2.wav","vj_lnrhl2/cp/alert3.wav"}
self.SoundTbl_Pain = {"vj_lnrhl2/cp/pain1.wav","vj_lnrhl2/cp/pain2.wav","vj_lnrhl2/cp/pain3.wav","vj_lnrhl2/cp/pain4.wav"}
self.SoundTbl_Death = {"vj_lnrhl2/cp/die1.wav","vj_lnrhl2/cp/die2.wav","vj_lnrhl2/cp/die3.wav","vj_lnrhl2/cp/die4.wav"}
self.SoundTbl_BeforeMeleeAttack = {"vj_lnrhl2/cp/attack1.wav","vj_lnrhl2/cp/attack2.wav","vj_lnrhl2/cp/attack3.wav","vj_lnrhl2/cp/attack4.wav","vj_lnrhl2/cp/attack6.wav"}
self.SoundTbl_LeapAttackJump = {"vj_lnrhl2/cp/attack1.wav","vj_lnrhl2/cp/attack2.wav","vj_lnrhl2/cp/attack3.wav","vj_lnrhl2/cp/attack4.wav","vj_lnrhl2/cp/attack6.wav"}
end

self:SetSkin(math.random(0,1))
self:SetCollisionBounds(Vector(16,16,20),Vector(-16,-16,0))
        self.AnimTbl_IdleStand = {ACT_IDLE_STIMULATED}
		self.AnimTbl_Walk = {ACT_WALK_STIMULATED}
		self.AnimTbl_Run = {ACT_WALK_STIMULATED}
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	local randattack_close = 1
    if randattack_close == 1 then
		self.AnimTbl_MeleeAttack = {"vjseq_crawlgrabshove"}
		self.MeleeAttackDistance = 20
		self.MeleeAttackDamageDistance = 55
		self.NextAnyAttackTime_Melee = 0.8	
end
end	
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo,hitgroup)
	if (dmginfo:IsBulletDamage()) && self.LN_Armor == true then
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
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink_AIEnabled()		
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_AfterDamage(dmginfo,hitgroup)
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/