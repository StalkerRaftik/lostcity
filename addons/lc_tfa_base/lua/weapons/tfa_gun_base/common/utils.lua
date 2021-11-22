
-- Copyright (c) 2018-2020 TFA Base Devs

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

TFA.RangeFalloffLUTStep = 0.01
TFA.RangeFalloffLUTStepInv = 1 / TFA.RangeFalloffLUTStep

SWEP.AmmoRangeTable = {
	["SniperPenetratedRound"] = 2,
	["SniperPenetratedBullet"] = 2,
	["buckshot"] = 0.5,
	["ar2"] = 1,
	["smg1"] = 0.7,
	["pistol"] = 0.33,
	["def"] = 1
}

function SWEP:AmmoRangeMultiplier()
	return self.AmmoRangeTable[self.Primary_TFA.Ammo or "def"] or self.AmmoRangeTable["def"] or 1
end

function SWEP:MetersToUnits(x)
	return x * 39.3701 * 4 / 3
end

function SWEP:GetLastSequenceString()
	if not IsValid(self.OwnerViewModel) then return "" end

	if self:GetLastSequence() < 0 then return "" end
	return self.OwnerViewModel:GetSequenceName(self:GetLastSequence())
end

local cv_3dmode = GetConVar("cl_tfa_scope_sensitivity_3d")

SWEP.SensitivtyFunctions = {
	[0] = function() return 1 end,
	[1] = function(self, ...)
		if self:GetStat("Secondary.ScopeZoom") then
			return TFA.CalculateSensitivtyScale(90 / self:GetStat("Secondary.ScopeZoom"), self:GetStat("Secondary.IronFOV"), self.Secondary_TFA.ScopeScreenScale or 0.392592592592592)
		else
			return self.SensitivtyFunctions[2](self, ...)
		end
	end,
	[2] = function(self, ...)
		if self:GetStat("RTScopeFOV") then
			return TFA.CalculateSensitivtyScale(self:GetStat("RTScopeFOV"), self:GetStat("Secondary.IronFOV"), self.Secondary_TFA.ScopeScreenScale or 0.392592592592592)
		else
			return self.SensitivtyFunctions[0](self, ...)
		end
	end,
	[3] = function(self, ...)
		if self:GetStat("RTScopeFOV") then
			return TFA.CalculateSensitivtyScale(self:GetStat("RTScopeFOV"), self:GetStat("Secondary.IronFOV"), 1)
		else
			return self.SensitivtyFunctions[0](self, ...)
		end
	end
}

function SWEP:Get3DSensitivity()
	local f = self.SensitivtyFunctions[cv_3dmode:GetInt()]

	return f(self)
end

function SWEP:GetSeed()
	local sd = math.floor(self:Clip1() + self:Ammo1() + self:Clip2() + self:Ammo2() + self:GetLastActivity()) + self:GetNextIdleAnim() + self:GetNextPrimaryFire() + self:GetNextSecondaryFire()

	return math.Round(sd)
end

function SWEP:GetSeedIrradical()
	return math.floor(self:Clip1() + self:Ammo1() + self:Clip2() + self:Ammo2() + self:GetLastActivity()) + self:GetNextIdleAnim() + self:GetNextPrimaryFire() + self:GetNextSecondaryFire()
end

SWEP.SharedRandomValues = {}
local seed

--math.random equivalent
function SWEP:SharedRandom(min, max, id)
	if min and not max then
		max = min
		min = 1
	end

	min = math.Round(min)
	max = math.Round(max)
	local key = (id or "Weapon") .. min .. max
	seed = self:GetSeed()
	local val = math.floor(util.SharedRandom(id or "Weapon", min, max + 1, seed))

	if self.SharedRandomValues[key] and self.SharedRandomValues[key] == val then
		if min < val and max > val then
			math.randomseed(seed)

			if (math.Rand(0, 1) < 0.5) then
				math.randomseed(seed + 1)
				val = math.random(min, val - 1)
			else
				math.randomseed(seed + 1)
				val = math.random(val + 1, max)
			end
		elseif min < val then
			math.randomseed(seed + 1)
			val = math.random(min, val - 1)
		elseif max > val then
			math.randomseed(seed + 1)
			val = math.random(val + 1, max)
		end
	end

	if IsFirstTimePredicted() then
		timer.Simple(0, function()
			if IsValid(self) then
				self.SharedRandomValues[key] = val
			end
		end)
	end

	return val
end

local oiv = nil
local rlcv = GetConVar("sv_tfa_reloads_enabled")
local holding_result_cached = false
local last_held_check = -1
local sp = game.SinglePlayer()
local slo, sqlo
local nm

