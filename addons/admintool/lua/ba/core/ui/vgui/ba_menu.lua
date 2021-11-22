local Menu
local Settings

--
-- Player Label
--
PANEL = {}

function PANEL:Init()
	self.Avatar = ui.Create('ui_avatarbutton', self)

	self.Name = ui.Create('DLabel', self)
	self.Name:SetTextColor(ui.col.ButtonText)

	self.Copy = ui.Create('DButton', self)
	self.Copy:SetText('Copy SteamID')
	self.Copy.DoClick = function()
		SetClipboardText(self.SteamID)
	end
end

function PANEL:PerformLayout()
	self.Avatar:Dock(LEFT)
	self.Avatar:SetWide(32)
	self.Avatar:DockMargin(2, 2, 2, 2)
	
	self.Name:Dock(LEFT)
	self.Name:DockMargin(2, 2, 2, 2)
	self.Name:SizeToContents()

	self.Copy:Dock(RIGHT)
	self.Copy:SetWide(115)
	self.Copy:DockMargin(7.5, 7.5, 7.5, 7.5)
end

function PANEL:GetValue()
	return self.SteamID
end

function PANEL:SetPlayer(pl)
	self.Player = pl
	self.SteamID = pl:SteamID()
	self.Avatar:SetPlayer(pl)
	self.Name:SetText(pl:NameID())
end

vgui.Register('ba_menu_playerlabel', PANEL, 'ui_panel')



--
-- Time select
--
PANEL = {}

function PANEL:Init()
	self.Num = self:Add('DComboBox')
	self.Num:SetValue('Number')
	self.Num:SetFont('ui.22')
	self.Num.OnSelect = function(panel, index, value)
		self.numValue = value
	end
	for i = 1, 30 do
		self.Num:AddChoice(i)
	end

	self.Unit = self:Add('DComboBox')
	self.Unit:SetValue('Unit')
	self.Unit:SetFont('ui.22')
	self.Unit.OnSelect = function(panel, index, value)
		self.Value = value
	end
	for k, v in pairs(ba.NumberUntits) do
		self.Unit:AddChoice(k)
	end
end

function PANEL:PerformLayout()
	self.Num:SetSize(self:GetWide()/2 - 2.5)
	self.Num:Dock(LEFT)

	self.Unit:SetSize(self:GetWide()/2 - 2.5)
	self.Unit:Dock(RIGHT)
end

function PANEL:GetValue()
	if (self.numValue == nil) or (self.Value == nil) then
		return nil
	end
	return (self.numValue .. self.Value)
end

function PANEL:Paint() end

vgui.Register('ba_menu_timeselect', PANEL, 'ui_panel')



--
-- Player
--
PANEL = {}

function PANEL:Init()
	self.Selected = false
	
	self.Avatar = ui.Create('ui_avatarbutton', self)

	self.Name = ui.Create('DLabel', self)
	self.Name:SetFont('ui.22')
	self.Name:SetTextColor(ui.col.ButtonText)

	self.Checkbox = ui.Create('DButton', self)
	self.Checkbox:SetText('')
	self.Checkbox.DoClick = function()
		if (Menu.Player ~= self) then
			if (Menu.Player ~= nil) then
				Menu.Player.Selected = false
			end
			Menu.Player = self
			self.Selected = true
			Menu:SetStage(2)
		else
			if (Menu.CMD ~= nil) then
				Menu.CMD.Selected = false
			end
			Menu.Player = nil
			self.Selected = false
			Menu:SetStage(1)
		end
	end
	self.Checkbox.GetChecked = function()
		return self.Selected
	end
	self.Checkbox.Paint = function(self, w, h)
		derma.SkinHook('Paint', 'CheckBox', self, w, h)
	end

	self:SetTall(34)
end

function PANEL:PerformLayout()
	self.Avatar:Dock(LEFT)
	self.Avatar:SetWide(32)
	self.Avatar:DockMargin(2, 2, 2, 2)
	
	self.Name:Dock(LEFT)
	self.Name:DockMargin(2, 2, 2, 2)
	self.Name:SizeToContents()

	self.Checkbox:Dock(RIGHT)
	self.Checkbox:SetWide(22.5)
	self.Checkbox:DockMargin(7.5, 7.5, 7.5, 7.5)
end

function PANEL:SetPlayer(pl)
	self.Player = pl
	self.SteamID = pl:SteamID()
	self.Avatar:SetPlayer(pl)
	self.Name:SetText(self.Player:RPName(true))
end

function PANEL:SetStartTime(time)
	self.StartTime = time
end

function PANEL:Think()
	if (self.StartTime) then
		local diff = CurTime() - self.StartTime
		local mins = math.floor(diff / 60)
		local secs = math.floor(diff % 60)
		
		self.PlayerName = (IsValid(self.Player) and self.Player:Name()) or self.PlayerName
		
		self.Name:SetText(Format("(%d:%02d) %s", mins, secs, self.PlayerName))
	end
