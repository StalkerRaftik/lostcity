for i=1, 100 do
surface.CreateFont( "Bariol"..i, {
  font = "Bariol Regular",
  extended = false,
  size = i,
  weight = 600,
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
} )
end
local nsize = 150
local CustomTop
local modelPanel
local Preview
local PreviewZ
local MFrame
local DPanelDrP
local top = Material("materials/Cosmetics/006-game.png")
local exitM = Material("materials/Cosmetics/exit.png")
local pay = Material("materials/Cosmetics/pay.png")
local edit = Material("materials/Cosmetics/edit.png")
local photo = Material("materials/Cosmetics/photo.png")
local ent

local blur = Material("pp/blurscreen")
local function DrawBlur( p, a, d )


	local x, y = p:LocalToScreen(0, 0)
	
	surface.SetDrawColor( 255, 255, 255 )
	
	surface.SetMaterial( blur )
	
	for i = 1, d do
	
	
		blur:SetFloat( "$blur", (i / d ) * ( a ) )
		
		blur:Recompute()
		
		render.UpdateScreenEffectTexture()
		
		surface.DrawTexturedRect( x * -1, y * -1, ScrW(), ScrH() )
		
		
	end
	
	
end

local function DrawBlurRect(x, y, w, h, amount, heavyness)
	surface.SetDrawColor(255, 255, 255, 255)
	surface.SetMaterial(blur)

	for i = 1, heavyness do
		blur:SetFloat("$blur", (i / 3) * (amount or 6))
		blur:Recompute()

		render.UpdateScreenEffectTexture()

		render.SetScissorRect(x, y, x + w, y + h, true)
			surface.DrawTexturedRect(0 * -1, 0 * -1, ScrW(), ScrH())
		render.SetScissorRect(0, 0, 0, 0, false)
	end
	
end

local function FixVertexLitMaterial(Mat)
		
	if not Mat then return Mat end
	local strImage = Mat:GetName()
	
	if ( string.find( Mat:GetShader(), "VertexLitGeneric" ) || string.find( Mat:GetShader(), "Cable" ) ) then
	
		local t = Mat:GetString( "$basetexture" )
		
		if ( t ) then
		
			local params = {}
			params[ "$basetexture" ] = t
			params[ "$vertexcolor" ] = 1
			params[ "$vertexalpha" ] = 1
			
			Mat = CreateMaterial( strImage .. "_hud_fx", "UnlitGeneric", params )
		
		end
		
	end
	
	return Mat
	
end	

local function OpenPreview(Panel)
	local x, y = Panel:GetSize()
	
	local texture = CustomTop.Texture
	local data = Cosmetics.Male.EditableTop[texture]
	
	local sizex = data.sizex*4 + 4
	local sizey = data.sizey*4 + 4
	
	Preview = vgui.Create( "DPanel",Panel )
	Preview:SetPos( ScrW()-sizex-20,y*0.7/2-sizey/2 )
	Preview:SetSize( sizex, sizey )
	Preview.Paint = function(pnl, w, h)
		draw.RoundedBox(0,0,0,w,2, Color(255,255,255,255))
		draw.RoundedBox(0,0,h-2,w,2, Color(255,255,255,255))
		draw.RoundedBox(0,0,0,2,h, Color(255,255,255,255))
		draw.RoundedBox(0,w-2,0,2,h, Color(255,255,255,255))
	end
	
	-- local mat = FixVertexLitMaterial(Material("models/humans/male/group01/players_sheet"))
	local mat = FixVertexLitMaterial(Material(texture))
	
	PreviewZ = vgui.Create( "DPanel",Preview )
	PreviewZ:SetPos( 2,2 )
	PreviewZ:SetSize( sizex-4, sizey-4)
	PreviewZ.Paint = function(pnl, w, h)
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetMaterial( mat )
		-- surface.DrawTexturedRectUV( 0, 0, 1024, 1024, 80, 390,100,391 )
		surface.DrawTexturedRect( -data.posx*4, -data.posy*4, 1024*2,1024*2 )
		-- surface.DrawTexturedRect( 0,0,w,h )
	end
	
	
end

local function CreateImageGUI( parent )
	
	if not IsValid( parent ) then return end
	
	local dhtml = vgui.Create("HTML", parent )
	dhtml:SetPos( 0,0 )
	dhtml:SetSize( 50,50 )

	dhtml.Link = "https://pbs.twimg.com/profile_images/2229650446/gmod-logo-big-noborder_400x400.png"
	dhtml.SizeX = 50
	dhtml.SizeY = 50

	dhtml:SetHTML( [[
	
    <html><head><style>body{
        background-attachment: fixed;
        background-image: url("]]..dhtml.Link..[[");
        background-repeat: repeat;
		background-size: 100% 100%;
        overflow: hidden;
    }</style></head><body></body></html>
	
	]] 	)
	
	local buttonImg = vgui.Create( "DButton", parent )
	buttonImg:SetText( "" )
	buttonImg:SetPos( dhtml:GetPos() )
	buttonImg:SetSize( dhtml:GetSize() )

	local X, Y = parent:GetSize()
		
	function buttonImg:OnMousePressed( key )
	
		if key != MOUSE_FIRST then return end
		
		self.Move = true
		
	end
	
	function buttonImg:OnMouseReleased( key )
			
		if key != MOUSE_FIRST then return end
		
		self.Move = false
		
		local ssizex, ssizey = self:GetSize()
		local posx, posy = self:GetPos()
		
		local x = math.Clamp(posx, 2, X-ssizex )
		local y = math.Clamp(posy, 2, Y-ssizey )
		
		self:SetPos(x,y)
		dhtml:SetPos(x,y)
		
		if IsValid( modelPanel ) then
			modelPanel:ActualizeC()
		end

	end
	
	function buttonImg:Think()
		
		if not self.Move then return end

		local ssizex, ssizey = self:GetSize()
		
		local xwc, ywc = parent:CursorPos()
	
		
		local x = math.Clamp(xwc-ssizex/2, 2, X-ssizex )
		local y = math.Clamp(ywc-ssizey/2, 2, Y-ssizey )
				
		self:SetPos(x,y)
		dhtml:SetPos(x,y)
		
	end
	
	function buttonImg:Paint()
	end
	
	buttonImg.pHTML = dhtml
	dhtml.button = buttonImg
	
	local valu = table.Count(CustomTop.Images)+1
		
	CustomTop.Images[valu] = dhtml
	
	if IsValid( modelPanel ) then
		modelPanel:ActualizeC()
	end
		
