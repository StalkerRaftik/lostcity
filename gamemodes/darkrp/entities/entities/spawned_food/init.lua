AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE_DEBRIS)
	self:SetModel(self:GetFoodModel() or 'models/props/cs_italy/bananna.mdl')
	self:PhysWake()
	self:SetFoodName(self:GetFoodName() or 'Еда')
end

function ENT:OnTakeDamage(dmg)
	self:Remove()
end

function ENT:Use(activator,caller)
	self:Remove()

	activator:AddHunger(self:GetFoodAmount())
    activator:AddThirst(self:GetThirstAmount())

    activator:Freeze( true )
    timer.Simple( 2, function() activator:Freeze( false ) end )

    if self:GetThirstAmount() > self:GetFoodAmount() then
        activator:EmitSound("eating_and_drinking/soda.wav")
    else
		activator:EmitSound("eating_and_drinking/eating.wav")
	end
end