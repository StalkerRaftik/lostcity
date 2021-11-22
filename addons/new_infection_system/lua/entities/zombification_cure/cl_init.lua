include("shared.lua")

function ENT:Draw()
	self:DrawModel()
end

function ENT:OnRemove()
	if LocalPlayer() == self:GetNWEntity("User") then
		surface.PlaySound( "player/pl_wade1.wav" )
	end
end