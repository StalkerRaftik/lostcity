surface.CreateFont( "TargetID", {
	font = "Roboto",
	size = ba.ScreenScale(20),
	extended = true,
	weight = 800,
	--outline=true
})

surface.CreateFont( "ChatLine", {
	font = "Roboto",
	size = ba.ScreenScale(24),
	extended = true,
	weight = 400,
})

local surface_SetMaterial = surface.SetMaterial
local surface_DrawTexturedRect = surface.DrawTexturedRect
local surface_DrawText = surface.DrawText
local surface_SetDrawColor = surface.SetDrawColor
local surface_DrawRect = surface.DrawRect
local surface_DrawOutlinedRect = surface.DrawOutlinedRect
local surface_SetFont = surface.SetFont
local surface_GetTextSize = surface.GetTextSize
local surface_SetAlphaMultiplier = surface.SetAlphaMultiplier
local surface_SetAlphaMultiplier = surface.SetAlphaMultiplier
local surface_SetTextColor = surface.SetTextColor
local surface_SetTextPos = surface.SetTextPos
local draw_TextShadow = draw.TextShadow
local draw_Blur = draw.Blur


local function ParseForEmotes(...)
	local data = {...};
	
	if (ba.twitchEmotes) then
		local k = 0;
		while (k < #data) do
			k = k + 1;
			local v = data[k];
			if (type(v) == "table") then
				local first = true;
				local shouldgoto;
				for m, n in pairs(v) do
					if (shouldgoto and m < shouldgoto) then
						continue
					elseif (shouldgoto) then
						shouldgoto = nil
					end
					
					if (type(n) == "string" and (!first or n[1] == ":")) then
						first = nil;
						
						local earliest = math.huge
						local emote
						for i, l in pairs(ba.twitchEmotes) do
							local pos = string.find(n, i, 1, true);
							if (pos and pos < earliest) then
								earliest = pos
								emote = i
							end
						end
						
						if (emote) then
							local repwith = n:sub(1, earliest-1)
							local add = n:sub(earliest+#emote)
							local em = ba.twitchEmotes[emote]
							
							data[k][m] = repwith
							table.insert(data[k], m+1,add);
							table.insert(data[k], m+1, em);
							
							shouldgoto = m + 2
						end
					end
				end
			end
		end
	end
	
	return data;
end


function ba.CreateChatBox()
	local frame = vgui.Create('ba_chatbox')
	
	frame:AddMessage({Color(255, 100, 0), '> ', Color(255, 255, 255), 'Добро пожаловать на ', Color(51, 128, 255), 'Lost-City'})
	frame:AddMessage({Color(255, 100, 0), '> ', Color(255, 255, 255), 'Группа ВК - ', Color(51, 128, 255), 'vk.com/octopusgmod'})
	frame:AddMessage({Color(255, 100, 0), '> ', Color(255, 255, 255), 'Контент - ', Color(51, 128, 255), 'https://vk.cc/ahVql0'})
	frame:AddMessage({Color(255, 100, 0), '> ', Color(255, 255, 255), 'Discord - ', Color(51, 128, 255), 'discord.gg/ngHafFe'})

	return frame
end

local LABEL = {}
function LABEL:Init()
	self._Colors = {}
	self._Emotes = {}
	self._Text = ''
	self._SelStart = 0
	self._SelEnd = 0
	self._SelText = ''
	self._Bits = {}
	
	self.Expire = SysTime() + 15
	self.Created = SysTime()
	
	self:SetText('')
end

function LABEL:SizeToContents(w)
	surface_SetFont('TargetID')
	
	local w, h = 0, 0;
	for i=1, utf8.len(self._Text) do
		if (self._Emotes[i]) then
			h = 16;
			table.insert(self._Chars, {'', w, 16})
			w = w + 16;
		else
			local t = utf8_sub(self._Text, i, i)
			local wid, th = surface_GetTextSize(t)
		
			if (h == 0) then h = th; end

			if (t == '&') then wid = 12 end
			table.insert(self._Chars, {t, w, wid})
			w = w + wid
		end
	end
	self:SetSize(w, h)
end

function LABEL:SetText(val)
	self._Text = val
	self._Bits = {}
	
	self._Chars = {}
			
	surface_SetFont('TargetID')
	
	self:SizeToContents()
end

function LABEL:AddColor(Pos, Col)
	self._Colors[Pos] = Col
	self._Bits = {}
end

function LABEL:AddEmote(Pos, Emote)
	self._Emotes[Pos] = Emote;
	self._Bits = {}
end

function LABEL:GetSelectedText()
	return self._SelText
end

function LABEL:Think()
	self._SelText = ''
	
	local x1 = nil
	local x2 = nil
	
	if (self._SelStart != 0 or self._SelEnd != 0) then
		local endx
		for k, v in ipairs(self._Chars) do
			if (self._SelStart <= v[2] + v[3] and self._SelEnd >= v[2] + v[3]) then
				self._SelText = self._SelText .. v[1] .. ((k == self._Chars) and '\n' or '')
				v.Sel = true
				
				if (!x1) then x1 = v[2] end
			else
				v.Sel = false
				
				if (x1 and !x2) then x2 = v[2] - x1 end
			end
			endx = v[2] + v[3]
		end
		if (x1 and !x2) then x2 = endx - x1 end
	end
	
	self._HighX1 = x1
	self._HighX2 = x2
	
	if (!self._Bits[1]) then
		local lastcol = Color(0, 0, 0)
		local lastpos = 1
		local lastx = 0;
		local str = ''
		
		for k, v in ipairs(self._Chars) do
			if (self._Colors[k]) then
				str = utf8_sub(self._Text, lastpos, k - 1)
				
				table.insert(self._Bits, {str, self._Chars[lastpos][2], lastcol})
				
				lastpos = k

				lastcol = self._Colors[k]
			end
			
			if (self._Emotes[k]) then
				str = utf8_sub(self._Text, lastpos, k - 1)
				
				table.insert(self._Bits, {str, self._Chars[lastpos][2], lastcol})
				
				if (self._Chars[k-1]) then
					table.insert(self._Bits, {'', self._Chars[k-1][2] + self._Chars[k-1][3], lastCol, Emote = self._Emotes[k]});
				else
					table.insert(self._Bits, {'', 0, lastCol, Emote = self._Emotes[k]})
				end
				
				lastpos = k+1
				
				//lastx = lastx
			end
		end
		
		if (self._Text[lastpos] and self._Chars[lastpos]) then
			str = utf8_sub(self._Text, lastpos)
				
			table.insert(self._Bits, {str, self._Chars[lastpos][2], lastcol})
		end
	end
end

function LABEL:GetSelText()
	return self._SelText or ''
end

local blk = Color(0, 0, 0)
function LABEL:Paint(w, h)
	if (SysTime() > self.Expire) and (CHATBOX and !CHATBOX._Open) then return true end
	
	local fin = math.Clamp((SysTime() - (self.Expire - 15)) / .25, 0, 1)
	if (!CHATBOX._Open and fin == 1) then
		-- calc alpha and override mul
		local a = 1 - (math.Clamp((SysTime() - self.Expire) + 2, 0, 2) / 2)
		surface_SetAlphaMultiplier(a)
	else
		surface_SetAlphaMultiplier(fin)
	end
	
	local h = self:GetTall()
	local outcol = Color(0, 0, 0)
	local emoteswide = 0;
	
	if (self._HighX1 and self._HighX2) then
		surface_SetDrawColor(200, 200, 200, 100)
		surface_DrawRect(self._HighX1, 0, self._HighX2, h)
	end
	
	for k, v in ipairs(self._Bits) do
		if (v.Emote) then
			surface_SetDrawColor(255, 255, 255);
			surface_SetMaterial(v.Emote);
			surface_DrawTexturedRect(v[2], (h - 16) / 2, 16, 16);
		else
			v[3].a = math.Clamp((SysTime() - self.Created) / 0.5, 0, 1) * 255
			
			v.tab = v.tab or { -- idek what number to put it
				pos = {v[2]+1, ((self:GetTall() == 16 and 1) or 0)},
				color = v[3],
				text = v[1],
				font = 'TargetID',
				xalign = 0,
				yalign = 0
			}
			
			draw_TextShadow(v.tab, 1, v[3].a)
		end
	end
	
	return true
end
derma.DefineControl('ba_chatlabel', 'Badmin Chatbox Label', LABEL, 'DLabel')

local PANEL = {}

function PANEL:OnMouseReleased(b)
	self.Selecting = nil
end

function PANEL:Init()
	self._Open = false
	self._Messages = {}
	self._Team = false
	
	self.History = {}
	
	self.msgFrame = vgui.Create('ui_scrollpanel', self)
	self.msgFrame:HideScrollbar(true) 
	self.msgFrame:SetScrollSize(2)
	
	self.OvermsgFrame = vgui.Create('ui_scrollpanel', self)
	self.OvermsgFrame.PaintOver = function() end
	
	self.OvermsgFrame.Paint = function() end
	
	self.OvermsgFrame.Think = function(s)
		local y = 0
		local off = math.abs(self.msgFrame.yOffset)
		local mp = {gui.MouseX() - s.x - self.x, gui.MouseY() - s.y - self.y + self.msgFrame.yOffset}
		local firstx, firsty, lastx, lasty
		
		if (self.Selecting) then
			if (self.MouseDown[2] > mp[2]) then firstx = mp[1] firsty = mp[2] lastx = self.MouseDown[1] lasty = self.MouseDown[2] else firstx = self.MouseDown[1] firsty = self.MouseDown[2] lastx = mp[1] lasty = mp[2] end
		end
		
		//if (self.msgFrame.ySpeed and self.msgFrame.ySpeed == 0) then self.msgFrame.AutoScrolling = false end
		
		self.SelectedText = ''
		for k, v in ipairs(self._Messages) do
			if (y >= off - s:GetTall() and y <= off + s:GetTall()) then
				v:SetVisible(true)
			else
				v:SetVisible(false)
			end
			
			if (self.Selecting) then
				if (firsty <= v.y and lasty > v.y + v:GetTall()) then
					v._SelStart = 0
					v._SelEnd = v:GetWide()
				elseif (firsty >= v.y and firsty <= v.y + v:GetTall() - 1) then
					if (lasty > v.y + v:GetTall()) then
						v._SelStart = firstx
						v._SelEnd = v:GetWide()
					else
						if (firstx < lastx) then
							v._SelStart = firstx
							v._SelEnd = lastx
						else
							v._SelStart = lastx
							v._SelEnd = firstx
						end
					end
				elseif (lasty >= v.y and lasty <= v.y + v:GetTall()) then
					if (firsty <= v.y + 10) then
						v._SelStart = 0
						v._SelEnd = lastx
					else
						if (firstx < lastx) then
							v._SelStart = firstx
							v._SelEnd = lastx
						else
							v._SelStart = lastx
							v._SelEnd = firstx
						end
					end
				else
					v._SelStart = 0
					v._SelEnd = 0
				end
			end
			
			self.SelectedText = self.SelectedText .. v:GetSelText()
		
			y = y + v:GetTall()
		end
	end
	
	self.OvermsgFrame.OnMouseWheeled = function(s, ...)
		return self.msgFrame:OnMouseWheeled(...)
	end
	
	self.OvermsgFrame.OnMousePressed = function(s, b)
		local sb = self.msgFrame.scrollBar.scrollButton
		local sbx, sby = sb:CursorPos()
		
		if (sbx >= 0 and sbx <= sb:GetWide() and sby >= 0 and sby <= sb:GetTall()) then
			sb:OnMousePressed(b)
		else
			self.MouseDown = {gui.MouseX() - self.x - s.x, gui.MouseY() - self.y - s.y + self.msgFrame.yOffset}
			self.Selecting = true
		end
	end
	
	self.OvermsgFrame.OnMouseReleased = function(s, b)
		self.Selecting = false
	end	
	
	-- if (GAMEMODE.Name == "DarkRP") then
		self.btnChats = ui.Create("DButton", function(btn)
			btn:SetVisible(false)
			btn:SetText("Чат каналы")
			btn.DoClick = function()
				RunConsoleCommand('rp_chats')
				self:Close()
			end
		end, self)
	-- end
	
	self.txtEntry = vgui.Create('DTextEntry', self)
	self.txtEntry:SetDrawBackground(false)
	self.txtEntry:SetVisible(false)

	self.txtEntry.PaintOver = function(s, w, h)
		if (!s.AutoFillText) then return end
		
		surface_SetFont('ChatLine')
		
		local x = surface_GetTextSize(s:GetValue())
		local w, h = surface_GetTextSize(s.AutoFillText)
		
		surface_SetDrawColor(s:GetHighlightColor())
		surface_DrawRect(x+3, 1, w, h+1)
		surface_SetTextColor(ui.col.White)
		surface_SetTextPos(x+3, 1)
		surface_DrawText(s.AutoFillText)
	end

	self.txtEntry.OnKeyCodeTyped = function(s, c)
		if (c == KEY_TAB) or ((c == KEY_RIGHT) and (s:GetCaretPos() == #s:GetValue())) then
			-- Thanks, Scorpy!
			self:DoAutoFill()
			s:OnTextChanged()
			s:SetCaretPos(#s:GetValue())
		elseif (c == KEY_UP) then
			if (self.History[s.historyPos + 1]) then
				s.historyPos = s.historyPos + 1;
				s:SetText(self.History[s.historyPos]);
				s:SelectAll();
			end
		elseif (c == KEY_DOWN) then
			if (self.History[s.historyPos - 1] or s.historyPos - 1== 0) then
				s.historyPos = s.historyPos - 1;
				s:SetText(self.History[s.historyPos] or "");
				s:SelectAll();
			end
		elseif (c == KEY_ENTER) then
			RunConsoleCommand("say" .. ((self._Team and "_team") or ""), s:GetValue())
			if (string.Trim(s:GetValue()) != "") then
				table.insert(self.History, 1, s:GetValue());
			end
			self:Close()
		elseif (c == KEY_ESCAPE) then
			self:Close()
			
			RunConsoleCommand("cancelselect")
		end
	end

	self.txtEntry.OnLoseFocus = function(s)
		if (input.IsKeyDown(KEY_TAB)) then
			s:RequestFocus()
			s:SetCaretPos(#s:GetText())
		end
	end
	
	self.txtEntry.OnTextChanged = function(s)
		local auto = self:DoAutoFill(true)
		
		s.AutoFillText = auto or nil
		
		if (s:AllowInput()) then
			s:SetValue(string.sub(s:GetValue(), 1, 126))
			s:SetCaretPos(126)
		end
		
		gamemode.Call('ChatTextChanged', s:GetValue())
	end

	self.txtEntry.AllowInput = function(s)
		if (string.len(s:GetValue()) >= 126) then
			surface.PlaySound('Resource/warning.wav')
			return true
		end
	end
	
	self:PerformLayout()
end

function PANEL:OnKeyCodePressed(k)
	if (k == KEY_C) and (input.IsKeyDown(KEY_LCONTROL)) then
		if (self.SelectedText and self.SelectedText != '') then
			SetClipboardText(self.SelectedText)
		end
	end
end

function PANEL:PerformLayout()
	self:SetSize(ScrW() * .35, ScrH() * .3)
	self:SetPos(10, ScrH() - self:GetTall() - 10 - 120) 
	
	if (self.btnChats) then
		self.btnChats:SizeToContents()
		self.btnChats:SetWide(self.btnChats:GetWide() + 10)
	end
	
	self.txtEntry:SetFont('ChatLine')
	self.txtEntry:SetPos(5, self:GetTall() - self.txtEntry:GetTall() - 5)
	if (self.btnChats) then
		self.txtEntry:SetWide(self:GetWide() - 15 - self.btnChats:GetWide())
	
		self.btnChats:SetTall(self.txtEntry:GetTall() + 2)
		self.btnChats:SetPos(self:GetWide() - 5 - self.btnChats:GetWide(), self.txtEntry.y - 1)
	else
		self.txtEntry:SetWide(self:GetWide() - 10)
	end
	
	self.msgFrame:SetPos(5, 5)
	self.msgFrame:SetSize(self:GetWide() - 10, self.txtEntry.y - 10)
	self.OvermsgFrame:SetPos(5, 5)
	self.OvermsgFrame:SetSize(self:GetWide() - 10, self.txtEntry.y - 10)
end 

function PANEL:Think()
	self:MoveToBack()
end

local colblack = Color(0, 0, 0)
local coloutline = Color(ui.col.Outline.r, ui.col.Outline.g, ui.col.Outline.b)
local colteamchat = Color(100, 200, 100)
local colglobalchat = Color(255, 255, 255)
function PANEL:Paint(w, h)
	local a = 0
	if (self._OpenTime) then
		a = math.Clamp((SysTime() - self._OpenTime) / .25, 0, 1)
	elseif (self._CloseTime) then
		a = 1 - math.Clamp((SysTime() - self._CloseTime) / .25, 0, 1)
	end
	
	if (a == 0) then
		if (self.btnChats) then
			self.btnChats:SetVisible(false) 
		end
		return
	end
	
	if (self.btnChats) then
		self.btnChats:SetAlpha(a * 255)
	end
	
	draw_Blur(self, a * 6)
	
	surface_SetDrawColor(0, 0, 0, 150 * a)
	surface_DrawRect(0, 0, w, h)
	
	coloutline.a = a * 255
	surface_SetDrawColor(coloutline)
	surface_DrawOutlinedRect(0, 0, w, h)
	
	local x, y, w, h = self.txtEntry.x - 2, self.txtEntry.y - 2, self.txtEntry:GetWide() + 4, self.txtEntry:GetTall() + 4
	
	colblack.a = a * 255
	surface_SetDrawColor(colblack)
	surface_DrawRect(x + 1, y + 1, w - 2, h - 2)
	
	colteamchat.a = a * 255
	colglobalchat.a = a * 255
	surface_SetDrawColor((self._Team and colteamchat) or colglobalchat)
	surface_DrawRect(x+2, y+2, w-4, h-4)
end

function PANEL:PaintOver(w, h)
end

function PANEL:AddMessage(...)
	local strings = ''
	local colors = {}
	local emotes = {}
	local emotesww = {}
	-- Do replacing with ba.twitchEmotes here
	
	self.LastMaxOffset = math.Clamp(self.msgFrame:GetCanvas():GetTall() - self.msgFrame:GetTall(), 0, math.huge)
	
	table.insert(colors, {Col=Color(200, 200, 200), Pos=1})
	
	local data = !self.DoEmotes and {...} or ParseForEmotes(...);
	self.DoEmotes = false
	
	for k, v in ipairs(data[1]) do
		if (type(v) == 'IMaterial') then
			-- KAAPAPAPAPAK
			strings = strings .. '*'
	
			emotesww[emotes[table.insert(emotes, {Emote = v, Pos=#strings})].Pos] = true
		elseif (type(v) == 'string' or type(v) == 'number') then
			if (v[1] == '>') then
				table.insert(colors, {Col=Color(140, 200, 100), Pos=string.len(strings)});
			end
			strings = strings .. v
		elseif (type(v) == 'Player') then
			if (string.len(strings) == 0) then table.remove(colors, 1) end

			table.insert(colors, {Col=team.GetColor(v:Team()), Pos=string.len(strings) + 1})
			 
			strings = strings .. v:Name()
		else
			if (string.len(strings) == 0) then table.remove(colors, 1) end
			table.insert(colors, {Col=v, Pos=utf8.len(strings) + 1}) 
		end
	end
	
	local texts = ba.ui.WordWrap('TargetID', strings, self.msgFrame:GetWide() - 5, emotesww)
	local shouldPopDown
	if (self.msgFrame:IsAtMaxOffset()) then
		shouldPopDown = true
	end
	
	local cursnip = 1
	for k, v in ipairs(texts) do
		if (v == '') then continue end
		
		if (self._Messages[1000]) then self._Messages[1]:Remove() table.remove(self._Messages, 1) end
		
		local lbl = vgui.Create('ba_chatlabel', self.msgFrame:GetCanvas())
		lbl:SetFont('TargetID')
		
		table.insert(self._Messages, lbl)
		
		for i, l in ipairs(colors) do
			if (l.Pos <= cursnip and (!colors[i+1] or colors[i+1].Pos > cursnip)) then
				lbl:AddColor(1, l.Col)
			elseif (l.Pos >= cursnip and l.Pos < cursnip + utf8.len(v)) then
				lbl:AddColor(l.Pos - cursnip + 1, l.Col)
			end
		end
		
		for i, l in ipairs(emotes) do
			if (l.Pos >= cursnip and l.Pos < cursnip + utf8.len(v)) then
				lbl:AddEmote(l.Pos - cursnip + 1, l.Emote)
			end
		end
		lbl:SetText(v)
		self.msgFrame:AddItem(lbl)
		
		cursnip = cursnip + utf8.len(v)
	end
	
	chat.PlaySound()
	
	if (shouldPopDown) then
		self.msgFrame.yOffset = math.Clamp(self.msgFrame:GetCanvas():GetTall() - self.msgFrame:GetTall(), 0, math.huge)
	end
	
	self:InvalidateLayout()
end

function PANEL:DoAutoFill(ret) -- TODO, replace with command autocomplete
	local match
	
	local words = string.Explode(' ', self.txtEntry:GetValue());
	match = words[#words];
 
	if (!match or match == '') then return end

	local pl;
	for k, v in ipairs(player.GetAll()) do
		if ((string.find(v:RPName(true):lower(), match:lower(), 1, true) or -1) == 1) then
			pl = v;
			break;
		elseif ((string.find(v:RPName():lower(), match:lower(), 1, true) or -1) == 1) then
			pl = v;
			break;
		elseif ((string.find(tostring(v:UserID()):lower(), match:lower(), 1, true) or -1) == 1) then
			pl = v;
			break;			
		end		
	end
		
	if (pl) then
		local pref = string.sub(self.txtEntry:GetValue(), 1, 1)
		local add
		
		local firstarg = string.sub(self.txtEntry:GetValue(), 1, (string.find(self.txtEntry:GetValue(), ' ')  or (#self.txtEntry:GetValue() + 1)) - 1)
		
		if (pref == '/' or pref == '!') and (firstarg != '//' and firstarg != '/ooc' and firstarg != '/ad' and firstarg != '/advert') and (!ret) then
			add = pl:SteamID()
		else
			add = pl:RPName(true)
		end
		
		if (!ret) then
			self.txtEntry:SetText(string.sub(self.txtEntry:GetValue(), 1, -(#match + 1)) .. add .. ' ')
		else
			return string.sub(add, #match+1)
		end
		
		return
	end
end

function PANEL:Open(tm)
	self._Open = true
	self._OpenTime = SysTime()
	self._CloseTime = nil
	
	self._Team = tm
	gamemode.Call('StartChat')
	
	self:MakePopup()
	self:MoveToFront()
	
	self.txtEntry:SetVisible(true)
	self.txtEntry:RequestFocus()
	self.txtEntry.historyPos = 0
	
	if (self.btnChats) then
		self.btnChats:SetVisible(true)
	end
	
	self.msgFrame:HideScrollbar(false)
end

function PANEL:Close()
	if (!self._Open) then return end
	
	if (self.ForceOpen) then
		gamemode.Call('FinishChat')
		gamemode.Call('ChatTextChanged', '')
		self.txtEntry:SetText('')

		return
	end
	
	self._Open = false
	self._OpenTime = nil
	self._CloseTime = SysTime()
	
	self.msgFrame.yOffset = math.Clamp((self.msgFrame:GetCanvas():GetTall() - self.msgFrame:GetTall()), 0, math.huge)
	self.msgFrame:InvalidateLayout()
	self.msgFrame:HideScrollbar(true)
	
	gamemode.Call('FinishChat')
	
	self:SetMouseInputEnabled(false)
	self:SetKeyboardInputEnabled(false)
	
	gamemode.Call('ChatTextChanged', '')
	
	self.txtEntry:SetVisible(false)
	self.txtEntry:SetText('')
	self.txtEntry:OnTextChanged()
	
	//self.btnChats:SetVisible(false)
	self:MoveToBack()
end

derma.DefineControl('ba_chatbox', 'Badmin Chatbox', PANEL, 'EditablePanel')

if (CHATBOX) then CHATBOX:Remove() CHATBOX = ba.CreateChatBox() end