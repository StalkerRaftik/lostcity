rp.ui = rp.ui or {}
ui = ui or {}


surface.CreateFont('ui.40', {font = 'Roboto', size = ba.ScreenScale(40), weight = 500, extended = true})
surface.CreateFont('ui.39', {font = 'Roboto', size = ba.ScreenScale(39), weight = 500, extended = true})
surface.CreateFont('ui.38', {font = 'Roboto', size = ba.ScreenScale(38), weight = 500, extended = true})
surface.CreateFont('ui.37', {font = 'Roboto', size = ba.ScreenScale(37), weight = 500, extended = true})
surface.CreateFont('ui.36', {font = 'Roboto', size = ba.ScreenScale(36), weight = 500, extended = true})
surface.CreateFont('ui.35', {font = 'Roboto', size = ba.ScreenScale(35), weight = 500, extended = true})
surface.CreateFont('ui.34', {font = 'Roboto', size = ba.ScreenScale(34), weight = 500, extended = true})
surface.CreateFont('ui.33', {font = 'Roboto', size = ba.ScreenScale(33), weight = 500, extended = true})
surface.CreateFont('ui.32', {font = 'Roboto', size = ba.ScreenScale(32), weight = 400, extended = true})
surface.CreateFont('ui.31', {font = 'Roboto', size = ba.ScreenScale(31), weight = 500, extended = true})
surface.CreateFont('ui.30', {font = 'Roboto', size = ba.ScreenScale(30), weight = 500, extended = true})
surface.CreateFont('ui.29', {font = 'Roboto', size = ba.ScreenScale(29), weight = 500, extended = true})
surface.CreateFont('ui.28', {font = 'Roboto', size = ba.ScreenScale(28), weight = 500, extended = true})
surface.CreateFont('ui.27', {font = 'Roboto', size = ba.ScreenScale(27), weight = 400, extended = true})
surface.CreateFont('ui.26', {font = 'Roboto', size = ba.ScreenScale(26), weight = 400, extended = true})
surface.CreateFont('ui.25', {font = 'Roboto', size = ba.ScreenScale(25), weight = 400, extended = true})
surface.CreateFont('ui.24', {font = 'Roboto', size = ba.ScreenScale(24), weight = 400, extended = true})
surface.CreateFont('ui.23', {font = 'Roboto', size = ba.ScreenScale(23), weight = 400, extended = true})
surface.CreateFont('ui.22', {font = 'Roboto', size = ba.ScreenScale(22), weight = 400, extended = true})
surface.CreateFont('ui.20', {font = 'Roboto', size = ba.ScreenScale(20), weight = 400, extended = true})
surface.CreateFont('ui.19', {font = 'Roboto', size = ba.ScreenScale(19), weight = 400, extended = true})
surface.CreateFont('ui.18', {font = 'Roboto', size = ba.ScreenScale(18), weight = 400, extended = true})
surface.CreateFont('ui.17', {font = 'Roboto', size = ba.ScreenScale(15), weight = 400, extended = true})
surface.CreateFont('ui.15', {font = 'Roboto', size = ba.ScreenScale(15), weight = 400, extended = true})

for size = 10, 100 do
    surface.CreateFont('rp.ui.'..size, {font = 'Roboto', size = ba.ScreenScale(size), weight = 400, extended = true})
end

