AddCSLuaFile()

if CLIENT then
    SWEP.PrintName = "Отмычка"
    SWEP.Slot = 5
    SWEP.SlotPos = 1
    SWEP.DrawAmmo = false
    SWEP.DrawCrosshair = false
end

-- Variables that are used on both client and server

SWEP.Author = "Kirussell"
SWEP.Instructions = "ЛКМ - начать взлом"
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.IsDarkRPLockpick = true

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.ViewModel = Model("models/weapons/c_crowbar.mdl")
SWEP.WorldModel = Model("models/weapons/w_crowbar.mdl")

SWEP.UseHands = true

SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.Category = "Other"
SWEP.Sound = Sound("physics/wood/wood_box_impact_hard3.wav")

SWEP.Primary.ClipSize = -1      -- Size of a clip
SWEP.Primary.DefaultClip = 0        -- Default number of bullets in a clip
SWEP.Primary.Automatic = false      -- Automatic/Semi Auto
SWEP.Primary.Ammo = ""

SWEP.Secondary.ClipSize = -1        -- Size of a clip
SWEP.Secondary.DefaultClip = -1     -- Default number of bullets in a clip
SWEP.Secondary.Automatic = false        -- Automatic/Semi Auto
SWEP.Secondary.Ammo = ""

function SWEP:SetupDataTables()
    self:NetworkVar("Bool", 0, "IsLockpicking")
    self:NetworkVar("Float", 0, "LockpickStartTime")
    self:NetworkVar("Float", 1, "LockpickEndTime")
    self:NetworkVar("Float", 2, "NextSoundTime")
    self:NetworkVar("Int", 0, "TotalLockpicks")
    self:NetworkVar("Entity", 0, "LockpickEnt")
end

function SWEP:Initialize()
    self:SetHoldType("normal")
end

function SWEP:PrimaryAttack()
    self:SetNextPrimaryFire(CurTime() + 0.5)
    if self:GetIsLockpicking() then return end

    self:GetOwner():LagCompensation(true)
    local trace = self:GetOwner():GetEyeTrace()
    self:GetOwner():LagCompensation(false)
    local ent = trace.Entity

    if not IsValid(ent) then return end
    if ent:IsPlayer() and not ent:IsHandcuffed() then return end

    local canLockpick = hook.Call("canLockpick", nil, self:GetOwner(), ent, trace)

    if canLockpick == false then return end
    if canLockpick ~= true and (
            trace.HitPos:DistToSqr(self:GetOwner():GetShootPos()) > 10000 or
            (not ent:IsVehicle() and not string.find(string.lower(ent:GetClass()), "vehicle") and (not ent.isFadingDoor) and (not ent:GetClass() == "prop_door_rotating"))
        ) then
        return
    end

    self:SetHoldType("pistol")

    self:SetIsLockpicking(true)
    self:SetLockpickEnt(ent)
    self:SetLockpickStartTime(CurTime())
    local endDelta = hook.Call("lockpickTime", nil, self:GetOwner(), ent) or util.SharedRandom("DarkRP_Lockpick" .. self:EntIndex() .. "_" .. self:GetTotalLockpicks(), 20, 40)
    self:SetLockpickEndTime(CurTime() + endDelta)
    self:SetTotalLockpicks(self:GetTotalLockpicks() + 1)


    if IsFirstTimePredicted() then
        hook.Call("lockpickStarted", nil, self:GetOwner(), ent, trace)
    end

    if CLIENT then
        self.Dots = ""
        self.NextDotsTime = SysTime() + 0.5
        return
    end

    local onFail = function(ply) if ply == self:GetOwner() then hook.Call("onLockpickCompleted", nil, ply, false, ent) end end

    -- Lockpick fails when dying or disconnecting
    hook.Add("PlayerDeath", self, fc{onFail, fn.Flip(fn.Const)})
    hook.Add("PlayerDisconnected", self, fc{onFail, fn.Flip(fn.Const)})
    -- Remove hooks when finished
    hook.Add("onLockpickCompleted", self, fc{fp{hook.Remove, "PlayerDisconnected", self}, fp{hook.Remove, "PlayerDeath", self}})
