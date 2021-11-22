COLOR_WHITE = Color(255, 255, 255, 255)
COLOR_HOVER = Color(241, 209, 94, 255)
COLOR_BLACK = Color(0, 0, 0, 255)



net.Receive("Inventory.Set", function()
  LocalPlayer().inv = net.ReadTable()
  hook.Call("CosmeticsChanged", nil, self)
end)

net.Receive("Inventory.Set2", function()
	LocalPlayer().inv2 = net.ReadTable()
	if Inventory:GetTradeMenu() then
	 Inventory:RebuildTrade(Inventory.Trade.Player)
	end
	hook.Call("CosmeticsChanged", nil, self)
end)

net.Receive("Inventory.Update2", function()
  LocalPlayer().inv2[net.ReadString()] = net.ReadTable()
  if Inventory:GetTradeMenu() then
    -- Inventory.Trade.Player.inv2[net.ReadString()] = net.ReadTable()
    Inventory:RebuildTrade(Inventory.Trade.Player)
  end
   hook.Call("CosmeticsChanged", nil, self)
end)

net.Receive("Inventory.UpdateSafe2", function()
  local ply = net.ReadEntity()
  ply.inv2 = net.ReadTable()
  if Inventory:GetTradeMenu() then
    Inventory.Trade.Player.inv2 = ply.inv2
    Inventory:RebuildTrade(ply)
  end
   hook.Call("CosmeticsChanged", nil, self)
end)

-- hook.Add("InitPostEntity", "Inventory.Set", function()
--   net.Start("Inventory.Set")
--   net.SendToServer()
--   net.Start("Inventory.Set2")
--   net.SendToServer()
-- end)

net.Receive("Inventory.OpenMenu", function()
  Inventory:CreteMenu(n)
end)

net.Receive("Inventory.OpenMenuTrade", function()
  local ply = net.ReadEntity()
  Inventory:CreteTradeMenu(ply)
end)

net.Receive("Inventory.OpenMenuTrader", function()
  local id = net.ReadString()
  local ply = net.ReadEntity()
  Inventory:CreateTraderMenu(ply, id)
end)

net.Receive("Inventory.UpdateTraderMenu", function()
  local ply = net.ReadEntity()
  local id = net.ReadString()
  if Inventory:GetTraderMenu() then
    Inventory:RebuildTrader(ply, id)
  end
end)

function Inventory.GetPrintWeight(weight)
  weight = weight or 0
  if weight >= 0 then
    return  "Вес: "..weight.." кг"
  elseif weight < 0 then
    return "Вес: "..weight.." кг"
  else
    return 0
  end
end

function Inventory:CreteTradeMenu(ply)
	if Inventory.Trade && Inventory.Trade:IsValid() then
		return
	end
	inventrtype = tonumber(LocalPlayer():GetNWInt("invspace"))

	Inventory.Trade = vgui.Create( "BFrame" )
	Inventory.Trade:SetSize(1000, 600)
	Inventory.Trade:Center()
	Inventory.Trade:SetTitle( "" )
	Inventory.Trade:SetVisible( true )
	Inventory.Trade:SetDraggable( false )
	Inventory.Trade:ShowCloseButton( true )
	Inventory.Trade:MakePopup()
	Inventory.Trade:SizeToContents()
  	Inventory.Trade.Player = ply
	Inventory.Trade.Paint = function(self, w, h)
		draw.RoundedBox(0,0,0,w,h,Color(50, 50, 50, 100))
		rp.Interface.DrawBlur( self )
		surface.SetDrawColor(Color(60,60,60))
		surface.DrawOutlinedRect(0, 0, w, h)
		draw.RoundedBox( 0, 5, 55, 500, 540, Color( 60, 60, 60, 150) )
		surface.SetDrawColor(Color(0,0,0))
   		surface.DrawOutlinedRect(5, 55, 500, 540)
		draw.ShadowSimpleText( "Содержимое хранилища", "font_base_24", 260, 70, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER )
		draw.RoundedBox( 0, 510, 55, 485, 540, Color( 60, 60, 60, 150) )
		surface.SetDrawColor(Color(0,0,0))
   		surface.DrawOutlinedRect(510, 55, 485, 540)
		draw.ShadowSimpleText( "Ваш инвентарь", "font_base_24", 760, 70, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER )
	end

	Inventory.parent1 = vgui.Create( "DPanelList", Inventory.Trade )
	Inventory.parent1:SetSize( 494, 460 )
	Inventory.parent1:SetPos( 8, 100 )
	Inventory.parent1:EnableVerticalScrollbar( true )
	Inventory.parent1.Paint = function( s, w, h ) draw.RoundedBox( 0, 0, 0, w, h, Color(0,0,0,0)) end
	Inventory.parent1.VBar.Paint = function( s, w, h ) draw.RoundedBox( 4, 3, 13, 8, h-24, Color(0,0,0,70)) end
	Inventory.parent1.VBar.btnUp.Paint = function( s, w, h ) end
	Inventory.parent1.VBar.btnDown.Paint = function( s, w, h ) end
	Inventory.parent1.VBar.btnGrip.Paint = function( s, w, h )draw.RoundedBox( 4, 5, 0, 4, h+22, Color(0,0,0,70)) end

	Inventory.parent2 = vgui.Create( "DPanelList", Inventory.Trade )
	Inventory.parent2:SetSize( 480, 460 )
	Inventory.parent2:SetPos( 513, 100 )
	Inventory.parent2:EnableVerticalScrollbar( true )
	Inventory.parent2.Paint = function( s, w, h ) draw.RoundedBox( 0, 0, 0, w, h, Color(0,0,0,0)) end
	Inventory.parent2.VBar.Paint = function( s, w, h ) draw.RoundedBox( 4, 3, 13, 8, h-24, Color(0,0,0,70)) end
	Inventory.parent2.VBar.btnUp.Paint = function( s, w, h ) end
	Inventory.parent2.VBar.btnDown.Paint = function( s, w, h ) end
	Inventory.parent2.VBar.btnGrip.Paint = function( s, w, h )draw.RoundedBox( 4, 5, 0, 4, h+22, Color(0,0,0,70)) end

	self:RebuildTrade(ply)
