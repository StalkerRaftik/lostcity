ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.DisableDuplicator = false
ENT.PrintName = "Trailer"
ENT.Author = "ZeroChain"
ENT.Category = "Zeros LawnMowerman"
ENT.Spawnable = true
ENT.AdminSpawnable = true

function ENT:SetupDataTables()
    self:NetworkVar("Int", 0, "GrassRolls")
    if (SERVER) then
        self:SetGrassRolls(0)
    end
end
