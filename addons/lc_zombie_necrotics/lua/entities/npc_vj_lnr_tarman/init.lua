AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2018 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_lnrhl2/Tarman.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 80 
ENT.HullType = HULL_HUMAN
ENT.CanFlinch = 1
ENT.FlinchChance = 3
ENT.NextFlinchTime = 1.5
ENT.AnimTbl_Flinch = {ACT_BIG_FLINCH} 
ENT.HasHitGroupFlinching = true 
ENT.HitGroupFlinching_DefaultWhenNotHit = false
ENT.HitGroupFlinching_Values = {{HitGroup = {HITGROUP_HEAD}, Animation = {"vjges_flinch_head_01","vjges_flinch_head_02"}}, {HitGroup = {HITGROUP_STOMACH}, Animation = {"vjges_flinch_stomach_01","vjges_flinch_stomach_02","ShoveReactBehind"}}, {HitGroup = {HITGROUP_CHEST}, Animation = {"vjges_flinch_01","vjges_flinch_02","ShoveReact"}}, {HitGroup = {HITGROUP_LEFTARM}, Animation = {"vjges_flinch_shoulder_l"}}, {HitGroup = {HITGROUP_RIGHTARM}, Animation = {"vjges_flinch_shoulder_r"}}, {HitGroup = {HITGROUP_LEFTLEG}, Animation = {"vjges_flinch_back_01"}}, {HitGroup = {HITGROUP_RIGHTLEG}, Animation = {"vjges_flinch_back_01"}}}
ENT.ImmuneDamagesTable = {DMG_RADIATION}
ENT.OnlyDoKillEnemyWhenClear = false
ENT.VJC_Data = {
	CameraMode = 1, -- Sets the default camera mode | 1 = Third Person, 2 = First Person
	ThirdP_Offset = Vector(40, 10, -50), -- The offset for the controller when the camera is in third person
	FirstP_Bone = "ValveBiped.Bip01_Head1", -- If left empty, the base will attempt to calculate a position for first person
	FirstP_Offset = Vector(0, 0, 5), -- The offset for the controller when the camera is in first person
}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE"} 
ENT.BloodColor = "Oil" 
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.HasMeleeAttack = true 
ENT.MeleeAttackDamage = math.Rand(100,200)
ENT.HasOnKilledEnemySound = true
ENT.SlowPlayerOnMeleeAttack = true 
ENT.SlowPlayerOnMeleeAttack_WalkSpeed = 30
ENT.SlowPlayerOnMeleeAttack_RunSpeed = 45
ENT.SlowPlayerOnMeleeAttackTime = 2.5
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.MeleeAttackBleedEnemy = true 
ENT.MeleeAttackBleedEnemyChance = 2
ENT.MeleeAttackBleedEnemyDamage = 6
ENT.MeleeAttackBleedEnemyTime = 2.5
ENT.MeleeAttackBleedEnemyReps = 10
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.InvestigateSoundDistance = 4000
ENT.DisableFootStepSoundTimer = true
ENT.AnimTbl_Run = {ACT_WALK}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.HasDeathAnimation = true
ENT.DeathAnimationTime = 1.5
ENT.DeathAnimationChance = 2
ENT.AnimTbl_Death = {"vjseq_nz_death_1","vjseq_nz_death_2","vjseq_nz_death_3"} 
ENT.GeneralSoundPitch1 = 100
ENT.GeneralSoundPitch2 = 100
---------------------------------------------------------------------------------------------------------------------------------------------
--custom
ENT.LN_VirusInfection = true
ENT.LN_IsWalker = false
ENT.LN_Run = false

	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"npc/zombie/foot1.wav","npc/zombie/foot2.wav","npc/zombie/foot3.wav"}