--[[
local sqind

function SWEP:TranslateSequenceActivityTable( tbl )
	if not self:VMIV() then return end
	for k,v in pairs(tbl) do
		if type(k) == "string" then
			sqind = self.OwnerViewModel:GetSequenceActivity( self.OwnerViewModel:LookupSequence( k ) or -1 ) or -1
			tbl[ sqind ] = tbl[sqind] or v
		end
		tbl[k] = nil
	end
end
]]
--
--, seq )
function SWEP:GetActivityLengthRaw(tanim, status, animType)
	local vm = self:VMIVNPC()
	if not vm then return 0 end

	if tanim == nil then
		-- we already track last sequence so, we can account sequence
		tanim = self:GetLastSequence()
		animType = TFA.Enum.ANIMATION_SEQ
	end

	if tanim < 0 then return 0 end

	if animType == nil or animType == TFA.Enum.ANIMATION_ACT then
		nm = vm:GetSequenceName(vm:SelectWeightedSequenceSeeded(tanim, self:GetSeedIrradical()))
	else
		nm = vm:GetSequenceName(tanim)
	end

	local sqlen

	if animType == TFA.Enum.ANIMATION_SEQ then
		sqlen = vm:SequenceDuration(tanim)
	elseif tanim == vm:GetSequenceActivity(vm:GetSequence()) then
		sqlen = vm:SequenceDuration(vm:GetSequence())
	else
		sqlen = vm:SequenceDuration(vm:SelectWeightedSequenceSeeded(math.max(tanim or 1, 1), self:GetSeedIrradical()))
	end

	slo = self:GetStat("StatusLengthOverride." .. nm) or self:GetStat("StatusLengthOverride." .. (tanim or "0"))
	sqlo = self:GetStat("SequenceLengthOverride." .. nm) or self:GetStat("SequenceLengthOverride." .. (tanim or "0"))

	if status and slo then
		sqlen = slo
	elseif sqlo then
		sqlen = sqlo
	end

	return sqlen
end

function SWEP:GetActivityLength(tanim, status, animType)
	if not self:VMIVNPC() then return 0 end
	local sqlen = self:GetActivityLengthRaw(tanim, status, animType)
	if sqlen <= 0 then return 0 end
	return sqlen / self:GetAnimationRate(tanim)
end

function SWEP:GetHolding()
	if CurTime() > last_held_check + 0.2 then
		last_held_check = CurTime()
		holding_result_cached = nil
	end

	if holding_result_cached == nil then
		holding_result_cached = false

		if not IsValid(self:GetOwner()) or not self:GetOwner():IsPlayer() then
			holding_result_cached = false

			return false
		end

		local ent = self:GetOwner():GetNW2Entity("LastHeldEntity")

		if not IsValid(ent) then
			holding_result_cached = false

			return false
		end

		if ent.IsPlayerHolding then
			ent:SetNW2Bool("PlayerHolding", ent:IsPlayerHolding())
		end

		if ent:GetNW2Bool("PlayerHolding") then
			holding_result_cached = true

			return true
		end
	end

	return holding_result_cached
end

function SWEP:CanInterruptShooting()
	return self:GetStat("Primary.RPM") > 160 and not self:GetStat("BoltAction") and not self:GetStat("BoltAction_Forced")
end

function SWEP:ReloadCV()
	if rlcv then
		if (not rlcv:GetBool()) and (not self.Primary_TFA.ClipSize_PreEdit) then
			self.Primary_TFA.ClipSize_PreEdit = self.Primary_TFA.ClipSize
			self.Primary_TFA.ClipSize = -1
			self:ClearStatCache()
		elseif rlcv:GetBool() and self.Primary_TFA.ClipSize_PreEdit then
			self.Primary_TFA.ClipSize = self.Primary_TFA.ClipSize_PreEdit
			self.Primary_TFA.ClipSize_PreEdit = nil
			self:ClearStatCache()
		end
	end
end

function SWEP:OwnerIsValid()
	if oiv == nil then
		oiv = IsValid(self:GetOwner())
	end

	return oiv
end

function SWEP:NullifyOIV()
	if oiv ~= nil then
		self:GetHolding()
		oiv = nil
	end

	return self:VMIV()
end

function SWEP:VMIVNPC()
	local ply = self:GetOwner()

	if ply:IsPlayer() then return self:VMIV() end

	if ply:IsNPC() then
		return self
	end

	return false
end

function SWEP:VMIV()
	if not IsValid(self.OwnerViewModel) then
		if IsValid(self:GetOwner()) and self:GetOwner().GetViewModel then
			self.OwnerViewModel = self:GetOwner():GetViewModel()
		end

		return false
	else
		return self.OwnerViewModel
	end
