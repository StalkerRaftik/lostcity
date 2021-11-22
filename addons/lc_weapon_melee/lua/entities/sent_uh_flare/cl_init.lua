include('shared.lua')

function ENT:Draw()
	self:DrawModel()
	
	if self:GetOn() then
		if (self.b_nextflare or 0) < CurTime() then
			self.b_nextflare = CurTime() + 0.1
			local fx = EffectData()
			fx:SetOrigin(self:GetPos() + self:GetUp()*10)
			fx:SetScale(2)
			util.Effect("uh_flare",fx)
		end
		
		local dlight = DynamicLight( self:EntIndex() )
		if dlight then
			dlight.Pos = self:GetPos() + self:GetUp()*8
			dlight.r = 200
			dlight.g = 25
			dlight.b = 0
			dlight.Brightness = 0.5
			dlight.Decay = 1000
			dlight.size = 256
			dlight.DieTime = CurTime() + 1
		end
	end
end