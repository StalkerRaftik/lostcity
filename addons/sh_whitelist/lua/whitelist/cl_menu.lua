-- IDEA: Presets and 76561198059738127

local easynet = SH_WHITELIST.easynet

local function L(...) return SH_WHITELIST:L(...) end

function SH_WHITELIST:OpenMenu(opento)
	self:RemoveIfValid(_SH_WHITELIST)

	local m = self:GetMargin()
	local m2 = m * 0.5
	local ss = self:GetScreenScale()
	local wi, he = 800 * self.WidthMultiplier * ss, 600 * self.HeightMultiplier * ss
	local styl = self.Style

	local selplayer, selid, selusg

	local wnd, body = self:MakeWindow(L"whitelist", m)
	wnd:SetEscapeToClose(true)
	wnd:SetSize(wi, he)
	wnd:Center()
	wnd:MakePopup()
	wnd.OnRemove = function(me)
		easynet.SendToServer("SH_WHITELIST.InMenu", {active = false})
	end
	_SH_WHITELIST = wnd

		local tw = wi * 0.25

		local selectplayer = self:CreateGroup(L"select_a_player", body)
		selectplayer:SetWide(tw)
		selectplayer:Dock(LEFT)
		selectplayer:DockMargin(0, 0, m2, 0)

			local scroll = vgui.Create("DScrollPanel", selectplayer)
			scroll:Dock(FILL)
			self:PaintScroll(scroll)

		local selectsaved = self:CreateGroup("", body)
		selectsaved:SetWide(tw)
		selectsaved:SetVisible(false)
		selectsaved:Dock(LEFT)
		selectsaved:DockMargin(0, 0, m2, 0)

			local scroll2 = vgui.Create("DScrollPanel", selectsaved)
			scroll2:Dock(FILL)
			self:PaintScroll(scroll2)

				local lblsaved_sid = self:QuickLabel("SteamID", "{prefix}Large", styl.text, scroll2)
				lblsaved_sid:Dock(TOP)
				lblsaved_sid:DockMargin(0, 0, 0, m2)

				local lblsaved_usg = self:QuickLabel(L"usergroup", "{prefix}Large", styl.text, scroll2)
				lblsaved_usg:Dock(TOP)
				lblsaved_usg:DockMargin(0, 0, 0, m2)

				local saved_btns = {}

		local jobcat = self:CreateGroup("", body)
		jobcat:SetVisible(false)
		jobcat:SetTall(24 * ss + m)
		jobcat:Dock(TOP)
		jobcat:DockMargin(0, 0, 0, m2)

			local lbl = self:QuickLabel(L"job_category", "{prefix}Medium", styl.text, jobcat)
			lbl:SetTall(24 * ss)
			lbl:Dock(TOP)
			lbl:DockMargin(0, 0, 0, m)

				local combo = self:QuickComboBox(lbl)
				combo:Dock(FILL)
				combo:DockMargin(lbl:GetWide() + m2, 0, 0, 0)
				combo.m_Background = styl.bg

			local scrolljobs = vgui.Create("DScrollPanel", jobcat)
			scrolljobs:Dock(FILL)
			self:PaintScroll(scrolljobs)

		local jobswl = self:CreateGroup(L"jobs", body)
		jobswl:SetVisible(false)
		jobswl:Dock(FILL)

			local all_line

			local ilist = vgui.Create("DListView", jobswl)
			ilist:SetDataHeight(32)
			ilist:AddColumn(L"name")
			local a = ilist:AddColumn(L"allow")
			a:SetMinWidth(64)
			a:SetMaxWidth(64)
			ilist:SetDrawBackground(false)
			ilist:Dock(FILL)
			ilist.OnRowRightClick = function(me, _, __)
				local sel = me:GetSelected()
				for _, v in pairs (sel) do
					if (v == all_line) then
						table.RemoveByValue(sel, v)
						break
					end
				end

				local m = self:Menu()
				m:AddOption(L("toggle_selected", #sel), function()
					local b = false
					local chkd = 0
					for ___, line in pairs (sel) do
						if (line.m_bCheckbox:GetChecked()) then
							b = true
							chkd = chkd + 1
						end
					end

					if (chkd == 0 or chkd == #sel) then
						b = !b
					end

					for ___, line in pairs (sel) do
						line.m_bCheckbox:SetValue(b)
					end
				end)
				m:Open()
			end
			self:PaintList(ilist, true)

			local tosend = {}
			local function WhitelistJob(name, b)
				tosend[name] = b

				local s, u = selid, selusg

				timer.Create("SH_WHITELIST.WhitelistJob", 0, 1, function()
					local n, d = "", {jobs = {}, whitelisted = {}}
					for k, v in pairs (tosend) do
						table.insert(d.jobs, k)
						table.insert(d.whitelisted, v)
					end

					if (u) then
						n = "SH_WHITELIST.WhitelistUsergroup"
						d.usergroup = u
					else
						n = "SH_WHITELIST.WhitelistSteamID"
						d.steamid = s
					end

					easynet.SendToServer(n, d)
					tosend = {}
				end)
			end

			local jobs = {}
			local function AddJob(tx, id, color)
				local cb
				if (isfunction(id)) then
					cb = id
				elseif (isnumber(id)) then
					cb = function(me, b)
						-- Check if we're all checked
						if (b) then
							local ok = true
							for _, line in pairs (jobs) do
								if (line == all_line) then
									continue end

								if (!line.m_bCheckbox:GetChecked()) then
									ok = false
									break
								end
							end

							all_line.m_bCheckbox:SetChecked(ok)
							all_line.m_bCheckbox.m_bValue = ok
						else
							all_line.m_bCheckbox:SetChecked(false)
							all_line.m_bCheckbox.m_bValue = false
						end

						--
						WhitelistJob(tx, me:GetChecked())
					end
				end

				-- Checked?
				local whitelisted = (selusg and self.Whitelisted.usergroups[selusg] or self.Whitelisted.players[selid]) or {} /* 76561198059738115 */
				local b = whitelisted[tx] == true

				local chkw = vgui.Create("DPanel", ilist)
				chkw:SetDrawBackground(false)

					local can_edit = self:CanWhitelist(LocalPlayer(), tx)

					local chk = self:Checkbox(cb, chkw)
					chk:SetTooltipLounge(L"allow_tooltip")
					chk:SetMouseInputEnabled(can_edit)
					chk:SetChecked(b)
					chk.m_bValue = b
					chk.m_bDrawBackground = can_edit
					chk:SetSize(16, 16)
					chk:SetPos(24, 8)

				local line = ilist:AddLine(tx, chkw)
				line.m_bCheckbox = chk
				line.m_sJobName = tx
				self:LineStyle(line, true)

				if (color) then
					line.Columns[1]:SetColor(Color(color.r, color.g, color.b))
				end

				table.insert(jobs, line)
				return line
			end

		-- Populate job list
		combo.OnSelect = function(me, index, value, data)
			ilist:Clear()
			tosend = {}
			jobs = {}

			all_line = AddJob(L"all_jobs_in_category", function(me, b)
				for _, line in pairs (jobs) do
					if (line == all_line) then
						continue end

					if (b ~= line.m_bCheckbox:GetChecked()) then
						line.m_bCheckbox:SetChecked(b)
						line.m_bCheckbox.m_bValue = b

						WhitelistJob(line.m_sJobName, line.m_bCheckbox:GetChecked())
					end
				end
			end)
			all_line:SetSelectable(false)

			for _, job in pairs (data) do
				AddJob(job.name, job.team, job.color)
			end

			local ok = true
			for _, line in pairs (jobs) do
				if (line == all_line) then
					continue end

				if (!line.m_bCheckbox:GetChecked()) then
					ok = false
					break
				end
			end

			all_line.m_bCheckbox:SetChecked(ok)
			all_line.m_bCheckbox.m_bValue = ok
		end

		local wlall = {}
		for _, job in pairs (RPExtraTeams) do
			if (self:IsWhitelistJob(job)) then
				table.insert(wlall, job)
			end
		end
		combo:AddChoice(L"all" .. " (" .. #wlall .. ")", wlall, true)

		if (DarkRP and DarkRP.getCategories and DarkRP.getCategories().jobs) then
			local cats = DarkRP.getCategories().jobs
			for _, cat in pairs (cats) do
				local wl = {}
				for __, job in pairs (cat.members) do
					if (self:IsWhitelistJob(job)) then
						table.insert(wl, job)
					end
				end

				if (#wl == 0) then
					continue end

				combo:AddChoice(cat.name .. " (" .. #wl .. ")", wl)
			end
		end

		if (#wlall == 0) then
			self:Notify(L"no_whitelistable_jobs", nil, styl.failure, wnd)
		end

		-- Jobs display
		local function ShowJobs(steamid, ply, usg)
			selplayer = ply
			selid = steamid
			selusg = usg

			if (usg) then
				easynet.SendToServer("SH_WHITELIST.ReqWhitelistUsergroup", {usergroup = usg})
			else
				easynet.SendToServer("SH_WHITELIST.ReqWhitelistSteamID", {steamid = selid})
			end
		end

		self:AddPanelHook("OnWhitelistReceived", jobswl, function(me, whitelisted, steamid, usergroup)
			if (steamid and selid ~= steamid) or (usergroup and selusg ~= usergroup) then
				return end

			local all = true
			for _, line in pairs (jobs) do
				if (line == all_line) then
					continue end

				local b = whitelisted[line.m_sJobName] or false
				line.m_bCheckbox:SetChecked(b)
				line.m_bCheckbox.m_bValue = b

				if (!b) then
					all = false
				end
			end

			all_line.m_bCheckbox:SetChecked(all)
			all_line.m_bCheckbox.m_bValue = all

			if (!jobcat:IsVisible()) then
				jobcat:SetVisible(true)
				jobcat:SetAlpha(0)
				jobcat:AlphaTo(255, 0.1)

				jobswl:SetVisible(true)
				jobswl:SetAlpha(0)
				jobswl:AlphaTo(255, 0.1)
			end
		end)

		-- Populate player list
		local sp = 32 * 0.25 * 0.5
		for _, v in ipairs (player.GetAll()) do
			local btn = self:QuickButton(v:Nick(), function(me)
				if (selplayer == v) then
					return end

				ShowJobs(v:SteamID(), v)
				wnd:SetTitle(L"whitelist" .. " - " .. v:Nick() .. " (" .. L"player" .. ")")
			end, scroll)
			btn.Think = function(me)
				if (!IsValid(v) and !me.m_bStopping) then
					wnd:SetTitle(L"whitelist")

					me.m_bStopping = true
					me:SetMouseInputEnabled(false)
					me:SizeTo(me:GetWide(), 1, 0.2, nil, nil, function()
						me:Remove()
					end)

					if (!IsValid(selplayer) and jobcat:IsVisible()) then
						jobcat:Stop()
						jobcat:AlphaTo(0, 0.1, 0, function()
							jobcat:SetVisible(false)
						end)
						jobswl:Stop()
						jobswl:AlphaTo(0, 0.1, 0, function()
							jobswl:SetVisible(false)
						end)
					end
				end
			end
			btn:SetTall(32)
			btn:Dock(TOP)
			btn:DockMargin(0, 0, 0, m2)
			btn.m_Background = styl.bg

				local avi = self:Avatar(v, 24, btn)
				avi:Dock(LEFT)
				avi:DockMargin(sp, sp, 0, 0)

			if (opento == v) then
				btn:DoClick()
			end
		end

		if (self:IsAdmin(LocalPlayer()) or self.NonAdminsCanWhitelistAll) then
			local btn_saved = self:QuickButton(L"view_saved_whitelists", function(me)
				easynet.SendToServer("SH_WHITELIST.ReqWhitelistSaved")

				selectplayer:SizeTo(1, -1, 0.2, nil, nil, function()
					selectplayer:SetVisible(false)

					selectsaved:SetVisible(true)
					selectsaved:SetWide(1)
					selectsaved:SizeTo(tw, -1, 0.2)
				end)
			end, selectplayer)
			btn_saved:SetTooltipLounge(L"saved_tooltip")
			btn_saved:SetTall(24 * ss)
			btn_saved:DockMargin(0, m2, 0, 0)
			btn_saved:Dock(BOTTOM)
			btn_saved.m_Background = styl.bg

			-- local btn_usg = self:QuickButton(L"usergroup" .. "..", function(me)
			-- 	self:StringRequest(L"whitelist_jobs_for_usergroup", L"usergroup_tooltip", function(text)
			-- 		if (self.Usergroups[text]) then
			-- 			self:Notify(L"this_usergroup_cant_be_whitelisted", nil, styl.failure, body)
			-- 			return
			-- 		end

			-- 		ShowJobs(nil, nil, text)
			-- 		wnd:SetTitle(L"whitelist" .. " - " .. text .. " (" .. L"usergroup" .. ")")
			-- 	end)
			-- end, selectplayer)
			-- btn_usg:SetTooltipLounge(L"usergroup_tooltip")
			-- btn_usg:SetTall(24 * ss)
			-- btn_usg:DockMargin(0, m2, 0, 0)
			-- btn_usg:Dock(BOTTOM)
			-- btn_usg.m_Background = styl.bg

			local btn_steamid = self:QuickButton("SteamID..", function(me)
				self:StringRequest(L"whitelist_jobs_for_steamid", L"steamid_tooltip", function(text)
					text = text:upper():Trim()
					if (!self:IsValidSteamID(text)) then
						self:Notify(L"invalid_steamid", nil, styl.failure, body)
						return
					end

					if (text:StartWith("76")) then
						text = util.SteamIDFrom64(text)
					end

					ShowJobs(text)
					wnd:SetTitle(L"whitelist" .. " - " .. text .. " (SteamID)")
				end)
			end, selectplayer)
			btn_steamid:SetTooltipLounge(L"steamid_tooltip")
			btn_steamid:SetTall(24 * ss)
			btn_steamid:DockMargin(0, m2, 0, 0)
			btn_steamid:Dock(BOTTOM)
			btn_steamid.m_Background = styl.bg
		end

		-- Populate saved list
		self:AddPanelHook("OnSavedWhitelistReceived", selectsaved, function(me, steamids, usergroups)
			for _, v in pairs (saved_btns) do
				if (IsValid(v)) then
					v:Remove()
				end
			end
			saved_btns = {}

			for _, steamid in pairs (steamids) do
				steamid = "STEAM_" .. steamid

				local btn = self:QuickButton(steamid, function(me)
					if (selid == steamid) then
						return end

					ShowJobs(steamid)
					wnd:SetTitle(L"whitelist" .. " - " .. steamid .. " (SteamID)")
				end, scroll2)
				btn:SetTall(24 * ss)
				btn:Dock(TOP)
				btn:DockMargin(0, 0, 0, m2)
				btn:MoveToAfter(lblsaved_sid)
				btn.m_Background = styl.bg

				table.insert(saved_btns, btn)
			end

			for _, usergroup in pairs (usergroups) do
				local btn = self:QuickButton(usergroup, function(me)
					if (selusg == usergroup) then
						return end

					ShowJobs(nil, nil, usergroup)
					wnd:SetTitle(L"whitelist" .. " - " .. usergroup .. " (" .. L"usergroup" .. ")")
				end, scroll2)
				btn:SetTall(24 * ss)
				btn:Dock(TOP)
				btn:DockMargin(0, 0, 0, m2)
				btn:MoveToAfter(lblsaved_usg)
				btn.m_Background = styl.bg

				table.insert(saved_btns, btn)
			end
		end)

		local btn_back = self:QuickButton(L"go_back", function(me)
			selectsaved:SizeTo(1, -1, 0.2, nil, nil, function()
				selectsaved:SetVisible(false)

				selectplayer:SetVisible(true)
				selectplayer:SetWide(1)
				selectplayer:SizeTo(tw, -1, 0.2)
			end)
		end, selectsaved)
		btn_back:SetTall(24 * ss)
		btn_back:DockMargin(0, m2, 0, 0)
		btn_back:Dock(BOTTOM)
		btn_back.m_Background = styl.bg

		if (self:IsAdmin(LocalPlayer())) then
			local back_opti = self:QuickButton(L"delete_empty_entries", function(me)
				easynet.SendToServer("SH_WHITELIST.OptimizeDatabase")
			end, selectsaved)
			back_opti:SetTall(24 * ss)
			back_opti:DockMargin(0, m2, 0, 0)
			back_opti:Dock(BOTTOM)
			back_opti.m_Background = styl.bg
		end

	wnd:SetAlpha(0)
	wnd:AlphaTo(255, 0.2)

	easynet.SendToServer("SH_WHITELIST.InMenu", {active = true})
end