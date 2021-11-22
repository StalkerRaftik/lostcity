---------------------------------------------------
-- CONFIG (TEMPORARY)
---------------------------------------------------

cats.mysqlite = {}
cats.mysqlite.EnableMySQL      = true                  -- Set to true if you want to use an external MySQL database, false if you want to use the built in SQLite database (garrysmod/sv.db) of Garry's mod

cats.mysqlite.Host             = RP_MySQLConfig.Host            -- The IP address of the MySQL host
cats.mysqlite.Username         = RP_MySQLConfig.Username            -- The username to log in on the MySQL server
cats.mysqlite.Password         = RP_MySQLConfig.Password            -- The password to log in on the MySQL server
cats.mysqlite.Database_name    = RP_MySQLConfig.Database_name     -- The name of the Database on the MySQL server
cats.mysqlite.Database_port    = RP_MySQLConfig.Database_port                  -- The port of the MySQL server
cats.mysqlite.Preferred_module = "tmysql4"              -- The MySQL module you use for GMod server
---------------------------------------------------
-- NET STRING DECLARE
---------------------------------------------------

util.AddNetworkString "cats.dispatchMessage"
util.AddNetworkString "cats.syncTickets"
util.AddNetworkString "cats.claimTicket"
util.AddNetworkString "cats.closeTicket"
util.AddNetworkString "cats.setRating"
util.AddNetworkString "cats.getAdminList"
util.AddNetworkString "cats.getAdminData"

---------------------------------------------------
-- CACHE STORAGE
---------------------------------------------------

cats.currentTickets = {}
cats.adminDataCache = {}

-- build receivers list
local function getAdmins(steamID)

    local admins = {}
    for i, ply in ipairs(player.GetAll()) do
        if cats.config.playerCanSeeTicket(ply, steamID) then table.insert(admins, ply) end
    end

    return admins

end

---------------------------------------------------
-- HELPERS
---------------------------------------------------

-- generates empty punchcard
local PUNCHCARD_EMPTY = {}
for dow = 1, 7 do
    PUNCHCARD_EMPTY[dow] = {}
    for dom = 1, 24 do
        PUNCHCARD_EMPTY[dow][dom] = 0
    end
end

---------------------------------------------------
-- BASE CODE
---------------------------------------------------

-- log in console
function cats:Log(text)

    print("[CATS] " .. text)

end

-- initialize addon
function cats:Init()

    self.config.serverID = self.config.serverID:gsub('[^A-Za-z]','')
    MySQLite.initialize( self.mysqlite )
    self:Log("Initialized.")

end
cats:Init()

-- handle query error
function cats.QueryError(err, q)

    error("\n[CATS] Query error : " .. err .. " on query : '" .. q .. "'\n\n")

end

-- make a query
function cats:Query(q, callback)

    if not q or type(q) ~= "string" then return end
	MySQLite.query(q, callback, self.QueryError)

end

-- process & broadcast new ticket message
function cats:DispatchMessage(ply, steamID, msg)

    local name = cats.config.getPlayerName(ply)
    local admins = getAdmins(steamID)

    if self.currentTickets[steamID] then
        -- check if has unfinished ticket
        if self.currentTickets[steamID].ended then
            cats.config.notify(ply, cats.lang.error_needToRate, NOTIFY_ERROR, 10)
            return
        end

        -- ticket exists, append chat message
        table.insert(self.currentTickets[steamID].chatLog, {name, msg, ply:SteamID() ~= steamID})
    else
        -- create new ticket
        self.currentTickets[steamID] = {
            createdTime = os.time(),
            createdGameTime = CurTime(),
            chatLog = {{name, msg}},
            user = ply,
            userID = steamID
        }

        -- if no admins, tell user
        if #admins < 2 then
            cats.config.notify(ply, cats.lang.ticket_noAdmins, NOTIFY_GENERIC, 10)
        else
            ply:ChatPrint( '----Жалоба ожидает принятия-----' ) 
            ply:ChatPrint( 'Постарайтесь быть вежливым и спокойным на разборхах, не перебивать. Это поможет администратору быстрее и легче разобраться в произошедшем.')
            ply:ChatPrint('\n Не забывайте, что если вы будете кричать, использовать нецезурную брань или оскорблять кого-то на разборках, администратор может отказать вам в разборе жалобы!')
        end
    end

    --
    
    -- do networking
    net.Start('cats.dispatchMessage')
        net.WriteString(steamID)
        net.WriteEntity(ply)
        net.WriteString(msg)
    net.Send(admins)

