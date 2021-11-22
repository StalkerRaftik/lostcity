AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_lnrhl2/humans/group03/female_01.mdl","models/vj_lnrhl2/humans/group03/female_02.mdl","models/vj_lnrhl2/humans/group03/female_03.mdl","models/vj_lnrhl2/humans/group03/female_04.mdl","models/vj_lnrhl2/humans/group03/female_06.mdl","models/vj_lnrhl2/humans/group03/female_07.mdl","models/vj_lnrhl2/humans/group03m/female_01.mdl","models/vj_lnrhl2/humans/group03m/female_02.mdl","models/vj_lnrhl2/humans/group03m/female_03.mdl","models/vj_lnrhl2/humans/group03m/female_04.mdl","models/vj_lnrhl2/humans/group03m/female_06.mdl","models/vj_lnrhl2/humans/group03m/female_07.mdl","models/vj_lnrhl2/alyx.mdl","models/vj_lnrhl2/mossman.mdl","models/vj_lnrhl2/humans/group01/female_01.mdl","models/vj_lnrhl2/humans/group01/female_02.mdl","models/vj_lnrhl2/humans/group01/female_03.mdl","models/vj_lnrhl2/humans/group01/female_04.mdl","models/vj_lnrhl2/humans/group01/female_06.mdl","models/vj_lnrhl2/humans/group01/female_07.mdl"} 
ENT.MeleeAttackDamage = math.Rand(5,8)
ENT.HasDeathAnimation = false
ENT.AttackProps = false 
ENT.PushProps = false
ENT.HasLeapAttack = false 
ENT.CanFlinch = 1
ENT.HitGroupFlinching_DefaultWhenNotHit = false
ENT.HitGroupFlinching_Values = {{HitGroup = {HITGROUP_HEAD}, Animation = {"vjges_flinch_head_01","vjges_flinch_head_02"}}, {HitGroup = {HITGROUP_STOMACH}, Animation = {"vjges_flinch_stomach_01","vjges_flinch_stomach_02"}}, {HitGroup = {HITGROUP_CHEST}, Animation = {"vjges_flinch_01","vjges_flinch_02"}}, {HitGroup = {HITGROUP_LEFTARM}, Animation = {"vjges_flinch_shoulder_l"}}, {HitGroup = {HITGROUP_RIGHTARM}, Animation = {"vjges_flinch_shoulder_r"}}, {HitGroup = {HITGROUP_LEFTLEG}, Animation = {"vjges_flinch_back_01"}}, {HitGroup = {HITGROUP_RIGHTLEG}, Animation = {"vjges_flinch_back_01"}}}
ENT.SoundTbl_MeleeAttack = {"vj_lnrhl2/npc/melee/hit_punch_08.wav","vj_lnrhl2/npc/melee/hit_punch_07.wav","vj_lnrhl2/npc/melee/hit_punch_06.wav","vj_lnrhl2/npc/melee/hit_punch_05.wav","vj_lnrhl2/npc/melee/hit_punch_04.wav","vj_lnrhl2/npc/melee/hit_punch_03.wav","vj_lnrhl2/npc/melee/hit_punch_02.wav","vj_lnrhl2/npc/melee/hit_punch_01.wav"}
ENT.VJC_Data = {
	CameraMode = 1, -- Sets the default camera mode | 1 = Third Person, 2 = First Person
	ThirdP_Offset = Vector(45, 20, -15), -- The offset for the controller when the camera is in third person
	FirstP_Bone = "ValveBiped.Bip01_Head1", -- If left empty, the base will attempt to calculate a position for first person
	FirstP_Offset = Vector(10, 0, -5),  -- The offset for the controller when the camera is in first person
}
-------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
if GetConVarNumber("vj_LNR_CitizenSkins") == 1 then
self:SetSkin( math.random(0,3))

elseif GetConVarNumber("vj_LNR_CitizenSkins") == 0 then
self:SetSkin( math.random(0,39))
end	
	self:SetBodygroup(4,math.random(0,1))
self:SetCollisionBounds(Vector(16,16,20),Vector(-16,-16,0))
        self.AnimTbl_IdleStand = {ACT_IDLE_STIMULATED}
		self.AnimTbl_Walk = {ACT_WALK_STIMULATED}
		self.AnimTbl_Run = {ACT_WALK_STIMULATED}
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo,hitgroup)
	if hitgroup == HITGROUP_HEAD && GetConVarNumber("vj_LNR_Headshot") == 1 then
		dmginfo:SetDamage(self:Health())
   end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	local randattack_close = 1
    if randattack_close == 1 then
		self.AnimTbl_MeleeAttack = {"vjseq_crawlgrabloop"}
		self.MeleeAttackDistance = 25
		self.MeleeAttackDamageDistance = 55
		self.NextAnyAttackTime_Melee = 0.88
		self.MeleeAttackDamageType = DMG_NERVEGAS			
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink_AIEnabled()		
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_AfterDamage(dmginfo,hitgroup)
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/