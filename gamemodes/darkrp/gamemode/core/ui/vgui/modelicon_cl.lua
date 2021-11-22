
-----------------------------------------------------
local PANEL = {}

function PANEL:Init()
	self:SetModel(LocalPlayer():GetModel())
end

function PANEL:Paint(w, h)
	draw.Box(0, 0, w, h, ui.col.Background)
	if self:IsHovered() then
		draw.Box(1, 1, w - 2, h - 2, ui.col.Hover, ui.col.Outline)
	end
end

function PANEL:PaintOver(w, h)
	draw.Outline(0, 0, w, h, ui.col.Outline)
end

vgui.Register('rp_modelicon', PANEL, 'SpawnIcon')