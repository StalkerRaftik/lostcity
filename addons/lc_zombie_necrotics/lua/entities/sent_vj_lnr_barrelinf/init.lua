AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
--ENT.StartHealth = 300
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE"}
ENT.MovementType = VJ_MOVETYPE_STATIONARY
ENT.CanTurnWhileStationary = false
ENT.HasDeathRagdoll = false
ENT.ImmuneDamagesTable = {DMG_RADIATION}
ENT.DisableMakingSelfEnemyToNPCs = true
-- custom
ENT.LN_VirusInfection = true
ENT.LN_IsWalker = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPreInitialize() 
if GetConVarNumber("vj_LNR_Infection") == 0 then 
		self.LN_VirusInfection = false 
end		
end
-------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetModel("models/props/de_train/barrel.mdl")
	--ParticleEffectAttach("smoke_exhaust_01",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("origin"))
	self:SetSkin(math.random(2,6))
    self:SetColor(Color(255,0,0,255))
	self:SetMaxHealth(100)
    self:SetHealth(100)
    self:SetNoDraw(false)
    self:DrawShadow(true)
    self:PhysicsInit( SOLID_VPHYSICS )
    self:SetMoveType( SOLID_VPHYSICS )
    self:SetSolid( SOLID_VPHYSICS )
    self:SetUseType( SIMPLE_USE )
	self.VJ_NoTarget = true
    local phys = self:GetPhysicsObject()
    if (phys:IsValid()) then
    phys:Wake()
end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo,hitgroup)
	if math.random(1,5) == 1 && (dmginfo:IsBulletDamage()) then
	if self.HasSounds == true && self.HasImpactSounds == true then VJ_EmitSound(self,"vj_impact_metal/bullet_metal/metalsolid"..math.random(1,10)..".wav",70) end
		--dmginfo:ScaleDamage(0.60)		
	ParticleEffectAttach("smoke_exhaust_01",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("origin"))
	for _,v in ipairs(ents.FindInSphere(self:GetPos(),DMG_RADIATION,150)) do
	timer.Create("LNR_Radiation"..self:EntIndex(), 1.5, 0, function()
	if IsValid(self) then
    util.VJ_SphereDamage(self,self,self:GetPos(),150,math.random(10,15),DMG_RADIATION,true,true)
	
			 end
		 end)
	  end
   end  
end   
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPriorToKilled()	
	util.BlastDamage(self,self,self:GetPos(),300,150)
	util.ScreenShake(self:GetPos(),100,200,1,2500)

	if self.HasGibDeathParticles == true then
		local effectdata = EffectData()
		effectdata:SetOrigin(self:GetPos()+Vector(0,0,32))
		//effectdata:SetScale(2)
		util.Effect("Explosion",effectdata)
		util.Effect("HelicopterMegaBomb",effectdata)
		ParticleEffect("vj_explosion2",self:GetPos(),Angle(0,0,0),nil)	
		--ParticleEffect("smoke_exhaust_01",self:GetPos() +self:OBBCenter(),Angle(0,0,0),nil)
     self:Remove()		
end
    local props = {
        "models/props_c17/oildrumchunk01a.mdl",
        "models/props_c17/oildrumchunk01b.mdl",
        "models/props_c17/oildrumchunk01c.mdl",
        "models/props_c17/oildrumchunk01d.mdl",
        "models/props_c17/oildrumchunk01e.mdl",
    }

    for i,mdl in pairs(props) do
        local prop = ents.Create("prop_physics")
        prop:SetModel(mdl)
        prop:SetPos(self:GetPos() + Vector(0,0,50) + VectorRand() * 2)
        --prop:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
        
        prop:Spawn()
        prop:Activate()
        prop:PhysWake()
        --prop:GetPhysicsObject():ApplyForceCenter(VectorRand() * 2500)
        prop:SetLocalAngularVelocity(AngleRand())
        SafeRemoveEntityDelayed(prop,6)
    end

    self:EmitSound("weapons/flaregun/fire.wav",95)
    self:EmitSound("physics/metal/metal_box_break2.wav",75,math.random(90,100))
    self:Remove()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Use(p)
    if !self:IsPlayerHolding() and self:GetPos():Distance(p:GetPos()) <= 120 then
        p:PickupObject(self)
    end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/