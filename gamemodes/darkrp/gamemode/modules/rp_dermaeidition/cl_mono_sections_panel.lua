
local PANEL = {}

local gradient = Material("gui/gradient")

function PANEL:Init()
    self:GetParent():InvalidateParent( true )
    self:InvalidateParent( true )
end

function PANEL:Setup()
    self.sectionContainer = self:Add( "monoPanel" )
    self.sectionContainer:Dock( RIGHT )
    self.sectionContainer:DockMargin( 0, 38, 0, 0 )
    self.sectionContainer:DockPadding( 0, 5, 0, 0 )
    self.sectionContainer:SetWide( 100 )
    self.sectionContainer:SetBackground( false )
    self.sectionContainer:InvalidateParent( true )

    self.sectionContainer.Paint = function( this, w, h )
        --draw.OutlinedBox( 0, 0, w, h, 2, Color( 0, 0, 0, 100 ), Color( 0, 0, 0, 100 ) )
        --draw.RoundedBox( 0, 2, 2, w - 4, h -4, Color( 0, 0, 0, 150 ) )

        surface.SetDrawColor( Color( 0, 0, 0, 160 ) )
        surface.SetMaterial( gradient )
        surface.DrawTexturedRect( 0, 0, w, h )

    end

	local headerColor = Color(255,255,255,255)

    self.sectionHeader = self:Add( "monoHeader" )
    self.sectionHeader:SetText( "" )
    self.sectionHeader:SetFont( 'rp.ui.40' )
    self.sectionHeader:DockMargin( 15, 8, 0, 0 )
    self.sectionHeader:SetContentAlignment( 4 )
    self.sectionHeader:SizeToContents()
    self.sectionHeader:InvalidateParent( true )
    self.sectionHeader:SetColor( headerColor )

    self.sectionSubHeader = self:Add( "monoHeader" )
    self.sectionSubHeader:DockMargin( 16, -12, 0, 0 )
    self.sectionSubHeader:SetColor( headerColor )
    self.sectionSubHeader:SetText( "" )
    self.sectionSubHeader:SetContentAlignment( 4 )
    self.sectionSubHeader:SetFont( 'rp.ui.24' )
    self.sectionSubHeader:SetWrap( true )
    self.sectionSubHeader:SizeToContents()

    self.contentScroll = self:Add( "monoPanel" )
    self.contentScroll:Dock( FILL )
    self.contentScroll:DockMargin( 8, 4, 0, 0 )
    self.contentScroll:SetBackground( false )
    self.contentScroll:InvalidateParent( true )

    self:InvalidateLayout()

    self.sections = {}
    self.buttons = {}
end

function PANEL:SetSubHeaderText( text )
    self.sectionSubHeader:SetTall( text == "" and 12 or 40 )
    self.sectionSubHeader:SetText( text )
end

function PANEL:OnClose()
    self:Remove()
end

function PANEL:SetSectionText( text )
    self.sectionHeader:SetText( text )
end


local glowMat = Material( "particle/Particle_Glow_04_Additive" )
function PANEL:AddSectionButton( data )
    local button = self.sectionContainer:Add( "monoImage" )
    button:Dock( data.extraData and data.extraData.bottom and BOTTOM or TOP )
    button:DockMargin( 0, 0, 0, 10 )
    button:SetTall( 64 )
    button:SetImage( data.icon )

    if data.extraData and data.extraData.glowColor then
        button:SetGlowColor( data.extraData.glowColor )
    end

    button.DoClick = function( this )
        self:OpenSection( data )
    end

    button.LerpPos = 10
    button.Paint = function( self, w, h )
        local color = self.active and ( Color(0,0,0, 150)) or Color(20,0,0, 150)
        color = Color( color.r, color.g, color.b, self.active and 255 or self:IsDown() and 255 or self:IsHovered() and 200 or 150 )

        local glowColor = self.glowColor or Color( 0, 125, 255 )
        self.LerpPos = Lerp( FrameTime() * 6, self.LerpPos, self.active and 15 or 10 )

        -- local col = Color( 0, 0, 0, 200)
        -- if self:IsHovered() then
        --     col = Color(100,110,110, 150)
        -- end
        -- draw.RoundedBox(4, 0, 0, w, h, col)

        surface.SetDrawColor( Color(255,255,255) )
        surface.SetMaterial( self.image )
        surface.DrawTexturedRect( self.LerpPos, 0, 64, 64 )

       -- draw.ShadowSimpleText(data.name, 'rp.ui.36', w*0.25, h*0.2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
    end

    button.IsSection = true 

    self.buttons[ data.name ] = button

    if data.extraData and data.extraData.default then
        self:OpenSection( data )
    end

    return button
end

function PANEL:AddSection( name, icon, callback, canDo, extraData )
    local data = {
        name = name,
        icon = Material( icon ),
        callback = callback or function() end,
        canDo = canDo or function() return true end,
        extraData = extraData
    }

    if canDo and not canDo() then return end

    self.sections[ name ] = data
    return self:AddSectionButton( data )
end

function PANEL:GetSection( name )
    return self.sections[ name ]
end

function PANEL:OpenSection( nameOrData )
    local section = istable( nameOrData ) and nameOrData or self:GetSection( nameOrData )
    if not section then return end

    if not section.canDo() then return end

    local sectionButton = self.buttons[ section.name ]
    if not sectionButton then return end

    for _, button in pairs( self.buttons ) do
        if button == sectionButton then continue end

        button:SetActive( false )
    end

    sectionButton:SetActive( true )

    self.contentScroll:Clear()
    self.sectionHeader:SetText( section.name:upper() )
    self:SetSubHeaderText( section.extraData and section.extraData.subHeader or "" )

    return section.callback( self.contentScroll )
end

function PANEL:Paint( this, w, h )

end

vgui.Register( "monoSectionsPanel", PANEL, "Panel" )
