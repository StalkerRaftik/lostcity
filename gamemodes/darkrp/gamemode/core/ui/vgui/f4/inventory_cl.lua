local PANEL = {}


function PANEL:Init()
	self:ShowCloseButton(false)
	self:SetTitle('')
	self:SetDraggable(false)
	self.Paint = function(s,w,h)
	end

	local gradient = Material("gui/gradient")

  self.Scroll = vgui.Create( "SRP_ScrollPanel", self ) 
	self.Scroll:Dock( RIGHT )
	self.Scroll:DockMargin(0,10,-10,0)
	self.Scroll.sbar = self.Scroll:GetVBar()
  self.Scroll.sbar.Paint = function( self, w, h ) draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 150)) end
  self.Scroll.sbar.btnUp.Paint = function( self, w, h ) end
  self.Scroll.sbar.btnDown.Paint = function( self, w, h ) end
  self.Scroll.sbar.btnGrip.Paint = function( self, w, h ) draw.RoundedBox(0, 0, 0, w, h, Color(200, 200, 200, 150)) end
	self.Scroll.Paint = function( self, w, h )
    	draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 150))
    end

	self.List = vgui.Create( "DIconLayout", self.Scroll )
	self.List:Dock( FILL )
	self.List:DockPadding(0,5,0,5)
	self.List:DockMargin(5,5,5,5)
	self.List:SetSpaceY( 5 ) 
	self.List:SetSpaceX( 5 ) 

	wb = vgui.Create("MProgressBar", self)

	self:UpdateInventory()
  self:UpdateInventory()
end

function PANEL:UpdateInventory()
		self.List:Clear()
		wb:SetMax(LocalPlayer():GetDefaultSpace())
		wb:SetValue(LocalPlayer():GetSpace())

		local SlotSize = ScrW()/20, ScrH()/20
    local glowMat = Material( "particle/Particle_Glow_04_Additive" )

		for k, v in pairs(LocalPlayer().inv) do
			for item, count in pairs(v) do
				local itemTable = Inventory.GetItem(k, item)
				if !itemTable then continue end

				local glowColor = Color(94, 112, 124, 150)
        -- if itemTable and itemTable.Category == ITEM_CONSUMABLE then
        --     glowColor = Color( 150, 75, 150, 200 )
        -- end

        if itemTable and itemTable.Name then
            element:SetTooltip( itemData.Name )
        end

				local pos_cam = Vector(32,32,32)
				local pos_look = Vector(0,0,0)
				local base_fov = 75
				local camera_distance = 30
				local x = 32
				local y = 0
				local z = 0

				ItemButton = self.List:Add( "monoPanel" )
		    ItemButton:Dock( NODOCK )
		    ItemButton:SetSize( SlotSize, SlotSize )
		    ItemButton:SetPos( self:GetWide() * 0.005, self:GetTall() * 0.75 - ( SlotSize / 2 ) )
		    ItemButton.Paint = function(s,w,h)      
		        draw.RoundedBox(0,0,0,w,h, Color(50,50,50,200))
		        draw.OutlinedBox(0, 0, w, h, Color(0,0,0,0), glowColor)
		        surface.SetDrawColor( glowColor )
		        surface.SetMaterial( glowMat )
		        surface.DrawTexturedRect( 0 - ( w / 3 ), 0 - ( h / 3 ), w * 3, h * 3 )
		        draw.ShadowSimpleText('x'..count, 'rp.ui.18', w*0.05, h*0.005, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
		    end

			    ItemButton.monoIcon = ItemButton:Add( "DModelPanel" )
			    ItemButton.monoIcon:SetModel(itemTable.model)
			    ItemButton.monoIcon:Dock( FILL )
			    -- ItemButton.monoIcon:DockMargin( 20, 20, 20, 20 )
			    ItemButton.monoIcon.PaintOver = function() end
			    ItemButton.monoIcon:SetTooltip( itemTable.name )
			    ItemButton.monoIcon.DoClick = function(this) 
			    	self:UpdatePreview(itemTable, glowColor, count, k, item)
			    end

			   			-- fix icon position
				local PrevMins, PrevMaxs = ItemButton.monoIcon:GetEntity():GetRenderBounds()
				ItemButton.monoIcon:SetCamPos(PrevMins:Distance(PrevMaxs) * Vector(0.75, 0.75, 0.5))
				ItemButton.monoIcon:SetLookAt((PrevMaxs + PrevMins) / 2)

				ItemButton.monoIcon.Entity:SetSkin(v.skin or 0)

				function ItemButton.monoIcon:LayoutEntity(ent)
					ent:SetAngles(Angle(0, 0, 0))
				end
			end
		end
end


function PANEL:PerformLayout()

  self.Scroll:SetSize(self:GetWide(),self:GetTall())
 --   pnl2:SetPos(Main:GetWide()*0.01,Main:GetTall()*0.05)
	wb:SetPos( self:GetWide()*0.005, self:GetTall()*0.01 )
	wb:SetSize( self:GetWide()/1.01, 20 )

end

vgui.Register('rp_inventoryf4', PANEL, 'DFrame')

