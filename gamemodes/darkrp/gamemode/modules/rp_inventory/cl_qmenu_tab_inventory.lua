local Panel = {}
function Panel:Init()
	self.m_colItemName = Color( 255, 255, 255, 255 )
	self.m_colAmount = Color( 120, 230, 110, 255 )

	-- self.m_matWeight = Material( "samprp/emoji/2696.png", "smooth" )
	-- -- self.m_matVolume = Material( "icon16/brick.png", "smooth" )

	self.m_pnlIcon = vgui.Create( "monoIcon", self )
	self.m_pnlIcon:SetPos(0,0)
	self.m_pnlNameLabel = vgui.Create( "DLabel", self )
	self.m_pnlNameLabel:SetExpensiveShadow( 2, Color(0, 0, 0, 255) )
	self.m_pnlNameLabel:SetTextColor( self.m_colItemName )
	self.m_pnlNameLabel:SetFont( "font_base_24" )

	self.m_pnlNumLabel = vgui.Create( "DLabel", self )
	self.m_pnlNumLabel:SetExpensiveShadow( 2, Color(0, 0, 0, 255) )   
	self.m_pnlNumLabel:SetTextColor( self.m_colAmount )
	self.m_pnlNumLabel:SetFont( "font_base_18" )
	self.m_pnlNumLabel:SetText( " " )

	self.m_pnlContainer = vgui.Create( "EditablePanel", self )

	self.m_tblTrayBtns = {}
	self.m_pnlBtnTray = vgui.Create( "EditablePanel", self.m_pnlContainer )
	self.m_pnlBtnTray:SetVisible( false )
	self.m_pnlBtnTray.PerformLayout = function( p, intW, intH )
		for k, v in pairs( self.m_tblTrayBtns ) do
			v:SetWide( 100 )
			v:DockMargin( 0, 0, 5, 0 )
			v:Dock( LEFT )
		end
	end

	self.m_pnlDescLabel = vgui.Create( "DLabel", self.m_pnlContainer )
	self.m_pnlDescLabel:SetExpensiveShadow( 2, Color(0, 0, 0, 255) )
	self.m_pnlDescLabel:SetTextColor( self.m_colItemName )
	self.m_pnlDescLabel:SetFont( "font_base_18" )

	self.m_intItemAmount = 1
end

function Panel:Think()
	local x, y = self:CursorPos()
	if x < 0 or y < 0 or x > self:GetWide() or y > self:GetTall() then
		if self.m_bIsHovered then
			self.m_bIsHovered = false
			self:OnCursorEndHover()
		end
	else
		if not self.m_bIsHovered then
			self.m_bIsHovered = true
			self:OnCursorHover()
		end
	end
end

function Panel:OnCursorHover()
	local padding = 5
	local labelPosX = 0
	local labelPosY = 0

	self.m_pnlDescLabel:Stop()
	self.m_pnlBtnTray:Stop()

	self.m_pnlDescLabel:SetPos( labelPosX, labelPosY )
	self.m_pnlDescLabel:SetVisible( true )
	self.m_pnlDescLabel:MoveTo( labelPosX, labelPosY -self.m_pnlBtnTray:GetTall(), 0.25, 0, 2, function()
		self.m_pnlDescLabel:SetVisible( false )
	end )

	self.m_pnlBtnTray:SetPos( labelPosX, labelPosY +self.m_pnlBtnTray:GetTall() )
	self.m_pnlBtnTray:SetVisible( true )
	self.m_pnlBtnTray:MoveTo( labelPosX, labelPosY, 0.25, 0, 2, function()
		self.m_pnlBtnTray:SetVisible( true )
	end )
end

function Panel:OnCursorEndHover()
	local padding = 5
	local labelPosX = 0
	local labelPosY = 0

	self.m_pnlDescLabel:Stop()
	self.m_pnlBtnTray:Stop()

	self.m_pnlDescLabel:SetPos( labelPosX, labelPosY -self.m_pnlDescLabel:GetTall() )
	self.m_pnlDescLabel:SetVisible( true )
	self.m_pnlDescLabel:MoveTo( labelPosX, labelPosY, 0.25, 0, 2, function()
		self.m_pnlDescLabel:SetVisible( true )
	end )

	self.m_pnlBtnTray:SetVisible( true )
	self.m_pnlBtnTray:MoveTo( labelPosX, labelPosY +self.m_pnlDescLabel:GetTall(), 0.25, 0, 2, function()
		self.m_pnlBtnTray:SetVisible( false )
	end )
