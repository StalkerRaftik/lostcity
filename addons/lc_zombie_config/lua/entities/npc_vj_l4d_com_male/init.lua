AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = GetConVarNumber("vj_l4d_com_h")
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.PoseParameterLooking_Names = {pitch={"body_pitch"},yaw={"body_yaw"},roll={}} -- Custom pose parameters to use, can put as many as needed
ENT.HasBloodPool = false -- Does it have a blood pool?
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.MeleeAttackDamage = GetConVarNumber("vj_l4d_com_d")
ENT.AnimTbl_MeleeAttack = {"vjges_melee_moving01","vjges_melee_moving02","vjges_melee_moving03","vjges_melee_moving04","vjges_melee_moving05","vjges_melee_moving06"} -- Melee Attack Animations
ENT.MeleeAttackAnimationAllowOtherTasks = true -- If set to true, the animation will not stop other tasks from playing, such as chasing | Useful for gesture attacks!
ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something
ENT.SlowPlayerOnMeleeAttack = true -- If true, then the player will slow down
ENT.SlowPlayerOnMeleeAttackTime = 0.5 -- How much time until player's Speed resets
ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.AnimTbl_Death = {"vjseq_death_01","vjseq_death_02a","vjseq_death_02c","vjseq_death_03","vjseq_death_05","vjseq_death_06","vjseq_death_07","vjseq_death_08","vjseq_death_08b","vjseq_death_09","vjseq_death_10ab","vjseq_death_10b","vjseq_death_10c","vjseq_death_11_01a","vjseq_death_11_01b","vjseq_death_11_02a","vjseq_death_11_02b","vjseq_death_11_02c","vjseq_death_11_02d","vjseq_death_11_03a","vjseq_death_11_03b","vjseq_death_11_03c"} -- Death Animations
ENT.DeathAnimationChance = 2 -- Put 1 if you want it to play the animation all the time
ENT.GibOnDeathDamagesTable = {"All"} -- Damages that it gibs from | "UseDefault" = Uses default damage types | "All" = Gib from any damage
ENT.DisableFootStepSoundTimer = true -- If set to true, it will disable the time system for the footstep sound code, allowing you to use other ways like model events
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.HasMeleeAttackSlowPlayerSound = false -- Does it have a sound when it slows down the player?

	-- ====== Flinching Code ====== --
//ENT.AnimTbl_Flinch = {"vjges_flinch_01"} -- If it uses normal based animation, use this
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.FlinchChance = 12 -- Chance of it flinching from 1 to x | 1 will make it always flinch
ENT.HasHitGroupFlinching = true -- It will flinch when hit in certain hitgroups | It can also have certain animations to play in certain hitgroups
ENT.HitGroupFlinching_DefaultWhenNotHit = false -- If it uses hitgroup flinching, should it do the regular flinch if it doesn't hit any of the specified hitgroups?
ENT.HitGroupFlinching_Values = {{HitGroup = {HITGROUP_HEAD}, Animation = {"HeadshotFront"}},{HitGroup = {HITGROUP_CHEST}, Animation = {"Shoved_Backward_01"}},{HitGroup = {HITGROUP_STOMACH}, Animation = {"Shoved_Backward_01"}}}
	-- ====== File Path Variables ====== --
	-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"vj_l4d_com/footstep/dirt1.wav","vj_l4d_com/footstep/dirt2.wav","vj_l4d_com/footstep/dirt3.wav","vj_l4d_com/footstep/dirt4.wav"}
