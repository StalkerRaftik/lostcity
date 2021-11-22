include("shared.lua")

local nsize = 150

hook.Add("PostDrawOpaqueRenderables", "PostDrawClothesNPCTitle", function()
  for _, ent in pairs (ents.FindByClass("cm_clothing_display")) do
    if ent:GetPos():Distance(LocalPlayer():GetPos()) < 1000 then
      local PlyAng = LocalPlayer():EyeAngles()
      cam.Start3D2D(ent:GetPos()+ent:GetUp()*85-ent:GetRight()*2, Angle( 0, PlyAng.y-90, 90  ), 0.1)
        draw.ShadowSimpleText( 'Продавец одежды', "font_base_24", -31, 70, Color( 0, 150, 255, 255 ), TEXT_ALIGN_CENTER)
        draw.ShadowSimpleText( 'Здесь вы можете купить футболку или штаны', "font_base_18", -31, 90, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER)      
      cam.End3D2D()
    end
  end
end)