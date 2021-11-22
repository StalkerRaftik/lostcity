
local FRAME_HEADER_FONT = 'font_base'
local FRAME_HEADER_HEIGHT = 40

local HEADER = {}

function HEADER:Init()
    self:Dock(TOP)
    self:SetTall(FRAME_HEADER_HEIGHT)

    self.text = self:Add("DLabel")
    self.text:Dock(FILL)
    self.text:SetText("")
    self.text:SetFont(FRAME_HEADER_FONT)
    self.text:SetContentAlignment(1)
    self.text:SetTextColor(rp.col.white)

    self:SetExpensiveShadow(2, Color(0, 0, 0, 125))
end

function HEADER:SetContentAlignment( alignment )
    self.text:SetContentAlignment( alignment )
end

function HEADER:SetText(text)
    self.text:SetText(text)
end

function HEADER:SetColor(color)
    self.text:SetTextColor(color)
end

function HEADER:SetFont(font)
    self.text:SetFont(font)
end

function HEADER:SetExpensiveShadow(distance, color)
    self.text:SetExpensiveShadow(distance, color)
end

vgui.Register("monoHeader", HEADER, "Panel")
