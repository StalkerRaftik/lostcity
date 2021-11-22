function ba.GetStaff()
	return table.Filter(player.GetAll(), function(pl)
		return pl:IsAdmin()
	end)
end

function ba.IsPlayer(info)
	return (type(info) == 'Player')
end

function ba.IsSteamID(info)
	return (type(info) == 'string' and info:match('^STEAM_%d:%d:%d+$'))
end

function ba.FindPlayer(info) 
	if not info or info == '' then return nil end
	for k, pl in ipairs(player.GetAll()) do
		if info == pl:SteamID() or info == pl:SteamID64() then
			return pl
		end

		if string.find(string.lower(pl:UserID()), string.lower(tostring(info)), 1, true) ~= nil then
			return pl
		end


		if string.find(string.lower(pl:RPName()), string.lower(tostring(info)), 1, true) ~= nil then
			return pl
		end

		if string.find(string.lower(pl:RPName(true)), string.lower(tostring(info)), 1, true) ~= nil then
			return pl
		end
	end
	return nil
end

function ba.InfoTo64(info)
	return (ba.IsPlayer(info) and info:SteamID64() or util.SteamIDTo64(info))
end

function ba.InfoTo32(info)
	return (ba.IsPlayer(info) and info:SteamID() or (ba.IsSteamID(info) and info or util.SteamIDFrom64(info)))
end

function PLAYER:NameID()
	return (self:RPName(true) .. '(' .. self:SteamID() .. ')')
end

function PLAYER:SetBVar(var, val)
	if (self._ba == nil) then
		self._ba = {}
	end
	self._ba[var] = val
end

function PLAYER:GetBVar(var)
	if (self._ba == nil) then
		self._ba = {}
	end
	return self._ba[var]
end