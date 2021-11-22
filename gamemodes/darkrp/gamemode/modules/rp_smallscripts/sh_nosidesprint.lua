hook.Add("SetupMove", "SprintLimiter", function(pl, mv, cmd)
	if pl:GetMoveType() ~= MOVETYPE_WALK then return end

	local speed = mv:GetForwardSpeed() ~= 0 and mv:GetSideSpeed() ~= 0 and math.sqrt(pl:GetMaxSpeed() ^ 2 / 2) or pl:GetMaxSpeed()
	local walkspeed = mv:GetForwardSpeed() ~= 0 and mv:GetSideSpeed() ~= 0 and math.sqrt(pl:GetWalkSpeed() ^ 2 / 2) or pl:GetWalkSpeed()
	local slowspeed = walkspeed * 0.8

	if mv:GetForwardSpeed() ~= 0 then
		if mv:GetForwardSpeed() > 0 then
			mv:SetForwardSpeed(speed)
		else
			mv:SetForwardSpeed(-slowspeed)
		end
	end
	if mv:GetSideSpeed() ~= 0 then
		mv:SetSideSpeed(mv:GetSideSpeed() / math.abs(mv:GetSideSpeed()) * slowspeed)
	end
end)