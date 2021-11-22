include("shared.lua")

function ENT:Initialize()

end

function ENT:OnRemove()

end

function ENT:Draw()
	self:DrawModel()
end

function ENT:DrawTranslucent()
  self:DrawModel()
  local ply = LocalPlayer()
  
  local dist = self:GetPos():DistToSqr(ply:GetShootPos())
  if dist > 70000 then return end

  self.ScrAng = self:GetAngles()
  local fix_rotation = Vector(0, 90, 75)
  --self.ScrOff = self:GetUp() * 0 + self:GetForward()*0 + self:GetRight()*0
  local x, y = 0, 0
  local left = 0
  if self:GetCookStart() > 0 then
    left = math.Round(self:GetCookStart() - CurTime())
  end
  self.ScrAng:RotateAroundAxis(self.ScrAng:Right(), fix_rotation.x)
  self.ScrAng:RotateAroundAxis(self.ScrAng:Up(), fix_rotation.y)
  self.ScrAng:RotateAroundAxis(self.ScrAng:Forward(), fix_rotation.z)
  
  self.ScrPos = self:GetPos()
  self.ScrOff2 = (self:GetUp() * 47) + (self:GetRight()*18) + (self:GetForward()*-9.5)  
  cam.Start3D2D(self.ScrPos + self.ScrOff2, self.ScrAng, 0.05)
    surface.SetDrawColor(Color(20,20,20,255))
    surface.DrawRect(x,y-5,723,150)
    draw.ShadowSimpleText( "Плита", "font_base_big", 300, y, white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    draw.ShadowSimpleText( "Готовим: "..self:GetRecipe(), "font_base_big", 0, y+40, white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    draw.ShadowSimpleText( "Осталось: "..rplib.FormatTime(left), "font_base_big", 0, y+90, white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
  cam.End3D2D()
end