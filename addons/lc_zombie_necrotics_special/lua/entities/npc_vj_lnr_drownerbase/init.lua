AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_lnrspecials/drownerbase/gman.mdl"} 
ENT.HasDeathRagdoll = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
self.AnimTbl_IdleStand = {"Infectiondeathidle"}
self.GodMode = true
self.VJ_NoTarget = true
self.DisableMakingSelfEnemyToNPCs = true
self.DisableChasingEnemy = true
self.DisableFindEnemy = true
self.DisableWandering = true
self.MovementType = VJ_MOVETYPE_STATIONARY
self.CanTurnWhileStationary = false
self.HasSounds = false
self.GodMode = true
self.CanFlinch = 0

timer.Simple(GetConVarNumber("VJ_LNR_InfectionTime"),function()
if IsValid(self) then
self:VJ_ACT_PLAYACTIVITY("Infectionrise",true,4,false)
self.GodMode = false
self.VJ_NoTarget = false
self.DisableMakingSelfEnemyToNPCs = false
self.DisableChasingEnemy = false
self.DisableFindEnemy = false
self.DisableWandering = false
self.HasSounds = true
self.GodMode = false

	if GetConVarNumber("vj_npc_noidleparticle") == 0 then
		local eyeglow1 = ents.Create("env_sprite")
		eyeglow1:SetKeyValue("model","vj_base/sprites/vj_glow1.vmt")
		eyeglow1:SetKeyValue("scale","0.02")
		eyeglow1:SetKeyValue("rendermode","5")
		eyeglow1:SetKeyValue("rendercolor","0 255 255 255")
		eyeglow1:SetKeyValue("spawnflags","1") -- If animated
		eyeglow1:SetParent(self)
		eyeglow1:Fire("SetParentAttachment","eye1",0)
		eyeglow1:Spawn()
		eyeglow1:Activate()
		self:DeleteOnRemove(eyeglow1)
		
		local eyeglow2 = ents.Create("env_sprite")
		eyeglow2:SetKeyValue("model","vj_base/sprites/vj_glow1.vmt")
		eyeglow2:SetKeyValue("scale","0.02")
		eyeglow2:SetKeyValue("rendermode","5")
		eyeglow2:SetKeyValue("rendercolor","0 255 255 255")
		eyeglow2:SetKeyValue("spawnflags","1") -- If animated
		eyeglow2:SetParent(self)
		eyeglow2:Fire("SetParentAttachment","eye2",0)
		eyeglow2:Spawn()
		eyeglow2:Activate()
		self:DeleteOnRemove(eyeglow2)
end

timer.Simple(4,function()
if IsValid(self) then
self.AnimTbl_IdleStand = {ACT_IDLE}
self.MovementType = VJ_MOVETYPE_AQUATIC
self.CanFlinch = 1
end
end)
end
end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPriorToKilled(dmginfo,hitgroup)		
		    self:EmitSound(Sound("vj_gib/gibbing2.wav",250))
		    self:EmitSound(Sound("vj_gib/gibbing3.wav",250))
            self:EmitSound(Sound("vj_gib/gibbing1.wav",250))	
		    self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_01.mdl")
		    self:CreateGibEntity("obj_vj_gib","models/gibs/humans/mgib_04.mdl")
		    self:CreateGibEntity("obj_vj_gib","models/gibs/humans/mgib_06.mdl")
		    self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_02.mdl")
		    self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_03.mdl")
		    self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_02.mdl")
		    self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_03.mdl")
		    self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_02.mdl")
		    self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_03.mdl")
			self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_01.mdl")
		    self:CreateGibEntity("obj_vj_gib","models/gibs/humans/mgib_03.mdl")
		    self:CreateGibEntity("obj_vj_gib","models/gibs/humans/mgib_04.mdl")
		    self:CreateGibEntity("obj_vj_gib","models/gibs/humans/mgib_06.mdl")

			local bloodeffect = EffectData()
			bloodeffect:SetOrigin(self:GetPos()+ self:GetUp()*50)
			bloodeffect:SetColor(VJ_Color2Byte(Color(127,0,0,255)))
			bloodeffect:SetScale(60)
			util.Effect("VJ_Blood1",bloodeffect)
			
			local bloodspray = EffectData()
			bloodspray:SetOrigin(self:GetPos() +self:OBBCenter())
			bloodspray:SetColor(VJ_Color2Byte(Color(127,0,0,255)))
			bloodspray:SetScale(1)
			bloodspray:SetFlags(3)
			bloodspray:SetColor(1)
			util.Effect("bloodspray",bloodspray)
			util.Effect("bloodspray",bloodspray)				
end 
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/