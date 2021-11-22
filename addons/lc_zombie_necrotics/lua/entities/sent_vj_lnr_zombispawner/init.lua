AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.IsVJBaseSpawner = true
ENT.VJBaseSpawnerDisabled = false -- If set to true, it will stop spawning the entities
ENT.SingleSpawner = false -- If set to true, it will spawn the entities once then remove itself
	-- General ---------------------------------------------------------------------------------------------------------------------------------------------
ENT.Model = {"models/props_c17/gravestone003a.mdl"} -- The models it should spawn with | Picks a random one from the table
ENT.SoundTbl_Idle = {}
ENT.GodMode = true
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE"}
ENT.MovementType = VJ_MOVETYPE_STATIONARY
ENT.CanTurnWhileStationary = false

-----custom
ENT.move = false
ENT.move2 = false
ENT.move3 = false
ENT.spawn = false
ENT.spawn2 = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	--self:PhysicsInit(SOLID_VPHYSICS)
	--self:SetMoveType(MOVETYPE_VPHYSICS)
	--self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
	self:SetCollisionBounds(Vector(2, 20, 22), Vector(-2, -20, -22))
	--self:SetUseType(SIMPLE_USE)
	self.VJ_NoTarget = true
self.DisableMakingSelfEnemyToNPCs = true
self.DisableChasingEnemy = true
self.DisableFindEnemy = true
	local phys = self:GetPhysicsObject()
	if phys and phys:IsValid() then
		phys:Wake()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink_AIEnabled()
if IsValid(self) && !IsValid(self.sworm13) && self.spawn == false then
self.spawn = true
self.spawn2 = true
local rands = math.random(1,5)
if rands == 1 then
//VJ_EmitSound(self,"duct/slasherbully_022.wav",100,88)
elseif rands == 2 then
//VJ_EmitSound(self,"duct/slasherbully_023.wav",100,88)
elseif rands == 3 then
//VJ_EmitSound(self,"duct/slasherbully_024.wav",100,88)
elseif rands == 4 then
//VJ_EmitSound(self,"duct/slasherbully_025.wav",100,88)
elseif rands == 5 then
//VJ_EmitSound(self,"duct/slasherbully_026.wav",100,88)
end
local rand = math.random(1,2)
if rand == 1 then

self.sworm13 = ents.Create("npc_vj_lnr_zombi_rising")
self.sworm13:SetPos(self:GetPos() + self:GetForward() * 50)
self.sworm13:SetAngles(self:GetAngles())
self.sworm13:Spawn()
self.sworm13:Activate()
self.sworm13:SetOwner(self)
self:DeleteOnRemove(self.sworm13)

elseif rand == 2 then

self.sworm13 = ents.Create("npc_vj_lnr_zombi_rising_corpse")
self.sworm13:SetPos(self:GetPos() + self:GetForward() * 50)
self.sworm13:SetAngles(self:GetAngles())
self.sworm13:Spawn()
self.sworm13:Activate()
self.sworm13:SetOwner(self)
self:DeleteOnRemove(self.sworm13)

end
end
if IsValid(self) && !IsValid(self.sworm13) && self.spawn2 == true then
self.spawn2 = false
timer.Simple(math.random(6,18),function() if IsValid(self) then
self.spawn = false end end)
end
end

/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/