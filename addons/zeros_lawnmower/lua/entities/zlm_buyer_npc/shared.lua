ENT.Base = "base_ai"
ENT.Type = "ai"
ENT.PrintName = "Grass Buyer"
ENT.Author = "ClemensProduction aka Zerochain"
ENT.Information = "info"
ENT.Category = "Zeros LawnMowerman"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.AutomaticFrameAdvance = true

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "PriceModifier")
	if (SERVER) then
		self:SetPriceModifier(100)
	end
end