end

function Panel:BuildTrayButtons()
	self.m_pnlBtnTray:Clear()
	if not self.m_tblItem then return end
  if not self.m_strItemClass then return end
	k = self.m_strItemClass
  if k == 'entity' then
    local dentbtn = vgui.Create( "SRP_Button", self.m_pnlBtnTray )
    dentbtn:SetText( "Выкинуть" ) 
    dentbtn.DoClick = function()
      LocalPlayer():ConCommand("Inventory.Drop".." "..self.m_strItemClass.." ".. self.key .." "..self.m_strItemID)
    end
    table.insert( self.m_tblTrayBtns, dentbtn )

    local dentbtn2 = vgui.Create( "SRP_Button", self.m_pnlBtnTray )
	dentbtn2:SetText( "Выкинуть неск." ) 
	dentbtn2.DoClick = function()
		local InputFrame = vgui.Create("DFrame", self.m_pnlContainer)
		InputFrame:SetSize( 250, 60 )
		InputFrame:SetPos(ScrW()/2-100, ScrH()/2-25)
		InputFrame:MakePopup()
		InputFrame:SetTitle("Сколько предметов выкинуть?")

		local class = self.m_strItemClass
		local ID = self.m_strItemID
		local key = self.key
		local TextEntry = vgui.Create( "DTextEntry", InputFrame ) -- create the form as a child of frame
		TextEntry:Dock( FILL )
		TextEntry:SetNumeric(true)
		TextEntry:SetValue("Введите число, затем нажмите Enter")
		TextEntry.OnEnter = function( self )
			LocalPlayer():ConCommand("Inventory.Drop".." "..class.." ".. key .." "..ID .." "..self:GetValue())
		end
	end
	table.insert( self.m_tblTrayBtns, dentbtn2 )

	local dentbtn3 = vgui.Create( "SRP_Button", self.m_pnlBtnTray )
    dentbtn3:SetText( "Выкинуть всё" ) 
    dentbtn3.DoClick = function()
    	if LocalPlayer().inv[self.m_strItemClass] == nil or LocalPlayer().inv[self.m_strItemClass][self.m_strItemID] == nil or LocalPlayer().inv[self.m_strItemClass][self.m_strItemID][self.key] == nil then return end
      LocalPlayer():ConCommand("Inventory.Drop".." "..self.m_strItemClass.." ".. self.key .." "..self.m_strItemID.." "..(LocalPlayer().inv[self.m_strItemClass][self.m_strItemID][self.key].count or 1))
    end
    table.insert( self.m_tblTrayBtns, dentbtn3 )

	if self.m_tblItem.usable then
		local useebtn = vgui.Create( "SRP_Button", self.m_pnlBtnTray )
		useebtn:SetText( "Использовать" ) 
		useebtn.DoClick = function()
		LocalPlayer():ConCommand("Inventory.Use".." "..self.m_strItemClass.." ".. self.key .." "..self.m_strItemID)
		end
		table.insert( self.m_tblTrayBtns, useebtn )
	end
	elseif k == 'weapon' then
		local dentbtn = vgui.Create( "SRP_Button", self.m_pnlBtnTray )
		dentbtn:SetText( "Выкинуть" ) 
		dentbtn.DoClick = function()
			LocalPlayer():ConCommand("Inventory.Drop".." "..self.m_strItemClass.." ".. self.key .." "..self.m_strItemID)
		end
		table.insert( self.m_tblTrayBtns, dentbtn )
		local dentbtn2 = vgui.Create( "SRP_Button", self.m_pnlBtnTray )
		dentbtn2:SetText( "Выкинуть неск." ) 
		dentbtn2.DoClick = function()
			local InputFrame = vgui.Create("DFrame", self.m_pnlContainer)
			InputFrame:SetSize( 250, 60 )
			InputFrame:SetPos(ScrW()/2-100, ScrH()/2-25)
			InputFrame:MakePopup()
			InputFrame:SetTitle("Сколько предметов выкинуть?")

			local class = self.m_strItemClass
			local ID = self.m_strItemID
			local key = self.key
			local TextEntry = vgui.Create( "DTextEntry", InputFrame ) -- create the form as a child of frame
			TextEntry:Dock( FILL )
			TextEntry:SetNumeric(true)
			TextEntry:SetValue("Введите число, затем нажмите Enter")
			TextEntry.OnEnter = function( self )
				LocalPlayer():ConCommand("Inventory.Drop".." "..class.." ".. key .." "..ID .." "..self:GetValue())
			end
		end
		table.insert( self.m_tblTrayBtns, dentbtn2 )
		local dentbtn3 = vgui.Create( "SRP_Button", self.m_pnlBtnTray )
	    dentbtn3:SetText( "Выкинуть всё" ) 
	    dentbtn3.DoClick = function()
	      LocalPlayer():ConCommand("Inventory.Drop".." "..self.m_strItemClass.." ".. self.key .." "..self.m_strItemID.." "..LocalPlayer().inv[self.m_strItemClass][self.m_strItemID][self.key].count or 1)
	    end
	    table.insert( self.m_tblTrayBtns, dentbtn3 )
		local useebtn = vgui.Create( "SRP_Button", self.m_pnlBtnTray )
		useebtn:SetText( "Экипировать" ) 
		useebtn.DoClick = function()
			LocalPlayer():ConCommand("Inventory.Use".." "..self.m_strItemClass.." ".. self.key .." "..self.m_strItemID)
		end
		table.insert( self.m_tblTrayBtns, useebtn )
  elseif k == 'clothes' then
    local dropcbtn = vgui.Create( "SRP_Button", self.m_pnlBtnTray )
    dropcbtn:SetText( "Выкинуть" ) 
    dropcbtn.DoClick = function()
    --   LocalPlayer():ConCommand("Inventory.Drop".." "..self.m_strItemClass.." "..self.m_strItemID)
      net.Start("Inventory.DropClothes")
      net.WriteString(self.m_strItemClass)
      net.WriteString(self.m_strItemID)
      net.SendToServer()
	  
    end
    table.insert( self.m_tblTrayBtns, dropcbtn )
    local usecbtn = vgui.Create( "SRP_Button", self.m_pnlBtnTray )
    usecbtn:SetText( "Надеть") 
    usecbtn.DoClick = function()
      -- LocalPlayer():ConCommand("Inventory.Equip".." "..self.m_strItemClass.." "..self.m_strItemID)
      net.Start("Inventory.EquipClothes")
      net.WriteString(self.m_strItemClass)
      net.WriteString(self.m_strItemID)
      net.SendToServer()
    end
    table.insert( self.m_tblTrayBtns, usecbtn )
  elseif k == 'food' then 
    local dropfbtn = vgui.Create( "SRP_Button", self.m_pnlBtnTray )
    dropfbtn:SetText( "Выкинуть" ) 
    dropfbtn.DoClick = function()
      LocalPlayer():ConCommand("Inventory.Drop".." "..self.m_strItemClass.." ".. self.key .." "..self.m_strItemID)
    end
    table.insert( self.m_tblTrayBtns, dropfbtn )
    local dentbtn2 = vgui.Create( "SRP_Button", self.m_pnlBtnTray )
	dentbtn2:SetText( "Выкинуть неск." ) 
	dentbtn2.DoClick = function()
		local InputFrame = vgui.Create("DFrame", self.m_pnlContainer)
		InputFrame:SetSize( 250, 60 )
		InputFrame:SetPos(ScrW()/2-100, ScrH()/2-25)
		InputFrame:MakePopup()
		InputFrame:SetTitle("Сколько предметов выкинуть?")

		local class = self.m_strItemClass
		local ID = self.m_strItemID
		local key = self.key
		local TextEntry = vgui.Create( "DTextEntry", InputFrame ) -- create the form as a child of frame
		TextEntry:Dock( FILL )
		TextEntry:SetNumeric(true)
		TextEntry:SetValue("Введите число, затем нажмите Enter")
		TextEntry.OnEnter = function( self )
			LocalPlayer():ConCommand("Inventory.Drop".." "..class.." ".. key .." "..ID .." "..self:GetValue())
		end
	end
	table.insert( self.m_tblTrayBtns, dentbtn2 )
	local dentbtn3 = vgui.Create( "SRP_Button", self.m_pnlBtnTray )
    dentbtn3:SetText( "Выкинуть всё" ) 
    dentbtn3.DoClick = function()
    	print(self.m_strItemClass)
    	print(self.key)
    	print(self.m_strItemID)
      LocalPlayer():ConCommand("Inventory.Drop".." "..self.m_strItemClass.." ".. self.key .." "..self.m_strItemID.." "..LocalPlayer().inv[self.m_strItemClass][self.m_strItemID][self.key].count or 1)
    end
    table.insert( self.m_tblTrayBtns, dentbtn3 )
    local eatBtn = vgui.Create( "SRP_Button", self.m_pnlBtnTray )
    eatBtn:SetText( "Употребить" ) 
    eatBtn.DoClick = function()
      LocalPlayer():ConCommand("Inventory.Eat".." "..self.m_strItemClass.." "..self.m_strItemID)
    end
    table.insert( self.m_tblTrayBtns, eatBtn )
  elseif k == 'prop' then 
    local spawnpBtn = vgui.Create( "SRP_Button", self.m_pnlBtnTray )
    spawnpBtn:SetText( "Установить" ) 
    spawnpBtn.DoClick = function()
      LocalPlayer():ConCommand("Inventory.Drop".." "..self.m_strItemClass.." "..self.m_strItemID)
    end
    table.insert( self.m_tblTrayBtns, spawnpBtn )
  elseif k == 'hats' then
    local dropbtnhats = vgui.Create( "SRP_Button", self.m_pnlBtnTray )
    dropbtnhats:SetText( "Выкинуть" ) 
    dropbtnhats.DoClick = function()
      LocalPlayer():ConCommand("Inventory.Drop".." "..self.m_strItemClass.." ".. self.key .." "..self.m_strItemID)
    end
    table.insert( self.m_tblTrayBtns, dropbtnhats )
    local dentbtn2 = vgui.Create( "SRP_Button", self.m_pnlBtnTray )
	dentbtn2:SetText( "Выкинуть неск." ) 
	dentbtn2.DoClick = function()
		local InputFrame = vgui.Create("DFrame", self.m_pnlContainer)
		InputFrame:SetSize( 250, 60 )
		InputFrame:SetPos(ScrW()/2-100, ScrH()/2-25)
		InputFrame:MakePopup()
		InputFrame:SetTitle("Сколько предметов выкинуть?")

		local class = self.m_strItemClass
		local ID = self.m_strItemID
		local key = self.key
		local TextEntry = vgui.Create( "DTextEntry", InputFrame ) -- create the form as a child of frame
		TextEntry:Dock( FILL )
		TextEntry:SetNumeric(true)
		TextEntry:SetValue("Введите число, затем нажмите Enter")
		TextEntry.OnEnter = function( self )
			LocalPlayer():ConCommand("Inventory.Drop".." "..class.." ".. key .." "..ID .." "..self:GetValue())
		end
	end
	table.insert( self.m_tblTrayBtns, dentbtn2 )
	local dentbtn3 = vgui.Create( "SRP_Button", self.m_pnlBtnTray )
    dentbtn3:SetText( "Выкинуть всё" ) 
    dentbtn3.DoClick = function()
      LocalPlayer():ConCommand("Inventory.Drop".." "..self.m_strItemClass.." ".. self.key .." "..self.m_strItemID.." "..LocalPlayer().inv[self.m_strItemClass][self.m_strItemID][self.key].count or 1)
    end
    table.insert( self.m_tblTrayBtns, dentbtn3 )
    local eqBtn = vgui.Create( "SRP_Button", self.m_pnlBtnTray )
    eqBtn:SetText( "Надеть" ) 
    eqBtn.DoClick = function()
      LocalPlayer():ConCommand("Inventory.Equip".." "..self.m_strItemClass.." ".. self.key .." "..self.m_strItemID)
    end
    table.insert( self.m_tblTrayBtns, eqBtn )
  end



	self.m_pnlBtnTray:InvalidateLayout()

