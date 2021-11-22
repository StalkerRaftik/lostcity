AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
  self:SetModel("models/Humans/Group02/Male_04.mdl")
  self:SetHullType(HULL_HUMAN)
  self:SetHullSizeNormal()
  self:SetNPCState(NPC_STATE_SCRIPT)
  self:SetSolid(SOLID_BBOX) 
  self:SetUseType(SIMPLE_USE) 
  self:DropToFloor()
  self:CapabilitiesAdd(CAP_ANIMATEDFACE)
  
  self.nextClick = CurTime() + 1
end

function ENT:AcceptInput( event, a, p )

	if( event == "Use" && p:IsPlayer() && self.nextClick < CurTime() )  then
	
		self.nextClick = CurTime() + 2
		
		if Cosmetics.Config.ForbiddenJobs[p:Team()] or Cosmetics.Config.ForbiddenJobsWithHeads[p:Team()] then
			p:CM_Notif(Cosmetics.Config.Sentences[36][Cosmetics.Config.Lang])
		return end
		
		net.Start("Cosmetics:ClothesShop")
			net.WriteEntity( self )
		net.Send( p )
		
	end
	
end