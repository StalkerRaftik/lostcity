AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_lnrspecials/carrier.mdl"} 
ENT.StartHealth = 250 
ENT.HasHealthRegeneration = true 
ENT.HealthRegenerationAmount = 8
ENT.HealthRegenerationDelay = VJ_Set(1,1.5) 
ENT.HealthRegenerationResetOnDmg = true
ENT.HullType = HULL_HUMAN
ENT.CanFlinch = 1
ENT.FlinchChance = 1.5
ENT.NextFlinchTime = 1.5
ENT.AnimTbl_Flinch = {ACT_BIG_FLINCH} 
ENT.HasHitGroupFlinching = true 
ENT.HitGroupFlinching_DefaultWhenNotHit = false
ENT.HitGroupFlinching_Values = {
{HitGroup = {HITGROUP_HEAD}, Animation = {"vjges_flinch_head_01","vjges_flinch_head_02"}}, 
{HitGroup = {HITGROUP_STOMACH}, Animation = {"vjges_flinch_stomach_01","vjges_flinch_stomach_02"}}, 
{HitGroup = {HITGROUP_CHEST}, Animation = {"vjges_flinch_01","vjges_flinch_02"}}, 
{HitGroup = {HITGROUP_LEFTARM}, Animation = {"vjges_flinch_shoulder_l"}}, 
{HitGroup = {HITGROUP_RIGHTARM}, Animation = {"vjges_flinch_shoulder_r"}}, 
{HitGroup = {HITGROUP_LEFTLEG}, Animation = {"vjges_flinch_back_01"}}, 
{HitGroup = {HITGROUP_RIGHTLEG}, Animation = {"vjges_flinch_back_01"}}}
ENT.ImmuneDamagesTable = {DMG_RADIATION}
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
ENT.MeleeAttackBleedEnemy = true 
ENT.MeleeAttackBleedEnemyChance = 2
ENT.MeleeAttackBleedEnemyDamage = 200
ENT.MeleeAttackBleedEnemyTime = 15
ENT.MeleeAttackBleedEnemyReps = 1
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.DisableFootStepSoundTimer = true
ENT.AnimTbl_Run = {ACT_RUN}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.HasDeathAnimation = true
ENT.DeathAnimationTime = 1.5
ENT.DeathAnimationChance = 2
ENT.AnimTbl_Death = {"vjseq_nz_death_1","vjseq_nz_death_2","vjseq_nz_death_3"} 
ENT.GeneralSoundPitch1 = 100
ENT.GeneralSoundPitch2 = 100
ENT.GibOnDeathDamagesTable = {"All"}
---------------------------------------------------------------------------------------------------------------------------------------------
--custom
ENT.LNR_VirusInfection = true
ENT.LNR_IsWalker = true
ENT.LNR_NextStumble = CurTime()

	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"misc/concrete1.wav","misc/concrete2.wav","misc/concrete3.wav","misc/concrete4.wav"}
