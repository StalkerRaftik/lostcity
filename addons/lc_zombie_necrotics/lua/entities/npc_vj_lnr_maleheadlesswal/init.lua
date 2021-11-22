AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_lnrhl2/humans/group03/male_01.mdl","models/vj_lnrhl2/humans/group03/male_02.mdl","models/vj_lnrhl2/humans/group03/male_03.mdl","models/vj_lnrhl2/humans/group03/male_04.mdl","models/vj_lnrhl2/humans/group03/male_05.mdl","models/vj_lnrhl2/humans/group03/male_06.mdl","models/vj_lnrhl2/humans/group03/male_07.mdl","models/vj_lnrhl2/humans/group03/male_08.mdl","models/vj_lnrhl2/humans/group03/male_09.mdl","models/vj_lnrhl2/humans/group03m/male_01.mdl","models/vj_lnrhl2/humans/group03m/male_02.mdl","models/vj_lnrhl2/humans/group03m/male_03.mdl","models/vj_lnrhl2/humans/group03m/male_04.mdl","models/vj_lnrhl2/humans/group03m/male_05.mdl","models/vj_lnrhl2/humans/group03m/male_06.mdl","models/vj_lnrhl2/humans/group03m/male_07.mdl","models/vj_lnrhl2/humans/group03m/male_08.mdl","models/vj_lnrhl2/humans/group03m/male_09.mdl","models/vj_lnrhl2/humans/group01/male_01.mdl","models/vj_lnrhl2/humans/group01/male_02.mdl","models/vj_lnrhl2/humans/group01/male_03.mdl","models/vj_lnrhl2/humans/group01/male_04.mdl","models/vj_lnrhl2/humans/group01/male_05.mdl","models/vj_lnrhl2/humans/group01/male_06.mdl","models/vj_lnrhl2/humans/group01/male_07.mdl","models/vj_lnrhl2/humans/group01/male_08.mdl","models/vj_lnrhl2/humans/group01/male_09.mdl","models/vj_lnrhl2/barney.mdl","models/vj_lnrhl2/breen.mdl","models/vj_lnrhl2/barney.mdl","models/vj_lnrhl2/eli.mdl","models/vj_lnrhl2/fisherman.mdl","models/vj_lnrhl2/gman.mdl","models/vj_lnrhl2/kleiner.mdl","models/vj_lnrhl2/magnusson.mdl","models/vj_lnrhl2/monk.mdl","models/vj_lnrhl2/odessa.mdl"}
ENT.IdleSoundLevel = 1
ENT.CombatIdleSoundLevel = 1
ENT.AlertSoundLevel = 1
ENT.BeforeMeleeAttackSoundLevel = 1
ENT.PainSoundLevel = 1
ENT.DeathSoundLevel = 1
ENT.LeapAttackJumpSoundLevel = 1
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()	
if GetConVarNumber("vj_LNR_CitizenSkins") == 1 then
self:SetSkin( math.random(0,3))

elseif GetConVarNumber("vj_LNR_CitizenSkins") == 0 then
self:SetSkin( math.random(0,47))
end
self:SetBodygroup(1,2)
self:SetCollisionBounds(Vector(13, 13, 63), Vector(-13, -13, 0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetUpGibesOnDeath(dmginfo,hitgroup)
if GetConVarNumber("vj_LNR_Gib") == 1 then
	
	if hitgroup == HITGROUP_LEFTARM && dmginfo:GetDamageForce():Length() > 800 then
		self:SetBodygroup(3,2)
	
		if self.HasGibDeathParticles == true then
			for i=1,3 do
				ParticleEffect("blood_impact_red_01_chunk",self:GetAttachment(self:LookupAttachment("chest")).Pos,self:GetAngles())
	end
end
				
			self:EmitSound(Sound("vj_lnrhl2/armbreak.mp3",250))
			self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_02.mdl",{Pos=self:GetAttachment(self:LookupAttachment("chest")).Pos+self:GetUp()*2+self:GetRight()*2})
		    self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_01.mdl",{Pos=self:GetAttachment(self:LookupAttachment("chest")).Pos+self:GetUp()*2+self:GetRight()*2})			
			self:CreateGibEntity("obj_vj_gib","models/gibs/humans/mgib_07.mdl",{Pos=self:GetAttachment(self:LookupAttachment("chest")).Pos+self:GetUp()*2+self:GetRight()*2})
			return true,{AllowCorpse=true}
end
		
	if hitgroup == HITGROUP_RIGHTARM && dmginfo:GetDamageForce():Length() > 800 then
		self:SetBodygroup(2,2)
	
		if self.HasGibDeathParticles == true then
			for i=1,3 do
				ParticleEffect("blood_impact_red_01_chunk",self:GetAttachment(self:LookupAttachment("chest")).Pos,self:GetAngles())
	end
end
				
			self:EmitSound(Sound("vj_lnrhl2/armbreak.mp3",250))
			self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_02.mdl",{Pos=self:GetAttachment(self:LookupAttachment("chest")).Pos+self:GetUp()*2+self:GetRight()*2})
		    self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_01.mdl",{Pos=self:GetAttachment(self:LookupAttachment("chest")).Pos+self:GetUp()*2+self:GetRight()*2})			
			self:CreateGibEntity("obj_vj_gib","models/gibs/humans/mgib_07.mdl",{Pos=self:GetAttachment(self:LookupAttachment("chest")).Pos+self:GetUp()*2+self:GetRight()*2})
			return true,{AllowCorpse=true}
end
end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo,hitgroup,GetCorpse)
if GetConVarNumber("vj_LNR_Gib") == 1 then

	if hitgroup == HITGROUP_RIGHTARM && dmginfo:GetDamageForce():Length() > 800 && self.HasGibDeathParticles == true then
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

	if hitgroup == HITGROUP_LEFTARM && dmginfo:GetDamageForce():Length() > 800 && self.HasGibDeathParticles == true then
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
end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/