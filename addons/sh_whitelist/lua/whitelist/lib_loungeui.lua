/*
* About time I made a library for general use!
* You can copy this file for your own server/personal use.
* What you can't do is use it in a commercial project without my approval (add me at http://steamcommunity.com/id/shendow/)
* I won't provide much support if you run into trouble editing this file.
*/

local base_table = SH_WHITELIST
local font_prefix = "SH_WHITELIST."

--
local matClose = Material("shenesis/general/close.png", "noclamp smooth")
local th, m

local function get_scale()
	local sc = math.Clamp(ScrH() / 1080, 0.75, 1)
	if (!th) then
		th = 48 * sc
		m = th * 0.25
	end

	return sc
end

get_scale()

function base_table:L(s, ...)
	return string.format(self.Language[s] or s, ...)
end

function base_table:GetPadding()
	return th
end

function base_table:GetMargin()
	return m
end

function base_table:GetScreenScale()
	return get_scale()
end

function base_table:CreateFonts(scale)
	local font = self.Font
	local font_bold = self.FontBold

	local sizes = {
		[12] = "Small",
		[16] = "Medium",
		[20] = "Large",
		[24] = "Larger",
		[32] = "Largest",
		[200] = "3D",
	}

	for s, n in pairs (sizes) do
		surface.CreateFont(font_prefix .. n, {font = font, size = s * scale})
		surface.CreateFont(font_prefix .. n .. "B", {font = font_bold, size = s * scale})
	end
end

