include("shared.lua")

function ENT:Initialize()
    self.LastRolls = 0
end

function ENT:Draw()
    self:DrawModel()
end

function ENT:Think()
    self:SetNextClientThink(CurTime())

    -- ClientModel
    if zlm.f.InDistance(LocalPlayer():GetPos(), self:GetPos(), 2000) then

        if self.ClientProps then

            if self.LastRolls ~= self:GetGrassRolls() then

                self.LastRolls = self:GetGrassRolls()

                -- If the new roll count is greater then 0 then this means a roll got loaded and we create the effect then.
                if self.LastRolls > 0 then
                    self:EmitSound("zlm_grassroll_hit")
                    local attach = self:GetAttachment(self.LastRolls + 4)
                    ParticleEffect("zlm_grassroll_load", attach.Pos, Angle(0, 0, 0), NULL)
                end

                self:RemoveClientModels()

                for i = 1, self.LastRolls do
                    self:SpawnClientModel_GrassRolls(i)
                end
            end
        else
            self.ClientProps = {}
        end
    else
        self:RemoveClientModels()
        self.LastRolls = -1
    end

    return true
end

function ENT:SpawnClientModel_GrassRolls(pos)
    local attach = self:GetAttachment(pos + 4)
    if attach == nil then return end
    local rPos = attach.Pos
    local ent = ents.CreateClientProp("models/zerochain/props_lawnmower/zlm_grassroll.mdl")
    ent:SetPos(rPos)
    ent:SetAngles(self:GetAngles())
    ent:Spawn()
    ent:Activate()
    ent:SetParent(self)
    self.ClientProps["GrassRoll" .. pos] = ent
end

function ENT:RemoveClientModels()
    if (self.ClientProps and table.Count(self.ClientProps) > 0) then
        for k, v in pairs(self.ClientProps) do
            if IsValid(v) then
                v:Remove()
            end
        end
    end

    self.ClientProps = {}
end

function ENT:OnRemove()
    self:RemoveClientModels()
end
