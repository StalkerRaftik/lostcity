ColdSystem = ColdSystem or {}
ColdSystem.__index = ColdSystem

hook.Add("Initialize", "rp.illness.CreateDB", function()
    db:Query("CREATE TABLE IF NOT EXISTS rp_illnesses(SteamID64 VARCHAR(255) NOT NULL, charid INT(11) NOT NULL PRIMARY KEY, data TEXT NOT NULL)")
end)

hook.Add("PlayerCharLoaded", "rp.illness.IllSetup", function(ply)
    db:Query('SELECT * FROM rp_illnesses WHERE steamid64=' .. ply:SteamID64() .. " AND charid = " .. ply:GetNVar("CurrentChar") .. ';', function(rawdata)
        if rawdata[1] then
            if (rawdata[1].data ~= nil) and rawdata[1].data ~= "[]" then
                data = util.JSONToTable(rawdata[1].data)
                ply:SetIllsFromData(data)
                if ply.Ills == nil then ply.Ills = {} end
                ply:SendIlls()
            else 
                ply.Ills = {}
            end
        else
            ply.Ills = {}
            db:Query('INSERT INTO rp_illnesses (SteamID64, charid, data) VALUES(?, ?, ?);', ply:SteamID64(), ply:GetNVar("CurrentChar"), util.TableToJSON(ply.Ills))
        end
    end)
end)


util.AddNetworkString("rp.illness.SendIllsToClient")
function PLAYER:SendIlls()
    net.Start("rp.illness.SendIllsToClient")
        net.WriteTable(self.Ills)
    net.Send(self)
end

hook.Add("PlayerDisconnected", "rp.illness.SaveIllsToDB", function(ply)
	if not ply.Ills then return end

    _Ill:SaveDataToDB(ply)
    for name, time in pairs(ply.Ills) do
        if timer.Exists(ply:SteamID64().."_"..name) then timer.Remove(ply:SteamID64().."_"..name) end
        if timer.Exists(ply:SteamID64().."_"..name.."_think") then timer.Remove(ply:SteamID64().."_"..name.."_think") end
    end
    
end)

timer.Create( "rp.illness.updateBD", 60, 0, function()
    for _,ply in pairs(player.GetAll()) do
        _Ill:SaveDataToDB(ply)
    end
end)


function PLAYER:SetTemp(int)
    self:SetNVar("Temperature", int, NETWORK_PROTOCOL_PRIVATE)
end

function PLAYER:GetClothesWet()
    local info = self:GetNVar("ClothesIsWet")
    return info and not isnumber(info) and info or 0
end

function PLAYER:SetClothesWet(time)
    self:SetNVar("ClothesIsWet", time, NETWORK_PROTOCOL_PRIVATE)
end

timer.Create("TempUpdate", 10, 0,function()
    for _, ply in ipairs(player.GetAll()) do
        if not IsValid(ply) or not ply:Alive() or not ply:IsCharSelected() then continue end
        if ply:IsSOD() then
            continue
        end
        if isbool(ply:GetNVar('Temperature')) then continue end

        --print(ply:RPName().." TEMP: "..ply:GetNVar('Temperature')) --DEBUG
        local isUnderRoof = ply:IsUnderRoof()
        local isFireAround = ply:IsFireAround()
        local isWet = ply:IsClothesWet()

        if ply:WaterLevel() == 3 or ply:WaterLevel() == 2 then
            ply:SetClothesWet(CurTime()+300)
        end
        if ply:GetClothesWet() < CurTime() then
            ply:SetClothesWet(0)
        end



        if firearound == true then 
            ply:SetTemp(math.Clamp( ply:GetNVar('Temperature') + 5, 0, 100))
            if isWet then
                ply:SetClothesWet(ply:GetClothesWet() - 33)
            end
        end
        if isUnderRoof == true then
            ply:SetTemp(math.Clamp( ply:GetNVar('Temperature') + 1, 0, 100))
        end

        if isWet then
            ply:SetTemp(math.Clamp( ply:GetNVar('Temperature') - rp.cfg.DefaultColdRate - 0.8, 0, 100))
        else
            ply:SetTemp(math.Clamp( ply:GetNVar('Temperature') - rp.cfg.DefaultColdRate, 0, 100))
        end

        local AdditionalTempCost = 0
        if ply.Ills then 
            for name, _ in pairs(ply.Ills) do
                AdditionalTempCost = AdditionalTempCost + (1 - rp.Ills[name]:GetThirstEfficiencyEffect())
            end
        end
        ply:SetTemp(math.Clamp( ply:GetNVar('Temperature') - AdditionalTempCost, 0, 100))


        if ply:GetNVar('Temperature') < 10 and not ply.Ills["Грипп"] then
            local rand = math.random(1,20)
            if rand == 1 then
                ply:SetIll("Грипп")
            end
            -- ply:SetNVar('Temperature', 0, NETWORK_PROTOCOL_PRIVATE)
            if ply.ColdSoundTimer and ply.ColdSoundTimer <= CurTime() then return end
            ply:EmitSound(Sound("lostcity/cold/cold1.mp3"), SNDLVL_45dB)
            ply.ColdSoundTimer = CurTime() + 600
        end        
        if ply:GetNVar('Temperature') <= 0 then
            -- ply:SetNVar('Temperature', 0, NETWORK_PROTOCOL_PRIVATE)
            ply:TakeDamage( 1, ply, ply )
        end
    end
end)

hook.Add("PlayerSpawn", "SetTempOnSpawn", function(ply)
    ply:SetNVar("Temperature", 100, NETWORK_PROTOCOL_PRIVATE)
    ply:SetClothesWet(0)
end)


function ColdSystem:GetMovespeedPercent(ply)
    local temp = ply:GetTemp()
    if temp == nil or isbool(temp) then return 100 end

    if temp < 10 then
        return 70
    elseif temp < 30 then
        return 80
    elseif temp < 50 then
        return 95
    else
        return 100
    end
end