hook.Add("InitPostEntity", font_prefix .. "CreateFonts", function()
	base_table:CreateFonts(get_scale())
end)
local matBlurScreen = Material( "pp/blurscreen" )
function base_table:MakeWindow(title, border)
	local scale = get_scale()
	local styl = self.Style

	local pnl = vgui.Create("EditablePanel")
	pnl.m_bEscapeToClose = false
	pnl.m_bDraggable = true
	pnl.SetEscapeToClose = function(me, b)
		me.m_bEscapeToClose = b
	end
	pnl.SetDraggable = function(me, b)
		me.m_bDraggable = b
	end
	pnl.Think = function(me)
		if (me.m_bEscapeToClose and input.IsKeyDown(KEY_ESCAPE)) then
			me:Close()
			gui.HideGameUI()
			timer.Simple(0, gui.HideGameUI)
		end
	end
	pnl.Paint = function(self, w, h)
		-- if (me.m_fCreateTime) then
		-- 	Derma_DrawBackgroundBlur(me, me.m_fCreateTime)
		-- end

		-- draw.RoundedBox(0, 0, 0, w, h, styl.bg)
		if ( self.m_fCreateTime ) then
			Derma_DrawBackgroundBlur( self, self.m_fCreateTime )
		end

		local x, y = self:GetPos()

		surface.SetMaterial( matBlurScreen )
		surface.SetDrawColor( 255, 255, 255, 255 )

		for i = 1, 3 do
			matBlurScreen:SetFloat("$blur", i)
			matBlurScreen:Recompute()
			render.UpdateScreenEffectTexture()
			surface.DrawTexturedRect(-x, -y, ScrW(), ScrH())
		end

		-- background fill
		surface.SetDrawColor( Color(0,0,0,150) )
		surface.DrawRect(0, 0, w, h)

		-- title
		--surface.SetDrawColor( Color(20,40,70,255) )
		-- surface.SetDrawColor( Color(50,50,50,220) )
		-- surface.DrawRect(0, 0, w, 11 )
		--surface.SetDrawColor( Color(0,0,0,50) )
		--surface.DrawRect(0, 11, width, 11)	
	end
	pnl.OnClose = function() end
	pnl.Close = function(me)
		if (me.m_bClosing) then
			return end

		me.m_bClosing = true
		me:AlphaTo(0, 0.1, 0, function()
			me:Remove()
		end)
		me:OnClose()
	end

		local header = vgui.Create("BPanel", pnl)
		header:SetTall(th)
		header:Dock(TOP)
		header.Paint = function(me, w, h)
			-- draw.RoundedBoxEx(0, 0, 0, w, h, styl.header, true, true, false, false)
					surface.SetDrawColor( Color(50,50,50,220) )
		surface.DrawRect(0, 0, w, h )
		end
		header.Think = function(me)
			if (me.Hovered and pnl.m_bDraggable) then
				me:SetCursor("sizeall")
			end

			local drag = me.m_Dragging
			if (drag) then
				local mx, my = math.Clamp(gui.MouseX(), 1, ScrW() - 1), math.Clamp(gui.MouseY(), 1, ScrH() - 1)
				local x, y = mx - drag[1], my - drag[2]

				pnl:SetPos(x, y)
			end
		end
		header.OnMousePressed = function(me)
			if (pnl.m_bDraggable) then
				me.m_Dragging = {gui.MouseX() - pnl.x, gui.MouseY() - pnl.y}
				me:MouseCapture(true)
			end
		end
		header.OnMouseReleased = function(me)
			me.m_Dragging = nil
			me:MouseCapture(false)
		end
		pnl.m_Header = header

			local titlelbl = self:QuickLabel(title, font_prefix .. "Larger", styl.text, header)
			titlelbl:Dock(LEFT)
			titlelbl:DockMargin(m, 0, 0, 0)
			pnl.m_Title = titlelbl

			local close = vgui.Create("DButton", header)
			close:SetText("")
			close:SetWide(th)
			close:Dock(RIGHT)
			close.Paint = function(me, w, h)
				if (me.Hovered) then
					draw.RoundedBoxEx(4, 0, 0, w, h, styl.close_hover, false, true, false, false)
				end

				if (me:IsDown()) then
					draw.RoundedBoxEx(4, 0, 0, w, h, styl.hover, false, true, false, false)
				end
				draw.SimpleText( "r", "Marlett", w/2, h/2, me.Hovered and color_white or color_gray, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				-- surface.SetDrawColor(me:IsDown() and styl.text_down or styl.text)
				-- surface.SetMaterial(matClose)
				-- surface.DrawTexturedRectRotated(w * 0.5, h * 0.5, 16 * scale, 16 * scale, 0)
			end
			close.DoClick = function(me)
				pnl:Close()
			end
			pnl.m_Close = close

		local body = vgui.Create("BPanel", pnl)
		body:SetDrawBackground(false)
		body:Dock(FILL)
		if (border) then
			body:DockPadding(border, border, border, border)
		end

	pnl.SetTitle = function(me, text)
		titlelbl:SetText(text)
		titlelbl:SizeToContentsX()
	end
	pnl.AddHeaderButton = function(me, icon, callback)
		local btn = vgui.Create("BButton", header)
		btn:SetText("")
		btn:SetWide(self:GetPadding())
		btn:Dock(RIGHT)
		btn.Paint = function(me, w, h)
			if (me.Hovered) then
				surface.SetDrawColor(styl.hover)
				surface.DrawRect(0, 0, w, h)
			end

			surface.SetMaterial(icon)
			surface.SetDrawColor(styl.text)
			surface.DrawTexturedRect(w * 0.5 - 8, h * 0.5 - 8, 16, 16)
		end
		btn.DoClick = function()
			callback()
		end

		return btn
	end
	pnl.ShowCloseButton = function(me, b)
		me.m_Close:SetVisible(b)
	end

	return pnl, body
end

function base_table:QuickLabel(t, f, c, p)
	local l = vgui.Create("DLabel", p)
	l:SetText(t)
	l:SetFont("font_base_18")
	l:SetColor(c)
	l:SizeToContents()

	return l
end

function base_table:QuickButton(t, cb, p, f, c, a)
	p:SetMouseInputEnabled(true)

	local styl = self.Style
	local bg = a and styl.bg or styl.inbg

	local b = vgui.Create("BButton", p)
	b:SetText(t)
	b:SetFont("font_base_18")
	b:SetColor(c or styl.text)
	b:SizeToContents()
	b.DoClick = function(me)
		cb(me)
	end
	-- b.Paint = function(me, w, h)
	-- 	local r = 0

	-- 	draw.RoundedBox(r, 0, 0, w, h, me.m_Background or bg)

	-- 	if (!me.m_bNoHover and me.Hovered) then
	-- 		draw.RoundedBox(r, 0, 0, w, h, styl.hover)
	-- 	end

	-- 	if (me.IsDown and me:IsDown()) then
	-- 		draw.RoundedBox(r, 0, 0, w, h, styl.hover)
	-- 	end
	-- end

	return b
end

function base_table:QuickButtonAlt(t, cb, p, f, c)
	return self:QuickButton(t, cb, p, f, c, true)
end

function base_table:ButtonStyle(b, f, c)
	local styl = self.Style

	b:SetFont("font_base_18")
	b:SetContentAlignment(5)
	b:SetColor(c or styl.text)
	b.Paint = function(me, w, h)
		local r = 0

		draw.RoundedBox(r, 0, 0, w, h, Color(50,50,50,220))

		if (!me.m_bNoHover and me.Hovered) then
			draw.RoundedBox(r, 0, 0, w, h, styl.hover)
		end

		if (me.IsDown and me:IsDown()) then
			draw.RoundedBox(r, 0, 0, w, h, styl.hover)
		end
	end
end

function base_table:LineStyle(l, alt)
	local styl = self.Style
	local altc = alt and styl.bg or styl.inbg

	for _, v in pairs (l.Columns) do
		if (v.SetFont) then
			v:SetContentAlignment(5)
			v:SetFont("font_base_18")
			v:SetTextColor(styl.text)
		end
	end

	l.Paint = function(me, w, h)
		if (!me:GetAltLine()) then
			surface.SetDrawColor(altc.r, altc.g, altc.b, altc.a * 0.25)
			surface.DrawRect(0, 0, w, h)
		end

		if (me:IsSelectable() and me:IsLineSelected()) then
			surface.SetDrawColor(styl.hover)
			surface.DrawRect(0, 0, w, h)
		elseif (me.Hovered or me:IsChildHovered()) then
			surface.SetDrawColor(styl.hover2)
			surface.DrawRect(0, 0, w, h)
		end
	end
end

function base_table:QuickEntry(tx, parent, alt)
	parent:SetMouseInputEnabled(true)
	parent:SetKeyboardInputEnabled(true)

	local styl = self.Style
	local bg = alt and styl.bg or styl.textentry

	local entry = vgui.Create("DTextEntry", parent)
	entry:SetText(tx or "")
	entry:SetFont("font_base_18")
	entry:SetDrawLanguageID(false)
	entry:SetUpdateOnType(true)
	entry:SetTextColor(styl.text)
	entry:SetHighlightColor(styl.header)
	entry:SetCursorColor(styl.text)
	entry.Paint = function(me, w, h)
		draw.RoundedBox(0, 0, 0, w, h, bg)
		me:DrawTextEntryText(me:GetTextColor(), me:GetHighlightColor(), me:GetCursorColor())
	end

	return entry
end

function base_table:QuickComboBox(parent)
	parent:SetMouseInputEnabled(true)

	local combo = vgui.Create("DComboBox", parent)
	combo.m_bNoHover = true
	self:ButtonStyle(combo)

	combo.OldDoClick = combo.DoClick
	combo.DoClick = function(me)
		me:OldDoClick()

		if (IsValid(me.Menu)) then
			for _, v in pairs (me.Menu:GetChildren()[1]:GetChildren()) do -- sdfdsfzz
				self:ButtonStyle(v)
				v.m_iRound = 0
			end
		end
	end

	return combo
end

function base_table:PaintScroll(panel)
	local styl = self.Style

	if (panel.Rebuild) then
		panel.PerformLayout = function(me)
			local Tall = me.pnlCanvas:GetTall()
			local Wide = me:GetWide()
			local YPos = 0

			me:Rebuild()

			me.VBar:SetUp(me:GetTall(), me.pnlCanvas:GetTall())
			YPos = me.VBar:GetOffset()

			if (me.VBar.Enabled) then Wide = Wide - me.VBar:GetWide() - m * 0.5 end

			me.pnlCanvas:SetPos(0, YPos)
			me.pnlCanvas:SetWide(Wide)

			me:Rebuild()

			if (Tall != me.pnlCanvas:GetTall()) then
				me.VBar:SetScroll(me.VBar:GetScroll())
			end
		end
	end

	local scr = panel.VBar or panel:GetVBar()
	scr.Paint = function(_, w, h)
		draw.RoundedBox(0, 0, 0, w, h, /* 76561198059738127 styl.header */ styl.bg)
	end

	scr.btnUp.Paint = function(_, w, h)
		draw.RoundedBox(0, 2, 0, w - 4, h - 2, styl.inbg)
	end
	scr.btnDown.Paint = function(_, w, h)
		draw.RoundedBox(0, 2, 2, w - 4, h - 2, styl.inbg)
	end

	scr.btnGrip.Paint = function(me, w, h)
		draw.RoundedBox(0, 2, 0, w - 4, h, styl.inbg)

		if (me.Hovered) then
			draw.RoundedBox(0, 2, 0, w - 4, h, styl.hover2)
		end

		if (me.Depressed) then
			draw.RoundedBox(0, 2, 0, w - 4, h, styl.hover2)
		end
	end
end

function base_table:PaintList(ilist, alt)
	for _, v in pairs (ilist.Columns) do
		self:ButtonStyle(v.Header)
		if (alt) then
			v.Header.m_Background = self.Style.bg
		end

		v.DraggerBar:SetVisible(false)
	end

	self:PaintScroll(ilist)
end

function base_table:StringRequest(title, text, callback)
	local styl = self.Style

	if (IsValid(_LOUNGE_STRREQ)) then
		_LOUNGE_STRREQ:Remove()
	end

	local scale = math.max(get_scale(), 0.8)
	local wi, he = 600 * scale, 160 * scale

	local cancel = vgui.Create("DPanel")
	cancel:SetDrawBackground(false)
	cancel:StretchToParent(0, 0, 0, 0)
	cancel:MoveToFront()
	cancel:MakePopup()

	local pnl = self:MakeWindow(title)
	pnl:SetSize(wi, he)
	pnl:Center()
	pnl:MakePopup()
	pnl.m_fCreateTime = SysTime()
	_LOUNGE_STRREQ = pnl

	cancel.OnMouseReleased = function(me, mc)
		if (mc == MOUSE_LEFT) then
			pnl:Close()
		end
	end
	cancel.Think = function(me)
		if (!IsValid(pnl)) then
			me:Remove()
		end
	end

		local body = vgui.Create("DPanel", pnl)
		body:SetDrawBackground(false)
		body:Dock(FILL)
		body:DockPadding(m, m, m, m)

			local tx = self:QuickLabel(text, font_prefix .. "Large", styl.text, body)
			tx:SetContentAlignment(5)
			tx:SetWrap(tx:GetWide() > wi - m * 2)
			tx:Dock(FILL)

			local apply = vgui.Create("DButton", body)
			apply:SetText("OK")
			apply:SetColor(styl.text)
			apply:SetFont("font_base_18")
			apply:Dock(BOTTOM)
			apply.Paint = function(me, w, h)
				draw.RoundedBox(0, 0, 0, w, h, styl.inbg)

				if (me.Hovered) then
					draw.RoundedBox(0, 0, 0, w, h, styl.hover)
				end

				if (me:IsDown()) then
					draw.RoundedBox(0, 0, 0, w, h, styl.hover)
				end
			end

			local entry = vgui.Create("DTextEntry", body)
			entry:RequestFocus()
			entry:SetFont("font_base_18")
			entry:SetTextColor(styl.text)
			entry:SetHighlightColor(styl.header)
			entry:SetCursorColor(styl.text)
			entry:SetDrawLanguageID(false)
			entry:Dock(BOTTOM)
			entry:DockMargin(0, m, 0, m)
			entry.Paint = function(me, w, h)
				draw.RoundedBox(0, 0, 0, w, h, styl.textentry)
				me:DrawTextEntryText(me:GetTextColor(), me:GetHighlightColor(), me:GetCursorColor())
			end
			entry.OnEnter = function()
				apply:DoClick()
			end

			apply.DoClick = function()
				pnl:Close()
				callback(entry:GetValue())
			end

	pnl.OnFocusChanged = function(me, gained)
		if (!gained) then
			timer.Simple(0, function()
				if (!IsValid(me) or vgui.GetKeyboardFocus() == entry) then
					return end

				me:Close()
			end)
		end
	end

	pnl:SetWide(math.max(math.min(tx:GetWide() + m * 2, pnl:GetWide()), th * 2))
	pnl:CenterHorizontal()

	pnl:SetAlpha(0)
	pnl:AlphaTo(255, 0.1)
end

function base_table:Menu()
	local styl = self.Style

	if (IsValid(_LOUNGE_MENU)) then
		_LOUNGE_MENU:Remove()
	end

	local cancel = vgui.Create("DPanel")
	cancel:SetDrawBackground(false)
	cancel:StretchToParent(0, 0, 0, 0)
	cancel:MoveToFront()
	cancel:MakePopup()

	local pnl = vgui.Create("DPanel")
	pnl:SetDrawBackground(false)
	pnl:SetSize(20, 1)
	pnl.AddOption = function(me, text, callback)
		surface.SetFont("font_base_18")
		local wi, he = surface.GetTextSize(text)
		wi = wi + m * 2
		he = he + m

		me:SetWide(math.max(wi, me:GetWide()))
		me:SetTall(pnl:GetTall() + he)

		local btn = vgui.Create("DButton", me)
		btn:SetText(self:L(text))
		btn:SetFont("font_base_18")
		btn:SetColor(styl.text)
		btn:Dock(TOP)
		btn:SetSize(wi, he)
		btn.Paint = function(me, w, h)
			surface.SetDrawColor(styl.menu)
			surface.DrawRect(0, 0, w, h)

			if (me.Hovered) then
				surface.SetDrawColor(styl.hover)
				surface.DrawRect(0, 0, w, h)
			end

			if (me:IsDown()) then
				surface.SetDrawColor(styl.hover)
				surface.DrawRect(0, 0, w, h)
			end
		end
		btn.DoClick = function(me)
			if (callback) then
				callback()
			end
			pnl:Close()
		end

		return btn
	end
	pnl.Open = function(me)
		me:SetPos(gui.MouseX(), math.min(math.max(0, ScrH() - me:GetTall()), gui.MouseY()))
		me:MakePopup()
	end
	pnl.Close = function(me)
		if (me.m_bClosing) then
			return end

		me.m_bClosing = true
		me:AlphaTo(0, 0.1, 0, function()
			me:Remove()
		end)
	end
	_LOUNGE_MENU = pnl

	cancel.OnMouseReleased = function(me, mc)
		pnl:Close()
	end
	cancel.Think = function(me)
		if (!IsValid(pnl)) then
			me:Remove()
		end
	end

	return pnl
end

function base_table:PanelPaint(name)
	local styl = self.Style
	local col = styl[name] or styl.bg

	return function(me, w, h)
		draw.RoundedBox(0, 0, 0, w, h, col)
	end
end

// https://facepunch.com/showthread.php?t=1522945&p=50524545&viewfull=1#post50524545|76561198059738127
local sin, cos, rad = math.sin, math.cos, math.rad
local rad0 = rad(0)
local function DrawCircle(x, y, radius, seg)
	local cir = {
		{x = x, y = y}
	}

	for i = 0, seg do
		local a = rad((i / seg) * -360)
		table.insert(cir, {x = x + sin(a) * radius, y = y + cos(a) * radius})
	end

	table.insert(cir, {x = x + sin(rad0) * radius, y = y + cos(rad0) * radius})
	surface.DrawPoly(cir)
end

function base_table:Avatar(ply, siz, par)
	if (type(ply) == "Entity" and !IsValid(ply)) then
		return end

	if (isnumber(ply)) then
		ply = tostring(ply)
	end

	siz = siz or 32
	local hsiz = siz * 0.5

	local url = "http://steamcommunity.com/profiles/" .. (isstring(ply) and ply or ply:SteamID64() or "")

	par:SetMouseInputEnabled(true)

	local pnl = vgui.Create("DPanel", par)
	pnl:SetSize(siz, siz)
	pnl:SetDrawBackground(false)
	pnl.Paint = function() end

		local av = vgui.Create("AvatarImage", pnl)
		if (isstring(ply)) then
			av:SetSteamID(ply, siz)
		else
			av:SetPlayer(ply, siz)
		end
		av:SetPaintedManually(true)
		av:SetSize(siz, siz)

			local btn = vgui.Create("DButton", av)
			btn:SetToolTip("Click here to view " .. (isstring(ply) and "their" or ply:Nick() .. "'s") .. " Steam Profile")
			btn:SetText("")
			btn:Dock(FILL)
			btn.Paint = function() end
			btn.DoClick = function(me)
				gui.OpenURL(url)
			end

	pnl.SetSteamID = function(me, s)
		av:SetSteamID(s, siz)
		url = "http://steamcommunity.com/profiles/" .. s
	end
	pnl.SetPlayer = function(me, p)
		av:SetPlayer(p, siz)
		url = "http://steamcommunity.com/profiles/" .. p:SteamID64()
	end
	pnl.Paint = function(me, w, h)
		render.ClearStencil()
		render.SetStencilEnable(true)

		render.SetStencilWriteMask(1)
		render.SetStencilTestMask(1)

		render.SetStencilFailOperation(STENCILOPERATION_REPLACE)
		render.SetStencilPassOperation(STENCILOPERATION_ZERO)
		render.SetStencilZFailOperation(STENCILOPERATION_ZERO)
		render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_NEVER)
		render.SetStencilReferenceValue(1)

		draw.NoTexture()
		surface.SetDrawColor(color_black)
		DrawCircle(hsiz, hsiz, hsiz, hsiz)

		render.SetStencilFailOperation(STENCILOPERATION_ZERO)
		render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
		render.SetStencilZFailOperation(STENCILOPERATION_ZERO)
		render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
		render.SetStencilReferenceValue(1)

		av:PaintManual()

		render.SetStencilEnable(false)
		render.ClearStencil()
	end

	return pnl
