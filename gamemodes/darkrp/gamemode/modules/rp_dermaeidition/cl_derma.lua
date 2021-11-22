local btn_col_nrm = Color(120,120,160,60)
local btn_col_hov = Color(120,130,190,80)

local BFRAME = {}

local matBlurScreen = Material( "pp/blurscreen" )

local color_white = Color(255,255,255)
local color_gray = Color(210,210,210)

function BFRAME:Init()

	self.m_fCreateTime = SysTime()
	self.lblTitle:SetFont("font_base_24")

	self.TitleBarHeight = 24 * rphud.Scale
	self.IconSize = 16 * rphud.Scale

	self.btnClose.lerp = 4
	self.btnClose.Paint = function( panel, w, h )
		-- panel.lerp = Lerp( FrameTime() * 10, panel.lerp, panel.Hovered and 21 or 4)
		surface.SetDrawColor( panel.Hovered and Color(210,100,100,100) or Color(180,100,100,80) )
		surface.DrawRect(1, 0, w-1, 21)

		-- local posx, posy = self.btnClose:LocalToScreen(0, 0)
		-- render.SetScissorRect(posx, posy, posx+w, posy+panel.lerp, true)
		draw.SimpleText( "r", "Marlett", w / 2, 10, panel.Hovered and color_white or color_gray, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		-- render.SetScissorRect( 0, 0, 0, 0, false )

	end

	self:DockPadding( 5, self.TitleBarHeight + 5, 5, 5 )

end

function BFRAME:Paint(width, height)

	if ( self.m_bBackgroundBlur ) then
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
	surface.DrawRect(0, 0, width, height)

	-- title
	--surface.SetDrawColor( Color(20,40,70,255) )
	surface.SetDrawColor( Color(50,50,50,220) )
	surface.DrawRect(0, 0, width, self.TitleBarHeight )
	--surface.SetDrawColor( Color(0,0,0,50) )
	--surface.DrawRect(0, 11, width, 11)

end

function BFRAME:OnMousePressed()

	if ( self.m_bSizable ) then

		if ( gui.MouseX() > ( self.x + self:GetWide() - 20 ) and
			gui.MouseY() > ( self.y + self:GetTall() - 20 ) ) then

			self.Sizing = { gui.MouseX() - self:GetWide(), gui.MouseY() - self:GetTall() }
			self:MouseCapture( true )
			return
		end

	end

	if ( self:GetDraggable() and gui.MouseY() < ( self.y + self.TitleBarHeight ) ) then
		self.Dragging = { gui.MouseX() - self.x, gui.MouseY() - self.y }
		self:MouseCapture( true )
		return
	end

end

function BFRAME:PerformLayout()

	local titlePush = 0

	if ( IsValid( self.imgIcon ) ) then

		self.imgIcon:SetPos( self.TitleBarHeight - (self.IconSize * 1.25), self.TitleBarHeight - (self.IconSize * 1.25) )
		self.imgIcon:SetSize( self.IconSize, self.IconSize )
		titlePush = self.IconSize + ( self.IconSize / 10 )

	end

	self.btnClose:SetPos( self:GetWide() - 71 - 4, 0 )
	self.btnClose:SetSize( 61, self.TitleBarHeight )

	self.lblTitle:SetPos( 8 + titlePush, (14 * rphud.Scale) / self.TitleBarHeight )
	self.lblTitle:SetSize( self:GetWide() - 25 - titlePush, self.TitleBarHeight )

end

vgui.Register( "BFrame", BFRAME, "DFrame" )

local BBUTTON = {}

function BBUTTON:Init()
	self:SetColor( Color(255,255,255) )
	self:SetFont("font_base_24")
	self:SetTall( 22 * rphud.Scale )
	self.BGColor = Color(120,120,120, 100)

end

function BBUTTON:Paint(width, height)

	--local w,h = surface.GetTextSize( self:GetText() )

	--derma.SkinHook( "Paint", "Button", self, width, height )

	if self.m_bDisabled then

		surface.SetDrawColor( self.BGColor )
		surface.DrawRect(0, 0, width, height)

		surface.SetDrawColor( Color(0,0,0,10) )
		surface.DrawRect(0, 0, width, height)

		--surface.SetTextColor( Color(120,120,120,255) )
		--surface.SetTextPos(width/2 - (w/2), height/2 - (h/2))
		--surface.DrawText( self:GetText() )

		self:SetCursor("pointer")

	else

		--local bg = self.Hovered and Color(120,130,190, 60) or Color(120,120,160, 40)

		--if self.BGColor then
		--	bg = self.BGColor
		--end

		-- --[[
		-- surface.SetDrawColor( bg )
		-- surface.DrawRect(0, 0, width, height)
		
		-- surface.SetDrawColor( Color(0,0,0,50) )
		-- surface.DrawRect(0, height/2, width, height/2)
		
		-- surface.SetDrawColor( Color(0,0,0,140) )
		-- surface.DrawOutlinedRect(0, 0, width, height)
		-- ]]--
		surface.SetDrawColor( self.BGColor )
		surface.DrawRect(0, 0, width, height)

		if self.Hovered then
			surface.SetDrawColor( Color(255,255,255,4) )
			surface.DrawRect(0, 0, width, height)
		end

		-- shadow
		--surface.SetTextColor( Color(0,0,0,255) )
		--surface.SetTextPos(self.left and 5 or (width/2 - (w/2) + 1), height/2 - (h/2) + 1)
		--surface.DrawText( self:GetText() )

		-- text
		--surface.SetTextColor( self:GetTextColor() ) --)) self.Hovered and Color(255,255,255,255) or Color(200,200,200,255) )
		--surface.SetTextPos(self.left and 5 or (width/2 - (w/2)), height/2 - (h/2))
		--surface.DrawText( self:GetText() )

	end

	return false
