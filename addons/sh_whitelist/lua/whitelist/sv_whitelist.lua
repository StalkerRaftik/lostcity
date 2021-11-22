local easynet = SH_WHITELIST.easynet

if (SH_WHITELIST.UseWorkshop) then
	resource.AddWorkshop("1251198810")
	-- resource.AddWorkshop("76561198059738134")
else
	resource.AddSingleFile("materials/shenesis/general/back.png")
	resource.AddSingleFile("materials/shenesis/general/close.png")
	resource.AddSingleFile("materials/shenesis/general/list.png")
	resource.AddSingleFile("materials/shenesis/general/checked.png")
	resource.AddSingleFile("resource/fonts/circular.ttf")
	resource.AddSingleFile("resource/fonts/circular_bold.ttf")
end

function SH_WHITELIST:DatabaseConnected()
	local dm = self.DatabaseMode
	if (dm == "mysqloo") then
		local to_create = {
			sh_whitelist = [[`type` int(11) NOT NULL, `name` varchar(128) COLLATE utf8_unicode_ci NOT NULL, `whitelisted` text COLLATE utf8_unicode_ci NOT NULL]],
		}

		local function Advance()
			if (table.Count(to_create) > 0) then
				local k = table.GetFirstKey(to_create)
				local d = to_create[k]
				to_create[k] = nil

				self:TryCreateTable(k, d, function()
					Advance()
				end)
			else
				self:BetterQuery([[ALTER TABLE sh_whitelist ADD faction_chosen int(11) NOT NULL DEFAULT 0]], {})

				timer.Simple(1, function()
					self:PostDatabaseConnected()
				end)
			end
		end

		Advance()
	else
		self:TryCreateTable("sh_whitelist", [[`type` INTEGER NOT NULL, `name` TEXT NOT NULL UNIQUE, `whitelisted` TEXT NOT NULL]])

		_SH_QUERY_SILENT = true
			self:BetterQuery([[ALTER TABLE sh_whitelist ADD COLUMN faction_chosen INTEGER NOT NULL DEFAULT 0]], {})
		_SH_QUERY_SILENT = false

		self:PostDatabaseConnected()
	end
end

function SH_WHITELIST:PostDatabaseConnected(cb)
	self:DBPrint("Post database actions..")

	self.Whitelisted = {
		players = {},
		usergroups = {},
	}
	self.FactionsChosen = {}

	self:BetterQuery("SELECT * FROM sh_whitelist", {}, function(q, ok, data)
		if (!ok) then
			return end

		for _, wl in pairs (data) do
			local dest = tonumber(wl.type) == self.TYPE_USERGROUP and self.Whitelisted.usergroups or self.Whitelisted.players
			local tbl = self:ParseCSVLine(wl.whitelisted)
			local jobs = {}
			for _, v in pairs (tbl) do
				jobs[v] = true
			end

			dest[wl.name] = jobs

			if (tonumber(wl.type) == self.TYPE_STEAMID) then
				self.FactionsChosen[wl.name] = tonumber(wl.faction_chosen)
			end
		end

		if (cb) then
			cb()
		end
	end)
end

function SH_WHITELIST:PlayerInitialSpawn(ply)
	ply.SH_WHITELIST = {}
	ply.SH_WHITELIST_USERGROUP = ply:GetUserGroup()

	self.FactionsChosen[ply:SteamID()] = self.FactionsChosen[ply:SteamID()] or 0
	self:ApplyWhitelist(ply)
end

function SH_WHITELIST:PlayerSpawn(ply)
	self:FactionPlayerSpawn(ply)
end

function SH_WHITELIST:SendWhitelist(ply, steamid, usergroup)
	local wl
	if (usergroup) then
		wl = self.Whitelisted.usergroups[usergroup]
	else
		wl = self.Whitelisted.players[steamid]
	end

	local jobs = {}
	if (wl) then
		for k in pairs (wl) do
			table.insert(jobs, k)
		end
	end

	local n, d = "", {jobs = jobs}
	if (usergroup) then
		n = "SH_WHITELIST.SendWhitelistUsergroup"
		d.usergroup = usergroup
	else
		n = "SH_WHITELIST.SendWhitelistSteamID"
		d.steamid = steamid
	end

	easynet.Send(ply, n, d)
