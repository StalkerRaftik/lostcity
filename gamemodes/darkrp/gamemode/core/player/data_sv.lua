rp.data = rp.data or {}
db = rp._Stats

-- util.AddNetworkString("Init.ClientReadyToBeLoaded")
-- util.AddNetworkString("rp.data.LoadPlayer")


function PLAYER:SavePlayerData(name,value)
  if istable(value) then
    value = util.TableToJSON(value)
  end

  if self:GetNVar('CurrentChar') == false then return end
  if value then
    db:Query( "UPDATE `player_data` SET " .. name .. " = '" .. value .. "' WHERE SteamID = '" .. self:SteamID64() .. "' AND id = "..self:GetNVar('CurrentChar') )
  end
end

function rp.data.CheckPlayer(pl)
  db:Query('SELECT * FROM player_data WHERE SteamID=' .. pl:SteamID64() .. ';', function(_data)
    -- local data = _data[1] or {}
  end)
end

function rp.data.LoadPlayer(pl, cback)
  db:Query('SELECT * FROM player_data WHERE SteamID=' .. pl:SteamID64() .. ';', function(data)
    if IsValid(pl) then
      nw.WaitForPlayer(pl, function()
        pl:SetNVar('CharData', data, NETWORK_PROTOCOL_PRIVATE)
        loadClothes(pl)

        pl:SetNVar('CurrentChar', -1, NETWORK_PROTOCOL_PRIVATE)
        --if #data > 0 then
          
          -- rp.data.SelectChar(pl, data[1].id)
          -- pl:SetNVar('CurrentChar', data[1].id, NETWORK_PROTOCOL_PRIVATE)
        --end
        pl:SetNetVar('Name', "Загружается...")
        pl:SetNVar('Name', "Загружается...", NETWORK_PROTOCOL_PUBLIC)
        -- pl.CosmeticsData = {}
        -- pl.Cosmetics = {}
        
        -- CM_NetworkTableInfos()
        -- pl:CM_NetworkTableInfos()
        pl:SetNVar('Level', 1, NETWORK_PROTOCOL_PRIVATE)
        pl:SetNVar('Experience', 1, NETWORK_PROTOCOL_PRIVATE)
        pl:SetNVar('Registered', 0, NETWORK_PROTOCOL_PRIVATE)
        pl:SetNVar('FriendsList', {}, NETWORK_PROTOCOL_PRIVATE)
        pl.bannedfrom = {}
        pl:SetNetVar('Money', 0)    
		-- 	net.Start('OpenMOTD')
		-- net.Send(pl)
        pl:SetVar('DataLoaded', true)
        hook.Call('PlayerDataLoaded', GAMEMODE, pl, data)
 
        pl:SetNVar('PlayerDataLoaded', true, NETWORK_PROTOCOL_PUBLIC)
      end)
    end
    if cback then cback(data) end
  end)
end

-- net.Receive("rp.data.LoadPlayer", function(_, ply)
--     rp.data.LoadPlayer(ply)
-- end)

hook.Add( "PlayerInitialSpawn", "LoadPlayerOnInitial", function( ply )
  net.Start('OpenMOTD')
  net.Send(ply)
end)

-- function GM:PlayerAuthed(pl)
--   -- rp.data.LoadPlayer(pl)
--   net.Start('OpenMOTD')
--   net.Send(pl)
-- end

-- hook.Add( "PlayerInitialSpawn", "FullLoadSetup", function( ply )
-- 	hook.Add( "SetupMove", ply, function( self, ply, _, cmd )
-- 		if self == ply and not cmd:IsForced() then
-- 			-- rp.data.LoadPlayer(ply)
--           net.Start('OpenMOTD')
--     net.Send(ply)
-- 			hook.Remove( "SetupMove", self )
-- 		end
-- 	end )
-- end )

