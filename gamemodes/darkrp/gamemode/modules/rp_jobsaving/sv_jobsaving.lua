hook.Add("PlayerCharLoaded", "rp.Hunger.SetPlayerHunger", function(ply)
    db:Query('SELECT * FROM player_data WHERE steamid=' .. ply:SteamID64() .. " AND id = " .. ply:GetNVar("CurrentChar") .. ' LIMIT 1;', function(tbl)
        if tbl and tbl[1] then
            local job = tbl[1].job
            if job then
                ply:ChangeTeam(job, true)
            -- else
            --     ply:ChangeTeam(1, true)
            end
            ply:Spawn()
        end
    end)
end)

hook.Add("PlayerDisconnected", "rp.Hunger.SaveAttributesToDB", function(ply)
    if not isnumber(ply:GetNVar('CurrentChar')) then return end

	local job = ply:GetJob()

	db:Query('UPDATE player_data SET job=? WHERE steamid=? AND id=?;', job, ply:SteamID64(), ply:GetNVar('CurrentChar'))
end)