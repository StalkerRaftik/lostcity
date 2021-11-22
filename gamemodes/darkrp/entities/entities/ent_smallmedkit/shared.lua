
ENT.Base 			= "base_gmodentity"
ENT.Type 			= "anim"
ENT.PrintName 		= "Феназалгин"
ENT.Author 			= "DrVrej; BlackSnow"
ENT.Contact 		= ""
ENT.Purpose 		= "Hmmm. A small medkit, gives you 50 hp"
ENT.Instructions 	= ""
ENT.Category		= "Lost Health System"

ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.AutomaticFrameAdvance = true
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetAutomaticFrameAdvance( bUsingAnim )
	self.AutomaticFrameAdvance = bUsingAnim
end