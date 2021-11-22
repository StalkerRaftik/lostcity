AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_lnrhl2/humans/group03/female_01.mdl","models/vj_lnrhl2/humans/group03/female_02.mdl","models/vj_lnrhl2/humans/group03/female_03.mdl","models/vj_lnrhl2/humans/group03/female_04.mdl","models/vj_lnrhl2/humans/group03/female_06.mdl","models/vj_lnrhl2/humans/group03/female_07.mdl","models/vj_lnrhl2/humans/group03m/female_01.mdl","models/vj_lnrhl2/humans/group03m/female_02.mdl","models/vj_lnrhl2/humans/group03m/female_03.mdl","models/vj_lnrhl2/humans/group03m/female_04.mdl","models/vj_lnrhl2/humans/group03m/female_06.mdl","models/vj_lnrhl2/humans/group03m/female_07.mdl","models/vj_lnrhl2/alyx.mdl","models/vj_lnrhl2/mossman.mdl","models/vj_lnrhl2/humans/group01/female_01.mdl","models/vj_lnrhl2/humans/group01/female_02.mdl","models/vj_lnrhl2/humans/group01/female_03.mdl","models/vj_lnrhl2/humans/group01/female_04.mdl","models/vj_lnrhl2/humans/group01/female_06.mdl","models/vj_lnrhl2/humans/group01/female_07.mdl"}
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
self:SetSkin( math.random(0,39))
end	
self:SetBodygroup(1,2)
self:SetCollisionBounds(Vector(13, 13, 61), Vector(-13, -13, 0))
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