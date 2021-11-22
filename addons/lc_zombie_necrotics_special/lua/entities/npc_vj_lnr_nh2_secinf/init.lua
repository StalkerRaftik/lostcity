AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_lnrspecials/nh2/Security01_inf.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 250 
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
ENT.PropAP_MaxSize = 5
ENT.HasItemDropsOnDeath = true 
ENT.ItemDropsOnDeathChance = 4
ENT.ItemDropsOnDeath_EntityList = {"weapon_stunstick","item_ammo_ar2","item_ammo_pistol","item_ammo_smg1","item_box_buckshot","weapon_frag","item_ammo_crossbow","item_rpg_round"}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.HasMeleeAttack = true 
ENT.MeleeAttackDistance = 35
ENT.MeleeAttackDamageDistance = 65
ENT.MeleeAttackDamage = math.Rand(15,20)
ENT.MeleeAttackAnimationAllowOtherTasks = true 
ENT.TimeUntilMeleeAttackDamage = false
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.DisableFootStepSoundTimer = true
ENT.AnimTbl_Run = {ACT_SPRINT}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.HasDeathAnimation = true
ENT.DeathAnimationTime = 1.5
ENT.DeathAnimationChance = 2
ENT.AnimTbl_Death = {"vjseq_nz_death_1","vjseq_nz_death_2","vjseq_nz_death_3"} 
ENT.GeneralSoundPitch1 = 90
ENT.GeneralSoundPitch2 = 90
ENT.FootStepPitch1 = 100
ENT.FootStepPitch2 = 100
ENT.MeleeAttackSoundPitch1 = 100
ENT.MeleeAttackSoundPitch2 = 100
---------------------------------------------------------------------------------------------------------------------------------------------
--custom
ENT.LNR_VirusInfection = true
ENT.LNR_IsWalker = false
ENT.Riot_LowHP = false
ENT.LNR_NextStumble = CurTime()

	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
