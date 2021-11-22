
local PANEL = {}

function PANEL:Init()

end

function PANEL:SetBackground(bool)
    self.DrawBackground = bool
end

function PANEL:SetFadedBackground(bool)
    self.FadedBackground = bool
end

local gradient = Material( "gui/gradient" )
function PANEL:Paint(w, h)
    if self.DrawBackground == false then return end

    -- if not self.FadedBackground then
        -- draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 150))
    -- else
    --     surface.SetDrawColor( Color( 0, 0, 0, 100 ) )
    --     surface.SetMaterial( gradient )
    --     surface.DrawTexturedRect( 0, 0, w, h )

    --     surface.SetDrawColor( Color( 50, 50, 50, 50 ) )
    --     surface.SetMaterial( gradient )
    --     surface.DrawTexturedRect( 0, - w / 2, w * 2, h )
    -- end
end

vgui.Register("monoPanel", PANEL, "DPanel")
