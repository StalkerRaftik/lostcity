ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Clothes"
ENT.Category = "Clothes Mod"
ENT.Author = "Venatuss"
ENT.Spawnable = true

function ENT:SetupDataTables()
    self:NetworkVar("String", 0, "CName")
	if SERVER then
		self:SetCName("Loading...")
	end
end
