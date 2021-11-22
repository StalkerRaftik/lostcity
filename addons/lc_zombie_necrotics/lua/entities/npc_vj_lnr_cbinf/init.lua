AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_lnrhl2/ElitePolice.mdl","models/vj_lnrhl2/police.mdl","models/vj_lnrhl2/combine_super_soldier.mdl","models/vj_lnrhl2/combine_soldier_prisonguard.mdl","models/vj_lnrhl2/combine_soldier.mdl"}  
ENT.StartHealth = 150 
ENT.LN_IsWalker = false
ENT.AnimTbl_Run = {ACT_SPRINT}
ENT.HasLeapAttack = false
-------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
if self:GetModel() == "models/vj_lnrhl2/police.mdl" && self.LN_Armor == true then
self.LN_Armor = false
self:SetHealth(100)
self.SoundTbl_CombatIdle = {"vj_lnrhl2/cp/idle1.wav","vj_lnrhl2/cp/idle2.wav","vj_lnrhl2/cp/idle3.wav","vj_lnrhl2/cp/idle4.wav","vj_lnrhl2/cp/idle5.wav","vj_lnrhl2/cp/idle6.wav"}
self.SoundTbl_Idle = {"vj_lnrhl2/cp/idle1.wav","vj_lnrhl2/cp/idle2.wav","vj_lnrhl2/cp/idle3.wav","vj_lnrhl2/cp/idle4.wav","vj_lnrhl2/cp/idle5.wav","vj_lnrhl2/cp/idle6.wav"}
self.SoundTbl_Alert = {"vj_lnrhl2/cp/alert1.wav","vj_lnrhl2/cp/alert2.wav","vj_lnrhl2/cp/alert3.wav"}
self.SoundTbl_Pain = {"vj_lnrhl2/cp/pain1.wav","vj_lnrhl2/cp/pain2.wav","vj_lnrhl2/cp/pain3.wav","vj_lnrhl2/cp/pain4.wav"}
self.SoundTbl_Death = {"vj_lnrhl2/cp/die1.wav","vj_lnrhl2/cp/die2.wav","vj_lnrhl2/cp/die3.wav","vj_lnrhl2/cp/die4.wav"}
self.SoundTbl_BeforeMeleeAttack = {"vj_lnrhl2/cp/attack1.wav","vj_lnrhl2/cp/attack2.wav","vj_lnrhl2/cp/attack3.wav","vj_lnrhl2/cp/attack4.wav","vj_lnrhl2/cp/attack6.wav"}
self.SoundTbl_LeapAttackJump = {"vj_lnrhl2/cp/attack1.wav","vj_lnrhl2/cp/attack2.wav","vj_lnrhl2/cp/attack3.wav","vj_lnrhl2/cp/attack4.wav","vj_lnrhl2/cp/attack6.wav"}

elseif self:GetModel() == "models/vj_lnrhl2/elitepolice.mdl" then
self:SetHealth(125)
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
function ENT:CustomOnPreInitialize() 
self.MeleeAttackDamage = self.MeleeAttackDamage * GetConVarNumber("vj_LNR_Infected_DamageModifier")
self.StartHealth = self.StartHealth * GetConVarNumber("vj_LNR_Infected_HealthModifier")	
self:SetHealth(self.StartHealth)
self.MeleeAttackBleedEnemyDamage = self.MeleeAttackBleedEnemyDamage * GetConVarNumber("vj_LNR_BleedDamage")
self.MeleeAttackBleedEnemyReps = self.MeleeAttackBleedEnemyReps * GetConVarNumber("vj_LNR_BleedReps")
self.MeleeAttackBleedEnemyChance = self.MeleeAttackBleedEnemyChance * GetConVarNumber("vj_LNR_BleedChance")

if GetConVarNumber("vj_LNR_Infection") == 0 then 
		self.LN_VirusInfection = false 

elseif GetConVarNumber("vj_LNR_DeathAnimations") == 0 then 
		self.HasDeathAnimation = false	

elseif GetConVarNumber("vj_LNR_InfectionDamage") == 0 then 
		self.SlowPlayerOnMeleeAttack = false
		self.MeleeAttackBleedEnemy = false
end

if math.random(1,3) == 1 then
self.AnimTbl_IdleStand = {ACT_IDLE_STIMULATED}
end
end
-------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnCallForHelp(ally)
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
	
if math.random(1,20) == 1 && GetConVarNumber("vj_LNR_Run") == 1 then --&& (self.StartHealth -50 > self:Health()) then
self.AnimTbl_Run = {self:GetSequenceActivity(self:LookupSequence("nz_sonic_run_1","nz_sonic_run_2","nz_sonic_run_3"))}
end	
end	
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/