end

function Inventory:GetTradeMenu() return Inventory.Trade && Inventory.Trade:IsValid() end

function Inventory:RebuildTrade(ply)
	local parentt = Inventory.parent1
	local parentr = Inventory.parent2
	parentt:Clear()
	parentr:Clear()
	if IsValid(tb) then tb:Remove() end
	if IsValid(ib) then ib:Remove() end
	if IsValid(plym) then plym:Remove() end

	tb = vgui.Create("MProgressBar", Inventory.Trade)
	tb:SetPos( 8, 570 )
	tb:SetSize( 494, 20 )
	tb:SetMax(LocalPlayer():GetTradeDSpace())
	tb:SetValue(LocalPlayer():GetSpace2())

	ib = vgui.Create("MProgressBar", Inventory.Trade)
	ib:SetPos( 513, 570 )
	ib:SetSize( 479, 20 )
	ib:SetMax(LocalPlayer():GetDefaultSpace())
	ib:SetValue(LocalPlayer():GetSpace())

	local spaceall = LocalPlayer():GetTradeDSpace()
	local spcaeused = LocalPlayer():GetSpace()
	for k, v in pairs(LocalPlayer().inv) do
		for item, tbl in pairs(v) do
		for key, itemtbl in pairs(tbl) do

			local itemTable1 = Inventory.GetItem(k, item)
			if !itemTable1 then continue end

			local colort =  Color( 50, 50, 50, 120 )

			local itemfr = vgui.Create( "DButton")
			itemfr:SetSize( parentt:GetWide(), 50 )
			itemfr:SetText('')
			itemfr.Paint = function( self, w, h )

				surface.SetDrawColor(Color(60,60,60))
				surface.DrawOutlinedRect(0, 0, w, h)
				draw.RoundedBox(0,0,0,w,h, colort)

				draw.ShadowSimpleText( itemTable1.name, "font_base_24",  w*0.12, h*0.08, Color( 200, 200, 200 ), TEXT_ALIGN_LEFT )
				draw.ShadowSimpleText( itemtbl.count, "font_base_24", w-15, h/4, Color( 200, 200, 200 ), TEXT_ALIGN_RIGHT )
				local text = Inventory.GetPrintWeight(itemTable1.weight)
                if k == INV_WEAPON then
                    text = text .. ", прочность: "..itemtbl.health.."%, патронов в маг: "..itemtbl.ammo
                end
				draw.ShadowSimpleText( text, "rp.ui.20",  w*0.12, 26, Color( 200, 200, 200 ), TEXT_ALIGN_LEFT )
			end

			itemfr.DoClick = function()
				local Menu = DermaMenu()
				Menu:SetSkin('core')
				Menu:AddSpacer()

				local butbtn1 = Menu:AddOption( "Переместить один" )
				butbtn1:SetIcon( "icon16/basket.png" )
				butbtn1.DoClick = function()
					LocalPlayer():ConCommand("Inventory.PutInTrade "..k.." "..item.." "..key)
				end

				Menu:AddSpacer()

				local butbtnn = Menu:AddOption( "Переместить несколько" )
				butbtnn:SetIcon( "icon16/basket_add.png" )
				butbtnn.DoClick = function()
					Derma_StringRequest(
						"Введите сколько переместить",
						"Введите количество",
						"",
						function( text )
							local num = tonumber(text)
							if not isnumber(num) then return false end
							LocalPlayer():ConCommand("Inventory.PutInTrade "..k.." "..item.." "..key.." "..tonumber(text))
						end,
						function( text ) end
					 )
				end

				Menu:AddSpacer()

				Menu:Open()

			end
			itemfr.OnCursorEntered = function( self ) colort =  Color( 60, 60, 60, 150) end
			itemfr.OnCursorExited = function( self ) colort =  Color( 50, 50, 50, 120) end

			-- icon = vgui.Create("monoIcon", itemfr)
			-- icon:SetPos( 0, 0 )
			-- icon:SetSize( itemfr:GetWide()*0.1, itemfr:GetTall() )
			-- icon:SetModel(LocalPlayer():GetModel())
			-- icon:SetModel(itemTable1.model)

			-- icon.Entity:SetSkin(v.skin or 0)

			icon = itemfr:Add("rp.itemmodel")
			icon:SetPos( 0, 0 )
			icon:SetModel(itemTable1.model)
			icon:SetSize( itemfr:GetWide()*0.1, itemfr:GetTall() )
			-- icon:DockMargin(5,5,5,5)
			icon:CenterCamera(1)

			parentr:AddItem(itemfr)
		end
		end
	end

	if not LocalPlayer().inv2 then return end

	for k, v in pairs(LocalPlayer().inv2) do
		for item, tbl in pairs(v) do
		for key, itemtbl in pairs(tbl) do
			local itemTable = Inventory.GetItem(k, item)
			if !itemTable then continue end

			local colort =  Color( 50, 50, 50, 120 )

			local itemfr = vgui.Create( "DButton")
			itemfr:SetSize( parentt:GetWide(), 50 )
			itemfr:SetText('')
			itemfr.Paint = function( self, w, h )

				surface.SetDrawColor(Color(60,60,60))
				surface.DrawOutlinedRect(0, 0, w, h)
				draw.RoundedBox(0,0,0,w,h, colort)

				draw.ShadowSimpleText( itemTable.name, "font_base_24",  w*0.12, h*0.08, Color( 200, 200, 200 ), TEXT_ALIGN_LEFT )
				draw.ShadowSimpleText( itemtbl.count, "font_base_24", w-15, h/4, Color( 200, 200, 200 ), TEXT_ALIGN_RIGHT )
				local text = Inventory.GetPrintWeight(itemTable.weight)
                if k == INV_WEAPON then
                    text = text .. ", прочность: "..itemtbl.health.."%, патронов в маг: "..itemtbl.ammo
                end
				draw.ShadowSimpleText( text, "rp.ui.20",  w*0.12, 26, Color( 200, 200, 200 ), TEXT_ALIGN_LEFT )
			end

			itemfr.DoClick = function()
				local Menu = DermaMenu()
				Menu:SetSkin('core')
				Menu:AddSpacer()

				local butbtn1 = Menu:AddOption( "Переместить один" )
				butbtn1:SetIcon( "icon16/basket.png" )
				butbtn1.DoClick = function()
					LocalPlayer():ConCommand("Inventory.TakeFromTrade "..k.." "..item.." "..key)
				end

				Menu:AddSpacer()

				local butbtnn = Menu:AddOption( "Переместить несколько" )
				butbtnn:SetIcon( "icon16/basket_add.png" )
				butbtnn.DoClick = function()
					Derma_StringRequest(
						"Введите сколько переместить",
						"Введите количество",
						"",
						function( text )
							local num = tonumber(text)
							if not isnumber(num) then return false end
							LocalPlayer():ConCommand("Inventory.TakeFromTrade "..k.." "..item.." "..key.." "..tonumber(text))
						end,
						function( text ) end
					 )
				end

				Menu:AddSpacer()

				Menu:Open()
			end
			itemfr.OnCursorEntered = function( self ) colort =  Color( 60, 60, 60, 150) end
			itemfr.OnCursorExited = function( self ) colort =  Color( 50, 50, 50, 120) end

			icon = vgui.Create("monoIcon", itemfr)
			icon:SetPos( 0, 0 )
			icon:SetSize( itemfr:GetWide()*0.1, itemfr:GetTall() )
			icon:SetModel(LocalPlayer():GetModel())
			icon:SetModel(itemTable.model)

			icon.Entity:SetSkin(v.skin or 0)

			parentt:AddItem(itemfr)
		end
		end
	end

 end