ENT.SoundTbl_Breath = {"vj_l4d_com/idle_breath/breathing01.wav","vj_l4d_com/idle_breath/breathing08.wav","vj_l4d_com/idle_breath/breathing09.wav","vj_l4d_com/idle_breath/breathing10.wav","vj_l4d_com/idle_breath/breathing13.wav","vj_l4d_com/idle_breath/breathing16.wav","vj_l4d_com/idle_breath/breathing18.wav","vj_l4d_com/idle_breath/breathing25.wav","vj_l4d_com/idle_breath/breathing26.wav","vj_l4d_com/idle_breath/idle_breath_01.wav","vj_l4d_com/idle_breath/idle_breath_02.wav","vj_l4d_com/idle_breath/idle_breath_03.wav","vj_l4d_com/idle_breath/idle_breath_04.wav","vj_l4d_com/idle_breath/idle_breath_06.wav"}
ENT.SoundTbl_Idle = {"vj_l4d_com/idle/mumbling01.wav","vj_l4d_com/idle/mumbling02.wav","vj_l4d_com/idle/mumbling03.wav","vj_l4d_com/idle/mumbling04.wav","vj_l4d_com/idle/mumbling05.wav","vj_l4d_com/idle/mumbling06.wav","vj_l4d_com/idle/mumbling07.wav","vj_l4d_com/idle/mumbling08.wav","vj_l4d_com/idle/moan01.wav","vj_l4d_com/idle/moan02.wav","vj_l4d_com/idle/moan03.wav","vj_l4d_com/idle/moan04.wav","vj_l4d_com/idle/moan05.wav","vj_l4d_com/idle/moan06.wav","vj_l4d_com/idle/moan07.wav","vj_l4d_com/idle/moan08.wav","vj_l4d_com/idle/moan09.wav"}
ENT.SoundTbl_CombatIdle = {"vj_l4d_com/idle_combat/alert24.wav","vj_l4d_com/idle_combat/become_enraged01.wav","vj_l4d_com/idle_combat/become_enraged02.wav","vj_l4d_com/idle_combat/become_enraged03.wav","vj_l4d_com/idle_combat/become_enraged06.wav","vj_l4d_com/idle_combat/become_enraged07.wav","vj_l4d_com/idle_combat/become_enraged09.wav","vj_l4d_com/idle_combat/become_enraged10.wav","vj_l4d_com/idle_combat/become_enraged11.wav","vj_l4d_com/idle_combat/become_enraged30.wav","vj_l4d_com/idle_combat/become_enraged50.wav","vj_l4d_com/idle_combat/become_enraged51.wav","vj_l4d_com/idle_combat/become_enraged52.wav","vj_l4d_com/idle_combat/become_enraged53.wav","vj_l4d_com/idle_combat/become_enraged54.wav","vj_l4d_com/idle_combat/become_enraged55.wav","vj_l4d_com/idle_combat/become_enraged56.wav","vj_l4d_com/idle_combat/become_enraged57.wav","vj_l4d_com/idle_combat/become_enraged58.wav","vj_l4d_com/idle_combat/male/become_enraged40.wav","vj_l4d_com/idle_combat/male/become_enraged41.wav","vj_l4d_com/idle_combat/male/become_enraged42.wav","vj_l4d_com/idle_combat/male/become_enraged43.wav"}
ENT.SoundTbl_Investigate = {"vj_l4d_com/investigate/become_alert01.wav","vj_l4d_com/investigate/become_alert04.wav","vj_l4d_com/investigate/become_alert09.wav","vj_l4d_com/investigate/become_alert11.wav","vj_l4d_com/investigate/become_alert12.wav","vj_l4d_com/investigate/become_alert14.wav","vj_l4d_com/investigate/become_alert17.wav","vj_l4d_com/investigate/become_alert18.wav","vj_l4d_com/investigate/become_alert21.wav","vj_l4d_com/investigate/become_alert23.wav","vj_l4d_com/investigate/become_alert25.wav","vj_l4d_com/investigate/become_alert26.wav","vj_l4d_com/investigate/become_alert29.wav","vj_l4d_com/investigate/become_alert38.wav","vj_l4d_com/investigate/become_alert41.wav","vj_l4d_com/investigate/become_alert54.wav","vj_l4d_com/investigate/become_alert55.wav","vj_l4d_com/investigate/become_alert56.wav","vj_l4d_com/investigate/become_alert57.wav","vj_l4d_com/investigate/become_alert58.wav","vj_l4d_com/investigate/become_alert59.wav","vj_l4d_com/investigate/male/become_alert60.wav","vj_l4d_com/investigate/male/become_alert61.wav","vj_l4d_com/investigate/male/become_alert62.wav","vj_l4d_com/investigate/male/become_alert63.wav"}
ENT.SoundTbl_Alert = {"vj_l4d_com/alert/shout02.wav","vj_l4d_com/alert/shout03.wav","vj_l4d_com/alert/shout04.wav","vj_l4d_com/alert/shout06.wav","vj_l4d_com/alert/shout07.wav","vj_l4d_com/alert/shout08.wav","vj_l4d_com/alert/shout09.wav","vj_l4d_com/alert/recognize01.wav","vj_l4d_com/alert/recognize02.wav","vj_l4d_com/alert/recognize03.wav","vj_l4d_com/alert/recognize04.wav","vj_l4d_com/alert/recognize05.wav","vj_l4d_com/alert/recognize06.wav","vj_l4d_com/alert/recognize07.wav","vj_l4d_com/alert/recognize08.wav","vj_l4d_com/alert/alert13.wav","vj_l4d_com/alert/alert22.wav","vj_l4d_com/alert/alert23.wav","vj_l4d_com/alert/alert25.wav","vj_l4d_com/alert/alert27.wav","vj_l4d_com/alert/alert36.wav","vj_l4d_com/alert/alert43.wav","vj_l4d_com/alert/alert44.wav","vj_l4d_com/alert/hiss01.wav","vj_l4d_com/alert/male/alert50.wav","vj_l4d_com/alert/male/alert51.wav","vj_l4d_com/alert/male/alert52.wav","vj_l4d_com/alert/male/alert53.wav","vj_l4d_com/alert/male/alert54.wav","vj_l4d_com/alert/male/alert55.wav"}
ENT.SoundTbl_CallForHelp = {"vj_l4d_com/alert/howl01.wav","vj_l4d_com/alert/shout01.wav"}
ENT.SoundTbl_BeforeMeleeAttack = {"vj_l4d_com/attack_b/male/rage_50.wav","vj_l4d_com/attack_b/male/rage_51.wav","vj_l4d_com/attack_b/male/rage_52.wav","vj_l4d_com/attack_b/male/rage_53.wav","vj_l4d_com/attack_b/male/rage_54.wav","vj_l4d_com/attack_b/male/rage_55.wav","vj_l4d_com/attack_b/male/rage_56.wav","vj_l4d_com/attack_b/male/rage_57.wav","vj_l4d_com/attack_b/male/rage_58.wav","vj_l4d_com/attack_b/male/rage_59.wav","vj_l4d_com/attack_b/male/rage_60.wav","vj_l4d_com/attack_b/male/rage_61.wav","vj_l4d_com/attack_b/male/rage_62.wav","vj_l4d_com/attack_b/male/rage_64.wav","vj_l4d_com/attack_b/male/rage_65.wav","vj_l4d_com/attack_b/male/rage_66.wav","vj_l4d_com/attack_b/male/rage_67.wav","vj_l4d_com/attack_b/male/rage_68.wav","vj_l4d_com/attack_b/male/rage_69.wav","vj_l4d_com/attack_b/male/rage_70.wav","vj_l4d_com/attack_b/male/rage_71.wav","vj_l4d_com/attack_b/male/rage_72.wav","vj_l4d_com/attack_b/male/rage_73.wav","vj_l4d_com/attack_b/male/rage_74.wav","vj_l4d_com/attack_b/male/rage_75.wav","vj_l4d_com/attack_b/male/rage_76.wav","vj_l4d_com/attack_b/male/rage_77.wav","vj_l4d_com/attack_b/male/rage_78.wav","vj_l4d_com/attack_b/male/rage_79.wav","vj_l4d_com/attack_b/male/rage_80.wav","vj_l4d_com/attack_b/male/rage_81.wav","vj_l4d_com/attack_b/male/rage_82.wav"}
ENT.SoundTbl_MeleeAttackExtra = {"vj_l4d_com/attack_hit/hit_punch_01.wav","vj_l4d_com/attack_hit/hit_punch_02.wav","vj_l4d_com/attack_hit/hit_punch_03.wav","vj_l4d_com/attack_hit/hit_punch_04.wav","vj_l4d_com/attack_hit/hit_punch_05.wav","vj_l4d_com/attack_hit/hit_punch_06.wav","vj_l4d_com/attack_hit/hit_punch_07.wav","vj_l4d_com/attack_hit/hit_punch_08.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"vj_l4d_com/attack_miss/claw_miss_1.wav","vj_l4d_com/attack_miss/claw_miss_2.wav"}
ENT.SoundTbl_Pain = {"vj_l4d_com/pain/been_shot_01.wav","vj_l4d_com/pain/been_shot_04.wav","vj_l4d_com/pain/been_shot_05.wav","vj_l4d_com/pain/been_shot_06.wav","vj_l4d_com/pain/been_shot_08.wav","vj_l4d_com/pain/been_shot_09.wav","vj_l4d_com/pain/been_shot_13.wav","vj_l4d_com/pain/been_shot_14.wav","vj_l4d_com/pain/been_shot_18.wav","vj_l4d_com/pain/been_shot_22.wav","vj_l4d_com/pain/been_shot_24.wav","vj_l4d_com/pain/male/been_shot_30.wav","vj_l4d_com/pain/male/been_shot_31.wav","vj_l4d_com/pain/male/been_shot_32.wav","vj_l4d_com/pain/male/been_shot_33.wav","vj_l4d_com/pain/male/been_shot_34.wav","vj_l4d_com/pain/male/been_shot_35.wav","vj_l4d_com/pain/male/been_shot_36.wav","vj_l4d_com/pain/male/been_shot_37.wav"}
ENT.SoundTbl_Death = {"vj_l4d_com/death/death_14.wav","vj_l4d_com/death/death_17.wav","vj_l4d_com/death/death_18.wav","vj_l4d_com/death/death_19.wav","vj_l4d_com/death/death_22.wav","vj_l4d_com/death/death_23.wav","vj_l4d_com/death/death_24.wav","vj_l4d_com/death/death_25.wav","vj_l4d_com/death/death_26.wav","vj_l4d_com/death/death_27.wav","vj_l4d_com/death/death_28.wav","vj_l4d_com/death/death_29.wav","vj_l4d_com/death/death_30.wav","vj_l4d_com/death/death_32.wav","vj_l4d_com/death/death_33.wav","vj_l4d_com/death/death_34.wav","vj_l4d_com/death/death_35.wav","vj_l4d_com/death/death_36.wav","vj_l4d_com/death/death_37.wav","vj_l4d_com/death/death_38.wav","vj_l4d_com/death/male/death_40.wav","vj_l4d_com/death/male/death_41.wav","vj_l4d_com/death/male/death_42.wav","vj_l4d_com/death/male/death_43.wav","vj_l4d_com/death/male/death_44.wav","vj_l4d_com/death/male/death_45.wav","vj_l4d_com/death/male/death_46.wav","vj_l4d_com/death/male/death_47.wav","vj_l4d_com/death/male/death_48.wav","vj_l4d_com/death/male/death_49.wav"}

-- Custom
ENT.Zombie_CanPuke = true -- Can this zombie puke? (Particle)
ENT.Zombie_CanHearPipe = false -- Can it hear the pipe bombs?
ENT.Zombie_Climbing = false
ENT.Zombie_NextClimb = 0
ENT.Zombie_AllowClimbing = false
ENT.Zombie_NextStumble = 0
ENT.Zombie_IsMudMen = false
ENT.Zombie_NextPipBombT = 0
ENT.Zombie_NoAlertAnimation = false

-- Sitting
ENT.Zombie_IdleState = "N" -- N: Normal | S: Sitting | L: Laying
ENT.Zombie_InTransition = false
ENT.Zombie_NextGetUpT = 0
ENT.Zombie_NextSitT = 0
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPreInitialize()
	if self:GetClass() == "npc_vj_l4d_com_male" then
		self.Model = {"models/cpthazama/l4d1/common/male_01.mdl","models/cpthazama/l4d1/common/common_male_rural01.mdl","models/cpthazama/l4d1/common/common_worker_male01_test.mdl","models/cpthazama/l4d1/common/common_male_suit.mdl"}
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Zombie_CustomOnInitialize()
	if self:GetModel() == "models/cpthazama/l4d1/common/common_male_rural01.mdl" then
		self:SetBodygroup(0,math.random(0,4))
		self:SetBodygroup(1,math.random(0,1))
		self:SetSkin(math.random(0,15))
	else
		self:SetBodygroup(0,math.random(0,3))
		self:SetBodygroup(1,math.random(0,1))
		if self:GetModel() == "models/cpthazama/l4d1/common/common_worker_male01_test.mdl" or self:GetModel() == "models/cpthazama/l4d1/common/common_male_suit.mdl" then
			self:SetSkin(math.random(0,15))
		else
			self:SetSkin(math.random(0,31))
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:Zombie_CustomOnInitialize()
	
	if GetConVarNumber("vj_l4d_alllowclimbing") == 1 then self.Zombie_AllowClimbing = true end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	//print(key)
	if key == "event_emit step" then
		self:FootStepSoundCode()
	end
	if key == "event_mattack" then
		self:MeleeAttackCode()
	end
	if key == "event_vomit" && self.Zombie_CanPuke == true then
		ParticleEffectAttach("vj_l4d_com_puke", PATTACH_POINT_FOLLOW, self, 9)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOn_PoseParameterLookingCode(pitch,yaw,roll)
	local ap = math.ApproachAngle
	local cl = math.Clamp
	self:SetPoseParameter("lean_pitch",cl(ap(self:GetPoseParameter("lean_pitch"),-15,15),pitch,self.PoseParameterLooking_TurningSpeed))
	self:SetPoseParameter("lean_yaw",cl(ap(self:GetPoseParameter("lean_yaw"),-15,15),yaw,self.PoseParameterLooking_TurningSpeed))
end
// ACT_RUN_ON_FIRE - run_onfire, run_onfire_01
// ACT_IDLE_ON_FIRE - standing_onfire
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInvestigate(argent)
	self:VJ_ACT_PLAYACTIVITY("vjges_startled_delta_01",false)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAlert(argent)
	if self.Zombie_NoAlertAnimation == false && self.Zombie_IdleState == "N" && math.random (1,3) == 1 then
		if !self:IsMoving() then
			self:VJ_ACT_PLAYACTIVITY("idle_alert_straight_05",true,math.Rand(1.5,3),true)
			-- "idle_alert_straight_05", " idle_alert_straight_08"
		end
	end
	self.Zombie_NoAlertAnimation = false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnCallForHelp(ally)
	if self.Zombie_IdleState == "N" then
		self:VJ_ACT_PLAYACTIVITY("idle_acquire_05",true,math.Rand(1.5,3)/*self:DecideAnimationLength(anim,false,0.4)*/,true)
	end
	-- "idle_acquire_05","idle_acquire_06","idle_acquire_11"
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnSetEnemyOnDamage(dmginfo,hitgroup)
	if self.Zombie_IdleState == "N" && math.random (1,2) == 1 then
		self:VJ_ACT_PLAYACTIVITY("idle_alert_injured_straight_02",true,math.Rand(1.5,3),true)
		self.Zombie_NoAlertAnimation = true
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomFindCheck(enemy, distance)
	if not enemy:IsPlayer() then return true end

	local detectDistance = 500
	if enemy:Crouching() then detectDistance = 220
	elseif enemy:IsSprinting() then detectDistance = self.SightDistance end

	if (StormFox.GetTime() < 1260 && StormFox.GetTime() > 360) then -- If daytime
		if (enemy:FlashlightIsOn() == true) then
			detectDistance = detectDistance * 1.2
		end
	else -- if nighttime
		if (enemy:FlashlightIsOn() == true) then
			detectDistance = detectDistance * 2
		end
	end

	if distance <= detectDistance then 
		return true
	else
		return false
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink_AIEnabled()
	self:SetPoseParameter("move_x",1) -- Kalelou hamar
	
	//print(self.NextIdleStandTime - CurTime())
	if self.Zombie_IdleState != "N" && (self:IsMoving() or CurTime() > self.Zombie_NextGetUpT) then -- Yete che getsadz yev ge kalegor, erevor iren state-e normal e
		self:VJ_ACT_PLAYACTIVITY("sitting03_to_standing",true,false)
		self.Zombie_IdleState = "N"
		self.DisableWandering = false
		self.DisableChasingEnemy = false
		self.Zombie_NextSitT = CurTime() + 10
	end
	
	if self:IsOnFire() && self.Immune_Fire == false then -- Yete gragi vera e
		self.AnimTbl_IdleStand = {ACT_IDLE_ON_FIRE}
		self.AnimTbl_Walk = {ACT_RUN_ON_FIRE}
		self.AnimTbl_Run = {ACT_RUN_ON_FIRE}
	else
		if IsValid(self:GetEnemy()) then -- Yete teshnami ouni
			if self.Zombie_IdleState != "N" && self.Zombie_InTransition == false then
				self.Zombie_InTransition = true
				self:VJ_ACT_PLAYACTIVITY("sitting_to_standing_alert",true,false,false,0,{},function(vsched)
					vsched.RunCode_OnFinish = function()
						self.Zombie_InTransition = false
						self.Zombie_IdleState = "N"
					end
				end)
				self.DisableWandering = false
				self.DisableChasingEnemy = false
			end
			
			self.AnimTbl_IdleStand = {"idle_unabletoreachtarget_01a","idle_unabletoreachtarget_01b","idle_unabletoreachtarget_01c","idle_unabletoreachtarget_01d"}
			if self.Zombie_IsMudMen == true then
				self.AnimTbl_Walk = {ACT_RUN_STEALTH}
				self.AnimTbl_Run = {ACT_RUN_STEALTH}
			else
				self.AnimTbl_Walk = {ACT_WALK}
				self.AnimTbl_Run = {ACT_RUN}
			end
		else -- Yete teshnami chouni
			if self.Zombie_IdleState == "N" && !self:IsMoving() && CurTime() > self.Zombie_NextSitT && math.random(1,150) == 1 then -- Yete che nesdadz...
				self:VJ_ACT_PLAYACTIVITY("standing_to_sitting03",true,false)
				self.Zombie_IdleState = "S"
				self.DisableWandering = true
				self.DisableChasingEnemy = true
				self.Zombie_NextGetUpT = CurTime() + 7 //math.Rand(10,35)
			end
			
			if self.Zombie_IdleState == "N" then
				self.AnimTbl_IdleStand = {ACT_IDLE}
			elseif  self.Zombie_IdleState == "S" then
				self.AnimTbl_IdleStand = {"Sitting01","Sitting02","Sitting03","Sitting04","Sitting05","Sitting06","Sitting07","Sitting08","Sitting09"}
			end
			if self.Zombie_IsMudMen == true then
				self.AnimTbl_Walk = {ACT_RUN_STEALTH}
				self.AnimTbl_Run = {ACT_RUN_STEALTH}
			else
				self.AnimTbl_Walk = {ACT_WALK}
				self.AnimTbl_Run = {ACT_RUN}
			end
		end
	end
	
	//print(self:GetBlockingEntity())
	// IsValid(self:GetBlockingEntity()) && !self:GetBlockingEntity():IsNPC() && !self:GetBlockingEntity():IsPlayer()
	if self.Zombie_AllowClimbing == true && self.Dead == false && self.Zombie_Climbing == false && CurTime() > self.Zombie_NextClimb then
		//print("-------------------------------------------------------------------------------------")
		local anim = false
		local finalpos = self:GetPos()
		local tr5 = util.TraceLine({start = self:GetPos() + self:GetUp()*144, endpos = self:GetPos() + self:GetUp()*144 + self:GetForward()*40, filter = function(ent) if (ent:GetClass() == "prop_physics") then return true end end}) -- 144
		local tr4 = util.TraceLine({start = self:GetPos() + self:GetUp()*120, endpos = self:GetPos() + self:GetUp()*120 + self:GetForward()*40, filter = function(ent) if (ent:GetClass() == "prop_physics") then return true end end}) -- 120
		local tr3 = util.TraceLine({start = self:GetPos() + self:GetUp()*96, endpos = self:GetPos() + self:GetUp()*96 + self:GetForward()*40, filter = function(ent) if (ent:GetClass() == "prop_physics") then return true end end}) -- 96
		local tr2 = util.TraceLine({start = self:GetPos() + self:GetUp()*72, endpos = self:GetPos() + self:GetUp()*72 + self:GetForward()*40, filter = function(ent) if (ent:GetClass() == "prop_physics") then return true end end}) -- 72
		local tr1 = util.TraceLine({start = self:GetPos() + self:GetUp()*48, endpos = self:GetPos() + self:GetUp()*48 + self:GetForward()*40, filter = function(ent) if (ent:GetClass() == "prop_physics") then return true end end}) -- 48
		local tru = util.TraceLine({start = self:GetPos(), endpos = self:GetPos() + self:GetUp()*200, filter = self})
		
		//VJ_CreateTestObject(tru.StartPos,self:GetAngles(),Color(0,0,255))
		//VJ_CreateTestObject(tru.HitPos,self:GetAngles(),Color(0,255,0))
		//PrintTable(tr2)
		if not IsValid(tru.Entity) then
			if IsValid(tr5.Entity) then
				local tr5b = util.TraceLine({start = self:GetPos() + self:GetUp()*160, endpos = self:GetPos() + self:GetUp()*160 + self:GetForward()*40, filter = function(ent) if (ent:GetClass() == "prop_physics") then return true end end})
				if !IsValid(tr5b.Entity) then
					anim = VJ_PICK({"vjseq_climb144_00_inplace","vjseq_climb144_00a_inplace","vjseq_climb144_01_inplace","vjseq_climb144_03_inplace","vjseq_climb144_03a_inplace","vjseq_climb144_04_inplace"})
					finalpos = tr5.HitPos
				end
			elseif IsValid(tr4.Entity) then
				anim = VJ_PICK({"vjseq_climb120_00_inplace","vjseq_climb120_00a_inplace","vjseq_climb120_01_inplace","vjseq_climb120_03_inplace","vjseq_climb120_03a_inplace","vjseq_climb120_04_inplace"})
				finalpos = tr4.HitPos
			elseif IsValid(tr3.Entity) then
				anim = VJ_PICK({"vjseq_climb96_00_inplace","vjseq_climb96_00a_inplace","vjseq_climb96_03_inplace","vjseq_climb96_03a_inplace","vjseq_climb96_04a_inplace","vjseq_climb96_05_inplace"})
				finalpos = tr3.HitPos
			elseif IsValid(tr2.Entity) then
				anim = VJ_PICK({"vjseq_climb72_03_inplace","vjseq_climb72_04_inplace","vjseq_climb72_05_inplace","vjseq_climb72_06_inplace","vjseq_climb72_07_inplace"})
				finalpos = tr2.HitPos
			elseif IsValid(tr1.Entity) then
				anim = VJ_PICK({"vjseq_climb48_01_inplace","vjseq_climb48_02_inplace","vjseq_climb48_03_inplace","vjseq_climb48_04_inplace"})
				finalpos = tr1.HitPos
			end
		
			if anim ~= false then
				//print(anim)
				self:SetGroundEntity(NULL)
				self.Zombie_Climbing = true
				timer.Simple(0.4,function()
					if IsValid(self) then
						self:SetPos(finalpos)
					end
				end)
				self:VJ_ACT_PLAYACTIVITY(anim,true,false/*self:DecideAnimationLength(anim,false,0.4)*/,true,0,{},function(vsched)
					vsched.RunCode_OnFinish = function()
						//self:SetGroundEntity(NULL)
						//self:SetPos(finalpos)
						self.Zombie_Climbing = false
					end
				end)
			end
			self.Zombie_NextClimb = CurTime() + 0.1 //5
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_AfterDamage(dmginfo,hitgroup)
	if math.random (1,16) == 1 then
		if self.Zombie_NextStumble < CurTime() && self:IsMoving() && self:GetActivity() == ACT_RUN then
			self:VJ_ACT_PLAYACTIVITY("run_stumble_01",true,2.4)
			self.Zombie_NextStumble = CurTime() + 10
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Zombie_Gibs(gType)
	if gType == "h" then
		if self:GetModel() == "models/cpthazama/l4d1/common/common_male_rural01.mdl" then
			self:SetBodygroup(0,5)
		else
			self:SetBodygroup(0,4)
		end
		if self:GetBodygroup(1) == 0 then
			self:SetBodygroup(1,2)
		else
			self:SetBodygroup(1,5)
		end
	elseif gType == "la" then
		if self:GetBodygroup(1) == 0 then
			self:SetBodygroup(1,4)
		else
			self:SetBodygroup(1,7)
		end
	elseif gType == "ra" then
		if self:GetBodygroup(1) == 0 then
			self:SetBodygroup(1,3)
		else
			self:SetBodygroup(1,6)
		end
	elseif gType == "ll" then
		self:SetBodygroup(2,2)
	elseif gType == "rl" then
		self:SetBodygroup(2,1)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetUpGibesOnDeath(dmginfo,hitgroup)
	if VJ_HasValue(self.DefaultGibDamageTypes,dmginfo:GetDamageType()) then self.HasDeathAnimation = false return end
	if dmginfo:GetDamageForce():Length() < 700 then return false end
	local mernelou_anim = true
	if hitgroup == HITGROUP_HEAD then
		self:CreateGibEntity("prop_ragdoll","models/cpthazama/l4d1/gibs/limb_male_head01.mdl",{Pos=self:GetAttachment(self:LookupAttachment("severed_head")).Pos, Ang=self:GetAngles(), Vel="UseDamageForce"},function(gib)
			self:RemoveAllDecals()
			self:Zombie_Gibs("h")
			if self.HasGibDeathParticles == true then
				local bloodeffect = ents.Create("info_particle_system")
				bloodeffect:SetKeyValue("effect_name","blood_advisor_puncture_withdraw")
				bloodeffect:SetPos(self:GetAttachment(self:LookupAttachment("severed_head")).Pos)
				bloodeffect:SetAngles(self:GetAttachment(self:LookupAttachment("severed_head")).Ang)
				bloodeffect:SetParent(self)
				bloodeffect:Fire("SetParentAttachment","severed_head")
				bloodeffect:Spawn()
				bloodeffect:Activate()
				bloodeffect:Fire("Start","",0)
				bloodeffect:Fire("Kill","",3.5)
			end
		end)
	elseif hitgroup == HITGROUP_LEFTARM then
		self:CreateGibEntity("prop_ragdoll","models/cpthazama/l4d1/gibs/limb_male_larm01.mdl",{Pos=self:GetAttachment(self:LookupAttachment("severed_larm")).Pos - self:GetRight()*-5, Ang=self:GetAngles(), Vel="UseDamageForce"},function(gib)
			self:Zombie_Gibs("la")
		end)
	elseif hitgroup == HITGROUP_RIGHTARM then
		self:CreateGibEntity("prop_ragdoll","models/cpthazama/l4d1/gibs/limb_male_rarm01.mdl",{Pos=self:GetAttachment(self:LookupAttachment("severed_rarm")).Pos - self:GetRight()*-5, Ang=self:GetAngles(), Vel="UseDamageForce"},function(gib)
			self:Zombie_Gibs("ra")
		end)
	elseif hitgroup == HITGROUP_LEFTLEG then
		mernelou_anim = false
		self:CreateGibEntity("prop_ragdoll","models/cpthazama/l4d1/gibs/limb_male_lleg01.mdl",{Pos=self:GetAttachment(self:LookupAttachment("lfoot")).Pos - self:GetRight()*-5, Ang=self:GetAngles(), Vel="UseDamageForce"},function(gib)
			self:Zombie_Gibs("ll")
		end)
	elseif hitgroup == HITGROUP_RIGHTLEG then
		mernelou_anim = false
		self:CreateGibEntity("prop_ragdoll","models/cpthazama/l4d1/gibs/limb_male_rleg01.mdl",{Pos=self:GetAttachment(self:LookupAttachment("rfoot")).Pos - self:GetRight()*5, Ang=self:GetAngles(), Vel="UseDamageForce"},function(gib)
			self:Zombie_Gibs("rl")
		end)
	else
		return false
	end
	return true, {DeathAnim=mernelou_anim,AllowCorpse=true} -- Return to true if it gibbed!
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomGibOnDeathSounds(dmginfo,hitgroup)
	if hitgroup == HITGROUP_HEAD then
		VJ_EmitSound(self,VJ_PICK({"vj_l4d_com/gore/melee/melee_skull_break_01.wav","vj_l4d_com/gore/melee/melee_skull_break_02.wav"}),90,math.random(80,100))
	else
		VJ_EmitSound(self,VJ_PICK({"vj_l4d_com/gore/melee/melee_arm_break_01.wav","vj_l4d_com/gore/melee/melee_arm_break_02.wav"}),90,math.random(80,100))
	end
	return false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPriorToKilled(dmginfo,hitgroup)
	if self.Zombie_Climbing == true or self.Zombie_IdleState != "N" then self.HasDeathAnimation = false end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomDeathAnimationCode(dmginfo,hitgroup)
	if /*dmginfo:GetDamageForce():Length() > 10000 or */dmginfo:GetDamageType() == DMG_BUCKSHOT then
		self.AnimTbl_Death = {"death_shotgun_backward_03","death_shotgun_backward_04","death_shotgun_backward_05","death_shotgun_backward_06","death_shotgun_backward_07","death_shotgun_backward_08","death_shotgun_backward_09"}
		//self.DeathAnimationTime = 0.5
		self.DeathAnimationDecreaseLengthAmount = 0.2
	elseif self:IsMoving() && self:GetActivity() == ACT_RUN then
		self.AnimTbl_Death = {"deathrunning_01","deathrunning_03","deathrunning_04","deathrunning_05","deathrunning_06","deathrunning_07","deathrunning_08","deathrunning_09","deathrunning_10","deathrunning_11a","deathrunning_11b","deathrunning_11c","deathrunning_11d","deathrunning_11e","deathrunning_11f","deathrunning_11g"}
		//self.DeathAnimationTime = 1
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/