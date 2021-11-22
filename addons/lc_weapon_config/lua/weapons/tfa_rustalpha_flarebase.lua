
-- Copyright (c) 2018-2019 TFA Base Devs

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

SWEP.Base = "tfa_rustalpha_gunbase"

DEFINE_BASECLASS(SWEP.Base)

SWEP.MuzzleFlashEffect = ""
SWEP.data 				= {}
SWEP.data.ironsights			= 0

SWEP.Delay = 0.1 -- Delay to fire entity
SWEP.Ent = "" -- Nade Entity
SWEP.Velocity = 550 -- Entity Velocity

function SWEP:SetupDataTables(...)
	BaseClass.SetupDataTables(self, ...)

	self:NetworkVar("Bool", 10, "Ready")
end

function SWEP:Initialize()
	self:SetReady(false)

	BaseClass.Initialize(self)
end

function SWEP:Deploy()
	if self:Clip1() <= 0 then
		if self:Ammo1() <= 0 then
			timer.Simple(0, function()
				if IsValid(self) and self:OwnerIsValid() and SERVER then
					self.Owner:StripWeapon(self:GetClass())
				end
			end)
		else
			self:TakePrimaryAmmo(1, true)
			self:SetClip1(1)
		end
	end

	self:SetReady(false)

	self:CleanParticles()

	BaseClass.Deploy(self)
end

function SWEP:ChoosePullAnim()
	if not self:OwnerIsValid() then return end

	self:GetOwner():SetAnimation(PLAYER_RELOAD)

	local tanim = ACT_VM_PULLPIN
	local success = true
	self:SendViewModelAnim(ACT_VM_PULLPIN)

	if game.SinglePlayer() then
		self:CallOnClient("AnimForce", tanim)
	end

	return success, tanim
end

function SWEP:ChooseShootAnim()
	if not self:OwnerIsValid() then return end

	self:GetOwner():SetAnimation(PLAYER_ATTACK1)
	self:SendViewModelAnim(ACT_VM_THROW)
	local tanim = ACT_VM_THROW
	local success = true

	if game.SinglePlayer() then
		self:CallOnClient("AnimForce", tanim)
	end

	return success, tanim
end

function SWEP:Throw()
	if self:Clip1() > 0 then
		self.ProjectileVelocity = self.Velocity and self.Velocity or 550 --Entity to shoot's velocity
		self:TakePrimaryAmmo(1)
		self:ShootBulletInformation()
		self:DoAmmoCheck()
	end
end

function SWEP:DoAmmoCheck()
	if IsValid(self) and SERVER then
		local vm = self:GetOwner():GetViewModel()
		if not IsValid(vm) then return end
		local delay = vm:SequenceDuration()
		delay = delay * 1 - math.Clamp(vm:GetCycle(), 0, 1)

		timer.Simple(delay, function()
			if IsValid(self) then
				self:Deploy()
			end
		end)
	end
end

local CurTime = CurTime

local stat

function SWEP:Think2(...)
	stat = self:GetStatus()

	if CurTime() > self:GetStatusEnd() then
		if stat == TFA.Enum.STATUS_GRENADE_PULL then
			self:SetStatus(TFA.GetStatus("grenade_ready"))
			self:SetStatusEnd(math.huge)
		elseif stat == TFA.Enum.STATUS_GRENADE_THROW then
			self:SetReady(false)
			self:Throw()
		end
	end

	BaseClass.Think2(self, ...)
end

-- local shouldPred = game.SinglePlayer() and SERVER

function SWEP:PrimaryAttack()
	if self:Clip1() > 0 and not self:GetReady() then
		self:SetReady(true)

		local _, tanim = self:ChoosePullAnim()
		self:SetStatus(TFA.GetStatus("grenade_pull"))
		self:SetStatusEnd(CurTime() + self:GetActivityLength(tanim, self:GetStatus()))
	end
end

function SWEP:SecondaryAttack()
	if self:Clip1() > 0 and self:GetStatus() == TFA.Enum.STATUS_GRENADE_READY then
		self:ChooseShootAnim()
		self:SetStatus(TFA.GetStatus("grenade_throw"))
		self:SetStatusEnd(CurTime() + self.Delay)
	end
end

function SWEP:Reload()
	if self:Clip1() <= 0 and self:OwnerIsValid() and self:CanFire() then
		self:Deploy()
	end
end

function SWEP:ChooseIdleAnim( ... )
	if self:GetReady() then return end

	BaseClass.ChooseIdleAnim(self,...)
end