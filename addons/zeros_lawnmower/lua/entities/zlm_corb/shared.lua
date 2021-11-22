ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.Model = "models/zerochain/props_lawnmower/zlm_corb.mdl"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.PrintName = "Corb"
ENT.Category = "Zeros LawnMowerman"
ENT.RenderGroup = RENDERGROUP_OPAQUE

function ENT:SetupDataTables()
    self:NetworkVar("Int", 0, "GrassStorage")

    if (SERVER) then
        self:SetGrassStorage(0)
    end
end