ENT.SoundTbl_Idle = {"carrier/zcarrier_taunt-19.wav","carrier/zcarrier_taunt-18.wav","carrier/zcarrier_taunt-17.wav","carrier/zcarrier_taunt-16.wav","carrier/zcarrier_taunt-15.wav","carrier/zcarrier_taunt-14.wav","carrier/zcarrier_taunt-13.wav","carrier/zcarrier_taunt-12.wav","carrier/zcarrier_taunt-11.wav","carrier/zcarrier_taunt-10.wav","carrier/zcarrier_taunt-09.wav","carrier/zcarrier_taunt-08.wav","carrier/zcarrier_taunt-07.wav","carrier/zcarrier_taunt-06.wav","carrier/zcarrier_taunt-05.wav","carrier/zcarrier_taunt-04.wav","carrier/zcarrier_taunt-03.wav","carrier/zcarrier_taunt-02.wav","carrier/zcarrier_taunt-01.wav"}
ENT.SoundTbl_Alert = {"carrier/carrier_berserk-07.wav","carrier/carrier_berserk-06.wav","carrier/carrier_berserk-05.wav","carrier/carrier_berserk-03.wav","carrier/carrier_berserk-03.wav","carrier/carrier_berserk-02.wav","carrier/carrier_berserk-01.wav"} 
ENT.SoundTbl_CombatIdle = {"carrier/zcarrier_taunt-19.wav","carrier/zcarrier_taunt-18.wav","carrier/zcarrier_taunt-17.wav","carrier/zcarrier_taunt-16.wav","carrier/zcarrier_taunt-15.wav","carrier/zcarrier_taunt-14.wav","carrier/zcarrier_taunt-13.wav","carrier/zcarrier_taunt-12.wav","carrier/zcarrier_taunt-11.wav","carrier/zcarrier_taunt-10.wav","carrier/zcarrier_taunt-09.wav","carrier/zcarrier_taunt-08.wav","carrier/zcarrier_taunt-07.wav","carrier/zcarrier_taunt-06.wav","carrier/zcarrier_taunt-05.wav","carrier/zcarrier_taunt-04.wav","carrier/zcarrier_taunt-03.wav","carrier/zcarrier_taunt-02.wav","carrier/zcarrier_taunt-01.wav","carrier/carrier_berserk-07.wav","carrier/carrier_berserk-06.wav","carrier/carrier_berserk-05.wav","carrier/carrier_berserk-03.wav","carrier/carrier_berserk-03.wav","carrier/carrier_berserk-02.wav","carrier/carrier_berserk-01.wav"} 
ENT.SoundTbl_Pain = {"carrier/zcarrier_pain-13.wav","carrier/zcarrier_pain-12.wav","carrier/zcarrier_pain-11.wav","carrier/zcarrier_pain-10.wav","carrier/zcarrier_pain-09.wav","carrier/zcarrier_pain-08.wav","carrier/zcarrier_pain-07.wav","carrier/zcarrier_pain-06.wav","carrier/zcarrier_pain-05.wav","carrier/zcarrier_pain-04.wav","carrier/zcarrier_pain-03.wav","carrier/zcarrier_pain-02.wav","carrier/zcarrier_pain-01.wav"}
ENT.SoundTbl_Death = {"carrier/zcarrier_death-01.wav","carrier/zcarrier_death-15.wav","carrier/zcarrier_death-14.wav","carrier/zcarrier_death-13.wav","carrier/zcarrier_death-12.wav","carrier/zcarrier_death-11.wav","carrier/zcarrier_death-10.wav","carrier/zcarrier_death-09.wav","carrier/zcarrier_death-07.wav","carrier/zcarrier_death-07.wav","carrier/zcarrier_death-06.wav","carrier/zcarrier_death-05.wav","carrier/zcarrier_death-04.wav","carrier/zcarrier_death-03.wav","carrier/zcarrier_death-02.wav"}
ENT.SoundTbl_MeleeAttack = {"carrier/z_hit-01.wav","carrier/z_hit-02.wav","carrier/z_hit-03.wav","carrier/z_hit-04.wav","carrier/z_hit-05.wav","carrier/z_hit-06.wav"}
ENT.SoundTbl_BeforeMeleeAttack = {"carrier/zcarrier_attack-01.wav","carrier/zcarrier_attack-02.wav","carrier/zcarrier_attack-03.wav","carrier/zcarrier_attack-04.wav","carrier/zcarrier_attack-05.wav","carrier/zcarrier_attack-06.wav","carrier/zcarrier_attack-07.wav","carrier/zcarrier_attack-08.wav","carrier/zcarrier_attack-09.wav","carrier/zcarrier_attack-10.wav","carrier/zcarrier_attack-11.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"carrier/z-swipe-1.wav","carrier/z-swipe-2.wav","carrier/z-swipe-3.wav","carrier/z-swipe-4.wav","carrier/z-swipe-5.wav","carrier/z-swipe-6.wav"}
ENT.SoundTbl_OnKilledEnemy = {"carrier/activate.wav","carrier/deactivate.wav"}
ENT.SoundTbl_MeleeAttackSlowPlayer = {"ambient/voices/cough1.wav","ambient/voices/cough2.wav","ambient/voices/cough3.wav","ambient/voices/cough4.wav"}
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

if GetConVarNumber("VJ_LNR_Gib") == 0 then
        self.AllowedToGib = false 
        self.HasGibOnDeath = false 
        self.HasGibOnDeathSounds = false 
        self.HasGibDeathParticles = false
end

if math.random(1,3) == 1 then
        self:SetSkin(1)
        self.LN_IsWalker = false
        self.AnimTbl_Run = {ACT_SPRINT}	
    end
end
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
function ENT:CustomOnChangeMovementType(movType)	
	if VJ_AnimationExists(self,ACT_JUMP) == true then self:CapabilitiesRemove(bit.bor(CAP_MOVE_JUMP)) end
	if VJ_AnimationExists(self,ACT_CLIMB_UP) == true then self:CapabilitiesRemove(bit.bor(CAP_MOVE_CLIMB)) end
end
---------------------------------------------------------------
function ENT:CustomOnDoKilledEnemy(argent,attacker,inflictor)	
if math.random(1,5) == 1 then
        self:VJ_ACT_PLAYACTIVITY("vjseq_nz_taunt_7",true,2,true)	
end
end
------------------------------------------------------------------
function ENT:CustomOnAlert(argent)
if math.random(1,5) == 1 then
        self:VJ_ACT_PLAYACTIVITY("vjseq_nz_sonic_attack_1",true,2,true)
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GetSightDirection()
	return self:GetAttachment(self:LookupAttachment("eyes")).Ang:Forward() -- Attachment example
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink_AIEnabled()	
		if IsValid(self:GetEnemy()) then
			self.AnimTbl_IdleStand = {ACT_IDLE_ANGRY}
	    else
		    self.AnimTbl_IdleStand = {ACT_IDLE}	
	end		
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_AfterDamage(dmginfo,hitgroup)
	 if math.random (1,16) == 1 then
		 if self.LNR_NextStumble < CurTime() then
			 self:VJ_ACT_PLAYACTIVITY("ShoveReact",true,1.6)
	end		 self.LNR_NextStumble = CurTime() + 10
end			 
	 if math.random (1,16) == 1 then		 
		 if self.LNR_NextStumble < CurTime() then
			 self:VJ_ACT_PLAYACTIVITY("ShoveReactBehind",true,1.6)
			 self.LNR_NextStumble = CurTime() + 10			 
		end	 
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	local randattack_stand = math.random(9,12)
	local randattack_moving = math.random(1,8)

	if randattack_moving == 1 && self:IsMoving() then
		self.AnimTbl_MeleeAttack = {"vjges_nz_attack_run_ad_1"}	
		self.NextAnyAttackTime_Melee = 0.6999999833107

	elseif randattack_moving == 2 && self:IsMoving() then
		self.AnimTbl_MeleeAttack = {"vjges_nz_attack_run_ad_2"}
		self.NextAnyAttackTime_Melee = 0.73333332750532

	elseif randattack_moving == 3 && self:IsMoving() then
		self.AnimTbl_MeleeAttack = {"vjges_nz_attack_run_ad_3"}
		self.NextAnyAttackTime_Melee = 0.5666666621632

	elseif randattack_moving == 4 && self:IsMoving() then
		self.AnimTbl_MeleeAttack = {"vjges_nz_attack_run_ad_4"}	
		self.NextAnyAttackTime_Melee = 0.73333332750532

	elseif randattack_moving == 5 && self:IsMoving() then
		self.AnimTbl_MeleeAttack = {"vjges_nz_attack_run_au_1"}	
		self.NextAnyAttackTime_Melee = 0.6999999833107 
		
	elseif randattack_moving == 6 && self:IsMoving() then
		self.AnimTbl_MeleeAttack = {"vjges_nz_attack_run_au_2"}	
		self.NextAnyAttackTime_Melee = 0.73333332750532
		
	elseif randattack_moving == 7 && self:IsMoving() then
		self.AnimTbl_MeleeAttack = {"vjges_nz_attack_run_au_3"}
		self.NextAnyAttackTime_Melee = 0.5666666621632
		
	elseif randattack_moving == 8 && self:IsMoving() then
		self.AnimTbl_MeleeAttack = {"vjges_nz_attack_run_au_4"}
		self.NextAnyAttackTime_Melee = 0.73333332750532
		
	elseif randattack_stand == 9 then
		self.AnimTbl_MeleeAttack = {"vjseq_nz_attack_stand_ad_1"}
		self.NextAnyAttackTime_Melee = 1.7999999141693

	elseif randattack_stand == 10 then
		self.AnimTbl_MeleeAttack = {"vjseq_nz_attack_stand_ad_2-2"}
		self.NextAnyAttackTime_Melee = 1.7999999141693

	elseif randattack_stand == 11 then
		self.AnimTbl_MeleeAttack = {"vjseq_nz_attack_stand_ad_2-3"}
		self.NextAnyAttackTime_Melee = 1.3666666340828
		
    elseif randattack_stand == 12 then
		self.AnimTbl_MeleeAttack = {"vjseq_nz_attack_stand_ad_2-4"}	
		self.NextAnyAttackTime_Melee = 4	
	end
end		
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetUpGibesOnDeath(dmginfo,hitgroup)
if GetConVarNumber("VJ_LNR_Gib") == 1 then
	if hitgroup == HITGROUP_HEAD && dmginfo:GetDamageForce():Length() > 800 then
	    self:EmitSound(Sound("vj_lnrhl2/headshot.mp3",250))
		self:SetBodygroup(1,math.random(1,3))
		self:SetBodygroup(2,math.random(1,3))
		self:SetBodygroup(0,math.random(1,3))

		if self.HasGibDeathParticles == true then
			for i=1,3 do
				ParticleEffect("blood_impact_red_01",self:GetAttachment(self:LookupAttachment("forward")).Pos,self:GetAngles())
				
		local bloodeffect = ents.Create("info_particle_system")
		bloodeffect:SetKeyValue("effect_name","blood_zombie_split_spray")
		bloodeffect:SetPos(self:GetAttachment(self:LookupAttachment("forward")).Pos)
		bloodeffect:SetAngles(self:GetAttachment(self:LookupAttachment("forward")).Ang)
		bloodeffect:SetParent(self)
		bloodeffect:Fire("SetParentAttachment","forward")
		bloodeffect:Spawn()
		bloodeffect:Activate()
		bloodeffect:Fire("Start","",0)
		bloodeffect:Fire("Kill","",2)
				
	end
end		
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_01.mdl",{Pos=self:LocalToWorld(Vector(0,0,50))})
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_02.mdl",{Pos=self:LocalToWorld(Vector(0,0,50))})
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_03.mdl",{Pos=self:LocalToWorld(Vector(0,0,50))})
		return true,{DeathAnim=true,AllowCorpse=true}
	  end
   end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo,hitgroup,GetCorpse)
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
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/