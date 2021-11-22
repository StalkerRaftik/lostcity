AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	local mdl = self:GetModel()

	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	local phys = self:GetPhysicsObject()
	self:NextThink(CurTime() + 0.1)

	if phys:IsValid() then
		phys:Wake()
		phys:SetMass(1)
	end


	self:SetUseType(SIMPLE_USE)

	self.damage = self.damage or 15
	self.beep = self.beep or false

	self.DestroyTime = CurTime() + 120
	self.NextBeep = CurTime() + 0.1

	self.Explode = CurTime() + self.delay

	if self.randomturnoff then
		self.Explode = CurTime() + math.Rand(3.5,4)
	end

	self:SetNW2Bool("CanPickup", false)
end



function ENT:Think()
	self:NextThink(CurTime() + 0.1)
	if CurTime() > self.DestroyTime then
		self:Remove()
	end
	
	if CurTime() > self.NextBeep then
		if self.randomturnoff then
			self.NextBeep = CurTime() + 3.3
			self:EmitSound("darky_rust.beancan-grenade-fuse")		
		end
	end

	if CurTime() > self.Explode then
		if not self:IsValid() then return end
		if self.randomturnoff then
			if math.random(1,10)>=8 then 
				self:SetNW2Bool("CanPickup", true)
				self.Explode = CurTime() + 150
				self.NextBeep = CurTime() + 150
				self:StopSound("darky_rust.beancan-grenade-fuse")
				self:EmitSound("darky_rust.rock-strike-3")
			else
				self:EmitSound(self.sound)
				self:StopSound("darky_rust.beancan-grenade-fuse")
				ParticleEffect( "rust_big_explosion", self:GetPos()+self:GetUp()*20, Angle( 0, 0, 0 ) )
				local fx = EffectData()
				fx:SetOrigin(self:GetPos())
				util.Effect( "HelicopterMegaBomb", fx )
				util.ScreenShake(self:GetPos(), 10, 1, 2, 1000)
				if not self.owner or not self.owner:IsValid() then self.owner = self end
				util.BlastDamage(self, self.owner, self:GetPos()+self:GetUp()*10, self.radius, self.damage)
				self:Remove()
			end
		else
			self:EmitSound(self.sound)
			ParticleEffect( "rust_big_explosion", self:GetPos()+self:GetUp()*20, Angle( 0, 0, 0 ) )
			local fx = EffectData()
			fx:SetOrigin(self:GetPos())
			util.Effect( "HelicopterMegaBomb", fx )
			util.ScreenShake(self:GetPos(), 10, 1, 2, 1000)
			if not self.owner or not self.owner:IsValid() then self.owner = self end
			util.BlastDamage(self, self.owner, self:GetPos()+self:GetUp()*10, self.radius, self.damage)
			self:Remove()
		end
	end
end


function ENT:PhysicsCollide(data, phys)
	if not IsFirstTimePredicted() then return end
	
	timer.Simple(0, function()  -- to prevent "Changing collision rules within a callback is likely to cause crashes!" errors
		if not self:IsValid() then return end
		self:EmitSound("darky_rust.beancan-grenade-bounce-"..math.random(1,3))
	end)
end

function ENT:Use(ply, caller)
	local classname = self:GetNW2String("ClassName")
	if not classname or classname == "" then return end
	if not self:GetNW2Bool("CanPickup") then return end
	if ply:IsPlayer() then
		if ply:HasWeapon(classname) then
			ply:GiveAmmo(1, classname, true)
		else
			ply:Give(classname)
		end

		self:Remove()
	end
end