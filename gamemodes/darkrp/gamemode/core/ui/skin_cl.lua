local SKIN  = {
  PrintName   = 'core',
  Author    = 'Kirussell'
}

local c = Color

rp.ui.col = {
  SUP       = c(40,40,40,150),
  Background    = c(40,40,40,150),
  Outline     = c(60,60,60,255),
  Hover       = c(160,160,160,40),


  Button      = c(140,140,140),
  ButtonHover   = c(220,220,220),
  ButtonRed     = c(240,0,0),
  ButtonGreen   = c(0,240,0),
  Close       = c(235,235,235),
  CloseBackground = c(215,45,90),
  CloseHovered  = c(235,25,70),


  OffWhite    = c(200,200,200),
  FlatBlack     = c(40,40,40),
  Black       = c(0,0,0),
  White       = c(255,255,255),
  Red       = c(255,0,0),
  Orange      = c(245,120,0),
}

local color_sup       = rp.ui.col.SUP
local color_background    = rp.ui.col.Background
local color_outline     = rp.ui.col.Outline
local color_hover       = rp.ui.col.Hover
local color_button      = rp.ui.col.Button
local color_button_hover  = rp.ui.col.ButtonHover
local color_close       = rp.ui.col.Close
local color_close_bg    = rp.ui.col.CloseBackground
local color_close_hover   = rp.ui.col.CloseHovered

local color_offwhite    = rp.ui.col.OffWhite
local color_flat_black    = rp.ui.col.FlatBlack
local color_black       = rp.ui.col.Black
local color_white       = rp.ui.col.White
local color_red       = rp.ui.col.Red

-- Frames    
function SKIN:PaintFrame(self, w, h)
  draw.StencilBlur(self, w, h)

  draw.RoundedBoxOutlined( 2, 0,0, w, h, Color(50, 50, 50, 150), Color(10,10,10,150) )
  draw.RoundedBoxOutlined( 2, 0, 0, w, 25, Color(30, 30, 30, 200), Color(20,20,20,150) )
end

function SKIN:PaintPanel(self, w, h)

end

function SKIN:PaintShadow() end

-- Buttons    
function SKIN:PaintButton(self, w, h)
  if (not self.m_bBackground) then return end

  self.m_intAlpha = 255
  self.m_colWhite = Color( 255, 255, 255, 255 )
  self.m_colWhiteT = Color( 255, 255, 255, 100 )
  self.m_colGrey = Color( 100, 100, 100, 255 )
  self.m_intAlphaOverride = int
  self.m_colOverride = col
  self.m_colMouseOverOverride = col

  if self:GetDisabled() then
    if not self.m_colDisabled then
      surface.SetDrawColor( 40, 40, 40, self.m_intAlphaOverride or self.m_intAlpha *0.9 )
    else
      surface.SetDrawColor( self.m_colDisabled.r, self.m_colDisabled.g, self.m_colDisabled.b, self.m_colDisabled.a )
    end
    self:SetTextColor( color_white )
  elseif self.Depressed then
    if not self.m_colDepressed then
      surface.SetDrawColor( 55, 55, 55, self.m_intAlphaOverride or self.m_intAlpha *0.8 )
    else
      surface.SetDrawColor( self.m_colDepressed.r, self.m_colDepressed.g, self.m_colDepressed.b, self.m_colDepressed.a )
    end
    self:SetTextColor( color_white )
  elseif self.Hovered then
    if not self.m_colMouseOver then
      surface.SetDrawColor( 100, 100, 100, self.m_intAlphaOverride or self.m_intAlpha *0.7 )
    else
      surface.SetDrawColor( self.m_colMouseOver.r, self.m_colMouseOver.g, self.m_colMouseOver.b, self.m_colMouseOver.a )
    end
    self:SetTextColor( color_white )
  elseif self.m_bSelected then
    if not self.m_colSelected then
      surface.SetDrawColor( 100, 100, 100, self.m_intAlphaOverride or self.m_intAlpha *0.7 )
    else
      surface.SetDrawColor( self.m_colSelected.r, self.m_colSelected.g, self.m_colSelected.b, self.m_colSelected.a )
    end
    self:SetTextColor( color_white )
  else
    if not self.m_colColor then
      surface.SetDrawColor( 80, 80, 80, self.m_intAlphaOverride or self.m_intAlpha *0.6 )
    else
      surface.SetDrawColor( self.m_colColor.r, self.m_colColor.g, self.m_colColor.b, self.m_colColor.a )
    end
    self:SetTextColor( color_white )
  end

  surface.DrawRect( 0, 0, w, h )

  if self.m_matIcon then
    surface.SetDrawColor( 255, 255, 255, 255 )
    surface.SetMaterial( self.m_matIcon )
    surface.DrawTexturedRect( self.m_intTexX, self.m_intTexY, self.m_intTexW or w, self.m_intTexH or h )
  end

  if (not self.fontset) then
    self:SetFont('rp.ui.17')
    self.fontset = true
  end
