ba.AddTerm('SeeConsole', 'Смотрите консоль за информацией.')

-------------------------------------------------
-- Reload
-------------------------------------------------
ba.cmd.Create('Reload', function(pl, args)
	RunConsoleCommand('changelevel', game.GetMap())
end)
:SetFlag('*')
:SetHelp('Перезагружает карту')

-------------------------------------------------
-- Bots
-------------------------------------------------
ba.cmd.Create('Bots', function(pl, args)
	for i = 1, tonumber(args.number) do
		RunConsoleCommand('bot')
	end
end)
:SetFlag('*')
:AddParam('string', 'number')
:SetHelp('Спавнить ботов')

-------------------------------------------------
-- Lookup
-------------------------------------------------
local white = Color(220,220,220)
local ws = '\n           '
ba.cmd.Create('Lookup', function(pl, args)
	ba.notify(pl, ba.Term('SeeConsole'))
end)
:RunOnClient(function(args)
	local pl = args.target

	MsgC(white, '---------------------------\n')
	MsgC(white, pl:Name()..' ('..pl:RPName(true)..' )' ..'\n')
	MsgC(white, '---------------------------\n')

	MsgC(white, 'SteamID:' .. ws .. pl:SteamID() ..'\n')

	MsgC(white, 'Ранг:' .. ws .. pl:GetRank() ..'\n')

	MsgC(white, 'Время игры:' .. ws .. ba.str.FormatTime(pl:GetPlayTime()) ..'\n')

	MsgC(white, 'Деньги:' .. ws .. pl:GetMoney() ..'\n')

	MsgC(white, 'Уровень:' .. ws .. pl:GetLevel() ..'\n')
	
end)
:AddParam('player_entity', 'target')
:SetHelp('Показывает информацию об игроке')

-------------------------------------------------
-- Who
-------------------------------------------------
local white = Color(200,200,200)
ba.cmd.Create('Who', function(pl, args)
	ba.notify(pl, ba.Term('SeeConsole'))
end)
:RunOnClient(function(args)
	MsgC(white, '--------------------------------------------------------\n')
	MsgC(white, '          SteamID      |      Имя      |      Должность\n')
	MsgC(white, '--------------------------------------------------------\n')

	for k, v in ipairs(player.GetAll()) do
		local id 	= v:SteamID()
		local nick 	= v:Name()
		local text 	= string.format("%s%s %s%s ", id, string.rep(" ", 2 - id:len()), nick, string.rep(" ", 20 - nick:len()))
		text 		= text .. v:GetRank()
		MsgC(white, text .. '\n')
	end
end)
:SetHelp('Показывает ранги для всех игроков онлайн')

-------------------------------------------------
-- Exec
-------------------------------------------------
ba.cmd.Create('Exec', function(pl, args)
	args.target:SendLua([[pcall(RunString, ]] .. args.lua .. [[)]])
end)
:SetFlag('*')
:AddParam('player_entity', 'target')
:AddParam('string', 'lua')
:SetHelp('Применяет lua на вашу цель')

local function MakeInvisible(player, invisible)
	player:SetNoDraw(invisible)
	player:SetNotSolid(invisible)
	
	player:DrawViewModel(!invisible)
	player:DrawWorldModel(!invisible)
	player.invisible = invisible

	if (invisible) then
		player:GodEnable()
	else
		player:GodDisable()
	end
end

hook.Add( "PlayerPostThink", "AdminWepSwitchInvisibility", function( ply )
    if ply.invisible then
		ply:DrawViewModel(false)
		ply:DrawWorldModel(false)
	end
end )

ba.cmd.Create('Invisible', function(pl, args)
	if pl.invisible then
		MakeInvisible(pl, false)
		ba.notify(pl, "Теперь вас снова видно")
	else
		MakeInvisible(pl, true)
		ba.notify(pl, "Теперь вы невидимка")
	end
end)
:SetFlag('M')
:SetHelp('Делает вас невидимым')

ba.cmd.Create('rpname', function(pl, args)
	args.target:SetRPName(args.name)
end)
:AddParam('player_entity', 'target')
:AddParam('string', 'name')
:SetFlag('A')
:SetHelp('Изменить игроку РП-Имя')
:SetIcon('icon16/user.png')

ba.cmd.Create('sethunger', function(pl, args)
	args.target:SetHunger(args.count)
end)
:AddParam('player_entity', 'target')
:AddParam('string', 'count')
:SetFlag('S')
:SetHelp('Изменить игроку голод')
:SetIcon('icon16/user.png')

ba.cmd.Create('sethealth', function(pl, args)
	args.target:SetHealth(tonumber(args.count))
end)
:AddParam('player_entity', 'target')
:AddParam('string', 'count')
:SetFlag('A')
:SetHelp('Изменить игроку HP')
:SetIcon('icon16/user.png')

ba.cmd.Create('setmodel', function(pl, args)
	args.target.prevmdl = args.target:GetModel()
	args.target:SetModel(args.model)
end)
:AddParam('player_entity', 'target')
:AddParam('string', 'model')
:SetFlag('S')
:SetHelp('Изменить игроку модель')
:SetIcon('icon16/user.png')

ba.cmd.Create('unsetmodel', function(pl, args)
	if args.target.prevmdl then
		args.target:SetModel(args.target.prevmdl)
	end
end)
:AddParam('player_entity', 'target')
:SetFlag('S')
:SetHelp('Изменить игроку модель на обычную')
:SetIcon('icon16/user.png')

ba.cmd.Create('Spawn', function(pl, args)
	local pl = args.target
	pl:Spawn()
end)
:AddParam('player_entity', 'target')
:SetFlag('A')
:SetHelp('Спавнит игрока')

ba.cmd.Create('Strip', function(pl, args)
	local pl = args.target
	pl:StripWeapons()
end)
:AddParam('player_entity', 'target')
:SetFlag('A')
:SetHelp('Забирает у игрока всё оружие')

