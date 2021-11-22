DEFINE_BASECLASS("tfa_gun_base")
SWEP.Type = "Grenade"
SWEP.MuzzleFlashEffect = ""
SWEP.data = {}
SWEP.data.ironsights = 0
SWEP.Primary.Round = ""
SWEP.UseHands = true

// Velocities
SWEP.Velocity = 1000
SWEP.Velocity_Underhand = 500

// How long the nade should be cooked for before blowing up in hand  
SWEP.CookTimer = 5

// Pretty simple
SWEP.UnderhandEnabled = false
SWEP.CookingEnabled = false

//Third person animation and entity throw delay
SWEP.Delay = 0
SWEP.DelayCooked = 0
SWEP.Delay_Underhand = 0

//How long into the animation to delay the start of the cook
SWEP.CookStartDelay = 0

//Angle modifiers for thrown NADE
SWEP.NadeAngleModifier = Angle( 0, 0, 0 )
SWEP.NadeAngleModifierUnderhand = Angle( 0, 0, 0 )

SWEP.IsTFADOINade = true

function SWEP:Initialize()
	self:SetNW2Bool("Cooking", false)
	self:SetNW2Bool("Pulling", false)
	self:SetNW2Bool("Underhand", false)
	self.NextThrowTime = math.huge
      self.ThrowTime = math.huge
      self.ThirdPersonThrowAnimTime = math.huge
      self.ResetTime = math.huge
      self.ProjectileEntity = self.Primary.Round
      self.DestructTime = math.huge
      self.IsTFADOINade = true
      BaseClass.Initialize(self)
end

function SWEP:Deploy()
      self:DoAmmoCheck()
	self:SetNW2Bool("Cooking", false)
	self:SetNW2Bool("Pulling", false)
	self:SetNW2Bool("Underhand", false)
	self.NextThrowTime = math.huge
      self.ThrowTime = math.huge
      self.ThirdPersonThrowAnimTime = math.huge
      self.ResetTime = math.huge
      self.DestructTime = math.huge
      BaseClass.Deploy(self)
end

function SWEP:ChoosePullAnim()
	if not self:OwnerIsValid() then return end
	
	local cooking = self:GetNW2Bool( "Cooking", false )
	
	local tanim = ACT_VM_PULLBACK_HIGH
	
	if cooking then
		tanim = ACT_VM_PULLBACK_HIGH_BAKE
	end
	
	self:SendViewModelAnim(tanim)

	return tanim
end

function SWEP:ChooseShootAnim()
	if not self:OwnerIsValid() then return end
      
      local cooking = self:GetNW2Bool( "Cooking", false )
      local underhand = self:GetNW2Bool( "Underhand", false )
	
	local tanim = ACT_VM_THROW

      if cooking then
            tanim = ACT_VM_SECONDARYATTACK
            self.ThirdPersonThrowAnimTime = CurTime() + self.DelayCooked
      elseif underhand then
		tanim = ACT_VM_HAULBACK
		self.ThirdPersonThrowAnimTime = CurTime() + self.Delay
	else
            self.ThirdPersonThrowAnimTime = CurTime() + self.Delay
      end

	self:SendViewModelAnim(tanim)

	return tanim
end

function SWEP:Throw()
	
      local tanim = self:ChooseShootAnim()
      
      local cooking = self:GetNW2Bool( "Cooking", false )
      
	local underhand = self:GetNW2Bool( "Underhand", false )
	
      if cooking then
            self.ThrowTime = CurTime() + self.DelayCooked
      elseif underhand then
		self.ThrowTime = CurTime() + self.Delay_Underhand
	else
            self.ThrowTime = CurTime() + self.Delay
      end
      
      self.ResetTime = CurTime() + self:SequenceDuration( self:SelectWeightedSequence( tanim ) )
      self.NextThrowTime = math.huge
      
end

function SWEP:DoAmmoCheck()
      
      if self:Clip1() <= 0 then
		if self:Ammo1() <= 0 then
			timer.Simple(0, function()
				if IsValid(self) and self:OwnerIsValid() and SERVER then
					self:GetOwner():StripWeapon(self:GetClass())
				end
			end)
		else
			self:TakePrimaryAmmo(1, true)
			self:SetClip1(1)
		end
	end
      
end

