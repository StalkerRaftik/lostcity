AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_lnrspecials/dancer.mdl"} 
ENT.StartHealth = 300 
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
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.DisableFootStepSoundTimer = true
--ENT.HasSoundTrack = true
ENT.SoundTrackVolume = 0.5
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.HasDeathAnimation = true
ENT.DeathAnimationTime = 1.5
ENT.DeathAnimationChance = 2
ENT.AnimTbl_Death = {"vjseq_nz_death_1","vjseq_nz_death_2","vjseq_nz_death_3"} 
ENT.GeneralSoundPitch1 = 100
ENT.GeneralSoundPitch2 = 100
ENT.MeleeAttackSoundPitch1 = 100
ENT.MeleeAttackSoundPitch2 = 100
ENT.AnimTbl_Walk = {ACT_WALK_AIM}
ENT.AnimTbl_Run = {ACT_WALK_AIM}
---------------------------------------------------------------------------------------------------------------------------------------------
--custom
ENT.LNR_VirusInfection = true
ENT.LNR_IsWalker = false
ENT.Dancer_NextZombieSpawnT = 0
ENT.Dancer_AlreadySpawned = false
ENT.LNR_NextStumble = CurTime()

	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_Idle = {"undead/undead_misc0.wav","undead/undead_misc1.wav","undead/undead_misc2.wav","undead/undead_misc3.wav","undead/undead_hail0.wav","undead/undead_hail1.wav","undead/undead_hail2.wav"}
