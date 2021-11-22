
local PANEL = {}

--[[
    monoCollapsePanel

    functions:
        SetText( text ) - sets the header's text
        SetHeaderSize( w, h ) - sets the header's size
            SetHeaderWidth( w )
            SetHeaderHeight( h )
        SetFont( font ) - sets the header's font
        SetContents( panel ) - Sets a panel to be inside of the collapse panel
]]--

function PANEL:Init()
    self:SetTall( 128 ) -- Default size is 128

    self.header = self:Add( "monoButton" )
    self.header:Dock( TOP )
    self.header:SetTall( 32 )
    self.header:SetActive( true )

    self.active = true
    self.animationTime = 0.5

    self.header.DoClick = function( this )
        if self.active then
            self.desiredHeight = self:GetTall()
        end

        self:SizeTo( self:GetWide(), self.active and self.header:GetTall() or self.desiredHeight, self:GetAnimateTime(), 0, -1, function()
            self.active = not self.active
        end )
    end

    self.contents = self:Add( "monoPanel" )
    self.contents:Dock( FILL )
end

function PANEL:SetAnimateTime( time )
    self.animationTime = time
end

function PANEL:GetAnimateTime()
    return self.animationTime
end

function PANEL:SetText( text )
    return self.header:SetText( text )
end

function PANEL:SetHeaderSize( w, h )
    return self.header:SetSize( w, h )
end

function PANEL:SetHeaderWidth( w )
    return self.header:SetWide( w )
end

function PANEL:SetHeaderHeight( h )
    return self.header:SetTall( h )
end

function PANEL:SetFont( font )
    return self.header:SetFont( font )
end

function PANEL:SetContents( panel )
    panel:SetParent( self.contents )

    self:InvalidateLayout()
end

function PANEL:Paint() end

vgui.Register( "monoCollapsePanel", PANEL, "Panel" )
