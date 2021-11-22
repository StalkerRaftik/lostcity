chat.OldAddText = chat.OldAddText or chat.AddText
function chat.AddText(...)
	if IsValid(LocalPlayer()) then 
		CHATBOX = CHATBOX or ba.CreateChatBox()
		CHATBOX:AddMessage({...})
	end
	return chat.OldAddText(...)
end

chat._GetChatBoxSize = chat._GetChatBoxSize or chat.GetChatBoxSize
function chat.GetChatBoxSize()
	if IsValid(CHATBOX) then
		return CHATBOX:GetSize()
	end
	return chat._GetChatBoxSize()
end

chat._GetChatBoxPos = chat._GetChatBoxPos or chat.GetChatBoxPos
function chat.GetChatBoxPos()
	if IsValid(CHATBOX) then
		return CHATBOX:GetPos()
	end
	return chat._GetChatBoxPos()
end

hook.Add('HUDShouldDraw', 'HideDefaultChat', function(name)
	if (name == 'CHudChat') then
		return false
	end
end)

hook.Add('PlayerBindPress', 'OpenChatbox', function(ply, bind, pressed)
	if (!pressed) then return end
	
		CHATBOX = CHATBOX or ba.CreateChatBox()
		CHATBOX.ShowEmotes = true
		
	if (string.find(bind, 'messagemode2')) then
			CHATBOX:Open(true)
		return true
	elseif (string.find(bind, 'messagemode')) then
		CHATBOX:Open(false)
		return true
	end
end)

local function ToggleChat()
	net.Start('ba.ToggleChat')
	net.SendToServer()
end
hook.Add('StartChat', 'ba.chat.StartChat', ToggleChat)
hook.Add('FinishChat', 'ba.chat.FinishChat', ToggleChat)


hook.Add('ChatText', function(plInd, plName, Text, Type)
	if (Type == 'joinleave') then return true end
end)