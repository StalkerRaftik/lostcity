-------------------------------------------------
-- Setid
-------------------------------------------------
ba.AddTerm('SerevrIDSet', 'Сервер ID теперь #')

ba.cmd.Create('SetID', function(pl, args)
	ba.svar.Set('sv_id', args.id)
	ba.notify(pl, ba.Term('SerevrIDSet'), args.id)
end)
:AddParam('string', 'id')
:SetFlag('*')
:SetHelp('Устанавливает ID сервера. Не проебитесь с этой хуйней.')

-------------------------------------------------
-- Set Group
-------------------------------------------------
ba.AddTerm('SetRank', '# выдал # ранг: # # #')

ba.cmd.Create('SetGroup', function(pl, args)
	if args.exp_time and (not args.exp_rank) then
		ba.notify_err(pl, ba.Term('MissingArg'), 'exp_rank')
		return
	end

	if IsValid(pl) and pl:GetImmunity() < ba.ImmunityNeedToSetRanks then return end

	ba.data.SetRank(args.target, args.rank, (args.exp_rank or args.rank) , (args.exp_time and os.time() + args.exp_time or 0), function(data)
		ba.notify_all(ba.Term('SetRank'), pl, args.target, args.rank, (args.exp_rank and 'expiring to ' .. args.exp_rank or ''), (args.exp_time and 'in ' .. args.raw.exp_time or ''))
	end)
end)
:AddParam('player_steamid', 'target')
:AddParam('rank', 'rank')
:AddParam('time', 'exp_time', 'optional')
:AddParam('rank', 'exp_rank', 'optional')
:SetFlag('S')
:SetHelp('Выдает ранк игроку')
:SetIcon('icon16/group.png')

-------------------------------------------------
-- Adminmode
-------------------------------------------------
ba.AddTerm('EnterAdminmode', '# начал администрировать.')
ba.AddTerm('ExitAdminmode', '# закончил с администрированием.')

ba.cmd.Create('AdminMode', function(pl, args)
	if pl:GetBVar('adminmode') then
		ba.notify_staff(ba.Term('ExitAdminmode'), pl)
		pl:ChangeTeam(1, true)
		pl:StripWeapon('weapon_physgun')
	else
		ba.notify_staff(ba.Term('EnterAdminmode'), pl)
		pl:ChangeTeam(TEAM_ADMIN, true)
		pl:Give('weapon_physgun')
	end
	pl:SetBVar('adminmode', not (pl:GetBVar('adminmode') or false))
end)
:SetFlag('M')
:SetHelp('Позволяет использовать Noclip и манипулировать пропами')

-------------------------------------------------
-- Help
-------------------------------------------------
ba.cmd.Create('Help')
:RunOnClient(function() -- ehhhhh
	local fr = ui.Create('ui_frame', function(self)
		self:SetSize(600, ScrH() * 0.5)
		self:SetTitle('Command help')
		self:Center()
		self:MakePopup()
	end)

	local cont = ui.Create('ui_scrollpanel', function(self, p)
		self:SetPos(5, 32)
		self:SetSize(p:GetWide() - 10, p:GetTall() - 37)
		self:SetPadding(-1)
		self:SetScrollSize(4)
	end, fr)

	for k, v in pairs(ba.cmd.GetTable()) do
		if LocalPlayer():HasFlag(v:GetFlag()) then
			local p = ui.Create('ui_panel')

			local l = ba.ui.Label(v:GetNiceName() .. ':', p, {font = 'ba.ui.22', color = ui.col.Close})
			l:SizeToContents()
			l:SetPos(26, 5)

			local h = l:GetTall()

			l = ba.ui.Label('Help: ' .. v:GetHelp(), p, {font = 'ba.ui.22', color = ui.col.Close})
			l:SizeToContents()
			l:SetPos(50, 25)

			h = h + l:GetTall()

			local a = ''
			for k, arg in ipairs(v:GetArgs()) do
				a = a .. arg.Key .. (k == #v:GetArgs() and '' or ', ')
			end

			if (#v:GetArgs() < 1) then
				a = 'No Args'
			else
				a = 'Args: ' .. a
			end

			l = ba.ui.Label(a, p, {font = 'ba.ui.22', color = ui.col.Close})
			l:SizeToContents()
			l:SetPos(50, 50)

			h = h + l:GetTall() + 10

			p:SetTall(h)

			local i = ui.Create('DImage', function(self)
				self:SetPos(5, 5)
				self:SetImage(v:GetIcon())
				self:SetSize(16,16)
			end, p)

			cont:AddItem(p)
		end
	end
end)
:SetHelp('Дает полезную информацию о себе и о других полезных командах')