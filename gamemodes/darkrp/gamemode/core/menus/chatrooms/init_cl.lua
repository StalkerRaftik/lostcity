include('textmessage_cl.lua')

local sendFunctions = {
	[CHAT_LOCAL] = function(id, msg)
		RunConsoleCommand('say', string.sub(msg, 1, 123))
	end,
	[CHAT_STAFF] = function(id, msg)
		RunConsoleCommand('say', string.sub('@' .. msg, 1, 123))
	end,
	[CHAT_OOC] = function(id, msg)
		RunConsoleCommand('say', string.sub('// ' .. msg, 1, 123))
	end,
	[CHAT_PM] = function(id, msg)
		RunConsoleCommand('say', string.sub('/pm ' .. id .. ' ' .. msg, 1, 123))
	end,
	[CHAT_GROUP] = function(id, msg)
		RunConsoleCommand('say', string.sub('/g ' .. msg, 1, 124))
	end,
	[CHAT_ORG] = function(id, msg)
		RunConsoleCommand('say', string.sub('/org ' .. msg, 1, 122))
	end,
	[CHAT_RADIO] = function(id, msg)
		RunConsoleCommand('say', string.sub('/radio ' .. msg, 1, 120))
	end
}

local fr
local function createChatsMenu(switch)
  if IsValid(fr) then
    if (switch and switch == 'reset') then
      fr:Remove()
	elseif (switch and switch == 'hidden') then
	  return
    else
      fr:SetVisible(true)
      fr:FadeIn(0.2)
      fr:MakePopup()
	  
      return
    end
  end

  local w, h = ScrW() * 0.6, ScrH() * 0.7

  fr = ui.Create('ui_frame', function(self)
    self:SetDeleteOnClose(false)
    self:SetTitle('Доступные чаты')
    self:SetSize(w, h)
	self:Center()
	self.Threads = {}
	
	if (switch and switch == "hidden") then
		self:SetVisible(false)
	else
		self:MakePopup()
	end
  end)
	
  local newW, newH = math.Clamp(w * 0.25, 0, 230), 26
  fr.newPM = ui.Create('DButton', function(self)
	self:SetSize(newW, newH)
	self:SetPos(5, h - newH - 5)
	self:SetText("Написать личное сообщение")
	self.DoClick = function()
		local m = ui.DermaMenu()
		
		local list = player.GetAll()
		table.sort(list, function(p1, p2)
			return p1:Name():lower() < p2:Name():lower()
		end)
		
		for k, v in ipairs(list) do
			if (!fr.Threads[v:SteamID()]) then
				m:AddOption(v:Name(), function()
					fr:CreateThread(CHAT_PM, v:SteamID(), v:Name()):DoClick()
				end)
			end
		end
		m:Open()
	end
  end, fr)
  
  local listW, listH = newW, h - fr:GetTitleHeight() - newH - 8;
  fr.threadList = ui.Create('ui_listview', function(self)
    self:SetSize(listW, listH)
    self:SetPos(5, h - listH - newH - 10)
    self:SetScrollSize(5)
  end, fr)

  local sendW, sendH = 115, newH
  fr.sendBtn = ui.Create("DButton", function(self)
    self:SetSize(sendW, sendH)
    self:SetPos(w - sendW - 5, h - sendH - 5)
    self:SetText("Отправить")
    self.DoClick = function()
      local msg = fr.textBox:GetValue()
      if (string.Trim(msg) == "") then return; end

      for k, v in pairs(fr.Threads) do
        if (v.chat:IsVisible()) then
			if (sendFunctions[v.chatType]) then
				sendFunctions[v.chatType](k, msg)
			end
          v.chat.ySpeed = -1000;
          break;
        end
      end

      fr.textBox:SetText('')
	  fr.textBox:RequestFocus()
    end
  end, fr)

  local txtW, txtH = w - listW - sendW - 20, sendH
  fr.textBox = ui.Create('DTextEntry', function(self)
    self:SetSize(txtW, txtH)
    self:SetPos(w - txtW - sendW - 10, h - txtH - 5)
    self:SetFont('rp.ui.22')
    self.OnEnter = function()
      fr.sendBtn:DoClick()
    end
  end, fr)

  local chatW, chatH = w - listW - 15, listH
  fr.CreateThread = function(fr, chatType, id, title)
	local btn;
    ui.Create('ui_listview', function(chat)
      chat:SetSize(chatW, chatH)
      chat:SetPos(w - chatW - 5, fr.threadList.y)
      chat:SetVisible(false)
      chat:SetScrollSize(5)

      btn = fr.threadList:AddRow(title)
	  
	  btn.OMP = btn.OnMousePressed
	  btn.OnMousePressed = function(s, mb)
		s:OMP(mb)
		
		if (mb == MOUSE_RIGHT) then
			s:DoRightClick()
		end
	  end
	  
      btn.DC = btn.DoClick
      btn.DoClick = function(s)
        s:DC()

        for k, v in pairs(fr.Threads) do
			v.chat:SetVisible(false)
		end

        fr.CurrentThread = chat
        chat:SetVisible(true)
        chat.ySpeed = -1000;
      end
	  
	  btn.Deletable = (chatType == CHAT_PM)
	  btn.DoRightClick = function(s)
		if (!s.Deletable) then return; end
		
		local m = ui.DermaMenu()
		m:AddOption("Удалить", function()
			chat:Remove()
			btn:Remove()
			fr.Threads[id] = nil
			
			fr.Threads['local'].btn:DoClick()
		end)
		m:Open()
	  end
	
      fr.Threads[id] = {
        btn = btn,
        chat = chat,
		chatType = chatType
      }
    end, fr)
	
	return btn
  end

  fr.AddMessage = function(fr, chatType, id, title, sender, text)
    if (!fr.Threads[id]) then
      fr:CreateThread(chatType, id, title)
    end
	fr.Threads[id].btn:SetText(title)

    local chat = fr.Threads[id].chat

    local container = ui.Create('Panel', function(self)
      self:SetSize(chat:GetWide(), 1)
    end)

    ui.Create('rp_textmessage', function(msg)
      msg:SetSize(math.floor(chat:GetWide() * 0.75), 1)

      msg:SetSender(sender)
      msg:SetText(text)

      msg:HandleAlignment()

      container:SetTall(msg:GetTall() + (msg.Sender and msg.Sender:GetTall() or 0))

      chat:AddItem(container)
    end, container)
  end

	if (LocalPlayer():IsAdmin()) then
		fr:CreateThread(CHAT_STAFF, 'staff', 'Админ-чат')
	end
	fr:CreateThread(CHAT_LOCAL, 'local', 'LOCAL')
	fr:CreateThread(CHAT_OOC, 'ooc', 'OOC')

	fr.Threads["ooc"].btn:DoClick()
