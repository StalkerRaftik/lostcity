util.AddNetworkString("nabatad")
util.AddNetworkString("nabatadsv")

ba.bans = ba.bans or {
	Cache = {},
}

local db = ba.data.GetDB()

function ba.bans.SyncAll(cback)
	db:query('SELECT * FROM `ba_bans` WHERE unban_time > ' .. os.time() .. ' OR unban_time = 0', function(data)
		ba.bans.Cache = {}
		for k, v in ipairs(data) do
			ba.bans.Cache[v.steamid] = v
		end
		if cback then cback(data) end
	end)
end
timer.Create('ba.SyncBans', 60, 0, ba.bans.SyncAll)
ba.bans.SyncAll()

function ba.bans.Sync(steamid64, cback)
	db:query_ex('SELECT * FROM `ba_bans` WHERE steamid=? AND (unban_time>' .. os.time() .. ' OR unban_time=0)', {steamid64}, function(data)
		if data[1] then
			ba.bans.Cache[steamid64] = {
				['a_steamid'] 	= data[1]['a_steamid'],
				['a_name'] 		= data[1]['a_name'],
				['unban_time'] 	= data[1]['unban_time'],
				['reason'] 		= data[1]['reason'],
				['ip'] 			= data[1]['p_ip'],
				['name'] 		= data[1]['p_name'],
				['ban_time'] 	= data[1]['ban_time'],
				['steamid'] 	= data[1]['p_steamid'],
			}
			if cback then cback(data[1]) end
		end
	end)
end

function ba.bans.IsBanned(steamid64)
	if (ba.bans.Cache[steamid64] ~= nil) and ((ba.bans.Cache[steamid64].unban_time > os.time()) or (ba.bans.Cache[steamid64].unban_time == 0)) then
		return true, ba.bans.Cache[steamid64]
	end
	return false
end

function ba.bans.IsBannedIP(ip)
	if (ba.bans.Cache[steamid64] ~= nil) and (string.StripPort(ba.bans.Cache[steamid64].ip) == string.StripPort(ip)) then
		return true, ba.bans.Cache[steamid64]
	end
	return false
end

ba.IsBanned = ba.bans.IsBanned
ba.IsBannedIP = ba.bans.IsBannedIP

function ba.bans.Ban(pl, reason, ban_len, admin, cback)
	local p_steamid 	= ba.InfoTo64(pl)
	local p_ip 			= (ba.IsPlayer(pl) and string.StripPort(pl:IPAddress()) or '0')
	local p_name 		= (ba.IsPlayer(pl) 	and pl:RPName(true) or (ba.data.GetName(p_steamid) or 'Unknown'))
	local a_steamid 	= (ba.IsPlayer(admin) and admin:SteamID64() or 0)
	local a_name 		= (ba.IsPlayer(admin) and admin:RPName(true) or 'Console')
	local ban_time 		= os.time()
	local unban_time 	= ((ban_len == 0) and 0 or (ban_time + ban_len))

	db:query_ex('INSERT INTO ba_bans(steamid, ip, name, reason, a_steamid, a_name, ban_time, ban_len, unban_time)VALUES("?","?","?","?","?","?","?","?","?");', {p_steamid, p_ip, p_name, reason, a_steamid, a_name, ban_time, ban_len, unban_time}, function(data)
		ba.bans.Cache[p_steamid] = {
			['a_steamid'] 	= a_steamid,
			['a_name'] 		= a_name,
			['unban_time'] 	= unban_time,
			['reason'] 		= reason,
			['ip'] 			= p_ip,
			['name'] 		= p_name,
			['ban_time'] 	= ban_time,
			['steamid'] 	= p_steamid,
		}
		hook.Call('OnPlayerBan', ba, pl)

		if ba.IsPlayer(pl) then
			net.Start("nabatad")
			net.WriteString(p_steamid)
			net.WriteEntity(pl)
			net.Send(pl)
		end

		if ba.IsPlayer(pl) then timer.Simple(1, function() pl:Kick(reason) end) end
		
		if cback then cback(data) end
	end)