end

vgui.Register( "BButton", BBUTTON, "DButton" )


local BPANEL = {}

function BPANEL:Paint(w, h)
    -- draw.StencilBlur(self, w, h)

    draw.RoundedBox(0, 0, 0, w, h, Color(50, 50, 50, 150))

    surface.SetDrawColor(Color(0,0,0))
    surface.DrawOutlinedRect(0, 0, w, h)
end

vgui.Register( "BPanel", BPANEL, "DPanel" )


local BModelPanel = {}

function BModelPanel:Paint(w, h)

	if not IsValid( self.Entity ) then return end

	--surface.SetDrawColor( Color(220,140,240,20) )
	--surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )

	local x, y = self:LocalToScreen( 0, 0 )

	self:LayoutEntity( self.Entity )

	local ang = self.aLookAngle
	if not ang then
		ang = (self.vLookatPos-self.vCamPos):Angle()
	end

	cam.Start3D( self.vCamPos, ang, self.fFOV, x, y, w, h, 5, self.FarZ )

		render.SuppressEngineLighting(true)
		render.SetLightingOrigin(self.Entity:GetPos())
		render.ResetModelLighting(self.colAmbientLight.r / 255, self.colAmbientLight.g / 255, self.colAmbientLight.b / 255)
		render.SetColorModulation(self.colColor.r / 255, self.colColor.g / 255, self.colColor.b / 255)
		render.SetBlend(self.colColor.a / 255)

		for i = 0, 6 do
			local col = self.DirectionalLight[i]
			if (col) then
				render.SetModelLighting(i, col.r / 255, col.g / 255, col.b / 255)
			end
		end

		if self.MaterialOverrideIndex then
			render.MaterialOverride()
			render.MaterialOverrideByIndex( self.MaterialOverrideIndex, self.MaterialOverrideName )
		end

		self:DrawModel()

		if self.MaterialOverrideIndex then
			render.MaterialOverrideByIndex( self.MaterialOverrideIndex )
		end

		if self.Extra then

			for k,v in pairs( self.Extra ) do

				if not IsValid(v.entity) then continue end

				local id = self.Entity:LookupAttachment(v.attach or "eyes")
				local aPos = self.Entity:GetAttachment(id)

				if aPos then
					local pos = aPos.Pos
					local ang = aPos.Ang

					local pos_offset = v.pos
					local ang_offset = v.ang

					local forward, right, up = ang:Forward(), ang:Right(), ang:Up()
					local pos_off = (up*(pos_offset.z or 0)) + (right*(pos_offset.y or 0)) + (forward*(pos_offset.x or 0))

					ang:RotateAroundAxis( right, 	ang_offset.p or 0 )
					ang:RotateAroundAxis( forward, 	ang_offset.y or 0 )
					ang:RotateAroundAxis( up, 		ang_offset.r or 0 )

					v.entity:SetPos( pos + pos_off )
					v.entity:SetAngles( ang )

					--v.entity:SetRenderMode( RENDERMODE_TRANSALPHA )
					v.entity:SetColor( v.color )

					render.SetColorModulation( v.color.r/255, v.color.g/255, v.color.b/255 )
					render.SetBlend( v.color.a )

					v.entity:DrawModel()

				end

			end

		end

		render.SuppressEngineLighting( false )

	cam.End3D()

	self.LastPaint = RealTime()
	
end

function BModelPanel:AddAttachment(id, data)
	self.Extra = self.Extra or {}
	if self.Extra[id] and IsValid(self.Extra[id].entity) then self.Extra[id].entity:Remove() end
	self.Extra[id] = {
		model = data.model,
		entity = ents.CreateClientProp( data.model ),
		attach = data.attach or "eyes",
		pos = data.pos or Vector(0,0,0),
		ang = data.ang or Angle(0,0,0),
		color = data.color or Color(255,255,255,255),
		scale = data.scale or 1
	}
	self.Extra[id].entity:SetModel( self.Extra[id].model )
	self.Extra[id].entity:SetNoDraw( true )
	self.Extra[id].entity:SetColor( self.Extra[id].color )
	self.Extra[id].entity:SetModelScale( self.Extra[id].scale, 0 )
	self.Extra[id].entity:Spawn()

	if data.matrix then
		self.Extra[id].vmatrix = Matrix()
		self.Extra[id].vmatrix:Scale(data.matrix)
		self.Extra[id].entity:EnableMatrix("RenderMultiply", self.Extra[id].vmatrix)
	end

	return self.Extra[id].entity

