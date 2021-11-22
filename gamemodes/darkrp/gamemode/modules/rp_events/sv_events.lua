rp.cfg.events = {}

rp.CurEvent = nil

rp.cfg.events["darkness"] = {
	duration = 450,
	init = function()
		StormFox.SetWeather( "fog_event", 0.8)

		timer.Simple(30, function() 
			for k, v in pairs(rp.ZombieSystem.Config) do 
				if v.zombies == "Обычные зомби" or v.zombies == "Ночь" then
					v.zombies = "Туман"
				end
			end
			KillAllZombie()
			rp.ZombieSystem.SpawnZombies()
		end)
	end,
	finish = function()
		StormFox.SetWeather( "lc_clear", 1)
		SetUsualZombiesByTime()
	end,
}

function GetGameEvent()
	return rp.CurEvent
end

function SetGameEvent(name)
	if rp.CurEvent then print("ERROR TO SET GAME EVENT: EVENT IS ALREADY EXISTS") return end

	local eventtbl = rp.cfg.events[name]
	if not eventtbl then print("ERROR TO SET GAME EVENT: CANT FIND EVENT WITH THIS NAME") return end

	eventtbl.init()
	rp.CurEvent = name
	timer.Create("rp.cfg.EventEndTimer", eventtbl.duration, 1, function()
		rp.CurEvent = nil
		eventtbl.finish()
	end)
end

function StopCurGameEvent()
	if not rp.CurEvent then return end

	local eventtbl = rp.cfg.events[rp.CurEvent]
	if timer.Exists("rp.cfg.EventEndTimer") then timer.Remove("rp.cfg.EventEndTimer") end
	rp.CurEvent = nil
	eventtbl.finish()
end

timer.Create("rp.cfg.EventTimer", 3600, 0, function()
	if math.random(1,2) == 1 then return end
	local eventtbl, eventkey = table.Random(rp.cfg.events)

	SetGameEvent(eventkey)
end)
