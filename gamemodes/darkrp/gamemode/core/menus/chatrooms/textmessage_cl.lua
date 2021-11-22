local PANEL = {}

PANEL.ColorSent = rp.col.ButtonHovered
PANEL.ColorReceived = Color(50, 130, 50)

function PANEL:Init()
  self.Aligned = 0 -- 0 = left, 1 = right

  self.Sender = nil
  self.Text = {}
end

function PANEL:SetSender(pl) -- will automatically add a label above the main portion with name, steamid
  self.Sender = ui.Create("DLabel", function(lbl)
    lbl:SetFont("rp.ui.15")
    lbl:SetTextColor(Color(0, 0, 0))
	if (type(pl) == 'string') then
		lbl:SetText(pl)
	else
		lbl:SetText(((!pl or pl == LocalPlayer()) and 'Me') or pl:NameID())
	end
    lbl:SizeToContents()

    if (!pl or pl == LocalPlayer()) then
      self.Aligned = 1
    end
  end, self:GetParent())
end

function PANEL:SetText(text)
  local y = 3--self.Sender and self.Sender:GetTall() + 3 or 3

  self.Text = string.Wrap('rp.ui.22', text, self:GetWide() - 10)

  local shouldBreak = false
  for k, v in ipairs(self.Text) do
    self.Text[k] = ui.Create("DLabel", function(lbl)
      lbl:SetText(v)
      lbl:SizeToContents()
      lbl:SetPos(5, y)

      y = y + lbl:GetTall()

      if (k == 1 and #self.Text == 2 and #self.Text[2] == 0) then
		self:SetWide(lbl:GetWide() + 10)
		self:SetTall(y + 3)
		lbl:SetPos(7, lbl.y + 1)
        shouldBreak = true
      end
    end, self)

    if (shouldBreak) then return end
  end

  self:SetTall(y + 3)
end

function PANEL:HandleAlignment()
  if (self.Aligned == 1) then
    self:SetPos(self:GetParent():GetWide() - self:GetWide() - 5, self.Sender and self.Sender:GetTall() or 3);
  else
    self:SetPos(5, self.Sender and self.Sender:GetTall() or 3)
  end

  if (self.Sender) then
    self.Sender:SetPos((self.Aligned == 1 and self:GetParent():GetWide() - self.Sender:GetWide() - 7) or 5, 1)
  end
end

function PANEL:Paint(w, h)
  if (!self.Text[1]) then return end

  local y = self.Text[1].y - 2
  h = h - y

  draw.RoundedBox(6, 0, y, w, h, color_white)
  if (self.Aligned == 1) then
    draw.RoundedBox(6, 1, y + 1, w - 2, h - 2, self.ColorSent)
  else
    draw.RoundedBox(6, 1, y + 1, w - 2, h - 2, self.ColorReceived)
  end
end

vgui.Register('rp_textmessage', PANEL, 'Panel')