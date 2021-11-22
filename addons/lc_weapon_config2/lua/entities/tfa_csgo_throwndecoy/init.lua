AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	
	self.Entity:SetModel("models/weapons/tfa_csgo/w_eq_decoy_thrown.mdl")
	
	self:PhysicsInit(SOLID_VPHYSICS)
	--self.Entity:PhysicsInitSphere( ( self:OBBMaxs() - self:OBBMins() ):Length()/4, "metal" )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:DrawShadow( false )
	self.Entity:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	
	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:SetMass(6.5)
		phys:SetDamping(0.1,5)
	end
	
	self:SetFriction(3)
	
	self.particleCreated = false
	
	self:EmitSound("TFA_CSGO_Decoy.Throw")
	
	timer.Simple(15,function()
		if IsValid(self) then self.active = false self:Explode() self:Remove() end
	end)
	self:Think()
end

 function ENT:Think()
	
	if !self.lasttick then self.lasttick = CurTime()-0.1 end
	if self:GetVelocity():Length()<5 then
		self.active = true
		if self.ParticleCreated ~= true then
			local ground = ents.Create( "info_particle_system" )
			ground:SetKeyValue( "effect_name", "weapon_decoy_ground_effect" )
			ground:SetOwner( self )
			ground:SetPos(self:GetAttachment(1).Pos)
			ground:SetParent(self)
			ground:Spawn()
			ground:Activate()
			ground:Fire( "start", "", 0 )
			ground:Fire( "kill", "", 15 )
			self.ParticleCreated = true
		end
		if math.random(1,1/(CurTime()-self.lasttick)*2)==1 and IsValid(self.Owner) then
			local bul = {}
			bul.Attacker = self.Owner
			bul.Inflictor = self
			bul.Damage = 0
			bul.Force = 0.1
			bul.Dir = Vector(0,0,-1)
			bul.Tracer = 0
			bul.Spread = vector_origin
			bul.Src = self:GetPos()
			self.Owner:FireBullets(bul,true)
			local fsound = Sound("weapons/tfa_csgo/ak47/ak47-1-distant.wav")
			if self.Owner.GetActiveWeapon then
				local wep = self.Owner:GetActiveWeapon()
				if IsValid(wep) and wep.Primary and wep.Primary.Sound then
					fsound = wep.Primary.Sound
				end
			end
			self:EmitSound(fsound)
			local shot = ents.Create( "info_particle_system" )
			shot:SetKeyValue( "effect_name", "weapon_decoy_ground_effect_shot" )
			shot:SetOwner( self )
			shot:SetPos( self:GetAttachment(1).Pos )
			shot:SetParent(self)
			shot:Spawn()
			shot:Activate()
			shot:Fire( "start", "", 0 )
			shot:Fire( "kill", "", 0.001 )
		end
	end
	
	self.lasttick=CurTime()
	self:NextThink(CurTime())
	return true
end

function ENT:Explode()
if SERVER then
		local explode = ents.Create( "info_particle_system" )
		explode:SetKeyValue( "effect_name", "explosion_hegrenade_brief" )
		explode:SetOwner( self.Owner )
		explode:SetPos( self:GetPos() )
		explode:Spawn()
		explode:Activate()
		explode:Fire( "start", "", 0 )
		explode:Fire( "kill", "", 15 )
		local explode2 = ents.Create( "info_particle_system" )
		explode2:SetKeyValue( "effect_name", "explosion_hegrenade_interior" )
		explode2:SetOwner( self.Owner )
		explode2:SetPos( self:GetPos() )
		explode2:Spawn()
		explode2:Activate()
		explode2:Fire( "start", "", 0 )
		explode2:Fire( "kill", "", 15 )
	self:EmitSound( "TFA_CSGO_BaseGrenade.Explode" )
end
	util.BlastDamage( self, self.Owner, self:GetPos(), 350, 5 )
	local spos = self:GetPos()
	local trs = util.TraceLine({start=spos + Vector(0,0,64), endpos=spos + Vector(0,0,-32), filter=self})
	util.Decal("Scorch", trs.HitPos + trs.HitNormal, trs.HitPos - trs.HitNormal)
end

/*---------------------------------------------------------
OnTakeDamage
---------------------------------------------------------*/
function ENT:OnTakeDamage( dmginfo )
end


/*---------------------------------------------------------
Use
---------------------------------------------------------*/
function ENT:Use( activator, caller, type, value )
end


/*---------------------------------------------------------
StartTouch
---------------------------------------------------------*/
function ENT:StartTouch( entity )
end


/*---------------------------------------------------------
EndTouch
---------------------------------------------------------*/
function ENT:EndTouch( entity )
end


/*---------------------------------------------------------
Touch
---------------------------------------------------------*/
function ENT:Touch( entity )
end