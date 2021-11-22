util.AddNetworkString('RestartIncoming')

local AutoRestart = AutoRestart or {}

concommand.Add("Admin.Restart", function(ply, cmd, args)
	if !(ply:IsSuperAdmin()) then return end
	if !(args && args[1]) then return end
	
	local time = args[1]
	net.Start('RestartIncoming')
		net.WriteDouble(time)
	net.Broadcast()
	
	timer.Simple(time, function()
		RunConsoleCommand('ba', 'reload')
	end)
	
end)

function AutoRestart.PrintToAll(text)
	for k, v in pairs( player.GetAll() ) do
		v:ChatPrint(text)
		DarkRP.notify(v, 1, 4, text)
		v:PrintMessage( HUD_PRINTCENTER, text)
	end
end

function AutoRestart.CheckTime()

	AutoRestart.Time = os.date( "%H:%M", os.time() )
	
	if (AutoRestart.Time=="23:00") then
	
		AutoRestart.PrintToAll("Автоматический перезапуск сервера произойдёт через 1 Час")
		
	elseif (AutoRestart.Time=="23:30") then
	
		AutoRestart.PrintToAll("Автоматический перезапуск сервера произойдёт через 30 Минут")
		
	elseif (AutoRestart.Time=="23:45") then
	
		AutoRestart.PrintToAll("Автоматический перезапуск сервера произойдёт через 15 Минут")
		
	elseif (AutoRestart.Time=="23:50") then
	
		AutoRestart.PrintToAll("Автоматический перезапуск сервера произойдёт через 10 Минут")
		
	elseif (AutoRestart.Time=="23:55") then
	
		AutoRestart.PrintToAll("Автоматический перезапуск сервера произойдёт через 5 Минут")
		
	elseif (AutoRestart.Time=="23:56") then
	
		AutoRestart.PrintToAll("Автоматический перезапуск сервера произойдёт через 4 Минуты")
		
	elseif (AutoRestart.Time=="23:57") then
	
		AutoRestart.PrintToAll("Автоматический перезапуск сервера произойдёт через 3 Минуты")
		
	elseif (AutoRestart.Time=="23:58") then
	
		AutoRestart.PrintToAll("Автоматический перезапуск сервера произойдёт через 2 Минуты")
		
	elseif (AutoRestart.Time=="23:59") then
	
		AutoRestart.PrintToAll("Автоматический перезапуск сервера произойдёт через 1 Минуту")
		
	elseif (AutoRestart.Time=="00:00") then
	
		AutoRestart.PrintToAll("Сервер перезапускается!")

		-- for k, v in pairs( player.GetAll() ) do
		-- 	v:Kick( "Сервер перезапускается! \nПереподключитесь через 5 минут! \nЕсли сервер не отвечает - \nпожалуйста, свяжитесь с Администрацией!" )
		-- end

		timer.Simple(5,function() 
			RunConsoleCommand('ba', 'reload')
		end)
		
	end

	if (AutoRestart.Time=="07:00") then
	
		AutoRestart.PrintToAll("Автоматический перезапуск сервера произойдёт через 1 Час")
		
	elseif (AutoRestart.Time=="07:30") then
	
		AutoRestart.PrintToAll("Автоматический перезапуск сервера произойдёт через 30 Минут")
		
	elseif (AutoRestart.Time=="07:45") then
	
		AutoRestart.PrintToAll("Автоматический перезапуск сервера произойдёт через 15 Минут")
		
	elseif (AutoRestart.Time=="07:50") then
	
		AutoRestart.PrintToAll("Автоматический перезапуск сервера произойдёт через 10 Минут")
		
	elseif (AutoRestart.Time=="07:55") then
	
		AutoRestart.PrintToAll("Автоматический перезапуск сервера произойдёт через 5 Минут")
		
	elseif (AutoRestart.Time=="07:56") then
	
		AutoRestart.PrintToAll("Автоматический перезапуск сервера произойдёт через 4 Минуты")
		
	elseif (AutoRestart.Time=="07:57") then
	
		AutoRestart.PrintToAll("Автоматический перезапуск сервера произойдёт через 3 Минуты")
		
	elseif (AutoRestart.Time=="07:58") then
	
		AutoRestart.PrintToAll("Автоматический перезапуск сервера произойдёт через 2 Минуты")
		
	elseif (AutoRestart.Time=="07:59") then
	
		AutoRestart.PrintToAll("Автоматический перезапуск сервера произойдёт через 1 Минуту")
		
	elseif (AutoRestart.Time=="08:00") then
	
		AutoRestart.PrintToAll("Сервер перезапускается!")

		-- for k, v in pairs( player.GetAll() ) do
		-- 	v:Kick( "Сервер перезапускается! \nПереподключитесь через 5 минут! \nЕсли сервер не отвечает - \nпожалуйста, свяжитесь с Администрацией!" )
		-- end

		timer.Simple(5,function() 
			RunConsoleCommand('ba', 'reload')
		end)
		
	end
end

timer.Create( "AutoRestartTimer", 60, 0, function() AutoRestart.CheckTime() end)