end

function Panel:SetItemID( strItemClass, strItemID )
	self.m_strItemID = strItemID
  self.m_strItemClass = strItemClass
	self.m_tblItem = Inventory.GetItem( strItemClass, strItemID )
  self.m_ItemButton = self
  key = self.key
	self.m_pnlNameLabel:SetText( self.m_tblItem.name )
	
	self.m_pnlIcon:SetModel( self.m_tblItem.model )

	if Cosmetics.Items[self.m_strItemID] then
		self.m_pnlIcon:SetSkin(Cosmetics.Items[self.m_strItemID].skin or 0)
	end
	if strItemClass == INV_WEAPON and key then
		self.m_pnlDescLabel:SetText("Состояние: "..math.Round(LocalPlayer().inv[strItemClass][strItemID][key].health or 100, 1).."%, Патронов внутри: "..(LocalPlayer().inv[strItemClass][strItemID][key].ammo or 0))
	elseif strItemClass == INV_ENTITY and strItemID == "flashlight" and key then
		self.m_pnlDescLabel:SetText("Заряд: "..math.Round(LocalPlayer().inv[strItemClass][strItemID][key].power or 0, 1).."%")
	else
		self.m_pnlDescLabel:SetText( self.m_tblItem.desc or 'Описания нет' )
	end

	self:InvalidateLayout()
	self:BuildTrayButtons()