function SWEP:Think2()
	BaseClass.Think2(self)
      if self.DestructTime <= CurTime() and self:GetNW2Bool( "Cooking", false ) then
            self:SelfDestruct()
      end
	if self.NextThrowTime <= CurTime() and not self:GetOwner():KeyDown(IN_ATTACK) and not self:GetOwner():KeyDown(IN_ATTACK2) then
		self:Throw()
	end
      if self.ThrowTime <= CurTime() then
            self:ShootBulletInformation()
            self.ThrowTime = math.huge
      end
      if self.ThirdPersonThrowAnimTime <= CurTime() then
            self:GetOwner():SetAnimation(PLAYER_ATTACK1)
            self.ThirdPersonThrowAnimTime = math.huge
      end
      if self.ResetTime <= CurTime() then
            self:SetClip1( 0 )
            self:Deploy()
      end
end

function SWEP:PrimaryAttack()
    if not IsFirstTimePredicted() then return end
	if self:Clip1() > 0 and self:OwnerIsValid() and self:CanStartThrow() and self.Owner:KeyDown( IN_USE ) and self.CookingEnabled then
		self:SetNW2Bool( "Pulling", true )
		self:SetNW2Bool( "Cooking", true )
		local tanim = self:ChoosePullAnim()
		self.NextThrowTime = self:SequenceDuration( self:SelectWeightedSequence( tanim ) ) + CurTime()
        	self.DestructTime = CurTime() + self.CookTimer + self.CookStartDelay
	elseif self:Clip1() > 0 and self:OwnerIsValid() and self:CanStartThrow() then
		self:SetNW2Bool( "Pulling", true )
		local tanim = self:ChoosePullAnim()
		self.NextThrowTime = self:SequenceDuration( self:SelectWeightedSequence( tanim ) ) + CurTime()
	end
end

function SWEP:SecondaryAttack()
	if not IsFirstTimePredicted() then return end
	if self:Clip1() > 0 and self:OwnerIsValid() and self:CanStartThrow() and self.UnderhandEnabled then
		self:SetNW2Bool( "Pulling", true )
		self:SetNW2Bool( "Underhand", true )
		local tanim = self:ChoosePullAnim()
		self.NextThrowTime = self:SequenceDuration( self:SelectWeightedSequence( tanim ) ) + CurTime()
	end
end

function SWEP:ChooseIdleAnim( ... )
	if self:GetNW2Bool( "Pulling", false ) then return end
	BaseClass.ChooseIdleAnim( self, ... )
end

function SWEP:CanStartThrow()
	if self:GetNW2Bool( "Pulling", false ) or not self:CanPrimaryAttack() then return false end
	return true
end

function SWEP:SelfDestruct()
      local effectdata = EffectData()
      effectdata:SetOrigin( self:GetPos() )
      util.Effect( "Explosion", effectdata )
      util.BlastDamage( self, self.Owner, self:GetPos(), 375, 135 )
end

function SWEP:Reload()
	
end

function SWEP:ShootBullet(damage, recoil, num_bullets, aimcone, disablericochet, bulletoverride)
	
	if not IsFirstTimePredicted() and not game.SinglePlayer() then return end

	if SERVER then
		local ent = ents.Create(self:GetStat("Primary.Projectile"))
		local dir
		local ang = self:GetOwner():EyeAngles()
		dir = ang:Forward()
		ent:SetPos(self:GetOwner():GetShootPos())
		ent:SetOwner( self:GetOwner() )
		if self:GetNW2Bool( "Underhand", false ) then
			ent:SetAngles( ang + self.NadeAngleModifierUnderhand )
		else
			ent:SetAngles( ang + self.NadeAngleModifier )
		end
        if self:GetNW2Bool( "Cooking", false ) then
              ent.KaboomTime = self.DestructTime
        else
              ent.KaboomTime = CurTime() + self.CookTimer
        end
		
		ent:Spawn()

		local phys = ent:GetPhysicsObject()

		if IsValid(phys) then
			phys:AddAngleVelocity( Vector( 0, 0.66, 0 ) * 1000 )
			if self:GetNW2Bool( "Underhand", false ) then
				phys:SetVelocity( dir * self.Velocity_Underhand )
			else
				phys:SetVelocity( dir * self.Velocity )
			end
		end

		ent:SetOwner(self:GetOwner())
	end

end
