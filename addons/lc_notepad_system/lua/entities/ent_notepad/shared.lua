
ENT.Type = "anim"

ENT.PrintName = "Блокнот"
ENT.Category = "Предметы"
ENT.Spawnable = true
ENT.AdminOnly = false

ENT.Model = "models/props_lab/clipboard.mdl"
ENT.StartPages = 2
ENT.LimitPages = 16

function ENT:SetupDataTables()
 self:NetworkVar("Entity",0,"Writer")
 self:NetworkVar("Int",0,"Status")
 self:NetworkVar("Int",1,"Pages")  
end
