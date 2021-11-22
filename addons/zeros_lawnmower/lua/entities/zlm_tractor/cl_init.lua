include("shared.lua")


function ENT:Initialize()
    self.ss_Speed = 0

    self.unload_pp = 0
    self.bladespin_pp = 0
    self.motor_pp = 0

    self.unload_effect = false
    self.cutting_effect = false

    self.StorageIsFilling = false
    self.LastStorageValue = -1
    self.LastStorageCheck = -1

    self.IsRunning = false
    self.IsMowing = false
    self.IsUnloading = false
    self.GrassStorage = 0
    self.VehicleEnt = nil
    self.VCFuel = 0
end

function ENT:Think()
    if zlm.f.InDistance(self:GetPos(), LocalPlayer():GetPos(), GetConVar("zlm_cl_vfx_updatedistance"):GetFloat()) then
        self:CatchNetVar()
        self:CalculateSpeed()
        self:DriveSound()
        self:CuttingSound()
        self:CuttingGrassSound()
        self:AnimationHandle()
    end
    self:SetNextClientThink(CurTime())
    return true
end

function ENT:CatchNetVar()
    self.VehicleEnt = self:GetVehicleEnt()
    self.IsRunning = self:GetIsRunning()
    self.IsMowing = self:GetIsMowing()
    self.IsUnloading = self:GetIsUnloading()
    self.GrassStorage = self:GetGrassStorage()
    self.HasCorb = self:GetHasCorb()
    self.HasTrailer = self:GetHasTrailer()
    if zlm.config.VCMod and IsValid(self.VehicleEnt) then
        self.VCFuel = self.VehicleEnt:VC_fuelGet(true)
    end
end

function ENT:Draw()
    if zlm.f.InDistance(self:GetPos(), LocalPlayer():GetPos(), 100) then
        self:ScreenUI()
    end
end

function ENT:ScreenUI()

    if not self.IsRunning then return end

    if not IsValid(self.VehicleEnt) then return end
    if self.VehicleEnt:GetModel() == nil then return end

    local attach = self.VehicleEnt:GetAttachment(self.VehicleEnt:LookupAttachment("screen_attach"))

    if attach == nil then return end

    local Ang = attach.Ang
    Ang:RotateAroundAxis(attach.Ang:Forward(), 90)
    Ang:RotateAroundAxis(attach.Ang:Right(), 180)

    local Pos = attach.Pos + attach.Ang:Up() * 0.05

    cam.Start3D2D(Pos, Ang, 0.05)

        draw.RoundedBox(1, -70, -110, 140, 220, zlm.default_colors["grey02"])

        local connect_info = "[ " .. string.upper(language.GetPhrase(input.GetKeyName(zlm.config.LawnMower.Keys.Connect))) .. " ]"
        draw.DrawText(connect_info, "zlm_display_font01", 5, -90, zlm.default_colors["white01"], TEXT_ALIGN_LEFT)

        surface.SetDrawColor(zlm.default_colors["white01"])
        surface.SetMaterial(zlm.default_materials["connect"])
        surface.DrawTexturedRect(-60, -105, 50, 50)
        draw.NoTexture()

        if self.HasCorb then


            local info = "[ " .. string.upper(language.GetPhrase(input.GetKeyName(zlm.config.LawnMower.Keys.StartBlades))) .. " ]"
            draw.DrawText(info, "zlm_display_font01", 5, -58, zlm.default_colors["white01"], TEXT_ALIGN_LEFT)

            if self.IsMowing then
                surface.SetDrawColor(zlm.default_colors["green03"])
            else
                surface.SetDrawColor(zlm.default_colors["white01"])
            end
            surface.SetMaterial(zlm.default_materials["blades"])
            surface.DrawTexturedRect(-58, -62, 40, 40)
            draw.NoTexture()


            local u_info = "[ " .. string.upper(language.GetPhrase(input.GetKeyName(zlm.config.LawnMower.Keys.Unload))) .. " ]"
            draw.DrawText(u_info, "zlm_display_font01", 5, -22, zlm.default_colors["white01"], TEXT_ALIGN_LEFT)


            if self.IsUnloading then
                surface.SetDrawColor(zlm.default_colors["green03"])
            else
                surface.SetDrawColor(zlm.default_colors["white01"])
            end
            surface.SetMaterial(zlm.default_materials["unload"])
            surface.DrawTexturedRect(-58, -22, 40, 40)
            draw.NoTexture()



            surface.SetDrawColor(zlm.default_colors["grey03"])
        	surface.SetMaterial(zlm.default_materials["corb_bg"])
        	surface.DrawTexturedRect(-70, -20, 140, 140)
        	draw.NoTexture()

            local height = (-60 / zlm.config.LawnMower.StorageCapacity) * self.GrassStorage
            local bColor
            if self.GrassStorage >= zlm.config.LawnMower.StorageCapacity then
                bColor =  zlm.default_colors["red02"]
            else
                bColor =  zlm.default_colors["green03"]
            end
            draw.RoundedBox(0, -36, 88, 60, height, bColor)

            surface.SetDrawColor(zlm.default_colors["grey04"])
        	surface.SetMaterial(zlm.default_materials["corb_fg"])
        	surface.DrawTexturedRect(-70, -20, 140, 140)
        	draw.NoTexture()

            draw.DrawText(self.GrassStorage .. zlm.config.UoW, "zlm_display_font01", -5, 50, zlm.default_colors["white03"], TEXT_ALIGN_CENTER)

        elseif self.HasTrailer then

            local info = zlm.config.Currency .. ": [ " .. string.upper(language.GetPhrase(input.GetKeyName(zlm.config.LawnMower.Keys.Unload))) .. " ]"
            draw.DrawText(info, "zlm_display_font01", -65, -55, zlm.default_colors["white01"], TEXT_ALIGN_LEFT)

        end
    cam.End3D2D()
