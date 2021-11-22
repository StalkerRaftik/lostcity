local easynet = SH_WHITELIST.easynet

-- SERVER -> CLIENT
easynet.Start("SH_WHITELIST.SendWhitelistSteamID")
	easynet.Add("steamid", EASYNET_STRING)
	easynet.Add("jobs", EASYNET_STRING, true)
easynet.Register()

easynet.Start("SH_WHITELIST.SendWhitelistUsergroup")
	easynet.Add("usergroup", EASYNET_STRING)
	easynet.Add("jobs", EASYNET_STRING, true)
easynet.Register()

easynet.Start("SH_WHITELIST.SendWhitelistPlayer")
	easynet.Add("jobs", EASYNET_STRING, true)
easynet.Register()

easynet.Start("SH_WHITELIST.SendWhitelistSaved")
	easynet.Add("steamids", EASYNET_STRING, true)
	easynet.Add("usergroups", EASYNET_STRING, true)
easynet.Register()

easynet.Start("SH_WHITELIST.Notify")
	easynet.Add("message", EASYNET_STRING)
	easynet.Add("good", EASYNET_BOOL)
easynet.Register()

easynet.Start("SH_WHITELIST.OpenMenu")
easynet.Register()

easynet.Start("SH_WHITELIST.FactionMenu")
	easynet.Add("changing", EASYNET_BOOL)
easynet.Register()

-- CLIENT -> SERVER
easynet.Start("SH_WHITELIST.WhitelistSteamID")
	easynet.Add("steamid", EASYNET_STRING)
	easynet.Add("jobs", EASYNET_STRING, true)
	easynet.Add("whitelisted", EASYNET_BOOL, true)
easynet.Register()

easynet.Start("SH_WHITELIST.WhitelistUsergroup")
	easynet.Add("usergroup", EASYNET_STRING)
	easynet.Add("jobs", EASYNET_STRING, true)
	easynet.Add("whitelisted", EASYNET_BOOL, true)
easynet.Register()

easynet.Start("SH_WHITELIST.ReqWhitelistSteamID")
	easynet.Add("steamid", EASYNET_STRING)
easynet.Register()

easynet.Start("SH_WHITELIST.ReqWhitelistUsergroup")
	easynet.Add("usergroup", EASYNET_STRING)
easynet.Register()

easynet.Start("SH_WHITELIST.ReqWhitelistPlayer")
	easynet.Add("target", EASYNET_PLAYER)
easynet.Register()

easynet.Start("SH_WHITELIST.ReqWhitelistSaved")
easynet.Register()

easynet.Start("SH_WHITELIST.InMenu")
	easynet.Add("active", EASYNET_BOOL)
easynet.Register()

easynet.Start("SH_WHITELIST.PlayerReady")
easynet.Register()

easynet.Start("SH_WHITELIST.OptimizeDatabase")
easynet.Register()

easynet.Start("SH_WHITELIST.FactionChosen")
	easynet.Add("id", EASYNET_UINT8)
easynet.Register()

-- Callbacks
if (SERVER) then
	easynet.Callback("SH_WHITELIST.WhitelistSteamID", function(data, ply)
		SH_WHITELIST:WhitelistSteamID(ply, data.steamid, data.jobs, data.whitelisted)
	end)

	easynet.Callback("SH_WHITELIST.WhitelistUsergroup", function(data, ply)
		SH_WHITELIST:WhitelistUsergroup(ply, data.usergroup, data.jobs, data.whitelisted)
	end)

	easynet.Callback("SH_WHITELIST.ReqWhitelistSteamID", function(data, ply)
		SH_WHITELIST:SendWhitelist(ply, data.steamid, nil)
	end)

	easynet.Callback("SH_WHITELIST.ReqWhitelistUsergroup", function(data, ply)
		SH_WHITELIST:SendWhitelist(ply, nil, data.usergroup)
	end)

	easynet.Callback("SH_WHITELIST.ReqWhitelistPlayer", function(data, ply)
		if (!SH_WHITELIST:CanWhitelist(ply)) then
			return end

		SH_WHITELIST:SendPlayerWhitelist(ply, data.target)
	end)

	easynet.Callback("SH_WHITELIST.ReqWhitelistSaved", function(data, ply)
		if (!SH_WHITELIST:CanWhitelist(ply)) then
			return end

		SH_WHITELIST:SendWhitelistSaved(ply)
	end)

	easynet.Callback("SH_WHITELIST.InMenu", function(data, ply)
		if (data.active and !SH_WHITELIST:IsAdmin(ply)) then
			return end

		ply.SH_WHITELIST_MENU = data.active
	end)

	easynet.Callback("SH_WHITELIST.PlayerReady", function(data, ply)
		if (ply.SH_WHITELIST_READY) then
			return end

		ply.SH_WHITELIST_READY = true
		SH_WHITELIST:ApplyWhitelist(ply)
		SH_WHITELIST:FactionPlayerReady(ply)
	end)

	easynet.Callback("SH_WHITELIST.OptimizeDatabase", function(data, ply)
		SH_WHITELIST:OptimizeDatabase(ply)
	end)

	easynet.Callback("SH_WHITELIST.FactionChosen", function(data, ply)
		SH_WHITELIST:FactionChosen(ply, data.id)
	end)
else
	easynet.Callback("SH_WHITELIST.SendWhitelistSteamID", function(data)
		local jobs = {}
		for i = 1, #data.jobs do
			jobs[data.jobs[i]] = true
		end

		local ply = player.GetBySteamID(data.steamid)
		if (IsValid(ply)) then
			SH_WHITELIST:ApplyWhitelist(ply)
		end

		SH_WHITELIST.Whitelisted.players[data.steamid] = jobs
		SH_WHITELIST:CallPanelHook("OnWhitelistReceived", jobs, data.steamid, data.usergroup)
	end)

	easynet.Callback("SH_WHITELIST.SendWhitelistUsergroup", function(data)
		local jobs = {}
		for i = 1, #data.jobs do
			jobs[data.jobs[i]] = true
		end

		for _, v in ipairs (player.GetAll()) do
			if (v:IsUserGroup(data.usergroup)) then
				SH_WHITELIST:ApplyWhitelist(v)
			end
		end

		SH_WHITELIST.Whitelisted.usergroups[data.usergroup] = jobs
		SH_WHITELIST:CallPanelHook("OnWhitelistReceived", jobs, data.steamid, data.usergroup)
	end)

	easynet.Callback("SH_WHITELIST.SendWhitelistPlayer", function(data)
		SH_WHITELIST:CallPanelHook("OnPlayerWhitelistReceived", data.jobs)
	end)


	easynet.Callback("SH_WHITELIST.SendWhitelistSaved", function(data)
		SH_WHITELIST:CallPanelHook("OnSavedWhitelistReceived", data.steamids, data.usergroups)
	end)

	easynet.Callback("SH_WHITELIST.Notify", function(data)
		SH_WHITELIST:Notify(data.message, nil, SH_WHITELIST.Style[data.good and "success" or "failure"], IsValid(_SH_WHITELIST) and _SH_WHITELIST or nil) // 76561198059738127
	end)

	easynet.Callback("SH_WHITELIST.OpenMenu", function(data)
		SH_WHITELIST:OpenMenu()
	end)

	easynet.Callback("SH_WHITELIST.FactionMenu", function(data)
		SH_WHITELIST:OpenFactions(data.changing)
	end)

	hook.Add("InitPostEntity", "SH_WHITELIST.InitPostEntity", function()
		easynet.SendToServer("SH_WHITELIST.PlayerReady")
	end)
end