end

vgui.Register('ba_menu_player', PANEL, 'ui_panel')



--
-- Command
--
PANEL = {}

function PANEL:Init()
	self.Selected = false	

	self.Icon = ui.Create('DImage', self)

	self.Name = ui.Create('DLabel', self)
	self.Name:SetFont('ui.22')
	self.Name:SetTextColor(ui.col.ButtonText)

	self.Checkbox = ui.Create('DButton', self)
	self.Checkbox:SetText('')
	self.Checkbox.DoClick = function()
		Menu:RemoveCont()
		if (Menu.CMD ~= self) then
			if (Menu.CMD ~= nil) then
				Menu.CMD.Selected = false
			end
			Menu.CMD = self
			self.Selected = true
			Menu:CreateCont(self.Command)
			Menu:SetStage(3)
		else
			Menu.CMD = nil
			self.Selected = false
			Menu:SetStage(2)
		end
	end
	self.Checkbox.GetChecked = function()
		return self.Selected
	end
	self.Checkbox.Paint = function(self, w, h)
		derma.SkinHook('Paint', 'CheckBox', self, w, h)
	end

	self:SetTall(34)
end

function PANEL:PerformLayout()
	self.Icon:Dock(LEFT)
	self.Icon:SetWide(16)
	self.Icon:DockMargin(4, 8, 4, 8)
	
	self.Name:Dock(LEFT)
	self.Name:DockMargin(2, 2, 2, 2)
	self.Name:SizeToContents()

	self.Checkbox:Dock(RIGHT)
	self.Checkbox:SetWide(22.5)
	self.Checkbox:DockMargin(7.5, 7.5, 7.5, 7.5)
end

function PANEL:SetCommand(c)
	self.Command = c
	self.Icon:SetImage(c:GetIcon())
	self.Name:SetText(c:GetNiceName())
end

vgui.Register('ba_menu_command', PANEL, 'ui_panel')



--
-- Command Args
--
PANEL = {}

function PANEL:Init()
	self.Panels = {}

	self.Name = ui.Create('DLabel', self) 

	self.Run = ui.Create('DButton', function(self, p)
		self:SetText('Run Command')
	end, self)
	self.Run.DoClick = function()
		local c = 'ba ' .. self.Command:GetName()
		for k, v in ipairs(self.Panels) do
			if (v:GetValue() == nil) then break end
			c = c .. ' ' .. ba.str.Quotify(v:GetValue())
		end
		LocalPlayer():ConCommand(c)
	
	end
end

function PANEL:PerformLayout()
	self.Name:SizeToContents()
	self.Name:SetPos(5, 4)

	self.Run:SetSize(self:GetWide() - 10, 25)
end

function PANEL:ApplySchemeSettings()
	self.Name:SetTextColor(ui.col.Close)
	self.Name:SetFont('ui.22')
end

function PANEL:Paint(w, h)
	derma.SkinHook('Paint', 'Frame', self, w, h)
end