end

local c = {}
function base_table:GetName(sid, cb)
	local p = cb
	if (ispanel(p)) then
		cb = function(tx)
			if (IsValid(p)) then
				p:SetText(tx)
			end
		end
	end

	if (c[sid]) then
		cb(c[sid])
		return
	end

	for _, v in pairs (player.GetAll()) do
		if (v:SteamID64() == sid) then
			c[sid] = v:Nick()
			cb(v:Nick())
			return
		end
	end

	steamworks.RequestPlayerInfo(sid)
	timer.Simple(1, function()
		local n = steamworks.GetPlayerName(sid)
		c[sid] = n
		cb(n)
	end)
end

function base_table:Notify(msg, dur, bg, parent)
	if (IsValid(_SH_NOTIFY)) then
		_SH_NOTIFY:Close()
	end

	dur = dur or 3
	bg = bg or self.Style.header

	local fnt = font_prefix .. "Larger"

	local w, h = ScrW(), ScrH()
	if (IsValid(parent)) then
		w, h = parent:GetSize()
		fnt = font_prefix .. "Large"
	end

	local p = vgui.Create("BButton", IsValid(parent) and parent or nil)
	p:MoveToFront()
	p:SetText(self.Language[msg] or msg)
	p:SetFont("font_base_18")
	p:SetColor(self.Style.text)
	p:SetSize(w, draw.GetFontHeight(fnt) + self:GetMargin() * 2)
	p:AlignTop(h)
	p.Paint = function(me, w, h)
		surface.SetDrawColor(bg)
		surface.DrawRect(0, 0, w, h)
	end
	p.Close = function(me)
		if (me.m_bClosing) then
			return end

		me.m_bClosing = true
		me:Stop()
		me:MoveTo(0, h, 0.2, 0, -1, function()
			me:Remove()
		end)
	end
	p.DoClick = p.Close
	_SH_NOTIFY = p

	p:MoveTo(0, h - p:GetTall(), 0.2, 0, -1, function()
		p:MoveTo(0, h, 0.2, dur, -1, function()
			p:Remove()
		end)
	end)
