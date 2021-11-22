FADE_DELAY = 0.3

surface.CreateFont( "HeaderFont3", {
	font = "Arial",
	size = 55,
	weight = 900
})

surface.CreateFont( "HeaderFont", {
	font = "Arial",
	size = 40,
	weight = 900
})

surface.CreateFont( "HeaderFont1", {
	font = "Arial",
	size = 25,
	weight = 900
})

surface.CreateFont( "HeaderFont2", {
	font = "Arial",
	size = 35,
	weight = 900
})

surface.CreateFont( "TextFont", {
	font = "Arial",
	size = 18,
	weight = 900
})

function surface.GetTextWidth(text, font)
	surface.SetFont(font)
	return surface.GetTextSize(text)
end

function surface.DrawShadowText(text, font, posX, posY, textColor, shadowColor, align, shadowOffsetX, shadowOffsetY)
 	draw.DrawText(text, font, posX + (shadowOffsetY or 1), posY + (shadowOffsetX or 1), shadowColor, align or TEXT_ALIGN_LEFT)
 	draw.DrawText(text, font, posX, posY, textColor, align)
end

function draw.DrawOutlinedRect(x, y, width, height, color)
	surface.SetDrawColor(color)
    surface.DrawOutlinedRect(x, y, width, height)
end

function draw.DrawRect(x, y, width, height, color)
	surface.SetDrawColor(color.r, color.g, color.b, color.a)
	surface.DrawRect(x, y, width, height)
end

function surface.DrawShadowText(text, font, posX, posY, textColor, shadowColor, align, shadowOffsetX, shadowOffsetY)
 	draw.DrawText(text, font, posX + (shadowOfsetX or 1), posY + (shadowOfsetY or 1), shadowColor, align or TEXT_ALIGN_LEFT)
 	draw.DrawText(text, font, posX, posY, textColor, align)
end

function draw.DrawLine(startX, startY, endX, endY, color)
	surface.SetDrawColor(color)
	surface.DrawLine(startX, startY, endX, endY)
end

function draw.DrawOutlinedRoundedRect(width, height, color, x, y)
	x = x or 0
	y = y or 0
	surface.SetDrawColor(color)
	surface.DrawLine(x + 1, y, x + width - 2, y)
	surface.DrawLine(x, y + 1, x, y + height - 2)
	surface.DrawLine(x + width - 1, y + 2, x + width - 1, y + height - 2)
	surface.DrawLine(x + 1, y + height - 1, x + width - 2, y + height -1)
end

function LerpColor(delta, from, to)
	return Color(Lerp(delta, from.r, to.r), Lerp(delta, from.g, to.g), Lerp(delta, from.b, to.b), Lerp(delta, from.a, to.a))
end

/*
	MProgressBar
*/
local PANEL = {}

AccessorFunc(PANEL, "Min", "Min")
AccessorFunc(PANEL, "Max", "Max")
AccessorFunc(PANEL, "Value", "Value")
AccessorFunc(PANEL, "OldValue", "OldValue")
AccessorFunc(PANEL, "Color", "Color")
AccessorFunc(PANEL, "Percentage", "Percentage")
AccessorFunc(PANEL, "Desc", "Desc")
AccessorFunc(PANEL, "Animated", "Animated")
AccessorFunc(PANEL, "DrawText", "DrawText")

function PANEL:Init()
	self:SetDrawText(true)
	self:SetSize(500, 32)
	self:SetMax(100)
	self:SetMin(0)
	self:SetValue(0)
	self:SetColor(Color(40, 40, 40, 210))
end

function PANEL:SetValue(value)
	if self:GetAnimated() then
		self:SetOldValue(self:GetValue() or value)
	else
		self:SetOldValue(value)
	end
	self.Value = value
end

function PANEL:Paint()
	draw.DrawOutlinedRoundedRect(self:GetWide(), self:GetTall(), Color(100, 100, 100, 50))
	draw.DrawRect(1, 1, self:GetWide()-2, self:GetTall()-2, Color(50,50,50,150))

	if self:GetAnimated() then
		self:SetOldValue(Lerp(0.1, self:GetOldValue(), self:GetValue()))
	end

	local width = math.min(math.Round(self:GetWide()*(self:GetOldValue()-self:GetMin())/(self:GetMax()-self:GetMin())), self:GetWide())
	local height = self:GetTall()

	draw.DrawOutlinedRoundedRect(width, height, Color(100, 100, 100, 255), 0, (self:GetTall() - height)/2)
	draw.DrawRect(1, (self:GetTall() - height)/2 + 1, width - 2, height - 2, self:GetColor())
	
	if self:GetDrawText() then
		local text
		if self:GetPercentage() then
			text = math.Round(((self:GetOldValue()-self:GetMin())/(self:GetMax()-self:GetMin())) * 100).."%"
		else
			text = self:GetOldValue().." кг. / "..self:GetMax() .. ' кг.'
		end
		local textWidth, textHeight = surface.GetTextWidth(text, "font_base_20")
	
		local pos
		if self:GetDesc() then
			pos = self:GetWide() - textWidth - 6
			surface.DrawShadowText(self:GetDesc(), "font_base_20", 6, (self:GetTall() - textHeight)/2, COLOR_WHITE, COLOR_BLACK, TEXT_ALIGN_LEFT)
		else
			pos = math.Clamp(width - textWidth - 6, 6, self:GetWide() - textWidth)
		end
		
		surface.DrawShadowText(text, "font_base_20", pos, (self:GetTall() - textHeight)/2, COLOR_WHITE, COLOR_BLACK, TEXT_ALIGN_LEFT)
	end
end
derma.DefineControl( "MProgressBar", "", PANEL)