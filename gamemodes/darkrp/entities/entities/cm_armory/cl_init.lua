include("shared.lua")

function ENT:Draw()
	self:DrawModel()
	
	if not self.size then
		self.size = 0
		self.bsizec = false
	end
			
	local dist = LocalPlayer():GetPos():Distance(self:GetPos())
	
	if dist > 500 then return end
	
	local angle = self.Entity:GetAngles()	
	
	local position = self.Entity:GetPos() + angle:Forward() * 14.8 + angle:Up() * 25 + angle:Right() * 0
	
	angle:RotateAroundAxis(angle:Forward(), 90);
	angle:RotateAroundAxis(angle:Right(),-90);
	angle:RotateAroundAxis(angle:Up(), 0);
	
	local ang = LocalPlayer():GetAngles()
	
	cam.Start3D2D(position, angle, 0.2)
		
		local k = 0
		local encsize = 2
	
		draw.RoundedBox( 0, -100-encsize, -10-encsize + (k*25-30), encsize, 2+encsize*2, Color(255,255,255,255) )
		draw.RoundedBox( 0, 100, 10-encsize-2+ (k*25-30), encsize, 2+encsize*2, Color(255,255,255,255) )
		draw.RoundedBox( 0, -100-encsize, 10-encsize-2+ (k*25-30), encsize, 2+encsize*2, Color(255,255,255,255) )
		draw.RoundedBox( 0, 100, -10-encsize+ (k*25-30), encsize, 2+encsize*2, Color(255,255,255,255) )
		draw.RoundedBox( 0, -100, -10-encsize+ (k*25-30), 2+encsize, encsize, Color(255,255,255,255) )
		draw.RoundedBox( 0, 100-encsize-2, -10-encsize+ (k*25-30), 2+encsize, encsize, Color(255,255,255,255) )
		draw.RoundedBox( 0, 100-encsize-2, 10+ (k*25-30), 2+encsize, encsize, Color(255,255,255,255) )
		draw.RoundedBox( 0, -100, 10+ (k*25-30),  2+encsize, encsize, Color(255,255,255,255) )
		
		draw.RoundedBox( 0, -100, -10+ (k*25-30), 200, 20, Color(0,0,0,150) )
		
		draw.ShadowSimpleText("Гардероб", "font_base_24" ,0, (k*25-30), Color(255,255,255,255), 1, 1)
		
	cam.End3D2D()
end