end
net.Receive('cats.dispatchMessage', function(len, ply)

    local steamID = net.ReadString()
    local msg = net.ReadString()
    local user = player.GetBySteamID(steamID)

    -- check if user exists
    if not IsValid(user) then
        cats.config.notify(ply, cats.lang.error_playerNotFound, NOTIFY_ERROR, 3)
        return
    end

    -- check access
    if not cats.config.playerCanSeeTicket(ply, steamID) then
        cats.config.notify(ply, cats.lang.error_noAccess, NOTIFY_ERROR, 3)
        return
    end

    -- dispatch
    cats:DispatchMessage(ply, steamID, msg)

end)

-- close ticket
function cats:SaveTicket(steamID, rating)

    local ticket = self.currentTickets[steamID]

    -- ticket doesn't exist
    if not ticket then
        self:Log('Trying to close inexistant ticket for ' .. steamID)
        return
    end

    -- save ticket in database
    local q = string.format([[
        INSERT INTO cats_]] .. self.config.serverID .. [[_claims(user, admin, createdTime, ticketTime, rating)
        VALUES (%s, %s, %d, %d, %f);
    ]],
        MySQLite.SQLStr( steamID ),
        MySQLite.SQLStr( ticket.adminID ),
        ticket.createdTime,
        ticket.finishTime - ticket.claimTime,
        rating
    )

    self:Query(q, function(res)
        -- send info about rating
        if IsValid(ticket.user) then
            -- notify user
            cats.config.notify(ticket.user, string.format(cats.lang.ticketRatedForUser, tostring(rating)), NOTIFY_CLEANUP, 8)
        end
        if IsValid(ticket.admin) then
            -- notify admin
            cats.config.notify(ticket.admin, string.format(cats.lang.ticketRatedForAdmin, tostring(rating)), NOTIFY_CLEANUP, 8)
            
            -- update claimCard
            local now = os.date('*t', os.time())
            now.wday = now.wday - 1
            day = now.wday ~= 0 and now.wday or 7
            hour = now.hour ~= 0 and now.hour or 24
            ticket.admin.cats_adminData.claimCard[day][hour] = ticket.admin.cats_adminData.claimCard[day][hour] + 1
        end

        -- remove ticket
        self.currentTickets[steamID] = nil
    end)

end
net.Receive('cats.closeTicket', function(len, ply)

    local steamID = net.ReadString()
    local ticket = cats.currentTickets[steamID]

    -- ticket doesn't exist
    if not ticket then
        cats.config.notify(ply, cats.lang.error_ticketNotFound, NOTIFY_ERROR, 3)
        return
    end

    -- ticket already ended
    if ticket.ended then
        cats.config.notify(ply, cats.lang.error_ticketEnded, NOTIFY_ERROR, 3)
        return
    end

    if ticket.adminID == ply:SteamID() then -- admin closed the ticket
		-- update cache
	    ticket.ended = true
	    ticket.finishTime = os.time()

	    -- notify clients
	    net.Start('cats.closeTicket')
	        net.WriteString(steamID)
	    net.Send(getAdmins(steamID))
	    if IsValid(ticket.user) then
	        cats.config.notify(ticket.user, string.format(cats.lang.ticketClosedBy, ticket.admin:Name()), NOTIFY_GENERIC, 5)
	    end
	    cats.config.notify(ply, cats.lang.ticketClosed, NOTIFY_GENERIC, 3)
	elseif ticket.userID == ply:SteamID() and not IsValid(ticket.admin) then -- user cancelled the ticket
		-- notify clients
		net.Start('cats.closeTicket')
			net.WriteString(steamID)
		net.Send(getAdmins(steamID))

		-- delete ticket
		cats.currentTickets[steamID] = nil
	else -- we don't have access to this
        cats.config.notify(ply, cats.lang.error_noAccess, NOTIFY_ERROR, 3)
        return
    end

end)
net.Receive('cats.setRating', function(len, ply)

    local steamID = ply:SteamID()
    local rating = math.Clamp( net.ReadUInt(8) or cats.config.defaultRating, 1, 5 )
    local ticket = cats.currentTickets[steamID]

    -- ticket doesn't exist
    if not ticket then
        cats.config.notify(ply, cats.lang.error_ticketNotFound, NOTIFY_ERROR, 3)
        return
    end

    -- ticket is not closed
    if not ticket.ended then
        cats.config.notify(ply, cats.lang.error_ticketNotEnded, NOTIFY_ERROR, 3)
        return
    end

    -- notify clients
    net.Start('cats.setRating')
        net.WriteString(steamID)
        net.WriteUInt(rating, 8)
    net.Send({ply, ticket.admin})

    -- finish up
    cats:SaveTicket(steamID, rating)

end)