end

local nbimg = 0
local nbtxt = 0

local function OpenImage( Panel, Panel2 )
	
	local lastpos = 0
	
	local sizex, sizey = Panel:GetSize()
	
	local DPanel= vgui.Create("SRP_ScrollPanel", Panel)
	DPanel:SetPos(2,2)
	DPanel:SetSize(sizex-4,sizey-4)
	DPanel.Paint = function(pnl,w,h)
	end
	
	local sbar = DPanel:GetVBar()

	function sbar:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color(255, 255, 255,0) )
	end

	function sbar.btnUp:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color(0, 0, 0) )
	end
	
	function sbar.btnDown:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color(0, 0, 0) )
	end
	
	function sbar.btnGrip:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color(0, 0, 0,150) )
	end
	
	local button = vgui.Create("DButton", DPanel)
	button:SetPos(10,30)
	button:SetSize(100,30)
	button:SetText("")

	function button:DoClick()
		
		if nbimg + 1 > 5 then return end
		CreateImageGUI( PreviewZ )
		if IsValid(DPanel) then
			DPanel:Remove()
		end
		OpenImage( Panel, Panel2 )
	end
	
	button.Paint = function(pnl,w,h)
		local we = 2
		draw.RoundedBox(0,0,0,w,h, Color(0, 0, 0,150))
		draw.RoundedBox(0,0,0,w,we,Color(255,255,255,255))
		draw.RoundedBox(0,0,h-we,w,we,Color(255,255,255,255))
		draw.RoundedBox(0,0,0,we,h,Color(255,255,255,255))
		draw.RoundedBox(0,w-we,0,we,h,Color(255,255,255,255))
		draw.SimpleText( "> "..Cosmetics.Config.Sentences[1][Cosmetics.Config.Lang], "Bariol20",w/2-5,h/2,Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, 1 )
	end	
	
	local DLabel = vgui.Create( "DLabel", DPanel )
	surface.SetFont("Bariol25")
	local x, y = surface.GetTextSize(Cosmetics.Config.Sentences[2][Cosmetics.Config.Lang])
	DLabel:SetSize(x,y)
	DLabel:SetPos((sizex-4)/2-x/2,y+10)
	DLabel:SetFont("Bariol25")
	DLabel:SetText(Cosmetics.Config.Sentences[1][Cosmetics.Config.Lang])
	DLabel:SetTextColor(Color(255,255,255))
	
	sizex=sizex+160
	
	local nb = 1
	
	local previewX, previewY = PreviewZ:GetSize()
	
	nbimg = 0
	for k, v in pairs(  CustomTop.Images ) do
		
		if not IsValid( v ) then continue end
		nbimg = nbimg+1
		local link = v.Link or ""
		local sizeX = v.SizeX or 0
		local sizeY = v.SizeY or 0
						
		local panelM1 = vgui.Create("DPanel", DPanel)
		panelM1:SetPos(10, 100+( 125 ) * (nb-1))
		panelM1:SetSize(sizex-160-20-20, 110 )
		panelM1.Paint = function(pnl,w,h) 
			local we = 2
			draw.RoundedBox(0,0,0,w,h, Color(0, 0, 0,150))
			draw.SimpleText( Cosmetics.Config.Sentences[3][Cosmetics.Config.Lang].." "..k, "Bariol25",w/2,15,Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, 1 )
			draw.SimpleText( " x ", "Bariol25",w/2,75,Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, 0 )
			
		end
		
		local X, Y = panelM1:GetSize()
				
		local text = vgui.Create( "DTextEntry", panelM1 )
		text:SetPos( 10, 40 )
		text:SetSize( X-20, 25 )
		text:SetText( link )
		
		local previewX, previewY = PreviewZ:GetSize()
		
		text.OnTextChanged = function()
		
			v.Link = text:GetValue()
			v:SetHTML( [[
	
			<html><head><style>body{
				background-attachment: fixed;
				background-image: url("]]..v.Link..[[");
				background-repeat: repeat;
				background-size: 100% 100%;
				overflow: hidden;
			}</style></head><body></body></html>
			
			]] 	)
			
			if IsValid( modelPanel ) then
				modelPanel:ActualizeC()
			end
			
		end
		
		local size1 = vgui.Create( "DTextEntry", panelM1 )
		size1:SetPos( X/2-60, 75 )
		size1:SetSize( 40, 25 )
		size1:SetText( sizeX )
		size1:SetNumeric( true )
				
		size1.OnTextChanged = function()
			
			if tonumber(size1:GetValue()) == nil or size1:GetValue() == 0 then
				size1:SetText( 1 )
				return
			end
			
			local posx, posy = v:GetPos()
			
			if posx+tonumber(size1:GetValue()) > previewX then
				size1:SetText( v.SizeX )
				return
			end
			
			v.SizeX = tonumber(size1:GetValue())
			v:SetSize( v.SizeX, v.SizeY )
			v.button:SetSize( v:GetSize() )
			
			if IsValid( modelPanel ) then
				modelPanel:ActualizeC()
			end
			
		end
		
		local size2 = vgui.Create( "DTextEntry", panelM1 )
		size2:SetPos( X/2+20, 75 )
		size2:SetSize( 40, 25 )
		size2:SetText( sizeY )
		size2:SetNumeric( true )
				
		size2.OnTextChanged = function()
		
			if tonumber(size2:GetValue()) == nil or size2:GetValue() == 0 then
				size2:SetText( 1 )
				return
			end
			
			local posx, posy = v:GetPos()
			
			if posy+tonumber(size2:GetValue()) > previewY then
				size2:SetText( v.SizeY )
				return
			end
			
			v.SizeY = tonumber(size2:GetValue())
			v:SetSize( v.SizeX, v.SizeY )
			v.button:SetSize( v:GetSize() )
			
			if IsValid( modelPanel ) then
				modelPanel:ActualizeC()
			end
			
		end

		local button = vgui.Create("DButton", panelM1)		
		button:SetPos(X-110,Y-40)
		button:SetSize(100,30)
		button:SetText("")

		function button:DoClick()
			v:Remove()
			CustomTop.Images[k]=nil
			if IsValid(DPanel) then
				DPanel:Remove()
			end
			OpenImage( Panel, Panel2 )
			
			if IsValid( modelPanel ) then
				modelPanel:ActualizeC()
			end
		end
		
		button.Paint = function(pnl,w,h)
			local we = 2
			draw.RoundedBox(0,0,0,w,h, Color(0, 0, 0,150))
			draw.RoundedBox(0,0,0,w,we,Color(255,255,255,255))
			draw.RoundedBox(0,0,h-we,w,we,Color(255,255,255,255))
			draw.RoundedBox(0,0,0,we,h,Color(255,255,255,255))
			draw.RoundedBox(0,w-we,0,we,h,Color(255,255,255,255))
			draw.SimpleText( "> "..Cosmetics.Config.Sentences[4][Cosmetics.Config.Lang], "Bariol20",w/2-5,h/2,Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, 1 )
		end	
		
		nb = nb+1
	end
	
