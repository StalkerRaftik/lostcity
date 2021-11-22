ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Шляпа"
ENT.Author = ""
ENT.Contact = ""
ENT.Purpose = ""
ENT.Instructions = "" 
ENT.Category = "RP"

ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

ENT.Spawnable			= true
ENT.AdminSpawnable		= true

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "CosmeticType")
end