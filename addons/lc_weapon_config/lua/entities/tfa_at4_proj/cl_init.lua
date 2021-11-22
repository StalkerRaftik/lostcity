include("shared.lua")

function ENT:Draw()
	if CurTime() > self:GetNWFloat("HideTime", CurTime() + 1) then
		self:DrawModel()
	end
end

function ENT:IsTranslucent()
	return true
end