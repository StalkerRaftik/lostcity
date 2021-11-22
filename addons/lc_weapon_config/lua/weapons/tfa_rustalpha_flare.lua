SWEP.Base				= "tfa_rustalpha_flarebase"

DEFINE_BASECLASS(SWEP.Base)

SWEP.Category				= "LostCity Edged Weapons"
SWEP.Author				= "YuRaNnNzZZ"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.PrintName				= "Flare [Edged Weapons]"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 4				-- Slot in the weapon selection menu
SWEP.SlotPos				= 40			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= false		-- set false if you want no crosshair
SWEP.Weight				= 2			-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "slam"		-- how others view you carrying the weapon

SWEP.Type = "Grenade"
SWEP.Type_Displayed = "Portable Light Source"

SWEP.ViewModelFOV			= 54
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/yurie_rustalpha/c-vm-flare.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/yurie_rustalpha/wm-flare.mdl"	-- Weapon world model
SWEP.Spawnable				= (TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.5) and (TFA and TFA.RUSTALPHA ~= nil)
SWEP.UseHands = true
SWEP.AdminSpawnable			= true

SWEP.Primary.RPM				= 60 / 0.75		-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 1		-- Size of a clip
SWEP.Primary.DefaultClip		= 1		-- Bullets you start with
SWEP.Primary.Automatic			= false		-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "yurie_rustalpha_flare"

SWEP.Delay = 20 / 30
SWEP.ProjectileEntity = "tfa_rustalpha_flare_thrown"
SWEP.ProjectileVelocity = 750
SWEP.Primary.ProjectileModel = "models/weapons/yurie_rustalpha/wm-flare-irp.mdl"

function SWEP:SetupDataTables(...)
	BaseClass.SetupDataTables(self, ...)

	self:NetworkVar("Bool", 12, "HasFlareGlowEffect")
end

function SWEP:Think2(...)
	if DynamicLight then
		if self:GetHasFlareGlowEffect() then
			self.DLight = self.DLight or DynamicLight(self:EntIndex(), false)

			if self.DLight then
				local attpos = (self:IsFirstPerson() and self:GetOwner():GetViewModel() or self):GetAttachment(1)

				self.DLight.pos = (attpos and attpos.Pos) and attpos.Pos or self:GetPos()
				self.DLight.r = 255
				self.DLight.g = 0
				self.DLight.b = 0
				self.DLight.decay = 1000
				self.DLight.brightness = 2
				self.DLight.size = math.Rand(240, 272)
				self.DLight.dietime = CurTime() + 1
			end
		elseif self.DLight then
			self.DLight.dietime = -1
		end
	end

	return BaseClass.Think2(self, ...)
end

function SWEP:StopSounds(vm)
	self:SetHasFlareGlowEffect(false)

	if self.DLight then
		self.DLight.dietime = -1
	end

	if IsValid(self.GlowFXCSEnt) then
		self.GlowFXCSEnt.REMOVEME = true
		-- self.GlowFXCSEnt:Remove()
	end

	self:StopSound("YURIE_RUSTALPHA.Flare.Loop")

	if IsValid(vm) then
		vm:StopSound("YURIE_RUSTALPHA.Flare.Loop")
	end
end

function SWEP:OnDrop(...)
	self:StopSounds(self.OwnerViewModel)

	return BaseClass.OnDrop(self, ...)
end

function SWEP:OwnerChanged(...)
	self:StopSounds(self.OwnerViewModel)

	return BaseClass.OwnerChanged(self, ...)
end

function SWEP:Holster(...)
	if self:GetStatus() == TFA.Enum.STATUS_GRENADE_READY then
		self.RemoveAmmo = true
	end

	local retval = BaseClass.Holster(self, ...)

	if retval then
		self:StopSounds()

		if self.RemoveAmmo then
			self.RemoveAmmo = false

			self:TakePrimaryAmmo(1)
		end
	end

	return retval
end

SWEP.EventTable = {
	[ACT_VM_DRAW] = {
		{time = 0, type = "lua", value = SWEP.StopSounds},
		{time = 0, type = "sound", value = Sound("YURIE_RUSTALPHA.Draw")},
		{time = 0, type = "lua", value = function(wep, vm)
			wep.Bodygroups_W["Cap"] = 0
		end}
	},
	[ACT_VM_PULLPIN] = {
		{time = 20 / 30, type = "sound", value = Sound("YURIE_RUSTALPHA.Flare.Strike")},
		{time = 21 / 30, type = "lua", value = function(wep, vm)
			wep.Bodygroups_W["Cap"] = 1
		end},
		{time = 24 / 30, type = "lua", value = function(wep, vm)
			wep:SetHasFlareGlowEffect(true)

			local efdata = EffectData()
			efdata:SetEntity(wep)
			efdata:SetOrigin(wep:GetPos())
			efdata:SetAttachment(1)

			TFA.Effects.Create("yurie_rustalpha_flareglow", efdata)
		end},
		{time = 24 / 30, type = "sound", value = Sound("YURIE_RUSTALPHA.Flare.Loop")}
	},
	[ACT_VM_THROW] = {
		{time = 20 / 30, type = "lua", value = SWEP.StopSounds}
	}
}

SWEP.StatusLengthOverride = {
	[ACT_VM_DRAW] = 0.75,
	[ACT_VM_PULLPIN] = 42 / 30,
}

SWEP.VMPos = Vector(-1.75, 0, -4.5)
SWEP.VMAng = Vector(6.325, 0, 0)

SWEP.RunSightsPos = Vector(-0.35, 0, -6)
SWEP.RunSightsAng = Vector(0, 0, 0)

SWEP.Offset = {
	Pos = {
		Up = 0,
		Right = 2.5,
		Forward = 3.25,
	},
	Ang = {
		Up = 180,
		Right = 0,
		Forward = 180
	},
	Scale = 1
}