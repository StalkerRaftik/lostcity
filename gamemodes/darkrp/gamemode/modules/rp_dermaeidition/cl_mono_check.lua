local TG = { }
AccessorFunc(TG , "TG" , "Toggled" , FORCE_BOOL)

function TG:Init()
    self:SetText("")
end

function TG:Paint(_ , h)
    surface.SetDrawColor(100 , 100 , 100)
    surface.DrawOutlinedRect(1 , 1 , 64 , h - 2)
    surface.SetDrawColor(25 , 25 , 25)
    surface.DrawRect(2 , 2 , 62 , h - 4)

    if (self:GetToggled()) then
        surface.SetDrawColor(Color(46 , 204 , 113))
        surface.DrawRect(2 + 31 , 2 , 31 , h - 4)
        surface.SetDrawColor(Color(0 , 0 , 0 , 50))
        surface.DrawRect(2 , h - 6 , 31 , 4)
    else
        surface.SetDrawColor(Color(230 , 126 , 34))
        surface.DrawRect(2 , 2 , 31 , h - 4)
        surface.SetDrawColor(Color(0 , 0 , 0 , 50))
        surface.DrawRect(2 , h - 6 , 31 , 4)
    end

    if (self.Disabled) then
        surface.SetDrawColor(0,0,0,200)
        surface.DrawRect(2,2,62,h-4)
    end

    draw.SimpleText(self.Text or "Label" , 'rp.ui.22' , 72 , h / 2 , rp.col.white , TEXT_ALIGN_LEFT , TEXT_ALIGN_CENTER)
end

function TG:DoClick()
    if(not self.Disabled) then
        self:SetToggled(not self:GetToggled())
        self:OnValueChange(self:GetToggled())
    end
end

function TG:OnValueChange()
end

function TG:SetDisabled(b)
    self.Disabled = b
end

vgui.Register("monoCheck" , TG , "DButton")

local CHECK = {}

local ENABLED_COLOR = Color( 46, 204, 113, 150 )
local DISABLED_COLOR = Color( 204, 46, 46, 150 )

function CHECK:Paint( w, h )
    draw.RoundedBox( 0, 2, 2, w - 4, h - 4, Color( 60, 60, 60, 150 ) )

    local halfWidth = w / 2
    if self:GetChecked() then
        surface.SetDrawColor( ENABLED_COLOR )
        surface.DrawRect( halfWidth + 2, 2, halfWidth - 4, h - 4 )
    else
        surface.SetDrawColor( DISABLED_COLOR )
        surface.DrawRect( 2, 2, halfWidth - 2, h - 4 )
    end
    if (self.Disabled) then
        surface.SetDrawColor(0,0,0,150)
        surface.DrawRect(2,2,w-4,h-4)
    end
end

function CHECK:ReadOnly(b)
    self.Disabled = b
end

vgui.Register( "monoCheckBox", CHECK, "DCheckBox" )