--ENT.SoundTbl_FootStep = {"zombie_footstep_m_11.wav","zombie_footstep_m_06.wav","zombie_footstep_m_02.wav"}
ENT.SoundTbl_Breath = {"vj_lnrhl2/infected/idle_breath_06.wav","vj_lnrhl2/infected/idle_breath_04.wav","vj_lnrhl2/infected/idle_breath_03.wav","vj_lnrhl2/infected/idle_breath_02.wav","vj_lnrhl2/infected/idle_breath_01.wav","vj_lnrhl2/infected/male/breathing26.wav","vj_lnrhl2/infected/male/breathing25.wav","vj_lnrhl2/infected/male/breathing18.wav","vj_lnrhl2/infected/male/breathing16.wav","vj_lnrhl2/infected/male/breathing13.wav","vj_lnrhl2/infected/male/breathing08.wav","vj_lnrhl2/infected/male/breathing01.wav","vj_lnrhl2/infected/male/breathing10.wav"}
ENT.SoundTbl_Idle = {"vj_lnrhl2/infected/mumbling08.wav","vj_lnrhl2/infected/mumbling07.wav","vj_lnrhl2/infected/mumbling06.wav","vj_lnrhl2/infected/mumbling05.wav","vj_lnrhl2/infected/mumbling04.wav","vj_lnrhl2/infected/mumbling03.wav","vj_lnrhl2/infected/mumbling02.wav","vj_lnrhl2/infected/mumbling01.wav","vj_lnrhl2/infected/male/moan09.wav","vj_lnrhl2/infected/male/moan08.wav","vj_lnrhl2/infected/male/moan07.wav","vj_lnrhl2/infected/male/moan06.wav","vj_lnrhl2/infected/male/moan05.wav","vj_lnrhl2/infected/male/moan04.wav","vj_lnrhl2/infected/male/moan03.wav","vj_lnrhl2/infected/male/moan02.wav","vj_lnrhl2/infected/male/moan01.wav"}
ENT.SoundTbl_Alert = {"vj_lnrhl2/infected/male/snarl_4.wav","vj_lnrhl2/infected/male/shout09.wav","vj_lnrhl2/infected/male/shout08.wav","vj_lnrhl2/infected/male/shout07.wav","vj_lnrhl2/infected/male/shout06.wav","vj_lnrhl2/infected/male/shout04.wav","vj_lnrhl2/infected/male/shout03.wav","vj_lnrhl2/infected/male/shout02.wav","vj_lnrhl2/infected/male/alert44.wav","vj_lnrhl2/infected/male/alert43.wav","vj_lnrhl2/infected/male/alert42.wav","vj_lnrhl2/infected/male/alert41.wav","vj_lnrhl2/infected/male/alert40.wav","vj_lnrhl2/infected/male/alert39.wav","vj_lnrhl2/infected/male/alert38.wav","vj_lnrhl2/infected/male/alert37.wav","vj_lnrhl2/infected/male/alert36.wav","vj_lnrhl2/infected/male/alert27.wav","vj_lnrhl2/infected/male/alert26.wav","vj_lnrhl2/infected/male/alert25.wav","vj_lnrhl2/infected/male/alert23.wav","vj_lnrhl2/infected/male/alert22.wav","vj_lnrhl2/infected/male/alert16.wav","vj_lnrhl2/infected/male/alert13.wav","vj_lnrhl2/infected/male/howl01.wav","vj_lnrhl2/infected/male/recognize08.wav","vj_lnrhl2/infected/male/recognize07.wav","vj_lnrhl2/infected/male/recognize06.wav","vj_lnrhl2/infected/male/recognize05.wav","vj_lnrhl2/infected/male/recognize04.wav","vj_lnrhl2/infected/male/recognize02.wav","vj_lnrhl2/infected/male/recognize02.wav","vj_lnrhl2/infected/male/recognize01.wav"} 
ENT.SoundTbl_CallForHelp = {"vj_lnrhl2/infected/male/shout01.wav","vj_lnrhl2/infected/male/howl01.wav"}
ENT.SoundTbl_CombatIdle = {"vj_lnrhl2/infected/male/become_enraged43.wav","vj_lnrhl2/infected/male/become_enraged42.wav","vj_lnrhl2/infected/male/become_enraged41.wav","vj_lnrhl2/infected/male/become_enraged40.wav","vj_lnrhl2/infected/male/become_enraged58.wav","vj_lnrhl2/infected/male/become_enraged57.wav","vj_lnrhl2/infected/male/become_enraged56.wav","vj_lnrhl2/infected/male/become_enraged55.wav","vj_lnrhl2/infected/male/become_enraged54.wav","vj_lnrhl2/infected/male/become_enraged53.wav","vj_lnrhl2/infected/male/become_enraged52.wav","vj_lnrhl2/infected/male/become_enraged51.wav","vj_lnrhl2/infected/male/become_enraged50.wav","vj_lnrhl2/infected/male/become_enraged30.wav","vj_lnrhl2/infected/male/become_enraged11.wav","vj_lnrhl2/infected/male/become_enraged10.wav","vj_lnrhl2/infected/male/become_enraged09.wav","vj_lnrhl2/infected/male/become_enraged07.wav","vj_lnrhl2/infected/male/become_enraged03.wav","vj_lnrhl2/infected/male/become_enraged02.wav","vj_lnrhl2/infected/male/become_enraged01.wav","vj_lnrhl2/infected/male/rage_at_victim37.wav","vj_lnrhl2/infected/male/rage_at_victim36.wav","vj_lnrhl2/infected/male/rage_at_victim35.wav","vj_lnrhl2/infected/male/rage_at_victim34.wav","vj_lnrhl2/infected/male/rage_at_victim31.wav","vj_lnrhl2/infected/male/rage_at_victim30.wav","vj_lnrhl2/infected/male/rage_at_victim29.wav","vj_lnrhl2/infected/male/rage_at_victim28.wav","vj_lnrhl2/infected/male/rage_at_victim27.wav","vj_lnrhl2/infected/male/rage_at_victim25.wav","vj_lnrhl2/infected/male/rage_at_victim24.wav","vj_lnrhl2/infected/male/rage_at_victim23.wav","vj_lnrhl2/infected/male/rage_at_victim22.wav","vj_lnrhl2/infected/male/rage_at_victim21.wav","vj_lnrhl2/infected/male/rage_at_victim20.wav","vj_lnrhl2/infected/male/become_enraged06.wav","vj_lnrhl2/infected/male/become_enraged30.wav"} 
ENT.SoundTbl_Pain = {"vj_lnrhl2/infected/male/been_shot_37.wav","vj_lnrhl2/infected/male/been_shot_36.wav","vj_lnrhl2/infected/male/been_shot_35.wav","vj_lnrhl2/infected/male/been_shot_34.wav","vj_lnrhl2/infected/male/been_shot_33.wav","vj_lnrhl2/infected/male/been_shot_32.wav","vj_lnrhl2/infected/male/been_shot_31.wav","vj_lnrhl2/infected/male/been_shot_30.wav","vj_lnrhl2/infected/male/been_shot_24.wav","vj_lnrhl2/infected/male/been_shot_22.wav","vj_lnrhl2/infected/male/been_shot_21.wav","vj_lnrhl2/infected/male/been_shot_20.wav","vj_lnrhl2/infected/male/been_shot_19.wav","vj_lnrhl2/infected/male/been_shot_18.wav","vj_lnrhl2/infected/male/been_shot_14.wav","vj_lnrhl2/infected/male/been_shot_13.wav","vj_lnrhl2/infected/male/been_shot_12.wav","vj_lnrhl2/infected/male/been_shot_08.wav","vj_lnrhl2/infected/male/been_shot_06.wav","vj_lnrhl2/infected/male/been_shot_05.wav","vj_lnrhl2/infected/male/been_shot_04.wav","vj_lnrhl2/infected/male/been_shot_02.wav","vj_lnrhl2/infected/male/been_shot_01.wav"}
ENT.SoundTbl_Death = {"vj_lnrhl2/infected/male/death_49.wav","vj_lnrhl2/infected/male/death_48.wav","vj_lnrhl2/infected/male/death_47.wav","vj_lnrhl2/infected/male/death_46.wav","vj_lnrhl2/infected/male/death_45.wav","vj_lnrhl2/infected/male/death_44.wav","vj_lnrhl2/infected/male/death_43.wav","vj_lnrhl2/infected/male/death_42.wav","vj_lnrhl2/infected/male/death_41.wav","vj_lnrhl2/infected/male/death_40.wav","vj_lnrhl2/infected/male/death_38.wav","vj_lnrhl2/infected/male/death_34.wav","vj_lnrhl2/infected/male/death_33.wav","vj_lnrhl2/infected/male/death_32.wav","vj_lnrhl2/infected/male/death_30.wav","vj_lnrhl2/infected/male/death_29.wav","vj_lnrhl2/infected/male/death_38.wav","vj_lnrhl2/infected/male/death_37.wav","vj_lnrhl2/infected/male/death_36.wav","vj_lnrhl2/infected/male/death_27.wav","vj_lnrhl2/infected/male/death_25.wav","vj_lnrhl2/infected/male/death_24.wav","vj_lnrhl2/infected/male/death_19.wav","vj_lnrhl2/infected/male/death_18.wav","vj_lnrhl2/infected/male/death_17.wav","vj_lnrhl2/infected/male/death_14.wav","vj_lnrhl2/infected/male/death_28.wav","vj_lnrhl2/infected/male/death_22.wav","vj_lnrhl2/infected/male/death_23.wav","vj_lnrhl2/infected/male/death_26.wav","vj_lnrhl2/infected/male/death_35.wav"}
ENT.SoundTbl_MeleeAttack = {"vj_lnrhl2/claw_strike1.mp3","vj_lnrhl2/claw_strike2.mp3","vj_lnrhl2/claw_strike3.mp3"}
ENT.SoundTbl_BeforeMeleeAttack = {"vj_lnrhl2/infected/male/rage_82.wav","vj_lnrhl2/infected/male/rage_81.wav","vj_lnrhl2/infected/male/rage_80.wav","vj_lnrhl2/infected/male/rage_79.wav","vj_lnrhl2/infected/male/rage_78.wav","vj_lnrhl2/infected/male/rage_77.wav","vj_lnrhl2/infected/male/rage_76.wav","vj_lnrhl2/infected/male/rage_75.wav","vj_lnrhl2/infected/male/rage_74.wav","vj_lnrhl2/infected/male/rage_73.wav","vj_lnrhl2/infected/male/rage_72.wav","vj_lnrhl2/infected/male/rage_71.wav","vj_lnrhl2/infected/male/rage_70.wav","vj_lnrhl2/infected/male/rage_69.wav","vj_lnrhl2/infected/male/rage_68.wav","vj_lnrhl2/infected/male/rage_67.wav","vj_lnrhl2/infected/male/rage_66.wav","vj_lnrhl2/infected/male/rage_65.wav","vj_lnrhl2/infected/male/rage_64.wav","vj_lnrhl2/infected/male/rage_62.wav","vj_lnrhl2/infected/male/rage_60.wav","vj_lnrhl2/infected/male/rage_60.wav","vj_lnrhl2/infected/male/rage_59.wav","vj_lnrhl2/infected/male/rage_58.wav","vj_lnrhl2/infected/male/rage_57.wav","vj_lnrhl2/infected/male/rage_56.wav","vj_lnrhl2/infected/male/rage_55.wav","vj_lnrhl2/infected/male/rage_54.wav","vj_lnrhl2/infected/male/rage_53.wav","vj_lnrhl2/infected/male/rage_52.wav","vj_lnrhl2/infected/male/rage_51.wav","vj_lnrhl2/infected/male/rage_50.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"npc/zombie/claw_miss2.wav","npc/zombie/claw_miss1.wav"}
ENT.SoundTbl_MeleeAttackSlowPlayer = {"vj_lnrhl2/losthope.mp3"}

ENT.FootSteps = {
	[MAT_ANTLION] = {
		"physics/flesh/flesh_impact_hard1.wav",
		"physics/flesh/flesh_impact_hard2.wav",
		"physics/flesh/flesh_impact_hard3.wav",
		"physics/flesh/flesh_impact_hard4.wav",
		"physics/flesh/flesh_impact_hard5.wav",
		"physics/flesh/flesh_impact_hard6.wav",
	},
	[MAT_BLOODYFLESH] = {
		"physics/flesh/flesh_impact_hard1.wav",
		"physics/flesh/flesh_impact_hard2.wav",
		"physics/flesh/flesh_impact_hard3.wav",
		"physics/flesh/flesh_impact_hard4.wav",
		"physics/flesh/flesh_impact_hard5.wav",
		"physics/flesh/flesh_impact_hard6.wav",
	},
	[MAT_CONCRETE] = {
		"vj_lnrhl2/npc/footstep/zombie_footstep_m_11.wav",
		"vj_lnrhl2/npc/footstep/zombie_footstep_m_06.wav",
		"vj_lnrhl2/npc/footstep/zombie_footstep_m_02.wav",
	},
	[MAT_DIRT] = {
		"player/footsteps/dirt1.wav",
		"player/footsteps/dirt2.wav",
		"player/footsteps/dirt3.wav",
		"player/footsteps/dirt4.wav",
	},
	[MAT_FLESH] = {
		"physics/flesh/flesh_impact_hard1.wav",
		"physics/flesh/flesh_impact_hard2.wav",
		"physics/flesh/flesh_impact_hard3.wav",
		"physics/flesh/flesh_impact_hard4.wav",
		"physics/flesh/flesh_impact_hard5.wav",
		"physics/flesh/flesh_impact_hard6.wav",
	},
	[MAT_GRATE] = {
		"player/footsteps/metalgrate1.wav",
		"player/footsteps/metalgrate2.wav",
		"player/footsteps/metalgrate3.wav",
		"player/footsteps/metalgrate4.wav",
	},
	[MAT_ALIENFLESH] = {
		"physics/flesh/flesh_impact_hard1.wav",
		"physics/flesh/flesh_impact_hard2.wav",
		"physics/flesh/flesh_impact_hard3.wav",
		"physics/flesh/flesh_impact_hard4.wav",
		"physics/flesh/flesh_impact_hard5.wav",
		"physics/flesh/flesh_impact_hard6.wav",
	},
	[74] = { -- Snow
		"player/footsteps/sand1.wav",
		"player/footsteps/sand2.wav",
		"player/footsteps/sand3.wav",
		"player/footsteps/sand4.wav",
	},
	[MAT_PLASTIC] = {
		"physics/plaster/drywall_footstep1.wav",
		"physics/plaster/drywall_footstep2.wav",
		"physics/plaster/drywall_footstep3.wav",
		"physics/plaster/drywall_footstep4.wav",
	},
	[MAT_METAL] = {
		"player/footsteps/metal1.wav",
		"player/footsteps/metal2.wav",
		"player/footsteps/metal3.wav",
		"player/footsteps/metal4.wav",
	},
	[MAT_SAND] = {
		"player/footsteps/sand1.wav",
		"player/footsteps/sand2.wav",
		"player/footsteps/sand3.wav",
		"player/footsteps/sand4.wav",
	},
	[MAT_FOLIAGE] = {
		"player/footsteps/grass1.wav",
		"player/footsteps/grass2.wav",
		"player/footsteps/grass3.wav",
		"player/footsteps/grass4.wav",
	},
	[MAT_COMPUTER] = {
		"physics/plaster/drywall_footstep1.wav",
		"physics/plaster/drywall_footstep2.wav",
		"physics/plaster/drywall_footstep3.wav",
		"physics/plaster/drywall_footstep4.wav",
	},
	[MAT_SLOSH] = {
		"player/footsteps/slosh1.wav",
		"player/footsteps/slosh2.wav",
		"player/footsteps/slosh3.wav",
		"player/footsteps/slosh4.wav",
	},
	[MAT_TILE] = {
		"player/footsteps/tile1.wav",
		"player/footsteps/tile2.wav",
		"player/footsteps/tile3.wav",
		"player/footsteps/tile4.wav",
	},
	[85] = { -- Grass
		"player/footsteps/grass1.wav",
		"player/footsteps/grass2.wav",
		"player/footsteps/grass3.wav",
		"player/footsteps/grass4.wav",
	},
	[MAT_VENT] = {
		"player/footsteps/duct1.wav",
		"player/footsteps/duct2.wav",
		"player/footsteps/duct3.wav",
		"player/footsteps/duct4.wav",
	},
	[MAT_WOOD] = {
		"player/footsteps/wood1.wav",
		"player/footsteps/wood2.wav",
		"player/footsteps/wood3.wav",
		"player/footsteps/wood4.wav",
		"player/footsteps/woodpanel1.wav",
		"player/footsteps/woodpanel2.wav",
		"player/footsteps/woodpanel3.wav",
		"player/footsteps/woodpanel4.wav",
	},
	[MAT_GLASS] = {
		"physics/glass/glass_sheet_step1.wav",
		"physics/glass/glass_sheet_step2.wav",
		"physics/glass/glass_sheet_step3.wav",
		"physics/glass/glass_sheet_step4.wav",
	}
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnFootStepSound()
	if !self:IsOnGround() then return end
	local tr = util.TraceLine({
		start = self:GetPos(),
		endpos = self:GetPos() +Vector(0,0,-150),
		filter = {self}
	})
	if tr.Hit && self.FootSteps[tr.MatType] then
		VJ_EmitSound(self,VJ_PICK(self.FootSteps[tr.MatType]),self.FootStepSoundLevel,self:VJ_DecideSoundPitch(self.FootStepPitch1,self.FootStepPitch2))
	end
	if self:WaterLevel() > 0 && self:WaterLevel() < 3 then
		VJ_EmitSound(self,"player/footsteps/wade" .. math.random(1,8) .. ".wav",self.FootStepSoundLevel,self:VJ_DecideSoundPitch(self.FootStepPitch1,self.FootStepPitch2))
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:FootStepSoundCode(CustomTbl)
	if self.HasSounds == false or self.HasFootStepSound == false or self.MovementType == VJ_MOVETYPE_STATIONARY then return end
	if self:IsOnGround() && self:GetGroundEntity() != NULL then
		if self.DisableFootStepSoundTimer == true then
			self:CustomOnFootStepSound()
			return
		elseif self:IsMoving() && CurTime() > self.FootStepT then
			self:CustomOnFootStepSound()
			local CurSched = self.CurrentSchedule
			if self.DisableFootStepOnRun == false && ((VJ_HasValue(self.AnimTbl_Run,self:GetMovementActivity())) or (CurSched != nil  && CurSched.IsMovingTask_Run == true)) /*(VJ_HasValue(VJ_RunActivites,self:GetMovementActivity()) or VJ_HasValue(self.CustomRunActivites,self:GetMovementActivity()))*/ then
				self:CustomOnFootStepSound_Run()
				self.FootStepT = CurTime() + self.FootStepTimeRun
				return
			elseif self.DisableFootStepOnWalk == false && (VJ_HasValue(self.AnimTbl_Walk,self:GetMovementActivity()) or (CurSched != nil  && CurSched.IsMovingTask_Walk == true)) /*(VJ_HasValue(VJ_WalkActivites,self:GetMovementActivity()) or VJ_HasValue(self.CustomWalkActivites,self:GetMovementActivity()))*/ then
				self:CustomOnFootStepSound_Walk()
				self.FootStepT = CurTime() + self.FootStepTimeWalk
				return
			end
		end
	end
end
-------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize() 
	local randomstartskin = math.random(1,2)
	if randomstartskin == 1 then self:SetSkin(0) else
	if randomstartskin == 2 then self:SetSkin(2) end
	end
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
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo,hitgroup)
	if (dmginfo:IsBulletDamage()) && hitgroup == HITGROUP_CHEST or hitgroup == HITGROUP_STOMACH or hitgroup == HITGROUP_HEAD then
		dmginfo:ScaleDamage(0.0)
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
end
-------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAlert(argent)
if math.random(1,5) == 1 then
        self:VJ_ACT_PLAYACTIVITY("vjseq_nz_taunt_7",true,2,true)
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