-- claim/unclaim ticket
function cats:ClaimTicket(steamID, ply, doClaim)

    local ticket = self.currentTickets[steamID]

    -- ticket doesn't exist
    if not ticket then
        self:Log('Trying to claim inexistant ticket for ' .. steamID)
        return
    end

    -- check access
    if ticket.adminID and ticket.adminID ~= ply:SteamID() then
        cats.config.notify(ply, cats.lang.error_noAccess, NOTIFY_ERROR, 3)
        return
    end

    if doClaim then
        -- claim ticket
        ticket.admin = ply
        ticket.adminID = ply:SteamID()
        ticket.claimTime = os.time()
    else
        -- unclaim ticket
        ticket.admin = nil
        ticket.adminID = nil
    end

    net.Start('cats.claimTicket')
        net.WriteString(steamID)
        net.WriteEntity(ply)
        net.WriteBool(doClaim)
    net.Send(getAdmins(steamID))

end
net.Receive('cats.claimTicket', function(len, ply)

    local steamID = net.ReadString()
    local doClaim = net.ReadBool()
    local ticket = cats.currentTickets[steamID]

    -- check access
    if not cats.config.playerCanSeeTicket(ply, steamID) --[[or ply:SteamID() == steamID]] then
        cats.config.notify(ply, cats.lang.error_noAccess, NOTIFY_ERROR, 3)
        return
    end

    -- ticket doesn't exist
    if not ticket then
        cats.config.notify(ply, cats.lang.error_ticketNotFound, NOTIFY_ERROR, 3)
        return
    end

    if doClaim then
        -- ticket already claimed
        if IsValid(ticket.admin) then
            cats.config.notify(ply, cats.lang.error_ticketAlreadyClaimed, NOTIFY_ERROR, 3)
            return
        end

        -- notify about claim
        cats.config.notify(ply, cats.lang.ticketClaimed, NOTIFY_GENERIC, 5)
        cats.config.notify(ticket.user, string.format(cats.lang.ticketClaimedBy, ply:Name()), NOTIFY_GENERIC, 5)
    else
        -- ticket not claimed yet
        if not IsValid(ticket.admin) then
            cats.config.notify(ply, cats.lang.error_ticketNotClaimed, NOTIFY_ERROR, 3)
            return
        end

        -- notify about unclaim
        cats.config.notify(ply, cats.lang.ticketUnclaimed, NOTIFY_GENERIC, 5)
        cats.config.notify(ticket.user, string.format(cats.lang.ticketUnclaimedBy, ply:Name()), NOTIFY_GENERIC, 5)
    end

    -- do the thing
    cats:ClaimTicket(steamID, ply, doClaim)

end)

function cats:GetAdminList(steamID, callback)

    if not self.adminDataCache.lastUpdate or self.adminDataCache.lastUpdate + 300 > CurTime() then
        -- generate new cache
        cats:Query([[
            SELECT steamID, lastNick, ratingTotal FROM cats_]] .. self.config.serverID .. [[_admins;
        ]], function(res)
            if res and #res > 0 then
                -- store it
                for k, adminData in pairs(res) do
                    self.adminDataCache[adminData.steamID] = adminData
                end

                -- return results
                callback(self.adminDataCache)
            end
        end)
    else
        -- return results out of cache
        callback(self.adminDataCache)
    end

end
net.Receive('cats.getAdminList', function(len, ply)

    -- check cooldown
    if ply.cats_cooldowns.getAdminList and ply.cats_cooldowns.getAdminList > CurTime() then
        cats.config.notify(ply, cats.lang.error_wait, NOTIFY_ERROR, 3)
        return
    end
    ply.cats_cooldowns.getAdminList = CurTime() + 0.2

    -- check if has access
    if not cats.config.playerCanSeeTicket(ply) then
        cats.config.notify(ply, cats.lang.error_noAccess, NOTIFY_ERROR, 3)
        return
    end

    -- send it to player
    cats:Log('Sending admin list to ' .. tostring(ply))
    cats:GetAdminList(steamID, function(data)
        if not IsValid(ply) or not data then return end

        net.Start('cats.getAdminList')
            net.WriteTable(data)
        net.Send(ply)
    end)

end)

