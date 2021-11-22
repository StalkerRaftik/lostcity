ba.logs = ba.logs or {
	Stored 			= {},
	Maping 			= {},
	Data 			= {},
	PlayerEvents 	= {},
}

ba.log_mt			= ba.log_mt or {}
ba.log_mt.__index 	= ba.log_mt

local log_mt 		= ba.log_mt
local id_cache 		= {}

if (not file.IsDir('badmin/logs', 'data')) then
	file.CreateDir('badmin/logs')
end

local count = 0
function ba.logs.Create(name)
	local id
	if ba.logs.Stored[name] then
		id = ba.logs.Stored[name].ID
	else
		id = count
		count = count + 1
	end

	local l = setmetatable({
		Name  = name,
		ID 	  = count
	}, ba.log_mt)

	ba.logs.Stored[l.Name] 	= l
	ba.logs.Maping[l.ID] 	= l.Name
	ba.logs.Data[l.Name]	= {}	
	return l
end

ba.logs.Terms 		= ba.logs.Terms 		or {}
ba.logs.TermsMap 	= ba.logs.TermsMap 		or {}
ba.logs.TermsStore 	= ba.logs.TermsStore 	or {}

local c = 0
hook.Add('BadminPlguinsLoaded', 'ba.logs.terms.BadminPlguinsLoaded', function()
	for k, v in SortedPairsByMemberValue(ba.logs.TermsStore, 'Name', false) do
		ba.logs.TermsMap[v.Name] = c 
		ba.logs.Terms[c] = {Message = v.Message, Copy = v.Copy}
		c = c + 1
	end
end)

function ba.logs.AddTerm(name, message, copy)
	local k = ba.logs.TermsMap[name] or (#ba.logs.TermsStore + 1)
	ba.logs.TermsStore[k] = {
		Name = name,
		Message = message,
		Copy = copy
	}
end

function ba.logs.Term(name)
	return ba.logs.TermsMap[name]
end

function ba.logs.GetTerm(id)
	return ba.logs.Terms[id]
end


function ba.logs.GetTable()
	return ba.logs.Stored
end

function ba.logs.Get(name)
	return ba.logs.Stored[name]
end

function ba.logs.GetByID(id)
	return ba.logs.Get(ba.logs.Maping[id])
end

function ba.logs.Encode(data)
	return util.Compress(pon1.encode(data))
end

function ba.logs.Decode(data)
	return pon1.decode(util.Decompress(data))
end

function ba.logs.GetSaves()
	local files = file.Find('badmin/logs/*.dat', 'DATA', 'datedesc')
	for k, v in ipairs(files) do
		files[k] = string.StripExtension(v)
	end
	return files
end

function ba.logs.OpenSave(name)
	return ba.logs.Decode(file.Read('badmin/logs/' .. name .. '.dat', 'DATA'))
end

function ba.logs.DeleteSave(name)
	file.Delete('badmin/logs/' .. name .. '.dat')
end

function ba.logs.SaveExists(name)
	return file.Exists('badmin/logs/' .. string.Trim(name) .. '.dat', 'DATA')
end

function ba.logs.SaveLog(name, tbl)
	file.Write('badmin/logs/' .. string.Trim(name) .. '.dat', ba.logs.Encode(tbl)) 
end

function log_mt:SetColor(color)
	self.Color = color
	return self
end

function log_mt:Hook(name, callback)
	if (SERVER) then
		hook.Add(name, 'ba.logs.' .. name, function(...)
			callback(self, ...)
		end)
	end
	return self
end

function log_mt:GetName()
	return self.Name
end

function log_mt:GetColor()
	return self.Color
end

function log_mt:GetID()
	return self.ID
end


-- Commands
ba.cmd.Create('Logs', function(pl, args)
	ba.logs.OpenMenu(pl)
end)
:SetFlag('M')
:SetHelp('Shows you the logs')

ba.cmd.Create('PlayerEvents', function(pl, args)
	local steamid = ba.InfoTo32(args.target)
	if not ba.logs.PlayerEvents[steamid] then
		ba.notify_err(pl, ba.Term('NoPlayerEvents'))
		return
	end
	ba.logs.OpenPlayerEvents(pl, steamid)
end)
:AddParam('player_steamid', 'target')
:SetFlag('M')
:SetHelp('Shows you the logs for a specified player')
:AddAlias('pe')

-- Defualt logs
local term = ba.logs.Term

ba.logs.AddTerm('Connect', '#(#) подключился', {
	'Name',
	'SteamID'
})

ba.logs.AddTerm('Disconnect', '#(#) вышел с сервера', {
	'Name',
	'SteamID'
})

ba.logs.Create 'Подключения'
	:Hook('PlayerInitialSpawn', function(self, pl)
		self:PlayerLog(pl, term('Connect'), pl:RPName(), pl:SteamID())
	end)
	:Hook('PlayerDisconnected', function(self, pl)
		self:PlayerLog(pl, term('Disconnect'), pl:RPName(), pl:SteamID())
	end)


local function concatargs(args)
	local str
	for k, v in pairs(args) do
		str =  (str and str .. ', ' .. tostring(v) or tostring(v))
	end
	return str 
end

ba.logs.AddTerm('RunCommand', '#(#) использовал команду # с аргументами: "#"', {
	'Name',
	'SteamID',
	'Command'
})

ba.logs.Create 'Команды(Администрация)'
	:Hook('playerRunCommand', function(self, pl, cmd, args)
		if ba.IsPlayer(pl) then
			self:PlayerLog(pl, term('RunCommand'), pl:RPName(true), pl:SteamID(), cmd, (args.raw and concatargs(args.raw, ', ') or ''))
		end
	end)

ba.logs.AddTerm('Chat', '#(#) сказал "#"', {
	'Name',
	'SteamID'
})

ba.logs.AddTerm('VoiceStart', '#(#) начал говорить в микрофон', {
	'Name',
	'SteamID'
})

ba.logs.AddTerm('VoiceEnd', '#(#) закончил говорить в микрофон', {
	'Name',
	'SteamID'
})

ba.logs.Create 'Чат'
	:Hook('PlayerSay', function(self, pl, text)
		if (text ~= '') and (text[1] ~= '!') and (text[1] ~= '/') then
			self:PlayerLog(pl, term('Chat'), pl:RPName(true), pl:SteamID(), text)
		end
	end)
	:Hook('PlayerStartVoice', function(self, pl)
		--self:PlayerLog(pl, term('VoiceStart'), pl:RPName(true), pl:SteamID())
	end)
	:Hook('PlayerEndVoice', function(self, pl)
		--self:PlayerLog(pl, term('VoiceEnd'), pl:RPName(true), pl:SteamID())
	end)


ba.logs.AddTerm('PlayerGetResources', '[#] #(#) взял снаряжение за # ресурсов', {
	'Name',
	'SteamID'
})

ba.logs.Create 'Группировки'
	:Hook('rp.Fractions.PlayerGetResources', function(self, pl, fraction, kitPrice)
		self:PlayerLog(pl, term('PlayerGetResources'), fraction.Name, pl:RPName(true), pl:SteamID(), kitPrice)
	end)