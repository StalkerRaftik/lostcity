AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_lnrhl2/elitepolice.mdl","models/vj_lnrhl2/police.mdl","models/vj_lnrhl2/combine_super_soldier.mdl","models/vj_lnrhl2/combine_soldier_prisonguard.mdl","models/vj_lnrhl2/combine_soldier.mdl"} 
ENT.StartHealth = 250 
ENT.HullType = HULL_HUMAN
ENT.CanFlinch = 1
ENT.FlinchChance = 8
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
ENT.HasItemDropsOnDeath = true 
ENT.ItemDropsOnDeathChance = 2
ENT.ItemDropsOnDeath_EntityList = {"item_ammo_ar2","item_ammo_pistol","item_ammo_357","item_ammo_smg1","item_box_buckshot","weapon_frag","item_battery","item_ammo_crossbow","item_ammo_ar2_altfire","item_rpg_round","weapon_stunstick"}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.HasMeleeAttack = true 
ENT.MeleeAttackDistance = 35
ENT.MeleeAttackDamageDistance = 65
ENT.TimeUntilMeleeAttackDamage = false
ENT.MeleeAttackAnimationAllowOtherTasks = true
ENT.MeleeAttackDamage = math.Rand(10,15)
ENT.HasOnKilledEnemySound = false
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.SlowPlayerOnMeleeAttack = true 
ENT.SlowPlayerOnMeleeAttack_WalkSpeed = 30
ENT.SlowPlayerOnMeleeAttack_RunSpeed = 45
ENT.SlowPlayerOnMeleeAttackTime = math.Rand(0.8,1.5)
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.MeleeAttackBleedEnemy = true 
ENT.MeleeAttackBleedEnemyChance = 2
ENT.MeleeAttackBleedEnemyDamage = math.Rand(6,8)
ENT.MeleeAttackBleedEnemyTime = 2.5
ENT.MeleeAttackBleedEnemyReps = math.Rand(5,10)
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.HasLeapAttack = true  
ENT.LeapAttackDamage = math.Rand(8,12)
ENT.TimeUntilLeapAttackDamage = 0.5
ENT.LeapAttackDamageType = DMG_NERVEGAS
ENT.AnimTbl_LeapAttack = {"vjseq_Choke_Eat"} 
ENT.LeapAttackAnimationFaceEnemy = true  
ENT.NextAnyAttackTime_Leap = 1
ENT.NextLeapAttackTime = math.Rand(8,12) 
ENT.LeapDistance = 70
ENT.LeapToMeleeDistance = 50 
ENT.LeapAttackDamageDistance = 55 
ENT.LeapAttackVelocityForward = 100
ENT.LeapAttackVelocityUp = 0 
ENT.LeapAttackVelocityRight = 0
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.InvestigateSoundDistance = 10
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
ENT.LN_IsWalker = true
ENT.LN_Run = false
ENT.LN_Armor = true
ENT.LN_NextStumble = CurTime()

	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"vj_lnrhl2/npc/zombine/gear1.mp3","vj_lnrhl2/npc/zombine/gear2.mp3","vj_lnrhl2/npc/zombine/gear3.mp3"}
