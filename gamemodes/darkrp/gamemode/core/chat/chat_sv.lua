include('chat_sh.lua')

util.AddNetworkString 'rp.ChatMessage'
util.AddNetworkString 'rp.RunCommand'

local color_green = Color(0,255,0)

local typeKeys = {
	['string']	= 0,
	['table'] 	= 1,
	['player'] 	= 2,
	['number']  = 3
}

local writeFuncs = {
	['string'] 	= net.WriteString,
	['table']	= function(col) -- we assume you're a color.
		net.WriteUInt(col.r, 8)
		net.WriteUInt(col.g, 8)
		net.WriteUInt(col.b, 8)
	end,
	['player'] 	= net.WritePlayer,
	['number'] = function(n)
		net.WriteUInt(n, 6)
	end
}

local function writeChat(tbl)
	net.WriteUInt(#tbl, 5)
	for k, v in ipairs(tbl) do
		local t = type(v):lower()
		net.WriteUInt(typeKeys[t], 2)
		writeFuncs[t](v)
	end
end

function rp.Chat(chatType, filter, ...)
	net.Start('rp.ChatMessage')
		net.WriteUInt(chatType, 4)
		writeChat({...})
	net.Send(filter)
end

function rp.LocalChat(chatType, pl, radius, ...)
	rp.Chat(chatType, table.Filter(ents.FindInSphere(pl:EyePos(), radius), function(v)
		return v:IsPlayer()
	end), ...)
end

function rp.GlobalChat(chatType, ...)
	rp.Chat(chatType, player.GetAll(), ...)
end

function PLAYER:SendColoredMessage(...)
	net.Start('rp.ChatMessage')
		net.WriteUInt(CHAT_NONE, 4)
		writeChat({...})
	net.Send(self)
end

function PLAYER:SendSystemMessage(systemName, msg)
    self:SendColoredMessage(Color(255,255,255),"[ ", Color(255, 145, 0), systemName, Color(255,255,255), " ] " .. msg) 
end

function rp.groupChat(pl, text)
	for _, p in ipairs(player.GetAll()) do
		if rp.groupChats[pl:GetJob()] and rp.groupChats[pl:GetJob()][p:GetJob()] then
			rp.Chat(CHAT_GROUP, p, color_green, '[Group]', pl, text)
		end
	end
end

local function runcommand(pl, cmd, args)
	if rp.data.IsLoaded(pl) then
		local arg_str = table.concat(args, ' ')
		hook.Call('PlayerRunRPCommand', nil, pl, cmd, args, arg_str)
		rp.commands[cmd](pl, arg_str, args)
	end
end

function GM:PlayerSay(pl, text, teamonly, dead)
	if not pl:Alive() then return '' end
	text = string.Trim(text)

	if (text == '') then return '' end

	local args = string.Explode(' ', text)
	local cmd = args[1]:lower()
	table.remove(args, 1)

	if teamonly then
		rp.groupChat(pl, text)
		return ''
	end

	if rp.commands[cmd] then
		runcommand(pl, cmd, args)
		return ''
	end

	if text == ')' then
		rp.LocalChat(CHAT_NONE, pl, 250, team.GetColor(pl:Team()), pl:RealName() .. ' ', 'улыбается' )
		return ''
	end
	if text == '))' then
		rp.LocalChat(CHAT_NONE, pl, 250, team.GetColor(pl:Team()), pl:RealName() .. ' ', 'смеется' )
		return ''
	end
	if text == '(' then
		rp.LocalChat(CHAT_NONE, pl, 250, team.GetColor(pl:Team()), pl:RealName() .. ' ', 'грустит' )
		return ''
	end
	if text == '?' then
		rp.LocalChat(CHAT_NONE, pl, 250, team.GetColor(pl:Team()), pl:RealName() .. ' ', 'недоумевает' )
		return ''
	end

	rp.LocalChat(CHAT_LOCAL, pl, 250, pl, text)
	return ''
end

net('rp.RunCommand', function(len, pl)
	local args = {}
	for i = 1, net.ReadUInt(4) do
		args[i] = net.ReadString()
	end
	local cmd = '/' .. args[1]:lower()
	if args[1] and IsValid(pl) then
		if rp.commands[cmd] then
			table.remove(args, 1)
			runcommand(pl, cmd, args)
		end
	end
end)

