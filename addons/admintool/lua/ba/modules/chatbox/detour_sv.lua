util.AddNetworkString('ba.ToggleChat')

net.Receive('ba.ToggleChat', function(len, pl)
	pl:SetNetVar('IsTyping', not pl:GetNetVar('IsTyping'))
end)

function PLAYER:ChatPrint(...)
	ba.notify(self, ...)
end