end

function base_table:LerpColor(frac, from, to)
	return Color(Lerp(frac, from.r, to.r), Lerp(frac, from.g, to.g), Lerp(frac, from.b, to.b), Lerp(frac, from.a, to.a))
end

local matList = Material("shenesis/general/list.png", "smooth")

function base_table:NavBar(parent, tabs, selectable, iconless)
	local scale = self:GetScreenScale()
	local toggled = !iconless and cookie.GetNumber(font_prefix .. "NavBar", 1) == 1

	local sel

	local navbar = vgui.Create("DPanel", parent)
	navbar:SetWide(toggled and th or th * (iconless and 2.5 or 3.25))
	navbar:Dock(LEFT)
	navbar:DockPadding(0, iconless and 0 or th, 0, 0)
	navbar.Paint = function(me, w, h)
		draw.RoundedBoxEx(4, 0, 0, w, h, self.Style.inbg, false, false, true, false)
	end

		if (!iconless) then
			local togglenavbar = vgui.Create("DButton", navbar)
			togglenavbar:SetText("")
			togglenavbar:SetToolTip(self.Language.toggle)
			togglenavbar:SetSize(th, th)
			togglenavbar.Paint = function(me, w, h)
				surface.SetDrawColor(self.Style.text)
				surface.SetMaterial(matList)
				surface.DrawTexturedRectRotated(w * 0.5, h * 0.5, 24 * scale, 24 * scale, 0)
			end
			togglenavbar.DoClick = function()
				toggled = !toggled
				cookie.Set(font_prefix .. "NavBar", toggled and 1 or 0)

				_TAB_LOUNGE_RESIZING = true
				navbar:Stop()
				navbar:SizeTo(toggled and th or th * 3.25, -1, 0.1, 0, 0.2, function()
					_TAB_LOUNGE_RESIZING = false
				end)
			end
		end

		local pagepnls ={}
		for i, page in ipairs (tabs) do
			if (page.visible == false) or (page.display and !page.display()) then
				continue end

			if (page.pnl) then
				page.pnl:Dock(FILL)
				page.pnl:SetVisible(false)

				table.insert(pagepnls, page.pnl)
			end

			local tx = self.Language[page.text] or page.text
			local args = page.args or {}

			local func = page.func
			if (istable(func)) then
				func = page.func[1]
				table.remove(page.func, 1)
				args = page.func
			end

			local btn = vgui.Create("DButton", navbar)
			btn:SetText("")
			btn:SetToolTip(tx)
			btn:SetTall(th)
			btn:Dock(TOP)
			btn.Paint = function(me, w, h)
				if (me.Hovered) then
					surface.SetDrawColor(self.Style.hover)
					surface.DrawRect(0, 0, w, h)
				end

				if (me:IsDown()) then
					surface.SetDrawColor(self.Style.hover)
					surface.DrawRect(0, 0, w, h)
				end

				if (page.icon) then
					surface.SetDrawColor(me.m_Color)
					surface.SetMaterial(page.icon)
					surface.DrawTexturedRectRotated(24 * scale, 24 * scale, 24 * scale, 24 * scale, 0)
				end

				if (selectable and sel == i) then
					surface.SetDrawColor(self.Style.header)
					surface.DrawRect(0, 0, th * 0.1, h)
				end
			end
			btn.DoClick = function()
				if (sel == i) then
					return end

				for _, v in ipairs (pagepnls) do
					v:SetVisible(v == page.pnl)

					if (v:IsVisible()) then
						v:SetAlpha(0)
						v:AlphaTo(255, 0.1)
					end
				end

				if (func) then
					func(unpack(args))
				end

				sel = i
			end
			btn.m_Color = self.Style.text
			page.m_Button = btn

				local lbl = self:QuickLabel(tx, "font_base_18", self.Style.text, btn)
				lbl:Dock(LEFT)
				lbl:DockMargin(iconless and m + 4 or th, 0, 0, 0)

			btn.SetColor = function(me, c)
				lbl:SetTextColor(c)
				me.m_Color = c
			end

			if (page.color) then
				btn:SetColor(page.color)
			end

			if (page.default) then
				btn:DoClick()

				if (page.pnl) then
					page.pnl:SetVisible(true)
				end
			end
		end

	if (!iconless) then
		navbar.Think = function(me)
			if (input.IsKeyDown(KEY_TAB)) then
				if (!me.m_bHoldingTab) then
					togglenavbar:DoClick()
				end

				me.m_bHoldingTab = true
			else
				me.m_bHoldingTab = false
			end
		end
	end
	navbar.m_Tabs = tabs

	return navbar