end

function BModelPanel:RemoveAttachment(id)
	self.Extra = self.Extra or {}
	if self.Extra[id] and IsValid(self.Extra[id].entity) then self.Extra[id].entity:Remove() end
end

function BModelPanel:RemoveAllAttachments()
	if self.Extra then
		for k,v in pairs( self.Extra ) do
			if IsValid(v.entity) then
				v.entity:Remove()
			end
		end
	end
end

function BModelPanel:OnRemove()
	if ( IsValid( self.Entity ) ) then
		self.Entity:Remove()
	end

	if self.Extra then
		for k,v in pairs( self.Extra ) do
			if IsValid(v.entity) then
				v.entity:Remove()
			end
		end
	end

end

vgui.Register( "BModelPanel", BModelPanel, "DModelPanel" )



local BTEXT = {}

function BTEXT:Paint(width, height)

	surface.SetDrawColor( Color(30,50,120,100) )
	surface.DrawRect(0, 0, width, height)

end

vgui.Register( "BTextEntry", BTEXT, "DTextEntry" )

surface.CreateFont( "TooltipFont", {
	font = "Roboto",
	size = 14,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	extended = true,
} )

surface.CreateFont( "TooltipBold", {
	font = "Roboto",
	size = 14,
	weight = 700,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	extended = true,
} )

local tt = {}

function tt:Init()
	self:SetDrawOnTop( true )
	self.DeleteContentsOnClose = false
	self:SetText( "" )
	self:SetFont( "TooltipFont" )
	self:SetTextColor( Color(200,200,200) )
end

function tt:Paint( w, h )

	self:PositionTooltip()

	local x, y = self:GetPos()

	surface.SetMaterial( matBlurScreen )
	surface.SetDrawColor( 255, 255, 255, 255 )

	matBlurScreen:SetFloat( "$blur", 3 )
	matBlurScreen:Recompute()
	render.UpdateScreenEffectTexture()
	surface.DrawTexturedRect( -x, -y, ScrW(), ScrH() )

	surface.SetDrawColor( Color(20,20,30,200) )
	surface.DrawRect(0, 0, w, h)

end

vgui.Register( "BTooltip", tt, "DTooltip" )

local Tooltip = nil
local TooltippedPanel = nil

function RemoveTooltip( PositionPanel )

	if ( not IsValid( Tooltip ) ) then return true end

	Tooltip:Close()
	Tooltip = nil
	return true

end

function FindTooltip( panel )

	while ( panel and panel:IsValid() ) do

		if ( panel.strTooltipText or panel.pnlTooltipPanel ) then
			return panel.strTooltipText, panel.pnlTooltipPanel, panel
		end

		panel = panel:GetParent()

	end

end

function ChangeTooltip( panel )

	RemoveTooltip()

	local Text, Panel, PositionPanel = FindTooltip( panel )

	if ( not Text and not Panel ) then return end

	Tooltip = vgui.Create( "BTooltip" )

	if ( Text ) then

		Tooltip:SetText( Text )

	else

		Tooltip:SetContents( Panel, false )

	end

	Tooltip:OpenForPanel( PositionPanel )
	TooltippedPanel = panel

end

function EndTooltip( panel )

	if ( not TooltippedPanel ) then return end
	if ( TooltippedPanel ~= panel ) then return end

	RemoveTooltip()

end

for k,v in pairs( vgui.GetWorldPanel():GetChildren() ) do
	if v:GetName() == "ItemStoreTooltip" then print("remove itemstore tooltip") v:Remove() end
end

local PANEL = baseclass.Get("ItemStoreSlot")
function PANEL:Paint( w, h )
	surface.SetDrawColor( self.Hovered and itemstore.config.Colours.HoveredSlot or itemstore.config.Colours.Slot )
	surface.DrawRect( 0, 0, w, h )

	surface.SetDrawColor( itemstore.config.Colours.OuterBorder )
	surface.DrawOutlinedRect( 0, 0, w, h )

	surface.SetDrawColor( itemstore.config.Colours.InnerBorder )
	surface.DrawOutlinedRect( 1, 1, w - 2, h - 2 )

	self.BaseClass.Paint( self, w, h )

	local item = self:GetItem()
	if item and item.DrawItem then item:DrawItem( self, w, h ) end

	if item and item:GetAmount() > 1 then
		draw.SimpleTextOutlined( "x" .. item:GetAmount(), "DermaDefault", 4,
			h - 2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, color_black )
	end
	print("braxpaint", self)
end

print("[rphud] Derma elements")