ENT.SoundTbl_CombatIdle = {"vj_lnrhl2/npc/zombine/zombine_alert1.mp3","vj_lnrhl2/npc/zombine/zombine_alert2.mp3","vj_lnrhl2/npc/zombine/zombine_alert3.mp3","vj_lnrhl2/npc/zombine/zombine_alert4.mp3","vj_lnrhl2/npc/zombine/zombine_alert5.mp3","vj_lnrhl2/npc/zombine/zombine_alert6.mp3","vj_lnrhl2/npc/zombine/zombine_alert7.mp3","vj_lnrhl2/npc/zombine/zombine_charge1.mp3","vj_lnrhl2/npc/zombine/zombine_charge2.mp3"}
ENT.SoundTbl_Idle = {"vj_lnrhl2/npc/zombine/zombine_idle1.mp3","vj_lnrhl2/npc/zombine/zombine_idle2.mp3","vj_lnrhl2/npc/zombine/zombine_idle3.mp3","vj_lnrhl2/npc/zombine/zombine_idle4.mp3"}
ENT.SoundTbl_Alert = {"vj_lnrhl2/npc/zombine/zombine_alert1.mp3","vj_lnrhl2/npc/zombine/zombine_alert2.mp3","vj_lnrhl2/npc/zombine/zombine_alert3.mp3","vj_lnrhl2/npc/zombine/zombine_alert4.mp3","vj_lnrhl2/npc/zombine/zombine_alert5.mp3","vj_lnrhl2/npc/zombine/zombine_alert6.mp3","vj_lnrhl2/npc/zombine/zombine_alert7.mp3","vj_lnrhl2/npc/zombine/zombine_charge1.mp3","vj_lnrhl2/npc/zombine/zombine_charge2.mp3"}
ENT.SoundTbl_Pain = {"vj_lnrhl2/npc/zombine/zombine_pain1.mp3","vj_lnrhl2/npc/zombine/zombine_pain2.mp3","vj_lnrhl2/npc/zombine/zombine_pain3.mp3","vj_lnrhl2/npc/zombine/zombine_pain4.mp3"}
ENT.SoundTbl_Death = {"vj_lnrhl2/npc/zombine/zombine_die1.mp3","vj_lnrhl2/npc/zombine/zombine_die2.mp3"}
ENT.SoundTbl_MeleeAttack = {"vj_lnrhl2/claw_strike1.mp3","vj_lnrhl2/claw_strike2.mp3","vj_lnrhl2/claw_strike3.mp3"}
ENT.SoundTbl_MeleeAttackMiss = {"npc/zombie/claw_miss2.wav","npc/zombie/claw_miss1.wav"}
ENT.SoundTbl_BeforeMeleeAttack = {"vj_lnrhl2/npc/zombine/zombine_alert1.mp3","vj_lnrhl2/npc/zombine/zombine_alert2.mp3","vj_lnrhl2/npc/zombine/zombine_alert3.mp3","vj_lnrhl2/npc/zombine/zombine_alert4.mp3","vj_lnrhl2/npc/zombine/zombine_alert5.mp3","vj_lnrhl2/npc/zombine/zombine_alert6.mp3","vj_lnrhl2/npc/zombine/zombine_alert7.mp3","vj_lnrhl2/npc/zombine/zombine_charge1.mp3","vj_lnrhl2/npc/zombine/zombine_charge2.mp3"}
ENT.SoundTbl_LeapAttackJump = {"vj_lnrhl2/npc/zombine/zombine_alert1.mp3","vj_lnrhl2/npc/zombine/zombine_alert2.mp3","vj_lnrhl2/npc/zombine/zombine_alert3.mp3","vj_lnrhl2/npc/zombine/zombine_alert4.mp3","vj_lnrhl2/npc/zombine/zombine_alert5.mp3","vj_lnrhl2/npc/zombine/zombine_alert6.mp3","vj_lnrhl2/npc/zombine/zombine_alert7.mp3","vj_lnrhl2/npc/zombine/zombine_charge1.mp3","vj_lnrhl2/npc/zombine/zombine_charge2.mp3"}
ENT.SoundTbl_LeapAttackDamage = {"hit_punch_08.wav","hit_punch_07.wav","hit_punch_06.wav","hit_punch_05.wav","hit_punch_04.wav","hit_punch_03.wav","hit_punch_02.wav","hit_punch_01.wav"}
ENT.SoundTbl_LeapAttackDamageMiss = {"npc/zombie/claw_miss2.wav","npc/zombie/claw_miss1.wav"}
ENT.SoundTbl_MeleeAttackSlowPlayer = {"vj_lnrhl2/losthope.mp3"}
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
if GetConVarNumber("vj_LNR_Alert") == 0 then 
		self.CallForHelp = false