end

function SWEP:CanChamber()
	if self.C_CanChamber ~= nil then
		return self.C_CanChamber
	else
		self.C_CanChamber = not self:GetStat("BoltAction") and not self.Shotgun and not self.Revolver and not self:GetStat("DisableChambering")

		return self.C_CanChamber
	end
end

function SWEP:GetPrimaryClipSize(calc)
	local targetclip = self:GetStat("Primary.ClipSize")

	if self:CanChamber() and not (calc and self:Clip1() <= 0) then
		targetclip = targetclip + (self:GetStat("Akimbo") and 2 or 1)
	end

	return math.max(targetclip, -1)
end

function SWEP:GetPrimaryClipSizeForReload(calc)
	local targetclip = self:GetStat("Primary.ClipSize")

	if self:CanChamber() and not (calc and self:Clip1() <= 0) and not self:IsJammed() then
		targetclip = targetclip + (self:GetStat("Akimbo") and 2 or 1)
	end

	return math.max(targetclip, -1)
end

function SWEP:GetSecondaryClipSize(calc)
	local targetclip = self:GetStat("Secondary.ClipSize")

	return math.max(targetclip, -1)
end

--[[

function SWEP:GetPrimaryAmmoType()
	return self:GetStat( "Primary.Ammo" ) or ""
end

function SWEP:GetPrimaryAmmoTypeC()
	return self:GetStat( "Primary.Ammo" ) or self:GetPrimaryAmmoType()
end

function SWEP:Ammo1()
	return self:GetOwner():GetAmmoCount( self:GetPrimaryAmmoTypeC() or 0 )
end

function SWEP:GetSecondaryAmmoType()
	return self:GetStat( "Secondary.Ammo" ) or ""
end

function SWEP:GetSecondaryAmmoTypeC()
	return self:GetStat( "Secondary.Ammo" ) or self:GetSecondaryAmmoType()
end

function SWEP:Ammo2()
	return self:GetOwner():GetAmmoCount( self:GetSecondaryAmmoTypeC() or -1 )
end

]]
--
local at

function SWEP:GetPrimaryAmmoTypeC()
	at = self:GetStat("Primary.Ammo")

	if at and at ~= self.Primary_TFA.Ammo then
		return at
	elseif self.GetPrimaryAmmoTypeOld then
		return self:GetPrimaryAmmoTypeOld()
	else
		return self:GetPrimaryAmmoType()
	end
end

function SWEP:GetSecondaryAmmoTypeC()
	at = self:GetStat("Secondary.Ammo")

	if at and at ~= self.Secondary_TFA.Ammo then
		return at
	elseif self.GetSecondaryAmmoTypeOld then
		return self:GetSecondaryAmmoTypeOld()
	else
		return self:GetSecondaryAmmoType()
	end
end

function SWEP:Ammo1()
	if not self:GetOwner():IsValid() then return false end
	if self:GetOwner():IsNPC() then return 9999 end

	return self:GetOwner():GetAmmoCount(self:GetPrimaryAmmoTypeC() or 0)
end

function SWEP:Ammo2()
	if not self:GetOwner():IsValid() then return false end
	if self:GetOwner():IsNPC() then return 9999 end

	return self:GetOwner():GetAmmoCount(self:GetSecondaryAmmoTypeC() or -1)
end

function SWEP:TakePrimaryAmmo(num, pool)
	-- Doesn't use clips
	if self:GetStat("Primary.ClipSize") < 0 or pool then
		if (self:Ammo1() <= 0) then return end
		if not self:GetOwner():IsPlayer() then return end
		self:GetOwner():RemoveAmmo(math.min(self:Ammo1(), num), self:GetPrimaryAmmoTypeC())

		return
	end

	self:SetClip1(math.max(self:Clip1() - num, 0))
end

function SWEP:TakeSecondaryAmmo(num, pool)
	-- Doesn't use clips
	if self:GetStat("Secondary.ClipSize") < 0 or pool then
		if (self:Ammo2() <= 0) then return end
		if not self:GetOwner():IsPlayer() then return end
		self:GetOwner():RemoveAmmo(math.min(self:Ammo2(), num), self:GetSecondaryAmmoTypeC())

		return
	end

	self:SetClip2(math.max(self:Clip2() - num, 0))
end

SWEP.TakeAmmo1 = SWEP.TakePrimaryAmmo
SWEP.TakeAmmo2 = SWEP.TakeSecondaryAmmo