OPEN_STORAGE = nil

net.Receive("Inventory.StorageLookup", function()
	if Storage:GetMenu() then
		OPEN_STORAGE = net.ReadEntity()
		Storage:Rebuild(net.ReadTable())
	else
		Storage:CreateMenu(net.ReadEntity(), net.ReadTable())
	end
end)

function Storage:CreateMenu(ent, contents)

	OPEN_STORAGE = ent

	self.Menu = vgui.Create( "BFrame" )
	self.Menu:SetSize(1000, 600)
	self.Menu:Center()
	self.Menu:SetTitle( "" )
	self.Menu:SetVisible( true )
	self.Menu:SetDraggable( false )
	self.Menu:ShowCloseButton( true )
	self.Menu:MakePopup()
	self.Menu:SizeToContents()
	self.Menu.Paint = function(self, w, h)
		draw.RoundedBox(0,0,0,w,h,Color(50, 50, 50, 100))
		rp.Interface.DrawBlur( self )
		surface.SetDrawColor(Color(60,60,60))
		surface.DrawOutlinedRect(0, 0, w, h)
	end

	self.StorageTab = vgui.Create( "DPanelList", self.Menu )
	self.StorageTab:SetSize( 490, 500 )
	self.StorageTab:SetPos( 5, 55 )
	self.StorageTab:EnableVerticalScrollbar( true )
	self.StorageTab.Paint = function( s, w, h ) draw.RoundedBox( 0, 0, 0, w, h, Color(0,0,0,0)) end
	self.StorageTab.VBar.Paint = function( s, w, h ) draw.RoundedBox( 4, 3, 13, 8, h-24, Color(0,0,0,70)) end
	self.StorageTab.VBar.btnUp.Paint = function( s, w, h ) end
	self.StorageTab.VBar.btnDown.Paint = function( s, w, h ) end
	self.StorageTab.VBar.btnGrip.Paint = function( s, w, h )draw.RoundedBox( 4, 5, 0, 4, h+22, Color(0,0,0,70)) end

	self.InventoryTab = vgui.Create( "DPanelList", self.Menu )
	self.InventoryTab:SetSize( 490, 500 )
	self.InventoryTab:SetPos( 505, 55 )
	self.InventoryTab:EnableVerticalScrollbar( true )
	self.InventoryTab.Paint = function( s, w, h ) draw.RoundedBox( 0, 0, 0, w, h, Color(0,0,0,0)) end
	self.InventoryTab.VBar.Paint = function( s, w, h ) draw.RoundedBox( 4, 3, 13, 8, h-24, Color(0,0,0,70)) end
	self.InventoryTab.VBar.btnUp.Paint = function( s, w, h ) end
	self.InventoryTab.VBar.btnDown.Paint = function( s, w, h ) end
	self.InventoryTab.VBar.btnGrip.Paint = function( s, w, h )draw.RoundedBox( 4, 5, 0, 4, h+22, Color(0,0,0,70)) end


	self:Rebuild(contents)

	hook.Add("Think", "Storage.Think", function()
		local entity = LocalPlayer():GetEyeTrace().Entity

		if entity != OPEN_STORAGE then
			Storage:RemoveMenu()
		end

		if !IsValid(entity) then
			Storage:RemoveMenu()
		end
	end)
