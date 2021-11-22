ba.Terms 		= ba.Terms 		or {}
ba.TermsMap 	= ba.TermsMap 	or {}
ba.TermsStore 	= ba.TermsStore or {}

local c = 0
hook.Add('BadminPlguinsLoaded', 'ba.terms.BadminPlguinsLoaded', function()
	for k, v in SortedPairsByMemberValue(ba.TermsStore, 'Name', false) do
		ba.TermsMap[v.Name] = c 
		ba.Terms[c] = v.Message
		c = c + 1
	end
end)

local color_red 	= Color(255,0,0)
local color_white 	= Color(235,235,235)
local color_console = Color(200,200,200)
local color_green 	= Color(20,160,255)
local color_grey 	= Color(190,190,190)

function ba.AddTerm(name, message)
	local k = ba.TermsMap[name] or (#ba.TermsStore + 1)
	ba.TermsStore[k] = {
		Name = name,
		Message = message,
	}
end

function ba.Term(name)
	return ba.TermsMap[name]
end

local function writeargs(...)
	for k, v in ipairs({...}) do
		local t = type(v)
		if (t == 'Player') then
			net.WriteUInt(0,2)
			net.WritePlayer(v)
		elseif (t == 'Entity') then
			net.WriteUInt(1,2)
		else
			net.WriteUInt(2,2)
			net.WriteString(tostring(v))
		end
	end
end

local function readargs(msg)
	local tab = {}
	local k = 1
	local isfirst = (string.sub(msg, 1, 1) == '#') -- do the hack, do the hack
	local hasargs = (string.find(msg, '#') ~= nil)
	for v in string.gmatch(msg, '([^#]+)') do
		if (not isfirst) then
			tab[k] = v
			k = k + 1
		end
		if hasargs then
			local t = net.ReadUInt(2)
			if (t == 0) then 
				local v = net.ReadPlayer()
				if IsValid(v) then
					tab[k] = team.GetColor(v:Team())
					tab[k + 1] = v:RPName(true)
					tab[k + 2] = color_grey
					tab[k + 3] = '(' .. v:SteamID() .. ')'
					tab[k + 4] = color_white
					k = k + 5
				else
					tab[k] = color_console
					tab[k + 1] = 'Unknown'
					tab[k + 2] = color_white
					k = k + 3
				end
			elseif (t == 1) then
				tab[k] = color_console
				tab[k + 1] = '(Console)'
				tab[k + 2] = color_white
				k = k + 3
			else
				tab[k] = color_green
				tab[k + 1] = net.ReadString()
				tab[k + 2] = color_white
				k = k + 3
			end
		end
			if (isfirst) then
				tab[k] = v
				k = k + 1
			end
		end

	if (not IsColor(tab[1])) then
		table.insert(tab, 1, color_white)
	end

	return tab
end

function ba.WriteTerm(id, ...)
	net.WriteUInt(id, 8)
	writeargs(...)
end

function ba.ReadTerm()
	return readargs(ba.Terms[net.ReadUInt(8)])
end

function ba.WriteMsg(msg, ...)
	net.WriteString(msg)
	writeargs(...)
end

function ba.ReadMsg()
	return readargs(net.ReadString())
end