end

function ENT:CalculateSpeed()
    if IsValid(self.VehicleEnt) then
        local speed = math.floor(self.VehicleEnt:GetVelocity():Length() * 0.0568188)
        self.ss_Speed = speed
    else
        self.ss_Speed = 1
    end
end

function ENT:DriveSound()

    -- If vcmod is installed and we dont have any fuel left then we stop the motor sound
    if zlm.config.VCMod and self.VCFuel <= 0 then

        if self.SoundObj and self.SoundObj:IsPlaying() == true then
            self.SoundObj:Stop()
            self:EmitSound("zlm_tractor_engine_stop")
        end
        return
    end


    local MoveSound = CreateSound(self, "zlm_tractor_engine_idle")

    if self.IsRunning then

        if self.SoundObj == nil then
            self.SoundObj = MoveSound
        end

        if self.SoundObj:IsPlaying() == false then
            self.SoundObj:Play()
            self.SoundObj:ChangeVolume(0, 0)
            self.SoundObj:ChangeVolume(GetConVar("zlm_cl_sfx_volume"):GetFloat() * 0.15, 0)

            local soundData = zlm.f.CatchSound("zlm_tractor_engine_start")
            EmitSound(soundData.sound, self:GetPos(), self:EntIndex(), CHAN_STATIC, soundData.volume, soundData.lvl, 0, soundData.pitch)
        end

        local pitch = (255 / 18) * self.ss_Speed
        pitch = math.Clamp(pitch, 75, 200)

        self.SoundObj:ChangePitch(pitch, 0)
    else
        if self.SoundObj == nil then
            self.SoundObj = MoveSound
        end

        if self.SoundObj:IsPlaying() == true then
            self.SoundObj:ChangeVolume(0, 0.3)
            self.SoundObj:Stop()

            local soundData = zlm.f.CatchSound("zlm_tractor_engine_stop")
            EmitSound(soundData.sound, self:GetPos(), self:EntIndex(), CHAN_STATIC, soundData.volume, soundData.lvl, 0, soundData.pitch)
        end
    end
end

function ENT:CuttingSound()
    local CutSound = CreateSound(self, "zlm_tractor_cutting")

    if self.IsMowing then

        if self.CuttingSoundObj == nil then
            self.CuttingSoundObj = CutSound
        end

        if self.CuttingSoundObj:IsPlaying() == false then
            self.CuttingSoundObj:Play()
            self.CuttingSoundObj:ChangeVolume(0, 0)
            self.CuttingSoundObj:ChangeVolume(GetConVar("zlm_cl_sfx_volume"):GetFloat(), 0)

        end
    else
        if self.CuttingSoundObj == nil then
            self.CuttingSoundObj = CutSound
        end

        if self.CuttingSoundObj:IsPlaying() == true then
            self.CuttingSoundObj:ChangeVolume(0, 0.3)
            self.CuttingSoundObj:Stop()
        end
    end
end

function ENT:CuttingGrassSound()
    local lCutGrassSound = CreateSound(self, "zlm_cut_grass_loop")

    -- Grass Cutting sound starts currently when storage is changing, this is a problem when connecting a grass corb to the tractor
    -- !Find a fix pls
    if self.StorageIsFilling then
        if self.GrassCutSound == nil then
            self.GrassCutSound = lCutGrassSound
        end

        if self.GrassCutSound:IsPlaying() == false then
            self.GrassCutSound:Play()
            self.GrassCutSound:ChangeVolume(0, 0)
            self.GrassCutSound:ChangeVolume(GetConVar("zlm_cl_sfx_volume"):GetFloat() * 0.5, 0.3)
        end
    else
        if self.GrassCutSound == nil then
            self.GrassCutSound = lCutGrassSound
        end

        if self.GrassCutSound:IsPlaying() == true then
            self.GrassCutSound:ChangeVolume(0, 0.5)

            timer.Simple(0.5, function()
                if IsValid(self) then
                    if self.StorageIsFilling == false then
                        self.GrassCutSound:Stop()
                    else
                        self.GrassCutSound:ChangeVolume(GetConVar("zlm_cl_sfx_volume"):GetFloat() * 0.5, 0.3)
                    end
                end
            end)
        end
    end
