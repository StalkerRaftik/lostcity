include("shared.lua")

local nsize = 0
local ysize = 0

hook.Add("PostDrawOpaqueRenderables", "ClothName", function()
  for _, ent in pairs (ents.FindByClass("cm_cloth")) do
    if ent:GetPos():Distance(LocalPlayer():GetPos()) < 1000 then
      local PlyAng = LocalPlayer():EyeAngles()
      cam.Start3D2D(ent:GetPos()+ent:GetUp()*30-ent:GetRight()*0, Angle( 0, PlyAng.y-90, 90  ), 0.1)
        draw.ShadowSimpleText( 'Одежда', "font_base_24", 0, 70, Color( 0, 150, 255, 255 ), TEXT_ALIGN_CENTER)
        draw.ShadowSimpleText( ent:GetCName(), "font_base_24", 0, 90, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER)      
      cam.End3D2D()
    end
  end
end)

function ENT:Draw()
  self:DrawModel()
end