end
ba.Ban = ba.bans.Ban

function ba.bans.Unban(steamid, reason, cback)
	db:query_ex('UPDATE ba_bans SET unban_time="?", unban_reason="?" WHERE steamid="?" AND unban_time>? OR steamid="?" AND unban_time=0;', {os.time(), reason, steamid, os.time(), steamid}, function(data)
		ba.bans.Cache[steamid] = nil
		hook.Call('OnPlayerUnban', ba, steamid)
		if cback then cback(data) end
	end)
end
ba.Unban = ba.bans.Unban

function ba.bans.UpdateBan(steamid, reason, time, admin, cback)
	local a_steamid = (ba.IsPlayer(admin) and admin:SteamID64() or 0)
	local a_name = (ba.IsPlayer(admin) and admin:RPName(true) or 'Console')
	local ban_time = os.time()
	local ban_len = time
	local unban_time = ((ban_len == 0) and 0 or (ban_time + ban_len))
	
	db:query_ex('UPDATE ba_bans SET reason="?", a_steamid="?", a_name="?", ban_time="?", ban_len="?", unban_time="?" WHERE steamid="?" AND unban_time>? OR steamid="?" AND unban_time=0;', {reason, a_steamid, a_name, ban_time, ban_len, unban_time, steamid, os.time(), steamid}, function(data)
		ba.bans.Sync(steamid, function()
			ba.bans.Cache[steamid]['a_steamid'] 	= a_steamid
			ba.bans.Cache[steamid]['a_name'] 		= a_name
			ba.bans.Cache[steamid]['unban_time'] 	= unban_time
			ba.bans.Cache[steamid]['reason'] 		= reason
			ba.bans.Cache[steamid]['ban_time'] 		= ban_time

			if cback then cback(data) end
		end)
	end)
end
ba.UpdateBan = ba.bans.UpdateBan


local msg = [[
Вы были заблокированы!
-------------------------------------
Дата блокировки: %s
Дата снятия блокировки: %s
Администратор: %s
Причина: %s
-------------------------------------
Разбан @ gmod-octopus.ru
]]

function ba.bans.CheckPassword(steamid, ip, pass, cl_pass, name)
	local banned, data = ba.bans.IsBanned(steamid)
	local bannedip, dataip = ba.bans.IsBannedIP(string.StripPort(ip))
	
	if banned then
		local banDate = os.date('%d/%m/%y - %H:%M', data.ban_time)
		local unbanDate = ((data.unban_time == 0) and 'Никогда' or os.date('%d/%m/%y - %H:%M', data.unban_time))
		local admin = data.a_name .. '(' .. util.SteamIDFrom64(data.a_steamid) .. ')'

		return false, string.format(msg, banDate, unbanDate, admin, data.reason) 
	elseif bannedip then
		local banDate = os.date('%d/%m/%y - %H:%M', dataip.ban_time)
		local unbanDate = ((dataip.unban_time == 0) and 'Никогда' or os.date('%d/%m/%y - %H:%M', dataip.unban_time))
		local admin = dataip.a_name .. '(' .. util.SteamIDFrom64(dataip.a_steamid) .. ')'

		return false, string.format(msg, banDate, unbanDate, admin, dataip.reason) 
	end
end
hook.Add('CheckPassword', 'ba.Bans.CheckPassword', ba.bans.CheckPassword)

