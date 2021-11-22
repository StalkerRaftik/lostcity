include('shared.lua')

function ENT:Draw()
	self:DrawModel()
	
	local ang = self:GetAngles()
	
	ang:RotateAroundAxis( ang:Right(), -90)
	ang:RotateAroundAxis( ang:Up(), 90)
 
	cam.Start3D2D( self:GetPos() + ang:Up()*-15.18+ ang:Right()*-18.45, ang, 0.1 )
		-- draw.DrawText(self:GetText(), "font_base_24", 0, 0, Color(255,255,255,255), TEXT_ALIGN_CENTER)
	cam.End3D2D()
end

local function OpenDerma( data )


	local DefaultText = [[
	Разнообразный и богатый опыт новая модель организационной деятельности позволяет выполнять важные 
	задания по разработке новых предложений. Задача организации, в особенности же постоянное 
	информационно-пропагандистское обеспечение нашей деятельности играет важную роль в формировании 
	системы обучения кадров, соответствует насущным потребностям. Товарищи! постоянный количественный 
	рост и сфера нашей активности требуют от нас анализа дальнейших направлений развития. 
	Разнообразный и богатый опыт рамки и место обучения кадров в значительной степени обуславливает 
	создание направлений прогрессивного развития. С другой стороны сложившаяся структура 
	организации требуют определения и уточнения позиций, занимаемых участниками в отношении 
	поставленных задач. Равным образом новая модель организационной деятельности требуют от 
	нас анализа систем массового участия.]]

	local entSign = data:ReadEntity()
	local pPlayer = data:ReadEntity()

	//create main frame
	local Main = vgui.Create( "DFrame" )
	Main:SetSize( 600, 700 )
	Main:SetTitle( "Edit Text" )
	Main:ShowCloseButton(false)
	Main:SetTitle("")

	local width, height = Main:GetSize()

	local DescEntry = vgui.Create( "DTextEntry", Main )
	DescEntry:SetSize( 450, 635 ) 
	DescEntry:SetPos( Main:GetWide() / 2 - DescEntry:GetWide() / 2, 25 )
	DescEntry:SetText( entSign:GetText() )
	DescEntry:SetMultiline(true)
	DescEntry:SetFont("font_base")
	DescEntry.Paint = function( self, w, h )
		surface.SetDrawColor(247,225,211)
		surface.DrawRect(0, 0, self:GetWide(), self:GetTall())

		surface.SetDrawColor(35,35,35)
		surface.DrawLine(0, 0, self:GetWide(), 0)
		surface.DrawLine(0, 0, 0, self:GetTall())
		surface.DrawLine(0, self:GetTall()-1, self:GetWide(), self:GetTall()-1)
		surface.DrawLine(self:GetWide()-1, 0, self:GetWide()-1, self:GetTall())

		self:DrawTextEntryText(Color(0, 0, 0), Color(30, 130, 255), Color(0, 0, 0))
	end
	DescEntry.MaxChars = 10000
	DescEntry.OnTextChanged = function(self)
		local txt = self:GetValue()
		local amt = string.len(txt)
		if amt > self.MaxChars then
			self:SetText(self.OldText)
			self:SetValue(self.OldText)
		else
			self.OldText = txt
		end
		return txt
	end

	local RichText = vgui.Create( "RichText", Main )
	RichText:SetSize( 450, 635 ) 
	RichText:SetPos( Main:GetWide() / 2 - DescEntry:GetWide() / 2, 25 )
	RichText:SetText( entSign:GetText() ) -- Set the text of the label
	RichText:SetMultiline(true)
	RichText.Paint = function( self, w, h )
		surface.SetDrawColor(247,225,211)
		surface.DrawRect(0, 0, self:GetWide(), self:GetTall())

		surface.SetDrawColor(35,35,35)
		surface.DrawLine(0, 0, self:GetWide(), 0)
		surface.DrawLine(0, 0, 0, self:GetTall())
		surface.DrawLine(0, self:GetTall()-1, self:GetWide(), self:GetTall()-1)
		surface.DrawLine(self:GetWide()-1, 0, self:GetWide()-1, self:GetTall())

		self.m_FontName = "font_base_24"
    	self:SetFontInternal( "font_base_24" )	
    	self:SetFGColor(Color(0,0,0,255))		
    	-- self.Paint = nil

	end
	-- DLabel:SetDark( 1 ) -- Set the colour of the text inside the label to a darker one

	Main.Paint = function()
		-- draw.ShadowSimpleText("Owner by: "..entSign:GetOwningEntReason(),"font_base_24",DescEntry:GetWide()/6+1,0+1,Color(0,0,0,90))
		-- draw.ShadowSimpleText("Owner by: "..entSign:GetOwningEntReason(),"font_base_24",DescEntry:GetWide()/6,0,Color(255,255,255,200))
	end

	-- if entSign:GetOwningEntReason() != pPlayer:Name() then
	-- 	DescEntry:SetVisible(false)
		RichText:SetVisible(true)
	-- else
		DescEntry:SetVisible(true)
	-- 	RichText:SetVisible(false)
	-- end

	local ApplyButton = vgui.Create( "DButton", Main )
	ApplyButton:SetSize( 90, 50 )
	ApplyButton:SetPos( width/2 - 130/2 - 60, Main:GetTall() - ApplyButton:GetTall())
	ApplyButton:SetText( "Apply" )
	ApplyButton.DoClick = function()
		net.Start("TextChange")
			net.WriteEntity( entSign )
			net.WriteString( DescEntry:GetValue() )
		net.SendToServer()
		Main:Close()
	end
	ApplyButton:SetText("")
	ApplyButton.Paint = function( self, w, h ) 
		draw.ShadowSimpleText("Apply","font_base_24",w/2,h/2,Color(0,0,0,190), 1, 1)
		draw.ShadowSimpleText("Apply","font_base_24",w/2 - 1,h/2 - 1,Color(39,147,232,255), 1, 1)
	end

	local CloseButton = vgui.Create( "DButton", Main )
	CloseButton:SetSize( 90, 50 )
	CloseButton:SetPos( width/2 - 130/2 + 60, Main:GetTall() - CloseButton:GetTall())
	CloseButton:SetText( "CloseButton" )
	CloseButton.DoClick = function()
		Main:Close()
	end
	CloseButton:SetText("")
	CloseButton.Paint = function( self, w, h ) 
		draw.ShadowSimpleText("Close","font_base_24",w/2,h/2,Color(0,0,0,190), 1, 1)
		draw.ShadowSimpleText("Close","font_base_24",w/2 - 1,h/2 - 1,Color(255,65,0,255), 1, 1)
	end

	Main:SetVisible( true )
	Main:Center()
	Main:MakePopup()
end
usermessage.Hook( "OpenEditDerma", OpenDerma )
