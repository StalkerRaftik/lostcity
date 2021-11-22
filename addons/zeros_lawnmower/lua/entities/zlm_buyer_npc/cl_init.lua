include("shared.lua")

function ENT:Draw()
	self:DrawModel()

	-- if zlm.f.InDistance(LocalPlayer():GetPos(), self:GetPos(), 500) then
	-- 	self:DrawInfo()
	-- end
end

function ENT:DrawInfo()
	local Pos = self:GetPos() + self:GetUp() * 105
	Pos = Pos + self:GetUp() * math.abs(math.sin(CurTime()) * 1)
	local Ang = Angle(0, EyeAngles().y - 90, 90)
	cam.Start3D2D(Pos, Ang, 0.1)
		--draw.SimpleText(self:GetGrassCount() .. zlm.config.UoW, "zlm_grassbuyer_font02", 0, -125, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		draw.SimpleText(zlm.language.General["GrassBuyerTitle"], "zlm_grassbuyer_font01_shadow", 0, 27, zlm.default_colors["black01"], TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		draw.SimpleText(zlm.language.General["GrassBuyerTitle"], "zlm_grassbuyer_font01", 0, 27, zlm.default_colors["white01"], TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		draw.SimpleText("⇩", "zlm_grassbuyer_font02", 0, 200, zlm.default_colors["white01"], TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	cam.End3D2D()
end
