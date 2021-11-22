ba.AddTerm('AdminKickedPlayer', '# кикнул #. Причина: #.')
ba.AddTerm('AdminBannedPlayer', '# забанил # на #. Причина: #.')
ba.AddTerm('AdminUpdatedBan', '# обновил бан с # на #. Причина: #.')
ba.AddTerm('PlayerAlreadyBanned', 'Этот игрок уже забанен. Вам нужно иметь флаг "D" чтобы обновлять время бана.')
ba.AddTerm('BanNeedsPermission', 'Вам нужно указать того, кто дал вам разрешение дать пермабан. Выдача пермабана:(их имена) и ваша причина.')
ba.AddTerm('AdminPermadPlayer', '# забанил # навсегда. Причина: #.')
ba.AddTerm('AdminUpdatedBanPerma', '# обновил бан с # навсегда. Причина: #.')
ba.AddTerm('PlayerAlreadyPermad', 'Этот игрок уже забанен! Вам нужно иметь флаг "G" чтобы обновлять время бана.')
ba.AddTerm('AdminUnbannedPlayer', '# разбанил #. Причина: #.')

-------------------------------------------------
-- Kick
-------------------------------------------------
ba.cmd.Create('Kick', function(pl, args)
	ba.notify_all(ba.Term('AdminKickedPlayer'), pl, args.target, args.reason)
	args.target:Kick(args.reason)
end)
:AddParam('player_entity', 'target')
:AddParam('string', 'reason')
:SetFlag('M')
:SetHelp('Кикает игрока с сервера')
:SetIcon('icon16/door_open.png')

-------------------------------------------------
-- Ban
-------------------------------------------------
ba.cmd.Create('Ban', function(pl, args)
	local banned, _ = ba.IsBanned(ba.InfoTo64(args.target))

	if not banned then
		ba.Ban(args.target, args.reason, args.time, pl, function()
			ba.notify_all(ba.Term('AdminBannedPlayer'), pl, args.target, args.raw.time, args.reason)
		end)
	elseif banned then
		ba.UpdateBan(ba.InfoTo64(args.target), args.reason, args.time, pl, function()
			ba.notify_all(ba.Term('AdminUpdatedBan'), pl, args.target, args.raw.time, args.reason)
		end)
	else
		ba.notify_err(pl, ba.Term('PlayerAlreadyBanned'))
	end
end)
:AddParam('player_steamid', 'target')
:AddParam('time', 'time')
:AddParam('string', 'reason')
:SetFlag('A')
:SetHelp('Банит игрока на сервере')
:SetIcon('icon16/door_open.png')

-------------------------------------------------
-- Perma
-------------------------------------------------
ba.cmd.Create('Perma', function(pl, args)
	local banned, _ = ba.IsBanned(ba.InfoTo64(args.target))

	if not banned then
		if (!pl:HasAccess("S")) then
			if (!string.find(args.reason:lower(), 'perm:')) then
				ba.notify(pl, ba.Term('BanNeedsPermission'))
				return
			end
		end

		ba.Ban(args.target, args.reason, 0, pl, function()
			ba.notify_all(ba.Term('AdminPermadPlayer'), pl, args.target, args.reason)
		end)
	elseif banned and (not ba.IsPlayer(pl) or pl:HasAccess('S')) then
		ba.UpdateBan(ba.InfoTo64(args.target), args.reason, 0, pl, function()
			ba.notify_all(ba.Term('AdminUpdatedBanPerma'), pl, args.target, args.reason)
		end)
	else
		ba.notify_err(pl, ba.Term('PlayerAlreadyPermad'))
	end
end)
:AddParam('player_steamid', 'target')
:AddParam('string', 'reason')
:SetFlag('S')
:SetHelp('Банит игрока навсегда')
:SetIcon('icon16/door_open.png')

-------------------------------------------------
-- Unban
-------------------------------------------------
ba.cmd.Create('Unban', function(pl, args)
	ba.Unban(ba.InfoTo64(args.steamid), args.reason, function()
		ba.notify_all(ba.Term('AdminUnbannedPlayer'), pl, args.steamid, args.reason)
	end)
end)
:AddParam('player_steamid', 'steamid')
:AddParam('string', 'reason')
:SetFlag('S')
:SetHelp('Разбан игрока')
:SetIcon('icon16/door_open.png')
