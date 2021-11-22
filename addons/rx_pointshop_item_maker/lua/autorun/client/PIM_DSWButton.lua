local PANEL = {}
function PANEL:Init()
	self:SetText(" ")
	self.Status = "idle"
	self.Text = " "
	self.Font = "RXF_TrebOut_S20"
	self.BoarderWidth = 1
	self.BoarderCol = Color(255,255,255,255)
	self.TextCol = Color(255,255,255,255)
	self.Anim_Hover = 1
	self.Anim_Exit = 1
	self.Anim_Click = 1
	self.EventTime = nil
	self.HoverAnimTime = 0.3
	self.ClickSound = "ui/buttonclick.wav"
	self.AlignX = TEXT_ALIGN_CENTER
	self.AlignY = TEXT_ALIGN_CENTER
	
end

function PANEL:CursorEnter() end
function PANEL:CursorExit() end

function PANEL:OnCursorEntered()
	surface.PlaySound("buttons/lightswitch2.wav")
	self.EventTime = {Time=CurTime(),Mode="HoverPer"}
	self:CursorEnter()
end
function PANEL:OnCursorExited()
	self:CursorExit()
	local Time = CurTime() + self.HoverAnimTime
	if self.EventTime and self.EventTime.Time then
		if CurTime() - self.EventTime.Time < self.HoverAnimTime then
			Time = CurTime() + (CurTime() - self.EventTime.Time)
		end
	end
	self.EventTime = {Time=Time,Mode="HoverPer_Exit"}
end
function PANEL:DoClick()
	surface.PlaySound(self.ClickSound)
	self.ClickTime = CurTime()
	self.EventTime = {Time=CurTime(),Mode="Click"}
	self:Click()
	return
end
function PANEL:SetTextAlign(X,Y)
	if X then self.AlignX = X end
	if Y then self.AlignY = Y end
end
function PANEL:SetTexts(name)
	self.Text = name
end
function PANEL:SetBoarderWidth(int)
	self.BoarderWidth = int
end
function PANEL:SetBoarderColor(color)
	self.BoarderCol = color
end

function PANEL:SetHoverAnim(int)
	self.Anim_Hover = int
end
function PANEL:SetExitAnim(int)
	self.Anim_Exit = int
end
function PANEL:SetClickAnim(int)
	self.Anim_Click = int
end

function PANEL:PaintBackGround()
	-- override
end
function PANEL:PaintOverlay()
	-- override
end

function PANEL:Paint()
	surface.SetDrawColor( Color(0,0,0,200) )
	surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	self:PaintBackGround()

	draw.RoundedBox(2, 0, 0, self:GetWide(), self:GetTall(), self.BoarderCol)
	draw.RoundedBox(2, 1, 1, self:GetWide()-2, self:GetTall()-2, Color(50,50,50,255))

		if self.EventTime and self.EventTime.Time and self.EventTime.Mode then
			local Mode = self.EventTime.Mode
			if Mode == "HoverPer" then
				local Per = CurTime() - self.EventTime.Time
					local D = math.min(Per,self.HoverAnimTime)*4
					surface.SetDrawColor( Color(255,255,255,D*30) )
					surface.DrawRect( 1, 1, (self:GetWide()-2), self:GetTall()-2 )
			end
			if Mode == "HoverPer_Exit" then
				local Per = self.EventTime.Time - CurTime()
					local D = math.max(Per,0)*4
					surface.SetDrawColor( Color(255,255,255,D*30) )
					surface.DrawRect( 1, 1, (self:GetWide()-2), self:GetTall()-2 )
			end
			if Mode == "Click" then
				local Per = CurTime() - self.EventTime.Time
					local D = 1-math.min(Per*4,1)
					surface.SetDrawColor( Color(255,255,255,D*50) )
					surface.DrawRect( 1, 1, (self:GetWide()-2), self:GetTall()-2 )
			end
			
		end
		
		
		local DrawPosX = self:GetWide()/2
		local DrawPosY = self:GetTall()/2
		if self.AlignX == TEXT_ALIGN_LEFT then DrawPosX = 10 end
		if self.AlignX == TEXT_ALIGN_RIGHT then DrawPosX = self:GetWide()-10 end
		
		if self.AlignX == TEXT_ALIGN_TOP then DrawPosY = 1 end
		if self.AlignX == TEXT_ALIGN_BOTTOM then DrawPosY = self:GetTall()-1 end
		
		
		draw.SimpleText(self.Text, self.Font, DrawPosX,DrawPosY, self.TextCol, self.AlignX,self.AlignY)
		self:PaintOverlay()
end
function PANEL:Click()
	-- Override
end

vgui.Register("PIM_DSWButton",PANEL,"DButton")