
ENT.Base 			= "base_gmodentity"
ENT.Type 			= "anim"
ENT.PrintName 		= "Аптечка первой медицинской помощи"
ENT.Author 			= "DrVrej; BlackSnow"
ENT.Contact 		= ""
ENT.Purpose 		= "Some blood, it's like wine but only for jesus i guess."
ENT.Instructions 	= ""
ENT.Category		= "Lost Health System"

ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.AutomaticFrameAdvance = true
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetAutomaticFrameAdvance( bUsingAnim )
	self.AutomaticFrameAdvance = bUsingAnim
end