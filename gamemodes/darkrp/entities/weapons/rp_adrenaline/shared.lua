sound.Add({
    name = "syringe.slide",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = SNDLVL_NORM,
    sound = "weapons/syringe_slide.wav"
})

sound.Add({
    name = "syringe.click",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = SNDLVL_NORM,
    sound = "weapons/syringe_click.wav"
})

sound.Add({
    name = "syringe.inject",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = SNDLVL_GUNFIRE,
    sound = "weapons/syringe_inject.wav"
})

if SERVER then
    AddCSLuaFile("shared.lua")
    SWEP.Weight = 5
    SWEP.AutoSwitchTo = true
    SWEP.AutoSwitchFrom = true
end

if CLIENT then
    SWEP.DrawAmmo = true
    SWEP.DrawCrosshair = false
    SWEP.ViewModelFOV = 70
    SWEP.UseHands = true

    SWEP.PrintName = "Medical Syringe"
    SWEP.DrawWeaponInfoBox = false
    SWEP.BounceWeaponIcon = false
    SWEP.Slot = 5
    SWEP.SlotPos = 2

    SWEP.WepSelectIcon = surface.GetTextureID( "vgui/hud/weapon_darky_syringe" )
    SWEP.DrawWeaponInfoBox	= false
    SWEP.BounceWeaponIcon = false 
end

SWEP.Spawnable = true
SWEP.AdminSpawnable = false
SWEP.Category = ""

SWEP.ViewModel = "models/weapons/darky_m/c_imsyringe.mdl"
SWEP.WorldModel = "models/weapons/darky_m/w_imsyringe.mdl"
SWEP.HoldType = "grenade"

SWEP.HealAmount = 15
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "Syringes"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.Next = CurTime()
SWEP.Primed = 0
SWEP.HoldType = "slam"

function SWEP:Deploy()
    self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
    timer.Create("weapon_" .. self:EntIndex(), 1.8, 1,
        function() self.Weapon:SendWeaponAnim(ACT_VM_IDLE) end)
    return true
end

function SWEP:Initialize() self:SetWeaponHoldType(self.HoldType) end

function SWEP:PrimaryAttack()
    if self.Owner:Health() < self.Owner:GetMaxHealth()  and  self.Next < CurTime() and self.Primed == 0  then
        self.Owner:DoAnimationEvent(ACT_HL2MP_GESTURE_RELOAD_PISTOL)
        if CLIENT then
            self:SendWeaponAnim(ACT_RELOAD)
        end
        self.Owner:SetAnimation(PLAYER_RELOAD)
        timer.Create("inject" .. self:EntIndex(), 0.4, 1, function()
            if IsValid(self) and SERVER then
                self.Owner:EmitSound( "syringe.inject" )
            end
        end)
    end

    if (CLIENT) then return end

    if self.Next < CurTime() and self.Primed == 0 and
            self.Owner:GetAmmoCount(self.Primary.Ammo) > 0 then
            local ent = self.Owner

            local need = self.HealAmount
            if IsValid(ent) then
                need = math.min(ent:GetMaxHealth() - ent:Health(), self.HealAmount)
            end

            if IsValid(ent) and ent:Health() < ent:GetMaxHealth() then
                timer.Create("weapon_" .. self:EntIndex(), 1.5, 1, function()
                    ent:SetHealth(math.min(ent:GetMaxHealth(), ent:Health() + need))
                    self.Owner:RemoveAmmo(1, self.Primary.Ammo)
                    ent.SyringeRegen = (ent.SyringeRegen and ent.SyringeRegen or 0) + math.min(ent:GetMaxHealth()-ent:Health(), (ent.SyringeRegen and ent.SyringeRegen or 0) + 20)
                    ent.LastSyringeRegen = CurTime()
                end)
                self.Next = CurTime() + 2.3
                self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
                self.Primed = 1
            end
        end
end

function SWEP:SecondaryAttack()

    if (CLIENT) then return end
    if self.Next < CurTime() and self.Primed == 0 and
        self.Owner:GetAmmoCount(self.Primary.Ammo) > 0 then
        if self.Owner:IsPlayer() then self.Owner:LagCompensation(true) end

        local tr = util.TraceLine({
            start = self.Owner:GetShootPos(),
            endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 64,
            filter = self.Owner
        })

        if self.Owner:IsPlayer() then self.Owner:LagCompensation(false) end

        local ent = tr.Entity
        local need = self.HealAmount
        if IsValid(ent) then
            need = math.min(ent:GetMaxHealth() - ent:Health(), self.HealAmount)
        end

        if IsValid(ent) and ent:IsPlayer() or ent:IsNPC() and ent:Health() <
            ent:GetMaxHealth() then
            timer.Create("inject" .. self:EntIndex(), 0.4, 1, function()
                self:EmitSound("syringe.inject")
                self.Owner:DoAnimationEvent(ACT_GMOD_GESTURE_MELEE_SHOVE_1HAND)
            end)

            timer.Create("weapon_" .. self:EntIndex(), 2.7, 1, function()
                x1, y1 = self.Owner:GetPos().x, self.Owner:GetPos().y
                x2, y2 = ent:GetPos().x, ent:GetPos().y
                if IsValid(self) and math.Distance(x1, y1, x2, y2) < 100 then
                    ent:SetHealth(math.min(ent:GetMaxHealth(),
                                           ent:Health() + need))
                    self.Owner:RemoveAmmo(1, self.Primary.Ammo)
                    ent.SyringeRegen = (ent.SyringeRegen and ent.SyringeRegen or 0) + 20
                    ent.LastSyringeRegen = CurTime()
                end
            end)

            self:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
            self.Next = CurTime() + 2.7
            self.Primed = 1
        end
    end
end

function SWEP:Think()
    if self.Next < CurTime() then
        if self.Primed == 1 then
            self.Primed = 2
            self.Next = CurTime() + .3
        elseif self.Primed == 2 then
            self.Primed = 0
            self.Next = CurTime() + 1.8
            if SERVER then
                if self.Owner:GetAmmoCount(self.Primary.Ammo) > 0 then
                    self.Weapon:SendWeaponAnim(ACT_VM_FIDGET)
                else
                    self.Owner:StripWeapon("darky_syringe")
                end
            end
        end
    end
end

function SWEP:Holster()
    if SERVER and self.Primed == 0 then
        self.Next = CurTime()
        self.Primed = 0
        if SERVER then timer.Remove("weapon_" .. self:EntIndex()) end
        return true
    end
    return false
end
function SWEP:OnRemove()
    if SERVER then timer.Remove("weapon_" .. self:EntIndex()) end
end
function SWEP:OnDrop()
    if SERVER then timer.Remove("weapon_" .. self:EntIndex()) end
end
