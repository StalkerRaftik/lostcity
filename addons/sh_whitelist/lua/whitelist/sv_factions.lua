local easynet = SH_WHITELIST.easynet

function SH_WHITELIST:FactionPlayerReady(ply)
	if not (self.FactionsEnable) then
		return end

	local steamid = ply:SteamID()
	if (self.FactionsChosen[steamid] > 0 and self.FactionsFrequency == 0) then
		return end

	easynet.Send(ply, "SH_WHITELIST.FactionMenu", {changing = self.FactionsChosen[steamid] > 0})
end

function SH_WHITELIST:FactionPlayerSpawn(ply)
	if not (ply.SH_WHITELIST_READY and self.FactionsEnable and self.FactionsFrequency == 2) then
		return end

	easynet.Send(ply, "SH_WHITELIST.FactionMenu", {changing = self.FactionsChosen[ply:SteamID()] > 0})
end

function SH_WHITELIST:FactionChosen(ply, id)
	if not (self.FactionsEnable) then
		return end
	
	local steamid = ply:SteamID()
	if (!self:Assert(self.FactionsChosen[steamid] == 0 or self.FactionsCanChange(ply), ply, "already_chosen_faction")) then
		return end

	local fact = self.FactionsList[id]
	if (!fact or self.FactionsChosen[steamid] == id) then
		return end

	if (fact.CanJoin and !fact:CanJoin(ply)) then
		return end

	-- Let's unwhitelist him from the others
	if (self.FactionsChosen[steamid] > 0 and self.FactionsUnwhitelistRest) then
		for fid, fact2 in pairs (self.FactionsList) do
			if (fid == id) then
				continue end

			local wl = {}
			for i = 1, #fact2.Jobs do
				table.insert(wl, false)
			end
			self:WhitelistSteamID(nil, steamid, fact2.Jobs, wl)
		end
	end

	self.FactionsChosen[steamid] = id
	
	local wl = {}
	for i = 1, #fact.Jobs do
		table.insert(wl, true)
	end
	self:WhitelistSteamID(nil, steamid, fact.Jobs, wl)

	self:BetterQuery([[
		UPDATE sh_whitelist
		SET faction_chosen = {id}
		WHERE type = 1 AND name = {steamid}
	]], {id = id, steamid = steamid})

	if (fact.DefaultJob and fact.DefaultJob ~= "") then
		local job = self:GetJobByName(fact.DefaultJob)
		if (job) then
			ply:changeTeam(job.team, true, true)
		end
	end

	if (fact.JoinMessage and fact.JoinMessage ~= "") then
		ply:ChatPrint(fact.JoinMessage)
	end

	if (fact.GlobalJoinMessage and fact.GlobalJoinMessage ~= "") then
		PrintMessage(HUD_PRINTTALK, fact.GlobalJoinMessage:Replace("{player}", ply:Nick()))
	end

	if (self.UseServerLog) then
		ServerLog(string.format(self.Language.x_joined_faction_y, ply:Nick(), fact.Name) .. "\n")
	end
end