---------------------------------------------------
-- PLAYER FUNCTIONS
---------------------------------------------------

-- save player's data to DB
function cats:SavePlayer(ply, callback)

    local plyName = ply:Name()
    local data = ply.cats_adminData
    if data then
        data.playTimeTotal = ply:GetUTimeTotalTime()

        local q = [[
            SELECT
                SUM(ticketTime) AS ticketTimeTotal,
                COUNT(USER) AS claimsTotal,
                COUNT(DISTINCT USER) AS uniqueUsers,
                (SELECT AVG(avgPerUser) FROM (
                    SELECT AVG(rating) AS avgPerUser
                        FROM cats_lostcity_claims
                        WHERE admin = ']] .. data.steamID .. [['
                        GROUP BY user
                    ) AS avgs
                ) AS ratingTotal
            FROM cats_]] .. self.config.serverID .. [[_claims
            WHERE admin = ']] .. data.steamID .. [[';
        ]]

        self:Query(q, function(res)
            res = res and #res > 0 and res[1]
            if res then
                data.lastNick = plyName or "Unknown"
                data.lastPlayedTime = os.time() or 0
                data.playTimeTotal = data.playTimeTotal or 0
                data.ticketTimeTotal = res.ticketTimeTotal or 0
                data.ratingTotal = res.ratingTotal or 0
                data.claimsTotal = res.claimsTotal or 0
                data.uniqueUsers = res.uniqueUsers or 0
                data.timeCard = data.timeCard or table.Copy(PUNCHCARD_EMPTY)
                data.claimCard = data.claimCard or table.Copy(PUNCHCARD_EMPTY)
                data.updateTime = os.time() or 0

                local q = string.format([[
                    UPDATE cats_]] .. self.config.serverID .. [[_admins
                    SET lastNick = %s,
                        lastPlayedTime = %d,
                        playTimeTotal = %d,
                        ticketTimeTotal = %d,
                        ratingTotal = %f,
                        claimsTotal = %d,
                        uniqueUsers = %d,
                        timeCard = %s,
                        claimCard = %s,
                        updateTime = %d
                    WHERE steamID = ']] .. data.steamID .. [[';
                ]],
                    MySQLite.SQLStr( data.lastNick ),
                    data.lastPlayedTime,
                    data.playTimeTotal,
                    data.ticketTimeTotal,
                    data.ratingTotal,
                    data.claimsTotal,
                    data.uniqueUsers,
                    MySQLite.SQLStr( util.TableToJSON(data.timeCard) ),
                    MySQLite.SQLStr( util.TableToJSON(data.claimCard) ),
                    data.updateTime
                )

                self:Query(q, callback)
            else
                self.QueryError('No claim records on ' .. data.steamID, q)
            end
        end)
    end

end

-- get admin's data
function cats:GetAdminData(steamID, callback)

    local target = player.GetBySteamID(steamID)
    if IsValid(target) then
        -- player exists in server
        if target.cats_adminData and os.time() > target.cats_adminData.updateTime + 60 then
            -- old data, save it first
            self:SavePlayer(target, function()
                if not IsValid(target) then return end
                callback(target.cats_adminData) -- can be nil if player is not an admin
            end)
        else
            -- recently updated, return current data
            callback(target.cats_adminData) -- can be nil if player is not an admin
        end
    else
        -- player's not here, grab data from DB
        self:Query([[
            SELECT * FROM cats_]] .. self.config.serverID .. [[_admins
            WHERE steamID = ']] .. steamID .. [['
        ]], function(res)
            res = res and #res > 0 and res[1]
            if res then
                -- return the data
                res.timeCard = util.JSONToTable(res.timeCard)
                res.claimCard = util.JSONToTable(res.claimCard)
                callback(res)
            else
                -- no data on him, return nil
                callback()
            end
        end)
    end

end
net.Receive('cats.getAdminData', function(len, ply)

    local steamID = net.ReadString()

    -- check cooldown
    if ply.cats_cooldowns.getAdminData and ply.cats_cooldowns.getAdminData > CurTime() then
        cats.config.notify(ply, cats.lang.error_wait, NOTIFY_ERROR, 3)
        return
    end
    ply.cats_cooldowns.getAdminData = CurTime() + 0.5

    -- check if has access
    if not cats.config.playerCanSeeTicket(ply) then
        cats.config.notify(ply, cats.lang.error_noAccess, NOTIFY_ERROR, 3)
        return
    end

    -- send it to player
    cats:Log('Sending data of \'' .. steamID .. '\' to ' .. tostring(ply))
    cats:GetAdminData(steamID, function(data)
        if not IsValid(ply) or not data then return end

        net.Start('cats.getAdminData')
            net.WriteTable(data)
        net.Send(ply)
    end)

end)