surface.CreateFont( "font_base",        {font = "Roboto",size = ba.ScreenScale(35),weight = 400,underline = false,extended = true})
surface.CreateFont( "font_base_big",    {font = "Roboto",size = ba.ScreenScale(47),weight = 400,extended = true})
surface.CreateFont( "font_base_rotate", {font = "Roboto",size = ba.ScreenScale(41),weight = 400,extended = true})
surface.CreateFont( "font_base_normal", {font = "Roboto",size = ba.ScreenScale(29),weight = 400,underline = false,extended = true})
surface.CreateFont( "font_base_24",     {font = "Roboto",size = ba.ScreenScale(27),weight = 400,extended = true})
surface.CreateFont( "font_base_20",     {font = "Roboto",size = ba.ScreenScale(23),weight = 400,extended = true})
surface.CreateFont( "font_base_title",  {font = "Roboto",size = ba.ScreenScale(41),weight = 400,extended = true})
surface.CreateFont( "font_base_18",     {font = "Roboto",size = ba.ScreenScale(21),weight = 400,extended = true})
surface.CreateFont( "font_base_small",  {font = "Roboto",size = ba.ScreenScale(17),weight = 300,underline = false,extended = true})
surface.CreateFont( "font_base_12",     {font = "Roboto",size = ba.ScreenScale(15),weight = 400,underline = false,extended = true})
surface.CreateFont( "font_base_hud",    {font = "Roboto",size = ba.ScreenScale(29),weight = 400,underline = false,extended = true})
surface.CreateFont( "font_base_84",     {font = "Roboto",size = ba.ScreenScale(84),weight = 400,underline = false,extended = true})
surface.CreateFont( "font_base_54",     {font = "Roboto",size = ba.ScreenScale(54),weight = 400,underline = false,extended = true})
surface.CreateFont( "font_notify",      {font = "Roboto",size = ba.ScreenScale(25),weight = 400,extended = true})
surface.CreateFont( "font_gtasa_title", {font = "Pricedown Rus",size = ba.ScreenScale(100),weight = 400,extended = true,outline = true})
surface.CreateFont( "font_gtasa_text",  {font = "Pricedown Rus",size = ba.ScreenScale(60),weight = 400,extended = true,outline = true})
surface.CreateFont( "font_gta5_title",  {font = "Copyright House Industries",size = ba.ScreenScale(100),weight = 400,extended = true})
surface.CreateFont( "font_gta5_text",   {font = "Copyright House Industries",size = ba.ScreenScale(60),weight = 400,extended = true})
surface.CreateFont( "font_base_name",   {font = "Roboto",size = ba.ScreenScale(30),weight = 400,extended = true})
surface.CreateFont('font_base_note', {font = 'ljk_WC Mano Negra Bta', size = ba.ScreenScale(38), weight = 500, extended = true}) 
-- surface.CreateFont('font_base_loading', {font = 'ljk_WC Mano Negra Bta', size = ba.ScreenScale(90), weight = 500, extended = true})
surface.CreateFont('font_base_ds', {font = 'JK_Cold Night for Alligators', size = 130, weight = 500, extended = true, additive = true})
surface.CreateFont('font_base_uglybutton', {font = 'JK_Cold Night for Alligators', size = ba.ScreenScale(35), weight = 500, extended = true, additive = true})

local vguiFucs = {
	['DTextEntry'] = function(self, p)
		self:SetFont('ui.20')
	end,	
	['DLabel'] = function(self, p)
		self:SetFont('ui.22')
		self:SetColor(ui.col.White)
	end,
	['DButton'] = function(self, p)
		self:SetFont('ui.20')
	end,
	['DComboBox'] = function(self, p)
		self:SetFont('ui.22')
	end,
}

local c = Color

ui.col = {
	SUP 			= c(51,128,255),
	Background 		= c(10,10,10,170),
	Outline 		= c(100,100,100,255),
	Hover 			= c(160,160,160,40),


	Button 			= c(51,128,255),
	ButtonHover 	= c(51,128,255),
	ButtonRed 		= c(51,128,255),
	ButtonGreen 	= c(51,128,255),
	Close 			= c(51,128,255),
	CloseBackground = c(51,128,255),
	CloseHovered 	= c(51,128,255),


	OffWhite 		= c(200,200,200),
	FlatBlack 		= c(40,40,40),
	Black 			= c(0,0,0),
	White 			= c(255,255,255),
	Red 			= c(255,0,0),
	Orange 			= c(245,120,0),
}

local color_bg 		  = Color(0,0,0)
local color_outline = Color(245,245,245)

local math_clamp	= math.Clamp
local Color 		  = Color

function rp.ui.DrawBar(x, y, w, h, perc)
  local color = Color(255 - (perc * 255), perc * 255, 0, 255)

  draw.OutlinedBox(x, y, math_clamp((w * perc), 3, w), h, color, color_outline)
end

function rp.ui.DrawProgress(x, y, w, h, perc)
  local color = Color(255 - (perc * 255), perc * 255, 0, 255)

  draw.RoundedBoxOutlined( 2, x, y, w, h, Color(50, 60, 69, 200), Color(50,50,50,150) )
  draw.RoundedBoxOutlined( 2, x + 5, y + 5, math.clamp((w * perc) - 10, 3, w), h - 10, color, Color(50,50,50,150) )
end