end

function Storage:Rebuild(contents)
	self.InventoryTab:Clear()
	self.StorageTab:Clear()
	if IsValid(stt) then stt:Remove() end
	if IsValid(int) then int:Remove() end
	if IsValid(notice1) then notice1:Remove() end
	if IsValid(notice2) then notice2:Remove() end

	stt = vgui.Create("MProgressBar", self.Menu)
	stt:SetPos( 5, 575 )
	stt:SetSize( 490, 20 )
	stt:SetMax(OPEN_STORAGE:GetDefaultSpace())
	stt:SetValue(Inventory.GetSpace(contents))

	int = vgui.Create("MProgressBar", self.Menu)
	int:SetPos( 505, 575 )
	int:SetSize( 490, 20 )
	int:SetMax(LocalPlayer():GetDefaultSpace())
	int:SetValue(LocalPlayer():GetSpace())

	notice1 = vgui.Create( "DFrame")
	notice1:SetSize( self.StorageTab:GetWide(), 35 )
	notice1:SetTitle( "" )
	notice1:ShowCloseButton( false )
	notice1:SetDraggable( false )
	notice1.Paint = function( self, w, h )
		surface.SetDrawColor(Color(60,60,60))
		surface.DrawOutlinedRect(0, 0, w, h)
		draw.RoundedBox(0,0,0,w,h,Color( 50, 50, 50, 120 ))
		draw.ShadowSimpleText( "Содержимое", "font_base_24",  w/2, 7, Color( 200, 200, 200 ), 1 )
	end
	self.StorageTab:AddItem(notice1)

	takeall = vgui.Create( "DButton")
	takeall:SetSize( self.StorageTab:GetWide(), 35 )
	takeall:SetText("")
	takeall.Paint = function( self, w, h )
		if self:IsHovered() then
			surface.SetDrawColor(Color(0,0,0,0))
			surface.DrawOutlinedRect(0, 0, w, h)
			draw.RoundedBox(0,2,2,w-4,h-4,Color( 100, 100, 100, 120 ))
			draw.ShadowSimpleText( "Взять всё", "font_base_24",  w/2, 7, Color( 200, 200, 200 ), 1 )
		else
			surface.SetDrawColor(Color(0,0,0,0))
			surface.DrawOutlinedRect(0, 0, w, h)
			draw.RoundedBox(0,2,2,w-4,h-4,Color( 50, 50, 50, 120 ))
			surface.SetDrawColor(Color(255,255,255,100))
			surface.DrawOutlinedRect(2,2, w-4, h-4)
			draw.ShadowSimpleText( "Взять всё", "font_base_24",  w/2, 7, Color( 200, 200, 200 ), 1 )
		end
	end
	takeall.DoClick = function()
		LocalPlayer():ConCommand("Inventory.TakeFromStorage "..TAKE_ALL.." "..TAKE_ALL)
	end
	self.StorageTab:AddItem(takeall)

	notice2 = vgui.Create( "DFrame")
	notice2:SetSize( self.InventoryTab:GetWide(), 35 )
	notice2:SetTitle( "" )
	notice2:ShowCloseButton( false )
	notice2:SetDraggable( false )
	notice2.Paint = function( self, w, h )
		surface.SetDrawColor(Color(60,60,60))
		surface.DrawOutlinedRect(0, 0, w, h)
		draw.RoundedBox(0,0,0,w,h,Color( 50, 50, 50, 120 ))
		draw.ShadowSimpleText( "Ваш инвентарь", "font_base_24",  w/2, 7, Color( 200, 200, 200 ), 1 )
	end
	self.InventoryTab:AddItem(notice2)

	for k, v in pairs(contents) do
		for item, tbl in pairs(v) do
		for key, itemtbl in pairs(tbl) do
			local count = itemtbl.count or 1
			local itemTable = Inventory.GetItem(k, item)
			if !itemTable then continue end
			local colort =  Color( 50, 50, 50, 120 )

			local panel = vgui.Create( "DButton")
			panel:SetSize( self.StorageTab:GetWide(), 50 )
			panel:SetText( "" )
			panel.Paint = function( self, w, h )
				surface.SetDrawColor(Color(60,60,60))
				surface.DrawOutlinedRect(0, 0, w, h)
				draw.RoundedBox(0,0,0,w,h, colort)

				draw.ShadowSimpleText( itemTable.name, "font_base_24",  w*0.12, h*0.08, Color( 200, 200, 200 ), TEXT_ALIGN_LEFT )
				draw.ShadowSimpleText( count, "font_base_24", w-15, h/4, Color( 200, 200, 200 ), TEXT_ALIGN_RIGHT )
				local text = Inventory.GetPrintWeight(itemTable.weight)
                if k == INV_WEAPON then
                    text = text .. ", прочность: "..itemtbl.health.."%, патронов в маг: "..itemtbl.ammo
                end
				draw.ShadowSimpleText( Inventory.GetPrintWeight(itemTable.weight), "font_base_24",  w*0.12, 26, Color( 200, 200, 200 ), TEXT_ALIGN_LEFT )
			end
			panel.DoClick = function()
				if k == INV_CLOTHES then
					net.Start("Inventory.TakeFromStorageClothes")
					net.WriteString(k)
					net.WriteString(item)
					net.SendToServer()
				else
					local Menu = DermaMenu()
					Menu:SetSkin('core')
					Menu:AddSpacer()

					local butbtn1 = Menu:AddOption( "Переместить один" )
					butbtn1:SetIcon( "icon16/basket.png" )
					butbtn1.DoClick = function()
						LocalPlayer():ConCommand("Inventory.TakeFromStorage "..k.." "..item.." "..key)
					end

					Menu:AddSpacer()

					local butbtnn = Menu:AddOption( "Переместить несколько" )
					butbtnn:SetIcon( "icon16/basket_add.png" )
					butbtnn.DoClick = function()
						Derma_StringRequest(
							"Введите сколько переместить",
							"Введите количество",
							"",
							function( text )
								local num = tonumber(text)
								if not isnumber(num) then return false end
								LocalPlayer():ConCommand("Inventory.TakeFromStorage "..k.." "..item.." "..key.." "..tonumber(text))
							end,
							function( text ) end
						 )
					end

					Menu:AddSpacer()

					Menu:Open()
				end
			end
			panel.OnCursorEntered = function( self ) colort =  Color( 60, 60, 60, 150) end
			panel.OnCursorExited = function( self ) colort =  Color( 50, 50, 50, 120) end

			icon = vgui.Create("monoIcon", panel)
			icon:SetPos( 0, 0 )
			icon:SetSize( panel:GetWide()*0.1, panel:GetTall() )
			icon:SetModel(LocalPlayer():GetModel())
			icon:SetModel(itemTable.model)

			self.StorageTab:AddItem(panel)
		end
		end
	end

	for k, v in pairs(LocalPlayer().inv) do
		for item, tbl in pairs(v) do
		for key, itemtbl in pairs(tbl) do
			local count = itemtbl.count or 1
			local itemTable = Inventory.GetItem(k, item)
			if !itemTable then continue end
			local colort =  Color( 50, 50, 50, 120 )

			local panel = vgui.Create( "DButton")
			panel:SetSize( self.StorageTab:GetWide(), 50 )
			panel:SetText( "" )
			panel.Paint = function( self, w, h )
				surface.SetDrawColor(Color(60,60,60))
				surface.DrawOutlinedRect(0, 0, w, h)
				draw.RoundedBox(0,0,0,w,h, colort)

				draw.ShadowSimpleText( itemTable.name, "font_base_24",  w*0.12, h*0.08, Color( 200, 200, 200 ), TEXT_ALIGN_LEFT )
				draw.ShadowSimpleText( count, "font_base_24", w-15, h/4, Color( 200, 200, 200 ), TEXT_ALIGN_RIGHT )
				local text = Inventory.GetPrintWeight(itemTable.weight)
                if k == INV_WEAPON then
                    text = text .. ", прочность: "..itemtbl.health.."%, патронов в маг: "..itemtbl.ammo
                end
				draw.ShadowSimpleText( Inventory.GetPrintWeight(itemTable.weight), "font_base_24",  w*0.12, 26, Color( 200, 200, 200 ), TEXT_ALIGN_LEFT )
			end
			panel.DoClick = function()
				if k == INV_CLOTHES then
					net.Start("Inventory.PutInStorageClothes")
					net.WriteString(k)
					net.WriteString(item)
					net.SendToServer()
				else
					local Menu2 = DermaMenu()
					Menu2:SetSkin('core')
					Menu2:AddSpacer()

					local butbtn1 = Menu2:AddOption( "Переместить один" )
					butbtn1:SetIcon( "icon16/basket.png" )
					butbtn1.DoClick = function()
						LocalPlayer():ConCommand("Inventory.PutInStorage "..k.." "..item.." "..key)
					end

					Menu2:AddSpacer()

					local butbtnn = Menu2:AddOption( "Переместить несколько" )
					butbtnn:SetIcon( "icon16/basket_add.png" )
					butbtnn.DoClick = function()
						Derma_StringRequest(
							"Введите сколько переместить",
							"Введите количество",
							"",
							function( text )
								local num = tonumber(text)
								if not isnumber(num) then return false end
								LocalPlayer():ConCommand("Inventory.PutInStorage "..k.." "..item.." "..key.." "..tonumber(text))
							end,
							function( text ) end
						 )
					end

					Menu2:AddSpacer()

					Menu2:Open()
				end
			end
			panel.OnCursorEntered = function( self ) colort =  Color( 60, 60, 60, 150) end
			panel.OnCursorExited = function( self ) colort =  Color( 50, 50, 50, 120) end

			icon = vgui.Create("monoIcon", panel)
			icon:SetPos( 0, 0 )
			icon:SetSize( panel:GetWide()*0.1, panel:GetTall() )
			icon:SetModel(LocalPlayer():GetModel())
			icon:SetModel(itemTable.model)

			self.InventoryTab:AddItem(panel)
		end
		end
	end
