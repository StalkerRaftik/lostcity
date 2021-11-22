AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.Spawnable = false

function ENT:Draw()
	self:DrawModel()
end

function ENT:Initialize()
	if SERVER then
		self:SetModel( "models/weapons/tfa_csgo/w_c4_planted.mdl" )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
		self:DrawShadow( true )
		self:EmitSound( "TFA_CSGO_c4.plant" )
		self:SetUseType(CONTINUOUS_USE)
		local phys = self:GetPhysicsObject()
		if phys:IsValid() then
			phys:Wake()
			phys:SetBuoyancyRatio(0)
		end
	end
	
	self.DefuseProgress = 0
	self:SetNWBool("stopdetonation",false)
	self.DefuseTime = 10
	self.NextTick = 0
	self.LastUse = 0
	
	self.BeepTimer = CurTime() + 3
	self.FinalBeep = 0
	self.FinalBeepTimer = CurTime()
	self.ExplodeTimer = CurTime() + 40
end

function ENT:PhysicsCollide(data, physobj)
	if SERVER then
		self:SetMoveType(MOVETYPE_NONE)
	end
end

function ENT:Use(activator,caller,useType,value)
	if self:GetNWBool("defusing",false) == false then
		self:EmitSound("TFA_CSGO_c4.disarmstart")
		self:SetNWBool("defusing",true)
	end
	
	if ( activator:IsPlayer() ) then
		local DefaultRunSpeed = activator:GetRunSpeed()
		local DefaultWalkSpeed = activator:GetWalkSpeed()
		if self.NextTick <= CurTime() then
			self.LastUse = CurTime()
			self.DefuseProgress = self.DefuseProgress + 0.05
			self.NextTick = CurTime() + 0.05
			self.Using = true
		end
		self:SetNWInt("defusecount",self.Progress)	
	else
		--print("WHAT ARE YOU")
	end
end

function ENT:Think()
	
	local attach = self:LookupAttachment("led")
	local data = self:GetAttachment(attach)
	local attpos,attangs
	attpos = data.Pos
	attangs = data.Ang
	
	if SERVER then
		if self.DefuseProgress >= self.DefuseTime  then
			self:EmitSound("TFA_CSGO_c4.disarmfinish")
			self:Remove()
			self:SetNWBool("stopboom",true)
		else
			if self.LastUse + 0.1 <= CurTime() then
				self.DefuseProgress = 0
				self.Progress = 0
				self:SetNWInt("defusecount",self.Progress)
				self:SetNWBool("defusing",false)		
			end
		end
		
		if CurTime() > self.ExplodeTimer then			
			if self:GetNWBool("stopboom",false) == false then
				self:Explode()
				self:Remove()
			end
		end
		
		if self.BeepTimer <= CurTime() and self.ExplodeTimer > CurTime() + 2 then
			if SERVER then
				self:EmitSound( "TFA_CSGO_c4.PlantSound" )
			end
			local timerlight = ents.Create( "info_particle_system" )
			timerlight:SetKeyValue( "effect_name", "c4_timer_light" )
			timerlight:SetOwner( self.Owner )
			timerlight:SetPos( self:GetAttachment(1).Pos )
			timerlight:SetParent(self)
			timerlight:Spawn()
			timerlight:Activate()
			timerlight:Fire( "start", "", 0 )
			timerlight:Fire( "kill", "", 0.001 )
			self.BeepTimer = CurTime() + ( self.ExplodeTimer - CurTime() ) / 35	
		end
			
		if self.FinalBeep == 0 and self.ExplodeTimer <= CurTime() + 2 then
			self.FinalBeep = 1
			self.FinalBeepTimer = CurTime()
		end
			
		if self.FinalBeep == 1 and self.FinalBeepTimer <= CurTime() then
			if SERVER then
				self:EmitSound( "TFA_CSGO_c4.ExplodeTriggerTrip" )
			end
			local triggerlight = ents.Create( "info_particle_system" )
			triggerlight:SetKeyValue( "effect_name", "c4_timer_light_trigger" )
			triggerlight:SetOwner( self.Owner )
			triggerlight:SetPos( self:GetAttachment(1).Pos )
			triggerlight:SetParent(self)
			triggerlight:Spawn()
			triggerlight:Activate()
			triggerlight:Fire( "start", "", 0 )
			triggerlight:Fire( "kill", "", 5 )
			self.FinalBeep = 2
			self.FinalBeepTimer = CurTime() + 1
		end
			
		if self.FinalBeep == 2 and self.FinalBeepTimer <= CurTime() then
			if SERVER then
				self:EmitSound( "TFA_CSGO_c4.ExplodeWarning" )
			end	
			self.FinalBeep = 3
		end	
	end
end

function ENT:OnRemove()
end

function ENT:Explode()
	local ply = IsValid(self:GetOwner()) and self:GetOwner() or self
	if SERVER then
	local explode = ents.Create( "info_particle_system" )
		explode:SetKeyValue( "effect_name", "explosion_c4_500" )
		explode:SetOwner( self.Owner )
		explode:SetPos( self:GetPos() )
		explode:Spawn()
		explode:Activate()
		explode:Fire( "start", "", 0 )
		explode:Fire( "kill", "", 30 )
		self:EmitSound( "TFA_CSGO_c4.explode" )
	end
	util.BlastDamage( self, ply, self:GetPos(), 1750, 500 )
	local spos = self:GetPos()
	local trs = util.TraceLine({start=spos + Vector(0,0,64), endpos=spos + Vector(0,0,-32), filter=self})
	util.Decal("Scorch", trs.HitPos + trs.HitNormal, trs.HitPos - trs.HitNormal)
end