---------------------------------------------------
-- GAMEMODE HOOKS
---------------------------------------------------

-- initiate tickets
hook.Add("PlayerSay", "cats", function(ply, text)

    local shouldTrigger, msg = cats.config.triggerText(ply, text)
    if shouldTrigger then
        cats:DispatchMessage(ply, ply:SteamID(), msg)
        return ''
    end

end)

-- init admin
hook.Add( "PlayerDataLoaded", "cats", function(ply)

    ply.cats_cooldowns = {}
    if cats.config.playerCanSeeTicket(ply, "") then
        cats:Query([[
            SELECT * FROM cats_]] .. cats.config.serverID .. [[_admins
            WHERE steamID = ]] .. MySQLite.SQLStr( ply:SteamID() ) .. [[;
        ]], function(res)
            res = res and #res > 0 and res[1]
            if res then
                if not IsValid(ply) then return end
                ply.cats_adminData = res
                ply.cats_adminData.timeCard = ply.cats_adminData.timeCard and util.JSONToTable(ply.cats_adminData.timeCard) or table.Copy(PUNCHCARD_EMPTY)
                ply.cats_adminData.claimCard = ply.cats_adminData.claimCard and util.JSONToTable(ply.cats_adminData.claimCard) or table.Copy(PUNCHCARD_EMPTY)
            else
                ply.cats_adminData = {
                    steamID = ply:SteamID(),
                    lastNick = ply:Name(),
                    createdTime = os.time(),
                    playTimeTotal = ply:GetUTimeTotalTime(),
                    lastPlayedTime = os.time(),
                    ticketTimeTotal = 0,
                    updateTime = os.time(),
                    ratingTotal = 0,
                    claimsTotal = 0,
                    uniqueUsers = 0,
                    timeCard = table.Copy(PUNCHCARD_EMPTY),
                    claimCard = table.Copy(PUNCHCARD_EMPTY)
                }

                cats:Query(string.format([[
                    INSERT INTO cats_]] .. cats.config.serverID .. [[_admins(steamID, lastNick, createdTime, lastPlayedTime, playTimeTotal, ticketTimeTotal, ratingTotal, claimsTotal, uniqueUsers, timeCard, claimCard, updateTime)
                    VALUES (%s, %s, %d, %d, %d, %d, %f, %d, %d, %s, %s, %d);
                ]],
                    MySQLite.SQLStr( ply.cats_adminData.steamID ),
                    MySQLite.SQLStr( ply.cats_adminData.lastNick ),
                    ply.cats_adminData.createdTime,
                    ply.cats_adminData.playTimeTotal,
                    ply.cats_adminData.lastPlayedTime,
                    ply.cats_adminData.ticketTimeTotal,
                    ply.cats_adminData.ratingTotal,
                    ply.cats_adminData.claimsTotal,
                    ply.cats_adminData.uniqueUsers,
                    MySQLite.SQLStr( util.TableToJSON(ply.cats_adminData.timeCard) ),
                    MySQLite.SQLStr( util.TableToJSON(ply.cats_adminData.claimCard) ),
                    os.time()
                ))
            end

			ply:SetNWFloat("cats_adminRating", ply.cats_adminData.ratingTotal)
        end)
	end

	local q = [[
		SELECT
		COUNT(rating) AS ratingsTotal,
		AVG(rating) AS averageRating
		FROM cats_]] .. cats.config.serverID .. [[_claims
		WHERE user = ']] .. ply:SteamID() .. [[';
	]]

	cats:Query(q, function(res)
		res = res and #res > 0 and res[1]
		if res and IsValid(ply) then
			ply:SetNWInt("cats_ratingsTotal", res.ratingsTotal)
			ply:SetNWFloat("cats_averageRating", res.averageRating)
		end
	end)

end)

