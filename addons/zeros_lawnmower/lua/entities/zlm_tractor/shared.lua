ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.AutomaticFrameAdvance = true
ENT.DisableDuplicator = false
ENT.PrintName = "LawnMower"
ENT.Author = "ZeroChain"
ENT.Category = "Zeros LawnMowerman"
ENT.Spawnable = true
ENT.AdminSpawnable = true

function ENT:SetupDataTables()
    self:NetworkVar("Bool", 0, "IsRunning")
    self:NetworkVar("Bool", 1, "IsMowing")
    self:NetworkVar("Bool", 2, "IsUnloading")
    self:NetworkVar("Bool", 3, "HasCorb")
    self:NetworkVar("Bool", 4, "HasTrailer")
    self:NetworkVar("Int", 0, "GrassStorage")
    self:NetworkVar("Entity", 0, "VehicleEnt")

    if (SERVER) then
        self:SetIsRunning(false)
        self:SetIsMowing(false)
        self:SetGrassStorage(0)
        self:SetIsUnloading(false)
        self:SetHasCorb(true)
        self:SetHasTrailer(false)
    end
end
