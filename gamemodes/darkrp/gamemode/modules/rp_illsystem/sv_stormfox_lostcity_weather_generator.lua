local changeTemperatureAndWeatherTime = 30 -- in minutes
local changeWindTime = 10
rp.Weather = rp.Weather or {}
rp.Weather.CurrentTemperature = rp.Weather.CurrentTemperature or "Neutral"
rp.Weather.CurrentWind = rp.Weather.CurrentWind or "Calm"

local TemperatureChances = {
    Hell = 5,
    Hot = 10,
    Neutral = 70,
    Cold = 10,
    Winter = 5,
}

local Temperatures = {}
Temperatures["Hell"] = {
    Ratio = 25
}
Temperatures["Hot"] = {
    Ratio = 15
}
Temperatures["Warm"] = {
    Ratio = 12
}
Temperatures["Neutral"] = {
    Ratio = 5
}
Temperatures["Cold"] = {
    Ratio = -25
}
Temperatures["Winter"] = {
    Ratio = -40
}

local Winds = {}
Winds["Strong Hurricane"] = {
    Ratio = 60
}
Winds["Hurricane"] = {
    Ratio = 40
}
Winds["Storm"] = {
    Ratio = 30
}
Winds["Gale"] = {
    Ratio = 20
}
Winds["Breeze"] = {
    Ratio = 5
}
Winds["Calm"] = {
    Ratio = 0
}


function GetTemperature()
    return rp.Weather.CurrentTemperature or "Neutral"
end
function SetTemperature(Temperature)
    if TemperatureChances[Temperature] == nil then return end
    rp.Weather.CurrentTemperature = Temperature
end
function GenerateTemperature()
    local chance = math.random(1, 100)

    local SummaryChance = 0
    for Temperature, TemperatureChance in pairs(TemperatureChances) do
        SummaryChance = SummaryChance + TemperatureChance
        if chance <= SummaryChance then
            SetTemperature(Temperature)
            print("[LOST CITY Temperature] New Temperature = " .. Temperature)

            return
        end
    end
end

function GetWind()
    return rp.Weather.CurrentWind or "Neutral"
end
function SetWind(wind)
    if Winds[wind] == nil then return end
    rp.Weather.CurrentWind = wind
end
function GenerateWind()
    local _, wind = table.Random(Winds)
    SetWind(wind)
    print("[LOST CITY Temperature] New wind = " .. wind)
end


local function PickRandomWeather(current)
	current = current or StormFox.Weather.id or "lc_clear"
	if math.random(0, 3) >= 3 then
		return "lc_clear"
	else
		local pickable = {}
		local weathers = StormFox.GetWeathers()
		for i,id in ipairs(weathers) do
			local canGenerate = StormFox.GetMapSetting("weather_" .. id,StormFox.GetWeatherType(id).CanGenerate)
			if id ~= "lc_clear" and canGenerate == true and id ~= current then
				local tfunc = StormFox.GetWeatherType(id).GenerateCondition
				if not tfunc or tfunc() then -- If not aviable, then add it
					table.insert(pickable,id)
				end
			end
		end
		local selected_weather = "lc_clear"
		if #pickable > 0 then
			selected_weather = table.Random(pickable)
		end
		return selected_weather
	end
end

function GenerateWeather()
	local newWeather = PickRandomWeather(StormFox.GetWeather())
	StormFox.SetWeather(newWeather, 0.8)
    print("[LOST CITY WEATHER] New WEATHER = " .. newWeather)
end

timer.Create( "rp.illness.LostCity_Stormfox_Temperature_Generator", 60*changeTemperatureAndWeatherTime, 0, function()
    GenerateTemperature()
    GenerateWeather()
end)

timer.Create( "rp.illness.LostCity_Stormfox_Wind_Generator", 60*changeWindTime, 0, function()
    GenerateWind()
end)


