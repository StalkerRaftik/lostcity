AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel(zlm.config.NPC.Model)
	self:SetSolid(SOLID_BBOX)
	self:SetHullSizeNormal()
	self:SetNPCState(NPC_STATE_SCRIPT)
	self:SetHullType(HULL_HUMAN)
	self:SetUseType(SIMPLE_USE)

	self:SetMaxYawSpeed(90)

	if zlm.config.NPC.Capabilities then
		self:CapabilitiesAdd(CAP_ANIMATEDFACE)
		self:CapabilitiesAdd(CAP_TURN_HEAD)
	end

	zlm.f.NPC_Initialize(self)
end

function ENT:AcceptInput(key, ply)
	if ((self.lastUsed or CurTime()) <= CurTime()) and (key == "Use" and IsValid(ply) and ply:IsPlayer() and ply:Alive()) and zlm.f.InDistance(ply:GetPos(), self:GetPos(), 100) then
		self.lastUsed = CurTime() + 0.25
		zlm.f.NPC_USE(self, ply)
	end
end

function ENT:RefreshBuyRate()
	self:SetPriceModifier(math.random(zlm.config.NPC.MinBuyRate, zlm.config.NPC.MaxBuyRate))
end
