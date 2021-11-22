AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_lnrspecials/drowner.mdl"} 
ENT.StartHealth = 125 
ENT.HullType = HULL_HUMAN
ENT.MovementType = VJ_MOVETYPE_AQUATIC 
ENT.Aquatic_SwimmingSpeed_Calm = 80 
ENT.Aquatic_SwimmingSpeed_Alerted = 150
ENT.Aquatic_AnimTbl_Calm = {ACT_RUN} 
ENT.Aquatic_AnimTbl_Alerted = {ACT_SPRINT}
ENT.CanFlinch = 0
ENT.FlinchChance = 5
ENT.NextFlinchTime = 1.5
ENT.AnimTbl_Flinch = {ACT_BIG_FLINCH} 
ENT.HasHitGroupFlinching = true 
ENT.HitGroupFlinching_DefaultWhenNotHit = false
ENT.HitGroupFlinching_Values = {{HitGroup = {HITGROUP_HEAD}, Animation = {"vjges_flinch_head_01","vjges_flinch_head_02"}}, {HitGroup = {HITGROUP_STOMACH}, Animation = {"vjges_flinch_stomach_01","vjges_flinch_stomach_02"}}, {HitGroup = {HITGROUP_CHEST}, Animation = {"vjges_flinch_01","vjges_flinch_02"}}, {HitGroup = {HITGROUP_LEFTARM}, Animation = {"vjges_flinch_shoulder_l"}}, {HitGroup = {HITGROUP_RIGHTARM}, Animation = {"vjges_flinch_shoulder_r"}}, {HitGroup = {HITGROUP_LEFTLEG}, Animation = {"vjges_flinch_back_01"}}, {HitGroup = {HITGROUP_RIGHTLEG}, Animation = {"vjges_flinch_back_01"}}}
ENT.ImmuneDamagesTable = {DMG_RADIATION,DMG_DROWN}
ENT.Immune_Fire = true 
ENT.AllowIgnition = false
ENT.VJC_Data = {
	CameraMode = 1, -- Sets the default camera mode | 1 = Third Person, 2 = First Person
	ThirdP_Offset = Vector(40, 20, -50), -- The offset for the controller when the camera is in third person
	FirstP_Bone = "ValveBiped.Bip01_Head1", -- If left empty, the base will attempt to calculate a position for first person
	FirstP_Offset = Vector(0, 0, 5), -- The offset for the controller when the camera is in first person
}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE"} 
ENT.BloodColor = "Red" 
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.HasMeleeAttack = true 
ENT.MeleeAttackDistance = 35
ENT.MeleeAttackDamageDistance = 65
ENT.MeleeAttackDamage = math.Rand(15,20)
ENT.MeleeAttackAnimationAllowOtherTasks = true
ENT.TimeUntilMeleeAttackDamage = false
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.DisableFootStepSoundTimer = true
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.HasDeathAnimation = false
ENT.DeathAnimationTime = 1.1
ENT.DeathAnimationChance = 2
ENT.AnimTbl_Death = {"vjseq_nz_death_1","vjseq_nz_death_2","vjseq_nz_death_3"} 
ENT.GeneralSoundPitch1 = 100
ENT.GeneralSoundPitch2 = 100
---------------------------------------------------------------------------------------------------------------------------------------------
--custom
ENT.LNR_VirusInfection = true
ENT.LNR_IsDrowner = true
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"npc/zombie/foot1.mp3","npc/zombie/foot2.mp3","npc/zombie/foot3.mp3"}
ENT.SoundTbl_Idle = {"drowner/idle.wav","drowner/idle_03.wav","drowner/idle_05.wav"}
ENT.SoundTbl_Alert = {"drowner/idle_05.wav"}
ENT.SoundTbl_CombatIdle = {"drowner/idle.wav","drowner/idle_03.wav","drowner/idle_05.wav","drowner/idle_05.wav"} 
ENT.SoundTbl_Pain = {"drowner/idle.wav","drowner/idle_03.wav","drowner/idle_05.wav"}
ENT.SoundTbl_Death = {"drowner/idle_05.wav"}
ENT.SoundTbl_MeleeAttack = {"vj_lnrhl2/claw_strike1.mp3","vj_lnrhl2/claw_strike2.mp3","vj_lnrhl2/claw_strike3.mp3"}
ENT.SoundTbl_BeforeMeleeAttack = {"drowner/idle.wav","drowner/idle_03.wav","drowner/idle_05.wav","drowner/idle_05.wav"} 
ENT.SoundTbl_MeleeAttackMiss = {"npc/zombie/claw_miss2.wav","npc/zombie/claw_miss1.wav"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "step" then
		self:FootStepSoundCode()
	end
	
	if key == "attack" then
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
function ENT:CustomOnPreInitialize() 
self.StartHealth = self.StartHealth * GetConVarNumber("VJ_LNR_Walker_HealthModifier")	
self:SetHealth(self.StartHealth)
self.MeleeAttackDamage = self.MeleeAttackDamage * GetConVarNumber("VJ_LNR_Walker_DamageModifier")

if GetConVarNumber("VJ_LNR_Alert") == 0 then 
		self.CallForHelp = false
end

if GetConVarNumber("VJ_LNR_Infection") == 0 then 
		self.LNR_VirusInfection = false 
    end	
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GetSightDirection()
	return self:GetAttachment(self:LookupAttachment("eyes")).Ang:Forward() -- Attachment example
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	local randattack_moving = math.random(1,8)

	if randattack_moving == 1 then
		self.AnimTbl_MeleeAttack = {"vjges_nz_attack_run_ad_1"}	
		self.NextAnyAttackTime_Melee = 0.6999999833107

	elseif randattack_moving == 2 then
		self.AnimTbl_MeleeAttack = {"vjges_nz_attack_run_ad_2"}
		self.NextAnyAttackTime_Melee = 0.73333332750532

	elseif randattack_moving == 3 then
		self.AnimTbl_MeleeAttack = {"vjges_nz_attack_run_ad_3"}
		self.NextAnyAttackTime_Melee = 0.5666666621632

	elseif randattack_moving == 4 then
		self.AnimTbl_MeleeAttack = {"vjges_nz_attack_run_ad_4"}	
		self.NextAnyAttackTime_Melee = 0.73333332750532

	elseif randattack_moving == 5 then
		self.AnimTbl_MeleeAttack = {"vjges_nz_attack_run_au_1"}	
		self.NextAnyAttackTime_Melee = 0.6999999833107 
		
	elseif randattack_moving == 6 then
		self.AnimTbl_MeleeAttack = {"vjges_nz_attack_run_au_2"}	
		self.NextAnyAttackTime_Melee = 0.73333332750532
		
	elseif randattack_moving == 7 then
		self.AnimTbl_MeleeAttack = {"vjges_nz_attack_run_au_3"}
		self.NextAnyAttackTime_Melee = 0.5666666621632
		
	elseif randattack_moving == 8 then
		self.AnimTbl_MeleeAttack = {"vjges_nz_attack_run_au_4"}
		self.NextAnyAttackTime_Melee = 0.73333332750532
	end
end							
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/