end

function SH_WHITELIST:SendWhitelistSaved(ply)
	local steamids, usergroups = {}, {}
	for steamid in pairs (self.Whitelisted.players) do
		table.insert(steamids, steamid:Replace("STEAM_")) -- let's save some bits
	end
	for usg in pairs (self.Whitelisted.usergroups) do
		table.insert(usergroups, usg)
	end

	-- TODO? Compress76561198059738112
	easynet.Send(ply, "SH_WHITELIST.SendWhitelistSaved", {steamids = steamids, usergroups = usergroups})
end

function SH_WHITELIST:SendPlayerWhitelist(ply, target)
	local jobs = {}
	for k in pairs (ply.SH_WHITELIST or {}) do
		table.insert(jobs, k)
	end

	easynet.Send(ply, "SH_WHITELIST.SendWhitelistPlayer", {jobs = jobs})
end

function SH_WHITELIST:WhitelistInternal(type, name, jobs, whitelisted, admin)
	local index = {}
	for _, job in pairs (RPExtraTeams) do
		index[job.name] = job
	end

	local valid, valid2 = {}, {}
	for i, jobname in pairs (jobs) do
		if (!index[jobname] or !self:IsWhitelistJob(index[jobname])) or (admin and !self:CanWhitelist(admin, jobname)) then
			continue end

		table.insert(valid, jobname)
		table.insert(valid2, whitelisted[i])
	end

	if (#valid == 0) then
		return end

	local is_usergroup = type == self.TYPE_USERGROUP
	local tbl
	if (is_usergroup) then
		tbl = self.Whitelisted.usergroups[name]
	else
		tbl = self.Whitelisted.players[name]
	end

	local exists = tbl ~= nil
	tbl = tbl or {}

	for i, job in pairs (valid) do
		if (whitelisted[i]) then
			tbl[job] = true
		else
			tbl[job] = nil
		end
	end

	if (is_usergroup) then
		self.Whitelisted.usergroups[name] = tbl
	else
		self.Whitelisted.players[name] = tbl
	end

	local csv = self:TableToCSV(tbl, true)
	if (exists) then
		self:BetterQuery([[
			UPDATE sh_whitelist
			SET whitelisted = {whitelisted}
			WHERE type = {type} AND name = {name}
		]], {type = type, name = name, whitelisted = csv})
	else
		self:TryInsert([[
			INSERT INTO sh_whitelist (type, name, whitelisted)
			VALUES ({type}, {name}, {whitelisted})
		]], {type = type, name = name, whitelisted = csv})
	end

	local ccat = {}
	local first = valid2[1]
	for i, b in pairs (valid2) do
		if (first == b) then
			table.insert(ccat, valid[i])
		end
	end

	local msg = string.format(self.Language[first and "now_whitelisted_for_x" or "no_longer_whitelisted_for_x"], table.concat(ccat, ", ")) -- 76561198059738127
	for _, v in ipairs (player.GetAll()) do
		if (v:SteamID() == name or v:GetUserGroup() == name) then
			self:ApplyWhitelist(v)

			if (self.NotifyWhitelist) then
				self:Notify(v, msg, first)
			end

			local job = v:Team()
			local jobname = team.GetName(job)
			if (table.HasValue(valid, jobname) and !self:CanBecomeJob(v, job)) then
				self:Notify(v, self.Language.booted_from_job_unwhitelisted, false, jobname)
				v:changeTeam(GAMEMODE.DefaultTeam, true)
			end
		end
	end

	self:SendWhitelist(self:GetInMenu(admin), !is_usergroup and name or nil, is_usergroup and name or nil)

	if (self.UseServerLog) then
		local cc = {}
		for i, jobname in pairs (valid) do
			table.insert(cc, jobname .. " [" .. tostring(valid2[i]):upper() .. "]")
		end

		if (is_usergroup) then
			name = name .. " (" .. self.Language.usergroup .. ")"
		end
		ServerLog(string.format(self.Language.x_changed_whitelist_for_y, admin or "SERVER", name, table.concat(cc, ", ")) .. "\n")
	end
end

function SH_WHITELIST:WhitelistSteamID(admin, steamid, jobs, whitelisted)
	if (admin and !self:Assert(self:CanWhitelist(admin), admin, "no_permission")) then
		return end

	local ply

	if (type(steamid) == "Player") then
		ply = steamid
		steamid = steamid:SteamID()
	elseif (steamid:StartWith("76")) then -- SID64
		steamid = util.SteamIDFrom64(steamid)
	end
	ply = player.GetBySteamID(steamid)

	if (admin and !self:IsAdmin(admin)) then
		if (!self:Assert(self.NonAdminsCanWhitelistAll or IsValid(ply), admin, "no_permission")) then
			return end
	end

	self:WhitelistInternal(self.TYPE_STEAMID, steamid, jobs, whitelisted, admin)
end

function SH_WHITELIST:WhitelistUsergroup(admin, usergroup, jobs, whitelisted)
	if (admin and !self:Assert(self:CanWhitelist(admin), admin, "no_permission")) then
		return end

	if (admin and !self:IsAdmin(admin)) then
		if (!self:Assert(self.NonAdminsCanWhitelistAll and self.NonAdminsCanWhitelistUsergroups, admin, "no_permission")) then
			return end
	end

	if (!self:Assert(self.Usergroups[usergroup] == nil, admin, "this_usergroup_cant_be_whitelisted")) then
		return end

	self:WhitelistInternal(self.TYPE_USERGROUP, usergroup, jobs, whitelisted, admin)
end

function SH_WHITELIST:GetInMenu(except)
	local t = {}
	for _, v in ipairs (player.GetAll()) do
		if (v.SH_WHITELIST_MENU) and (v ~= except) then
			table.insert(t, v)
		end
	end

	return t
end

function SH_WHITELIST:Notify(ply, msg, good, ...)
	local a = {...}
	if (#a > 0) then
		easynet.Send(ply, "SH_WHITELIST.Notify", {message = string.format(msg, unpack(a)), good = good})
	else
		easynet.Send(ply, "SH_WHITELIST.Notify", {message = msg, good = good})
	end
end

-- Erases the tables and creates them again.
-- Map restart needed for client data to reset.
function SH_WHITELIST:WipeData()
	local dm = self.DatabaseMode
	if (dm == "mysqloo") then
		self:BetterQuery([[
			DROP TABLE IF EXISTS sh_whitelist
		]], {})
	else
		self:BetterQuery([[
			DROP TABLE sh_whitelist
		]], {})
	end

	self:DBPrint("Data wiped. Restart the map for changes to fully apply.")
end

function SH_WHITELIST:OptimizeDatabase(ply)
	if (ply and !self:Assert(self:IsAdmin(ply), ply, "no_permission")) then
		return end

	self:DBPrint("Optimizing database..")
	if (ply) then
		ServerLog(ply:Nick() .. " has optimized the SH Whitelist database\n")
	end

	self:BetterQuery([[
		DELETE FROM sh_whitelist
		WHERE whitelisted = ''
	]], {}, function()
		self:PostDatabaseConnected(function()
			if (IsValid(ply)) then
				self:SendWhitelistSaved(ply)
				self:Notify(ply, "database_optimized", true)
			end
		end)
	end)
end

hook.Add("PlayerInitialSpawn", "SH_WHITELIST.PlayerInitialSpawn", function(ply)
	SH_WHITELIST:PlayerInitialSpawn(ply)
end)

hook.Add("PlayerSpawn", "SH_WHITELIST.PlayerSpawn", function(ply)
	SH_WHITELIST:PlayerSpawn(ply)
end)

hook.Add("PlayerSay", "SH_WHITELIST.MenuCommand", function(ply, say)
	if true then return end

	say = say:Replace("!", "/"):lower():Trim()

	if (SH_WHITELIST.MenuCommands[say]) then
		if (SH_WHITELIST:Assert(SH_WHITELIST:CanWhitelist(ply), ply, "no_permission")) then
			easynet.Send(ply, "SH_WHITELIST.OpenMenu")
		end

		return ""
	end

	if (SH_WHITELIST.FactionsEnable and SH_WHITELIST.FactionsCommands[say]) then
		local chosen = SH_WHITELIST.FactionsChosen[ply:SteamID()] > 0
		if (!SH_WHITELIST:Assert(!chosen or SH_WHITELIST.FactionsCanChange(ply), ply, "already_chosen_faction")) then
			return ""
		end

		easynet.Send(ply, "SH_WHITELIST.FactionMenu", {changing = chosen})
		return ""
	end
end)

hook.Add("playerCanChangeTeam", "SH_WHITELIST.playerCanChangeTeam", function(ply, to, force)
	if (force) then
		return end

	if (!SH_WHITELIST:CanBecomeJob(ply, to)) then
		DarkRP.notify(ply, 1, 4, "Вам недоступна эта профессия!")
		return false, SH_WHITELIST.Language.not_whitelisted_for_job or "not_whitelisted_for_job"
	end


	-- LOST CITY блокировки
	local curTeam = rp.teams[ply:Team()]
	local potentialTeam = rp.teams[to]

	-- print(to)
	if to == 1 then
		DarkRP.notify(ply, 1, 4, "Вы не можете сами дезертировать из группировки. Вам необходимо попросить старших из группировки для своего увольнения.")
		return false
	end

	if (potentialTeam.category ~= "Other" and potentialTeam.category ~= curTeam.category) then
		if (curTeam.category == "Other") then
			DarkRP.notify(ply, 1, 4, "Он не имеет права принять чужого в группировку! Найдите главу или его доверенных лиц для вступления!")
			for k, v in pairs(player.GetAll()) do
				if (rp.teams[v:Team()].category == potentialTeam.category) and rp.teams[v:Team()].leader then
			    GAMEMODE.ques:Create(ply:Name() .. ' Хочет вступить\nв вашу группировку, принять?', ply:EntIndex() .. 'fractioninv', v, 20, function(ret)
			      if IsValid(v) and tobool(ret) then
			      	ply:ChangeTeam(to, true)
			      end
			    end, ply, v)
			    return false
				elseif (rp.teams[v:Team()].category == potentialTeam.category) and rp.teams[v:Team()].subleader then
			    GAMEMODE.ques:Create(ply:Name() .. ' Хочет вступить\nв вашу группировку, принять?', ply:EntIndex() .. 'fractioninv', v, 20, function(ret)
			      if IsValid(v) and tobool(ret) then
			      	ply:ChangeTeam(to, true)
			      end
			    end, ply, v)
				end
			end
			return false
		else
			DarkRP.notify(ply, 1, 4, "Вы должны уволиться из своей текущей группировки!")
			return false
		end
	end

end)

timer.Create("SH_WHITELIST.CheckUsergroup", 1, 0, function()
	for _, v in ipairs (player.GetAll()) do
		if (!v.SH_WHITELIST_USERGROUP) then -- nani kore www 76561198059738134
			continue end

		local usg = v:GetUserGroup()
		if (usg ~= v.SH_WHITELIST_USERGROUP) then
			SH_WHITELIST:ApplyWhitelist(v)
			v.SH_WHITELIST_USERGROUP = usg
		end
	end
end)

-- Messy part: console commands for donation systems
local function DoPrint(ply, msg)
	msg = "[SH WHITELIST] " .. msg

	if (IsValid(ply)) then
		ply:PrintMessage(HUD_PRINTCONSOLE, msg)
	end

	print(msg)
end

concommand.Add("sh_whitelist_add_steamid", function(ply, cmd, args)
	if (!args[1]) then
		DoPrint(ply, "SteamID is missing.")
		return
	end

	if (!args[2]) then
		DoPrint(ply, "Job name is missing.")
		return
	end

	if (!SH_WHITELIST:IsValidSteamID(args[1])) then
		DoPrint(ply, "Invalid SteamID.")
		return
	end

	local job = SH_WHITELIST:GetJobByName(args[2])
	if (!job) then
		DoPrint(ply, "This job does not exist. " .. args[2])
		return
	end

	if (!SH_WHITELIST:IsWhitelistJob(job)) then
		DoPrint(ply, "This job cannot be whitelisted. Check your config file!")
		return
	end

	SH_WHITELIST:WhitelistSteamID(ply, args[1], {args[2]}, {true})
end)

concommand.Add("sh_whitelist_remove_steamid", function(ply, cmd, args)
	if (!args[1]) then
		DoPrint(ply, "SteamID is missing.")
		return
	end

	if (!args[2]) then
		DoPrint(ply, "Job name is missing.")
		return
	end

	if (!SH_WHITELIST:IsValidSteamID(args[1])) then
		DoPrint(ply, "Invalid SteamID.")
		return
	end

	local job = SH_WHITELIST:GetJobByName(args[2])
	if (!job) then
		DoPrint(ply, "This job does not exist. " .. args[2])
		return
	end

	if (!SH_WHITELIST:IsWhitelistJob(job)) then
		DoPrint(ply, "This job cannot be unwhitelisted. Check your config file!")
		return
	end

	SH_WHITELIST:WhitelistSteamID(ply, args[1], {args[2]}, {false})
end)

concommand.Add("sh_whitelist_add_usergroup", function(ply, cmd, args)
	if (!args[1]) then
		DoPrint(ply, "Usergroup is missing.")
		return
	end

	if (!args[2]) then
		DoPrint(ply, "Job name is missing.")
		return
	end

	local job = SH_WHITELIST:GetJobByName(args[2])
	if (!job) then
		DoPrint(ply, "This job does not exist. " .. args[2])
		return
	end

	if (!SH_WHITELIST:IsWhitelistJob(job)) then
		DoPrint(ply, "This job cannot be whitelisted. Check your config file!")
		return
	end

	SH_WHITELIST:WhitelistUsergroup(ply, args[1], {args[2]}, {true})
end)

concommand.Add("sh_whitelist_remove_usergroup", function(ply, cmd, args)
	if (!args[1]) then
		DoPrint(ply, "Usergroup is missing.")
		return
	end

	if (!args[2]) then
		DoPrint(ply, "Job name is missing.")
		return
	end

	local job = SH_WHITELIST:GetJobByName(args[2])
	if (!job) then
		DoPrint(ply, "This job does not exist. " .. args[2])
		return
	end

	if (!SH_WHITELIST:IsWhitelistJob(job)) then
		DoPrint(ply, "This job cannot be whitelisted. Check your config file!")
		return
	end

	SH_WHITELIST:WhitelistUsergroup(ply, args[1], {args[2]}, {false})
end)

concommand.Add("sh_whitelist_faction_reset", function(ply, cmd, args)
	local steamid = args[1]
	if (!steamid) then
		DoPrint(ply, "SteamID is missing.")
		return
	end

	if (!SH_WHITELIST:IsValidSteamID(steamid)) then
		DoPrint(ply, "Invalid SteamID.")
		return
	end

	if (steamid:StartWith("76")) then -- SID64
		steamid = util.SteamIDFrom64(steamid)
	end

	if (!SH_WHITELIST.FactionsChosen[steamid] or SH_WHITELIST.FactionsChosen[steamid] == 0) then
		DoPrint(ply, "This player has not chosen a faction yet!")
		return
	end

	local before = SH_WHITELIST.FactionsChosen[steamid]
	local beforefct = SH_WHITELIST.FactionsList[before]
	local unwl, unwl2 = {}, {}
	if (beforefct) then
		unwl = table.Copy(beforefct.Jobs)

		for i = 1, #unwl do
			table.insert(unwl2, false)
		end
	end

	SH_WHITELIST.FactionsChosen[steamid] = 0

	SH_WHITELIST:WhitelistSteamID(nil, steamid, unwl, unwl2)
	SH_WHITELIST:BetterQuery([[
		UPDATE sh_whitelist
		SET faction_chosen = 0
		WHERE type = 1 AND name = {steamid}
	]], {steamid = steamid})

	local target = player.GetBySteamID(steamid)
	if (IsValid(target)) then
		easynet.Send(target, "SH_WHITELIST.FactionMenu", {changing = false})
	end

	DoPrint(ply, "Faction reset for " .. steamid .. "!")
end)

concommand.Add("sh_whitelist_optimize_database", function(ply, cmd, args)
	SH_WHITELIST:OptimizeDatabase(ply)
end)

concommand.Add("sh_whitelist_wipe_database", function(ply, cmd, args)
	if (IsValid(ply) and !ply:IsSuperAdmin()) then
		return end

	SH_WHITELIST:WipeData()
end)