ENT.SoundTbl_Alert = {"undead/undead_threat1.wav","undead/undead_threat2.wav","undead/undead_threat3.wav","undead/undead_threat4.wav"}
ENT.SoundTbl_CombatIdle = {"undead/undead_threat1.wav","undead/undead_threat2.wav","undead/undead_threat3.wav","undead/undead_threat4.wav","undead/undead_misc3.wav","undead/undead_hail0.wav","undead/undead_hail1.wav","undead/undead_hail2.wav"} 
ENT.SoundTbl_Pain = {"undead/undead_ouch0.wav","undead/undead_ouch1.wav","undead/undead_ouch2.wav"}
ENT.SoundTbl_Death = {"undead/undead_dying0.wav","undead/undead_dying1.wav","undead/undead_dying2.wav"}
ENT.SoundTbl_MeleeAttack = {"vj_lnrhl2/claw_strike1.mp3","vj_lnrhl2/claw_strike2.mp3","vj_lnrhl2/claw_strike3.mp3"}
ENT.SoundTbl_BeforeMeleeAttack = {"undead/undead_striking0.wav","undead/undead_striking1.wav","undead/undead_striking2.wav","undead/undead_striking3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"npc/zombie/claw_miss2.wav","npc/zombie/claw_miss1.wav"}

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
function ENT:Controller_IntMsg(ply)
	ply:ChatPrint("JUMP: Summon Backup Dancers")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink_AIEnabled()
		if IsValid(self:GetEnemy()) then
			self.AnimTbl_IdleStand = {ACT_IDLE_ANGRY}
	    else
		    self.AnimTbl_IdleStand = {ACT_IDLE}	
end		
	
	if IsValid(self:GetEnemy()) && CurTime() > self.Dancer_NextZombieSpawnT then
		if !IsValid(self.Zombie1) && !IsValid(self.Zombie2) && !IsValid(self.Zombie3) && !IsValid(self.Zombie4) && self.Dancer_AlreadySpawned == false && ((self.VJ_IsBeingControlled == false) or (self.VJ_IsBeingControlled == true && self.VJ_TheController:KeyDown(IN_JUMP))) then
			if self.VJ_IsBeingControlled == true then
				self.VJ_TheController:PrintMessage(HUD_PRINTCENTER,"Time to Zomboogie!")
end
			self.Dancer_AlreadySpawned = true
			self:VJ_ACT_PLAYACTIVITY("vjseq_reanimated",true,4.5,false)
			--ParticleEffect("aurora_shockwave_debris",self:GetPos(),Angle(0,0,0),nil)
			--ParticleEffect("aurora_shockwave",self:GetPos(),Angle(0,0,0),nil)	
			effects.BeamRingPoint(self:GetPos(), 0.3, 2, 400, 16, 0, Color(63, 0, 127, 255), {material="sprites/bluelight1", framerate=20})
	        effects.BeamRingPoint(self:GetPos(), 0.3, 2, 200, 16, 0, Color(63, 0, 127, 255), {material="sprites/bluelight1", framerate=20})
			self.carnocustomsd1 = CreateSound(self, Sound("vj_lnrhl2/dancing_zombie.wav")) self.carnocustomsd1:SetSoundLevel(70)
			self.carnocustomsd1:PlayEx(100,100)
			self.Light1 = ents.Create("light_dynamic")
	        self.Light1:SetKeyValue("brightness", "0.04")
	        self.Light1:SetKeyValue("distance", "240")
	        self.Light1:SetLocalPos(self:GetPos())
	        self.Light1:SetLocalAngles(self:GetAngles())
	        self.Light1:Fire("Color", "63 0 127 255")
	        self.Light1:SetParent(self)
	        self.Light1:Spawn()
	        self.Light1:Activate()
	        self.Light1:Fire("SetParentAttachment","chest")
	        self.Light1:Fire("TurnOn", "", 0)
	        self:DeleteOnRemove(self.Light1)
			
			self.Zombie1 = ents.Create("npc_vj_lnr_dancer_backup")
			self.Zombie1:SetPos(self:GetPos() +self:GetRight()*60)
			self.Zombie1:SetAngles(self:GetAngles())
			self.Zombie1:Spawn()
			self.Zombie1:SetNoDraw(true)
			timer.Simple(0.3,function() if IsValid(self.Zombie1) then self.Zombie1:SetNoDraw(false) end end)
			self.Zombie1:VJ_ACT_PLAYACTIVITY("vjseq_reanimated",true,4.5,true,0,{SequenceDuration=4.5})
			self.Zombie1:SetOwner(self)
			
			self.Zombie2 = ents.Create("npc_vj_lnr_dancer_backup")
			self.Zombie2:SetPos(self:GetPos() +self:GetRight()*-60)
			self.Zombie2:SetAngles(self:GetAngles())
			self.Zombie2:Spawn()
			self.Zombie2:SetNoDraw(true)
			timer.Simple(0.3,function() if IsValid(self.Zombie2) then self.Zombie2:SetNoDraw(false) end end)
			self.Zombie2:VJ_ACT_PLAYACTIVITY("vjseq_reanimated",true,4.5,true,0,{SequenceDuration=4.5})
			self.Zombie2:SetOwner(self)
			
			self.Zombie3 = ents.Create("npc_vj_lnr_dancer_backup")
			self.Zombie3:SetPos(self:GetPos() +self:GetForward()*60)
			self.Zombie3:SetAngles(self:GetAngles())
			self.Zombie3:Spawn()
			self.Zombie3:SetNoDraw(true)
			timer.Simple(0.3,function() if IsValid(self.Zombie3) then self.Zombie3:SetNoDraw(false) end end)
			self.Zombie3:VJ_ACT_PLAYACTIVITY("vjseq_reanimated",true,4.5,true,0,{SequenceDuration=4.5})
			self.Zombie3:SetOwner(self)			
			
			self.Zombie4 = ents.Create("npc_vj_lnr_dancer_backup")
			self.Zombie4:SetPos(self:GetPos() +self:GetForward()*-60)
			self.Zombie4:SetAngles(self:GetAngles())
			self.Zombie4:Spawn()
			self.Zombie4:SetNoDraw(true)
			timer.Simple(0.3,function() if IsValid(self.Zombie4) then self.Zombie4:SetNoDraw(false) end end)
			self.Zombie4:VJ_ACT_PLAYACTIVITY("vjseq_reanimated",true,4.5,true,0,{SequenceDuration=4.5})
			self.Zombie4:SetOwner(self)					
						
			self.Dancer_AlreadySpawned = false
			self.Dancer_NextZombieSpawnT = CurTime() + 20
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DoKilledEnemy(victim,attacker,inflictor)	
        self:VJ_ACT_PLAYACTIVITY("vjseq_reanimated",true,4.5,true)	
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove() 
self:StopSound("vj_lnrhl2/dancing_zombie.wav")
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