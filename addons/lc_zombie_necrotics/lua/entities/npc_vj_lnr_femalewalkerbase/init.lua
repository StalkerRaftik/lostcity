AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_lnrhl2/alyx.mdl"} 
ENT.StartHealth = 100
ENT.HullType = HULL_HUMAN
ENT.CanFlinch = 1
ENT.FlinchChance = 3
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
ENT.TimeUntilMeleeAttackDamage = false
ENT.MeleeAttackAnimationAllowOtherTasks = true
ENT.MeleeAttackDamage = math.Rand(10,15)
ENT.HasOnKilledEnemySound = false
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.SlowPlayerOnMeleeAttack = true 
ENT.SlowPlayerOnMeleeAttack_WalkSpeed = 30
ENT.SlowPlayerOnMeleeAttack_RunSpeed = 45
ENT.SlowPlayerOnMeleeAttackTime = 0.5
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.MeleeAttackBleedEnemy = true 
ENT.MeleeAttackBleedEnemyChance = 1
ENT.MeleeAttackBleedEnemyDamage = 5
ENT.MeleeAttackBleedEnemyTime = 2
ENT.MeleeAttackBleedEnemyReps = 5
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.HasLeapAttack = true  
ENT.LeapAttackDamage = math.Rand(8,12)
ENT.TimeUntilLeapAttackDamage = false
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
ENT.GibOnDeathDamagesTable = {"All"}
---------------------------------------------------------------------------------------------------------------------------------------------
--custom
ENT.LN_VirusInfection = true
ENT.LN_IsWalker = true
ENT.LN_Run = false
ENT.LN_NextStumble = CurTime()

	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
