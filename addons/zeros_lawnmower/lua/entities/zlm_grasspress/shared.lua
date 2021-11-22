ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.AutomaticFrameAdvance = true
ENT.Model = "models/zerochain/props_lawnmower/zlm_grasspress.mdl"
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.PrintName = "GrassPress"
ENT.Category = "Zeros LawnMowerman"
ENT.RenderGroup = RENDERGROUP_OPAQUE

function ENT:SetupDataTables()
    self:NetworkVar("Bool", 0, "IsRunning")
    self:NetworkVar("Int", 0, "GrassCount")
    self:NetworkVar("Int", 1, "ProgressState")

    self:NetworkVar("Int", 2, "UpgradeLevel")
    self:NetworkVar("Float", 0, "UCooldDown")

    self:NetworkVar("Float", 1, "Production_TimeStamp")

    if (SERVER) then
        self:SetGrassCount(0)
        self:SetProgressState(0)
        self:SetIsRunning(false)
        self:SetUpgradeLevel(0)
        self:SetUCooldDown(0)
        self:SetProduction_TimeStamp(-1)
    end
end

function ENT:EnableButton(ply)
    local trace = ply:GetEyeTrace()

    local lp = self:WorldToLocal(trace.HitPos)

    if lp.z > 52.2 and lp.z < 57.4 and lp.x < 14.5 and lp.x > 9.5 then
        return true
    else
        return false
    end
end

function ENT:UpgradButton(ply)
    local trace = ply:GetEyeTrace()

    local lp = self:WorldToLocal(trace.HitPos)

    if lp.z > 46.7 and lp.z < 51.6 and lp.x < 9 and lp.x > -14.4 then
        return true
    else
        return false
    end
end
