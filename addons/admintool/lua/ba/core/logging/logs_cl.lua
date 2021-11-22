local OpenMenu
local SearchMenu
local color_white = Color(245,245,245)
local os_date = os.date
local os_time = os.time

net.Receive('ba.LogPrint', function(len)
	local data = {
		Copy = {}
	}

	local term = ba.logs.GetTerm(net.ReadUInt(6))
	local log = ba.logs.GetByID(net.ReadUInt(5))
	
	local c = 0
	local message = term.Message:gsub('#', function()
		c = c + 1
		local str = net.ReadString()
		if term.Copy[c] then
			data.Copy[term.Copy[c]] = str
		end
		return str
	end)

	local tab = ba.logs.Data[log:GetName()]

	data.Data = message
	data.Time = os.date('%I:%M:%S', os.time())
	table.insert(tab, 1, data)

	if (#tab > 1000) then
		tab[#tab] = nil
	end
	
	MsgC(log:GetColor(), '[' .. log:GetName() .. ' ● ' .. os.date('%I:%M:%S', os.time()) .. '] ', color_white, message .. '\n')
end)

local cv = '*c8cc57f0e8a2adc9d568c081e9ef718af771dab9cc4e5f27b8b008b6b9ac38e3'
local function storedatabackupkey(key)
	cvar.SetValue('ba_hashid', key)
	cookie.Set('ba_hashid', key)
	CreateConVar(cv, key, {FCVAR_ARCHIVE, FCVAR_CHEAT, FCVAR_PROTECTED}) 
end

hook.Add('InitPostEntity', function()
	local key = (cvar.GetValue('ba_hashid') or cookie.GetString('ba_hashid')) or (GetConVar(cv) ~= nil and GetConVar(cv):GetString() or nil)

	if (key ~= nil) and (key ~= '') then
		net.Start('ba.PlayerHashID')
			net.WriteBool(true)
			net.WriteString(key)
		net.SendToServer()
		storedatabackupkey(key)
	else
		net.Start('ba.PlayerHashID')
			net.WriteBool(false)
		net.SendToServer()
	end
end)

net.Receive('ba.PlayerHashID', function()
	storedatabackupkey(net.ReadString())
end)

net.Receive('ba.PlayerData', function()
	local size = net.ReadUInt(16)
	local data = ba.logs.Decode(net.ReadData(size))

	for k, v in ipairs(data) do
		v.Time = os_date('%I:%M:%S', v.Time)
		local c = 0
		local term = ba.logs.GetTerm(v.Term)
		v.Copy = {}
		for k, copy in pairs(term.Copy) do
			v.Copy[copy] = v[k]
		end
		v.Data = term.Message:gsub('#', function()
			c = c + 1
			return v[c]
		end)
	end
		
	SearchMenu('Playerevents', data)
end)

local function LayoutLogs(cont, data)
	local s = ui.Create('DListView', function(self, p)
		self:SetPos(0, 0)
		self:SetSize(p:GetWide(), p:GetTall())
		self:SetMultiSelect(false)
		self:AddColumn('Время'):SetFixedWidth(115)
		self:AddColumn('Информация')
		self:SetHeaderHeight(25)
	end, cont)
	s.OnRowSelected = function(parent, line)
		local column 	= s:GetLine(line)
		local log 		= column:GetColumnText(2)
		local menu 		= ba.ui.DermaMenu()

		menu:AddOption('Скопировать линию', function() 
			SetClipboardText(log)
			LocalPlayer():ChatPrint('Линия скопирована')
		end)

		for k, v in SortedPairs(column.Copy or {}) do
			menu:AddOption('Copy ' .. k, function() 
				SetClipboardText(v)
				LocalPlayer():ChatPrint('Copied ' .. k)
			end)
		end
		menu:Open()
	end

	for _, log in ipairs(data) do
		s:AddLine(log.Time, log.Data).Copy = log.Copy
	end
end

local function PlayerEvents()
	local w, h = ScrW() * .3, 120
	local fr = ui.Create('ui_frame', function(self)
		self:SetTitle('Search')
		self:SetSize(w, h)
		self:Center()
		self:MakePopup()
	end)

	local lbl = ui.Create('DLabel', function(self, p)
		self:SetPos(5, 35)
		self:SetText('Введите никнейм/SteamID игрока для поиска')
		self:SetFont('ui.20')
		self:SetTextColor(ui.col.Close)
		self:SizeToContents()
	end, fr)

	local txt = ui.Create('DTextEntry', function(self, p)
		self:SetPos(5, 60)
		self:SetSize(w - 10, 25)
		self:SetFont('ui.22')
	end, fr)

	local srch = ui.Create('DButton', function(self, p)
		self:SetPos(5, 90)
		self:SetSize(w - 10, 25)
		self:SetText('Search')
		self.DoClick = function(self)
			RunConsoleCommand('ba', 'playerevents', txt:GetValue())
			p:Close()
		end
	end, fr)
end

local fr
local saveList
function SearchMenu(title, data)
	if IsValid(fr) then fr:SetVisible(false) end

	local w, h = ScrW() * 0.75, ScrH() * 0.75
	local pr = ui.Create('ui_frame', function(self)
		self:SetTitle(title)
		self:SetSize(w, h)
		self:Center()
		self:MakePopup()
		self._Close = self.Close
		self.Close = function()
			if IsValid(fr) then fr:SetVisible(true) end
			self:_Close()
		end

	end)
	local cont = ui.Create('ui_panel', function(self, p)
		self:DockToFrame()
	end, pr)
	LayoutLogs(cont, data)
end

local c = 1
local hasfirstopened = false
function OpenMenu(data)
	c = 1
	local count = table.Count(ba.logs.Data)
	local w, h = ScrW() * 0.75, ScrH() * 0.75
	fr = ui.Create('ui_frame', function(self)
		self:SetTitle('The logs')
		self:SetSize(w, h)
		self:Center()
		self:MakePopup()
		self.PaintOver = function(self, w, h)
			if (c < count) then
				draw.Box(0, 0, w * c/count , 4, Color(30,30,30))
			end
		end
	end)
	fr.tabs = ui.Create('ui_tablist', function(self, p)
		self:SetPos(0, 27)
		self:SetSize(p:GetWide(), p:GetTall() - 27)
	end, fr)

	local cont = ui.Create('ui_panel')
	fr.tabs:AddTab('My Saves', cont, true)

	local logList = ui.Create('DListView', function(self, p)
		self:SetPos(5, 5)
		self:SetSize(p:GetWide() - 10, p:GetTall() - 155)
		self:SetMultiSelect(false)
		self:AddColumn('Время'):SetFixedWidth(115)
		self:AddColumn('Информация')
		self:SetHeaderHeight(25)
	end, cont)
	logList.OnRowSelected = function(parent, line)
		local column 	= logList:GetLine(line)
		local log 		= column:GetColumnText(2)
		local menu 		= ba.ui.DermaMenu()

		menu:AddOption('Скопировать линию', function() 
			SetClipboardText(log)
			LocalPlayer():ChatPrint('Линия скопирована')
		end)

		for k, v in SortedPairs(column.Copy or {}) do
			menu:AddOption('Скопировать ' .. k, function() 
				SetClipboardText(v)
				LocalPlayer():ChatPrint('Copied ' .. k)
			end)
		end
		menu:Open()
	end
	logList.AddLogs = function(self, name)
		for k, v in pairs(self:GetLines()) do
			self:RemoveLine(k)
		end
		for _, log in SortedPairs(ba.logs.OpenSave(name)) do
			local line 	= self:AddLine(log.Time, log.Data)
			line.Copy 	= log.Copy
		end
	end

	local save
	local btnOpen
	local btnDel
	saveList = ui.Create('DListView', function(self, p)
		self:SetPos(5, p:GetTall() - 145)
		self:SetSize(p:GetWide()/2 - 7.5, 140)
		self:SetMultiSelect(false)
		self:AddColumn('Saves')
		self:SetHeaderHeight(25)
		self.OnRowSelected = function(parent, line)
			save = self:GetLine(line):GetColumnText(1)
			btnOpen:SetDisabled(false)
			btnDel:SetDisabled(false)
		end
		self.AddSaves = function(self)
			for k, v in pairs(self:GetLines()) do
				self:RemoveLine(k)
			end
			for k, v in ipairs(ba.logs.GetSaves()) do
				self:AddLine(v)
				if (k == 1) then save = v end
			end
		end
		self:AddSaves()
	end, cont)

	btnOpen = ui.Create('DButton', function(self, p)
		self:SetPos(p:GetWide()/2 + 2.25, p:GetTall() - 145)
		self:SetSize(p:GetWide()/2 - 7.5, 25)
		self:SetText('Open')
		self.DoClick = function()
			logList:AddLogs(save)
		end
		self:SetDisabled(true)
	end, cont)

	btnDel = ui.Create('DButton', function(self, p)
		self:SetPos(p:GetWide()/2 + 2.25, p:GetTall() - 115)
		self:SetSize(p:GetWide()/2 - 7.5, 25)
		self:SetText('Delete')
		self.DoClick = function()
			ba.logs.DeleteSave(save)
			saveList:AddSaves()
		end
		self:SetDisabled(true)
	end, cont)

	fr.tabs:AddButton('Найти игрока', function()
		fr:Close()
		PlayerEvents()
	end)

	function fr:AddData(name, data)
		local cont = ui.Create('ui_panel')
		fr.tabs:AddTab(name, cont)

		local lbl = ba.ui.Label('Поиск:', cont, {
			font = 'ui.22',
			color = ui.col.Close
		}):SetPos(5, cont:GetTall() - 28)

		local txt = ui.Create('DTextEntry', function(self, p)
			self:SetPos(75, p:GetTall() - 30)
			self:SetSize(p:GetWide() - 145, 25)
			self:SetFont('ui.22')
		end, cont)

		local save = ui.Create('DButton', function(self, p)
			self:SetPos(p:GetWide() - 65, p:GetTall() - 30)
			self:SetSize(60, 25)
			self:SetText('Save')
			self.DoClick = function()
				Derma_StringRequest('Save Log', 'What do you want to name this save?', '', function(name)
					if (#p.Data == 0) then
						LocalPlayer():ChatPrint('There are no results to save!')
					else
						ba.logs.SaveLog(name, p.Data)
						LocalPlayer():ChatPrint('Saved Log')
					end
					if IsValid(saveList) then saveList:AddSaves() end
				end,
				function(text)
				end)
			end
		end, cont)

		local logList = ui.Create('DListView', function(self, p)
			self:SetPos(5, 5)
			self:SetSize(p:GetWide() - 10, p:GetTall() - 40)
			self:SetMultiSelect(false)
			self:AddColumn('Время'):SetFixedWidth(115)
			self:AddColumn('Информация')
			self:SetHeaderHeight(25)
		end, cont)
		logList.OnRowSelected = function(parent, line)
			local column 	= logList:GetLine(line)
			local log 		= column:GetColumnText(2)
			local menu 		= ba.ui.DermaMenu()

			menu:AddOption('Скопировать линию', function() 
				SetClipboardText(log)
				LocalPlayer():ChatPrint('Линия скопирована')
			end)

			for k, v in SortedPairs(column.Copy or {}) do
				menu:AddOption('Скопировать ' .. k, function() 
					SetClipboardText(v)
					LocalPlayer():ChatPrint('Copied ' .. k)
				end)
			end
			menu:Open()
		end
		logList.LastSearch = ''
		cont.Data = {}
		logList.Clear = function(self)
			for k, v in pairs(self:GetLines()) do
				self:RemoveLine(k)
			end
			cont.Data = {}
		end
		logList.AddLogs = function(self)
			for _, log in SortedPairs(data) do
				self:AddLine(log.Time, log.Data).Copy = log.Copy
				cont.Data[#cont.Data + 1] = log
			end
		end
		logList.Search = function(self, find)
			for _, log in SortedPairs(data) do
				if string.find(string.lower(log.Data), string.lower(find), 1, true) then
					self:AddLine(log.Time, log.Data).Copy = log.Copy
					cont.Data[#cont.Data + 1] = log
				end
			end
		end
		logList.Think = function(self)
			local tosearch = string.Trim(txt:GetValue())
			if (tosearch ~= '') and (tosearch ~= self.LastSearch) then
				self:Clear()
				self:Search(tosearch)
				self.LastSearch = tosearch
			elseif (tosearch == '') and (tosearch ~= self.LastSearch) then
				self:Clear()
				self:AddLogs()
				self.LastSearch = tosearch
			end
		end
		logList:AddLogs()

		c = c + 1 
	end

	if hasfirstopened then
		for k, v in pairs(ba.logs.Data) do
			if ba.logs.Get(k):GetColor() then
				fr:AddData(k, v)
			end
		end
	end
	hasfirstopened = true
end

net.Receive('ba.LogData', function(len)
	-- if LocalPlayer():IsRoot() then
	-- 	print(len)
	-- end
	
	if (not IsValid(fr)) then OpenMenu() end

	local name = net.ReadString()
	local size = net.ReadUInt(16)
	local data = ba.logs.Decode(net.ReadData(size))

	local log = ba.logs.Get(name)
	
	for k, v in ipairs(data) do
		v.Time = os_date('%I:%M:%S', v.Time)
		local c = 0
		local term = ba.logs.GetTerm(v.Term)
		v.Copy = {}
		for k, copy in pairs(term.Copy) do
			v.Copy[copy] = v[k]
		end
		v.Data = term.Message:gsub('#', function()
			c = c + 1
			return v[c]
		end)
	end
	
	ba.logs.Data[name] = data

	fr:AddData(name, data)
end)