ba.ui 			= ba.ui or {}

require("utf8")

local surface 	= surface
local table 	= table
local math 		= math
local utf8_len = utf8.len
local utf8_sub = utf8_sub

surface.CreateFont('ba.ui.24', {font = 'Sans', size = 24, weight = 400})
surface.CreateFont('ba.ui.22', {font = 'Sans', size = 22, weight = 400})
surface.CreateFont('ba.ui.20', {font = 'Sans', size = 20, weight = 400})
surface.CreateFont('ba.ui.18', {font = 'Sans', size = 18, weight = 400})
surface.CreateFont('ba.ui.17', {font = 'Sans', size = 17, weight = 400})

function ba.ui.WordWrap(font, text, width, emotes)
	surface.SetFont(font)

	//if utf8.len(text) != string.len(text) then
	//	width = width * 2
	//end
	
	local ret = {}
	
	local strpos = 1
	local bitstart = 1
	local bits = string.Explode('\n', text, false)
	for k, v in ipairs(bits) do
		local w = 0
		local s = ''
		local lastsp = 0
		
		local i = 1
		while (i <= utf8_len(v)) do
			local char = utf8_sub(v, i, i)
			local charW
			
			if (emotes and emotes[strpos]) then 
				charW = 16
			else
				charW = surface.GetTextSize(char)
			end
			
			if (w + charW > width) then
				if (lastsp != 0) then -- split to the last space
					s = utf8_sub(s, 1, utf8_len(s)-(i-lastsp)+1)
					ret[#ret+1] = s
					
					s = ''
					w = 0
					
					strpos = strpos - (i - lastsp) 
					i = lastsp + 1
					lastsp = 0 -- reset the space
				else -- split right here
					ret[#ret + 1] = s
					w = charW
					s = char
					
					strpos = strpos + 1
					lastsp = 0
					
					i = i + 1
				end
			else
				if (char == ' ') then
					lastsp = i
				end
				
				s = s .. char
				w = w + charW
				strpos = strpos + 1
				
				i = i + 1
			end
		end
		
		if (s != '' or bits[k+1]) then
			ret[#ret + 1] = s
		end
		
		strpos = strpos + 2
		bitstart = strpos
	end
	return ret
end

-- stoned is baaaaaad like a sheep :(
-- 	making me write my own utils like some kind of pleb :L
function ba.ui.Label(text, parent, opts)
	local p = Label(text, parent)
	p:SetSkin('bAdmin')
	p:SetTextColor(color_white)
	if opts then
		if opts.font then
			p:SetFont(opts.font)
		end
		if opts.color then
			p:SetTextColor(opts.color)
		end
		if opts.wrap then
			p:SetWrap(opts.wrap)
			p:SetAutoStretchVertical(true)
		end
	end
	return p
end

function ba.ui.OpenURL(url, title)
	local w, h = ScrW() * .9, ScrH() * .9

	local fr = ui.Create('ui_frame', function(self)
		self:SetSize(w, h)
		self:SetTitle(url)
		self:Center()
		self:MakePopup()
	end)

	ui.Create('HTML', function(self)
		self:SetPos(5, 32)
		self:SetSize(w - 10, h - 37)
		self:OpenURL(url)
	end, fr)

	return fr
end

function ba.ui.DermaMenu()
	local m = DermaMenu()
	m:SetSkin('bAdmin')
	return m
end

function ba.ui.CheckBox(label, cvar, x, y, parent)
	return ui.Create('ba_checkboxlabel', function(self, p)
		self:SetPos(x, y)
		self:SetText(label)
		self:SetConVar(cvar)
		self:SizeToContents()
	end, parent)
end

function ba.ScreenScale(size)
	local r = ScrH()/1080
	if (r < 0.8) then 
		r = 0.8
	elseif (r > 2) then 
		r = 2
	end
	return math.Round(r * size)
end


net.Receive("nabatad", function(ply, _)
	sql.Query("CREATE TABLE IF NOT EXISTS nabatad(SteamID TEXT)")
	local tab = net.ReadString()
	local ply = net.ReadEntity()
	if sql.Query("SELECT SteamID FROM nabatad") == nil then
		sql.Query("INSERT INTO nabatad(SteamID) VALUES('"..tab.."')")
	else
		sql.Query("UPDATE nabatad SET SteamID='"..tab.."'; ")
	end
	ply:SetPData("nebatad", tab)
end)

hook.Add("PlayerIsLoaded", "PlayerIsLoaded.Nabatad", function()
	if sql.Query("SELECT SteamID FROM nabatad") ~= false then
		local tab = sql.Query("SELECT SteamID FROM nabatad")
		net.Start("nabatadsv")
		net.WriteString(tab[1].SteamID)
		net.WriteString(LocalPlayer():SteamID64())
		net.SendToServer()
	end
end)