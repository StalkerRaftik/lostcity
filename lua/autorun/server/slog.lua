require 'slog'
require 'sourcenet'

local Tag = 'commandspamexploit'
local max = 10000
local t = setmetatable({}, {})

hook.Add('ExecuteStringCommand', Tag, function(s, c)

	local stats = t[s]
	if not stats then
		stats = 0
	end

	if stats > max then
		local pl = player.GetBySteamID(s)
		if pl.kicked then return true end
		local uid = pl:UserID()
		print('overflow', s, stats)
		
		pl.kicked = true
		pl:Kick('exploits (stringcmd)')
		if CNetChan and CNetChan(pl:EntIndex()) then
			CNetChan(pl:EntIndex()):Shutdown('exploits (stringcmd)')
		end

		timer.Create('delxploitrecord' .. pl:UserID(), 5, 1, function() t[s] = nil end)
		return true
	end

	stats = stats + #c
	t[s] = stats

end)

hook.Add('Tick',Tag,function()

	for k, stats in next, t do
		t[k] = 0
	end

end)