end

function Panel:SetItemAmount( intAmount )
	self.m_intItemAmount = intAmount
	self.m_pnlNumLabel:SetText( "x".. intAmount )
  self.m_ItemButtonAmount = intAmount
	self:InvalidateLayout()
end

function Panel:SetItemPrice( intAmount )
	self.m_intItemPrice = intAmount
end

function Panel:Paint( intW, intH )
  draw.RoundedBox(5,0,0,intW,intH,Color(60, 60, 60, 150))
  surface.SetDrawColor(Color(150,150,150, 100))
  surface.DrawOutlinedRect(0, 0, intW, intH)
end

function Panel:PaintOver( intW, intH )
	if not self.m_tblItem then return end
	
	surface.SetFont( "font_base_18" )
	local weight = self.m_tblItem.weight and tostring( self.m_tblItem.weight * self.m_intItemAmount ) or '0'

	local wW, wH = surface.GetTextSize( weight.. "-" )
	draw.SimpleText(
		weight.." kg.",
		"font_base_18",
		intW -10, 15,
		color_white,
		TEXT_ALIGN_RIGHT
	)

end

function Panel:PerformLayout( intW, intH )
	local padding = 5

	self.m_pnlIcon:SetPos( 0, 0 )
	self.m_pnlIcon:SetSize( intH, intH )

	self.m_pnlNameLabel:SizeToContents()
	self.m_pnlNameLabel:SetPos( (padding *2) +intH, (intH /2) -self.m_pnlNameLabel:GetTall() )
	
	self.m_pnlNumLabel:SizeToContents()
	self.m_pnlNumLabel:SetPos( self.m_pnlIcon:GetWide() -self.m_pnlNumLabel:GetWide(), (intH /2) +(self.m_pnlNameLabel:GetTall() /2) -(self.m_pnlNameLabel:GetTall() /2) )


	self.m_pnlDescLabel:SizeToContents()
	self.m_pnlContainer:SetPos( (padding *2) +intH, (intH /2) )
	self.m_pnlContainer:SetSize( intW -(padding *2) +intH, self.m_pnlDescLabel:GetTall() )

	local w, h = self.m_pnlContainer:GetSize()
	self.m_pnlBtnTray:SetSize( w, h )
	self.m_pnlBtnTray:SetPos( self.m_pnlDescLabel:GetPos() )
