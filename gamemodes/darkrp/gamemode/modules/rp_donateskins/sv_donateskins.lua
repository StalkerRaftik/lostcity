util.AddNetworkString("SendDonateSkinsToClient")

hook.Add("Initialize", "rp.donateskins.CreateDB", function()
	db:Query("CREATE TABLE IF NOT EXISTS rp_donateskins(SteamID64 VARCHAR(255) NOT NULL, charid INT(11) NOT NULL PRIMARY KEY, data TEXT NOT NULL)")
end)

hook.Add("PlayerCharLoaded", "rp.donateskins.Setup", function(ply)
    db:Query('SELECT * FROM rp_donateskins WHERE SteamID64=' .. ply:SteamID64() .. " AND charid = " .. ply:GetNVar("CurrentChar") .. ';', function(data)
        if data[1] then
            if (data[1].data ~= nil) and data[1].data ~= "[]" then
                ply.skinID = data[1].data
            end
        else
        	db:Query('INSERT INTO rp_donateskins (SteamID64, charid, data) VALUES(?, ?, ?);', ply:SteamID64(), ply:GetNVar("CurrentChar"), "[]")
        end
        --ply:SyncSkins()
    end)
end)

-- function PLAYER:NWDonateSkin(newteam)
--     local team = newteam or self:Team()
--     local skin = self.dskins and self.dskins[team] and self.dskins[team].model or nil
--     if skin then
--         self:SetNVar('DonateSkin', skin, NETWORK_PROTOCOL_PUBLIC)
--     else
--         self:SetNVar('DonateSkin', nil, NETWORK_PROTOCOL_PUBLIC)
--     end
-- end

-- hook.Add("OnPlayerChangedTeam", "rp.donateskins.NWChangeTeam", function( ply, oldteam, newteam )
--      ply:NWDonateSkin(newteam)
-- end)

-- function PLAYER:AddDonateModel(job, model, days)
--     if not rp.teams[job] then 
--         rp.Notify(self, NOTIFY_ERROR, "Ошибка! Не найдена подходящая работа!")
--         return
--     end
--     local profname = rp.teams[job].name

--     if not self.dskins[job] then self.dskins[job] = {} end

--     days = days or 30
--     local time = os.time() + 60*60*24*days
--     if self.dskins[job][model] then
--         self.dskins[job][model] = self.dskins[job].time + time
--     else
--         self.dskins[job][model] = time
--     end
--     UpdateDonateSkinsDB(self)
--     self:SyncSkins()
--     rp.Notify(self, NOTIFY_ERROR, "Вам успешно выдали донат-модель ".. model .. " для профессии " .. profname)
-- end

function PLAYER:CanUseThisModel(job, model)
    if IsDonateModel(job,model) then
		if self:HasUpgrade(DonateSkinsDict[job][model]) then
			return true
		else
			return false
		end
	else
		if table.HasValue(rp.teams[job].model, model) then
			return true
		else
			return false
		end
	end
end

function UpdateDonateSkinsDB(ply)
    db:Query('UPDATE rp_donateskins SET data=? WHERE steamid64=? AND charid=?;', ply.skinID, ply:SteamID64(), ply:GetNVar('CurrentChar'))
end

-- function PLAYER:SyncSkins()
--     net.Start("SendDonateSkinsToClient")
--         net.WriteTable(self.dskins)
--     net.Send(self)
-- end

-- function PLAYER:RemoveDonateModel(job, model)
--     if not self.dskins[job] or not self.dskins[job][model] then
--         print("Модель у игрока не найдена для удаления")
--         return 
--     end
--     self.dskins[job][model] = nil
--     UpdateDonateSkinsDB(self)
--     self:SyncSkins()
-- end

-- function AddDonateModelOffline(steamID, charID, job, model, days)
--     local time = os.time() + 60*60*24*(days or 30)
--     local steamID64 = util.SteamIDTo64(steamID)
--     local data
--     db:Query('SELECT * FROM rp_donateskins WHERE SteamID64=' .. steamID64 .. " AND charid = " .. charID .. ';', function(data)
--         if data[1] then
--             if (data[1].data ~= nil) and data[1].data ~= "[]" then
--                 data = util.JSONToTable(data[1].data)
--             else 
--                 data = {}
--             end
--         else
--             data = {}
--             db:Query('INSERT INTO rp_donateskins (SteamID64, charid, data) VALUES(?, ?, ?);', steamID64, charID, util.TableToJSON(data))
--         end
--     end)

--     if not data[job] then data[job] = {} end

--     data[job][model] = time
--     db:Query('UPDATE rp_donateskins SET data=? WHERE steamid64=? AND charid=?;', util.TableToJSON(data), steamID64, charID)
--     print("Скин "..model.." успешно выдан игроку со STEAMID "..steamID)
-- end