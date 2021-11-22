ba.AddTerm('StaffReqLonger', 'Слишком короткое сообщение (<10+ символов)!')

if (SERVER) then
	util.AddNetworkString 'ba.AdminChat'

	hook.Add('PlayerSay', 'ba.AdminChat', function(pl, text)
		if (text[1] == '#') then
			text = text:sub(2):Trim()
			
			if (not pl:IsAdmin() and text:len() < 10) then
				ba.notify_err(pl, ba.Term('StaffReqLonger'))
			else
				net.Start('ba.AdminChat')
					net.WriteEntity(pl)
					net.WriteString(pl:SteamID())
					net.WriteString(text)
					net.WriteFloat(CurTime())
				net.Send(ba.GetStaff())
				
			end
			
			return ''
		end
	end)
else
	net.Receive('ba.AdminChat', function()
		local pl = net.ReadEntity()
		local stid = net.ReadString()
		if IsValid(pl) then
			if (pl:IsAdmin()) then
				local msg = net.ReadString()

				if IsValid(CHATBOX) then
					chat.AddText(Color(255,100,100), '> ', Color(200,0,0), '[АДМИН-ЧАТ] ', Color(255,255,255), pl:RPName(true), Color(255,255,255), ': ', Color(255,255,255), msg)
					hook.Call("PlayerUseAdminChat", GAMEMODE, pl, msg)
				end
			end
		end
	end)

end
