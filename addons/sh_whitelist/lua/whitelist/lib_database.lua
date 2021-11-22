/*
* You can copy this file for your own server/personal use.
* What you can't do is use it in a commercial project without my approval (add me at http://steamcommunity.com/id/shendow/)
* I won't provide much support if you run into trouble editing this file.
*/

local base_table = SH_WHITELIST
local prefix = "SH_WHITELIST."

function base_table:DBPrint(s)
	local src = debug.getinfo(1)
	local _, __, name = src.short_src:find("addons/(.-)/")
	MsgC(Color(0, 200, 255), "[" .. name:upper() .. " DB] ", color_white, s, "\n")
end

function base_table:ConnectToDatabase()
	local dm = self.DatabaseMode
	if (dm == "mysqloo") then
		require("mysqloo")

		local cfg = self.DatabaseConfig

		self:DBPrint("Connecting to database")

		local db = mysqloo.connect(cfg.host, cfg.user, cfg.password, cfg.database, cfg.port)
		db:setAutoReconnect(true)
		db:setMultiStatements(true)
		db.onConnected = function()
			self:DBPrint("Connected to database!")
			self.m_bConnectedToDB = true

			if (self.DatabaseConnected) then
				self:DatabaseConnected()
			end
		end
		db.onConnectionFailed = function(me, err)
			self:DBPrint("Failed to connect to database: " .. err .. "\n")
			print(err)
			self.m_bConnectedToDB = false
		end
		db:connect()
		_G[prefix .. "DB"] = db
	else
		self:DBPrint("Defaulting to sqlite")
		self.m_bConnectedToDB = true

		if (self.DatabaseConnected) then
			self:DatabaseConnected()
		end
	end
end

function base_table:IsConnectedToDB()
	return self.m_bConnectedToDB
end

function base_table:Query(query, callback)
	if (!self:IsConnectedToDB()) then
		return end

	local dm = self.DatabaseMode

	callback = callback or function(q, ok, ret) end

	if (dm == "mysqloo") then
		local q = _G[prefix .. "DB"]:query(query)
		q.onSuccess = function(me, data)
			_SH_QUERY_LAST_INSERT_ID = me:lastInsert()
			callback(query, true, data)
			_SH_QUERY_LAST_INSERT_ID = nil
		end
		q.onError = function(me, err, fq)
			callback(query, false, err .. " (" .. fq .. ")")
			self:DBPrint(err .. " (" .. fq .. ")")
		end
		q:start()
	else
		local d = sql.Query(query)
		if (d ~= false) then
			callback(query, true, d or {})
		else
			callback(query, false, sql.LastError())
			if (!_SH_QUERY_SILENT) then
				print("sqlite error (" .. query .. "): " .. sql.LastError())
			end
		end
	end
end

function base_table:Escape(s)
	local dm = self.DatabaseMode
	if (dm == "mysqloo") then
		return _G[prefix .. "DB"]:escape(s)
	else
		return sql.SQLStr(s, true)
	end
end

function base_table:BetterQuery(query, args, callback)
	for k, v in pairs (args) do
		if (isstring(v)) then
			v = self:Escape(v)
		elseif (type(v) == "Player") then
			v = self:NetworkID(v)
		elseif (isbool(v)) then
			continue end

		query = query:Replace("{" .. k .. "}", "'" .. v .. "'")
		query = query:Replace("[" .. k .. "]", v)
	end

	self:Query(query, callback)
end

function base_table:NetworkID(ply)
	return ply:SteamID():Replace("STEAM_", ""):Replace(":", "_")
end

function base_table:TryCreateTable(name, code, cb)
	cb = cb or function() end

	local dm = self.DatabaseMode
	if (dm == "mysqloo") then
		self:Query("SHOW TABLES LIKE '" .. name .. "'", function(q, ok, data)
			if (!ok) or (data and table.Count(data) > 0) then
				cb()
				return
			end

			self:Query([[
				CREATE TABLE IF NOT EXISTS `]] .. name .. [[` (]] .. code .. [[) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
			]], function(q2, ok2, data2)
				self:DBPrint("Creating " .. name .. ": " .. tostring(ok2) .. " (" .. tostring(data2) .. ")")
				cb()
			end)
		end)
	elseif (!sql.TableExists(name)) then
		sql.Query([[
			CREATE TABLE `]] .. name .. [[` (]] .. code .. [[)
		]])

		self:DBPrint("Creating " .. name .. ": " .. tostring(sql.TableExists(name)))
		cb()
	end
end

function base_table:TryInsert(query, args, callback)
	query = query:Replace("INSERT INTO", self.DatabaseMode == "mysqloo" and "INSERT IGNORE INTO" or "INSERT OR IGNORE INTO")
	self:BetterQuery(query, args, callback)
end

function base_table:CreateMultipleTables(tables, callback)
	callback = callback or function() end
	
	local function Advance()
		if (table.Count(tables) > 0) then
			local k = table.GetFirstKey(tables)
			local d = tables[k]
			tables[k] = nil

			self:TryCreateTable(k, d, function()
				Advance()
			end)
		else
			callback()
		end
	end

	Advance()
end

hook.Add("InitPostEntity", prefix .. "ConnectToDatabase", function()
	base_table:ConnectToDatabase()
end)

if (_G[prefix .. "DB"]) then
	base_table.m_bConnectedToDB = _G[prefix .. "DB"]:status() == 0
end