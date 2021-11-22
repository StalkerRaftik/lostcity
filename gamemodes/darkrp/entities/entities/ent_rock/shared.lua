
ENT.Base 			= "base_gmodentity"
ENT.Type 			= "anim"
ENT.PrintName 		= "Камень для долбления блять"
ENT.Author 			= "DrVrej; BlackSnow"
ENT.Contact 		= ""
ENT.Purpose 		= "Hmmm. A small medkit, gives you 50 hp"
ENT.Instructions 	= ""

ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.AutomaticFrameAdvance = true
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetAutomaticFrameAdvance( bUsingAnim )
	self.AutomaticFrameAdvance = bUsingAnim
end