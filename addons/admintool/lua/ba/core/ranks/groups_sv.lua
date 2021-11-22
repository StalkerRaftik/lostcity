local db = ba.data.GetDB()

function ba.canAdmin(pl)
	return (ba.IsPlayer(pl) and pl:GetBVar('adminmode') or not ba.IsPlayer(pl) or pl:GetUserGroup() == "sudoroot" or pl:GetUserGroup() == "root" or pl:GetUserGroup() == "spy")
end

function PLAYER:SetUserGroup() end

hook.Remove('PlayerInitialSpawn', 'PlayerAuthSpawn')

hook.Add('PlayerAuthed', 'ba.PlayerAuthed.PlayerData', function(pl)
	ba.data.LoadPlayer(pl)
end)

hook.Add('PlayerDisconnected', 'ba.PlayerDisconnected.PlayerData', function(pl) -- uh, we'll just plop this here for now
	ba.notify_staff(ba.Term('PlayerDisconnect'), pl:NameID())
	ba.data.UpdatePlayTime(pl)
end)

timer.Create('ba.PlayerGroupExpireCheck', 120, 0, function()
	for _, pl in ipairs(player.GetAll()) do
		ba.data.UpdatePlayTime(pl)
		if pl:GetBVar('DataLoaded') and (pl:GetBVar('expire_time') ~= 0) and (pl:GetBVar('expire_time') < os.time()) then
			ba.data.SetRank(pl, pl:GetBVar('expire_rank'), pl:GetBVar('expire_rank'), 0, function()
				hook.Call('playerRankExpire', ba, pl, pl:GetBVar('expire_rank'))
				ba.notify_err(pl, ba.Term('RankExpired'), pl:GetBVar('expire_rank'))
			end)
		end
	end
	db:query('SELECT * FROM ba_ranks WHERE (expire_time > 0) AND (expire_time <= ' .. os.time() .. ') AND (sv_id = "' .. ba.data.GetID() .. '");', function(data)
		for k, v in ipairs(data) do
			ba.data.SetRank(util.SteamIDFrom64(v.steamid), v.expire_rank, v.expire_rank, 0, function()
				if ba.ranks.Get(v.expire_rank) then
					hook.Call('playerRankExpire', ba, v.steamid, ba.ranks.Get(v.expire_rank):GetName())
				end
			end)
		end
	end)
end)

