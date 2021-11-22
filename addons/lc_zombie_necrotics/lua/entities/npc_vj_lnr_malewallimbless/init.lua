AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_lnrhl2/humans/group03/male_01.mdl","models/vj_lnrhl2/humans/group03/male_02.mdl","models/vj_lnrhl2/humans/group03/male_03.mdl","models/vj_lnrhl2/humans/group03/male_04.mdl","models/vj_lnrhl2/humans/group03/male_05.mdl","models/vj_lnrhl2/humans/group03/male_06.mdl","models/vj_lnrhl2/humans/group03/male_07.mdl","models/vj_lnrhl2/humans/group03/male_08.mdl","models/vj_lnrhl2/humans/group03/male_09.mdl","models/vj_lnrhl2/humans/group03m/male_01.mdl","models/vj_lnrhl2/humans/group03m/male_02.mdl","models/vj_lnrhl2/humans/group03m/male_03.mdl","models/vj_lnrhl2/humans/group03m/male_04.mdl","models/vj_lnrhl2/humans/group03m/male_05.mdl","models/vj_lnrhl2/humans/group03m/male_06.mdl","models/vj_lnrhl2/humans/group03m/male_07.mdl","models/vj_lnrhl2/humans/group03m/male_08.mdl","models/vj_lnrhl2/humans/group03m/male_09.mdl","models/vj_lnrhl2/humans/group01/male_01.mdl","models/vj_lnrhl2/humans/group01/male_02.mdl","models/vj_lnrhl2/humans/group01/male_03.mdl","models/vj_lnrhl2/humans/group01/male_04.mdl","models/vj_lnrhl2/humans/group01/male_05.mdl","models/vj_lnrhl2/humans/group01/male_06.mdl","models/vj_lnrhl2/humans/group01/male_07.mdl","models/vj_lnrhl2/humans/group01/male_08.mdl","models/vj_lnrhl2/humans/group01/male_09.mdl","models/vj_lnrhl2/barney.mdl","models/vj_lnrhl2/breen.mdl","models/vj_lnrhl2/barney.mdl","models/vj_lnrhl2/eli.mdl","models/vj_lnrhl2/fisherman.mdl","models/vj_lnrhl2/gman.mdl","models/vj_lnrhl2/kleiner.mdl","models/vj_lnrhl2/magnusson.mdl","models/vj_lnrhl2/monk.mdl","models/vj_lnrhl2/odessa.mdl"} 
ENT.MeleeAttackDamage = math.Rand(8,12)
ENT.SoundTbl_MeleeAttack = {"vj_lnrhl2/npc/melee/hit_punch_08.wav","vj_lnrhl2/npc/melee/hit_punch_07.wav","vj_lnrhl2/npc/melee/hit_punch_06.wav","vj_lnrhl2/npc/melee/hit_punch_05.wav","vj_lnrhl2/npc/melee/hit_punch_04.wav","vj_lnrhl2/npc/melee/hit_punch_03.wav","vj_lnrhl2/npc/melee/hit_punch_02.wav","vj_lnrhl2/npc/melee/hit_punch_01.wav"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
if GetConVarNumber("vj_LNR_CitizenSkins") == 1 then
self:SetSkin( math.random(0,3))

elseif GetConVarNumber("vj_LNR_CitizenSkins") == 0 then
self:SetSkin( math.random(0,47))
end
	if math.random(1,1) == 1 then 
	self:SetBodygroup(2,math.random(1,2))
	self:SetBodygroup(3,math.random(1,2))
end
	if math.random(1,1) == 1 then 
	self:SetBodygroup(2,math.random(1,2))
	self:SetBodygroup(3,math.random(0,2))
end
	if math.random(1,2) == 1 then 
	self:SetBodygroup(2,math.random(0,2))
	self:SetBodygroup(3,math.random(1,2))
end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "step" then
		self:FootStepSoundCode()
	end
	
	if key == "attack_leap" then
		self:MeleeAttackCode() 
    end	
	
	if key == "attack_leap" then
		self:LeapDamageCode() 
    end	
	
	if key == "death" then
		VJ_EmitSound(self, "physics/flesh/flesh_impact_hard"..math.random(1,5)..".wav", 85, math.random(100,100))
	end	

	if key == "infection_step" then
		VJ_EmitSound(self, "npc/zombie/foot"..math.random(1,3)..".wav", 85, math.random(100,100))
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
end		
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	local randattack_stand = math.random(1,1)
        if randattack_stand == 1 then
        self.MeleeAttackDistance = 12
	    self.MeleeAttackDamageDistance = 55
		self.AnimTbl_MeleeAttack = {"vjseq_Choke_Eat"}
	    self.TimeUntilMeleeAttackDamage = false
		self.MeleeAttackExtraTimers = {}
		self.NextMeleeAttackTime = 1
		self.NextAnyAttackTime_Melee = 1.2000000286102
		self.MeleeAttackDamageType = DMG_NERVEGAS		
end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/