function rp.data.AddFriend(pl, steamid64, cback)
    local pl2 = rp.FindPlayer(steamid64)
    if not IsValid(pl2) then 
      return false
    end
    local FriendsList = pl:GetNVar("FriendsList") or {}
    local FriendsList2 = pl2:GetNVar("FriendsList") or {}
    if pl:IsFriend(pl2) then
      DarkRP.notify(pl, 1, 4, "Вы уже знакомы с этим человеком")
      return false
    end
    if pl.LastFriendRequest && pl.LastFriendRequest > CurTime() then return end
  	pl.LastFriendRequest = CurTime() + 10
    GAMEMODE.ques:Create(pl:Name() .. ' Хочет познакомиться\nс вами, согласиться?', pl:EntIndex() .. 'friendinv', pl2, 20, function(ret)
      if IsValid(pl2) and tobool(ret) then
        if not istable(FriendsList) or not istable(FriendsList2) then return end
        table.insert(FriendsList, pl2:SteamID64())
        table.insert(FriendsList2, pl:SteamID64())
        pl:SetNVar('FriendsList', FriendsList, NETWORK_PROTOCOL_PRIVATE)
        pl2:SetNVar('FriendsList', FriendsList2, NETWORK_PROTOCOL_PRIVATE)
        pl:SavePlayerData("FriendsList", util.TableToJSON(FriendsList))
        pl2:SavePlayerData("FriendsList", util.TableToJSON(FriendsList2))
        DarkRP.notify(pl, 1, 4, "Теперь ты знаком с "..pl2:RPName(true))
        DarkRP.notify(pl2, 1, 4, "Теперь ты знаком с "..pl:RPName(true))        
      end
    end, pl, pl2)
end

function rp.data.SetName(pl, name, cback)
	db:Query('UPDATE player_data SET Name=? WHERE SteamID=' .. pl:SteamID64() .. ' AND id='..pl:GetNVar('CurrentChar')..';', name, function(data)
		pl:SetNetVar('Name', name)
		if cback then cback(data) end
	end)
end

function rp.data.GetNameCount(name, cback)
	db:Query('SELECT COUNT(*) as `count` FROM player_data WHERE Name=?;', name, function(data)
		if cback then cback(tonumber(data[1].count) > 0) end
	end)
end

function rp.data.SetMoney(pl, amount, cback)
	db:Query('UPDATE player_data SET Money=? WHERE SteamID=' .. pl:SteamID64() .. ' AND id='..pl:GetNVar('CurrentChar')..';', amount, cback)
end

function rp.data.PayPlayer(pl1, pl2, amount)
	if not IsValid(pl1) or not IsValid(pl2) then return end
	pl1:TakeMoney(amount)
	pl2:AddMoney(amount)
end

-- function rp.data.SetKarma(pl, amount, cback)
-- 	if (pl:GetKarma() ~= amount) then
-- 		db:Query('UPDATE player_data SET Karma=? WHERE SteamID=' .. pl:SteamID64() .. ';', amount, cback)
-- 	end
-- end

function rp.data.IsLoaded(pl)
	if IsValid(pl) and (pl:GetVar('DataLoaded') ~= true) then
		file.Append('data_load_err.txt', os.date() .. '\n' .. pl:Name() .. '\n' .. pl:SteamID() .. '\n' .. pl:SteamID64() .. '\n' .. debug.traceback() .. '\n\n')
		rp.Notify(pl, NOTIFY_ERROR,  rp.Term('DataNotLoaded'))
		return false
	end
	return true
end

hook('InitPostEntity', 'data.InitPostEntity', function()
	db:Query('UPDATE player_data SET Money=0 WHERE Money <' ..  0)
end)

-- hook.Add("PlayerDisconnected", "PlayerDisconnectedTeamSave", function(ply)
--   db:Query('UPDATE player_data SET Job=? WHERE SteamID=' .. ply:SteamID64() .. ';', ply:Team(), function(data) end)
-- end)

-- hook.Add("PlayerSpawn", "PlayerDisconnectedTeamSave", function(ply)
--   db:Query('SELECT * FROM player_data WHERE SteamID=' .. ply:SteamID64() .. ';', function(_data)
--     local data = _data[1] or {}
--     if data.Job and (data.Job ~= nil) and (data.Job ~= "") then
--       ply:ChangeTeam(data.Job, true)
--     else
--       ply:ChangeTeam(1, true)
--     end
--   end)
-- end)


--
--	Meta
--

function PLAYER:AddMoney(amount)
	if not rp.data.IsLoaded(self) then return end

	local total = self:GetMoney() + math.floor(amount)
	rp.data.SetMoney(self, total)
	self:SetNetVar('Money', total)
end

function PLAYER:TakeMoney(amount)
	self:AddMoney(-math.abs(amount))
end

-- function PLAYER:AddKarma(amount, cback)
-- 	if not rp.data.IsLoaded(self) then return end
	
-- 	local add = hook.Call('PlayerGainKarma', GAMEMODE, self)

-- 	if (add == false) then
-- 		return add
-- 	end

-- 	if cback then
-- 		cback(amount)
-- 	end

-- 	local total = math.Clamp(self:GetKarma() + math.floor(amount), 0, 100)
-- 	rp.data.SetKarma(self, total)
-- 	self:SetNetVar('Karma', total)
-- end

-- function PLAYER:TakeKarma(amount)
-- 	self:AddKarma(-math.abs(amount))
-- end
