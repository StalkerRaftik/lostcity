include("shared.lua")

local sounds = {}

local snddata = {}
snddata.path = Sound("ambient/machines/gas_loop_1.wav")
snddata.pitchBase = 40
snddata.soundLevel = 100
table.insert(sounds, snddata)

local snddata = {}
snddata.path = Sound("ambient/wind/wind_outdoors_1.wav")
snddata.pitchBase = 70
snddata.soundLevel = 120
table.insert(sounds, snddata)

local snddata = {}
snddata.path = Sound("vehicles/airboat/fan_blade_fullthrottle_loop1.wav")
snddata.pitchBase = 70
snddata.soundLevel = 120
table.insert(sounds, snddata)

function ENT:Initialize()
    self.sounds = {}

    for _,snddata in pairs(sounds) do
        local snd = CreateSound(self, snddata.path)
        snd:SetSoundLevel(snddata.soundLevel)
        snd:Play()
        snd:ChangeVolume(0)
        self.sounds[snddata] = snd
    end
end

function ENT:Think()

    local ply = LocalPlayer()
    local dir = (ply:GetPos()-self:GetPos()):GetNormalized()
    local speed = self:GetVelocity():Dot(dir) - ply:GetVelocity():Dot(dir)
    speed = speed / 250

    local dist = self:GetPos():Distance(ply:GetPos())
    local volume = math.Clamp(1 - dist/8500, 0, 1)

    for snddata,snd in pairs(self.sounds) do
        local pitch = snddata.pitchBase + speed
        pitch = math.Clamp(pitch, 0, 255)
        snd:ChangePitch(pitch)
        snd:ChangeVolume(volume)
    end

end

function ENT:OnRemove()
    for snddata,snd in pairs(self.sounds) do
        snd:Stop()
    end
end

function ENT:Draw()
    self:DrawModel()
    self:DrawShadow()
end
