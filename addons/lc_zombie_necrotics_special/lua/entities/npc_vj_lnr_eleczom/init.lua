AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_lnrspecials/electric_zombie.mdl"}
ENT.StartHealth = 500 
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
ENT.AnimTbl_MeleeAttack = {"vjseq_nz_sonic_attack_2"}
ENT.MeleeAttackDamage = math.Rand(25,30)
ENT.MeleeAttackDamageType = DMG_SHOCK
ENT.MeleeAttackDistance = 40 
ENT.MeleeAttackDamageDistance = 150 
ENT.TimeUntilMeleeAttackDamage = false
ENT.NextMeleeAttackTime = 3
ENT.NextAnyAttackTime_Melee =  2.6666666666667
ENT.MeleeAttackAnimationAllowOtherTasks = true
ENT.DisableDefaultMeleeAttackDamageCode = true
ENT.HasOnKilledEnemySound = false
ENT.SlowPlayerOnMeleeAttack = true 
ENT.SlowPlayerOnMeleeAttack_WalkSpeed = 30
ENT.SlowPlayerOnMeleeAttack_RunSpeed = 45
ENT.SlowPlayerOnMeleeAttackTime = math.Rand(0.8,1.5)
ENT.MeleeAttackBleedEnemy = true 
ENT.MeleeAttackBleedEnemyChance = 2
ENT.MeleeAttackBleedEnemyDamage = math.Rand(6,8)
ENT.MeleeAttackBleedEnemyTime = 2.5
ENT.MeleeAttackBleedEnemyReps = math.Rand(5,10)
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.DisableFootStepSoundTimer = true
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.HasDeathAnimation = true
ENT.DeathAnimationTime = 1.5
ENT.DeathAnimationChance = 2
ENT.AnimTbl_Death = {"vjseq_nz_death_1","vjseq_nz_death_2","vjseq_nz_death_3"} 
ENT.GeneralSoundPitch1 = 100
ENT.GeneralSoundPitch2 = 100
ENT.MeleeAttackSoundPitch1 = 100
ENT.MeleeAttackSoundPitch2 = 100
ENT.Immune_Electricity = true
ENT.AnimTbl_Run = {ACT_RUN}
---------------------------------------------------------------------------------------------------------------------------------------------
--custom
ENT.LNR_VirusInfection = true
ENT.LNR_IsWalker = false
ENT.LNR_NextStumble = CurTime()

	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_Breath = {"ambient/energy/electric_loop.wav"}
