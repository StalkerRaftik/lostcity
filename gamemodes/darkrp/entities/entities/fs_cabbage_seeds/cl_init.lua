include("shared.lua");

surface.CreateFont("foodFont", {
	font = "Times New Roman",
	size = 34,
	weight = 800,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
});

surface.CreateFont("foodFontSmall", {
	font = "Times New Roman",
	size = 26,
	weight = 800,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
});

function ENT:Initialize()	

end;

function ENT:Draw()
	self:DrawModel();
	
	local pos = self:GetPos()
	local ang = self:GetAngles()
	local color = Color(191, 191, 191, 255);
	local agrColor = Color(191, 191, 191, 255);
	
	ang:RotateAroundAxis(ang:Up(), 90);
	ang:RotateAroundAxis(ang:Forward(), 90);	
	if LocalPlayer():GetPos():Distance(self:GetPos()) < FS_DrawDistance then
		cam.Start3D2D(pos + ang:Up(), Angle(0, LocalPlayer():EyeAngles().y-90, 90), 0.15);
				if (self:GetDTInt(1) == 0) then
					if self:GetDTBool(3) then
						draw.SimpleTextOutlined("Сажаю...!", "foodFontSmall", 0, -50, Color(200, 255, 200, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, Color(25, 25, 25, 100));
					else
						draw.SimpleTextOutlined("Я не могу посадить семена сюда.", "foodFontSmall", 0, -50, Color(255, 200, 200, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, Color(25, 25, 25, 100));					
					end;
				elseif (self:GetDTInt(1) == 1) then				
					draw.SimpleTextOutlined(string.ToMinutesSeconds(self:GetDTInt(2)), "foodFontSmall", 0, -50, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, Color(25, 25, 25, 100));
				elseif (self:GetDTInt(1) == 2) then				
					draw.SimpleTextOutlined(string.ToMinutesSeconds(self:GetDTInt(2)), "foodFontSmall", 0, -146, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, Color(25, 25, 25, 100));
				end;			
		cam.End3D2D();
	end;
end;