-- deal with disconnected players
hook.Add( "PlayerDisconnected", "cats", function(ply)

    -- save player data
    cats:SavePlayer(ply)

    for steamID, ticket in pairs(cats.currentTickets) do
        if steamID == ply:SteamID() then
            -- notify clients
            net.Start('cats.closeTicket')
                net.WriteString(steamID)
            net.Send(getAdmins(steamID))

            -- notify admin
            if IsValid(ticket.admin) then
                cats.config.notify(ticket.admin, cats.lang.ticketUserLeft, NOTIFY_ERROR, 8)
            end

            -- delete ticket
            cats.currentTickets[steamID] = nil
        elseif ticket.adminID == ply:SteamID() then
            -- unclaim ticket
            cats:ClaimTicket(steamID, ply, false)
        end
    end

end)

hook.Add( "PlayerIsLoaded", "cats", function(ply)

    if cats.config.playerCanSeeTicket(ply, "") then
        net.Start('cats.syncTickets')
            net.WriteTable(cats.currentTickets)
        net.Send(ply)
    end

end)

-- init database
hook.Add( "DatabaseInitialized", "cats", function()

    local AUTOINCREMENT = MySQLite.isMySQL() and "AUTO_INCREMENT" or "AUTOINCREMENT"
	cats:Query([[
		CREATE TABLE IF NOT EXISTS cats_]] .. cats.config.serverID .. [[_admins(
			steamID VARCHAR(30) NOT NULL PRIMARY KEY,
			lastNick VARCHAR(255) NOT NULL,
			createdTime INTEGER(11) NOT NULL,
			lastPlayedTime INTEGER(11) NOT NULL,
            playTimeTotal INTEGER(11) NOT NULL,
			ticketTimeTotal INTEGER(8) NOT NULL,
			ratingTotal FLOAT NOT NULL,
			claimsTotal INTEGER NOT NULL,
            uniqueUsers INTEGER NOT NULL,
            timeCard TEXT NOT NULL,
            claimCard TEXT NOT NULL,
            updateTime INTEGER(11) NOT NULL
		);
    ]])

    cats:Query([[
        CREATE TABLE IF NOT EXISTS cats_]] .. cats.config.serverID .. [[_claims(
            id INTEGER NOT NULL PRIMARY KEY ]] .. AUTOINCREMENT .. [[,
            user VARCHAR(30) NOT NULL,
            admin VARCHAR(30) NOT NULL,
			createdTime INTEGER(11) NOT NULL,
			ticketTime INTEGER(5) NOT NULL,
            rating FLOAT NOT NULL,
            FOREIGN KEY(admin) REFERENCES cats_]] .. cats.config.serverID .. [[_admins(steamID) ON DELETE CASCADE
        );
    ]])

    cats:Query([[
		CREATE TABLE IF NOT EXISTS cats_]] .. cats.config.serverID .. [[_playtime(
			id INTEGER NOT NULL PRIMARY KEY ]] .. AUTOINCREMENT .. [[,
            admin VARCHAR(30) NOT NULL,
			joinedTime INTEGER(11) NOT NULL,
            playTime INTEGER(6) NOT NULL,
            FOREIGN KEY(admin) REFERENCES cats_]] .. cats.config.serverID .. [[_admins(steamID) ON DELETE CASCADE
		);
    ]])

    cats:Query([[
		CREATE TABLE IF NOT EXISTS cats_]] .. cats.config.serverID .. [[_summary(
			id INTEGER NOT NULL PRIMARY KEY ]] .. AUTOINCREMENT .. [[,
			checkTime INTEGER(11) NOT NULL,
			adminsAmount INTEGER(4) NOT NULL,
            playersAmount INTEGER(4) NOT NULL,
            casesClaimedAmount INTEGER(4) NOT NULL,
            casesUnclaimedAmount INTEGER(4) NOT NULL
		);
    ]])

end)

-- timeCard update
local nextTimeCardTick, nextTimeCardUpdate = 0, 0
hook.Add("Think", "cats.timeCard", function()

    if CurTime() < nextTimeCardTick then return end
    nextTimeCardTick = CurTime() + 1

    if os.time() >= nextTimeCardUpdate then
        nextTimeCardUpdate = os.time() + 600
        local now = os.date('*t', os.time())
        now.wday = now.wday - 1
        for k, ply in pairs(player.GetAll()) do
            if ply.cats_adminData and ply.cats_adminData.timeCard then
                day = now.wday ~= 0 and now.wday or 7
                hour = now.hour ~= 0 and now.hour or 24
                ply.cats_adminData.timeCard[day][hour] = ply.cats_adminData.timeCard[day][hour] + 1
            end
        end

        

        cats:Log('Временная  карта обновлена.')
    end

end)
