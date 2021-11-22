
local FRAME = {}

function FRAME:Init()
    self:StretchToParent( 0, 0, 0, 0 )
    self:SetTitle( "" )
    self:ShowCloseButton( true )

    self.startTime = CurTime()

    -- Add "CLOSE X"
    -- self:ShowQuit()

    self.Logo = self:DrawLogo()

end

function FRAME:HideQuit()
    if IsValid( self.QuitButton ) then self.QuitButton:Remove() end
end

function FRAME:ShowQuit()
    self:HideQuit()

    self.QuitButton = self:Add( "monoButton" )
    self.QuitButton:SetSize( 96, 32 )
    self.QuitButton:SetPos( self:GetWide() - self.QuitButton:GetWide(), 0 )
    self.QuitButton:SetText( "✕" )
    self.QuitButton.DoClick = function()
        self:Close()
    end
end

function FRAME:DrawLogo()
 --   return rp.UI.DrawLogo( self )
end

local MAT_SHADOWS = Material( "gui/gradient", "noclamp smooth" )
local MAT_BACKGROUND = Material( "gui/gradient", "noclamp smooth" )
local MAT_VIGNETTE = Material( "gui/gradient" , "noclamp smooth" )

function FRAME:Paint( w, h )
    self.Alpha = Lerp( FrameTime() * 6, self.Alpha or ( self.StartingAlpha or 0 ), self.TargetAlpha or 150 )

    draw.RoundedBox(0,0,0,w,h,Color(40, 40, 40, 150))
    draw.RoundedBox(0,0,0,w,h*0.03,Color(60, 60, 60, 150))
end

vgui.Register( "monoFrame", FRAME, "DFrame" )