function rp.ui.BlackAlphaScreen()
  hook.Remove("CalcView", "GlideTest")
  -- return false
	-- local alpha = 0
	-- hook.Add("HUDPaint", "CloseIntroMenuBlack", function()
	-- 	alpha = Lerp(.008, alpha, 255)
	-- 	surface.SetDrawColor( 0, 0, 0, alpha*1.05 )
	-- 	surface.DrawRect( 0, 0, ScrW(), ScrH() )
	-- 	if alpha >= 250 then 
	-- 		hook.Remove("CalcView", "GlideTest")
	-- 		if IsValid( LocalPlayer().s ) then LocalPlayer().s:Stop() end
	-- 		RunConsoleCommand( "stopsound" )
	-- 		LocalPlayer().intro = false
	-- 		hook.Remove("HUDPaint", "CloseIntroMenuBlack") 
	-- 		local alpha2 = 255
	-- 	-- hook.Add("HUDPaint", "CloseIntroMenuBlackBack", function()
	-- 	-- 	alpha2 = Lerp(.005, alpha2, 0)
	-- 	-- 	surface.SetDrawColor( 0, 0, 0, alpha2*1.05 )
	-- 	-- 	surface.DrawRect( 0, 0, ScrW(), ScrH() )
	-- 	-- 	if alpha2 <= 20 then 
	-- 	-- 		hook.Remove("HUDPaint", "CloseIntroMenuBlackBack")
	-- 	-- 	end
	-- 	-- end)
	-- 	end
	-- end)
end


local texOutlinedCorner = surface.GetTextureID( "gui/corner16" )
function draw.RoundedBoxOutlined( bordersize, x, y, w, h, color, bordercol )

  x = math.Round( x )
  y = math.Round( y )
  w = math.Round( w )
  h = math.Round( h )

  draw.RoundedBox( bordersize, x, y, w, h, color )
  
  surface.SetDrawColor( bordercol )
  
  surface.SetTexture( texOutlinedCorner )
  surface.DrawTexturedRectRotated( x + bordersize/2 , y + bordersize/2, bordersize, bordersize, 0 ) 
  surface.DrawTexturedRectRotated( x + w - bordersize/2 , y + bordersize/2, bordersize, bordersize, 270 ) 
  surface.DrawTexturedRectRotated( x + w - bordersize/2 , y + h - bordersize/2, bordersize, bordersize, 180 ) 
  surface.DrawTexturedRectRotated( x + bordersize/2 , y + h -bordersize/2, bordersize, bordersize, 90 ) 
  
  surface.DrawLine( x+bordersize, y, x+w-bordersize, y )
  surface.DrawLine( x+bordersize, y+h-1, x+w-bordersize, y+h-1 )
  
  surface.DrawLine( x, y+bordersize, x, y+h-bordersize )
  surface.DrawLine( x+w-1, y+bordersize, x+w-1, y+h-bordersize )

end

local matrix = Matrix()
local matrixAngle = Angle(0, 0, 0)
local matrixScale = Vector(0, 0, 0)
local matrixTranslation = Vector(0, 0, 0)

function draw.TextRotated(text, font, x, y, xScale, yScale, angle, color, bshadow)
  render.PushFilterMag( TEXFILTER.LINEAR )
  render.PushFilterMin( TEXFILTER.LINEAR )
    matrix:SetTranslation( Vector( x, y ) )
    matrix:SetAngles( Angle( 0, angle, 0 ) )

    surface.SetFont( font )
    
    if bshadow then
      surface.SetTextColor( Color(0,0,0,90) )

      matrixScale.x = xScale
      matrixScale.y = yScale
      matrix:Scale(matrixScale)
      
      surface.SetTextPos(1, 1)
      
      cam.PushModelMatrix(matrix)
        surface.DrawText(text)
      cam.PopModelMatrix()
    end

    surface.SetTextColor( color )
    surface.SetTextPos(0, 0)
    
    cam.PushModelMatrix(matrix)
      surface.DrawText(text)
    cam.PopModelMatrix()
  render.PopFilterMag()
  render.PopFilterMin()
end

