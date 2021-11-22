local LCClear = StormFox.WeatherType( "lc_clear" )
local max,min = math.max,math.min
LCClear.Name = "lc_clear"
LCClear.CanGenerate = false
LCClear.TimeDependentGenerate = {340,400}
LCClear.StormMagnitudeMin = 0.6
LCClear.StormMagnitudeMax = 0.9
LCClear.MaxLength = 0
LCClear.GenerateCondition = function()
	return GetConVar("sf_enablefog"):GetBool() and math.random(4) >= 3
end
local rc = Color(231,233,240)
local a,aa = 0.02,1
LCClear.TimeDependentData.SkyBottomColor = {
	TIME_SUNRISE = Color(rc.r * aa,rc.g * aa,rc.b * aa),
	TIME_SUNSET = Color(rc.r * a,rc.g * a,rc.b * a),
}
LCClear.TimeDependentData.DuskColor = {
	TIME_SUNRISE = Color(rc.r * aa,rc.g * aa,rc.b * aa),
	TIME_SUNSET = Color(rc.r * a,rc.g * a,rc.b * a),
}
LCClear.TimeDependentData.FadeBias = {
	TIME_SUNRISE = 1,
	TIME_SUNSET = 0.1,
}

LCClear.DataCalculationFunctions.Fogdensity = function(flPercent)
	return min(flPercent * 5,1)
end
LCClear.DataCalculationFunctions.Fogend = function(flPercent)
	local tv = StormFox.GetTimeEnumeratedValue()
	if tv == "TIME_SUNRISE" or tv == "TIME_NOON" then
		--day
		return 12000
	else
		--night
		return 4000
	end
end
LCClear.DataCalculationFunctions.Fogstart = function(flPercent)
	local tv = StormFox.GetTimeEnumeratedValue()
	local rp = 1 - flPercent
	if tv == "TIME_SUNRISE" or tv == "TIME_NOON" then
		--day
		return -900
	else
		--night
		return -1200
	end
end

LCClear.CalculatedData.MapDayLight = 92.5
LCClear.CalculatedData.SunColor = Color(155,255,155,55)

LCClear.DataCalculationFunctions.StarFade = function( flPercent ) return 1 end
LCClear.DataCalculationFunctions.SunSize = function( flPercent ) return 1 end
LCClear.DataCalculationFunctions.MoonVisibility = function( flPercent ) return 1 end

local m = Material("")
function LCClear:GetIcon()
	return m
end
function LCClear:GetStaticIcon()
	return m
end
function LCClear:GetName( _, _, _  )
	local m = StormFox.GetNetworkData( "WeatherMagnitude")
	if m <= 0.5 then
		return StormFox.Language.Translate("sf_weather.light_fog")
	elseif m <= 0.8 then
		return StormFox.Language.Translate("sf_weather.fog")
	else
		return StormFox.Language.Translate("sf_weather.heavy_fog")
	end
end


StormFox.AddWeatherType( LCClear )
