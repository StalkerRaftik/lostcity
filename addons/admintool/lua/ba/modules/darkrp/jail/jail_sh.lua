nw.Register 'JailReason'
	:Write(net.WriteString)
	:Read(net.ReadString)
	:SetLocalPlayer()

ba.AddTerm('JailNotSet', 'The jailroom is not set!')
ba.AddTerm('MissingArgTime', 'Время не указано!')
ba.AddTerm('MissingArgReason', 'Причина не указана!')
ba.AddTerm('JailTimeRestriction', 'Вы не можете посадить игрока в джайл более чем на 10 минут!')
ba.AddTerm('AdminJailedPlayer', '# has jailed # for #. Reason: #.')
ba.AddTerm('AdminJailedYou', '# has jailed you for #. Reason: #.')
ba.AddTerm('AdminUnjailedPlayer', '# выпустил из джайла #.')
ba.AddTerm('AdminUnjailedYou', '# выпустил вас из джайла.')
ba.AddTerm('JailroomSet', 'The jailroom has been set to your current position.')
ba.AddTerm('PlayerJailReleased', '# был освобожден из джайла.')
ba.AddTerm('YouJailReleased', 'Вас выпустили из джайла.')

function PLAYER:IsJailed()
	return ((SERVER) and (ba.jailedPlayers[self:SteamID()] ~= nil) or (self:GetNetVar('JailReason') ~= nil))
end

local cmd = ba.cmd.Create('Jail', function(pl, args)
	if not ba.svar.Get('jailroom') then
		ba.notify_err(pl, ba.Term('JailNotSet'))
		return
	end

	if not args.target:IsJailed() then
		if (args.time == nil) then
			ba.notify_err(pl, ba.Term('MissingArgTime'))
			return
		end

		if (args.reason == nil) then
			ba.notify_err(pl, ba.Term('MissingArgReason'))
			return
		end

		-- if (args.time > 600) and not pl:HasAccess('G') then
		-- 	ba.notify_err(pl, ba.Term('JailTimeRestriction'))
		-- 	return
		-- end

		ba.jailPlayer(args.target, args.time, args.reason)
		ba.notify_staff(ba.Term('AdminJailedPlayer'), pl, args.target, args.raw.time, args.reason)
		ba.notify(args.target, ba.Term('AdminJailedYou'), pl, args.raw.time, args.reason)
	else
		ba.unJailPlayer(args.target)
		ba.notify_staff(ba.Term('AdminUnjailedPlayer'), pl, args.target)
		ba.notify(args.target, ba.Term('AdminUnjailedYou'), pl)
	end
end)
cmd:AddParam('player_entity', 'target')
cmd:AddParam('time', 'time', 'optional')
cmd:AddParam('string', 'reason', 'optional')
cmd:SetFlag('M')
cmd:SetHelp('Сажает/снимает джайл с выбранного игрока')
cmd:SetIcon('icon16/lock_add.png')

-------------------------------------------------
-- Set Admin Room
-------------------------------------------------
local cmd = ba.cmd.Create('SetJailRoom', function(pl, args)
	ba.svar.Set('jailroom', pon.encode({pl:GetPos()}))
	ba.notify(pl, ba.Term('JailroomSet'))
end)
cmd:SetFlag('*')
cmd:SetHelp('Sets the jailroom to your current position')


if (CLIENT) then
	hook.Add('HUDPaint', 'jail.HUDPaint', function()
		if LocalPlayer():IsJailed() then
			local txt = 'Вы были наказаны: ' .. LocalPlayer():GetNetVar('JailReason')
			draw.ShadowSimpleText(txt, 'font_base_24', ScrW()/2, ScrH()/3, color_white, 1, 1)
			return false
		end
	end)
end