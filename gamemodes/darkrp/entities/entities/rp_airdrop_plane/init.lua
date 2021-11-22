AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

function ENT:Initialize()
    self:SetModel(Model("models/Combine_Helicopter.mdl"))
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_NONE)
    constraint.NoCollide(self, game.GetWorld(), 0, 0)

    local physobj = self:GetPhysicsObject()
    if IsValid(physobj) then
        physobj:EnableGravity(false)
        physobj:EnableDrag(false)
        physobj:Wake()
    end

    self.removeTime = CurTime() + 120
end

function ENT:SetCourse(from, to)
    local dir = (to-from):GetNormalized()
    self:SetPos(from)
    self:SetAngles(dir:Angle())
    local physobj = self:GetPhysicsObject()
    if IsValid(physobj) then
        physobj:SetVelocity(dir * 1400)
    end

    self.course = {
        ["from"] = from,
        ["to"] = to,
        ["direction"] = dir,
        ["distance"] = from:Distance(to),
    }

    self.drops = {
        math.Rand(0.2, 0.8),
    }
end

function ENT:Drop()
    rp.airdrop.SpawnPackage(self)
end

function ENT:Think()

    if self.course then
        local from = self.course.from
        local dist = self.course.distance
        local curDist = self:GetPos():Distance(from)
        local scale = curDist/dist
        for i, drop in pairs(self.drops) do
            if scale > drop then
                self.drops[i] = nil
                self:Drop()
            end
        end
        if curDist > dist then
            self:Remove()
            return
        end
    end

    if CurTime() > self.removeTime then
        self:Remove()
        return
    end

    self:NextThink(CurTime() + 0.2)
    return true
end