--ENT.SoundTbl_FootStep = {"zombie_footstep_m_11.wav","zombie_footstep_m_06.wav","zombie_footstep_m_02.wav"}
ENT.SoundTbl_Idle = {"vj_lnrhl2/walkers/female/idle01.mp3","vj_lnrhl2/walkers/female/idle02.mp3","vj_lnrhl2/walkers/female/idle03.mp3","vj_lnrhl2/walkers/female/idle04.mp3","vj_lnrhl2/walkers/female/idle05.mp3","vj_lnrhl2/walkers/female/idle06.mp3","vj_lnrhl2/walkers/female/idle07.mp3","vj_lnrhl2/walkers/female/idle08.mp3","vj_lnrhl2/walkers/female/idle09.mp3","vj_lnrhl2/walkers/female/idle10.mp3"}
ENT.SoundTbl_Alert = {"vj_lnrhl2/walkers/female/alert11.wav","vj_lnrhl2/walkers/female/alert12.wav","vj_lnrhl2/walkers/female/alert13.wav","vj_lnrhl2/walkers/female/alert14.wav","vj_lnrhl2/walkers/female/alert_10.wav","vj_lnrhl2/walkers/female/alert01.mp3","vj_lnrhl2/walkers/female/alert02.mp3","vj_lnrhl2/walkers/female/alert03.mp3","vj_lnrhl2/walkers/female/alert04.mp3","vj_lnrhl2/walkers/female/alert05.mp3","vj_lnrhl2/walkers/female/alert06.mp3","vj_lnrhl2/walkers/female/alert07.mp3","vj_lnrhl2/walkers/female/alert08.mp3","vj_lnrhl2/walkers/female/alert09.mp3","vj_lnrhl2/walkers/female/alert10.mp3"}
ENT.SoundTbl_CombatIdle = {"vj_lnrhl2/walkers/female/alert11.wav","vj_lnrhl2/walkers/female/alert12.wav","vj_lnrhl2/walkers/female/alert13.wav","vj_lnrhl2/walkers/female/alert14.wav","vj_lnrhl2/walkers/female/alert_10.wav","vj_lnrhl2/walkers/female/alert01.mp3","vj_lnrhl2/walkers/female/alert02.mp3","vj_lnrhl2/walkers/female/alert03.mp3","vj_lnrhl2/walkers/female/alert04.mp3","vj_lnrhl2/walkers/female/alert05.mp3","vj_lnrhl2/walkers/female/alert06.mp3","vj_lnrhl2/walkers/female/alert07.mp3","vj_lnrhl2/walkers/female/alert08.mp3","vj_lnrhl2/walkers/female/alert09.mp3","vj_lnrhl2/walkers/female/alert10.mp3"}
ENT.SoundTbl_BeforeMeleeAttack = {"vj_lnrhl2/walkers/female/alert11.wav","vj_lnrhl2/walkers/female/alert12.wav","vj_lnrhl2/walkers/female/alert13.wav","vj_lnrhl2/walkers/female/alert14.wav","vj_lnrhl2/walkers/female/alert_10.wav","vj_lnrhl2/walkers/female/alert01.mp3","vj_lnrhl2/walkers/female/alert02.mp3","vj_lnrhl2/walkers/female/alert03.mp3","vj_lnrhl2/walkers/female/alert04.mp3","vj_lnrhl2/walkers/female/alert05.mp3","vj_lnrhl2/walkers/female/alert06.mp3","vj_lnrhl2/walkers/female/alert07.mp3","vj_lnrhl2/walkers/female/alert08.mp3","vj_lnrhl2/walkers/female/alert09.mp3","vj_lnrhl2/walkers/female/alert10.mp3"}
ENT.SoundTbl_MeleeAttack = {"vj_lnrhl2/claw_strike1.mp3","vj_lnrhl2/claw_strike2.mp3","vj_lnrhl2/claw_strike3.mp3"}
ENT.SoundTbl_MeleeAttackMiss = {"npc/zombie/claw_miss2.wav","npc/zombie/claw_miss1.wav"}
ENT.SoundTbl_MeleeAttackSlowPlayer = {"vj_lnrhl2/losthope.mp3"}
ENT.SoundTbl_LeapAttackJump = {"vj_lnrhl2/walkers/female/alert11.wav","vj_lnrhl2/walkers/female/alert12.wav","vj_lnrhl2/walkers/female/alert13.wav","vj_lnrhl2/walkers/female/alert14.wav","vj_lnrhl2/walkers/female/alert_10.wav","vj_lnrhl2/walkers/female/alert01.mp3","vj_lnrhl2/walkers/female/alert02.mp3","vj_lnrhl2/walkers/female/alert03.mp3","vj_lnrhl2/walkers/female/alert04.mp3","vj_lnrhl2/walkers/female/alert05.mp3","vj_lnrhl2/walkers/female/alert06.mp3","vj_lnrhl2/walkers/female/alert07.mp3","vj_lnrhl2/walkers/female/alert08.mp3","vj_lnrhl2/walkers/female/alert09.mp3","vj_lnrhl2/walkers/female/alert10.mp3"}
ENT.SoundTbl_LeapAttackDamage = {"vj_lnrhl2/npc/melee/hit_punch_08.wav","vj_lnrhl2/npc/melee/hit_punch_07.wav","vj_lnrhl2/npc/melee/hit_punch_06.wav","vj_lnrhl2/npc/melee/hit_punch_05.wav","vj_lnrhl2/npc/melee/hit_punch_04.wav","vj_lnrhl2/npc/melee/hit_punch_03.wav","vj_lnrhl2/npc/melee/hit_punch_02.wav","vj_lnrhl2/npc/melee/hit_punch_01.wav"}
ENT.SoundTbl_LeapAttackDamageMiss = {"npc/zombie/claw_miss2.wav","npc/zombie/claw_miss1.wav"}
ENT.SoundTbl_Pain = {"vj_lnrhl2/walkers/female/pain01.mp3","vj_lnrhl2/walkers/female/pain02.mp3","vj_lnrhl2/walkers/female/pain03.mp3","vj_lnrhl2/walkers/female/pain04.mp3","vj_lnrhl2/walkers/female/pain05.mp3"}
ENT.SoundTbl_Death = {"vj_lnrhl2/walkers/female/pain01.mp3","vj_lnrhl2/walkers/female/pain02.mp3","vj_lnrhl2/walkers/female/pain03.mp3","vj_lnrhl2/walkers/female/pain04.mp3","vj_lnrhl2/walkers/female/pain05.mp3"}

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
if GetConVarNumber("vj_LNR_Gib") == 0 then
        self.AllowedToGib = false 
        self.HasGibOnDeath = false 
        self.HasGibOnDeathSounds = false 
        self.HasGibDeathParticles = false
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
if GetConVarNumber("vj_LNR_InfectionDamage") == 1 then
self.SlowPlayerOnMeleeAttackTime = self.SlowPlayerOnMeleeAttackTime * GetConVarNumber("vj_LNR_SlowTime")
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
function ENT:GetSightDirection()
	return self:GetAttachment(self:LookupAttachment("eyes")).Ang:Forward() -- Attachment example
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo,hitgroup)
if math.random(1,20) == 1 && GetConVarNumber("vj_LNR_Run") == 1 then --&& (self.StartHealth -50 > self:Health()) then
self.AnimTbl_Run = {ACT_RUN}	
end
	if hitgroup == HITGROUP_HEAD && GetConVarNumber("vj_LNR_Headshot") == 1 then
		dmginfo:SetDamage(self:Health())
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
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetUpGibesOnDeath(dmginfo,hitgroup)
if GetConVarNumber("vj_LNR_Gib") == 1 then

	if hitgroup == HITGROUP_HEAD && dmginfo:GetDamageForce():Length() > 800 then
	    self:EmitSound(Sound("vj_lnrhl2/headshot.mp3",250))
		self:SetBodygroup(1,2)
	
		if self.HasGibDeathParticles == true then
			for i=1,3 do
				ParticleEffect("blood_impact_red_01",self:GetAttachment(self:LookupAttachment("forward")).Pos,self:GetAngles())
				
		local bloodeffect = ents.Create("info_particle_system")
		bloodeffect:SetKeyValue("effect_name","blood_advisor_pierce_spray")
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
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_01.mdl",{Pos=self:GetAttachment(self:LookupAttachment("forward")).Pos+self:GetUp()*5})
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_02.mdl",{Pos=self:GetAttachment(self:LookupAttachment("forward")).Pos+self:GetUp()*5+self:GetRight()*2})
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_01.mdl",{Pos=self:GetAttachment(self:LookupAttachment("forward")).Pos+self:GetUp()*5+self:GetRight()*2})
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_02.mdl",{Pos=self:GetAttachment(self:LookupAttachment("forward")).Pos+self:GetUp()*5+self:GetRight()*5})
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_03.mdl",{Pos=self:GetAttachment(self:LookupAttachment("forward")).Pos+self:GetUp()*5+self:GetRight()*5})
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_02.mdl",{Pos=self:GetAttachment(self:LookupAttachment("forward")).Pos+self:GetUp()*5+self:GetRight()*5})
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_03.mdl",{Pos=self:GetAttachment(self:LookupAttachment("forward")).Pos+self:GetUp()*5+self:GetRight()*5})
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_02.mdl",{Pos=self:GetAttachment(self:LookupAttachment("forward")).Pos+self:GetUp()*5+self:GetRight()*5})
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_03.mdl",{Pos=self:GetAttachment(self:LookupAttachment("forward")).Pos+self:GetUp()*5+self:GetRight()*5})
		return true,{DeathAnim=true,AllowCorpse=true}
