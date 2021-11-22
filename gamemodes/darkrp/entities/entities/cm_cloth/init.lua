AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()

	self:SetModel("models/props_equipment/sleeping_bag3.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()
	local phys = self:GetPhysicsObject()
	
	if phys:IsValid() then
	
		phys:Wake()
		
	end
	
end

function ENT:Use(a,c)
	
	-- if Cosmetics.Config.ForbiddenJobs[c:Team()] or Cosmetics.Config.ForbiddenJobsWithHeads[c:Team()] then
	-- 	c:CM_Notif(Cosmetics.Config.Sentences[36][Cosmetics.Config.Lang])
	-- return end
	
	-- if not self.Type or (self.Type != 1.1 and self.Type != 1.2 and self.Type != 2) then
	-- 	self:Remove()
	-- 	return
	-- end
	
	-- local plyInfos = c:CM_GetInfos()
	
	-- if self.Sex != plyInfos.sex then
	-- 	c:CM_Notif(Cosmetics.Config.Sentences[50][Cosmetics.Config.Lang])
	-- 	return
	-- end
	
	-- if self.Type == 1.1 then
	
	-- 	c:CM_DropCloth( 1 )
		
	-- 	local infos =  CM_GetTextureInfos( self.id )
				
	-- 	c:CM_AddTop( infos, true )
		
		
		
	-- 	plyInfos.teetexture.basetexture = "!CM_"..self.id
	-- 	plyInfos.teetexture.id = tonumber(self.id)
	-- 	plyInfos.teetexture.hasCustomThings = true
		
	-- 	local data
	-- 	if infos.sex == 1 then
	-- 		data = Cosmetics.Male
	-- 	else
	-- 		data = Cosmetics.Female
	-- 	end
		
		
	-- 	local bodygroup = data.EditableTop["models/humans/enhancedshortsleeved/citizen_sheet3"].bodygroup
	-- 	plyInfos.bodygroups.top = bodygroup
		
	-- 	c:CM_SavePlayerInfos()
	-- 	c:CM_NetworkTableInfos()
	-- 	self:Remove()
	-- elseif self.Type == 1.2 then
	
	-- 	c:CM_DropCloth( 1 )
		
	-- 	local data
	-- 	if plyInfos.sex == 1 then
	-- 		data = Cosmetics.Male
	-- 	else
	-- 		data = Cosmetics.Female
	-- 	end
		
	-- 	local infos = data.ListTops[self:GetCName()]
	-- 	c:CM_AddTop( infos, false )
		
	-- 	plyInfos.teetexture.basetexture = self.Texture
	-- 	plyInfos.teetexture.id = nil
	-- 	plyInfos.teetexture.hasCustomThings = false
	-- 	plyInfos.bodygroups.top = infos.bodygroup
		
	-- 	c:CM_SavePlayerInfos()
	-- 	c:CM_NetworkTableInfos()
	-- 	self:Remove()
		
	-- elseif self.Type == 2 then
		
	-- 	c:CM_DropCloth( 2 )
		
	-- 	local data
	-- 	if plyInfos.sex == 1 then
	-- 		data = Cosmetics.Male
	-- 	else
	-- 		data = Cosmetics.Female
	-- 	end
		
	-- 	local infos = data.ListBottoms[self:GetCName()]
	-- 	c:CM_AddBottom( infos )
		
	-- 	plyInfos.panttexture.basetexture = self.Texture
	-- 	plyInfos.bodygroups.pant = infos.bodygroup
		
	-- 	c:CM_SavePlayerInfos()
	-- 	c:CM_NetworkTableInfos()
	-- 	self:Remove()
		
	-- end
	
end