end

function SKIN:PaintAvatarImage(self, w, h)
  if self.Hovered then
    draw.Box(0, 0, w, h, color_hover)
  end
end


-- Close Button                                               
function SKIN:PaintWindowCloseButton(panel, w, h)
  surface.SetDrawColor( panel.Hovered and Color(210,100,100,100) or Color(180,100,100,80) )
  surface.DrawRect(1, h*0.09, w, h/1.3)
  draw.SimpleText( "r", "Marlett", w / 2, 10, panel.Hovered and color_white or color_gray, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
end

-- btnMaxim
-- btnMinim

-- Scrollbar
function SKIN:PaintVScrollBar(self, w, h) end
function SKIN:PaintButtonUp(self, w, h) end
function SKIN:PaintButtonDown(self, w, h) end
function SKIN:PaintButtonLeft(self, w, h) end
function SKIN:PaintButtonRight(self, w, h) end

function SKIN:PaintScrollBarGrip(self, w, h)
  --draw.Box(0, 0, w, h, color_sup)
end

function SKIN:PaintScrollPanel(self, w, h)
  draw.OutlinedBox(0, 0, w, h, color_background, color_outline)
end

function SKIN:PaintUIScrollBar(self, w, h)
--  draw.Box(0, self.scrollButton.y, w, self.height, color_outline)
end


-- Slider
function SKIN:PaintUISlider(self, w, h)
  SKIN:PaintPanel(self, w, h)
  -- draw.Box(1, 1, self:GetValue() * w - self:GetValue() * 16, h - 2, Color(220,220,220,150))
end


-- Text Entry
function SKIN:PaintTextEntry(self, w, h)
  draw.OutlinedBox(0, 0, w, h, color_offwhite, color_outline)

  self:DrawTextEntryText(color_black, color_sup, color_black)
end


-- List View
function SKIN:PaintUIListView(self, w, h) 
  draw.OutlinedBox(0, 0, w, h, color_offwhite, color_outline)
end


function SKIN:PaintListView(self, w, h) 
  draw.OutlinedBox(0, 0, w, h, color_offwhite, color_outline)
end

function SKIN:PaintListViewLine(self, w, h) -- todo, just make a new control and never use this
  for k, v in ipairs(self.Columns) do
    if (self:IsSelected() or self:IsHovered()) then
      v:SetTextColor(color_black)
    else
      v:SetTextColor(color_white)
    end
  end
end


-- Checkbox
function SKIN:PaintCheckBox(self, w, h)
  draw.OutlinedBox(0, 0, w, h, color_background, (self:GetChecked() and color_outline or color_outline))

  if self:GetChecked() then 
    draw.Box(4, 4, w - 8, h - 8, color_white)
  end
end


-- Tabs
function SKIN:PaintTabButton(self, w, h)
  self:SetTextColor(color_white)
  draw.Box(1, 0, w, h, Color(150,150,150,150))
  if self.Hovered then
    draw.Box(1, 0, w, h, Color(100,100,100,100))
  else
    draw.Box(1, 0, w, h, Color(60,60,60,150))
  end
end

function SKIN:PaintTabListPanel(self, w, h)

end


-- ComboBox
function SKIN:PaintComboBox(self, w, h)
  if IsValid(self.Menu) and (not self.Menu.SkinSet) then
    self.Menu:SetSkin('core')
    self.Menu.SkinSet = true
  end

  self:SetTextColor(((self.Hovered or self.Depressed or self:IsMenuOpen()) and color_black or color_white))

  draw.OutlinedBox(0, 0, w, h, ((self.Hovered or self.Depressed or self:IsMenuOpen()) and color_button_hover or color_background), color_outline)
end

function SKIN:PaintComboDownArrow(self, w, h)
  surface.SetDrawColor(color_sup)
  draw.NoTexture()
  surface.DrawPoly({
    {x = 0, y = w * .5},
    {x = h, y = 0},
    {x = h, y = w}
  })
end


-- -- DMenu
function SKIN:PaintMenu(self, w, h)
end

function SKIN:PaintMenuOption(self, w, h)
  if (not self.FontSet) then
    self:SetFont("rp.ui.18")
    self:SetTextInset(5, 0)
    self.FontSet = true
  end
  
  self:SetTextColor(color_white)
  draw.RoundedBox(0, 0, 0, w, h, Color(70,70,70,200))
  if self.m_bBackground and (self.Hovered or self.Highlight) then
    draw.OutlinedBox(0, 0, w, h - 1, Color(70,70,70,200),Color(180,180,180,50))
    self:SetTextColor(color_button_hover)
  end
end


-- DPropertySheet
local propbackground = Color(200, 200, 200)
local prophovered = rp.ui.col.ButtonHover

function SKIN:PaintPropertySheet(self, w, h)
  -- draw.RoundedBox(5, 0, 0, w, h*20, Color(40,40,0,40))
end

function SKIN:PaintTab(self, w, h)
  self:SetFont("rp.ui.18")
  local active = self:GetPropertySheet():GetActiveTab() == self
  
  if (active) then
   self:SetTextColor(propactive)
   draw.RoundedBox(0, 0, 2, w-5, 28, Color(60,60,60,200))
   surface.SetDrawColor(Color(60,60,60))
   surface.DrawOutlinedRect(0, 0, w-5, 0)
 elseif (self:IsHovered()) then
   draw.RoundedBox(0, 0, 2, w-5, 28, Color(60,60,60,200))
   surface.SetDrawColor(Color(60,60,60))
   surface.DrawOutlinedRect(0, 0, w-5, 0)
  end
end

derma.DefineSkin('core', 'core derma skin', SKIN)


local NoteSKIN  = {
  PrintName   = 'Note',
  Author    = 'Kirussell'
}

-- Frames    
function NoteSKIN:PaintFrame(self, w, h)
  draw.StencilBlur(self, w, h)

  draw.RoundedBoxOutlined( 2, 0,0, w, h, Color(50, 50, 50, 150), Color(10,10,10,150) )
  draw.RoundedBoxOutlined( 2, 0, 0, w, 25, Color(30, 30, 30, 200), Color(20,20,20,150) )
end

function NoteSKIN:PaintPanel(self, w, h)

end

function NoteSKIN:PaintShadow() end

-- Buttons    
function NoteSKIN:PaintButton(self, w, h)
  if (not self.m_bBackground) then return end

  self.m_colColor = col
  self.m_colMouseOver = col
  self.m_colDisabled = col
  self.m_colDepressed = col
  self.m_intAlpha = 255
  self.m_colWhite = Color( 255, 255, 255, 255 )
  self.m_colWhiteT = Color( 255, 255, 255, 100 )
  self.m_colGrey = Color( 100, 100, 100, 255 )
  self.m_intAlphaOverride = int
  self.m_colOverride = col
  self.m_colMouseOverOverride = col

  if self:GetDisabled() then
    if not self.m_colDisabled then
      surface.SetDrawColor( 40, 40, 40, self.m_intAlphaOverride or self.m_intAlpha *0.9 )
    else
      surface.SetDrawColor( self.m_colDisabled.r, self.m_colDisabled.g, self.m_colDisabled.b, self.m_colDisabled.a )
    end
    self:SetTextColor( color_white )
  elseif self.Depressed then
    if not self.m_colDepressed then
      surface.SetDrawColor( 55, 55, 55, self.m_intAlphaOverride or self.m_intAlpha *0.8 )
    else
      surface.SetDrawColor( self.m_colDepressed.r, self.m_colDepressed.g, self.m_colDepressed.b, self.m_colDepressed.a )
    end
    self:SetTextColor( color_white )
  elseif self.Hovered then
    if not self.m_colMouseOver then
      surface.SetDrawColor( 100, 100, 100, self.m_intAlphaOverride or self.m_intAlpha *0.7 )
    else
      surface.SetDrawColor( self.m_colMouseOver.r, self.m_colMouseOver.g, self.m_colMouseOver.b, self.m_colMouseOver.a )
    end
    self:SetTextColor( color_white )
  elseif self.m_bSelected then
    if not self.m_colSelected then
      surface.SetDrawColor( 100, 100, 100, self.m_intAlphaOverride or self.m_intAlpha *0.7 )
    else
      surface.SetDrawColor( self.m_colSelected.r, self.m_colSelected.g, self.m_colSelected.b, self.m_colSelected.a )
    end
    self:SetTextColor( color_white )
  else
    if not self.m_colColor then
      surface.SetDrawColor( 80, 80, 80, self.m_intAlphaOverride or self.m_intAlpha *0.6 )
    else
      surface.SetDrawColor( self.m_colColor.r, self.m_colColor.g, self.m_colColor.b, self.m_colColor.a )
    end
    self:SetTextColor( color_white )
  end

  surface.DrawRect( 0, 0, w, h )

  if self.m_matIcon then
    surface.SetDrawColor( 255, 255, 255, 255 )
    surface.SetMaterial( self.m_matIcon )
    surface.DrawTexturedRect( self.m_intTexX, self.m_intTexY, self.m_intTexW or w, self.m_intTexH or h )
  end

  if (not self.fontset) then
    self:SetFont('rp.ui.24')
    self.fontset = true
  end
end

function NoteSKIN:PaintAvatarImage(self, w, h)
  if self.Hovered then
    draw.Box(0, 0, w, h, color_hover)
  end
end


-- Close Button                                               
function NoteSKIN:PaintWindowCloseButton(panel, w, h)
  surface.SetDrawColor( panel.Hovered and Color(210,100,100,100) or Color(180,100,100,80) )
  surface.DrawRect(1, h*0.09, w, h/1.3)
  draw.SimpleText( "r", "Marlett", w / 2, 10, panel.Hovered and color_white or color_gray, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
end

-- btnMaxim
-- btnMinim

-- Scrollbar
function NoteSKIN:PaintVScrollBar(self, w, h) end
function NoteSKIN:PaintButtonUp(self, w, h) end
function NoteSKIN:PaintButtonDown(self, w, h) end
function NoteSKIN:PaintButtonLeft(self, w, h) end
function NoteSKIN:PaintButtonRight(self, w, h) end

function NoteSKIN:PaintScrollBarGrip(self, w, h)
  --draw.Box(0, 0, w, h, color_sup)
end

function NoteSKIN:PaintScrollPanel(self, w, h)
  draw.OutlinedBox(0, 0, w, h, color_background, color_outline)
end

function NoteSKIN:PaintUIScrollBar(self, w, h)
--  draw.Box(0, self.scrollButton.y, w, self.height, color_outline)
end


-- Slider
function NoteSKIN:PaintUISlider(self, w, h)
  NoteSKIN:PaintPanel(self, w, h)
  -- draw.Box(1, 1, self:GetValue() * w - self:GetValue() * 16, h - 2, Color(220,220,220,150))
end


-- Text Entry
function NoteSKIN:PaintTextEntry(self, w, h)
  -- draw.OutlinedBox(0, 0, w, h, color_offwhite, color_outline)

  self:DrawTextEntryText(color_white, color_sup, color_white)
end


-- List View
function NoteSKIN:PaintUIListView(self, w, h) 
  draw.OutlinedBox(0, 0, w, h, color_offwhite, color_outline)
end


function NoteSKIN:PaintListView(self, w, h) 
  draw.OutlinedBox(0, 0, w, h, color_offwhite, color_outline)
end

function NoteSKIN:PaintListViewLine(self, w, h) -- todo, just make a new control and never use this
  for k, v in ipairs(self.Columns) do
    if (self:IsSelected() or self:IsHovered()) then
      v:SetTextColor(color_black)
    else
      v:SetTextColor(color_white)
    end
  end
end


-- Checkbox
function NoteSKIN:PaintCheckBox(self, w, h)
  draw.OutlinedBox(0, 0, w, h, color_background, (self:GetChecked() and color_outline or color_outline))

  if self:GetChecked() then 
    draw.Box(4, 4, w - 8, h - 8, color_white)
  end
end


-- Tabs
function NoteSKIN:PaintTabButton(self, w, h)
  self:SetTextColor(color_white)
  draw.Box(1, 0, w, h, Color(150,150,150,150))
  if self.Hovered then
    draw.Box(1, 0, w, h, Color(100,100,100,100))
  else
    draw.Box(1, 0, w, h, Color(60,60,60,150))
  end
end

function NoteSKIN:PaintTabListPanel(self, w, h)

end


-- ComboBox
function NoteSKIN:PaintComboBox(self, w, h)
  if IsValid(self.Menu) and (not self.Menu.NoteSKINSet) then
    self.Menu:SetNoteSKIN('core')
    self.Menu.NoteSKINSet = true
  end

  self:SetTextColor(((self.Hovered or self.Depressed or self:IsMenuOpen()) and color_black or color_white))

  draw.OutlinedBox(0, 0, w, h, ((self.Hovered or self.Depressed or self:IsMenuOpen()) and color_button_hover or color_background), color_outline)
end

function NoteSKIN:PaintComboDownArrow(self, w, h)
  surface.SetDrawColor(color_sup)
  draw.NoTexture()
  surface.DrawPoly({
    {x = 0, y = w * .5},
    {x = h, y = 0},
    {x = h, y = w}
  })
end


-- -- DMenu
function NoteSKIN:PaintMenu(self, w, h)
end

function NoteSKIN:PaintMenuOption(self, w, h)
  if (not self.FontSet) then
    self:SetFont("rp.ui.18")
    self:SetTextInset(5, 0)
    self.FontSet = true
  end
  
  self:SetTextColor(color_white)
  draw.RoundedBox(0, 0, 0, w, h, Color(70,70,70,200))
  if self.m_bBackground and (self.Hovered or self.Highlight) then
    draw.OutlinedBox(0, 0, w, h - 1, Color(70,70,70,200),Color(180,180,180,50))
    self:SetTextColor(color_button_hover)
  end
end


-- DPropertySheet
local propbackground = Color(200, 200, 200)
local prophovered = rp.ui.col.ButtonHover

function NoteSKIN:PaintPropertySheet(self, w, h)
  -- draw.RoundedBox(5, 0, 0, w, h*20, Color(40,40,0,40))
end

function NoteSKIN:PaintTab(self, w, h)
  self:SetFont("rp.ui.18")
  local active = self:GetPropertySheet():GetActiveTab() == self
  
  if (active) then
   self:SetTextColor(propactive)
   draw.RoundedBox(0, 0, 2, w-5, 28, Color(60,60,60,200))
   surface.SetDrawColor(Color(60,60,60))
   surface.DrawOutlinedRect(0, 0, w-5, 0)
 elseif (self:IsHovered()) then
   draw.RoundedBox(0, 0, 2, w-5, 28, Color(60,60,60,200))
   surface.SetDrawColor(Color(60,60,60))
   surface.DrawOutlinedRect(0, 0, w-5, 0)
  end
end

derma.DefineSkin('note', 'note derma skin', NoteSKIN)