end
	
	if hitgroup == HITGROUP_LEFTARM && dmginfo:GetDamageForce():Length() > 800 then
        self:EmitSound(Sound("vj_lnrhl2/armbreak.mp3",250))	
		self:SetBodygroup(3,2)
	
		if self.HasGibDeathParticles == true then
			for i=1,3 do
				ParticleEffect("blood_impact_red_01_chunk",self:GetAttachment(self:LookupAttachment("chest")).Pos,self:GetAngles())
				
		local bloodeffect = ents.Create("info_particle_system")
		bloodeffect:SetKeyValue("effect_name","blood_advisor_pierce_spray")
		bloodeffect:SetPos(self:GetAttachment(self:LookupAttachment("anim_attachment_LH")).Pos)
		bloodeffect:SetAngles(self:GetAttachment(self:LookupAttachment("anim_attachment_LH")).Ang)
		bloodeffect:SetParent(self)
		bloodeffect:Fire("SetParentAttachment","anim_attachment_LH")
		bloodeffect:Spawn()
		bloodeffect:Activate()
		bloodeffect:Fire("Start","",0)
		bloodeffect:Fire("Kill","",2)				
				
	end
end				
			self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_02.mdl",{Pos=self:GetAttachment(self:LookupAttachment("chest")).Pos+self:GetUp()*2+self:GetRight()*2})
		    self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_01.mdl",{Pos=self:GetAttachment(self:LookupAttachment("chest")).Pos+self:GetUp()*2+self:GetRight()*2})			
			self:CreateGibEntity("obj_vj_gib","models/gibs/humans/mgib_07.mdl",{Pos=self:GetAttachment(self:LookupAttachment("chest")).Pos+self:GetUp()*2+self:GetRight()*2})
			return true,{DeathAnim=true,AllowCorpse=true}
end
		
	if hitgroup == HITGROUP_RIGHTARM && dmginfo:GetDamageForce():Length() > 800 then
        self:EmitSound(Sound("vj_lnrhl2/armbreak.mp3",250))	
		self:SetBodygroup(2,2)
	
		if self.HasGibDeathParticles == true then
			for i=1,3 do
				ParticleEffect("blood_impact_red_01_chunk",self:GetAttachment(self:LookupAttachment("chest")).Pos,self:GetAngles())
				
		local bloodeffect = ents.Create("info_particle_system")
		bloodeffect:SetKeyValue("effect_name","blood_advisor_pierce_spray")
		bloodeffect:SetPos(self:GetAttachment(self:LookupAttachment("anim_attachment_RH")).Pos)
		bloodeffect:SetAngles(self:GetAttachment(self:LookupAttachment("anim_attachment_RH")).Ang)
		bloodeffect:SetParent(self)
		bloodeffect:Fire("SetParentAttachment","anim_attachment_RH")
		bloodeffect:Spawn()
		bloodeffect:Activate()
		bloodeffect:Fire("Start","",0)
		bloodeffect:Fire("Kill","",2)				
				
	end
