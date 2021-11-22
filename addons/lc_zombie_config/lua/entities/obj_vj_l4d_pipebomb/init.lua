AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.VJ_AddEntityToSNPCAttackList = true
ENT.Model = {"models/cpthazama/l4d1/weapons/pipebomb.mdl"} -- The models it should spawn with | Picks a random one from the table
ENT.MoveCollideType = nil -- Move type | Some examples: MOVECOLLIDE_FLY_BOUNCE, MOVECOLLIDE_FLY_SLIDE
ENT.CollisionGroupType = nil -- Collision type, recommended to keep it as it is
ENT.SolidType = SOLID_VPHYSICS -- Solid type, recommended to keep it as it is
ENT.RemoveOnHit = false -- Should it remove itself when it touches something? | It will run the hit sound, place a decal, etc.
ENT.DecalTbl_DeathDecals = {"Scorch"}
ENT.SoundTbl_OnCollide = {"weapons/hegrenade/he_bounce-1.wav"}

-- Custom
ENT.FussTime = 7
ENT.TimeSinceSpawn = 0
ENT.Zombies = {}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomPhysicsObjectOnInitialize(phys)
	phys:Wake()
	phys:EnableGravity(true)
	phys:SetBuoyancyRatio(0)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	for _, x in ipairs(ents.FindInSphere(self:GetPos(),4000)) do
		if x:IsNPC() && string.find(x:GetClass(),"npc_vj_l4d_com_") && x.Zombie_CanHearPipe == true && x.Zombie_NextPipBombT < CurTime() then
			x.Zombie_NextPipBombT = CurTime() + 6.9
			table.insert(x.VJ_AddCertainEntityAsEnemy,self)
			x:AddEntityRelationship(self,D_HT,99)
			x.MyEnemy = self
			x:SetEnemy(self)
			table.insert(self.Zombies,x)
		end
	end
	
	timer.Simple(self.FussTime,function() if IsValid(self) then self:DeathEffects() end end)
	timer.Simple(0,function() if IsValid(self) then self:Beep(75) end end)
	timer.Simple(1,function() if IsValid(self) then self:Beep(75) end end)
	timer.Simple(2,function() if IsValid(self) then self:Beep(75) end end)
	timer.Simple(3,function() if IsValid(self) then self:Beep(75) end end)
	timer.Simple(3.5,function() if IsValid(self) then self:Beep(75) end end)
	timer.Simple(4,function() if IsValid(self) then self:Beep(75) end end)
	timer.Simple(4.4,function() if IsValid(self) then self:Beep(75) end end)
	timer.Simple(4.8,function() if IsValid(self) then self:Beep(78) end end)
	timer.Simple(5.2,function() if IsValid(self) then self:Beep(80) end end)
	timer.Simple(5.6,function() if IsValid(self) then self:Beep(80) end end)
	timer.Simple(6,function() if IsValid(self) then self:Beep(84) end end)
	timer.Simple(6.2,function() if IsValid(self) then self:Beep(84) end end)
	timer.Simple(6.3,function() if IsValid(self) then self:Beep(84) end end)
	timer.Simple(6.4,function() if IsValid(self) then self:Beep(84) end end)
	timer.Simple(6.5,function() if IsValid(self) then self:Beep(84) end end)
	timer.Simple(6.6,function() if IsValid(self) then self:Beep(88) end end)
	timer.Simple(6.7,function() if IsValid(self) then self:Beep(90) end end)
	timer.Simple(6.8,function() if IsValid(self) then self:Beep(90) end end)
	timer.Simple(6.9,function() if IsValid(self) then self:Beep(90) end end)
	
	local glow = ents.Create("env_sprite")
	glow:SetKeyValue("model","sprites/glow1.vmt")
	glow:SetKeyValue("scale","0.1")
	glow:SetKeyValue("rendermode","5")
	glow:SetKeyValue("rendercolor","255 191 0")
	glow:SetKeyValue("spawnflags","1")
	glow:SetPos(self:GetPos())
	glow:SetParent(self)
	glow:Spawn()
	glow:Activate()
	glow:Fire("SetParentAttachment","fuse")
	self:DeleteOnRemove(glow)
	
	local glow = ents.Create("env_sprite")
	glow:SetKeyValue("model","sprites/glow1.vmt")
	glow:SetKeyValue("scale","0.05")
	glow:SetKeyValue("rendermode","5")
	glow:SetKeyValue("rendercolor","255 0 0")
	glow:SetKeyValue("spawnflags","1")
	glow:SetPos(self:GetPos())
	glow:SetParent(self)
	glow:Spawn()
	glow:Activate()
	glow:Fire("SetParentAttachment","pipebomb_light")
	self:DeleteOnRemove(glow)
	
	util.SpriteTrail(self, 2, Color(255,0,0,255), false, 15, 0.5, 0.2, 1/(10+1)*0.5, "VJ_Base/sprites/vj_trial1.vmt")
	
	self.Light = ents.Create("light_dynamic")
	self.Light:SetKeyValue("brightness", "0.5")
	self.Light:SetKeyValue("distance", "35")
	self.Light:SetLocalPos(self:GetPos())
	self.Light:SetLocalAngles( self:GetAngles() )
	self.Light:Fire("Color", "255 50 0")
	self.Light:SetParent(self)
	self.Light:Spawn()
	self.Light:Activate()
	self.Light:Fire("TurnOn", "", 0)
	self.Light:Fire("SetParentAttachment","fuse")
	self:DeleteOnRemove(self.Light)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Beep(vol)
	self:EmitSound("vj_l4d_com/pipe_bomb/beep.wav",vol,100)
	
	local glow = ents.Create("env_sprite")
	glow:SetKeyValue("model","sprites/glow1.vmt")
	glow:SetKeyValue("scale","0.115")
	glow:SetKeyValue("rendermode","5")
	glow:SetKeyValue("rendercolor","255 0 0")
	glow:SetKeyValue("spawnflags","1")
	glow:SetPos(self:GetPos())
	glow:SetParent(self)
	glow:Spawn()
	glow:Activate()
	glow:Fire("SetParentAttachment","pipebomb_light")
	self:DeleteOnRemove(glow)
	
	timer.Simple(0.2,function()
		if IsValid(self) then
			glow:Remove()
		end
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	self.TimeSinceSpawn = self.TimeSinceSpawn + 0.2
	for _,v in ipairs(self.Zombies) do
		if IsValid(v) then
			v:SetLastPosition(self:GetPos())
			v:VJ_TASK_GOTO_LASTPOS()
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage(dmginfo)
	self:GetPhysicsObject():AddVelocity(dmginfo:GetDamageForce() * 0.1)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPhysicsCollide(data,phys)
	getvelocity = phys:GetVelocity()
	velocityspeed = getvelocity:Length()
	if velocityspeed > 500 then -- Or else it will go flying!
		phys:SetVelocity(getvelocity * 1.2)
	end
	
	if velocityspeed > 100 then -- If the grenade is going faster than 100, then play the touch sound
		self:OnCollideSoundCode()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DeathEffects()
	ParticleEffect("vj_explosion2",self:GetPos(),Angle(0,0,0),nil)
	util.ScreenShake(self:GetPos(), 100, 200, 1, 2500)
	local owner = self:GetOwner()
	if self:GetOwner() == NULL then owner = self end
	util.BlastDamage(self,owner,self:GetPos(),450,150)
	
	local effectdata = EffectData()
	effectdata:SetOrigin(self:GetPos())
	util.Effect( "ThumperDust", effectdata )
	util.Effect( "Explosion", effectdata )

	self.ExplosionLight1 = ents.Create("light_dynamic")
	self.ExplosionLight1:SetKeyValue("brightness", "4")
	self.ExplosionLight1:SetKeyValue("distance", "300")
	self.ExplosionLight1:SetLocalPos(self:GetPos())
	self.ExplosionLight1:SetLocalAngles( self:GetAngles() )
	self.ExplosionLight1:Fire("Color", "255 150 0")
	self.ExplosionLight1:SetParent(self)
	self.ExplosionLight1:Spawn()
	self.ExplosionLight1:Activate()
	self.ExplosionLight1:Fire("TurnOn", "", 0)
	self:DeleteOnRemove(self.ExplosionLight1)
	util.ScreenShake(self:GetPos(), 100, 200, 1, 2500)

	self:SetLocalPos(Vector(self:GetPos().x,self:GetPos().y,self:GetPos().z +4)) -- Because the entity is too close to the ground
	local tr = util.TraceLine({
	start = self:GetPos(),
	endpos = self:GetPos() - Vector(0, 0, 100),
	filter = self })
	util.Decal(VJ_PICK(self.DecalTbl_DeathDecals),tr.HitPos+tr.HitNormal,tr.HitPos-tr.HitNormal)

	self:EmitSound(VJ_PICK({"vj_l4d_com/pipe_bomb/explode3.wav","vj_l4d_com/pipe_bomb/explode5.wav"}),90,100)
	self:DoDamageCode()
	self:SetDeathVariablesTrue(nil,nil,false)
	self:Remove()
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/