nw.Register 'NLR'
	:Write(function(v)
		net.WriteUInt(v.Time, 32)
		net.WriteVector(v.Pos)
	end)
	:Read(function()
		return { 
			Time = net.ReadUInt(32),
			Pos = net.ReadVector()
		}
	end)
	:SetLocalPlayer()

function PLAYER:InNLRZone()
	if self:Alive() and self:GetNetVar('NLR') then
		return (self:GetNetVar('NLR').Pos:DistToSqr(self:GetPos()) < 122500)
	end
	return false
end

function PLAYER:GetNLRTime()
	if self:Alive() and self:GetNetVar('NLR') then
		return math.Round(self:GetNetVar('NLR').Time - CurTime(), 0)
	end
end