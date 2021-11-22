
AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Fishing Lure"
ENT.Author = "SweptThrone"
ENT.Spawnable = true
ENT.AdminSpawnable = true 
ENT.Category = "STFishing"
ENT.LureType = "gumball"

if SERVER then

    function ENT:Initialize()
        self:SetModel("models/props_lab/huladoll.mdl") 
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
        self:SetUseType( SIMPLE_USE )
        local phys = self:GetPhysicsObject()
        if phys and phys:IsValid() then
            phys:Wake()
        end
    end

    function ENT:OnRemove()
    end

    function ENT:Use( act, ply )
    end

    function ENT:Think()
        --if we're underwater and our owner isnt actually fishing
        if self:WaterLevel() > 1 and IsValid( self:GetOwner() ) and !self:GetOwner().SpecLure then
            self:GetOwner():SetNWEntity( "plyLure", self )
            self:GetOwner():StartFishing()
        end
    end

    function ENT:GravGunPickupAllowed()
        return false
    end

end

if CLIENT then
    
    function ENT:Initialize()
    end

    function ENT:Draw()
        self:DrawModel()
    end

    function ENT:Think()
    end 

end