local Fades = {}
FADE_STAGE_IN = 1
FADE_STAGE_STAY = 2
FADE_STAGE_FADING = 3
FADE_STAGE_NONE = 4
function FadeInOut(id, drawFunc, InTime, StayTime, FadeTime)
	if not Fades[id] then 
		Fades[id] = {
			Alpha = 0,
			HoldTime = 0,
			Stage = FADE_STAGE_IN,
			StageStart = SysTime(),
		}
	end
	
	local FadeInfo = Fades[id]

	if FadeInfo.Stage == FADE_STAGE_IN then
		FadeInfo.Alpha = Lerp( ( SysTime() - FadeInfo.StageStart ) / InTime, 0, 1 )

		if FadeInfo.Alpha == 1 then
			FadeInfo.Stage = FADE_STAGE_STAY
			FadeInfo.StageStart = CurTime()
		end
	elseif FadeInfo.Stage == FADE_STAGE_STAY then
		if CurTime() - FadeInfo.StageStart > StayTime then 
			FadeInfo.Stage = FADE_STAGE_FADING
			FadeInfo.StageStart = SysTime()
		end
	elseif FadeInfo.Stage == FADE_STAGE_FADING then
		FadeInfo.Alpha = Lerp( ( SysTime() - FadeInfo.StageStart ) / FadeTime, 1, 0 )

		if FadeInfo.Alpha == 0 then
			Fades[id] = nil 
			return FADE_STAGE_NONE
		end
	end

	drawFunc(FadeInfo.Alpha)
	return FadeInfo.Stage
end

function draw.ShadowSimpleText( text, font, x, y, color, xalign, yalign )
	color = color and color or Color(255,255,255, 255)
	draw.SimpleText(text, font, x+1, y+1, Color(0,0,0, color.a * 190), xalign, yalign)
	draw.SimpleText(text, font, x, y, color, xalign, yalign)
end

function draw.ShadowTextOutlined( text, font, x, y, color, xalign, yalign, shadowOutlineColor )
  shadowOutlineColor = shadowOutlineColor or Color(0, 0, 0, 255)
  draw.SimpleTextOutlined(text, font, x+1, y+1, shadowOutlineColor, xalign, xalign, 1, shadowOutlineColor)
  draw.SimpleText(text, font, x, y, color, xalign, xalign)
end

function draw.ShadowText(text, font, x, y, colortext, colorshadow, dist, xalign, yalign)
	draw.SimpleText(text, font, x + dist, y + dist, colorshadow, xalign, yalign)
	draw.SimpleText(text, font, x, y, colortext, xalign, yalign)
end

local function safeText(text)
    return string.match(text, "^#([a-zA-Z_]+)$") and text .. " " or text
end

function draw.DrawNonParsedText(text, font, x, y, color, xAlign)
    return draw.DrawText(safeText(text), font, x, y, color, xAlign)
end

function draw.DrawNonParsedTextOutlined(text, font, x, y, color, xAlign)
  draw.DrawText(safeText(text), font, x+1, y+1, Color(0,0,0,190), xAlign)
  draw.DrawText(safeText(text), font, x, y, color, xAlign)
end

function draw.DrawNonParsedSimpleText(text, font, x, y, color, xAlign, yAlign)
    return draw.SimpleText(safeText(text), font, x, y, color, xAlign, yAlign)
end

function draw.DrawNonParsedSimpleTextOutlined(text, font, x, y, color, xAlign, yAlign, outlineWidth, outlineColor)
    return draw.SimpleTextOutlined(safeText(text), font, x, y, color, xAlign, yAlign, outlineWidth, outlineColor)
end

function surface.DrawNonParsedText(text)
    return surface.DrawText(safeText(text))
end

function chat.AddNonParsedText(...)
    local tbl = {...}
    for i = 2, #tbl, 2 do
        tbl[i] = safeText(tbl[i])
    end
    return chat.AddText(unpack(tbl))
end

function rp.ui.Label(txt, font, x, y, parent)
  return ui.Create('DLabel', function(self, p)
    self:SetText(txt)
    self:SetFont("font_base_24")
    self:SetTextColor(rp.col.White)
    self:SetPos(x, y)
    self:SizeToContents()
    self:SetWrap(true)
    self:SetAutoStretchVertical(true)
  end, parent)
end

function draw.Icon( x, y, w, h, Mat, tblColor )
	surface.SetMaterial(Mat)
	surface.SetDrawColor(tblColor or Color(255,255,255,255))
	surface.DrawTexturedRect(x, y, w, h)
end

