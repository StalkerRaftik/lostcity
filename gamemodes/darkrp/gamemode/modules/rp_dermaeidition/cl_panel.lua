local PANEL = {}

function PANEL:Paint(c)
  surface.SetDrawColor(self:GetBackgroundColor())
  local x,y = self:GetPos()
  surface.DrawRect(x,y, self:GetWide(), self:GetTall())
end

vgui.Register("ZPanel",PANEL,"DPanel");
