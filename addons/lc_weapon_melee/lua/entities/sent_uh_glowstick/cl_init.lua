include('shared.lua')

function ENT:Draw()
	self:DrawModel()
	
	if self:GetOn() then
		local skin = self:GetSkin()
		
		if skin == 1 then
			col = Color(0,255,0)
		elseif skin == 3 then
			col = Color(255,0,0)
		elseif skin == 5 then
			col = Color(0,0,255)
		elseif skin == 7 then
			col = Color(255,255,0)
		else
			col = Color(255,0,255)
		end
		
		local dlight = DynamicLight( self:EntIndex() )
		if dlight then
			dlight.Pos = self:GetPos()
			dlight.r = col.r
			dlight.g = col.g
			dlight.b = col.b
			dlight.Brightness = 2
			dlight.Decay = 1000
			dlight.size = 256
			dlight.DieTime = CurTime() + 1
		end
	end
end