end				
		    self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_02.mdl",{Pos=self:GetAttachment(self:LookupAttachment("chest")).Pos+self:GetUp()*2+self:GetRight()*2})
		    self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_01.mdl",{Pos=self:GetAttachment(self:LookupAttachment("chest")).Pos+self:GetUp()*2+self:GetRight()*2})			
			self:CreateGibEntity("obj_vj_gib","models/gibs/humans/mgib_07.mdl",{Pos=self:GetAttachment(self:LookupAttachment("chest")).Pos+self:GetUp()*2+self:GetRight()*2})
			return true,{DeathAnim=true,AllowCorpse=true}
end
end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo,hitgroup,GetCorpse)
if GetConVarNumber("vj_LNR_Gib") == 1 then

	if hitgroup == HITGROUP_HEAD && dmginfo:GetDamageForce():Length() > 800 && self.HasGibDeathParticles == true && self.HasBeenGibbedOnDeath == true then
		local bloodeffect = ents.Create("info_particle_system")
		bloodeffect:SetKeyValue("effect_name","blood_advisor_pierce_spray")
		bloodeffect:SetPos(GetCorpse:GetAttachment(GetCorpse:LookupAttachment("forward")).Pos)
		bloodeffect:SetAngles(GetCorpse:GetAttachment(GetCorpse:LookupAttachment("forward")).Ang)
		bloodeffect:SetParent(GetCorpse)
		bloodeffect:Fire("SetParentAttachment","forward")
		bloodeffect:Spawn()
		bloodeffect:Activate()
		bloodeffect:Fire("Start","",0)
		bloodeffect:Fire("Kill","",2)
	end

	if hitgroup == HITGROUP_RIGHTARM && dmginfo:GetDamageForce():Length() > 800 && self.HasGibDeathParticles == true && self.HasBeenGibbedOnDeath == true then
		local bloodeffect = ents.Create("info_particle_system")
		bloodeffect:SetKeyValue("effect_name","blood_advisor_pierce_spray")
		bloodeffect:SetPos(GetCorpse:GetAttachment(GetCorpse:LookupAttachment("anim_attachment_RH")).Pos)
		bloodeffect:SetAngles(GetCorpse:GetAttachment(GetCorpse:LookupAttachment("anim_attachment_RH")).Ang)
		bloodeffect:SetParent(GetCorpse)
		bloodeffect:Fire("SetParentAttachment","anim_attachment_RH")
		bloodeffect:Spawn()
		bloodeffect:Activate()
		bloodeffect:Fire("Start","",0)
		bloodeffect:Fire("Kill","",2)
	end

	if hitgroup == HITGROUP_LEFTARM && dmginfo:GetDamageForce():Length() > 800 && self.HasGibDeathParticles == true && self.HasBeenGibbedOnDeath == true then
		local bloodeffect = ents.Create("info_particle_system")
		bloodeffect:SetKeyValue("effect_name","blood_advisor_pierce_spray")
		bloodeffect:SetPos(GetCorpse:GetAttachment(GetCorpse:LookupAttachment("anim_attachment_LH")).Pos)
		bloodeffect:SetAngles(GetCorpse:GetAttachment(GetCorpse:LookupAttachment("anim_attachment_LH")).Ang)
		bloodeffect:SetParent(GetCorpse)
		bloodeffect:Fire("SetParentAttachment","anim_attachment_LH")
		bloodeffect:Spawn()
		bloodeffect:Activate()
		bloodeffect:Fire("Start","",0)
		bloodeffect:Fire("Kill","",2)
	end
	
	--if hitgroup == HITGROUP_STOMACH && dmginfo:GetDamageForce():Length() > 800 && self.HasGibDeathParticles == true && self.HasBeenGibbedOnDeath == true then		
		--local bloodeffect = ents.Create("info_particle_system")
		--bloodeffect:SetKeyValue("effect_name","blood_impact_red_01_chunk")
		--bloodeffect:SetPos(GetCorpse:GetAttachment(GetCorpse:LookupAttachment("chest")).Pos)
		--bloodeffect:SetAngles(GetCorpse:GetAttachment(GetCorpse:LookupAttachment("chest")).Ang)
		--bloodeffect:SetParent(GetCorpse)
		--bloodeffect:Fire("SetParentAttachment","chest")
		--bloodeffect:Spawn()
		--bloodeffect:Activate()
		--bloodeffect:Fire("Start","",0)
		--bloodeffect:Fire("Kill","",2)
end
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