end

function Storage:GetMenu()
	return self.Menu && self.Menu:IsValid()
end

function Storage:RemoveMenu()
	hook.Remove("Think", "Storage.Think")

	self.Menu:Remove()

	-- net.Start("Inventory.CloseStorage")
	-- net.SendToServer()
end

-----------------------
function Inventory:CreateTraderMenu(ply, id)
	if Inventory.Trader && Inventory.Trader:IsValid() then
		return
	end

	Inventory.Trader = vgui.Create( "BFrame" )
	Inventory.Trader:SetSize(1000, 600)
	Inventory.Trader:Center()
	Inventory.Trader:SetTitle( "" )
	Inventory.Trader:SetVisible( true )
	Inventory.Trader:SetDraggable( false )
	Inventory.Trader:ShowCloseButton( true )
	Inventory.Trader:MakePopup()
	Inventory.Trader:SizeToContents()
  	Inventory.Trader.Player = ply
	Inventory.Trader.Paint = function(self, w, h)
		draw.RoundedBox(0,0,0,w,h,Color(50, 50, 50, 100))
		rp.Interface.DrawBlur( self )
		surface.SetDrawColor(Color(60,60,60))
		surface.DrawOutlinedRect(0, 0, w, h)
		draw.RoundedBox( 0, 5, 55, 500, 540, Color( 60, 60, 60, 150) )
		surface.SetDrawColor(Color(0,0,0))
		draw.ShadowSimpleText( "Ваши деньги: "..LocalPlayer():GetMoney() .." монет", "font_base_24", 15, 15, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT )
   	surface.DrawOutlinedRect(5, 55, 500, 540)
		draw.ShadowSimpleText( "Доступно к покупке", "font_base_24", 260, 70, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER )
		draw.RoundedBox( 0, 510, 55, 485, 540, Color( 60, 60, 60, 150) )
		surface.SetDrawColor(Color(0,0,0))
   	surface.DrawOutlinedRect(510, 55, 485, 540)
		draw.ShadowSimpleText( "Ваш инвентарь", "font_base_24", 760, 70, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER )
	end

	Inventory.parent1 = vgui.Create( "DPanelList", Inventory.Trader )
	Inventory.parent1:SetSize( 494, 460 )
	Inventory.parent1:SetPos( 8, 100 )
	Inventory.parent1:EnableVerticalScrollbar( true )
	Inventory.parent1.Paint = function( s, w, h ) draw.RoundedBox( 0, 0, 0, w, h, Color(0,0,0,0)) end
	Inventory.parent1.VBar.Paint = function( s, w, h ) draw.RoundedBox( 4, 3, 13, 8, h-24, Color(0,0,0,70)) end
	Inventory.parent1.VBar.btnUp.Paint = function( s, w, h ) end
	Inventory.parent1.VBar.btnDown.Paint = function( s, w, h ) end
	Inventory.parent1.VBar.btnGrip.Paint = function( s, w, h )draw.RoundedBox( 4, 5, 0, 4, h+22, Color(0,0,0,70)) end

	Inventory.parent2 = vgui.Create( "DPanelList", Inventory.Trader )
	Inventory.parent2:SetSize( 480, 460 )
	Inventory.parent2:SetPos( 513, 100 )
	Inventory.parent2:EnableVerticalScrollbar( true )
	Inventory.parent2.Paint = function( s, w, h ) draw.RoundedBox( 0, 0, 0, w, h, Color(0,0,0,0)) end
	Inventory.parent2.VBar.Paint = function( s, w, h ) draw.RoundedBox( 4, 3, 13, 8, h-24, Color(0,0,0,70)) end
	Inventory.parent2.VBar.btnUp.Paint = function( s, w, h ) end
	Inventory.parent2.VBar.btnDown.Paint = function( s, w, h ) end
	Inventory.parent2.VBar.btnGrip.Paint = function( s, w, h )draw.RoundedBox( 4, 5, 0, 4, h+22, Color(0,0,0,70)) end

	self:RebuildTrader(ply, id)