end

function ENT:Stop_CuttingVFX(veh)
    if self.cutting_effect then
        self.cutting_effect = false
        veh:StopParticles()
    end
    self.StorageIsFilling = false
end

function ENT:CuttingVFX(veh)

    if self.LastStorageValue < self.GrassStorage then
        self.StorageIsFilling = true
    end

    if CurTime() > self.LastStorageCheck then

        if self.LastStorageValue < self.GrassStorage then
            if self.IsMowing then

                if self.cutting_effect == false then
                    ParticleEffectAttach("zlm_mowing", PATTACH_POINT_FOLLOW, veh, veh:LookupAttachment("blade01_jnt"))
                    ParticleEffectAttach("zlm_mowing", PATTACH_POINT_FOLLOW, veh, veh:LookupAttachment("blade02_jnt"))
                    self.cutting_effect = true
                end

            else
                self:Stop_CuttingVFX(veh)
            end
        else
            self:Stop_CuttingVFX(veh)
        end
        self.LastStorageValue = self.GrassStorage
        self.LastStorageCheck = CurTime() + 1
    end
end

function ENT:AnimationHandle()
    if IsValid(self.VehicleEnt) then
        self:Unloading(self.VehicleEnt)
        --self:BladeSpin(veh)
        self:MotorRun(self.VehicleEnt)
        self:CuttingVFX(self.VehicleEnt)
    end
end

function ENT:Unloading(veh)

    if self.IsUnloading then
        self.unload_pp = math.Clamp(self.unload_pp + 0.01, 0, 1)
        if self.unload_effect == false then
            ParticleEffectAttach( "zlm_unload", PATTACH_POINT_FOLLOW, veh, veh:LookupAttachment("unload_effect") )

            local soundData = zlm.f.CatchSound("zlm_tractor_unload")
            EmitSound(soundData.sound, self:GetPos(), self:EntIndex(), CHAN_STATIC, soundData.volume, soundData.lvl, 0, soundData.pitch)

            soundData = zlm.f.CatchSound("zlm_grass_fall")
            EmitSound(soundData.sound, self:GetPos(), self:EntIndex(), CHAN_STATIC, soundData.volume, soundData.lvl, 0, soundData.pitch)

            self.unload_effect = true
        end
    else
        self.unload_pp = math.Clamp(self.unload_pp - 0.01, 0, 1)
        if self.unload_effect then

            self.unload_effect = false

            local soundData = zlm.f.CatchSound("zlm_tractor_unload")
            EmitSound(soundData.sound, self:GetPos(), self:EntIndex(), CHAN_STATIC, soundData.volume, soundData.lvl, 0, soundData.pitch)

            veh:StopParticles()
        end
    end
    -- Add something here so it doesent call the SetPoseParameter function all the time
    --if self.unload_pp ~= 0 and self.unload_pp ~= 1 then
        veh:SetPoseParameter("zlm_unload", self.unload_pp)
    --end
end

function ENT:BladeSpin(veh)

    if self.IsMowing then
        self.bladespin_pp = self.bladespin_pp + 0.01

        if self.bladespin_pp > 1 then
            self.bladespin_pp = 0
        end

        veh:SetPoseParameter("zlm_blade_spin", self.bladespin_pp)
    end
end

function ENT:MotorRun(veh)

    if self.IsRunning then

        self.motor_pp = self.motor_pp + math.Clamp((0.1 / 18) * self.ss_Speed, 0.05, 0.1)

        if self.motor_pp > 1 then
            self.motor_pp = 0
        end

        if zlm.config.VCMod and self.VCFuel <= 0 then
            self.motor_pp = 0
        end

        veh:SetPoseParameter("zlm_motor_run", self.motor_pp)
    end
end

function ENT:OnRemove()
    self:StopSound("zlm_tractor_engine_start")
    self:StopSound("zlm_tractor_engine_idle")
    self:StopSound("zlm_tractor_engine_stop")

    if self.CuttingSoundObj and self.CuttingSoundObj:IsPlaying() then
        self.CuttingSoundObj:Stop()
    end

    if self.GrassCutSound and self.GrassCutSound:IsPlaying() then
        self.GrassCutSound:Stop()
    end
end
