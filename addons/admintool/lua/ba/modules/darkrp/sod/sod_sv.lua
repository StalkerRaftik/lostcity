function PLAYER:IsSOD()
	return (self:Team() == TEAM_ADMIN)
end

hook.Add('PlayerShouldTakeDamage', 'SOD.PlayerShouldTakeDamage', function(pl, attacker)
	if pl:IsSOD() then
		return false
	end
end)

hook.Add('PlayerHasHunger', 'SOD.PlayerHasHunger', function(pl)
	if (pl:IsSOD()) then return false end
end)