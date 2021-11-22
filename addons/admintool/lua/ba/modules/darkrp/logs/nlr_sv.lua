local nlr_players = {}

hook.Add('PlayerDeath', 'nlr.PlayerDeath', function(pl)
	if (pl:IsJailed()) then return end
	nlr_players[pl] = CurTime() + 180
	pl:SetNetVar('NLR', {Pos = pl:GetPos(), Time = CurTime() + 180})
end)

timer.Create('nlr_check', 1, 0, function()
	for pl, time in pairs(nlr_players) do
		if IsValid(pl) and (time > CurTime()) then
			if pl:InNLRZone() and (not pl.InNLR) then
				hook.Call('PlayerEnterNLRZone', nil, pl, time - CurTime())
				pl.InNLR = true
			elseif (not pl:InNLRZone()) and pl.InNLR then
				hook.Call('PlayerLeaveNLRZone', nil, pl, time - CurTime())
				pl.InNLR = nil
			end
		else
			nlr_players[pl] = nil
			pl:SetNetVar('NLR', nil)
		end
	end
end) 