end

function Inventory:GetTraderMenu() return Inventory.Trader && Inventory.Trader:IsValid() end

function Inventory:RebuildTrader(ply, id)
	local parentt = Inventory.parent1
	local parentr = Inventory.parent2
	parentt:Clear()
	parentr:Clear()
	if IsValid(ib) then ib:Remove() end
	if IsValid(plym) then plym:Remove() end

	ib = vgui.Create("MProgressBar", Inventory.Trader)
	ib:SetPos( 513, 570 )
	ib:SetSize( 479, 20 )
	ib:SetMax(LocalPlayer():GetDefaultSpace())
	ib:SetValue(LocalPlayer():GetSpace())

	local spaceall = LocalPlayer():GetTradeDSpace()
	local spcaeused = LocalPlayer():GetSpace()
	for k, v in pairs(LocalPlayer().inv) do
		for item, tbl in pairs(v) do
		for key, itemtbl in pairs(tbl) do

			-- if not rp.Traders.Config[id].itemsforbuy[item] then continue end

			local itemTable1 = Inventory.GetItem(k, item)
			if !itemTable1 then continue end

			local colort =  Color( 50, 50, 50, 120 )

			local itemfr = vgui.Create( "DButton")
			itemfr:SetSize( parentt:GetWide(), 50 )
			itemfr:SetText('')
			itemfr.Paint = function( self, w, h )

				surface.SetDrawColor(Color(60,60,60))
				surface.DrawOutlinedRect(0, 0, w, h)
				draw.RoundedBox(0,0,0,w,h, colort)

				draw.ShadowSimpleText( itemTable1.name, "font_base_24",  w*0.12, h*0.08, Color( 200, 200, 200 ), TEXT_ALIGN_LEFT )
				draw.ShadowSimpleText( itemtbl.count, "font_base_24", w-15, h/4, Color( 200, 200, 200 ), TEXT_ALIGN_RIGHT )
				draw.ShadowSimpleText( rp.Traders.Config[id].itemsforbuy[item] and ("Цена: "..rp.Traders.Config[id].itemsforbuy[item].."м.") or "Цена: не продаётся", "font_base_24",  w*0.12, 26, Color( 200, 200, 200 ), TEXT_ALIGN_LEFT )
			end

			itemfr.DoClick = function()
				if not rp.Traders.Config[id].itemsforbuy[item] then return end
				local Menu = DermaMenu()
				Menu:SetSkin('core')
				Menu:AddSpacer()

				local butbtn1 = Menu:AddOption( "Продать "..itemTable1.name.. " (x1)" )
				butbtn1:SetIcon( "icon16/basket.png" )
				butbtn1.DoClick = function()
					net.Start("rp.Traders.SellItem")
					net.WriteString(item)
					net.WriteString(k)
					net.WriteInt(key, 32)
					net.WriteInt(1, 32)
					net.WriteString(id)
					net.SendToServer()
				end

				Menu:AddSpacer()

				local butbtnn = Menu:AddOption( "Продать "..itemTable1.name.. " (несколько)" )
				butbtnn:SetIcon( "icon16/basket_add.png" )
				butbtnn.DoClick = function()
					Derma_StringRequest(
						"Продать "..itemTable1.name.. " (несколько)",
						"Введите количество",
						"",
						function( text )
							local num = tonumber(text)
							if not isnumber(num) then return false end
							net.Start("rp.Traders.SellItem")
							net.WriteString(item)
							net.WriteString(k)
							net.WriteInt(key, 32)
							net.WriteInt(text, 32)
							net.WriteString(id)
							net.SendToServer()
						end,
						function( text ) end
					 )
				end

				Menu:AddSpacer()

				Menu:Open()
			end
			itemfr.OnCursorEntered = function( self ) colort =  Color( 60, 60, 60, 150) end
			itemfr.OnCursorExited = function( self ) colort =  Color( 50, 50, 50, 120) end

			icon = vgui.Create("monoIcon", itemfr)
			icon:SetPos( 0, 0 )
			icon:SetSize( itemfr:GetWide()*0.1, itemfr:GetTall() )
			icon:SetModel(LocalPlayer():GetModel())
			icon:SetModel(itemTable1.model)

			icon.Entity:SetSkin(v.skin or 0)

			parentr:AddItem(itemfr)
		end
		end
	end

	local shoplist = rp.Traders.Config[id].items

	if not shoplist then return end

	for k, v in pairs(shoplist) do
		local itemTable, itemtype = Inventory.GetItemByClass(class)
		if !itemTable then continue end

		local colort =  Color( 30, 30, 30, 120 )

		local itemfr = vgui.Create( "DButton")
		itemfr:SetSize( parentt:GetWide(), 50 )
		itemfr:SetText('')
		itemfr.Paint = function( self, w, h )
			surface.SetDrawColor(Color(100,100,100))
			surface.DrawOutlinedRect(0, 0, w, h)
			draw.RoundedBox(0,0,0,w,h, colort)

			draw.ShadowSimpleText( itemTable.name, "font_base_24",  w*0.12, h/4, Color( 200, 200, 200 ), TEXT_ALIGN_LEFT )
			draw.ShadowSimpleText( v .. ' м.', "font_base_24", w-15, h/4, Color( 200, 200, 200 ), TEXT_ALIGN_RIGHT )
		end

		itemfr.DoClick = function()
			local Menu = DermaMenu()
			Menu:SetSkin('core')
			Menu:AddSpacer()

			local butbtn1 = Menu:AddOption( "Купить "..itemTable.name.. " (x1)" )
			butbtn1:SetIcon( "icon16/basket.png" )
			butbtn1.DoClick = function()
				net.Start("rp.Traders.BuyItem")
				net.WriteString(k)
				net.WriteString(itemtype)
				net.WriteInt(1, 32)
				net.WriteString(id)
				net.SendToServer()
			end

			Menu:AddSpacer()

			local butbtnn = Menu:AddOption( "Купить "..itemTable.name.. " (несколько)" )
			butbtnn:SetIcon( "icon16/basket_add.png" )
			butbtnn.DoClick = function()
				Derma_StringRequest(
					"Купить "..itemTable.name.. " (несколько)",
					"Введите количество",
					"",
					function( text )
						local num = tonumber(text)
						if not isnumber(num) then return false end
						net.Start("rp.Traders.BuyItem")
						net.WriteString(k)
						net.WriteString(itemtype)
						net.WriteInt(text, 32)
						net.WriteString(id)
						net.SendToServer()
					end,
					function( text ) end
				 )
			end

			Menu:AddSpacer()

			Menu:Open()
		end
		itemfr.OnCursorEntered = function( self ) colort =  Color( 60, 60, 60, 150) end
		itemfr.OnCursorExited = function( self ) colort =  Color( 30, 30, 30, 120) end

		icon = vgui.Create("monoIcon", itemfr)
		icon:SetPos( 0, 0 )
		icon:SetSize( itemfr:GetWide()*0.1, itemfr:GetTall() )
		icon:SetModel(LocalPlayer():GetModel())
		icon:SetModel(itemTable.model)

		icon.Entity:SetSkin(v.skin or 0)

		parentt:AddItem(itemfr)
	end
 end

