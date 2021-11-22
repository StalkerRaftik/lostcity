AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_lnrhl2/humans/group03in/male_01.mdl","models/vj_lnrhl2/humans/group03in/male_02.mdl","models/vj_lnrhl2/humans/group03in/male_03.mdl","models/vj_lnrhl2/humans/group03in/male_04.mdl","models/vj_lnrhl2/humans/group03in/male_05.mdl","models/vj_lnrhl2/humans/group03in/male_06.mdl","models/vj_lnrhl2/humans/group03in/male_07.mdl","models/vj_lnrhl2/humans/group03in/male_08.mdl","models/vj_lnrhl2/humans/group03in/male_09.mdl","models/vj_lnrhl2/humans/group03min/male_01.mdl","models/vj_lnrhl2/humans/group03min/male_02.mdl","models/vj_lnrhl2/humans/group03min/male_03.mdl","models/vj_lnrhl2/humans/group03min/male_04.mdl","models/vj_lnrhl2/humans/group03min/male_05.mdl","models/vj_lnrhl2/humans/group03min/male_06.mdl","models/vj_lnrhl2/humans/group03min/male_07.mdl","models/vj_lnrhl2/humans/group03min/male_08.mdl","models/vj_lnrhl2/humans/group03min/male_09.mdl","models/vj_lnrhl2/humans/group02/male_01.mdl","models/vj_lnrhl2/humans/group02/male_02.mdl","models/vj_lnrhl2/humans/group02/male_03.mdl","models/vj_lnrhl2/humans/group02/male_04.mdl","models/vj_lnrhl2/humans/group02/male_05.mdl","models/vj_lnrhl2/humans/group02/male_06.mdl","models/vj_lnrhl2/humans/group02/male_07.mdl","models/vj_lnrhl2/humans/group02/male_08.mdl","models/vj_lnrhl2/humans/group02/male_09.mdl","models/vj_lnrhl2/infectedhl2/barney.mdl","models/vj_lnrhl2/infectedhl2/breen.mdl","models/vj_lnrhl2/infectedhl2/barney.mdl","models/vj_lnrhl2/infectedhl2/eli.mdl","models/vj_lnrhl2/infectedhl2/fisherman.mdl","models/vj_lnrhl2/infectedhl2/gman.mdl","models/vj_lnrhl2/infectedhl2/kleiner.mdl","models/vj_lnrhl2/infectedhl2/magnusson.mdl","models/vj_lnrhl2/infectedhl2/monk.mdl","models/vj_lnrhl2/infectedhl2/odessa.mdl"}  
ENT.MeleeAttackDamage = math.Rand(15,18)
ENT.SoundTbl_MeleeAttack = {"vj_lnrhl2/npc/melee/melee_axe_03.wav","vj_lnrhl2/npc/melee/melee_axe_02.wav","vj_lnrhl2/npc/melee/melee_axe_01.wav","vj_lnrhl2/npc/melee/axe_impact_flesh3.wav","vj_lnrhl2/npc/melee/axe_impact_flesh2.wav","vj_lnrhl2/npc/melee/axe_impact_flesh1.wav"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
if GetConVarNumber("vj_LNR_CitizenSkins") == 1 then
self:SetSkin( math.random(0,3))

elseif GetConVarNumber("vj_LNR_CitizenSkins") == 0 then
self:SetSkin( math.random(0,47))
end
	local ZombieWeapon = math.random(1,4)
	if ZombieWeapon == 1 then
			self.ExtraGunModel1 = ents.Create("prop_physics")
			self.ExtraGunModel1:SetModel("models/weapons/hl2meleepack/w_axe.mdl")
			self.ExtraGunModel1:SetLocalPos(self:GetPos())
			//self.ExtraGunModel1:SetPos(self:GetPos())
			self.ExtraGunModel1:SetOwner(self)
			self.ExtraGunModel1:SetParent(self)
			self.ExtraGunModel1:SetLocalAngles(Angle(-120,45,90))
			self.ExtraGunModel1:Fire("SetParentAttachmentMaintainOffset","anim_attachment_LH")
			self.ExtraGunModel1:Fire("SetParentAttachment","anim_attachment_RH")
			self.ExtraGunModel1:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
			self.ExtraGunModel1:Spawn()
			self.ExtraGunModel1:Activate()
			self.ExtraGunModel1:SetSolid(SOLID_NONE)
			self.ExtraGunModel1:AddEffects(EF_BONEMERGE)
	
		elseif ZombieWeapon == 2 then
			self.ExtraGunModel1 = ents.Create("prop_physics")
			self.ExtraGunModel1:SetModel("models/weapons/w_crowbar.mdl")
			self.ExtraGunModel1:SetLocalPos(self:GetPos())
			//self.ExtraGunModel1:SetPos(self:GetPos())
			self.ExtraGunModel1:SetOwner(self)
			self.ExtraGunModel1:SetParent(self)
			self.ExtraGunModel1:SetLocalAngles(Angle(-120,45,90))
			self.ExtraGunModel1:Fire("SetParentAttachmentMaintainOffset","anim_attachment_LH")
			self.ExtraGunModel1:Fire("SetParentAttachment","anim_attachment_RH")
			self.ExtraGunModel1:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
			self.ExtraGunModel1:Spawn()
			self.ExtraGunModel1:Activate()
			self.ExtraGunModel1:SetSolid(SOLID_NONE)
			self.ExtraGunModel1:AddEffects(EF_BONEMERGE)

		elseif ZombieWeapon == 3 then
			self.ExtraGunModel1 = ents.Create("prop_physics")
			self.ExtraGunModel1:SetModel("models/props_canal/mattpipe.mdl")
			self.ExtraGunModel1:SetLocalPos(self:GetPos())
			//self.ExtraGunModel1:SetPos(self:GetPos())
			self.ExtraGunModel1:SetOwner(self)
			self.ExtraGunModel1:SetParent(self)
			self.ExtraGunModel1:SetLocalAngles(Angle(-120,45,90))
			self.ExtraGunModel1:Fire("SetParentAttachmentMaintainOffset","anim_attachment_LH")
			self.ExtraGunModel1:Fire("SetParentAttachment","anim_attachment_RH")
			self.ExtraGunModel1:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
			self.ExtraGunModel1:Spawn()
			self.ExtraGunModel1:Activate()
			self.ExtraGunModel1:SetSolid(SOLID_NONE)
			self.ExtraGunModel1:AddEffects(EF_BONEMERGE)
	
		elseif ZombieWeapon == 4 then
			self.ExtraGunModel1 = ents.Create("prop_physics")
			self.ExtraGunModel1:SetModel("models/weapons/w_knife_ct.mdl")
			self.ExtraGunModel1:SetLocalPos(self:GetPos())
			//self.ExtraGunModel1:SetPos(self:GetPos())
			self.ExtraGunModel1:SetOwner(self)
			self.ExtraGunModel1:SetParent(self)
			self.ExtraGunModel1:SetLocalAngles(Angle(-120,45,90))
			self.ExtraGunModel1:Fire("SetParentAttachmentMaintainOffset","anim_attachment_LH")
			self.ExtraGunModel1:Fire("SetParentAttachment","anim_attachment_RH")
			self.ExtraGunModel1:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
			self.ExtraGunModel1:Spawn()
			self.ExtraGunModel1:Activate()
			self.ExtraGunModel1:SetSolid(SOLID_NONE)
			self.ExtraGunModel1:AddEffects(EF_BONEMERGE)	

end				
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/