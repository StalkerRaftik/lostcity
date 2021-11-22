ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Storage"
ENT.Author = ""
ENT.Spawnable = true
ENT.AdminSpawnable = true

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "StorageName")
end