end

function SWEP:Holster()
    self:SetIsLockpicking(false)
    self:SetLockpickEnt(nil)
    return true
end

function SWEP:Succeed()
    self:SetHoldType("normal")

    local ent = self:GetLockpickEnt()
    self:SetIsLockpicking(false)
    self:SetLockpickEnt(nil)

    if not IsValid(ent) then return end

    local override = hook.Call("onLockpickCompleted", nil, self:GetOwner(), true, ent)

    if override then return end

    if ent.isFadingDoor and ent.fadeActivate and not ent.fadeActive then
        ent:fadeActivate()
        if IsFirstTimePredicted() then timer.Simple(5, function() if IsValid(ent) and ent.fadeActive then ent:fadeDeactivate() end end) end
    elseif ent:IsPlayer() and ent:IsHandcuffed() then 
        if SERVER then
            local wep = ent:GetActiveWeapon()
            if wep:GetClass() == "weapon_handcuffed" then
                wep:Break()
                ent:EmitSound(Sound("weapons/crowbar/crowbar_impact1.wav"))
            end      
        end
    elseif ent.Fire then
        ent.Locked = false
        ent:Fire("Unlock")
        ent:Fire("open", "", .6)
        ent:Fire("setanimation", "open", .6)
    end
end

function SWEP:Fail()
    self:SetIsLockpicking(false)
    self:SetHoldType("normal")

    hook.Call("onLockpickCompleted", nil, self:GetOwner(), false, self:GetLockpickEnt())
    self:SetLockpickEnt(nil)
end

local dots = {
    [0] = ".",
    [1] = "..",
    [2] = "...",
    [3] = ""
}
function SWEP:Think()
    if not self:GetIsLockpicking() or self:GetLockpickEndTime() == 0 then return end

    if CurTime() >= self:GetNextSoundTime() then
        self:SetNextSoundTime(CurTime() + 1)
        local snd = {1,3,4}
        self:EmitSound("weapons/357/357_reload" .. tostring(snd[math.Round(util.SharedRandom("DarkRP_LockpickSnd" .. CurTime(), 1, #snd))]) .. ".wav", 50, 100)
    end
    if CLIENT and (not self.NextDotsTime or SysTime() >= self.NextDotsTime) then
        self.NextDotsTime = SysTime() + 0.5
        self.Dots = self.Dots or ""
        local len = string.len(self.Dots)

        self.Dots = dots[len]
    end

    local trace = self:GetOwner():GetEyeTrace()
    if not IsValid(trace.Entity) or trace.Entity ~= self:GetLockpickEnt() or trace.HitPos:DistToSqr(self:GetOwner():GetShootPos()) > 10000 then
        self:Fail()
    elseif self:GetLockpickEndTime() <= CurTime() then
        self:Succeed()
    end
end

function SWEP:DrawHUD()
  if not self:GetIsLockpicking() or self:GetLockpickEndTime() == 0 then return end
  self.Dots = self.Dots or ""
  
  local w, h = 400, 50
  local scr_w, scr_h = ScrW(), ScrH()
  local starttime = self:GetLockpickStartTime()
  local endtime = self:GetLockpickEndTime()

  local time = endtime - starttime
  local status = (CurTime() - starttime)/time
  TimeLerp = Lerp(FrameTime() / 1.7, (CurTime()-starttime)/(endtime-starttime)*360, 0)
  ColorLerp = Lerp(FrameTime() / 1.7, (CurTime()-starttime)/(endtime-starttime)*220, 0)
  local ColorPerc = Color(255-(TimeLerp),TimeLerp*3,0)
  local color = ColorAlpha(color_white, ColorLerp)
  draw.OctopusArc({x=scr_w/2, y=scr_h/1.8},360,TimeLerp,30,360,5, color)
  draw.ShadowSimpleText("Взламываю"..self.Dots, "font_base_18", scr_w/2, scr_h/1.65, color, 1, 1)
end

function SWEP:SecondaryAttack()
    self:PrimaryAttack()
end