ENT.SoundTbl_Idle = {"vj_lnrhl2/vj_lnrhl2/tarman/alert1.wav","vj_lnrhl2/tarman/alert2.wav","vj_lnrhl2/tarman/alert3.wav","vj_lnrhl2/tarman/alert4.wav","vj_lnrhl2/tarman/alert5.wav","vj_lnrhl2/tarman/alert6.mp3"}
ENT.SoundTbl_Alert = {"vj_lnrhl2/tarman/alert1.wav","vj_lnrhl2/tarman/alert2.wav","vj_lnrhl2/tarman/alert3.wav","vj_lnrhl2/tarman/alert4.wav","vj_lnrhl2/tarman/alert5.wav","vj_lnrhl2/tarman/alert6.mp3"}
ENT.SoundTbl_MeleeAttack = {"vj_lnrhl2/npc/melee/hit_punch_08.wav","vj_lnrhl2/npc/melee/hit_punch_07.wav","vj_lnrhl2/npc/melee/hit_punch_06.wav","vj_lnrhl2/npc/melee/hit_punch_05.wav","vj_lnrhl2/npc/melee/hit_punch_04.wav","vj_lnrhl2/npc/melee/hit_punch_03.wav","vj_lnrhl2/npc/melee/hit_punch_02.wav","vj_lnrhl2/npc/melee/hit_punch_01.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"npc/zombie/claw_miss2.wav","npc/zombie/claw_miss1.wav"}
ENT.SoundTbl_Death = {"vj_lnrhl2/tarman/death.wav"}
ENT.SoundTbl_OnKilledEnemy = {"vj_lnrhl2/tarman/attack.wav"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "step" then
		self:FootStepSoundCode()
	end
	
	if key == "attack_leap" then
		self:MeleeAttackCode() 
    end	
	
	if key == "attack_leap" then
		self:LeapDamageCode() 
    end	
	
	if key == "death" then
		VJ_EmitSound(self, "physics/flesh/flesh_impact_hard"..math.random(1,5)..".wav", 85, math.random(100,100))
	end		
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnChangeMovementType(movType)	
	if VJ_AnimationExists(self,ACT_JUMP) == true then self:CapabilitiesRemove(bit.bor(CAP_MOVE_JUMP)) end
	if VJ_AnimationExists(self,ACT_CLIMB_UP) == true then self:CapabilitiesRemove(bit.bor(CAP_MOVE_CLIMB)) end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPreInitialize() 
self.MeleeAttackDamage = self.MeleeAttackDamage * GetConVarNumber("vj_LNR_Walker_DamageModifier")
self.StartHealth = self.StartHealth * GetConVarNumber("vj_LNR_Walker_HealthModifier")	
self:SetHealth(self.StartHealth)
self.MeleeAttackBleedEnemyDamage = self.MeleeAttackBleedEnemyDamage * GetConVarNumber("vj_LNR_BleedDamage")
self.MeleeAttackBleedEnemyReps = self.MeleeAttackBleedEnemyReps * GetConVarNumber("vj_LNR_BleedReps")
self.MeleeAttackBleedEnemyChance = self.MeleeAttackBleedEnemyChance * GetConVarNumber("vj_LNR_BleedChance")
self.LeapAttackDamage = self.LeapAttackDamage * GetConVarNumber("vj_LNR_LeapDamage")

if GetConVarNumber("vj_LNR_Infection") == 0 then 
		self.LN_VirusInfection = false 
end	
	
if GetConVarNumber("vj_LNR_DeathAnimations") == 0 then 
		self.HasDeathAnimation = false	
end

if GetConVarNumber("vj_LNR_InfectionDamage") == 0 then 
		self.SlowPlayerOnMeleeAttack = false
		self.MeleeAttackBleedEnemy = false
end

if GetConVarNumber("vj_LNR_Leap") == 0 then 
		self.HasLeapAttack = false 
end

if math.random(1,3) == 1 then
self.AnimTbl_IdleStand = {ACT_IDLE_RELAXED}
end
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
if GetConVarNumber("vj_LNR_InfectionDamage") == 1 then
self.SlowPlayerOnMeleeAttackTime = self.SlowPlayerOnMeleeAttackTime * GetConVarNumber("vj_LNR_SlowTime")
end
end
-----------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAlert()
if math.random(1,5) == 1 then
        self:VJ_ACT_PLAYACTIVITY("vjseq_nz_taunt_7",true,2,true)	
end
end
-------------------------------------------------------------------------------------------------------------------
function ENT:CustomDeathAnimationCode(dmginfo,hitgroup)
	if self:IsMoving() then -- When moving
	   self.AnimTbl_Death = {"vjseq_nz_death_f_1","vjseq_nz_death_f_2","vjseq_nz_death_f_3","vjseq_nz_death_f_4","vjseq_nz_death_f_5","vjseq_nz_death_f_6","vjseq_nz_death_f_7","vjseq_nz_death_f_8","vjseq_nz_death_f_9","vjseq_nz_death_f_10","vjseq_nz_death_f_11","vjseq_nz_death_f_12","vjseq_nz_death_f_13"}	
	   self.DeathAnimationTime = 1
end
    if self:IsOnFire() && self.Immune_Fire == false then -- When killed by fire damage
	   self.AnimTbl_Death = {"vjseq_nz_death_fire_1","vjseq_nz_death_fire_2","vjges_nz_death_fire_3","vjges_nz_death_fire_4","vjges_nz_death_fire_5"} 
	   self.DeathAnimationTime = 1.6
end	   
    if dmginfo:IsExplosionDamage() then -- When killed by explosion damage
	   self.AnimTbl_Death = {"vjseq_nz_death_expl_f_1","vjseq_nz_death_expl_f_2","vjseq_nz_death_expl_f_3","vjseq_nz_death_expl_b_1","vjseq_nz_death_expl_l_1","vjseq_nz_death_expl_l_1"}	
	   self.DeathAnimationTime = 1
end
    if dmginfo:IsDamageType(DMG_SHOCK) then -- When killed by shock damage
	--for i = 0,self:GetBoneCount() -1 do
	    --ParticleEffect("electrical_arc_01_parent",self:GetBonePosition(i),Angle(0,0,0),nil)
--end
	   self.AnimTbl_Death = {"vjseq_nz_death_elec_1","vjseq_nz_death_elec_2","vjseq_nz_death_elec_3","vjseq_nz_death_elec_4"} --"vjseq_nz_death_elec_5"	
	   self.DeathAnimationTime = 3.4
end
end
----------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	local randattack_close = 1
    if randattack_close == 1 then
        self.MeleeAttackDistance = 18
	    self.MeleeAttackDamageDistance = 55
		self.AnimTbl_MeleeAttack = {"vjseq_Choke_Eat"}
	    self.TimeUntilMeleeAttackDamage = false
        self.NextAnyAttackTime_Melee = 1.4
		self.MeleeAttackDamageType = DMG_SLASH		
	end
end	
/*-----------------------------------------------
	*** Copyright (c) 2012-2018 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/