local itemcount = nil
local waitingforanswer = false

hook.Add("HUDPaint", "ENT.OverlayTexts", function()
  	local ent = LocalPlayer():GetEyeTrace().Entity
 	if itemcount and not IsValid(ent) then
 		itemcount = nil
 	end
   if IsValid(ent) then

		if (ent:GetPos():Distance(LocalPlayer():GetPos()) <= 150) then

			local type = ""
			local class = ent:GetClass()

			if class == "spawned_weapon" then
				type = INV_WEAPON
				class = ent.weaponclass
			elseif class == "spawned_food" then
				type = INV_FOOD
				class = ent:GetModel()
			elseif class == "loot_container" then
				draw.OverlayText(ent, nil, "Хм...Кажется, здесь что-то есть!\nНажмите <color=158,194,255>'E'</color>, чтобы обыскать")
			elseif class == "cm_cloth" then
				local infos = LocalPlayer():CM_GetInfos()
				type = INV_CLOTHES
				class = ent.Texture
				sex = ent.sex or ent.Sex
			elseif class == "rp_cosmetics" then
				for k, v in pairs(Cosmetics.Items) do
					if k == ent:GetCosmeticType() then
						type = INV_HATS
						class = ent:GetCosmeticType()
					end
				end
			else
				for k, v in pairs(rp.entities) do
					if v.ent == class then
						type = INV_ENTITY
						class = class
						break
					end
				end
			end


		   	local itemTable = Inventory.GetItem(type, class)
			if not itemTable then
				itemcount = nil
				return
			end

			if not itemcount and not waitingforanswer then
				net.Start("Inventory.SendItemCount")
					net.WriteEntity(ent)
				net.SendToServer()
				waitingforanswer = true
			end

			draw.OverlayText(ent, nil, itemTable.name.."(x"..(itemcount and itemcount or "...")..")\nНажмите <color=158,194,255>'E'</color>, чтобы подобрать")
		end
   end

end)