function PANEL:SetCommand(c)
	self.Command = c
	self.Name:SetText(c:GetNiceName())

	local h = 32
	local last
	for k, v in pairs(c:GetArgs()) do
		local p = ba.cmd.Param(v.Param)
		last, h = p:CreateMenu(self, self:GetWide(), h, {Key = v.Key})
		self.Panels[#self.Panels + 1] = last
		h = h + 5
	end
	self.Run:SetPos(5, h)
	Menu.h3 = Menu.h + h + 30
end

vgui.Register('ba_menu_commandargs', PANEL, 'ui_panel')



--
-- Checkbox
--
PANEL = {}

function PANEL:SetConVar(var)
	self.Button.DoClick = function()
		self.Button:Toggle()
		cvar.SetValue(var, not cvar.GetValue(var))
	end
	self.Label.DoClick = self.Button.DoClick
	self:SetValue(cvar.GetValue(var) and 1 or 0)
	self:SetTextColor(ui.col.ButtonText)
end

vgui.Register('ba_menu_checkbox', PANEL, 'DCheckBoxLabel')



--
-- Settings
--
PANEL = {}

function PANEL:Init()
	self.lblTitle:SetText('Settings')
	self.Settings = ui.Create('DButton', self)
	self.Settings:SetText('')
	surface.SetFont('ui.22')
	self.Settings:SetSize(surface.GetTextSize('bAdmin') + 10, 27)
	self.Settings:SetPos(0, 4)

	self.Settings.Paint = function(s, w, h)
		if self.Settings.Hovered then
			draw.Box(5, h - 8, w - 5, 2, ui.col.SUP)
		end
	end
	self.Settings.DoClick = function()
		self:Close(function()
			ba.ui.OpenMenu()
		end)
	end
	
	local h = 32
	for k, v in pairs(cvar.GetTable()) do
		local title = (v:GetMetadata('BAMenu') or v:GetMetadata('Menu'))
		if title then
			ui.Create('ba_menu_checkbox', function(self, p)
				self:SetText(title)
				self:SizeToContents()
				self:SetConVar(v:GetName())
				self:SetPos(5, h)
				h = h + 20
			end, self)
		end
	end

	self:SetSize(ScrW() * .175, ScrH() * .425)
	self:Center()
	self:MakePopup()
end

vgui.Register('ba_menu_settings', PANEL, 'ui_frame')


--
-- Main Menu
--
local function PlayerCMD(a)
	for k, v in pairs(a) do
		if (v.Param == 'player_entity') or (v.Param == 'player_steamid') then
			return true
		end
	end
end

PANEL = {}

function PANEL:Init()
	self.w, self.h = ScrW() * .175, ScrH() * .425
	self.h3 = self.h * 1.5
	
	self.lblTitle:SetText('Administration Menu')

	surface.SetFont('ui.22')
	local a_pos = surface.GetTextSize('b') + 5

	self.Settings = ui.Create('DButton', self)
	self.Settings:SetText('')
	self.Settings.Paint = function(s, w, h)
		if self.Settings.Hovered then
			draw.Box(5, h - 8, w - 10, 2, ui.col.SUP)
			draw.SimpleText('Admin', 'ui.22', a_pos, 0, ui.col.SUP, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM) 
		end
	end
	self.Settings.DoClick = function()
		self:Close(function()
			ba.ui.OpenSettings()
		end)
	end
	
	self.PlayerList = ui.Create('ui_scrollpanel', self)
	self.PlayerList:SetPadding(-1)
	for k, v in ipairs(player.GetAll()) do
		local pl = ui.Create('ba_menu_player')
		pl:SetPlayer(v)
		self.PlayerList:AddItem(pl)
		self['Player_' .. k] = pl
	end

	self.CommandList = ui.Create('ui_scrollpanel', self)
	self.CommandList:SetPadding(-1)
	for k, v in pairs(ba.cmd.GetTable()) do
		if PlayerCMD(v:GetArgs()) and LocalPlayer():HasFlag(v.Flag) then
			print(v.Flag)
			local c = ui.Create('ba_menu_command')
			c:SetCommand(v)
			self.CommandList:AddItem(c)
			self['Command_' .. k] = c
		end
	end

	self:SetSkin('bAdmin')
	self:SetDraggable(true)
	self:MakePopup()

	self:SetAlpha(0)
	self:FadeIn(0.2)

	self:SetSize(self.w, self.h)
	self:Center()
end


function PANEL:PerformLayout()
	self.lblTitle:SizeToContents()
	self.lblTitle:SetPos(5, 3)

	self.btnClose:SetPos(self:GetWide() - 50, 0)
	self.btnClose:SetSize(50, 28)

	surface.SetFont('ui.22')
	self.Settings:SetSize(surface.GetTextSize('bAdmin') + 10, 27)
	self.Settings:SetPos(0, 4)

	self.PlayerList:SetPos(5, 32)
	self.PlayerList:SetSize(self.w - 10, self.h - 37)

	self.CommandList:SetPos(self.w, 32)
	self.CommandList:SetSize(self.w - 5, self.h - 37)
end

function PANEL:ApplySchemeSettings()
	self.lblTitle:SetTextColor(ui.col.Close)
	self.lblTitle:SetFont('ui.22')
end

function PANEL:Paint(w, h)
	derma.SkinHook('Paint', 'Frame', self, w, h)--self.h + 1)
end

function PANEL:CreateCont(c)
	self.Cont = ui.Create('ba_menu_commandargs', self)

	self.Cont:SetPos(0, self.h)
	self.Cont:SetSize(self.w * 2, self.h3)
	self.Cont:SetCommand(c)
end

function PANEL:RemoveCont()
	if IsValid(self.Cont) then
		self.Cont:Remove()
	end
end

function PANEL:SetStage(state)
	if (state == 1) then
		self:SizeTo(self.w, self.h, 0.175, 0, 0.25, cback)
	elseif (state == 2) then
		self:SizeTo(self.w * 2, self.h, 0.175, 0, 0.25, cback)
	else
		self:SizeTo(self.w * 2, self.h3, 0.175, 0, 0.25)
	end
end

function PANEL:Close(cback)
	self.Think = function() end
	self:FadeOut(0.2, function()
		self:Remove()
		if cback then cback() end
	end)
end

vgui.Register('ba_menu', PANEL, 'ui_frame')



function ba.ui.OpenMenu()
	if IsValid(Menu) then Menu:Remove() end
	Menu = ui.Create('ba_menu')
end

function ba.ui.AddCVar(cvar, title)
	ba.ui.Settings[cvar] = title
end

function ba.ui.OpenSettings()
	if IsValid(Settings) then Settings:Remove() end
	Settings = ui.Create('ba_menu_settings')
end