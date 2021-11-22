ENT.Type = "anim"
ENT.Base = "base_rp"
ENT.PrintName = "Spawned Food"
ENT.Author = "Kirussell"
ENT.Spawnable = false
ENT.AdminSpawnable = false

function ENT:SetupDataTables()
	self:NetworkVar('String', 0, 'FoodName')
	self:NetworkVar('String', 2, 'FoodModel')
	self:NetworkVar('Float', 0, 'FoodAmount')
  self:NetworkVar('Float', 2, 'ThirstAmount')
end