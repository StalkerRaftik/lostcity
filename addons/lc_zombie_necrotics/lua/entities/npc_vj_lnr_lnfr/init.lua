AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_lnrhl2/humans/group03/female_01.mdl","models/vj_lnrhl2/humans/group03/female_02.mdl","models/vj_lnrhl2/humans/group03/female_03.mdl","models/vj_lnrhl2/humans/group03/female_04.mdl","models/vj_lnrhl2/humans/group03/female_06.mdl","models/vj_lnrhl2/humans/group03/female_07.mdl"} 
ENT.StartHealth = 150 
ENT.HasItemDropsOnDeath = true 
ENT.ItemDropsOnDeathChance = 4
ENT.ItemDropsOnDeath_EntityList = {"item_ammo_ar2","item_ammo_pistol","item_ammo_357","item_ammo_smg1","item_box_buckshot","item_ammo_crossbow","item_rpg_round","item_ammo_357"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()	
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetUpGibesOnDeath(dmginfo,hitgroup)
if GetConVarNumber("vj_LNR_Gib") == 1 then

	if hitgroup == HITGROUP_HEAD && dmginfo:GetDamageForce():Length() > 800 then
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
        self:EmitSound(Sound("vj_lnrhl2/headshot.mp3",250))
		--self:EmitSound(Sound("vj_gib/gibbing2.wav",250))
		--self:EmitSound(Sound("vj_gib/gibbing3.wav",250))
        --self:EmitSound(Sound("vj_gib/gibbing1.wav",250))
        --self:EmitSound(Sound("vj_gib/bones_snapping3.wav",250))			
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_01.mdl",{Pos=self:GetAttachment(self:LookupAttachment("forward")).Pos+self:GetUp()*5})
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_02.mdl",{Pos=self:GetAttachment(self:LookupAttachment("forward")).Pos+self:GetUp()*5+self:GetRight()*2})
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_01.mdl",{Pos=self:GetAttachment(self:LookupAttachment("forward")).Pos+self:GetUp()*5+self:GetRight()*2})
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_02.mdl",{Pos=self:GetAttachment(self:LookupAttachment("forward")).Pos+self:GetUp()*5+self:GetRight()*5})
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_03.mdl",{Pos=self:GetAttachment(self:LookupAttachment("forward")).Pos+self:GetUp()*5+self:GetRight()*5})
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_02.mdl",{Pos=self:GetAttachment(self:LookupAttachment("forward")).Pos+self:GetUp()*5+self:GetRight()*5})
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_03.mdl",{Pos=self:GetAttachment(self:LookupAttachment("forward")).Pos+self:GetUp()*5+self:GetRight()*5})
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_02.mdl",{Pos=self:GetAttachment(self:LookupAttachment("forward")).Pos+self:GetUp()*5+self:GetRight()*5})
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_03.mdl",{Pos=self:GetAttachment(self:LookupAttachment("forward")).Pos+self:GetUp()*5+self:GetRight()*5})
		self:CreateGibEntity("obj_vj_gib","models/vj_lnrhl2/humans/group03/male_hat.mdl",{Pos=self:GetAttachment(self:LookupAttachment("forward")).Pos+self:GetUp()*5+self:GetRight()*5})
		return true,{DeathAnim=true,AllowCorpse=true}
end
	
	if hitgroup == HITGROUP_LEFTARM && dmginfo:GetDamageForce():Length() > 800 then
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
			self:EmitSound(Sound("vj_lnrhl2/armbreak.mp3",250))
		    self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_02.mdl",{Pos=self:GetAttachment(self:LookupAttachment("chest")).Pos+self:GetUp()*2+self:GetRight()*2})
		    self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_01.mdl",{Pos=self:GetAttachment(self:LookupAttachment("chest")).Pos+self:GetUp()*2+self:GetRight()*2})	
			self:CreateGibEntity("obj_vj_gib","models/gibs/humans/mgib_07.mdl",{Pos=self:GetAttachment(self:LookupAttachment("chest")).Pos+self:GetUp()*2+self:GetRight()*2})
			--self:CreateGibEntity("obj_vj_gib","models/gibs/humans/mgib_07.mdl",{Pos=self:GetAttachment(self:LookupAttachment("chest")).Pos+self:GetUp()*2+self:GetRight()*2})
			return true,{DeathAnim=true,AllowCorpse=true}
end
		
	if hitgroup == HITGROUP_RIGHTARM && dmginfo:GetDamageForce():Length() > 800 then
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
			self:EmitSound(Sound("vj_lnrhl2/armbreak.mp3",250))
		    self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_02.mdl",{Pos=self:GetAttachment(self:LookupAttachment("chest")).Pos+self:GetUp()*2+self:GetRight()*2})
		    self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_01.mdl",{Pos=self:GetAttachment(self:LookupAttachment("chest")).Pos+self:GetUp()*2+self:GetRight()*2})			
			self:CreateGibEntity("obj_vj_gib","models/gibs/humans/mgib_07.mdl",{Pos=self:GetAttachment(self:LookupAttachment("chest")).Pos+self:GetUp()*2+self:GetRight()*2})
			--self:CreateGibEntity("obj_vj_gib","models/gibs/humans/mgib_07.mdl",{Pos=self:GetAttachment(self:LookupAttachment("chest")).Pos+self:GetUp()*2+self:GetRight()*2})
			return true,{DeathAnim=true,AllowCorpse=true}
end
end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/