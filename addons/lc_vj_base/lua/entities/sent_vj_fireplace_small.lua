/*--------------------------------------------------
	*** Copyright (c) 2012-2020 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
AddCSLuaFile()
if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end

ENT.Base 			= "base_gmodentity"
ENT.Type 			= "anim"
ENT.PrintName 		= "FirePlace(small)"
ENT.Author 			= "DrVrej"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Purpose 		= "Gives a warm feeling, especially in snowy maps."
ENT.Instructions 	= "Don't change anything."
ENT.Category		= "VJ Base"

ENT.Spawnable = true
ENT.AdminOnly = false
---------------------------------------------------------------------------------------------------------------------------------------------
if (CLIENT) then
	ENT.NextActivationCheckT = 0
	ENT.NextFireLightT = 0
	ENT.DoneFireParticles = false
	
	function ENT:Draw()
		self:DrawModel()
	end
	
	function ENT:Think()

		if CurTime() > self.NextActivationCheckT then
			if self:GetNWBool("VJ_FirePlace_Activated") == true then
				if self.DoneFireParticles == false then
					self.DoneFireParticles = true
					ParticleEffectAttach("env_fire_tiny_smoke",PATTACH_ABSORIGIN_FOLLOW,self,0)
					ParticleEffectAttach("env_embers_large",PATTACH_ABSORIGIN_FOLLOW,self,0)
				end
				if CurTime() > self.NextFireLightT then
					local FireLight1 = DynamicLight(self:EntIndex())
					if (FireLight1) then
						local fuel = isnumber(self:GetNVar("Fuel")) and self:GetNVar("Fuel") or CurTime()+50

						FireLight1.Pos = self:GetPos() +self:GetUp() * 15
						FireLight1.R = 255
						FireLight1.G = 100
						FireLight1.B = 0
						FireLight1.Brightness = 8*math.Clamp((fuel-CurTime())/600, 0, 1.1)
						FireLight1.Size = 1024
						FireLight1.Decay = 400
						FireLight1.DieTime = CurTime() + 1
					end
					self.NextFireLightT = CurTime() + 0.2
				end
			else
				self.DoneFireParticles = false
			end
			self.NextActivationCheckT = CurTime() + 0.1
		end
	end
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if not SERVER then return end

ENT.FirePlaceOn = false

---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Initialize()
	self:SetNWBool("VJ_FirePlace_Activated", false)
	self:SetModel("models/hunter/blocks/cube025x025x025.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)


	self:SetNWBool("VJ_FirePlace_Activated", true)
	self.FirePlaceOn = true
	self:EmitSound(Sound("ambient/fire/mtov_flame2.wav"),60,100)
	self.firesd = CreateSound(self,"ambient/fire/fire_small_loop1.wav") self.firesd:SetSoundLevel(60)
	self.firesd:PlayEx(1,100)
	self:SetNVar("Fuel", CurTime() + 50, NETWORK_PROTOCOL_PUBLIC)
	self.think = 0
	self.infinite = true


	self:SetCollisionBounds(Vector(25,25,25),Vector(-25,-25,1))

	local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then -- Always check with IsValid! The ent might not have physics!
		phys:EnableMotion(false)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local fuelTbl = {
	["newhlam6"] = 300,
	["newhlam5"] = 300,
	["hlam21"] = 100,
	["intel"] = 100,
	["usedbandage"] = 50,
	["hlam22"] = 100,
	["hlam20"] = 100,
	["update01_hlam11"] = 50,
	["update01_hlam7"] = 40,
	["dryfuel"] = 500,
	["update01_hlam9"] = 100,
	["hlam15"] = 100,
	["hlam17"] = 100,
	["hlam16"] = 100,
	["hlam18"] = 100,
	["copypaper"] = 100,
}

function ENT:Think()
	if self.FirePlaceOn == false then
		VJ_STOPSOUND(self.firesd)
		self:StopParticles()
	end



	if self.think > CurTime() then return end
	self.think = CurTime() + 2

	if self:GetNVar("Fuel") < CurTime() and self:GetNWBool("VJ_FirePlace_Activated") == true then 
		self:SetNWBool("VJ_FirePlace_Activated", false)
		self.FirePlaceOn = false
		self:StopParticles()
		VJ_STOPSOUND(self.firesd)
	end

	if self:GetNVar("Fuel") + 300 < CurTime() and self.infinite ~= true then
		self:Remove()
	end

	local fuel
	for k, v in pairs(ents.FindInSphere( self:GetPos(), 50 )) do
		if fuelTbl[v:GetClass()] then
			fuel = v
			break
		end
	end
	if fuel then
		local additionaltime = fuelTbl[fuel:GetClass()]
		if self:GetNWBool("VJ_FirePlace_Activated") == true then
			if self:GetNVar("Fuel") + additionaltime > CurTime() + 1800 then return end

			if fuel.attributes and fuel.attributes.count and fuel.attributes.count > 1 then
				fuel.attributes.count = fuel.attributes.count - 1
			else
				fuel:Remove()
			end

			self:EmitSound(Sound("ambient/fire/mtov_flame2.wav"),60,100)
			if CurTime() < self:GetNVar("Fuel") then
				self:SetNVar("Fuel", self:GetNVar("Fuel") + additionaltime, NETWORK_PROTOCOL_PUBLIC)
			else
				self:SetNVar("Fuel", CurTime() + additionaltime, NETWORK_PROTOCOL_PUBLIC)
			end
		elseif self:GetNWBool("VJ_FirePlace_Activated") == false then
			local matches
			for k, v in pairs(ents.FindInSphere( self:GetPos(), 50 )) do
				if v:GetClass() == "matches" then
					matches = v
					break
				end
			end
			if not matches then return end


			self:SetNVar("Fuel", CurTime() + additionaltime, NETWORK_PROTOCOL_PUBLIC)
			fuel:Remove()
			matches:Remove()
			self:SetNWBool("VJ_FirePlace_Activated", true)
			self.FirePlaceOn = true
			self:EmitSound(Sound("ambient/fire/mtov_flame2.wav"),60,100)
			self.firesd = CreateSound(self,"ambient/fire/fire_small_loop1.wav") self.firesd:SetSoundLevel(60)
			self.firesd:PlayEx(1,100)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Use(activator, caller)
	if self.FirePlaceOn == false then
		-- self:SetNWBool("VJ_FirePlace_Activated", true)
		-- self.FirePlaceOn = true
		-- self:EmitSound(Sound("ambient/fire/mtov_flame2.wav"),60,100)
		-- self.firesd = CreateSound(self,"ambient/fire/fire_small_loop1.wav") self.firesd:SetSoundLevel(60)
		-- self.firesd:PlayEx(1,100)
	elseif not self.infinite then
		self:SetNWBool("VJ_FirePlace_Activated", false)
		self.FirePlaceOn = false
		self:StopParticles()
		VJ_STOPSOUND(self.firesd)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnTakeDamage(dmginfo)
	return false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Touch(entity)
	if (IsValid(entity) && entity:GetPos():Distance(self:GetPos()) <= 38 && self.FirePlaceOn == true) && (entity:IsNPC() or entity:IsPlayer()) then
		entity:Ignite(math.Rand(3,5))
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:PhysicsCollide(data, physobj)
	//self:EmitSound("physics/cardboard/cardboard_box_impact_soft"..math.random(1,5)..".wav")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnRemove()
	self:StopParticles()
	VJ_STOPSOUND(self.firesd)
end
/*--------------------------------------------------
	*** Copyright (c) 2012-2020 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/