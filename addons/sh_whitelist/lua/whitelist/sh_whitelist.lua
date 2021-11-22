local easynet = SH_WHITELIST.easynet

if (!SH_WHITELIST.Whitelisted) then
	SH_WHITELIST.Whitelisted = {
		players = {},
		usergroups = {},
	}
	SH_WHITELIST.FactionsChosen = {}
end

SH_WHITELIST.TYPE_STEAMID = 1
SH_WHITELIST.TYPE_USERGROUP = 2

function SH_WHITELIST:GetJobByName(name)
	for _, v in pairs (RPExtraTeams) do
		if (v.name == name) then
			return v
		end
	end
end

function SH_WHITELIST:ApplyWhitelist(ply)
	local jobs = {}
	local wlsid, wlusg = self.Whitelisted.players[ply:SteamID()], self.Whitelisted.usergroups[ply:GetUserGroup()]
	if (wlsid) then table.Merge(jobs, wlsid) end
	if (wlusg) then table.Merge(jobs, wlusg) end

	hook.Run("SH_WHITELIST.PreApplyWhitelist", ply, jobs)

	ply.SH_WHITELIST = jobs

	if (SERVER) then
		if (wlsid) then SH_WHITELIST:SendWhitelist(ply, ply:SteamID(), nil) end
		if (wlusg) then SH_WHITELIST:SendWhitelist(ply, nil, ply:GetUserGroup()) end
	end
end

function SH_WHITELIST:CanWhitelist(ply, jobname)
	if ply:IsSuperAdmin() then return true end
	local b = hook.Run("SH_WHITELIST.CanWhitelist", ply, jobname)
	if (b ~= nil) then
		return b
	end

	if (self:IsAdmin(ply)) then
		return true
	end

	local t = self.WhitelistingJobs[team.GetName(ply:Team())] or {}
	local t2 = self.WhitelistingUsergroups[ply:GetUserGroup()] or {}
	table.Add(t, t2)
	
	if (!jobname) then
		return table.Count(t) > 0
	end

	return table.Count(t) > 0 and table.HasValue(t, jobname)
end

function SH_WHITELIST:TableToCSV(tbl, key)
	local t = {}
	for k, v in pairs (tbl) do
		table.insert(t, '"' .. (key and k or v):Replace('"', '""') .. '"')
	end

	return table.concat(t, ",")
end

-- http://lua-users.org/wiki/LuaCsv
function SH_WHITELIST:ParseCSVLine(line, sep)
	local res = {}
	local pos = 1
	sep = sep or ','
	while true do
		local c = string.sub(line,pos,pos)
		if (c == "") then break end
		if (c == '"') then
			-- quoted value (ignore separator within)
			local txt = ""
			repeat
				local startp,endp = string.find(line,'^%b""',pos)
				txt = txt..string.sub(line,startp+1,endp-1)
				pos = endp + 1
				c = string.sub(line,pos,pos)
				if (c == '"') then txt = txt..'"' end
				-- check first char AFTER quoted string, if it is another
				-- quoted string without separator, then append it
				-- this is the way to "escape" the quote char in a quote. example:
				--   value1,"blub""blip""boing",value3  will result in blub"blip"boing  for the middle
			until (c ~= '"')
			table.insert(res,txt)
			assert(c == sep or c == "")
			pos = pos + 1
		else
			-- no quotes used, just look for the first separator
			local startp,endp = string.find(line,sep,pos)
			if (startp) then
				table.insert(res,string.sub(line,pos,startp-1))
				pos = endp + 1
			else
				-- no separator found -> use rest of string and terminate
				table.insert(res,string.sub(line,pos))
				break
			end
		end
	end
	return res
end

function SH_WHITELIST:Assert(b, ply, message)
	if (!b) then
		if (ply and message) then
			easynet.Send(ply, "SH_WHITELIST.Notify", {message = message, good = false})
		end

		return false
	end

	return true
end

function SH_WHITELIST:IsAdmin(ply)
	local b = hook.Run("SH_WHITELIST.IsAdmin", ply)
	if (b ~= nil) then
		return b
	end

	return self.Usergroups[ply:GetUserGroup()]
end

function SH_WHITELIST:IsValidSteamID(s)
	s = s:Trim():upper()
	if (s:find("STEAM_")) then
		-- 76561198059738142
		return util.SteamIDFrom64(util.SteamIDTo64(s)) == s
	else
		return util.SteamIDTo64(util.SteamIDFrom64(s)) == s
	end
end

function SH_WHITELIST:IsWhitelistJob(job)
	if (isnumber(job)) then
		job = RPExtraTeams[job]
	end

	local b = hook.Run("SH_WHITELIST.IsWhitelistJob", ply, job)
	if (b ~= nil) then
		return b
	end

	if (job.vote and self.WhitelistVotes) then
		return true
	end

	if (self.WhitelistedJobs[job.name]) then
		return true
	end

	if (self.WhitelistedJobs[job.category] and job.donatejob ~= true) then
		return true
	end

	local color = job.color
	color = color.r .. " " .. color.g .. " " .. color.b
	if (self.WhitelistedJobs[color]) then
		return true
	end

	return false
end

function SH_WHITELIST:IsPlayerWhitelisted(ply, job)
	local b = hook.Run("SH_WHITELIST.IsPlayerWhitelisted", ply, job)
	if (b ~= nil) then
		return b
	end

	-- if (self.AdminsBypass and self:IsAdmin(ply)) then
	-- 	return true
	-- end

	if (isnumber(job)) then
		job = RPExtraTeams[job]
	end

	return ply.SH_WHITELIST and ply.SH_WHITELIST[job.name] == true
end

function SH_WHITELIST:CanBecomeJob(ply, job)
	if (isnumber(job)) then
		job = RPExtraTeams[job]
	end

	local b = hook.Run("SH_WHITELIST.CanBecomeJob", ply, job)
	if (b ~= nil) then
		return b
	end

	if (self:IsWhitelistJob(job) and !self:IsPlayerWhitelisted(ply, job)) then
		return false
	end

	return true
end