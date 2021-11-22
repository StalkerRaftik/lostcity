ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Stove"
ENT.Author = ""
ENT.Category = "Coocking Sys"
ENT.Spawnable = true
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT
function ENT:SetupDataTables()
  self:NetworkVar("String", 0, "Ingredients")
  self:NetworkVar("Int", 0, "CookStart")
  self:NetworkVar("String", 0, "Recipe")
end