AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_lnrhl2/zombi.mdl"} 
ENT.MeleeAttackDamage = math.Rand(5,8)
ENT.GeneralSoundPitch1 = 60
ENT.GeneralSoundPitch2 = 60
ENT.FootStepPitch1 = 100
ENT.FootStepPitch2 = 100
ENT.MeleeAttackSoundPitch1 = 100
ENT.MeleeAttackSoundPitch2 = 100
ENT.SoundTbl_FootStep = {"npc/zombie/foot1.wav","npc/zombie/foot2.wav","npc/zombie/foot3.wav"}
ENT.SoundTbl_MeleeAttack = {"hit_punch_08.wav","hit_punch_07.wav","hit_punch_06.wav","hit_punch_05.wav","hit_punch_04.wav","hit_punch_03.wav","hit_punch_02.wav","hit_punch_01.wav"}
--custom
ENT.LN_Run = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
self:SetSkin(math.random(0,1))
		self.AnimTbl_Walk = {self:GetSequenceActivity(self:LookupSequence("nz_napalm_walk_1","nz_napalm_walk_2","nz_napalm_walk_3"))}
		self.AnimTbl_Run = {self:GetSequenceActivity(self:LookupSequence("nz_napalm_walk_1","nz_napalm_walk_2","nz_napalm_walk_3"))}
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	local randattack_stand = math.random(13,13)			
    if randattack_stand == 13 then
        self.MeleeAttackDistance = 12
	    self.MeleeAttackDamageDistance = 55
		self.AnimTbl_MeleeAttack = {"vjseq_Choke_Eat"}
	    self.TimeUntilMeleeAttackDamage = 0.5
		self.NextMeleeAttackTime = 1
		self.MeleeAttackDamageType = DMG_NERVEGAS			
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetUpGibesOnDeath(dmginfo,hitgroup)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo,hitgroup,GetCorpse)
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/