function SWEP:GetFireDelay()
	if self:GetMaxBurst() > 1 and self:GetStat("Primary.RPM_Burst") and self:GetStat("Primary.RPM_Burst") > 0 then
		return 60 / self:GetStat("Primary.RPM_Burst")
	elseif self:GetStat("Primary.RPM_Semi") and not self.Primary_TFA.Automatic and self:GetStat("Primary.RPM_Semi") and self:GetStat("Primary.RPM_Semi") > 0 then
		return 60 / self:GetStat("Primary.RPM_Semi")
	elseif self:GetStat("Primary.RPM") and self:GetStat("Primary.RPM") > 0 then
		return 60 / self:GetStat("Primary.RPM")
	else
		return self:GetStat("Primary.Delay") or 0.1
	end
end

function SWEP:GetBurstDelay(bur)
	if not bur then
		bur = self:GetMaxBurst()
	end

	if bur <= 1 then return 0 end
	if self:GetStat("Primary.BurstDelay") then return self:GetStat("Primary.BurstDelay") end

	return self:GetFireDelay() * 3
end

--[[
Function Name:  IsSafety
Syntax: self:IsSafety().
Returns:   Are we in safety firemode.
Notes:  Non.
Purpose:  Utility
]]
--
function SWEP:IsSafety()
	if not self:GetStat("FireModes") then return false end
	local fm = self:GetStat("FireModes")[self:GetFireMode()]
	local fmn = string.lower(fm and fm or self:GetStat("FireModes")[1])

	if fmn == "safe" or fmn == "holster" then
		return true
	else
		return false
	end
end

function SWEP:UpdateMuzzleAttachment()
	if not self:VMIV() then return end
	local vm = self.OwnerViewModel
	if not IsValid(vm) then return end
	self.MuzzleAttachmentRaw = nil

	if not self.MuzzleAttachmentSilenced then
		self.MuzzleAttachmentSilenced = (vm:LookupAttachment("muzzle_silenced") <= 0) and self.MuzzleAttachment or "muzzle_silenced"
	end

	if self:GetSilenced() and self.MuzzleAttachmentSilenced then
		self.MuzzleAttachmentRaw = vm:LookupAttachment(self.MuzzleAttachmentSilenced)

		if not self.MuzzleAttachmentRaw or self.MuzzleAttachmentRaw <= 0 then
			self.MuzzleAttachmentRaw = nil
		end
	end

	if not self.MuzzleAttachmentRaw and self.MuzzleAttachment then
		self.MuzzleAttachmentRaw = vm:LookupAttachment(self.MuzzleAttachment)

		if not self.MuzzleAttachmentRaw or self.MuzzleAttachmentRaw <= 0 then
			self.MuzzleAttachmentRaw = 1
		end
	end

	local mzm = self:GetStat("MuzzleAttachmentMod", 0)

	if mzm then
		if isstring(mzm) then
			self.MuzzleAttachmentRaw = vm:LookupAttachment(mzm)
		elseif mzm > 0 then
			self.MuzzleAttachmentRaw = mzm
		end
	end
end

function SWEP:UpdateConDamage()
	if not IsValid(self) then return end

	if not self.DamageConVar then
		self.DamageConVar = GetConVar("sv_tfa_damage_multiplier")
	end

	if self.DamageConVar and self.DamageConVar.GetFloat then
		self.ConDamageMultiplier = self.DamageConVar:GetFloat()
	end
end

--[[
Function Name:  IsCurrentlyScoped
Syntax: self:IsCurrentlyScoped().
Returns:   Is the player scoped in enough to display the overlay?  true/false, returns a boolean.
Notes:  Change SWEP.ScopeOverlayThreshold to change when the overlay is displayed.
Purpose:  Utility
]]
--
function SWEP:IsCurrentlyScoped()
	return (self:GetIronSightsProgress() > self:GetStat("ScopeOverlayThreshold")) and self:GetStat("Scoped")
end

--[[
Function Name:  IsHidden
Syntax: self:IsHidden().
Returns:   Should we hide self?.
Notes:
Purpose:  Utility
]]
--
function SWEP:GetHidden()
	if not self:VMIV() then return true end
	if self.DrawViewModel ~= nil and not self.DrawViewModel then return true end
	if self.ShowViewModel ~= nil and not self.ShowViewModel then return true end
	if self:GetHolding() then return true end

	return self:IsCurrentlyScoped()
end

