util.AddNetworkString( "OpenMOTD" )
util.AddNetworkString( "rp.data.SelectChar" )
util.AddNetworkString( "rp.data.SendCharCountToClient" )
util.AddNetworkString("rp.data.DeleteCharacter")
util.AddNetworkString("rp.charsmenu")



hook.Add("PlayerDataLoaded", "rp.data.SendCharCountHook", function(ply)
    ply:SetPos(Vector(-5283.08740, -607.795410, 215.593414))
    ply:SetAngles(Angle(-9.368921, -23.137690, 0.000000))
    ply:SetNoDraw(true)
    ply:SetMoveType(MOVETYPE_NOCLIP)
    ply:Freeze(true)

    net.Start("rp.data.SendCharCountToClient")
        net.WriteInt(ply:GetUpgradeCount('newcharacter'),8)
    net.Send(ply)
    net.Start("rp.charsmenu")
    net.Send(ply)
end)

net.Receive("rp.data.DeleteCharacter", function(_, ply)
    local id = net.ReadInt(16)
    db:Query('DELETE FROM player_data WHERE steamid=' .. ply:SteamID64() .. ' AND id='..id..';')
    rp.data.LoadPlayer(ply)
end)

net.Receive("rp.data.SelectChar", function(_, ply)
    local id = net.ReadInt(16)
    rp.data.SelectChar(ply, id)
end)

function rp.data.SelectChar(pl, id)
    db:Query('SELECT * FROM player_data WHERE steamid=' .. pl:SteamID64() .. ' AND id='..id..';', function(_data)
        local data = _data[1] or {}
        if (#_data > 0) then
            pl:SetNoDraw(false)
            pl:SetMoveType(MOVETYPE_WALK)
            pl:Freeze(false)

            pl:StripWeapons()
            pl.Cosmetics = {}
            pl.CosmeticsData = {}
            pl:NetVars("Cosmetics", pl.Cosmetics, true)

            pl:SetNetVar('Name', data.Name)
            pl:SetNVar('Name', data.Name, NETWORK_PROTOCOL_PUBLIC)
            pl:SetNVar('Gender', data.Gender, NETWORK_PROTOCOL_PRIVATE)
            pl:SetNVar('Level', data.Level, NETWORK_PROTOCOL_PRIVATE)
            pl:SetNVar('Experience', data.Experience, NETWORK_PROTOCOL_PRIVATE)
            pl:SetModel(data.Model or "models/kerry/player/citizen/male_01.mdl")
            pl:SetNVar('PlayerModel', data.Model or "models/kerry/player/citizen/male_01.mdl", NETWORK_PROTOCOL_PRIVATE)
            pl:SetNVar('CurrentChar', data.id, NETWORK_PROTOCOL_PUBLIC)
            pl.bannedfrom = util.JSONToTable(data.TeamBan) or {}

            pl.CosmeticsData = data.cosmetics and util.JSONToTable(data.cosmetics) or {}
            pl:NetVars("Cosmetics", pl.Cosmetics, true)

            net.Start("Cosmetics.UpdatePlayer")
            net.Send(pl)

            pl:SetNetVar('Money', data.Money or rp.cfg.StartMoney)

            if data.FriendsList and (data.FriendsList ~= nil) then
                pl:SetNVar('FriendsList', util.JSONToTable(data.FriendsList) or {}, NETWORK_PROTOCOL_PRIVATE)
            else
                pl:SetNVar('FriendsList', {}, NETWORK_PROTOCOL_PRIVATE)
            end

            pl:SetVar('CharSelected', true)
            pl:SetNVar('CharSelected', true, NETWORK_PROTOCOL_PRIVATE)
            pl:CM_NetworkTableInfos()
            -- pl:Spawn()
            hook.Call('PlayerCharLoaded', GAMEMODE, pl, data)
        end
    end)
end

-- hook.Add( "PlayerDataLoaded", "OpenMOTDMenu", function(ply)
--     net.Start('OpenMOTD')
--     net.Send(ply)
-- end)