local blur = Material("pp/blurscreen", "noclamp")
 function draw.StencilBlur(panel, w, h)
    render.ClearStencil()
    render.SetStencilEnable(true)
    render.SetStencilReferenceValue(1)
    render.SetStencilTestMask(1)
    render.SetStencilWriteMask(1)
    render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_NEVER)
    render.SetStencilFailOperation(STENCILOPERATION_REPLACE)
    render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
    render.SetStencilZFailOperation(STENCILOPERATION_REPLACE)
    surface.SetDrawColor(255, 255, 255, 255)
    surface.DrawRect(0, 0, w, h)
    render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
    render.SetStencilFailOperation(STENCILOPERATION_KEEP)
    render.SetStencilPassOperation(STENCILOPERATION_KEEP)
    render.SetStencilZFailOperation(STENCILOPERATION_KEEP)
    surface.SetMaterial(blur)
    surface.SetDrawColor(255, 255, 255, 255)

    for i = 0, 1, 0.33 do
        blur:SetFloat('$blur', 5 * i)
        blur:Recompute()
        render.UpdateScreenEffectTexture()
        local x, y = panel:GetPos()
        surface.DrawTexturedRect(-x, -y, ScrW(), ScrH())
    end

    render.SetStencilEnable(false)
end

function NoPanelBlur(x, y, w, h, amount, heavyness)
  -- if GetConVar("rp_blur_enable"):GetInt() >= 1 then 
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
  -- end
end


function draw.BlurBackground(x, y, w, h, alpha, panel, color_new)
  if panel then
      draw.StencilBlur(panel, w, h)
  end

  draw.RoundedBox(0, x, y, w, h, Color(0, 0, 0, alpha))

  if color_new then
      draw.RoundedBox(0, 0, 0, w, 35, color_new)
  end

  surface.SetDrawColor(Color(0,0,0, alpha))
  surface.DrawOutlinedRect(x, y, w, h)
end

function draw.BlurBackgroundColored(x, y, w, h, alpha, panel, color_new)
  if panel then
      draw.StencilBlur(panel, w, h)
  end
  draw.RoundedBox(0, x, y, w, h, color_new)
end

local blur = Material("pp/blurscreen")
local gradLeft = Material("vgui/gradient-l")
local gradUp = Material("vgui/gradient-u")
local gradRight = Material("vgui/gradient-r")
local gradDown = Material("vgui/gradient-d")
local cos, sin, abs, rad1, log, pow = math.cos, math.sin, math.abs, math.rad, math.log, math.pow

-- arc drawing functions
-- by bobbleheadbob
-- https://facepunch.com/showthread.php?t=1558060
function util.DrawArc(cx, cy, radius, thickness, startang, endang, roughness, color)
  surface.SetDrawColor(color)
  util.DrawPrecachedArc(util.PrecacheArc(cx, cy, radius, thickness, startang, endang, roughness))
end

function util.DrawPrecachedArc(arc) -- Draw a premade arc.
  for _, v in ipairs(arc) do
    surface.DrawPoly(v)
  end
end

function util.PrecacheArc(cx, cy, radius, thickness, startang, endang, roughness)
  local quadarc = {}

  -- Correct start/end ang
  startang = startang or 0
  endang = endang or 0

  -- Define step
  -- roughness = roughness or 1
  local diff = abs(startang - endang)
  local smoothness = log(diff, 2) / 2
  local step = diff / (pow(2, smoothness))

  if startang > endang then
    step = abs(step) * -1
  end

  -- Create the inner circle's points.
  local inner = {}
  local outer = {}
  local ct = 1
  local r = radius - thickness

  for deg = startang, endang, step do
    local rad = rad1(deg)
    local cosrad, sinrad = cos(rad), sin(rad) --calculate sin, cos

    local ox, oy = cx + (cosrad * r), cy + (-sinrad * r) --apply to inner distance
    inner[ct] = {
      x = ox,
      y = oy,
      u = (ox - cx) / radius + .5,
      v = (oy - cy) / radius + .5
    }

    local ox2, oy2 = cx + (cosrad * radius), cy + (-sinrad * radius) --apply to outer distance
    outer[ct] = {
      x = ox2,
      y = oy2,
      u = (ox2 - cx) / radius + .5,
      v = (oy2 - cy) / radius + .5
    }

    ct = ct + 1
  end

  -- QUAD the points.
  for tri = 1, ct do
    local p1, p2, p3, p4
    local t = tri + 1
    p1 = outer[tri]
    p2 = outer[t]
    p3 = inner[t]
    p4 = inner[tri]

    quadarc[tri] = {p1, p2, p3, p4}
  end

  -- Return a table of triangles to draw.
  return quadarc