end

local function CreateTextGUI( parent )
	
	local buttonText = vgui.Create( "DButton", parent )
	buttonText:SetText( "" )
	buttonText:SetPos( 12, 12 )
	
	buttonText.Text = "Text"
	buttonText.Color = Color(255,255,255)
	buttonText.FontSize = 17
	
	local X, Y = parent:GetSize()
	surface.SetFont("Bariol"..buttonText.FontSize)
	local tsx, tsy = surface.GetTextSize(buttonText.Text)
	
	buttonText:SetSize( tsx, tsy )
	
	function buttonText:OnMousePressed( key )
	
		if key != MOUSE_FIRST then return end
		
		self.Move = true
			
	end
	
	function buttonText:OnMouseReleased( key )
	
		if key != MOUSE_FIRST then return end
		
		self.Move = false
		
		local ssizex, ssizey = self:GetSize()
		local posx, posy = self:GetPos()
		
		local x = math.Clamp(posx, 2, X-ssizex )
		local y = math.Clamp(posy, 2, Y-ssizey )
		
		self:SetPos(x,y)
		if IsValid( modelPanel ) then
			modelPanel:ActualizeC()
		end

	end
	
	function buttonText:Paint(w,h)
	
		draw.SimpleText( self.Text, "Bariol"..buttonText.FontSize, 0,0, self.Color )
		
		if not self.Move then return end

		local ssizex, ssizey = self:GetSize()
		
		local xwc, ywc = parent:CursorPos()
	
		
		local x = math.Clamp(xwc-ssizex/2, 2, X-ssizex )
		local y = math.Clamp(ywc-ssizey/2, 2, Y-ssizey )
				
		self:SetPos(x,y)
		
	end
	
	local valu = table.Count(CustomTop.Texts)+1
		
	CustomTop.Texts[valu] = buttonText
	
	if IsValid( modelPanel ) then
		modelPanel:ActualizeC()
	end
end

local function OpenText( Panel, Panel2 )
	
	local lastpos = 0
	
	local sizex, sizey = Panel:GetSize()
	
	local DPanel= vgui.Create("SRP_ScrollPanel", Panel)
	DPanel:SetPos(2,2)
	DPanel:SetSize(sizex-4,sizey-4)
	DPanel.Paint = function(pnl,w,h)
	end
	
	local sbar = DPanel:GetVBar()

	function sbar:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color(255, 255, 255,0) )
	end

	function sbar.btnUp:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color(0, 0, 0) )
	end
	
	function sbar.btnDown:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color(0, 0, 0) )
	end
	
	function sbar.btnGrip:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color(0, 0, 0,150) )
	end
	
	local button = vgui.Create("DButton", DPanel)
	button:SetPos(10,30)
	button:SetSize(100,30)
	button:SetText("")

	function button:DoClick()
		
		if nbtxt + 1 > 10 then return end
		
		CreateTextGUI( PreviewZ )
		if IsValid(DPanel) then
			DPanel:Remove()
		end
		OpenText( Panel, Panel2 )
	end
	
	button.Paint = function(pnl,w,h)
		local we = 2
		draw.RoundedBox(0,0,0,w,h, Color(0, 0, 0,150))
		draw.RoundedBox(0,0,0,w,we,Color(255,255,255,255))
		draw.RoundedBox(0,0,h-we,w,we,Color(255,255,255,255))
		draw.RoundedBox(0,0,0,we,h,Color(255,255,255,255))
		draw.RoundedBox(0,w-we,0,we,h,Color(255,255,255,255))
		draw.SimpleText( "> "..Cosmetics.Config.Sentences[1][Cosmetics.Config.Lang], "Bariol20",w/2-5,h/2,Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, 1 )
	end	
	
	local DLabel = vgui.Create( "DLabel", DPanel )
	surface.SetFont("Bariol25")
	local x, y = surface.GetTextSize(Cosmetics.Config.Sentences[5][Cosmetics.Config.Lang])
	DLabel:SetSize(x,y)
	DLabel:SetPos((sizex-4)/2-x/2,y+10)
	DLabel:SetFont("Bariol25")
	DLabel:SetText(Cosmetics.Config.Sentences[5][Cosmetics.Config.Lang])
	DLabel:SetTextColor(Color(255,255,255))
	
	sizex=sizex+160
	
	local nb = 1
	
	nbtxt = 0
	
	for k, v in pairs(  CustomTop.Texts ) do
		
		if not IsValid( v ) then continue end
		
		nbtxt = nbtxt + 1
		
		local txt = v.Text or ""
		local fontsize = v.FontSize or 17
		local color = v.Color or Color(255,255,255)
		local outline = v.Outline or false
						
		local panelM1 = vgui.Create("DPanel", DPanel)
		panelM1:SetPos(10, 100+( 40+25+10+25+10+250 + 20 ) * (nb-1))
		panelM1:SetSize(sizex-160-20-20, ( 40+25+10+25+10+250))
		panelM1.Paint = function(pnl,w,h) 
			local we = 2
			draw.RoundedBox(0,0,0,w,h, Color(0, 0, 0,150))
			draw.SimpleText( Cosmetics.Config.Sentences[6][Cosmetics.Config.Lang].." "..k, "Bariol25",w/2,15,Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, 1 )
			-- draw.RoundedBox(0,0,0,w,we,Color(255,255,255,255))
			-- draw.RoundedBox(0,0,h-we,w,we,Color(255,255,255,255))
			-- draw.RoundedBox(0,0,0,we,h,Color(255,255,255,255))
			-- draw.RoundedBox(0,w-we,0,we,h,Color(255,255,255,255))
		end
				
		local text = vgui.Create( "DTextEntry", panelM1 )
		text:SetPos( 10, 40 )
		text:SetSize( sizex-160-20-20-40, 25 )
		text:SetText( txt )
		
		local previewX, previewY = PreviewZ:GetSize()
		
		text.OnTextChanged = function()
			surface.SetFont("Bariol"..v.FontSize)
			local x, y = surface.GetTextSize(text:GetValue())
			
			local posx, posy = v:GetPos()
			
			if x+posx > previewX then
				text:SetText(v.Text)
				return
			elseif y+posy > previewY then
				text:SetText(v.Text)
				return
			end
			
			v.Text = text:GetValue()			
			v:SetSize(x,y)
			
			if IsValid( modelPanel ) then
				modelPanel:ActualizeC()
			end
		end
		
		local DermaNumSlider = vgui.Create( "DNumSlider", panelM1 )
		DermaNumSlider:SetPos(-sizex/2+80, 40+25+10 )
		DermaNumSlider:SetSize( sizex+50, 25  )
		DermaNumSlider:SetMin( 10 )
		DermaNumSlider:SetMax( 100 )
		DermaNumSlider:SetDecimals( 0 )
		DermaNumSlider:SetValue( fontsize )
		DermaNumSlider:SetDark( false )
		
		DermaNumSlider.OnValueChanged = function( val )
			
			local value = math.Round(DermaNumSlider:GetValue())
			
			surface.SetFont("Bariol"..value)
			local x, y = surface.GetTextSize(v.Text)
			
			local posx, posy = v:GetPos()
			
			if x+posx > previewX then
				DermaNumSlider:SetValue(v.FontSize)
				return
			elseif y+posy > previewY then
				DermaNumSlider:SetValue(v.FontSize)
				return
			end
			
			v.FontSize = value
			v:SetSize(x,y)
			if IsValid( modelPanel ) then
				modelPanel:ActualizeC()
			end
			
		end
				
		local Mixer = vgui.Create( "DColorMixer", panelM1 )
		Mixer:SetPos(20, 40+25+10+25+10)
		Mixer:SetPalette( true )
		Mixer:SetAlphaBar( true )
		Mixer:SetWangs( true )
		Mixer:SetColor( color )
		
		Mixer.ValueChanged = function()
			CustomTop.Texts[k].Color = Mixer:GetColor()
			if IsValid( modelPanel ) then
				modelPanel:ActualizeC()
			end
		end
		
		local button = vgui.Create("DButton", panelM1)
		
		local X, Y = panelM1:GetSize()
		
		button:SetPos(X-110,Y-40)
		button:SetSize(100,30)
		button:SetText("")

		function button:DoClick()
			v:Remove()
			CustomTop.Texts[k]=nil
			if IsValid(DPanel) then
				DPanel:Remove()
			end
			OpenText( Panel, Panel2 )
			
			if IsValid( modelPanel ) then
				modelPanel:ActualizeC()
			end
		end
		
		button.Paint = function(pnl,w,h)
			local we = 2
			draw.RoundedBox(0,0,0,w,h, Color(0, 0, 0,150))
			draw.RoundedBox(0,0,0,w,we,Color(255,255,255,255))
			draw.RoundedBox(0,0,h-we,w,we,Color(255,255,255,255))
			draw.RoundedBox(0,0,0,we,h,Color(255,255,255,255))
			draw.RoundedBox(0,w-we,0,we,h,Color(255,255,255,255))
			draw.SimpleText( "> "..Cosmetics.Config.Sentences[4][Cosmetics.Config.Lang], "Bariol20",w/2-5,h/2,Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, 1 )
		end	
		nb = nb +1
		
	end
	