end
vgui.Register( "SRPQMenuItemCard", Panel, "EditablePanel" )

-- ----------------------------------------------------------------

local Panel = {}
function Panel:Init()

  self.m_tblTabs = {
    { Name = "Общее", ID = "type_all", Icon = "samprp/emoji/1f4e6.png" },
    { Name = "Аксессуары", ID = "hats", Icon = "samprp/emoji/1f454.png" },
    { Name = "Одежда", ID = "clothes", Icon = "samprp/emoji/1f454.png" },
    { Name = "Предметы", ID = "entity", Icon = "samprp/emoji/1f4fa.png" },
    { Name = "Мебель", ID = "prop", Icon = "samprp/emoji/1f6cf.png" },
    { Name = "Еда", ID = "food", Icon = "samprp/emoji/1f354.png" },
    { Name = "Оружие", ID = "weapon", Icon = "samprp/emoji/1f52b.png" },
  }
  self.wb = vgui.Create("MProgressBar", self)
  self.wb:SetMax(LocalPlayer():GetDefaultSpace())
  self.wb:SetValue(LocalPlayer():GetSpace())
  self.wb:Dock(TOP)
  self.wb:DockMargin(5,10,5,0)
  self.wb:SetDesc('Инвентарь')
  self.m_tblTabPanels = {}
  self.m_pnlItemList = vgui.Create( "SPropertySheet", self )
  -- self.m_pnlItemList:DockMargin(0,10,0,0)
  -- self.m_pnlItemList:Dock(FILL)
  -- self.m_pnlItemList:SetPadding(5)
  for k, v in pairs( self.m_tblTabs ) do
    self.m_tblTabPanels[v.ID] = { Panel = vgui.Create( "SRP_ScrollPanel", self.m_pnlItemList ), Cards = {} }
    self.m_pnlItemList:AddSheet( v.Name, self.m_tblTabPanels[v.ID].Panel, v.Icon )

  end

  self:Refresh()
