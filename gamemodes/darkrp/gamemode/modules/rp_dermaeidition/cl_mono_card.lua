local CARD = {}

local glowMat = Material( "particle/Particle_Glow_04_Additive" )
local BUTTON_COLOR = Color( 45, 45, 45, 225 )

function CARD:Init()
    self:Dock( TOP )
    self:SetTall( 96 )

    self.buttonColor = Color( 200, 200, 200 )
end

function CARD:SetColor( color )
    self.buttonColor = color or self.buttonColor
end

function CARD:GetColor()
    return self.buttonColor
end

function CARD:Paint( w, h )
    draw.RoundedBox( 0, 2, 2, w - 4, h - 4, BUTTON_COLOR )

    local outlineColor = self.buttonColor
    outlineColor = Color( outlineColor.r, outlineColor.g, outlineColor.b, self:IsDown() and 90 or self:IsHovered() and 60 or 30 )

    surface.SetDrawColor( outlineColor )
    surface.SetMaterial( glowMat )
    surface.DrawTexturedRect( ( 0 - ( w / 3 ) ), ( 0 - ( h / 3 ) ), ( w * 3 ), ( h * 3 ) )
end

vgui.Register( "monoCard", CARD, "monoButton" )
