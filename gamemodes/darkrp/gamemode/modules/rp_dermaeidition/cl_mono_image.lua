local BUTTON = {}

local ALPHA = 255
local COLOR_WHITE = Color( 255, 255, 255, ALPHA )
local COLOR_BLACK = Color( 0, 0, 0, 150 )

local glowMat = Material( "particle/Particle_Glow_04_Additive" )

function BUTTON:Init()
    self:SetText( "" )

    self.active = false
end

function BUTTON:SetColor( color )
    self.drawColor = color
end

function BUTTON:SetImage( image )
    self.image = image
end

function BUTTON:SetActive( bool )
    self.active = bool
end

function BUTTON:GetActive()
    return self.active
end

function BUTTON:SetActiveColor( color )
    self.activeColor = color
end

function BUTTON:GetActiveColor()
    return self.activeColor
end

function BUTTON:SetGlowColor( color )
    self.glowColor = color
end

function BUTTON:GetGlowColor()
    return self.glowColor
end

BUTTON.SetMaterial = BUTTON.SetImage

function BUTTON:Paint( w, h )
    if not self.image then
        draw.SimpleText( "?", 'rp.ui.32', w / 2, h / 2, rp.col.white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

        return
    end

    local color = self.active and ( self:GetActiveColor() or Color( 235, 235, 235 ) ) or self.drawColor or rp.col.white
    color = Color( color.r, color.g, color.b, self.active and 255 or self:IsDown() and 255 or self:IsHovered() and 200 or 100 )

    local glowColor = self.glowColor or Color( 0, 125, 255 )

    surface.SetDrawColor( Color( glowColor.r, glowColor.g, glowColor.b, 50 ) )
    surface.SetMaterial( glowMat )
    surface.DrawTexturedRect( ( 0 - ( w / 3 ) ) , ( 0 - ( h / 3 ) ) , ( w * 3 ) , ( h * 3 ) )

    surface.SetDrawColor( color )
    surface.SetMaterial( self.image )
    surface.DrawTexturedRect( 10, 10, w - 20, h - 20 )
end

vgui.Register( "monoImage", BUTTON, "DButton" )