ENT.SoundTbl_Idle = {"zombie/crimsonhead/crimhead_attack1.wav","zombie/crimsonhead/crimhead_attack2.wav"}
ENT.SoundTbl_Alert = {"zombie/crimsonhead/crimhead_alert.wav"}
ENT.SoundTbl_CombatIdle = {"zombie/crimsonhead/crimhead_alert.wav","zombie/crimsonhead/crimhead_attack1.wav","zombie/crimsonhead/crimhead_attack2.wav"} 
ENT.SoundTbl_Pain = {"zombie/crimsonhead/crimhead_pain.wav"}
ENT.SoundTbl_Death = {"zombie/crimsonhead/crimhead_die.wav"}
ENT.SoundTbl_MeleeAttack = {"ambient/energy/zap9.wav","ambient/energy/zap8.wav","ambient/energy/zap7.wav","ambient/energy/zap6.wav","ambient/energy/zap5.wav","ambient/energy/zap3.wav","ambient/energy/zap2.wav","ambient/energy/zap1.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"npc/zombie/claw_miss2.wav","npc/zombie/claw_miss1.wav"}
ENT.SoundTbl_MeleeAttackSlowPlayer = {"lethalnecrotics/losthope.mp3"}
ENT.SoundTbl_BeforeMeleeAttack = {"zombie/crimsonhead/crimhead_attack1.wav","zombie/crimsonhead/crimhead_attack2.wav"}

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
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink_AIEnabled()
		if IsValid(self:GetEnemy()) then
			self.AnimTbl_IdleStand = {ACT_IDLE_ANGRY}
	    else
		    self.AnimTbl_IdleStand = {ACT_IDLE}	
end	

if math.random(1,5) == 1 then
ParticleEffectAttach("electrical_arc_01_parent",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("forward"))
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
function ENT:CustomOnInitialize()
self.AnimTbl_Walk = {self:GetSequenceActivity(self:LookupSequence("nz_napalm_walk_1","nz_napalm_walk_2","nz_napalm_walk_3"))}
self:SetSkin(math.random(0,3))

self.Light1 = ents.Create("light_dynamic")
	self.Light1:SetKeyValue("brightness", "0.04")
	self.Light1:SetKeyValue("distance", "240")
	self.Light1:SetLocalPos(self:GetPos())
	self.Light1:SetLocalAngles(self:GetAngles())
	self.Light1:Fire("Color", "0 161 255 255")
	self.Light1:SetParent(self)
	self.Light1:Spawn()
	self.Light1:Activate()
	self.Light1:Fire("SetParentAttachment","chest")
	self.Light1:Fire("TurnOn", "", 0)
	self:DeleteOnRemove(self.Light1)
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
        self.LNR_IsWalker = true
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GetSightDirection()
	return self:GetAttachment(self:LookupAttachment("eyes")).Ang:Forward() -- Attachment example
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_BeforeChecks()
    ParticleEffectAttach("electrical_arc_01_parent",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("anim_attachment_RH"))
    ParticleEffectAttach("electrical_arc_01_parent",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("anim_attachment_LH"))
	effects.BeamRingPoint(self:GetPos(), 0.3, 2, 400, 16, 0, Color(188, 220, 255), {material="sprites/bluelight1", framerate=20})
	effects.BeamRingPoint(self:GetPos(), 0.3, 2, 200, 16, 0, Color(188, 220, 255), {material="sprites/bluelight1", framerate=20})
	
	if self.HasSounds == true && GetConVarNumber("vj_npc_sd_meleeattack") == 0 then
		VJ_EmitSound(self,"ambient/energy/whiteflash.wav",100,math.random(80,100))
	end
	
	util.VJ_SphereDamage(self, self, self:GetPos(), 400, 25, self.MeleeAttackDamageType, true, true, {DisableVisibilityCheck=true, Force=80})
	util.ScreenShake(self:GetPos(),44,600,1.5,1000)
    util.ScreenShake(self:GetPos(),44,600,1.5,1000)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "step" then
		self:FootStepSoundCode()
	end
	
	if key == "attack_shock" then
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
function ENT:CustomOnAlert(argent)
if math.random(1,5) == 1 then	
		self:VJ_ACT_PLAYACTIVITY("vjseq_nz_taunt_5",true,2,true)
end
end			
-------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnKilled(dmginfo, hitgroup)
if dmginfo:GetDamageType(DMG_SHOCK) then
   self.LNR_VirusInfection = false		
end

VJ_EmitSound(self,"ambient/energy/whiteflash.wav",100)
ParticleEffect("electrical_arc_01_parent",self:GetPos() + self:GetUp()*48 + self:GetForward()*1,Angle(0,0,0),nil) 
ParticleEffect("electrical_arc_01_parent",self:GetPos() + self:GetUp()*15,Angle(0,0,0),nil)
ParticleEffect("electrical_arc_01_parent",self:GetPos() + self:GetUp()*20,Angle(0,0,0),nil)
ParticleEffect("electrical_arc_01_parent",self:GetPos() + self:GetUp()*20,Angle(0,0,0),nil)
effects.BeamRingPoint(self:GetPos(), 0.3, 2, 400, 16, 0, Color(188, 220, 255), {material="sprites/bluelight1", framerate=20})
effects.BeamRingPoint(self:GetPos(), 0.3, 2, 200, 16, 0, Color(188, 220, 255), {material="sprites/bluelight1", framerate=20})
util.VJ_SphereDamage(self,self,self:GetPos(),150,math.random(50,100),DMG_SHOCK,true,true,{Force=20})
util.VJ_SphereDamage(self,self,self:GetPos(),150,math.random(50,100),DMG_SHOCK,true,true,{Force=20})
util.VJ_SphereDamage(self,self,self:GetPos(),150,math.random(50,100),DMG_SHOCK,true,true,{Force=20})
for k,v in ipairs(ents.FindInSphere(self:GetPos(),150)) do
v:TakeDamage(math.random(50,100),self,self)
end
util.ScreenShake(self:GetPos(),44,600,1.5,1000)
util.ScreenShake(self:GetPos(),44,600,1.5,1000)	
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
	