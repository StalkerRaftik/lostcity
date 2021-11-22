include("shared.lua")



local fade = 0


function ENT:Draw()
	self:DrawModel()
	local distance = LocalPlayer():GetPos():Distance(self:GetPos())

	if distance > 400 then return false end

	if distance > 400 then 
		fade = Lerp( FrameTime()*10, fade, 0 ) 
	else 
		fade = Lerp( FrameTime()*10, fade, 1 ) 
	end


	local color = self:GetColor()


	cam.Start3D2D(self:GetPos() + Vector(0,0,48), self:GetAngles() + Angle(0, 0, 0), 0.2  )
		draw.RoundedBox( 5, -118, -120, 242, 240, Color(30,30,30,200 * fade) )
		draw.ShadowSimpleText( "Склад", "ui.40", 0, -24, Color(200,200,200,255 * fade), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	cam.End3D2D()

end