end

function Panel:Think()
  self.wb:SetMax(LocalPlayer():GetDefaultSpace())
  self.wb:SetValue(LocalPlayer():GetSpace())
end

function Panel:Refresh()
	for k, v in pairs( self.m_tblTabPanels ) do
		for _, card in pairs( v.Cards ) do
			if ValidPanel( card ) then card:Remove() end
		end

		v.Cards = {}
	end

	for type, classes in SortedPairs( LocalPlayer().inv ) do
    for class, itemtbls in pairs(classes) do
    for key, tbl in pairs(itemtbls) do
  		itemData = Inventory.GetItem( type, class )
  		if not itemData then continue end
  		local groupTab = type
  		groupTab = groupTab or "type_all"

  		local tabPanel = self.m_tblTabPanels[groupTab].Panel
  		local itemCard = vgui.Create( "SRPQMenuItemCard", tabPanel )
  		itemCard.key = key
  		itemCard:SetItemID( type, class )
  		itemCard:SetItemAmount( tbl.count or 1 )
  		tabPanel:AddItem( itemCard )
  		table.insert( self.m_tblTabPanels[groupTab].Cards, itemCard )

  		if groupTab ~= "type_all" then --add it to type_all too
  			local tabPanel = self.m_tblTabPanels["type_all"].Panel
  			local itemCard = vgui.Create( "SRPQMenuItemCard", tabPanel )
  		itemCard.key = key
        itemCard:SetItemID( type, class)
        itemCard:SetItemAmount( tbl.count or 1 )
        itemCard.key = key
  			tabPanel:AddItem( itemCard )
  			table.insert( self.m_tblTabPanels["type_all"].Cards, itemCard )
  		else --add to the misc tab
  			local tabPanel = self.m_tblTabPanels["type_misc"].Panel
  			local itemCard = vgui.Create( "SRPQMenuItemCard", tabPanel )
  		itemCard.key = key
        itemCard:SetItemID( type, class )
        itemCard:SetItemAmount( tbl.count or 1 )
        itemCard.key = key
  			tabPanel:AddItem( itemCard )
  			table.insert( self.m_tblTabPanels["type_misc"].Cards, itemCard )
  		end
  	end
    end
    end

	self:InvalidateLayout()
end

function Panel:PerformLayout( intW, intH )
	local w = intW *0.3
	local y = intH

	local y = 5

	self.m_pnlItemList:SetSize( intW , intH/1.07 )
	self.m_pnlItemList:SetPos( 0, intH*0.07 )

	for k, v in pairs( self.m_tblTabPanels ) do
		--v.Panel:SetPos( 0, 0 )
		--v.Panel:SetSize( self.m_pnlItemList:GetSize() )
		for _, card in pairs( v.Cards ) do
			card:SetTall( 48 )
			card:DockMargin( 0, 0, 0, 5 )
			card:Dock( TOP )
		end
	end

end
vgui.Register( "SRPQMenu_Inventory", Panel, "EditablePanel" )
