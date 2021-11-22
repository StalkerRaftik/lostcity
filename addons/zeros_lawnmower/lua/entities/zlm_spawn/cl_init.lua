include("shared.lua")


function ENT:Draw()
	//self:DrawModel()

	-- if zlm.f.InDistance(LocalPlayer():GetPos(), self:GetPos(), 1000) then
	-- 	self:DrawInfo()
	-- end
end

function ENT:DrawInfo()
	cam.Start3D2D(self:LocalToWorld(Vector(0,0,0)), self:LocalToWorldAngles(Angle(0,90,0)), 0.1)
		surface.SetDrawColor(zlm.default_colors["white01"])
		surface.SetMaterial(zlm.default_materials["spawn_indicator"])
		surface.DrawTexturedRect(-1000, -1000, 2000, 2000)
	cam.End3D2D()
end


function ENT:DrawTranslucent()
	self:Draw()
end
