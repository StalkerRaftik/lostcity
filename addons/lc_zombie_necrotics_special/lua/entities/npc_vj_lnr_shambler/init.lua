AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_lnrspecials/shambler.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 200 
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
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.DisableFootStepSoundTimer = true
ENT.AnimTbl_Run = {ACT_WALK}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.HasDeathAnimation = true
ENT.DeathAnimationTime = 1.5
ENT.DeathAnimationChance = 2
ENT.AnimTbl_Death = {"vjseq_nz_death_1","vjseq_nz_death_2","vjseq_nz_death_3"} 
ENT.GeneralSoundPitch1 = 85
ENT.GeneralSoundPitch2 = 85
ENT.MeleeAttackSoundPitch1 = 100
ENT.MeleeAttackSoundPitch2 = 100
---------------------------------------------------------------------------------------------------------------------------------------------
--custom
ENT.LNR_VirusInfection = true
ENT.LNR_IsWalker = true
ENT.LNR_ShamblerRad = false
ENT.LNR_NextStumble = CurTime()

	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {
"misc/concrete1.wav",
"misc/concrete2.wav",
"misc/concrete3.wav",
"misc/concrete4.wav"
}
ENT.SoundTbl_MeleeAttack = {
"vj_lnrhl2/claw_strike1.mp3",
"vj_lnrhl2/claw_strike2.mp3",
"vj_lnrhl2/claw_strike3.mp3"
}
ENT.SoundTbl_MeleeAttackMiss = {
"npc/zombie/claw_miss2.wav",
"npc/zombie/claw_miss1.wav"
}
ENT.SoundTbl_Idle = {
"vj_lnrhl2/walkers/male/moan01.wav",
"vj_lnrhl2/walkers/male/moan02.wav",
"vj_lnrhl2/walkers/male/moan03.wav",
"vj_lnrhl2/walkers/male/moan04.wav",
"vj_lnrhl2/walkers/male/moan05.wav",
"vj_lnrhl2/walkers/male/breathing1.wav",
"vj_lnrhl2/walkers/male/breathing2.wav",
"vj_lnrhl2/walkers/male/breathing3.wav",
"vj_lnrhl2/walkers/male/breathing4.wav",
"vj_lnrhl2/walkers/male/breathing5.wav",
"vj_lnrhl2/walkers/male/breathing6.wav",
"vj_lnrhl2/walkers/male/breathing7.wav",
"vj_lnrhl2/walkers/male/breathing8.wav",
"vj_lnrhl2/walkers/male/breathing9.wav",
"vj_lnrhl2/walkers/male/breathing10.wav",
"vj_lnrhl2/walkers/male/breathing11.wav",
"vj_lnrhl2/walkers/male/breathing12.wav",
"vj_lnrhl2/walkers/male/breathing13.wav",
"vj_lnrhl2/walkers/male/breathing14.wav",
"vj_lnrhl2/walkers/male/idle1.wav",
"vj_lnrhl2/walkers/male/idle2.wav",
"vj_lnrhl2/walkers/male/idle3.wav",
"vj_lnrhl2/walkers/male/idle4.wav",
"vj_lnrhl2/walkers/male/idle5.wav",
"vj_lnrhl2/walkers/male/idle6.wav",
"vj_lnrhl2/walkers/male/idle7.wav",
"vj_lnrhl2/walkers/male/idle8.wav"
}
ENT.SoundTbl_Alert = {
"vj_lnrhl2/walkers/male/become_alert15.wav",
"vj_lnrhl2/walkers/male/become_alert17.wav",
"vj_lnrhl2/walkers/male/become_alert18.wav",
"vj_lnrhl2/walkers/male/become_alert19.wav",
"vj_lnrhl2/walkers/male/alert1.wav",
"vj_lnrhl2/walkers/male/alert2.wav",
"vj_lnrhl2/walkers/male/alert3.wav",
"vj_lnrhl2/walkers/male/alert4.wav",
"vj_lnrhl2/walkers/male/alert5.wav",
"vj_lnrhl2/walkers/male/alert6.wav",
"vj_lnrhl2/walkers/male/alert7.wav",
"vj_lnrhl2/walkers/male/alert8.wav",
"vj_lnrhl2/walkers/male/alert9.wav",
"vj_lnrhl2/walkers/male/alert10.wav",
"vj_lnrhl2/walkers/male/alert11.wav",
"vj_lnrhl2/walkers/male/alert12.wav",
"vj_lnrhl2/walkers/male/alert13.wav",
"vj_lnrhl2/walkers/male/alert14.wav",
"vj_lnrhl2/walkers/male/alert15.wav"
}
ENT.SoundTbl_CombatIdle = {
"vj_lnrhl2/walkers/male/become_enraged1.wav",
"vj_lnrhl2/walkers/male/become_enraged2.wav",
"vj_lnrhl2/walkers/male/become_enraged3.wav",
"vj_lnrhl2/walkers/male/become_enraged4.wav",
"vj_lnrhl2/walkers/male/become_enraged5.wav",
"vj_lnrhl2/walkers/male/become_enraged6.wav",
"vj_lnrhl2/walkers/male/become_enraged7.wav",
"vj_lnrhl2/walkers/male/become_enraged8.wav",
"vj_lnrhl2/walkers/male/become_enraged9.wav",
"vj_lnrhl2/walkers/male/become_enraged10.wav",
"vj_lnrhl2/walkers/male/become_enraged11.wav",
"vj_lnrhl2/walkers/male/become_enraged12.wav",
"vj_lnrhl2/walkers/male/become_enraged13.wav",
"vj_lnrhl2/walkers/male/become_enraged14.wav",
"vj_lnrhl2/walkers/male/become_enraged15.wav",
"vj_lnrhl2/walkers/male/become_enraged16.wav",
"vj_lnrhl2/walkers/male/become_enraged17.wav"
}
ENT.SoundTbl_BeforeMeleeAttack = {
"vj_lnrhl2/walkers/male/become_enraged1.wav",
"vj_lnrhl2/walkers/male/become_enraged2.wav",
"vj_lnrhl2/walkers/male/become_enraged3.wav",
"vj_lnrhl2/walkers/male/become_enraged4.wav",
"vj_lnrhl2/walkers/male/become_enraged5.wav",
"vj_lnrhl2/walkers/male/become_enraged6.wav",
"vj_lnrhl2/walkers/male/become_enraged7.wav",
"vj_lnrhl2/walkers/male/become_enraged8.wav",
"vj_lnrhl2/walkers/male/become_enraged9.wav",
"vj_lnrhl2/walkers/male/become_enraged10.wav",
"vj_lnrhl2/walkers/male/become_enraged11.wav",
"vj_lnrhl2/walkers/male/become_enraged12.wav",
"vj_lnrhl2/walkers/male/become_enraged13.wav",
"vj_lnrhl2/walkers/male/become_enraged14.wav",
"vj_lnrhl2/walkers/male/become_enraged15.wav",
"vj_lnrhl2/walkers/male/become_enraged16.wav",
"vj_lnrhl2/walkers/male/become_enraged17.wav"
}
ENT.SoundTbl_LeapAttackJump = {
"vj_lnrhl2/walkers/male/become_enraged1.wav",
"vj_lnrhl2/walkers/male/become_enraged2.wav",
"vj_lnrhl2/walkers/male/become_enraged3.wav",
"vj_lnrhl2/walkers/male/become_enraged4.wav",
"vj_lnrhl2/walkers/male/become_enraged5.wav",
"vj_lnrhl2/walkers/male/become_enraged6.wav",
"vj_lnrhl2/walkers/male/become_enraged7.wav",
"vj_lnrhl2/walkers/male/become_enraged8.wav",
"vj_lnrhl2/walkers/male/become_enraged9.wav",
"vj_lnrhl2/walkers/male/become_enraged10.wav",
"vj_lnrhl2/walkers/male/become_enraged11.wav",
"vj_lnrhl2/walkers/male/become_enraged12.wav",
"vj_lnrhl2/walkers/male/become_enraged13.wav",
"vj_lnrhl2/walkers/male/become_enraged14.wav",
"vj_lnrhl2/walkers/male/become_enraged15.wav",
"vj_lnrhl2/walkers/male/become_enraged16.wav",
"vj_lnrhl2/walkers/male/become_enraged17.wav"
}
ENT.SoundTbl_Pain = {
"vj_lnrhl2/walkers/male/pain1.wav",
"vj_lnrhl2/walkers/male/pain2.wav",
"vj_lnrhl2/walkers/male/pain3.wav",
"vj_lnrhl2/walkers/male/pain4.wav",
"vj_lnrhl2/walkers/male/pain5.wav",
"vj_lnrhl2/walkers/male/pain6.wav",
"vj_lnrhl2/walkers/male/pain7.wav",
"vj_lnrhl2/walkers/male/pain8.wav",
}
ENT.SoundTbl_Death = {
"vj_lnrhl2/walkers/male/death1.wav",
"vj_lnrhl2/walkers/male/death2.wav",
"vj_lnrhl2/walkers/male/death3.wav",
"vj_lnrhl2/walkers/male/death4.wav",
"vj_lnrhl2/walkers/male/death5.wav",
"vj_lnrhl2/walkers/male/death6.wav",
"vj_lnrhl2/walkers/male/death7.wav",
"vj_lnrhl2/walkers/male/death8.wav",
"vj_lnrhl2/walkers/male/death9.wav",
"vj_lnrhl2/walkers/male/death10.wav"
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize() 
if self.LNR_ShamblerRad == true then
ParticleEffectAttach("smoke_exhaust_01",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("mouth"))
end
self:SetSkin(math.random(0,3))
end
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

if math.random(1,3) == 1 then
    self.LNR_ShamblerRad = true
	for _,v in ipairs(ents.FindInSphere(self:GetPos(),DMG_RADIATION,150)) do
	timer.Create("LNR_Radiation"..self:EntIndex(), 1.5, 0, function()
	if IsValid(self) then
    util.VJ_SphereDamage(self,self,self:GetPos(),150,math.random(10,15),DMG_RADIATION,true,true)
	
			 end
		 end)
	  end
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
end
-------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnKilled(dmginfo, hitgroup)
if self.LNR_ShamblerRad == true then
local ent = ents.Create("obj_vj_lnr_radiation_cloud")
		local vec = Vector(0,0,5):GetNormal()
		ent:SetPos(self:GetPos() +Vector(0,0,5))
		ent:SetAngles(vec:Angle())
		ent:Spawn()
		ent:SetOwner(self)		
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