end

local function OpenTee(Panel, Panel2)
	local DPanel = vgui.Create( "SRP_ScrollPanel", Panel )

	local w, h = Panel:GetSize()
	local mod = math.floor((w-5)/90)
	local w2 = mod*90
	
	DPanel:SetSize( w-4, h-4 )
	DPanel:SetPos( 2,2 )
	DPanel.Paint = function()
		draw.SimpleText( Cosmetics.Config.Sentences[7][Cosmetics.Config.Lang], "Bariol25",w/2,30,Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
	end
	
	local DPanel2 = vgui.Create( "SRP_ScrollPanel", DPanel )

	DPanel2:SetSize( 5+w2, h-100 )
	DPanel2:SetPos( (w-w2-5)/2,80 )
	DPanel2.Paint = function()
		draw.RoundedBox(0,0,0,w,h, Color(0,0,0,100))
	end
	
	local sbar = DPanel2:GetVBar()

	function sbar:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color(255, 255, 255,0) )
	end

	function sbar.btnUp:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color(0, 0, 0) )
	end
	
	function sbar.btnDown:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color(0, 0, 0) )
	end
	
	function sbar.btnGrip:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color(0, 0, 0,150) )
	end
	
	local list = {}
	local infos = LocalPlayer():CM_GetInfos()
	
	if infos.sex == 1 then
		list = Cosmetics.Male.EditableTop
	else
		list = Cosmetics.Female.EditableTop
	end
	
	local nb = 0	
	local line = -1
	
	for tee, tables in pairs ( list ) do
					
		local nbl = math.mod( nb, mod )

		if nbl == 0 then
			line = line + 1
			nb = 0
		end
		
		local DPanel3 = vgui.Create( "DButton", DPanel2 )
		DPanel3:SetSize( 40+45, 40+45 )
		DPanel3:SetPos( 5 + 90*nb, 5+95* line )
		DPanel3:SetText("")
		DPanel3.Paint = function(p, w, h)
		end
		
		-- local DmodelPanel = vgui.Create( "DModelPanel", DPanel3 )
		-- DmodelPanel:SetSize( 85, 85 )
		-- DmodelPanel:SetPos( 0, 0 )
		-- function DmodelPanel:LayoutEntity( Entity ) return end
		-- DmodelPanel:SetModel( infos.model )

		-- local startpos = DmodelPanel.Entity:GetBonePosition( DmodelPanel.Entity:LookupBone( "ValveBiped.Bip01_Spine2" ) or 0)
		-- DmodelPanel:SetLookAt( startpos )
		-- DmodelPanel:SetCamPos( startpos - Vector( -25,0,0) )

		-- local datas 
		-- if infos.sex == 1 then
			-- datas = Cosmetics.Male.ListDefaultPM[infos.model]
		-- else
			-- datas = Cosmetics.Female.ListDefaultPM[infos.model]
		-- end
		
		-- local ent = DmodelPanel.Entity
	
		-- local texture = tee
		-- local bodygroupname = tables.bodygroup
		
		-- local bodygroups = {
			-- datas.bodygroupstop[bodygroupname].group
			-- }
		
		-- local group = datas.bodygroupstop[bodygroupname].tee
		
		-- for k,v in pairs( bodygroups ) do
			-- modelPanel.Entity:SetBodygroup(v[1],v[2])
		-- end
		-- for k,v in pairs( group ) do
			-- modelPanel.Entity:SetSubMaterial(v, texture)
		-- end
		
		-- function ent:GetPlayerColor() return Vector( 1,1,1 )
		-- end
		
		local dmodelPanel = vgui.Create( "DModelPanel", DPanel3 )
	
		dmodelPanel:SetSize( 85,85 )
		dmodelPanel:SetPos( 0,0 )
		
		
		function dmodelPanel:LayoutEntity( Entity ) return end
		dmodelPanel:SetModel( infos.model )
		local startpos = dmodelPanel.Entity:GetBonePosition( dmodelPanel.Entity:LookupBone( "ValveBiped.Bip01_Pelvis" ) or 0 )
		
		dmodelPanel.pos = startpos
		dmodelPanel.el = Vector(-40,-10,-0)

		local startpos = dmodelPanel.Entity:GetBonePosition( dmodelPanel.Entity:LookupBone( "ValveBiped.Bip01_Spine2" ) or 0)
		dmodelPanel:SetLookAt( startpos )
		dmodelPanel:SetCamPos( startpos - Vector( -25,0,0) )
		
		dmodelPanel.Actualize = function()
			local infos = LocalPlayer():CM_GetInfos()
			local datas 
			if infos.sex == 1 then
				datas = Cosmetics.Male
			else
				datas = Cosmetics.Female
			end
			
			local texture = tee
			local bodygroupname = datas.EditableTop[texture].bodygroup
			
			local bodygroups = {
				datas.ListDefaultPM[LocalPlayer():CM_GetInfos().model].bodygroupstop[bodygroupname].group
				}
			
			local group = datas.ListDefaultPM[LocalPlayer():CM_GetInfos().model].bodygroupstop[bodygroupname].tee
			
			for k,v in pairs( bodygroups ) do
				dmodelPanel.Entity:SetBodygroup(v[1],v[2])
			end
			for k,v in pairs( group ) do
				dmodelPanel.Entity:SetSubMaterial(v, texture)
			end
		end
		
		dmodelPanel:Actualize()
		
		function dmodelPanel.Entity:GetPlayerColor()return Vector( 1,1,1 )
		end
		
		local DButton3 = vgui.Create( "DButton", DPanel3 )
		DButton3:SetSize( 40+45, 40+45 )
		DButton3:SetPos( 0,0 )
		DButton3:SetText("")
		DButton3.Paint = function(p, w, h)
			draw.RoundedBox(0,0,0,w,h, Color(0,0,0,150))
			local m = 1
			if infos.model != head or infos.skin != ind then
				m = 0
			end
			
			draw.RoundedBox(0,0,0,w,2, Color(255,255,255,255 * m))
			draw.RoundedBox(0,0,h-2,w,2, Color(255,255,255,255 * m))
			draw.RoundedBox(0,0,0,2,h, Color(255,255,255,255  * m))
			draw.RoundedBox(0,w-2,0,2,h, Color(255,255,255,255 * m))
		end
		DButton3.DoClick = function( pnl )

			CustomTop.Texture = tee
			CustomTop.Texts = {}
			CustomTop.Images = {}
	
			modelPanel.Actualize()
			Preview:Remove()
			OpenPreview(Panel2)
			
		end
		
		nb = nb + 1
		
	end
