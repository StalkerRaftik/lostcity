-- IDEA: Presets and 76561198059738127

local easynet = SH_WHITELIST.easynet

local function L(...) return SH_WHITELIST:L(...) end

function SH_WHITELIST:OpenFactions(changing)
	self:RemoveIfValid(_SH_WHITELIST_FACTIONS)

	local m = self:GetMargin()
	local m2 = m * 0.5
	local ss = self:GetScreenScale()
	local styl = self.Style

	local wi, he = 600 * self.WidthMultiplier * ss, 400 * self.HeightMultiplier * ss
	local iconsize, layoutdir

	if (self.FactionsLayout == 0) then
		iconsize = 256 * ss
		layoutdir = LEFT

		wi = iconsize * #self.FactionsList + m * 3
		he = 48 * ss + iconsize + m * 2.5 + draw.GetFontHeight("SH_WHITELIST.Large") * 3
	else
		iconsize = 64 * ss + m
		layoutdir = TOP
	end

	local layout_left = self.FactionsLayout == 0
	local layout_top = self.FactionsLayout == 1

	local selplayer, selid, selusg

	local wnd, body = self:MakeWindow(L"choose_your_faction", m)
	wnd:ShowCloseButton(changing or false)
	wnd:SetSize(wi, he)
	wnd:Center()
	wnd:MakePopup()
	_SH_WHITELIST_FACTIONS = wnd

		local scroll = vgui.Create("DScrollPanel", body)
		scroll:SetTall(iconsize)
		scroll:Dock(TOP)
		scroll:DockMargin(0, 0, 0, m2)
		self:PaintScroll(scroll)

			local factlist = vgui.Create("DIconLayout", scroll)
			factlist:SetLayoutDir(layoutdir)
			factlist:SetSpaceX(m)
			factlist:SetSpaceY(m)
			factlist:Dock(FILL)

		local scroll2 = vgui.Create("DScrollPanel", body)
		scroll2:Dock(FILL)
		self:PaintScroll(scroll2)

			local desc = self:QuickLabel("", "{prefix}Large", styl.text, scroll2)
			desc:SetContentAlignment(5)
			desc:SetWrap(true)
			desc:SetAutoStretchVertical(true)
			desc:SetWide(wi - m * 2)

		if (layout_top) then
			scroll:Dock(FILL)
			scroll2:Dock(BOTTOM)
			scroll2:SetTall(draw.GetFontHeight("SH_WHITELIST.Large") * 3)
		end

		for id, fact in pairs (self.FactionsList) do
			if (fact.CanJoin and !fact.CanJoin(LocalPlayer())) then
				continue end
		
			local btn = self:QuickButton("", function()
				easynet.SendToServer("SH_WHITELIST.FactionChosen", {id = id})
				wnd:Close()
			end, factlist)
			btn:SetSize(layout_left and iconsize or desc:GetWide(), iconsize)

				if (fact.IconURL ~= "") then
					local mat = self:GetDownloadedImage(fact.IconURL)
					if (!mat) then
						self:DownloadImage(fact.IconURL, function(newmat)
							mat = newmat
						end)
					end

					local logo = vgui.Create("DPanel", btn)
					logo:SetMouseInputEnabled(false)
					logo:Dock(layout_top and LEFT or FILL)
					logo.Paint = function(me, w, h)
						if (!mat) then
							return end

						local is = math.min(w, h)
						surface.SetMaterial(mat)
						surface.SetDrawColor(color_white)
						surface.DrawTexturedRectRotated(w * 0.5, h * 0.5, is, is, 0)
					end

					if (layout_left) then
						logo:DockMargin(m2, m2, m2, 0)
					end
				else
					local logo = self:QuickLabel(fact.Name[1], "{prefix}3D", fact.Color, btn)
					logo:Dock(FILL)
					logo:SetContentAlignment(5)
				end

				local name = self:QuickLabel(fact.Name, "{prefix}Larger", fact.Color, btn)
				name:SetContentAlignment(5)
				if (layout_left) then
					name:Dock(BOTTOM)
					name:DockMargin(0, m2, 0, 0)
				else
					name:Dock(FILL)
				end

				btn:DockPadding(m2, m2, m2, m2)
				btn.OnCursorEntered = function(me)
					me.Hovered = true

					surface.SetFont("SH_WHITELIST.Large")
					local wi, he = surface.GetTextSize(fact.Description)

					desc:Stop()
					desc:SetWrap(wi > scroll2:GetWide())
					desc:SetText(fact.Description)
					desc:AlphaTo(255, 0.1)
				end
				btn.OnCursorExited = function(me)
					me.Hovered = false

					desc:Stop()
					desc:AlphaTo(0, 0.1, 0, function(me)
						desc:SetText("")
					end)
				end
		end

	wnd:SetAlpha(0)
	wnd:AlphaTo(255, 0.2)

	if (self.FactionsBackgroundBlur) then
		wnd.m_fCreateTime = SysTime()
	end
end