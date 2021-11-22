local PANEL = {}
	PANEL.CurPlanet = nil
	
function PANEL:Init()

	self.Demical = 0
	self.Max = 1
	self.Min = 0
	self.Name = ""
	
	self.LastValue = 0
end
function PANEL:SetName(name)
	self.Name = name
end

function PANEL:SetUp()

	self.Slider = vgui.Create( "DSlider", self)
	self.Slider:SetPos(10,20)
	self.Slider:SetSize(self:GetWide()-20,10)
	self.Slider.Knob:SetSize(15,8)
	self.Slider.Knob.Paint = function(slf)
		draw.RoundedBox(0, 0, 0, slf:GetWide(), slf:GetTall(), Color(0,255,255,255))
		draw.RoundedBox(0, 1, 1, slf:GetWide()-2, slf:GetTall()-2, Color(0,0,0,255))
	end
	

	self.Wang = vgui.Create( "DNumberWang", self )
	self.Wang:SetPos( self:GetWide()-70, 0 )
	if self.DisableWang then
		self.Wang:SetSize( 0,0)
	else
		self.Wang:SetSize( 60,20)
	end
	self.Wang:SetMax(self.Max or 10000)
	self.Wang:SetMin(self.Min or -10000)

	
	self.Wang.OnValueChanged = function(num,value)
		self:SetValue(value)
	end
	
end

function PANEL:SetValue(num)
	if tonumber(num) > self.Max then self:SetValue(self.Max) return end
	if tonumber(num) < self.Min then self:SetValue(self.Min) return end
	
	local Maxmin = self.Max - self.Min
	local Cal1 = (num-self.Min)/Maxmin

	if self.Slider then
		self.Slider:SetSlideX( Cal1 )
	end
	
	if self.LastValue != num then
		self:OnValueChanged( num )
		self.LastValue = num
	end
end

function PANEL:SetMax(num)
	self.Max = num
	if self.Wang then
		self.Wang:SetMax(num)
	end
end
function PANEL:SetMin(num)
	self.Min = num
	if self.Wang then
		self.Wang:SetMin(num)
	end
end


function PANEL:SetDemical(num)
	self.Demical = num
end

function PANEL:Think()
	if self.Wang then
		self.Wang:SetValue(self:GetValue())
	end
end

function PANEL:GetValue()
	local num = self.Slider.m_fSlideX * (self.Max - self.Min) + self.Min
	
	local num2 = math.Round(num* math.pow(10,self.Demical))
	local num3 = num2/ math.pow(10,self.Demical)
	
	return num3
end

function PANEL:Paint()
	draw.SimpleText(self.Name, "BudgetLabel", 10,15, Color(255,255,255,255), TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
	
	--Slider Line
	draw.RoundedBox(0, 10, 24, self:GetWide()-20, 1, Color(255,255,255,255))
	
	draw.SimpleText(self.Min, "BudgetLabel", 10,30, Color(255,255,255,255), TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
	draw.SimpleText(self.Max, "BudgetLabel", self:GetWide()-10,30, Color(255,255,255,255), TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
end

function PANEL:OnValueChanged( val )

	
	-- For override

end

vgui.Register("PIM_Sliders",PANEL,"Panel")