--[[
Function Name:  IsFirstPerson
Syntax: self:IsFirstPerson().
Returns:   Is the owner in first person.
Notes:  Broken in singplayer because gary.
Purpose:  Utility
]]
--
function SWEP:IsFirstPerson()
	if not IsValid(self) or not self:OwnerIsValid() then return false end
	if self:GetOwner():IsNPC() then return false end
	if CLIENT and (not game.SinglePlayer()) and self:GetOwner() ~= GetViewEntity() then return false end
	if sp and SERVER then return not self:GetOwner().TFASDLP end
	if self:GetOwner().ShouldDrawLocalPlayer and self:GetOwner():ShouldDrawLocalPlayer() then return false end
	if LocalPlayer and hook.Call("ShouldDrawLocalPlayer", GAMEMODE, self:GetOwner()) then return false end

	return true
end

--[[
Function Name:  GetMuzzlePos
Syntax: self:GetMuzzlePos( hacky workaround that doesn't work anyways ).
Returns:   The AngPos for the muzzle attachment.
Notes:  Defaults to the first attachment, and uses GetFPMuzzleAttachment
Purpose:  Utility
]]
--
local fp

function SWEP:GetMuzzleAttachment()
	local vmod = self.OwnerViewModel
	local att = math.max(1, self.MuzzleAttachmentRaw or (sp and vmod or self):LookupAttachment(self.MuzzleAttachment))

	if self:GetStat("Akimbo") then
		att = 1 + self:GetAnimCycle()
	end

	return att
end

function SWEP:GetMuzzlePos(ignorepos)
	fp = self:IsFirstPerson()
	local vm = self.OwnerViewModel

	if not IsValid(vm) then
		vm = self
	end

	-- Avoid returning strings inside MuzzleAttachmentMod, since this would decrease performance
	-- Better call :UpdateMuzzleAttachment() or return number in MuzzleAttachmentMod
	local obj = self:GetStat("MuzzleAttachmentMod") or self.MuzzleAttachmentRaw or vm:LookupAttachment(self.MuzzleAttachment)

	if type(obj) == "string" then
		obj = tonumber(obj) or vm:LookupAttachment(obj)
	end

	local muzzlepos
	obj = math.Clamp(obj or 1, 1, 128)

	if fp then
		muzzlepos = vm:GetAttachment(obj)
	else
		muzzlepos = self:GetAttachment(obj)
	end

	return muzzlepos
end

function SWEP:FindEvenBurstNumber()
	local burstOverride = self:GetStat("BurstFireCount")

	if burstOverride then
		return burstOverride
	end

	if (self:GetStat("Primary.ClipSize") % 3 == 0) then
		return 3
	elseif (self:GetStat("Primary.ClipSize") % 2 == 0) then
		return 2
	else
		local i = 4

		while i <= 7 do
			if self:GetStat("Primary.ClipSize") % i == 0 then return i end
			i = i + 1
		end
	end

	return nil
end

function SWEP:GetFireModeName()
	local fm = self:GetFireMode()
	local fmn = string.lower(self:GetStat("FireModes")[fm])
	if fmn == "safe" or fmn == "holster" then return language.GetPhrase("tfa.firemode.safe") end
	if self:GetStat("FireModeName") then return language.GetPhrase(self:GetStat("FireModeName")) end
	if fmn == "auto" or fmn == "automatic" then return language.GetPhrase("tfa.firemode.auto") end

	if fmn == "semi" or fmn == "single" then
		if self:GetStat("Revolver") then
			if (self:GetStat("BoltAction")) then
				return language.GetPhrase("tfa.firemode.single")
			else
				return language.GetPhrase("tfa.firemode.revolver")
			end
		else
			if (self:GetStat("BoltAction")) then
				return language.GetPhrase("tfa.firemode.bolt")
			else
				if (self.Shotgun and self:GetStat("Primary.RPM") < 250) then
					return language.GetPhrase("tfa.firemode.pump")
				else
					return language.GetPhrase("tfa.firemode.semi")
				end
			end
		end
	end

	local bpos = string.find(fmn, "burst")
	if bpos then return language.GetPhrase("tfa.firemode.burst"):format(string.sub(fmn, 1, bpos - 1)) end

	return ""
end

SWEP.BurstCountCache = {}

function SWEP:GetMaxBurst()
	local fm = self:GetFireMode()

	if not self.BurstCountCache[fm] then
		local fmt = self:GetStat("FireModes")
		local fmn = string.lower(fmt[fm])
		local bpos = string.find(fmn, "burst")

		if bpos then
			self.BurstCountCache[fm] = tonumber(string.sub(fmn, 1, bpos - 1))
		else
			self.BurstCountCache[fm] = 1
		end
	end

	return self.BurstCountCache[fm]
end

--[[
Function Name:  CycleFireMode
Syntax: self:CycleFireMode()
Returns:  Nothing.
Notes: Cycles to next firemode.
Purpose:  Feature
]]
--
local l_CT = CurTime

SWEP.FireModesAutomatic = {
	["Automatic"] = true,
	["Auto"] = true,
}

SWEP.FireModeSound = Sound("Weapon_AR2.Empty") -- firemode toggle sound

function SWEP:CycleFireMode()
	local ct = l_CT()
	local fm = self:GetFireMode()
	fm = fm + 1

	if fm >= #self:GetStat("FireModes") then
		fm = 1
	end

	self:SetFireMode(fm)
	local success, tanim, ttype = self:ChooseROFAnim()

	if success then
		self:SetNextPrimaryFire(ct + self:GetActivityLength(tanim, false, ttype))
	else
		self:EmitSound(self:GetStat("FireModeSound"))
		self:SetNextPrimaryFire(ct + math.max(self:GetFireDelay(), 0.25))
	end

	self.BurstCount = 0
	self:SetIsCyclingSafety(false)
	self:SetStatus(TFA.Enum.STATUS_FIREMODE, self:GetNextPrimaryFire())

	self.Primary.Automatic = self:GetStat("FireModesAutomatic." .. self:GetStat("FireModes." .. fm)) ~= nil
	self.Primary_TFA.Automatic =self.Primary.Automatic
end

--[[
Function Name:  CycleSafety
Syntax: self:CycleSafety()
Returns:  Nothing.
Notes: Toggles safety
Purpose:  Feature
]]
--
function SWEP:CycleSafety()
	local ct = l_CT()
	local fm = self:GetFireMode()
	local fmt = self:GetStat("FireModes")

	self.BurstCount = 0
	self:SetIsCyclingSafety(true)

	if fm ~= #fmt then
		self.LastFireMode = fm
		self:SetFireMode(#fmt)
	else
		self:SetFireMode(self.LastFireMode or 1)
	end

	local success, tanim, ttype = self:ChooseROFAnim()

	if success then
		self:SetSafetyCycleAnimated(true)
		self:SetNextPrimaryFire(ct + self:GetActivityLength(tanim, false, ttype))
	else
		self:SetSafetyCycleAnimated(false)
		self:EmitSound(self:GetStat("FireModeSound"))
		self:SetNextPrimaryFire(ct + math.max(self:GetFireDelay(), 0.25))
	end

	self:SetStatus(TFA.Enum.STATUS_FIREMODE, self:GetNextPrimaryFire())
end

--[[
Function Name:  1FireMode
Syntax: self:ProcessFireMode()
Returns:  Nothing.
Notes: Processes fire mode changing and whether the swep is auto or not.
Purpose:  Feature
]]
--
function SWEP:ProcessFireMode()
	if self:GetOwner():IsNPC() then return end

	if self:GetOwner().GetInfoNum and self:GetOwner():GetInfoNum("cl_tfa_keys_firemode", 0) > 0 then
		return
	end

	if self:OwnerIsValid() and self:KeyPressed(IN_RELOAD) and self:KeyDown(IN_USE) and self:GetStatus() == TFA.Enum.STATUS_IDLE and (SERVER or not sp) then
		if self:GetStat("SelectiveFire") and not self:KeyDown(IN_SPEED) then
			self:CycleFireMode()
		elseif self:GetOwner():KeyDown(IN_SPEED) then
			self:CycleSafety()
		end
	end
end

--[[
Function Name:  Unload
Syntax: self:Unload()
Returns:  Nothing.
Notes: Returns Clip1 ammo to reserve.
Purpose:  Utility
]]
--
function SWEP:Unload()
	local amm = self:Clip1()
	self:SetClip1(0)

	if self.OwnerIsValid and self:OwnerIsValid() and self.Owner.GiveAmmo then
		self:GetOwner():GiveAmmo(amm, self:GetPrimaryAmmoType(), true)
	end
end

--[[
Function Name:  Unload
Syntax: self:Unload()
Returns:  Nothing.
Notes: Returns Clip1 ammo to reserve.
Purpose:  Utility
]]
--
function SWEP:Unload2()
	local amm = self:Clip2()
	self:SetClip2(0)

	if self.OwnerIsValid and self:OwnerIsValid() and self.Owner.GiveAmmo then
		self:GetOwner():GiveAmmo(amm, self:GetSecondaryAmmoType(), true)
	end
end

local penetration_hitmarker_cvar = GetConVar("sv_tfa_penetration_hitmarker")

function SWEP:SendHitMarker(ply, traceres, dmginfo)
	if CLIENT or not penetration_hitmarker_cvar:GetBool() then return end
	if not IsValid(ply) or not ply:IsPlayer() then return end

	local hm3d = ply:GetInfoNum("cl_tfa_hud_hitmarker_3d_all", 0) > 0
	local hm3d_sg = ply:GetInfoNum("cl_tfa_hud_hitmarker_3d_shotguns", 0) > 0 and self:GetStat("Primary.NumShots") > 1

	if hm3d or hm3d_sg then
		net.Start("tfaHitmarker3D", true)
		net.WriteVector(traceres.HitPos)
		net.Send(ply)
	else
		net.Start("tfaHitmarker", true)
		net.Send(ply)
	end
end

SWEP.VMSeqCache = {}
local vm -- are you fucking kidding me

function SWEP:CheckVMSequence(seqname)
	if not IsValid(self) then return false end
	vm = self.OwnerViewModel
	if not IsValid(vm) then return false end
	local mdl = vm:GetModel()
	if not mdl then return false end
	self.VMSeqCache[mdl] = self.VMSeqCache[mdl] or {}

	if self.VMSeqCache[mdl][seqname] == nil then
		self.VMSeqCache[mdl][seqname] = vm:LookupSequence(seqname) >= 0
	end

	return self.VMSeqCache[mdl][seqname]
end

do
	local function sorter(a, b)
		return a.range < b.range
	end

	local function linear(a) return a end

	function SWEP:BuildFalloffTable(input, step)
		if step == nil then step = TFA.RangeFalloffLUTStep end

		table.sort(input.lut, sorter)

		if input.lut[1].range > 0 then
			for i = #input.lut, 1, -1 do
				input.lut[i + 1] = input.lut[i]
			end

			input.lut[1] = {range = 0, damage = 1}
		end

		local div = (input.units == "hammer" or input.units == "inches" or input.units == "inch" or input.units == "hu") and 1 or 0.0254

		local build = {}
		local minimal = input.lut[1].range
		local maximal = input.lut[#input.lut].range

		local fnrange = isfunction(input.range_func) and input.range_func or
			input.range_func == "quintic" and TFA.Quintic or
			input.range_func == "cubic" and TFA.Cubic or
			input.range_func == "cosine" and TFA.Cosine or
			input.range_func == "sinusine" and TFA.Sinusine or
			linear

		if input.bezier then
			local build_range = {}
			local build_damage = {}

			for _, data in ipairs(input.lut) do
				table.insert(build_range, data.range / div)
				table.insert(build_damage, data.damage)
			end

			for i = 0, 1, step do
				local value = fnrange(i)
				table.insert(build, {TFA.tbezier(value, build_range), TFA.tbezier(value, build_damage)})
			end
		else
			local current, next = input.lut[1], input.lut[2]
			local nextindex = 1

			for i = 0, 1, step do
				local value = fnrange(i)
				local interp = Lerp(value, minimal, maximal)

				if next.range < interp then
					nextindex = nextindex + 1
					current, next = input.lut[nextindex], input.lut[nextindex + 1]
				end

				if not current or not next then break end -- safeguard
				table.insert(build, {interp / div, Lerp(1 - (next.range - interp) / (next.range - current.range), current.damage, next.damage)})
			end
		end

		return build
	end
end

function SWEP:IncreaseRecoilLUT()
	if not self:HasRecoilLUT() then return end

	local self2 = self:GetTable()
	local time = CurTime()

	if not self:GetRecoilThink() then
		self:SetRecoilThink(true)
	end

	if not self:GetRecoilLoop() then
		local newvalue = self:GetRecoilInProgress() + self2.Primary_TFA.RecoilLUT["in"].increase

		self:SetRecoilInProgress(math.min(1, newvalue))

		self:SetRecoilInWait(time + self2.Primary_TFA.RecoilLUT["in"].wait)

		if self:GetRecoilInProgress() >= 1 then
			self:SetRecoilLoop(true)
			self:SetRecoilLoopProgress(math.Clamp(newvalue % 1, 0, 1))
			self:SetRecoilLoopWait(time + self2.Primary_TFA.RecoilLUT["loop"].wait)
		end

		return
	end

	local sub = 0

	if self:GetRecoilOutProgress() ~= 0 then
		local prev = self:GetRecoilOutProgress()
		local newvalue = math.max(0, prev - self2.Primary_TFA.RecoilLUT["out"].increase)
		self:SetRecoilOutProgress(newvalue)
		self:SetRecoilLoopWait(time + self2.Primary_TFA.RecoilLUT["loop"].wait)

		if newvalue ~= 0 then
			return
		end

		sub = self2.Primary_TFA.RecoilLUT["out"].increase - prev
	end

	local newvalue = (self:GetRecoilLoopProgress() + self2.Primary_TFA.RecoilLUT["loop"].increase + sub) % 1
	self:SetRecoilLoopProgress(newvalue)
	self:SetRecoilLoopWait(time + self2.Primary_TFA.RecoilLUT["loop"].wait)
end

function SWEP:HasRecoilLUT()
	return self.Primary_TFA.RecoilLUT ~= nil
end

do
	local function linear(a) return a end

	local function getfn(input)
		return isfunction(input.func) and input.func or
			input.func == "quintic" and TFA.Quintic or
			input.func == "cubic" and TFA.Cubic or
			input.func == "cosine" and TFA.Cosine or
			input.func == "sinusine" and TFA.Sinusine or
			linear
	end

	function SWEP:GetRecoilLUTAngle()
		if not self:GetRecoilThink() then
			return Angle()
		end

		local self2 = self:GetTable()
		local isp = 1 - self:GetIronSightsProgress() * self2.GetStat(self, "Primary.RecoilLUT_IronSightsMult")

		if not self:GetRecoilLoop() then
			-- currently, we only playing IN animation

			local t = getfn(self2.Primary_TFA.RecoilLUT["in"])(self:GetRecoilInProgress())

			local pitch = TFA.tbezier(t, self2.Primary_TFA.RecoilLUT["in"].points_p)
			local yaw = TFA.tbezier(t, self2.Primary_TFA.RecoilLUT["in"].points_y)

			return Angle(pitch * isp, yaw * isp)
		end

		local out = getfn(self2.Primary_TFA.RecoilLUT["out"])(self:GetRecoilOutProgress())
		local loop = getfn(self2.Primary_TFA.RecoilLUT["loop"])(self:GetRecoilLoopProgress())

		local pitch = TFA.tbezier(loop, self2.Primary_TFA.RecoilLUT["loop"].points_p)
		local yaw = TFA.tbezier(loop, self2.Primary_TFA.RecoilLUT["loop"].points_y)

		if out ~= 0 then
			-- cooling out
			self2.Primary_TFA.RecoilLUT["out"].points_p[1] = pitch
			self2.Primary_TFA.RecoilLUT["out"].points_y[1] = yaw

			local pitch2 = TFA.tbezier(out, self2.Primary_TFA.RecoilLUT["out"].points_p)
			local yaw2 = TFA.tbezier(out, self2.Primary_TFA.RecoilLUT["out"].points_y)

			return Angle(pitch2 * isp, yaw2 * isp)
		end

		return Angle(pitch * isp, yaw * isp)
	end
end

local sv_tfa_recoil_legacy = GetConVar("sv_tfa_recoil_legacy")

function SWEP:GetAimVector()
	return self:GetAimAngle():Forward()
end

function SWEP:GetAimAngle()
	local ang = self:GetOwner():GetAimVector():Angle()

	if sv_tfa_recoil_legacy:GetBool() and self:GetOwner():IsPlayer() then
		ang:Add(self:GetOwner():GetViewPunchAngles())
	elseif self:HasRecoilLUT() then
		ang:Add(self:GetRecoilLUTAngle())
	else
		ang.p = ang.p + self:GetViewPunchP()
		ang.y = ang.y + self:GetViewPunchY()
	end

	ang:Normalize()
	return ang
end

function SWEP:EmitSoundNet(sound, ifp)
	if ifp == nil then ifp = IsFirstTimePredicted() end
	if not ifp then return end

	if CLIENT and sp then return end

	if CLIENT or sp then
		self:EmitSound(sound)
		return
	end

	local filter = RecipientFilter()

	filter:AddPAS(self:GetPos())

	if IsValid(self:GetOwner()) and self:GetOwner():IsPlayer() then
		filter:RemovePlayer(self:GetOwner())
	end

	if filter:GetCount() == 0 then return end

	net.Start("tfaSoundEvent", true)
	net.WriteEntity(self)
	net.WriteString(sound)
	net.Send(filter)
end

function SWEP:StopSoundNet(sound, ifp)
	if ifp == nil then ifp = IsFirstTimePredicted() end
	if not ifp then return end

	if CLIENT and sp then return end

	if CLIENT or sp then
		self:StopSound(sound)
		return
	end

	local filter = RecipientFilter()

	filter:AddPAS(self:GetPos())

	if IsValid(self:GetOwner()) and self:GetOwner():IsPlayer() then
		filter:RemovePlayer(self:GetOwner())
	end

	if filter:GetCount() == 0 then return end

	net.Start("tfaSoundEventStop", true)
	net.WriteEntity(self)
	net.WriteString(sound)
	net.Send(filter)
end