end

function base_table:RemoveIfValid(o)
	if (o and IsValid(o)) then
		o:Remove()
	end
end

-- fresh from NEP
local d = {
	[86400 * 31] = "mo",
	[86400 * 7] = "w",
	[86400] = "d",
	[3600] = "h",
	[60] = "min",
	[1] = "s",
}
local c2 = {}
function base_table:FormatTime(i, cap)
	if (c2[i]) then
		return c2[i]
	end

	local f = i
	local t = {}
	for ti, s in SortedPairs(d, true) do
		local f = math.floor(i / ti)
		if (f > 0) then
			table.insert(t, f .. s)
			i = i - f * ti
		end
	end

	t = table.concat(t, " ", 1, cap and math.min(cap, #t) or nil)
	c2[f] = t

	return t
end

function base_table:TimerThink(panel, time, func)
	local function worker(me)
		if (!me.m_fNextTick or RealTime() >= me.m_fNextTick) then
			me.m_fNextTick = RealTime() + time
			func(me)
		end
	end

	local ot = panel.Think
	panel.TimerTick = function(me)
		me.m_fNextTick = nil
		worker(me)
	end
	panel.Think = function(me)
		ot(me)
		worker(me)
	end
end

function base_table:CreateGroup(text, parent, ...)
	local m2 = m * 0.5

	local p = vgui.Create("DPanel", parent)
	p:DockPadding(m2, m2, m2, m2)
	p.Paint = function(me, w, h)
		draw.RoundedBox(0, 0, 0, w, h, self.Style.inbg)
	end

		if (text ~= "") then
			local lbl = self:QuickLabel(text, font_prefix .. "Large", self.Style.text, p)
			lbl:Dock(TOP)
			lbl:DockMargin(0, 0, 0, m2)
		end

	return p
end

local matChecked = Material("shenesis/whitelist/checked.png", "noclamp smooth")

function base_table:CheckboxLabel(text, cvar, parent)
	if (cvar and !isfunction(cvar) and !isstring(cvar)) then
		cvar = cvar:GetName()
	end

	local pnl = vgui.Create("DPanel", parent)
	pnl:SetDrawBackground(false)
	pnl:SetTall(draw.GetFontHeight(font_prefix .. "Large"))

		local lbl = self:QuickLabel(text, font_prefix .. "Large", self.Style.text, pnl)
		lbl:Dock(FILL)

		local chk = vgui.Create("DCheckBox", pnl)
		chk:SetValue(false)
		chk:SetWide(pnl:GetTall() - 4)
		chk:Dock(RIGHT)
		chk:DockMargin(2, 2, 2, 2)
		chk.Paint = function(me, w, h)
			if (me:GetChecked()) then
				if (me.m_bDrawBackground) then
					draw.RoundedBox(0, 0, 0, w, h, self.Style.header)
				end

				surface.SetDrawColor(self.Style.text)
				surface.SetMaterial(matChecked)
				surface.DrawTexturedRectRotated(w * 0.5, h * 0.5, h - 4, h - 4, 0)
			elseif (me.m_bDrawBackground) then
				draw.RoundedBox(0, 0, 0, w, h, self.Style.bg)
			end
		end
		if (isfunction(cvar)) then
			chk.OnChange = function(me, b)
				cvar(me, b)
			end
		elseif (isstring(cvar)) then
			chk:SetConVar(cvar)
		end

	return pnl, lbl
end

function base_table:Checkbox(cvar, parent)
	if (cvar and !isfunction(cvar) and !isstring(cvar)) then
		cvar = cvar:GetName()
	end

	local chk = vgui.Create("DCheckBox", parent)
	chk:SetValue(false)
	chk.Paint = function(me, w, h)
		if (me:GetChecked()) then
			if (me.m_bDrawBackground) then
				draw.RoundedBox(0, 0, 0, w, h, self.Style.header)
			end

			surface.SetDrawColor(self.Style.text)
			surface.SetMaterial(matChecked)
			surface.DrawTexturedRectRotated(w * 0.5, h * 0.5, h - 4, h - 4, 0)
		else
			if (me.m_bDrawBackground) then
				draw.RoundedBox(0, 0, 0, w, h, self.Style.bg)
			end
		end
	end
	if (isfunction(cvar)) then
		chk.OnChange = function(me, b)
			cvar(me, b)
		end
	elseif (isstring(cvar)) then
		chk:SetConVar(cvar)
	end

	return chk
end

-- almost legal tooltip override
local meta = FindMetaTable("Panel")

meta.Lounge_SetTooltip = meta.Lounge_SetTooltip or meta.SetTooltip
function meta:SetTooltipLounge(text, bg)
	self:Lounge_SetTooltip(text)
	self.m_bLounge = true
	self.m_bLoungeTooltipBG = bg
end

hook.Add("InitPostEntity", font_prefix .. "ToolTipOverride", function()
	local PANEL = vgui.GetControlTable("DTooltip")
	PANEL.Lounge_OldOpenForPanel = PANEL.Lounge_OldOpenForPanel or PANEL.OpenForPanel
	PANEL.Lounge_OldClose = PANEL.Lounge_OldClose or PANEL.Close
	PANEL.Lounge_OldPositionTooltip = PANEL.Lounge_OldPositionTooltip or PANEL.PositionTooltip
	PANEL.Lounge_OldPaint = PANEL.Lounge_OldPaint or PANEL.Paint

	function PANEL:OpenForPanel(panel)
		self.m_bLounge = panel.m_bLounge
		self.m_bLoungeTooltipBG = panel.m_bLoungeTooltipBG

		if (panel.m_bLounge) then
			self.TargetPanel = panel
			self:PositionTooltip()

			self:SetVisible(true)
			self:SetAlpha(0)
			self:AlphaTo(255, 0.1)

			self:NewAnimation(0.1, 0, -1).Think = function(anim, _, fraction)
				self.m_fOffset = 5 * (1 - fraction)
			end
		else
			self:Lounge_OldOpenForPanel(panel)
		end
	end

	function PANEL:Close()
		if (self.m_bLounge) then
			self:AlphaTo(0, 0.1, 0, function()
				self:Remove()
			end)
		else
			self:Lounge_OldClose()
		end
	end

	function PANEL:PositionTooltip()
		if (self.m_bLounge) then
			if (!IsValid(self.TargetPanel)) then
				self:Remove()
				return
			end

			self:PerformLayout(true)

			local tw, th = self.TargetPanel:GetSize()
			local w, h = self:GetSize()
			local x, y = self.TargetPanel:LocalToScreen(w * -0.5 + tw * 0.5, -h - 12 - m * 0.5)

			self:SetPos(math.Clamp(x, 0, ScrW() - w), y + (self.m_fOffset or 0))
		else
			self:Lounge_OldPositionTooltip()
		end
	end

	local mat = Material("vgui/arrow")
	function PANEL:Paint(w, h)
		if (self.m_bLounge) then
			local styl = base_table.Style
			self:PositionTooltip()
			self:SetFont("font_base_18")
			self:SetTextColor(styl.text)

			draw.RoundedBox(0, 0, 0, w, h, self.m_bLoungeTooltipBG or styl.header)

			DisableClipping(true)
				surface.SetMaterial(mat)
				surface.SetDrawColor(self.m_bLoungeTooltipBG or styl.header)
				surface.DrawTexturedRect(w * 0.5 - 6, h, 12, 12)
			DisableClipping(false)
		else
			self:Lounge_OldPaint(w, h)
		end
	end
end)

function base_table:ParseColor(c)
	if (istable(c) and c.r) then
		return c
	elseif (isstring(c)) then
		return self.Style[c] or color_white
	end

	-- TODO, rgb, hex
end

local png_args = "smooth"

function base_table:GetDownloadedImage(url)
	local filename = util.CRC(url)
	local path = self.ImageDownloadFolder .. "/" .. filename .. ".png"

	if (file.Exists(path, "DATA")) then
		return Material("data/" .. path, png_args)
	else
		return false
	end
end

function base_table:DownloadImage(url, success, failed)
	local filename = util.CRC(url)
	local path = self.ImageDownloadFolder .. "/" .. filename .. ".png"

	failed = failed or function() end

	http.Fetch(url, function(body)
		if (!body) then
			failed()
			return
		end

		if (!file.IsDir(self.ImageDownloadFolder, "DATA")) then
			file.CreateDir(self.ImageDownloadFolder)
		end

		local ok = pcall(function()
			file.Write(path, body)
			success(Material("data/" .. path, png_args))
		end)

		if (!ok) then
			failed()
		end
	end)
end