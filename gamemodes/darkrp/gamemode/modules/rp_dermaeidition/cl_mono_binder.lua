local BINDER = {}

function BINDER:Init()
    self:SetWide( 100 )
    self:SetFont( 'font_base_24' )
    self:SetTextColor( color_white )
end

function BINDER:Paint( w, h )
    draw.RoundedBox( 0, 2, 2, w - 4, h - 4, Color( 60, 60, 60, 150 ) )
end

vgui.Register( "monoBinder", BINDER, "DBinder" )