-- function HandleGrowth()
--     local rand = math.random(1, 100)
--     if rand < 10 then
--         return 1
--     elseif rand < 20 then
--         return -1
--     else
--         return nil
--     end
-- end

-- local TempGrowth = TempGrowth or 0
-- function GenerateTemperature(Temperature)
--     local newgrowth = HandleGrowth()
--     if newgrowth != nil then
--         TempGrowth = newgrowth
--     end

--     local newTemp = StormFox.GetNetworkData("Temperature") + 1*TempGrowth

--     if newTemp > Temperatures[Temperature].Temp[2] then newTemp = Temperatures[Temperature].Temp[2] end
--     if newTemp < Temperatures[Temperature].Temp[1] then newTemp = Temperatures[Temperature].Temp[1] end
--     print("NewTemp = " .. newTemp)
--     StormFox.SetNetworkData("Temperature", newTemp)
-- end

-- local WindGrowth = WindGrowth or 0
-- function GenerateWind()
--     local newgrowth = HandleGrowth()
--     if newgrowth != nil then
--         WindGrowth = newgrowth
--     end

--     local newWind = StormFox.GetNetworkData("Wind") + 1*WindGrowth
    
--     if newWind > 75 then newWind = 75 end
--     if newWind < 0 then newWind = 0 end
--     print("NewWind = " .. newWind)
--     StormFox.SetNetworkData("Wind", newWind)
-- end


function ApproachingWeather(currentValue, approximateValue, step)
    if currentValue < approximateValue then
        currentValue = currentValue + step
    elseif currentValue > approximateValue then
        currentValue = currentValue - step
    else
        currentValue = currentValue + math.random(-1, 1)
    end
    return currentValue
end

function TestWeather()
    StormFox.SetNetworkData("Temperature", ApproachingWeather(StormFox.GetNetworkData("Temperature"), Temperatures[GetTemperature()].Ratio, 1) )
    StormFox.SetNetworkData("Wind", ApproachingWeather(StormFox.GetNetworkData("Wind"), Winds[GetWind()].Ratio, 1) )
end

function SetUsualZombiesByTime()
    local time = StormFox.GetTime()
    if time > 1380 or time < 270 then
        for k, v in pairs(rp.ZombieSystem.Config) do 
            if not rp.ZombieSystem.ZombieTypesWeatherIgnore[v.zombies] == true then
                v.zombies = "Ночь"
            end
        end
        
    else
        for k, v in pairs(rp.ZombieSystem.Config) do 
            if not rp.ZombieSystem.ZombieTypesWeatherIgnore[v.zombies] == true then
                v.zombies = "Обычные зомби"
            end
        end
    end
    KillAllZombie()
    rp.ZombieSystem.SpawnZombies()
end

local isNightZombies = false 
function HandleNightZombies()
    local time = StormFox.GetTime()
    if time > 1380 or time < 270 then
        if isNightZombies == false and GetGameEvent() == nil then
            SetUsualZombiesByTime()
            isNightZombies = true
        end
    else
        if isNightZombies == true and GetGameEvent() == nil then
            SetUsualZombiesByTime()
            isNightZombies = false
        end
    end
end



timer.Create( "rp.illness.LostCity_Stormfox_Temperature_MainCycle", 60, 0, function()
    timer.Simple(math.random(1,5), function()
        StormFox.SetNetworkData("Temperature", ApproachingWeather(StormFox.GetNetworkData("Temperature"), Temperatures[GetTemperature()].Ratio, 1) )
    end)
    timer.Simple(math.random(1,5), function()
        StormFox.SetNetworkData("Wind", ApproachingWeather(StormFox.GetNetworkData("Wind"), Winds[GetWind()].Ratio, 1) )
    end)
    HandleNightZombies()
end)

hook.Add( "InitPostEntity", "rp.illness.SetStartTemperature", function()
    GenerateWind()
    GenerateTemperature()
    StormFox.SetTime(600)
end)

