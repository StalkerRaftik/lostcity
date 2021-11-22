hook.Add("KeyPress", "AFKCheck", function(pl)
	pl.NotAFK = CurTime()
end)

hook.Add("PlayerSay", "AFKCheck", function(pl)
	pl.NotAFK = CurTime()
end)

function PLAYER:AFKTime()
	self.NotAFK = self.NotAFK or CurTime()
	
	return (CurTime() - self.NotAFK)
end

function PLAYER:IsAFK(threshhold)
	local threshhold = threshhold or (self:GetNetVar('Spectating') and 300 or 180)
	
	return self:AFKTime() >= threshhold
end