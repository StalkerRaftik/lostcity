AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_lnrspecials/butcher_chainsaw.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.HasExtraMeleeAttackSounds = true
ENT.MeleeAttackDamage = 200
ENT.AlertSoundPitch1 = 70
ENT.AlertSoundPitch2 = 70
ENT.ExtraMeleeSoundPitch1 = 70
ENT.ExtraMeleeSoundPitch2 = 70
ENT.PainSoundPitch1 = 70
ENT.PainSoundPitch2 = 70
ENT.GeneralSoundPitch1 = 70
ENT.GeneralSoundPitch2 = 70
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_Breath = {"butcher/chainsaw_loop.wav"}
ENT.SoundTbl_Alert = {"butcher/slower_alert30.wav","butcher/slower_alert20.wav","butcher/slower_alert10.wav"}
ENT.SoundTbl_MeleeAttack = {"butcher/chainsaw_attack_hit.wav","butcher/chainsaw_attack_hit.wav"}
ENT.SoundTbl_BeforeMeleeAttack = {"butcher/chainsaw_attack_miss.wav","butcher/chainsaw_attack_miss.wav"}
ENT.SoundTbl_MeleeAttackExtra = {"butcher/slower_attack1.wav","butcher/slower_attack2.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"butcher/chainsaw_attack_miss.wav","butcher/chainsaw_attack_miss.wav"}
ENT.SoundTbl_Pain = {"zombie/crimsonhead/crimhead_pain.wav","butcher/slower_pain1.wav","butcher/slower_pain1.wav"}
-------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize() 		
			self:SetSkin(math.random(0,3))			
			self.ExtraGunModel1 = ents.Create("prop_physics")
			self.ExtraGunModel1:SetModel("models/weapons/w_leatherface.mdl")
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
			self.ExtraGunModel1:AddEffects(EF_BONEMERGE)

		local Chainsaw = self:LookupBone("ValveBiped.Bip01_L_Forearm")
        self:ManipulateBoneAngles(Chainsaw, Angle(0,0,0) )	

		local Chainsaw2 = self:LookupBone("ValveBiped.Bip01_R_Forearm")
        self:ManipulateBoneAngles(Chainsaw2, Angle(0,-30,0) )	
		
		local Chainsaw3 = self:LookupBone("ValveBiped.Bip01_L_UpperArm")
        self:ManipulateBoneAngles(Chainsaw3, Angle(0,0,0) )		
end		
-------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo,hitgroup,GetCorpse)

end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/