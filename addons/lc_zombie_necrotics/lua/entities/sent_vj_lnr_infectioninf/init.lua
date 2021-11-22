AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
-- custom
ENT.LN_VirusInfection = true
ENT.LN_IsWalker = false
-------------------------------------------------------------------------------------
function ENT:Initialize()
self:SetModel("models/props_lab/jar01b.mdl")
self:SetColor(Color(255,0,0,255))
self:SetNoDraw(false)
self:DrawShadow(true)
self:PhysicsInit( SOLID_VPHYSICS )
self:SetMoveType( SOLID_VPHYSICS )
self:SetSolid( SOLID_VPHYSICS )
self:SetUseType( SIMPLE_USE )
local phys = self:GetPhysicsObject()
if (phys:IsValid()) then
phys:Wake()
end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Touch(activator)
if (activator:IsNPC() or activator:IsPlayer()) and GetConVarNumber("vj_LNR_Infection") == 1 then
activator:TakeDamage(9999999,self)
self:Remove()
end
end	
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:PhysicsCollide(data, physobj)
	if (data.Speed <= 200 and data.DeltaTime > 0.3) then
    self:EmitSound("physics/glass/glass_impact_soft"..math.random(1,3)..".wav")
	elseif (data.Speed > 200 and data.DeltaTime > 0.3) then
    self:EmitSound("physics/glass/glass_pottery_break"..math.random(1,4)..".wav")
    self:Remove()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnTakeDamage(dmginfo)
self:EmitSound("physics/glass/glass_pottery_break"..math.random(1,4)..".wav")
self:Remove()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Use(p)
  p:PickupObject(self)
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/