end

TRIANGLE_TOP = 1
TRIANGLE_BOT = 2
function draw.Triangle( x, y, width, height, direction, color)
  draw.NoTexture()
  local triangle

  if direction == TRIANGLE_TOP then
    triangle = {
      { x = x + width, y = y+height },
      { x = x, y = y + height },
      { x = x + width/2, y = y }
    }
  else
    triangle = {
      { x = x + width/2, y = y + height },
      { x = x, y = y },
      { x = x + width, y = y }
    }
  end
  surface.SetDrawColor( color )
  surface.DrawPoly( triangle )
end

function draw.Circle( center, radius, segs, color )
	draw.NoTexture()
	local cir = {}
	local x, y = center.x, center.y

	table.insert( cir, { x = x, y = y, u = 0.5, v = 0.5 } )
	for i = 0, segs do
		local a = math.rad( ( i / segs ) * -360 )
		table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
	end

	local a = math.rad( 0 ) -- This is needed for non absolute segment counts
	table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )

	surface.SetDrawColor( color.r, color.g, color.b, color.a )
	surface.DrawPoly( cir )
end

function draw.OctopusArc( center, startang, endang, radius, roughness, thickness, color )
	draw.NoTexture()
	surface.SetDrawColor( color.r, color.g, color.b, color.a )
	local segs, p = roughness, {}
	for i2 = 0, segs do
		p[i2] = -i2 / segs * (math.pi/180) * endang - (startang/57.3)
	end
	for i2 = 1, segs do
		if endang <= 90 then
			segs = segs/2
		elseif endang <= 180 then
			segs = segs/4
		elseif endang <= 270 then
			segs = segs/6
		else
			segs = segs
		end
		local r1, r2 = radius, math.max(radius - thickness, 0)
		local v1, v2 = p[i2 - 1], p[i2]
		local c1, c2 = math.cos( v1 ), math.cos( v2 )
		local s1, s2 = math.sin( v1 ), math.sin( v2 )
		surface.DrawPoly{
			{ x = center.x + c1 * r2, y = center.y - s1 * r2 },
			{ x = center.x + c1 * r1, y = center.y - s1 * r1 },
			{ x = center.x + c2 * r1, y = center.y - s2 * r1 },
			{ x = center.x + c2 * r2, y = center.y - s2 * r2 },
		}
	end
end

local drx, dry
local dx, dy

function draw.SimpleTextDegree(text, font, x, y, top, bottom, percent, alignx, aligny)
	aligny = aligny or 3
	drx, dry = draw.SimpleText(text, font, x, y, bottom, alignx, aligny)
	dx = x - (alignx == 0 and 0 or alignx == 1 and drx / 2 or drx)
	dy = y - (aligny == 3 and 0 or aligny == 1 and dry / 2 or dry)
	render.SetScissorRect(dx, dy, dx + drx, dy + dry * percent, true)
	draw.SimpleText(text, font, x, y, top, alignx, aligny)
	render.SetScissorRect(0, 0, 0, 0, false)
end

function surface.DrawCuteRect(x, y, w, h, gasp, alpha, callback, outlineColor )
	if not gasp then gasp = 4 end
	if not alpha then alpha = 100 end

	surface.SetDrawColor( 0, 0, 0, alpha )
	surface.DrawRect( x, y, w, h )

	if callback then callback( x, y, w, h ) end

	surface.SetDrawColor( outlineColor or Color( 255, 255, 255, 255 ) )

	surface.DrawRect( x, y, 4 * gasp, gasp )
	surface.DrawRect( x + w - 4 * gasp, y, 4 * gasp, gasp )
	surface.DrawRect( x, y + h - gasp, 4 * gasp, gasp )
	surface.DrawRect( x + w - 4 * gasp, y + h - gasp, 4 * gasp, gasp )
	surface.DrawRect( x, y + gasp, gasp, 3 * gasp )
	surface.DrawRect( x + w - gasp, y + gasp, gasp, 3 * gasp )
	surface.DrawRect( x, y + h - 4 * gasp, gasp, 3 * gasp )
	surface.DrawRect( x + w - gasp, y + h - 4 * gasp, gasp, 3 * gasp )
