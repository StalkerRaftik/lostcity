AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_lnrhl2/ElitePolice.mdl","models/vj_lnrhl2/police.mdl","models/vj_lnrhl2/combine_super_soldier.mdl","models/vj_lnrhl2/combine_soldier_prisonguard.mdl","models/vj_lnrhl2/combine_soldier.mdl"}  
ENT.MeleeAttackDamage = math.Rand(15,18)
ENT.MeleeAttackDamageType = DMG_SHOCK	
ENT.SoundTbl_MeleeAttack = {"weapons/stunstick/stunstick_fleshhit2.wav","weapons/stunstick/stunstick_fleshhit1.wav","weapons/stunstick/stunstick_fleshhit2.wav","weapons/stunstick/stunstick_fleshhit1.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"weapons/stunstick/stunstick_swing1.wav","weapons/stunstick/stunstick_swing2.wav"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
if self:GetModel() == "models/vj_lnrhl2/police.mdl" && self.LN_Armor == true then
self.LN_Armor = false
self:SetHealth(150)
self.SoundTbl_CombatIdle = {"vj_lnrhl2/cp/idle1.wav","vj_lnrhl2/cp/idle2.wav","vj_lnrhl2/cp/idle3.wav","vj_lnrhl2/cp/idle4.wav","vj_lnrhl2/cp/idle5.wav","vj_lnrhl2/cp/idle6.wav"}
self.SoundTbl_Idle = {"vj_lnrhl2/cp/idle1.wav","vj_lnrhl2/cp/idle2.wav","vj_lnrhl2/cp/idle3.wav","vj_lnrhl2/cp/idle4.wav","vj_lnrhl2/cp/idle5.wav","vj_lnrhl2/cp/idle6.wav"}
self.SoundTbl_Alert = {"vj_lnrhl2/cp/alert1.wav","vj_lnrhl2/cp/alert2.wav","vj_lnrhl2/cp/alert3.wav"}
self.SoundTbl_Pain = {"vj_lnrhl2/cp/pain1.wav","vj_lnrhl2/cp/pain2.wav","vj_lnrhl2/cp/pain3.wav","vj_lnrhl2/cp/pain4.wav"}
self.SoundTbl_Death = {"vj_lnrhl2/cp/die1.wav","vj_lnrhl2/cp/die2.wav","vj_lnrhl2/cp/die3.wav","vj_lnrhl2/cp/die4.wav"}
self.SoundTbl_BeforeMeleeAttack = {"vj_lnrhl2/cp/attack1.wav","vj_lnrhl2/cp/attack2.wav","vj_lnrhl2/cp/attack3.wav","vj_lnrhl2/cp/attack4.wav","vj_lnrhl2/cp/attack6.wav"}
self.SoundTbl_LeapAttackJump = {"vj_lnrhl2/cp/attack1.wav","vj_lnrhl2/cp/attack2.wav","vj_lnrhl2/cp/attack3.wav","vj_lnrhl2/cp/attack4.wav","vj_lnrhl2/cp/attack6.wav"}

elseif self:GetModel() == "models/vj_lnrhl2/elitepolice.mdl" then
self:SetHealth(175)
self.SoundTbl_CombatIdle = {"vj_lnrhl2/cp/idle1.wav","vj_lnrhl2/cp/idle2.wav","vj_lnrhl2/cp/idle3.wav","vj_lnrhl2/cp/idle4.wav","vj_lnrhl2/cp/idle5.wav","vj_lnrhl2/cp/idle6.wav"}
self.SoundTbl_Idle = {"vj_lnrhl2/cp/idle1.wav","vj_lnrhl2/cp/idle2.wav","vj_lnrhl2/cp/idle3.wav","vj_lnrhl2/cp/idle4.wav","vj_lnrhl2/cp/idle5.wav","vj_lnrhl2/cp/idle6.wav"}
self.SoundTbl_Alert = {"vj_lnrhl2/cp/alert1.wav","vj_lnrhl2/cp/alert2.wav","vj_lnrhl2/cp/alert3.wav"}
self.SoundTbl_Pain = {"vj_lnrhl2/cp/pain1.wav","vj_lnrhl2/cp/pain2.wav","vj_lnrhl2/cp/pain3.wav","vj_lnrhl2/cp/pain4.wav"}
self.SoundTbl_Death = {"vj_lnrhl2/cp/die1.wav","vj_lnrhl2/cp/die2.wav","vj_lnrhl2/cp/die3.wav","vj_lnrhl2/cp/die4.wav"}
self.SoundTbl_BeforeMeleeAttack = {"vj_lnrhl2/cp/attack1.wav","vj_lnrhl2/cp/attack2.wav","vj_lnrhl2/cp/attack3.wav","vj_lnrhl2/cp/attack4.wav","vj_lnrhl2/cp/attack6.wav"}
self.SoundTbl_LeapAttackJump = {"vj_lnrhl2/cp/attack1.wav","vj_lnrhl2/cp/attack2.wav","vj_lnrhl2/cp/attack3.wav","vj_lnrhl2/cp/attack4.wav","vj_lnrhl2/cp/attack6.wav"}
end

self:SetSkin( math.random(0,1) )
	local ZombieWeapon = math.random(1,1)
	if ZombieWeapon == 1 then
			self.ExtraGunModel1 = ents.Create("prop_physics")
			self.ExtraGunModel1:SetModel("models/weapons/w_stunbaton.mdl")
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
		if ZombieWeapon == 2 then
			self.ExtraGunModel1 = ents.Create("prop_physics")
			self.ExtraGunModel1:SetModel("models/weapons/w_irifle.mdl")
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
		if ZombieWeapon == 3 then
			self.ExtraGunModel1 = ents.Create("prop_physics")
			self.ExtraGunModel1:SetModel("models/weapons/w_smg1.mdl")
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
		if ZombieWeapon == 4 then
			self.ExtraGunModel1 = ents.Create("prop_physics")
			self.ExtraGunModel1:SetModel("models/weapons/w_shotgun.mdl")
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
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnIsJumpLegal(startPos,apex,endPos) return false 
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/