hook.Add("HUDPaint", "ENT.TrunkOverlayTexts", function()
  	local ent = LocalPlayer():GetEyeTrace().Entity
		if IsValid(ent) and ent:GetClass() == "gmod_sent_vehicle_fphysics_base" then
			if (ent:GetPos():Distance(LocalPlayer():GetPos()) <= 150) then
				if ent:GetNVar("TrunkLocked") == true then
					draw.TrunkOverlayText(ent, nil, "Багажник <color=200,0,0>(Закрыт)</color>\nНажмите <color=158,194,255>'E'</color>, чтобы обыскать")
				else
					draw.TrunkOverlayText(ent, nil, "Багажник <color=0,200,0>(Открыт)</color>\nНажмите <color=158,194,255>'E'</color>, чтобы обыскать")
				end
 			end
 		end

end)

net.Receive("Inventory.SendItemCountToClient", function()
	waitingforanswer = false
	itemcount = net.ReadInt(20)
end)

net.Receive("Inventory.CloseStorage", function(_, ply)
	if Storage.Menu then Storage.Menu:Remove() end
end)

-- -- TRUNK
-- local iScale = 0.09
-- local menuSize = { x = 2000, y = 740 + 35 }
-- hook.Add( "PostDrawTranslucentRenderables", "CarTrunk.PostDrawTranslucentRenderables", function()

-- 		for k, eVehicle in pairs(ents.GetAll()) do
-- 			if eVehicle:GetClass() != "gmod_sent_vehicle_fphysics_base" then continue end



-- 		local aAngle = Angle( 0, 0, 90  )
-- 		local vPosition = Vector( eVehicle:OBBCenter()[1], eVehicle:OBBMins()[2], 70 )
-- 		-- if tSpecificVehicles[ eVehicle:GetVehicleClass() ] and tSpecificVehicles[ eVehicle:GetVehicleClass() ].trunkAngle then
-- 		-- 	aAngle = aAngle + tSpecificVehicles[ eVehicle:GetVehicleClass() ].trunkAngle
-- 		-- end
-- 		-- if tSpecificVehicles[ eVehicle:GetVehicleClass() ] and tSpecificVehicles[ eVehicle:GetVehicleClass() ].trunkPosition then
-- 		-- 	vPosition = vPosition + tSpecificVehicles[ eVehicle:GetVehicleClass() ].trunkPosition
-- 		-- end

-- 		vPosition = eVehicle:LocalToWorld( vPosition - Vector(0,0,30))
-- 		aAngle = eVehicle:LocalToWorldAngles( aAngle )

-- 		if (vPosition:Distance(LocalPlayer():GetPos()) >= 80) then continue end

-- 		cam.Start3D2D( vPosition, aAngle, iScale )
-- 			  local markup_obj = markup.Parse("<font=font_base_18>".."Багажник автомобиля\nНажмите <color=158,194,255>'E'</color>, чтобы заглянуть".."</font>")
-- 				markup_obj:Draw( 0, 0, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 255 )
-- 		cam.End3D2D()
-- 	end

-- end )