end
if math.random(1,3) == 1 && GetConVarNumber("vj_LNR_WalkerRun") == 1 then 
		self.AnimTbl_Run = {ACT_RUN}
end

if math.random(1,3) == 1 then
self.AnimTbl_IdleStand = {ACT_IDLE_RELAXED}
end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_SlowPlayer(TheHitEntity) 
self.SlowPlayerOnMeleeAttackTime = self.SlowPlayerOnMeleeAttackTime * GetConVarNumber("vj_LNR_SlowTime")
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
function ENT:GetSightDirection()
	return self:GetAttachment(self:LookupAttachment("eyes")).Ang:Forward() -- Attachment example
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	local randattack_stand = math.random(9,12)
	local randattack_moving = math.random(1,8)

	if randattack_moving == 1 && self:IsMoving() then
		self.AnimTbl_MeleeAttack = {"vjges_nz_attack_walk_ad_1"}
		self.NextAnyAttackTime_Melee = 1.0666666666667
		
	elseif randattack_moving == 2 && self:IsMoving() then
		self.AnimTbl_MeleeAttack = {"vjges_nz_attack_walk_ad_2"}	
		self.NextAnyAttackTime_Melee = 1.5666667071316
		
	elseif randattack_moving == 3 && self:IsMoving() then
		self.AnimTbl_MeleeAttack = {"vjges_nz_attack_walk_ad_3"}
		self.NextAnyAttackTime_Melee = 1.233333343135
			
	elseif randattack_moving == 4 && self:IsMoving() then
		self.AnimTbl_MeleeAttack = {"vjges_nz_attack_walk_ad_4"}
		self.NextAnyAttackTime_Melee = 1.4666666550106
		
	elseif randattack_moving == 5 && self:IsMoving() then
		self.AnimTbl_MeleeAttack = {"vjges_nz_attack_walk_au_1"}
		self.NextAnyAttackTime_Melee = 1.0666666666667		
		
	elseif randattack_moving == 6 && self:IsMoving() then
		self.AnimTbl_MeleeAttack = {"vjges_nz_attack_walk_au_2"}
		self.NextAnyAttackTime_Melee = 1.5666667071316
			
	elseif randattack_moving == 7 && self:IsMoving() then
		self.AnimTbl_MeleeAttack = {"vjges_nz_attack_walk_au_3"}
		self.NextAnyAttackTime_Melee = 1.233333343135
				
	elseif randattack_moving == 8 && self:IsMoving() then
		self.AnimTbl_MeleeAttack = {"vjges_nz_attack_walk_au_4"}
		self.NextAnyAttackTime_Melee = 1.4666666550106
		
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
	
    elseif randattack_stand == 13 then
        self.MeleeAttackDistance = 12
	    self.MeleeAttackDamageDistance = 55
		self.AnimTbl_MeleeAttack = {"vjseq_Choke_Eat"}
		self.MeleeAttackDamageType = DMG_NERVEGAS
end

    if self.LN_Run == true then
	
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
		
		end
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

if math.random(1,20) == 1 && GetConVarNumber("vj_LNR_Run") == 1 then --&& (self.StartHealth -100 > self:Health()) then
self.AnimTbl_Run = {ACT_RUN}
end	
end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_AfterDamage(dmginfo,hitgroup)
	 if math.random (1,16) == 1 then
		 if self.LN_NextStumble < CurTime() then
			 self:VJ_ACT_PLAYACTIVITY("ShoveReact",true,1.6)
	end		 self.LN_NextStumble = CurTime() + 10
end			 
	 if math.random (1,16) == 1 then		 
		 if self.LN_NextStumble < CurTime() then
			 self:VJ_ACT_PLAYACTIVITY("ShoveReactBehind",true,1.6)
			 self.LN_NextStumble = CurTime() + 10			 
		end	 
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
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/