end

concommand.Add('rp_chats', function(_, _, a) createChatsMenu(a[1]) end)

hook("PlayerUseAdminChat", "ChatRoom.StaffChat", function(pl, msg)
	createChatsMenu('hidden')
	fr:AddMessage(CHAT_STAFF, 'staff', 'Админ-чат', pl, msg)
end)

hook("ChatRoomMessage", "ChatRoom.ParseMessage", function(chatType, plFrom, plTo, text)
	if (!text) then text = plTo end
	
	createChatsMenu('hidden')
	
	if (chatType == CHAT_LOCAL) then
		fr:AddMessage(chatType, 'local', 'LOCAL', plFrom, text)
	elseif (chatType == CHAT_OOC) then
		fr:AddMessage(chatType, 'ooc', 'OOC', plFrom, text)
	elseif (chatType == CHAT_PM) then
		local toward = (plFrom == LocalPlayer() and plTo) or plFrom		
		fr:AddMessage(chatType, toward:SteamID(), toward:Name(), plFrom, text)
	elseif (chatType == CHAT_GROUP) then
		fr:AddMessage(chatType, 'group', LocalPlayer():GetJobName() .. " Chat", plFrom, text)
	elseif (chatType == CHAT_ORG) then
		fr:AddMessage(chatType, 'org', LocalPlayer():GetOrg() .. " Chat", plFrom, text)
	elseif (chatType == CHAT_RADIO) then
		fr:AddMessage(chatType, 'radio', "Radio Chat", plFrom, text)
	end
end)