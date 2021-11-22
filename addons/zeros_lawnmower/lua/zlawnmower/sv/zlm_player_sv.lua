if (not SERVER) then return end
zlm = zlm or {}
zlm.f = zlm.f or {}

// How often are clients allowed to send net messages to the server
zlm_NW_TIMEOUT = 0.25


if zlm_PlayerList == nil then
    zlm_PlayerList = {}
end

function zlm.f.Add_Player(ply)
    table.insert(zlm_PlayerList, ply)
end

function zlm.f.NW_Player_Timeout(ply)
    local Timeout = false

    if ply.zlm_NWTimeout and ply.zlm_NWTimeout > CurTime() then
        Timeout = true
    end

    ply.zlm_NWTimeout = CurTime() + zlm_NW_TIMEOUT

    return Timeout
end

hook.Add("PlayerInitialSpawn", "zlm_PlayerInitialSpawn", function(ply)
    timer.Simple(1, function()
        zlm.f.Add_Player(ply)
    end)

    timer.Simple(10, function()
        if zlm.config.SimpleGrassMode.Enabled == false then
            zlm.f.Send_GrassSpots_ToClient(ply)
        end
    end)
end)

hook.Add("PlayerInitialSpawn", "zlm_PlayerInitialSpawn", function(ply)
    if ply:Team() == TEAM_POM2 then
        zlm.f.Send_GrassSpots_ToClient(ply)
    end
end)

hook.Add("PlayerSay", "zlm_PlayerSay_Save", function(ply, text)
    if string.sub(string.lower(text), 1, 8) == "/savezlm" then
        if ply:GetUserGroup() == "root" then
            zlm.f.Save_GrassSpots()
            zlm.f.Notify(ply, "GrassSpot´s have been saved for the map " .. game.GetMap() .. "!", 0)

            zlm.f.Save_BuyerNPC()
            zlm.f.Notify(ply, "Grass Buyer NPC´s have been saved for the map " .. game.GetMap() .. "!", 0)

            zlm.f.Save_GrassPress()
            zlm.f.Notify(ply, "GrassPress entities have been saved for the map " .. game.GetMap() .. "!", 0)

            zlm.f.Save_Lawnmower()
            zlm.f.Notify(ply, "Lawnmower entities have been saved for the map " .. game.GetMap() .. "!", 0)

            zlm.f.Save_VehicleSpawns()
            zlm.f.Notify(ply, "Vehicle Spawns have been saved for the map " .. game.GetMap() .. "!", 0)
        else
            zlm.f.Notify(ply, "You do not have permission to perform this action, please contact an admin.", 1)
        end
    end
end)

local zlm_DeleteEnts = {
    ["zlm_grasspress"] = true,
    ["zlm_tractor"] = true,
    ["zlm_tractor_trailer"] = true,
    ["zlm_corb"] = true
}
function zlm.f.Player_Cleanup(ply)
    for k, v in pairs(zlm.EntList) do
        if IsValid(v) and zlm_DeleteEnts[v:GetClass()] and zlm.f.GetOwnerID(v) == ply:SteamID() then
            v:Remove()
        end
    end

    if IsValid(ply.zlm_Tractor) then
        ply.zlm_Tractor:Remove()
    end
    if IsValid(ply.zlm_Tractor_Trailer) then
        ply.zlm_Tractor_Trailer:Remove()
    end
end
hook.Add("OnPlayerChangedTeam", "zlm_OnPlayerChangedTeam", function(pl, before, after)
    zlm.f.Player_Cleanup(pl)
end)

hook.Add("PlayerDisconnected", "zlm_PlayerDisconnected", function(ply)
    zlm.f.Player_Cleanup(ply)
end)

hook.Add("PlayerDeath", "zlm_PlayerDeath", function(victim, inflictor, attacker)

    // Close NPC interface
    zlm.f.NPC_CloseInterface(victim)

end)