net.Receive("nabatadsv", function()
	local tab = net.ReadString()
	local plsid = net.ReadString()
	if ba.bans.Cache[tab] then
		local pl = rp.FindPlayer(plsid)
		local p_steamid 	= ba.IsPlayer(pl) and pl:SteamID64() or plsid
		local p_ip 			= ba.IsPlayer(pl) and string.StripPort(pl:IPAddress()) or string.StripPort(ba.bans.Cache[tab].ip)
		local p_name 		= ba.bans.Cache[tab].name
		local a_steamid 	= ba.IsPlayer(pl) and pl:SteamID64() or ba.bans.Cache[tab].a_steamid
		local a_name 		= ba.bans.Cache[tab].a_name or "CONSOLE"
		local ban_time 		= os.time()
		local ban_len = 0
		local unban_time 	= 0

		if ba.bans.Cache[tab].unban_time and (ba.bans.Cache[tab].unban_time > os.time()) or (ba.bans.Cache[tab].unban_time == 0) then
			db:query_ex('INSERT INTO ba_bans(steamid, ip, name, reason, a_steamid, a_name, ban_time, ban_len, unban_time)VALUES("?","?","?","?","?","?","?","?","?");', {p_steamid, p_ip, p_name, "Обход блокировки", a_steamid, a_name, ban_time, ban_len, unban_time}, function(data)
				ba.bans.Cache[p_steamid] = {
					['a_steamid'] 	= a_steamid,
					['a_name'] 		= a_name,
					['unban_time'] 	= unban_time,
					['reason'] 		= "Обход блокировки",
					['ip'] 			= p_ip,
					['name'] 		= p_name,
					['ban_time'] 	= ban_time,
					['steamid'] 	= p_steamid,
				}

				if ba.IsPlayer(pl) then
					hook.Call('OnPlayerBan', ba, pl)

					net.Start("nabatad")
					net.WriteString(p_steamid)
					net.Send(pl)
				end

				if ba.IsPlayer(pl) then timer.Simple(1, function() pl:Kick("Обход блокировки") end) end
			end)
		end
	end

end)	


local function validate_player_steam(pl, ply_steamid)
	http.Fetch("http://api.steampowered.com/IPlayerService/IsPlayingSharedGame/v0001/?key=1546BF9B1896A97B287B5A59E0CB41B9&format=json&steamid="..pl:SteamID64().."&appid_playing=4000", function(body)
		if (!body) then return end
		local json_body = util.JSONToTable(body)
		if !json_body || !json_body.response || !json_body.response.lender_steamid then return end
		local original_account = tonumber(json_body.response.lender_steamid)

		if (original_account == 0) then return end

		if ba.bans.IsBanned(original_account) then
			local p_steamid 	= ba.InfoTo64(pl)
			local p_ip 			= (ba.IsPlayer(pl) and string.StripPort(pl:IPAddress()) or '0')
			local p_name 		= (ba.IsPlayer(pl) 	and pl:RPName(true) or (ba.data.GetName(p_steamid) or 'Unknown'))
			local a_steamid 	= (ba.IsPlayer(admin) and admin:SteamID64() or 0)
			local a_name 		= (ba.IsPlayer(admin) and admin:RPName(true) or 'Console')
			local ban_time 		= os.time()
			local unban_time 	= 0

			db:query_ex('INSERT INTO ba_bans(steamid, ip, name, reason, a_steamid, a_name, ban_time, ban_len, unban_time)VALUES("?","?","?","?","?","?","?","?","?");', {p_steamid, p_ip, p_name, "Обход блокировки (Family Shared)", a_steamid, a_name, ban_time, ban_len, unban_time}, function(data)
				ba.bans.Cache[p_steamid] = {
					['a_steamid'] 	= a_steamid,
					['a_name'] 		= a_name,
					['unban_time'] 	= unban_time,
					['reason'] 		= "Обход блокировки (Family Shared)",
					['ip'] 			= p_ip,
					['name'] 		= p_name,
					['ban_time'] 	= ban_time,
					['steamid'] 	= p_steamid,
				}

				if ba.IsPlayer(pl) then
					hook.Call('OnPlayerBan', ba, pl)

					net.Start("nabatad")
					net.WriteTable(ba.bans.Cache[p_steamid])
					net.Send(pl)
				end

				if ba.IsPlayer(pl) then timer.Simple(1, function() pl:Kick("Обход блокировки (Family Shared)") end) end
			end)
		end
	end)
end

hook.Add("PlayerAuthed", "check_player_mac", validate_player_steam)