end

local function ToData( tab )
	
	local data = {}
	data.baseTexture = tab.Texture
	data.sex = LocalPlayer():CM_GetInfos().sex
	data.name = tab.name
	data.price = tab.price
	data.customThings = {}
	data.customThings.Texts = {}
	data.customThings.Images = {}
	
	for k,v in pairs( tab.Texts ) do
		
		local posx, posy = v:GetPos()
		local text = v.Text
		local color = v.Color
		local textsize = v.FontSize
		
		data.customThings.Texts[#data.customThings.Texts+1] = {
			posx = posx-2,
			posy = posy-2,
			text = text,
			color = color,
			textsize = textsize
		}
		
	end
	
	for k,v in pairs( tab.Images ) do
		
		local posx, posy = v:GetPos()
		local sizex, sizey = v:GetSize()
		local link = v.Link

		
		data.customThings.Images[#data.customThings.Images+1] = {
			posx = posx,
			posy = posy,
			sizex = sizex,
			sizey = sizey,
			link = link,
			alpha = 255
		}
		
	end
	
	return data or {}
	
end

local function OpenPay( Panel, Panel2 )
	
	local lastpos = 0
	
	local sizex, sizey = Panel:GetSize()
	
	local err = ""
	
	local DPanel= vgui.Create("SRP_ScrollPanel", Panel)
	DPanel:SetPos(2,2)
	DPanel:SetSize(sizex-4,sizey-4)
	DPanel.Paint = function(pnl,w,h)
		draw.SimpleText(Cosmetics.Config.Sentences[8][Cosmetics.Config.Lang], "Bariol25",w/2,30,Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
		draw.SimpleText( Cosmetics.Config.Sentences[9][Cosmetics.Config.Lang], "Bariol20",w/2,60,Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
		if err != "" then
			draw.SimpleText( Cosmetics.Config.Sentences[10][Cosmetics.Config.Lang].." : "..err, "Bariol20",w/2,110+10+30+40,Color( 255, 0, 0, 255 ), TEXT_ALIGN_CENTER )
		end
	end
	
	local text = vgui.Create( "DTextEntry", Panel )
	text:SetPos( (sizex-4)/2-75, 85 )
	text:SetSize( 150, 25 )
	
	CustomTop.name = "Name"
	
	text:SetText( CustomTop.name )
	
	text.OnTextChanged = function()
	
		CustomTop.name = text:GetValue()
		
	end
	
	local text2 = vgui.Create( "DTextEntry", Panel )
	text2:SetPos( (sizex-4)/2-75, 85+30 )
	text2:SetSize( 150, 25 )
	
	CustomTop.price = 100
	
	text2:SetText( CustomTop.price )
	
	text2.OnTextChanged = function()
	
		CustomTop.price = tonumber(text2:GetValue())
		
	end
	
	
	
	local sbar = DPanel:GetVBar()

	function sbar:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color(255, 255, 255,0) )
	end

	function sbar.btnUp:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color(0, 0, 0) )
	end
	
	function sbar.btnDown:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color(0, 0, 0) )
	end
	
	function sbar.btnGrip:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color(0, 0, 0,150) )
	end
	
	local button = vgui.Create("DButton", DPanel)
	button:SetPos((sizex-4)/2-100/2,110+40)
	button:SetSize(100,30)
	button:SetText("")

	function button:DoClick()
		
		if nbtxt <= 0 and nbimg <= 0 then
			err = Cosmetics.Config.Sentences[11][Cosmetics.Config.Lang]
			return
		end
		
		for k, v in pairs( Cosmetics.ShopTextures ) do
			if v.name and v.name == CustomTop.name then
				err = Cosmetics.Config.Sentences[12][Cosmetics.Config.Lang]
				return
			end
		end
		
		MFrame:Remove()
		net.Start("Cosmetics:CustomTeeCreationShop")
			net.WriteTable( ToData( CustomTop ) )
		net.SendToServer()
	end
	
	button.Paint = function(pnl,w,h)
		local we = 2
		draw.RoundedBox(0,0,0,w,h, Color(0, 0, 0,150))
		draw.RoundedBox(0,0,0,w,we,Color(255,255,255,255))
		draw.RoundedBox(0,0,h-we,w,we,Color(255,255,255,255))
		draw.RoundedBox(0,0,0,we,h,Color(255,255,255,255))
		draw.RoundedBox(0,w-we,0,we,h,Color(255,255,255,255))
		draw.SimpleText( "> ".. Cosmetics.Config.Sentences[13][Cosmetics.Config.Lang], "Bariol20",w/2-5,h/2,Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, 1 )
	end	