end

function BestGuessLayout(mdlPanel, size)
	local ent = mdlPanel:GetEntity()
	local pos = ent:GetPos()
	local tab = PositionmonoIcon(ent, pos)

	if (tab) then
		mdlPanel:SetCamPos(tab.origin)
		mdlPanel:SetFOV(tab.fov * (size or 0.8))
		mdlPanel:SetLookAng(tab.angles)
	end
end


function draw.ShadowText(text, font, x, y, color, allignx, alligny)
  draw.SimpleText(text, font, x+1, y+1, Color(0,0,0), allignx, alligny)
  draw.SimpleText(text, font, x, y, color, allignx, alligny)
end

function draw.OverlayBackGround(round, x, y, w, h, alpha)
  alpha = alpha and alpha or 255
  draw.RoundedBox( 1, x, y, w, h, Color(40,40,40, 150) )
  draw.RoundedBox( 1, x+1, y+1, w-2, h-2, Color(0,0,0, 150) )
end

function draw.OverlayText(ent, icon, text, alpha)
  local markup_obj = markup.Parse("<font=font_base_18>"..text.."</font>")
  local w, h = markup_obj:GetWidth(), markup_obj:GetHeight()
  local pos = (ent:GetPos() + Vector(0,0,-ent:OBBMins().z)):ToScreen()
  local x, y = math.floor(pos.x-100), math.floor(pos.y-100)

  draw.OverlayBackGround(4, x, y, w + 20, h + 20)
  draw.SimpleText("u","marlett", x+w/2+10, y+h+14, Color(40,40,40), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
  draw.SimpleText("u","marlett", x+w/2+10, y+h+13, Color(32,36,40), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
  if icon then
    surface.SetDrawColor( 255, 255, 255, alpha )
    surface.SetMaterial(icon)
    surface.DrawTexturedRect( x+8, y+7, 20, 20 )
  end

  markup_obj:Draw( x+10, y+10, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 255 )
end

function draw.TrunkOverlayText(ent, icon, text, alpha)
  local markup_obj = markup.Parse("<font=font_base_18>"..text.."</font>")
  local w, h = markup_obj:GetWidth(), markup_obj:GetHeight()
  -- local pos = (ent:LocalToWorld( ent:OBBCenter() ) + ent:OBBMaxs() - Vector(0,200,00)):ToScreen()
  local vPosition = Vector( ent:OBBCenter()[1], ent:OBBMins()[2], 70 )
  local pos = (ent:LocalToWorld( vPosition - Vector(0,0,30))):ToScreen()
  local x, y = pos.x - 200, pos.y
  if (LocalPlayer():GetPos():DistToSqr(ent:LocalToWorld( vPosition - Vector(0,0,30))) >= 4000) then return end

  draw.OverlayBackGround(4, x, y, w + 20, h + 20)
  draw.SimpleText("u","marlett", x+w/2+10, y+h+14, Color(40,40,40), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
  draw.SimpleText("u","marlett", x+w/2+10, y+h+13, Color(32,36,40), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
  if icon then
    surface.SetDrawColor( 255, 255, 255, alpha )
    surface.SetMaterial(icon)
    surface.DrawTexturedRect( x+8, y+7, 20, 20 )
  end

  markup_obj:Draw( x+10, y+10, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 255 )
end

function ui.Create(t, f, p)
	local parent
	if (not isfunction(f)) and (f ~= nil) then
		parent = f
	elseif not isfunction(p) and (p ~= nil) then
		parent = p
	end

	local v = vgui.Create(t, parent)
  v:SetSkin('core')

	if vguiFucs[t] then vguiFucs[t](v, parent) end

	if isfunction(f) then f(v, parent) elseif isfunction(p) then p(v, f) end

	return v
end

function ui.Label(txt, font, x, y, parent)
	return ui.Create('DLabel', function(self, p)
		self:SetText(txt)
		self:SetFont(font)
		self:SetTextColor(ui.col.White)
		self:SetPos(x, y)
		self:SizeToContents()
		self:SetWrap(true)
		self:SetAutoStretchVertical(true)
	end, parent)
end

function ui.DermaMenu(p)
	local m = DermaMenu(p)
	m:SetSkin('core')
	return m
end

function ui.StringRequest(title, text, default, cback)
	local m = ui.Create('ui_frame', function(self)
		self:SetTitle(title)
		self:ShowCloseButton(false)
		self:SetWide(ScrW() * .3)
		self:MakePopup()
	end)
	
	local txt = string.Wrap('ui.18', text, m:GetWide() - 10)
	local y = m:GetTitleHeight() + 5

	for k, v in ipairs(txt) do
		local lbl = ui.Create('DLabel', function(self, p)
			self:SetText(v)
			self:SetFont('ui.18')
			self:SizeToContents()
			self:SetPos((p:GetWide() - self:GetWide()) / 2, y)
			y = y + self:GetTall()
		end, m)
	end
	
	local tb = ui.Create('DTextEntry', function(self, p) 
		self:SetPos(5, y + 5)
		self:SetSize(p:GetWide() - 10, 25)
		self:SetValue(default or '')
		y = y + self:GetTall() + 10
		self.OnEnter = function(s)
			p:Close()
			cback(self:GetValue())
		end
	end, m)

	local btnOK = ui.Create('DButton', function(self, p)
		self:SetText('Да')
		self:SetPos(5, y)
		self:SetSize(p:GetWide()/2 - 7.5, 25)
		self.DoClick = function(s)
			p:Close()
			cback(tb:GetValue())
		end
	end, m)

	local btnCan = ui.Create('DButton', function(self, p)
		self:SetText('Отмена')
		self:SetPos(btnOK:GetWide() + 10, y)
		self:SetSize(btnOK:GetWide(), 25)
		self:RequestFocus()
		self.DoClick = function(s)
			m:Close()
		end
		y = y + self:GetTall() + 5
	end, m)

	m:SetTall(y)
	m:Center()

	m:Focus()
	return m
end

function ui.PlayerReuqest(players, cback)
	if isfunction(players) then
		cback = players
		players = player.GetAll()
	end
	local m = ui.Create('ui_frame', function(self)
		self:SetTitle('Выберите игрока')
		self:SetSize(.2, .3)
		self:Center()
		self:MakePopup()
	end)
	local scr
	local x, y = m:GetDockPos()
	local tb = ui.Create('DTextEntry', function(self, p) 
		self:SetPos(x, y)
		self:SetSize(p:GetWide() - 10, 25)
		y = y + self:GetTall() + 5

		self.OnChange = function(s)
			scr:AddPlayers(self:GetValue())
		end

		self:RequestFocus()
	end, m)

	scr = ui.Create('ui_scrollpanel', function(self, p)
		self:SetPos(x, y)
		self:SetSize(p:GetWide() - 10, p:GetTall() - y - 5)

		function self:AddPlayer(pl)
			local p = ui.Create('DButton', function(self, p)
				self:SetTall(30)
				self:SetText(pl:Name())
				self:SetTextColor(ui.col.White)
				function self:Paint(w, h)
					if (not IsValid(pl)) then
						self:Remove()
						return
					end
					local col = pl.GetJobColor and pl:GetJobColor() or team.GetColor(pl:Team())
					col = Color(col.r,col.g,col.b,150)
					draw.OutlinedBox(0,0,w,h,col,ui.col.Outline)
				end
				function self:DoClick()
					if IsValid(pl) then
						m:Close()
						cback(pl)
					end
				end
			end)
			ui.Create('ui_avatarbutton', function(self, p)
				self:SetPos(2,2)
				self:SetSize(26, 26)
				self:SetPlayer(pl)
			end, p)
			self:AddItem(p)
		end
		function self:AddPlayers(inf)
			self:Reset()
			for k, v in ipairs(players) do
				if (v ~= LocalPlayer()) then
					if inf and string.find(v:Name():lower(), inf:lower(), 1, true) then
						self:AddPlayer(v)
					elseif (not inf) then
						self:AddPlayer(v)
					end
				end
			end
		end
		self:AddPlayers()
	end, m)

	m:Focus()
	return m
end

function ui.With(...)
	local arr = {...}
	return setmetatable({}, {
		__index = function(_, key)
			if arr[1][key] then
				return function(self, ...)
					if (self == _) then
						for k, v in ipairs(arr) do
							v[key](v, ...)
						end
					else
						error 'expected method call not function member invocation'
					end
					return self
				end
			elseif (key == 'Set') then
				return function(self, key, val)
					for k, v in ipairs(arr) do
						v[key] = val
					end
					return self
				end
			end
		end
	})
end