end

local function OpenEdit(Panel)
	
	local sizex, sizey = Panel:GetSize()
	local panelx, panely = sizex*0.4,392
	local pnOpen = 1
	
	local DPanelMenu = vgui.Create( "DPanel",Panel )
	DPanelMenu:SetPos( 10, (sizey*0.7-panely)/2 )
	DPanelMenu:SetSize( 80, panely )
	
	DPanelMenu.Paint = function(pnl, w, h)
		
		local we = 2
		draw.RoundedBox(0,0,0,w,h, Color(0, 0, 0,200))
		draw.RoundedBox(0,0,0,w,we,Color(255,255,255,255))
		draw.RoundedBox(0,0,h-we,w,we,Color(255,255,255,255))
		draw.RoundedBox(0,0,0,we,h,Color(255,255,255,255))
		draw.RoundedBox(0,w-we,0,we,h,Color(255,255,255,255))
	
	end
	
	-- local DPanelMenu = vgui.Create( "SRP_ScrollPanel",DPanelMen )
	-- DPanelMenu:SetPos( 2, 2 )
	-- DPanelMenu:SetSize( 80-4, panely-4 )
	
	-- DPanelMenu.Paint = function(pnl, w, h)	
	-- end
	
	local DPanelMenuC = vgui.Create( "DPanel",Panel )
	DPanelMenuC:SetPos( 10+78, (sizey*0.7-panely)/2 )
	DPanelMenuC:SetSize( panelx - 80, panely )
	
	DPanelMenuC.Paint = function(pnl, w, h)
		
		local we = 2
		draw.RoundedBox(0,0,0,w,h, Color(0, 0, 0,200))
		draw.RoundedBox(0,0,0,w,we,Color(255,255,255,255))
		draw.RoundedBox(0,0,h-we,w,we,Color(255,255,255,255))
		draw.RoundedBox(0,0,0,we,h,Color(255,255,255,255))
		draw.RoundedBox(0,w-we,0,we,h,Color(255,255,255,255))
		
	end
	
	local DButton1 = vgui.Create( "DButton", DPanelMenu)
	DButton1:SetSize( 80,80 )
	DButton1:SetPos(0,0 )
	DButton1:SetText( "" )	
	DButton1.Paint = function(pnl, w, h )
	
		local m = 1
		if pnOpen == 1 then
			m = 2
		end
		
		draw.RoundedBox( 0, 0,0,w,h, Color(0,0,0,100 * m))
		draw.RoundedBox(0,0,0,w,2, Color(255,255,255,255))
		draw.RoundedBox(0,0,h-2,w,2, Color(255,255,255,255))
		draw.RoundedBox(0,0,0,2,h, Color(255,255,255,255 ))
		draw.RoundedBox(0,w-2,0,2,h, Color(255,255,255,255))
		
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetMaterial( top )
		surface.DrawTexturedRect( 2 + (w-4)/2 - 64/2, 2 + (h-4)/2 - 64/2, 64,64 )
			
	end
	
	DButton1.DoClick = function( pnl )
		if pnOpen == 1 then return end
		pnOpen = 1
		DPanelMenuC:SizeTo(0, panely, 0.5, 0, -1, function()
			for k, v in pairs( DPanelMenuC:GetChildren() ) do
				v:Remove()
			end
			DPanelMenuC:SizeTo(panelx-80, panely, 0.5, 0, -1, function()
				OpenTee(DPanelMenuC, Panel)
			end)
		end)
	end
	OpenTee(DPanelMenuC, Panel)
	local DButton2 = vgui.Create( "DButton", DPanelMenu)
	DButton2:SetSize( 80,80 )
	DButton2:SetPos(0,80-2 )
	DButton2:SetText( "" )	
	DButton2.Paint = function(pnl, w, h )
		
		local m = 1
		if pnOpen == 2 then
			m = 2
		end
		
		draw.RoundedBox( 0, 0,0,w,h, Color(0,0,0,100 * m))
		draw.RoundedBox(0,0,0,w,2, Color(255,255,255,255))
		draw.RoundedBox(0,0,h-2,w,2, Color(255,255,255,255))
		draw.RoundedBox(0,0,0,2,h, Color(255,255,255,255 ))
		draw.RoundedBox(0,w-2,0,2,h, Color(255,255,255,255))
		
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetMaterial( edit )
		surface.DrawTexturedRect( 2 + (w-4)/2 - 64/2, 2 + (h-4)/2 - 64/2, 64,64 )
		
		-- draw.SimpleText( "CONTINUE", "Bariol25",150/2,30/2-1,Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	
	end
	DButton2.DoClick = function( pnl )
		if pnOpen == 2 then return end
		pnOpen = 2
		DPanelMenuC:SizeTo(0, panely, 0.5, 0, -1, function()
			for k, v in pairs( DPanelMenuC:GetChildren() ) do
				v:Remove()
			end
			
			DPanelMenuC:SizeTo(panelx-80, panely, 0.5, 0, -1, function()
				OpenText(DPanelMenuC, Panel) 
			end)
		end)
	end
	
	local DButton3 = vgui.Create( "DButton", DPanelMenu)
	DButton3:SetSize( 80,80 )
	DButton3:SetPos(0,(80-2)*2 )
	DButton3:SetText( "" )	
	DButton3.Paint = function(pnl, w, h )
		
		local m = 1
		if pnOpen == 3 then
			m = 2
		end
		
		draw.RoundedBox( 0, 0,0,w,h, Color(0,0,0,100 * m))
		draw.RoundedBox(0,0,0,w,2, Color(255,255,255,255))
		draw.RoundedBox(0,0,h-2,w,2, Color(255,255,255,255))
		draw.RoundedBox(0,0,0,2,h, Color(255,255,255,255 ))
		draw.RoundedBox(0,w-2,0,2,h, Color(255,255,255,255))
		
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetMaterial( photo )
		surface.DrawTexturedRect( 2 + (w-4)/2 - 64/2, 2 + (h-4)/2 - 64/2, 64,64 )
		
		-- draw.SimpleText( "CONTINUE", "Bariol25",150/2,30/2-1,Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	
	end
	DButton3.DoClick = function( pnl )
		if pnOpen == 3 then return end
		pnOpen = 3
		DPanelMenuC:SizeTo(0, panely, 0.5, 0, -1, function()
			for k, v in pairs( DPanelMenuC:GetChildren() ) do
				v:Remove()
			end
			
			DPanelMenuC:SizeTo(panelx-80, panely, 0.5, 0, -1, function()
				OpenImage(DPanelMenuC, Panel) 
			end)
		end)
	end
	
	local DButton4 = vgui.Create( "DButton", DPanelMenu)
	DButton4:SetSize( 80,80 )
	DButton4:SetPos(0,(80-2)*3 )
	DButton4:SetText( "" )	
	DButton4.Paint = function(pnl, w, h )
		
		local m = 1
		if pnOpen == 4 then
			m = 2
		end
		
		draw.RoundedBox( 0, 0,0,w,h, Color(0,0,0,100 * m))
		draw.RoundedBox(0,0,0,w,2, Color(255,255,255,255))
		draw.RoundedBox(0,0,h-2,w,2, Color(255,255,255,255))
		draw.RoundedBox(0,0,0,2,h, Color(255,255,255,255 ))
		draw.RoundedBox(0,w-2,0,2,h, Color(255,255,255,255))
		
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetMaterial( pay )
		surface.DrawTexturedRect( 2 + (w-4)/2 - 64/2, 2 + (h-4)/2 - 64/2, 64,64 )
		
		-- draw.SimpleText( "CONTINUE", "Bariol25",150/2,30/2-1,Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	
	end
	DButton4.DoClick = function( pnl )
		if pnOpen == 4 then return end
		pnOpen = 4
		DPanelMenuC:SizeTo(0, panely, 0.5, 0, -1, function()
			for k, v in pairs( DPanelMenuC:GetChildren() ) do
				v:Remove()
			end
			
			DPanelMenuC:SizeTo(panelx-80, panely, 0.5, 0, -1, function()
				OpenPay(DPanelMenuC, Panel) 
			end)
		end)

	end
	
	local DButton5 = vgui.Create( "DButton", DPanelMenu)
	DButton5:SetSize( 80,80 )
	DButton5:SetPos(0,(80-2)*4 )
	DButton5:SetText( "" )	
	DButton5.Paint = function(pnl, w, h )
		
		local m = 1
		if pnOpen == 5 then
			m = 2
		end
		
		draw.RoundedBox( 0, 0,0,w,h, Color(0,0,0,100 * m))
		draw.RoundedBox(0,0,0,w,2, Color(255,255,255,255))
		draw.RoundedBox(0,0,h-2,w,2, Color(255,255,255,255))
		draw.RoundedBox(0,0,0,2,h, Color(255,255,255,255 ))
		draw.RoundedBox(0,w-2,0,2,h, Color(255,255,255,255))
		
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetMaterial( exitM )
		surface.DrawTexturedRect( 2 + (w-4)/2 - 64/2, 2 + (h-4)/2 - 64/2, 64,64 )
		
		-- draw.SimpleText( "CONTINUE", "Bariol25",150/2,30/2-1,Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	
	end
	DButton5.DoClick = function( pnl )
		MFrame:Close()
	end
	--
	
end

function Cosmetics_OpenAdminGui()

	local sizex, sizey = ScrW(),ScrH()
	local infos = LocalPlayer():CM_GetInfos()
	
	MFrame = vgui.Create( "DFrame" )
	MFrame:SetPos( (ScrW()-sizex)/2, (ScrH()-sizey)/2 )
	MFrame:SetSize( sizex, sizey )
	MFrame:SetTitle( "" )
	MFrame:SetDraggable( false )
	MFrame:ShowCloseButton( false )
	MFrame:MakePopup()
	MFrame.Paint = function( pnl, w, h )
		DrawBlurRect(0,0, sizex, sizey*0.15, 6, 10)
		DrawBlurRect(0,ScrH()-sizey*0.15, sizex, sizey*0.15, 6, 10)
		
		DrawBlur( pnl, 8, 16 )
		
		draw.RoundedBox( 0, 0,0,sizex,sizey*0.15, Color(0,0,0,245))
		draw.RoundedBox( 0, 0,ScrH()-sizey*0.15,sizex,sizey*0.15, Color(0,0,0,245))

		DrawBlur( pnl, 8, 16 )
		
		draw.RoundedBox( 0, 0,0,sizex,sizey*0.15, Color(0,0,0,245))
		draw.RoundedBox( 0, 0,ScrH()-sizey*0.15,sizex,sizey*0.15, Color(0,0,0,245))
				
	end
	
	local DPanelM = vgui.Create( "DPanel",MFrame )
	DPanelM:SetPos( 0,sizey*0.15 )
	DPanelM:SetSize( sizex, sizey*0.7 )
	DPanelM.Paint = function() 
	end

	CustomTop = {}
	
	CustomTop.Texts = {}
	CustomTop.Images = {}
	CustomTop.Texture = "models/humans/enhancedshortsleeved/citizen_sheet"
	
	local DPanel = vgui.Create( "DPanel",DPanelM )
	DPanel:SetPos( 0,50 )
	DPanel:SetSize( sizex, sizey )
	local removeTime = -1
	local startTime = CurTime()
	DPanel:SetAlpha( 0 )
	DPanel:MoveTo( 0,0,1,0,-1, function() end )
	
	local sizeym = sizey * 0.9
	local sizexm = sizeym * 0.7
	
	DPanel.Paint = function(pnl, w, h)
		local perc = 1
	
		if removeTime != -1 then
		
			perc = (1-math.Clamp(CurTime() - removeTime, 0, 1))/2
		else
			
			perc = ( math.Clamp(CurTime() - startTime, 0, 1) )
			
		end
		
		DPanel:SetAlpha(255 * perc)	
		
	end
	
	
	modelPanel = vgui.Create( "DModelPanel", DPanel )
	
	modelPanel:SetSize( sizexm, sizeym )
	modelPanel:SetPos( ScrW()/2-sizexm/2, 0 )
	
	
	function modelPanel:LayoutEntity( Entity ) return end
	modelPanel:SetModel( infos.model )
	local startpos = modelPanel.Entity:GetBonePosition( modelPanel.Entity:LookupBone( "ValveBiped.Bip01_Pelvis" ) or 0 )
	
	modelPanel.pos = startpos
	modelPanel.el = Vector(-40,-10,-0)

	modelPanel:SetLookAt( modelPanel.pos )

	modelPanel:SetCamPos( modelPanel.pos-modelPanel.el )
	
	modelPanel.Entity:SetEyeTarget( modelPanel.pos-modelPanel.el )
	
	modelPanel.Actualize = function()
		local infos = LocalPlayer():CM_GetInfos()
		local datas 
		if infos.sex == 1 then
			datas = Cosmetics.Male
		else
			datas = Cosmetics.Female
		end
		
		local texture = CustomTop.Texture
		local bodygroupname = datas.EditableTop[texture].bodygroup
		
		local bodygroups = {
			datas.ListDefaultPM[LocalPlayer():CM_GetInfos().model].bodygroupstop[bodygroupname].group
			}
		
		local group = datas.ListDefaultPM[LocalPlayer():CM_GetInfos().model].bodygroupstop[bodygroupname].tee
		
		for k,v in pairs( bodygroups ) do
			modelPanel.Entity:SetBodygroup(v[1],v[2])
		end
		for k,v in pairs( group ) do
			modelPanel.Entity:SetSubMaterial(v, texture)
		end
	end
	
	modelPanel.ActualizeC = function()
			
		local infos = LocalPlayer():CM_GetInfos()
		local datas 
		if infos.sex == 1 then
			datas = Cosmetics.Male
		else
			datas = Cosmetics.Female
		end
		
		local texture = CustomTop.Texture
		local bodygroupname = datas.EditableTop[texture].bodygroup
		
		local bodygroups = {
			datas.ListDefaultPM[LocalPlayer():CM_GetInfos().model].bodygroupstop[bodygroupname].group
			}
		
		local group = datas.ListDefaultPM[LocalPlayer():CM_GetInfos().model].bodygroupstop[bodygroupname].tee
		
		for k,v in pairs( bodygroups ) do
			modelPanel.Entity:SetBodygroup(v[1],v[2])
		end
		
		CM_CreateClothes(ToData(CustomTop),0)
		
		texture = "!CM_0"
		
		for k,v in pairs( group ) do
			modelPanel.Entity:SetSubMaterial(v, texture)
		end
	end
	
	-- timer.Create("CM_modelPanelActualize", 0.3, 0, function()
	
		-- if IsValid( modelPanel ) then
			-- modelPanel:ActualizeC()
		-- else
			-- timer.Remove("CM_modelPanelActualize")
		-- end
		
	-- end)
	
	modelPanel:Actualize()
	
	function modelPanel.Entity:GetPlayerColor()return Vector( 1,1,1 )
	end
	
	DPanelDrP = vgui.Create( "DPanel",DPanel )
	DPanelDrP:SetPos( ScrW()/2-sizexm*0.3/2, sizeym*0.28 )
	DPanelDrP:SetSize( sizexm*0.3, sizeym*0.26 )
	DPanelDrP.Paint = function(pnl, w, h)
		-- draw.RoundedBox(0,w/2-w*0.4/2,h*0.25,w*0.4,h*0.3, Color(255,255,255,100))
		-- draw.RoundedBox(0,w/2-w*0.4/2,h*0.25,2,h*0.3, Color(255,255,255,255))
		-- draw.RoundedBox(0,w/2-w*0.4/2 + w*0.4,h*0.25,2,h*0.3, Color(255,255,255,255))
		-- draw.RoundedBox(0,w/2-w*0.4/2,h*0.25,w*0.4,2, Color(255,255,255,255))
		-- draw.RoundedBox(0,w/2-w*0.4/2,h*0.25 + h*0.3,w*0.4,2, Color(255,255,255,255))
		
		draw.RoundedBox(0,0,0,h,2, Color(255,255,255,255))
		draw.RoundedBox(0,0,h-2,h,2, Color(255,255,255,255))
		draw.RoundedBox(0,0,0,2,h, Color(255,255,255,255))
		draw.RoundedBox(0,w-2,0,2,h, Color(255,255,255,255))
	end
	
	local DPanelDl = vgui.Create( "DPanel",DPanel )
	DPanelDl:SetPos( 0,50 )
	DPanelDl:SetSize( sizex, sizey )	
	DPanelDl.Paint = function(pnl, w, h)
		if IsValid( DPanelDrP ) and IsValid( Preview ) then
			
			local posx, posy = DPanelDrP:GetPos()
			local x, y = DPanelDrP:GetSize()
			
			local posPx, posPy = Preview:GetPos()
			local x2, y2 = Preview:GetSize()
			
			local distY = math.abs( posPy-posy )/2

			surface.DrawLine(posx+x, posy-50, posPx, posPy-50 )
			
			surface.DrawLine(posx+x, posy-50+y, posPx, posPy-50+y2-2 )
		end	
		
	end
	
	OpenEdit(DPanel)
	
	OpenPreview(DPanel)
	
end
