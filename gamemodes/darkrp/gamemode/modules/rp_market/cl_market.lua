net.Receive("rp.Market.Sync", function()
    local data = net.ReadTable()
    rp.Market.Data = data
end)

net.Receive("rp.Market.Refresh", function()
    local marketid = net.ReadInt(32)
    local category = net.ReadString()
    net.Start("rp.Market.SyncFromMenu") 
    net.SendToServer()
    timer.Simple(.2, function()
        rp.Market.Setup(marketid, category)
    end)
end)

net.Receive("rp.Market.RefreshSeller", function()
    local marketid = net.ReadInt(32)
    local category = net.ReadString()
    net.Start("rp.Market.SyncFromMenu") 
    net.SendToServer()
    timer.Simple(.2, function()
        rp.Market.SellerSetup(marketid, category)
    end)
    
end)

local glowMat = Material( "particle/Particle_Glow_04_Additive" )

function rp.Market.OpenMenu(marketid, category)
    net.Start("rp.Market.SyncFromMenu") 
    net.SendToServer()
    if IsValid(rp.Market.SellerMenu) then rp.Market.SellerMenu:Remove() end
    
    local category = category or nil
    local searchable = nil

    rp.Market.Menu = vgui.Create( "BFrame" )
    rp.Market.Menu:SetSize(ScrW()/1.2, ScrH()/1.5) 
    rp.Market.Menu:Center() 
    rp.Market.Menu:SetTitle( "Торговый рынок " .. marketid)  
    rp.Market.Menu:SetVisible( true )
    rp.Market.Menu:SetDraggable( false ) 
    rp.Market.Menu:ShowCloseButton( true )
    rp.Market.Menu:MakePopup()
    rp.Market.Menu:SizeToContents()

    rp.Market.Menu.Cats = rp.Market.Menu:Add( "DPanelList")
    rp.Market.Menu.Cats:Dock(LEFT)
    rp.Market.Menu.Cats:DockMargin(0,0,5,0)
    rp.Market.Menu.Cats:SetWide(rp.Market.Menu:GetWide()/4)
    rp.Market.Menu.Cats:EnableVerticalScrollbar( true )
    rp.Market.Menu.Cats.Paint = function( s, w, h ) draw.RoundedBox( 0, 0, 0, w, h, Color(255,0,0,0)) end
    rp.Market.Menu.Cats.VBar.Paint = function( s, w, h ) draw.RoundedBox( 4, 3, 13, 8, h-24, Color(0,0,0,70)) end
    rp.Market.Menu.Cats.VBar.btnUp.Paint = function( s, w, h ) end
    rp.Market.Menu.Cats.VBar.btnDown.Paint = function( s, w, h ) end
    rp.Market.Menu.Cats.VBar.btnGrip.Paint = function( s, w, h ) draw.RoundedBox( 4, 5, 0, 4, h+22, Color(0,0,0,70)) end

    for k, data in pairs(rp.Market.Cats) do
        local colort =  Color( 30, 30, 30, 120 )

        local ItemCat = rp.Market.Menu.Cats:Add("BButton")
        ItemCat:Dock(TOP)
        ItemCat:DockMargin(0,3,0,0)
        ItemCat:SetTall(50)
        ItemCat:SetText("")
        ItemCat.Paint = function( self, w, h )
            surface.SetDrawColor(Color(60,60,60))
            surface.DrawOutlinedRect(0, 0, w, h)
            draw.RoundedBox(0,0,0,w,h, colort)
            draw.ShadowSimpleText( data.name, "font_base_24",  w/2, h/2, Color( 200, 200, 200 ), 1, 1 )
        end
        ItemCat.OnCursorEntered = function( self ) colort =  Color( 60, 60, 60, 150) end
        ItemCat.OnCursorExited = function( self ) colort =  Color( 30, 30, 30, 120) end
            
        ItemCat.DoClick = function() 
            rp.Market.Setup(marketid, k)
            category = k
        end

    end

    local colort =  Color( 30, 30, 30, 120 )

    local SellerMenu = rp.Market.Menu.Cats:Add("BButton")
    SellerMenu:Dock(BOTTOM)
    SellerMenu:DockMargin(0,3,0,0)
    SellerMenu:SetTall(30)
    SellerMenu:SetText("")
    SellerMenu:SetToolTip("Нажмите, чтобы снять деньги")
    SellerMenu.Paint = function( self, w, h )
        surface.SetDrawColor(Color(60,60,60))
        surface.DrawOutlinedRect(0, 0, w, h)
        draw.RoundedBox(0,0,0,w,h, colort)
        draw.ShadowSimpleText( "Баланс: "..rp.FormatMoney(LocalPlayer():GetNVar('MarketMoney')), "font_base_24",  w/2, h/2, Color( 200, 200, 200 ), 1, 1 )
    end
    SellerMenu.OnCursorEntered = function( self ) colort =  Color( 60, 60, 60, 150) end
    SellerMenu.OnCursorExited = function( self ) colort =  Color( 30, 30, 30, 120) end
        
    SellerMenu.DoClick = function() 
        net.Start("rp.Market.TakeBankMoney")
        net.SendToServer()
    end

    local MyMoney = rp.Market.Menu.Cats:Add("BButton")
    MyMoney:Dock(BOTTOM)
    MyMoney:DockMargin(0,3,0,0)
    MyMoney:SetTall(30)
    MyMoney:SetText("")
    MyMoney.Paint = function( self, w, h )
        surface.SetDrawColor(Color(60,60,60))
        surface.DrawOutlinedRect(0, 0, w, h)
        draw.RoundedBox(0,0,0,w,h,  Color( 30, 30, 30, 120))
        draw.ShadowSimpleText( "Мои монеты: "..rp.FormatMoney(LocalPlayer():GetMoney()), "font_base_24",  w/2, h/2, Color( 200, 200, 200 ), 1, 1 )
    end


    rp.Market.PanelForSearchAndFilters = rp.Market.Menu:Add( "DPanel")
    rp.Market.PanelForSearchAndFilters:DockMargin(0,5,14,5)
    rp.Market.PanelForSearchAndFilters:SetSkin('core')
    rp.Market.PanelForSearchAndFilters:Dock(TOP)
    rp.Market.PanelForSearchAndFilters:SetVisible(false)
    rp.Market.PanelForSearchAndFilters:SetTall( 30 )

    rp.Market.Search = rp.Market.PanelForSearchAndFilters:Add( "DTextEntry")
    rp.Market.Search:SetSkin('core')
    rp.Market.Search:Dock(LEFT)
    rp.Market.Search:SetVisible(true)
    rp.Market.Search:SetWide(rp.Market.Menu:GetWide()*0.3)
    rp.Market.Search:SetValue( "Введите название и нажмите ENTER" )
    rp.Market.Search.OnEnter = function( self )
        rp.Market.Setup(marketid, category)
    end

    rp.Market.Filters = rp.Market.PanelForSearchAndFilters:Add( "DComboBox")
    rp.Market.Filters:SetSkin('core')
    rp.Market.Filters:DockMargin(10,0,0,0)
    rp.Market.Filters:SetValue("Фильтр")
    rp.Market.Search:SetVisible(true)
    rp.Market.Filters:Dock(LEFT)
    rp.Market.Filters:SetWide(rp.Market.Menu:GetWide()*0.2)
    rp.Market.Filters:AddChoice("Сначала старые")
    rp.Market.Filters:AddChoice("Сначала новые")
    rp.Market.Filters:AddChoice("По убыванию(цена)")
    rp.Market.Filters:AddChoice("По возрастанию(цена)")
    function rp.Market.Filters:OnSelect(index, value, data)
        rp.Market.Setup(marketid, category)
    end


    rp.Market.Menu.Items = rp.Market.Menu:Add( "DScrollPanel")
    rp.Market.Menu.Items:Dock(FILL)
    rp.Market.Menu.Items.Paint = function( s, w, h ) draw.RoundedBox( 0, 0, 0, w, h, Color(0,255,0,0)) end
    rp.Market.Menu.Items.VBar.Paint = function( s, w, h ) draw.RoundedBox( 4, 3, 13, 8, h-24, Color(0,0,0,70)) end
    rp.Market.Menu.Items.VBar.btnUp.Paint = function( s, w, h ) end
    rp.Market.Menu.Items.VBar.btnDown.Paint = function( s, w, h ) end
    rp.Market.Menu.Items.VBar.btnGrip.Paint = function( s, w, h )draw.RoundedBox( 4, 5, 0, 4, h+22, Color(0,0,0,70)) end

end

function rp.Market.Setup(marketid, category)
    if rp.Market.Menu and rp.Market.Menu.Items then
        rp.Market.Menu.Items:Clear()
        rp.Market.PanelForSearchAndFilters:SetVisible(true)
        local Filtering = rp.Market.Filters:GetValue()
        local SortedTable = {}
        
        if Filtering == "Сначала новые" then
            local tblleng = #rp.Market.Data
            for i = 1, tblleng do
                SortedTable[i] = rp.Market.Data[tblleng-i+1]
            end
        elseif Filtering == "Сначала старые" or Filtering == "Фильтр" then
            SortedTable = rp.Market.Data
        elseif Filtering == "По убыванию(цена)" then
            SortedTable = rp.Market.Data
            table.sort( SortedTable, function(a, b) return a.price > b.price end )
        elseif Filtering == "По возрастанию(цена)" then
            SortedTable = rp.Market.Data
            table.sort( SortedTable, function(a, b) return a.price < b.price end )
        end

        for k, data in pairs(SortedTable) do
            if data.marketid == marketid and data.category == category then      
                local itemTable = Inventory.GetItem(data.category, data.class)
                if !itemTable then continue end

                local tbl = util.JSONToTable(data.tbl)

                local searchable = rp.Market.Search:GetValue() == "Введите название и нажмите ENTER" and "" or rp.Market.Search:GetValue()
                if not string.match( itemTable.name, searchable ) then continue end

                local colort =  Color( 30, 30, 30, 120 )

                local Item = rp.Market.Menu.Items:Add("BButton")
                Item:Dock(TOP)
                Item:DockMargin(0,3,0,0)
                Item:SetTall(70)
                Item:SetText("")
                Item.Paint = function( self, w, h )
                end

                local iconPanel = Item:Add("monoPanel")
                iconPanel:Dock(LEFT)
                iconPanel:SetPos( 0, 0 )
                iconPanel:SetSize( Item:GetWide(), Item:GetTall() )
                iconPanel.Paint = function(s,w,h)
                    glowColor = Color( 200, 200, 200, 100 )
                    
                    draw.RoundedBox(0,0,0,w,h, Color(glowColor.r,glowColor.g,glowColor.b,40))
                    draw.OutlinedBox(0, 0, w, h, Color(0,0,0,0), glowColor)
                    surface.SetDrawColor( glowColor )
                    surface.SetMaterial( glowMat )
                    surface.DrawTexturedRect( 0 - ( w*0.3 ), 0 - ( h*0.3 ), w * 3, h * 3 )
                end
                iconPanel.monoIcon = iconPanel:Add( "monoIcon" )
                iconPanel.monoIcon:SetModel( itemTable.model )
                iconPanel.monoIcon.Entity:SetSkin( 0 )
                iconPanel.monoIcon:Dock( FILL )
                iconPanel.monoIcon:DockMargin( 5, 5, 5, 5 )
                iconPanel.monoIcon.PaintOver = function() end

                local ItemDesc = Item:Add("DButton")
                ItemDesc:Dock(FILL)
                ItemDesc:SetText("")
                ItemDesc.Paint = function( self, w, h )
                    surface.SetDrawColor(Color(60,60,60))
                    surface.DrawOutlinedRect(0, 0, w, h)
                    draw.RoundedBox(0,0,0,w,h, colort)
                    
                    draw.ShadowSimpleText( itemTable.name.." ("..data.price.."$ )", "rp.ui.20",  w*0.01, 5, Color( 235, 235, 235 ), TEXT_ALIGN_LEFT )
                    draw.ShadowSimpleText( "Кол-во: "..tbl.count, "rp.ui.18", w-5, 50, Color( 200, 200, 200 ), TEXT_ALIGN_RIGHT )
                    draw.ShadowSimpleText( KitsFormatTimeNice(data.exptime), "rp.ui.18", w*0.7, 25, Color( 200, 200, 200 ), TEXT_ALIGN_RIGHT )
                    draw.ShadowSimpleText( data.price .. " м.", "rp.ui.26", w-15, 20, Color( 235, 235, 235 ), TEXT_ALIGN_RIGHT )
                    local text = Inventory.GetPrintWeight(itemTable.weight)
                    if data.category == INV_WEAPON then 
                        text = text .. ", прочность: "..tbl.health.."%, патронов в маг: "..tbl.ammo
                    end
                    draw.ShadowSimpleText( text, "rp.ui.20",  w*0.01, 25, Color( 235, 235, 235 ), TEXT_ALIGN_LEFT )
                    draw.ShadowSimpleText( "Продавец: "..data.sellername, "rp.ui.20",  w*0.01, 45, Color( 235, 235, 235 ), TEXT_ALIGN_LEFT )
                end
                ItemDesc.OnCursorEntered = function( self ) colort =  Color( 60, 60, 60, 150) end
                ItemDesc.OnCursorExited = function( self ) colort =  Color( 30, 30, 30, 120) end            
                ItemDesc.DoClick = function() 
                    local Menu = DermaMenu()
                    Menu:SetSkin('core')
                    Menu:AddSpacer()

                    local butbtn1 = Menu:AddOption( "Купить "..itemTable.name.. " (x1)" )
                    butbtn1:SetIcon( "icon16/basket.png" )
                    butbtn1.DoClick = function()
                        net.Start("rp.Market.BuyItem")
                        net.WriteInt(data.itemid, 32)
                        net.WriteInt(1, 31)
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
                                net.Start("rp.Market.BuyItem")
                                net.WriteInt(data.itemid, 32)
                                net.WriteInt(num, 31)
                                net.SendToServer()
                            end,
                            function( text ) end
                        )
                    end

                    Menu:AddSpacer()

                    Menu:Open()
                end        
            end
        end
    end
end

-- Мой рынок
function rp.Market.OpenSellerMenu(marketid, category)
    if IsValid(rp.Market.Menu) then rp.Market.Menu:Remove() end

    local category = category or nil
    local searchable = nil

    rp.Market.SellerMenu = vgui.Create( "BFrame" )
    rp.Market.SellerMenu:SetSize(ScrW()/1.2, ScrH()/1.5) 
    rp.Market.SellerMenu:Center() 
    rp.Market.SellerMenu:SetTitle( "Мой торговый рынок " .. marketid)  
    rp.Market.SellerMenu:SetVisible( true )
    rp.Market.SellerMenu:SetDraggable( false ) 
    rp.Market.SellerMenu:ShowCloseButton( true )
    rp.Market.SellerMenu:MakePopup()
    rp.Market.SellerMenu:SizeToContents()

    rp.Market.SellerMenu.Cats = rp.Market.SellerMenu:Add( "DPanelList")
    rp.Market.SellerMenu.Cats:Dock(LEFT)
    rp.Market.SellerMenu.Cats:DockMargin(0,0,5,0)
    rp.Market.SellerMenu.Cats:SetWide(rp.Market.SellerMenu:GetWide()/4)
    rp.Market.SellerMenu.Cats:EnableVerticalScrollbar( true )
    rp.Market.SellerMenu.Cats.Paint = function( s, w, h ) draw.RoundedBox( 0, 0, 0, w, h, Color(255,0,0,0)) end
    rp.Market.SellerMenu.Cats.VBar.Paint = function( s, w, h ) draw.RoundedBox( 4, 3, 13, 8, h-24, Color(0,0,0,70)) end
    rp.Market.SellerMenu.Cats.VBar.btnUp.Paint = function( s, w, h ) end
    rp.Market.SellerMenu.Cats.VBar.btnDown.Paint = function( s, w, h ) end
    rp.Market.SellerMenu.Cats.VBar.btnGrip.Paint = function( s, w, h ) draw.RoundedBox( 4, 5, 0, 4, h+22, Color(0,0,0,70)) end

    for k, data in pairs(rp.Market.Cats) do
        local colort =  Color( 30, 30, 30, 120 )

        local ItemCat = rp.Market.SellerMenu.Cats:Add("BButton")
        ItemCat:Dock(TOP)
        ItemCat:DockMargin(0,3,0,0)
        ItemCat:SetTall(50)
        ItemCat:SetText("")
        ItemCat.Paint = function( self, w, h )
            surface.SetDrawColor(Color(60,60,60))
            surface.DrawOutlinedRect(0, 0, w, h)
            draw.RoundedBox(0,0,0,w,h, colort)
            draw.ShadowSimpleText( data.name, "font_base_24",  w/2, h/2, Color( 200, 200, 200 ), 1, 1 )
        end
        ItemCat.OnCursorEntered = function( self ) colort =  Color( 60, 60, 60, 150) end
        ItemCat.OnCursorExited = function( self ) colort =  Color( 30, 30, 30, 120) end
            
        ItemCat.DoClick = function() 
            rp.Market.SellerSetup(marketid, k)
            category = k
        end

    end

    local colort =  Color( 30, 30, 30, 120 )

    local SellerMenu = rp.Market.SellerMenu.Cats:Add("BButton")
    SellerMenu:Dock(BOTTOM)
    SellerMenu:DockMargin(0,3,0,0)
    SellerMenu:SetTall(30)
    SellerMenu:SetText("")
    SellerMenu:SetToolTip("Нажмите, чтобы снять деньги")
    SellerMenu.Paint = function( self, w, h )
        surface.SetDrawColor(Color(60,60,60))
        surface.DrawOutlinedRect(0, 0, w, h)
        draw.RoundedBox(0,0,0,w,h, colort)
        draw.ShadowSimpleText( "Баланс: "..rp.FormatMoney(LocalPlayer():GetNVar('MarketMoney')), "font_base_24",  w/2, h/2, Color( 200, 200, 200 ), 1, 1 )
    end
    SellerMenu.OnCursorEntered = function( self ) colort =  Color( 60, 60, 60, 150) end
    SellerMenu.OnCursorExited = function( self ) colort =  Color( 30, 30, 30, 120) end
        
    SellerMenu.DoClick = function() 
        net.Start("rp.Market.TakeBankMoney")
        net.SendToServer()
    end

    local MyMoney = rp.Market.SellerMenu.Cats:Add("BButton")
    MyMoney:Dock(BOTTOM)
    MyMoney:DockMargin(0,3,0,0)
    MyMoney:SetTall(30)
    MyMoney:SetText("")
    MyMoney.Paint = function( self, w, h )
        surface.SetDrawColor(Color(60,60,60))
        surface.DrawOutlinedRect(0, 0, w, h)
        draw.RoundedBox(0,0,0,w,h,  Color( 30, 30, 30, 120))
        draw.ShadowSimpleText( "Мои монеты: "..rp.FormatMoney(LocalPlayer():GetMoney()), "font_base_24",  w/2, h/2, Color( 200, 200, 200 ), 1, 1 )
    end

    rp.Market.InvTitle = rp.Market.SellerMenu:Add( "DLabel")
    rp.Market.InvTitle:DockMargin(0,5,14,5)
    rp.Market.InvTitle:SetSkin('core')
    rp.Market.InvTitle:Dock(TOP)
    rp.Market.InvTitle:SetTall( 30 )
    rp.Market.InvTitle:SetText( "" )
    rp.Market.InvTitle.Paint = function( self, w, h )
        surface.SetDrawColor(Color(60,60,60))
        surface.DrawOutlinedRect(0, 0, w, h)
        draw.RoundedBox(0,0,0,w,h, Color( 30, 30, 30, 120))
        draw.ShadowSimpleText( "Управление вашими вещами на рынке", "rp.ui.22",  w/2, h/2, Color( 200, 200, 200 ), 1, 1 )
    end

    rp.Market.SellerMenu.InvItems = rp.Market.SellerMenu:Add( "DScrollPanel")
    rp.Market.SellerMenu.InvItems:Dock(LEFT)
    rp.Market.SellerMenu.InvItems:SetWide(rp.Market.SellerMenu:GetWide()/3)
    rp.Market.SellerMenu.InvItems:DockMargin(0,0,5,0)
    rp.Market.SellerMenu.InvItems.Paint = function( s, w, h ) draw.RoundedBox( 0, 0, 0, w, h, Color(0,255,0,0)) end
    rp.Market.SellerMenu.InvItems.VBar.Paint = function( s, w, h ) draw.RoundedBox( 4, 3, 13, 8, h-24, Color(0,0,0,70)) end
    rp.Market.SellerMenu.InvItems.VBar.btnUp.Paint = function( s, w, h ) end
    rp.Market.SellerMenu.InvItems.VBar.btnDown.Paint = function( s, w, h ) end
    rp.Market.SellerMenu.InvItems.VBar.btnGrip.Paint = function( s, w, h )draw.RoundedBox( 4, 5, 0, 4, h+22, Color(0,0,0,70)) end

    rp.Market.Search = rp.Market.SellerMenu:Add( "DTextEntry")
    rp.Market.Search:DockMargin(0,5,14,5)
    rp.Market.Search:SetSkin('core')
    rp.Market.Search:Dock(TOP)
    rp.Market.Search:SetVisible(false)
    rp.Market.Search:SetTall( 30 )
    rp.Market.Search:SetValue( "Введите название и нажмите ENTER" )
    rp.Market.Search.OnEnter = function( self )
        rp.Market.SellerSetup(marketid, category)
    end

    rp.Market.SellerMenu.Items = rp.Market.SellerMenu:Add( "DScrollPanel")
    rp.Market.SellerMenu.Items:Dock(FILL)
    rp.Market.SellerMenu.Items.Paint = function( s, w, h ) draw.RoundedBox( 0, 0, 0, w, h, Color(0,255,0,0)) end
    rp.Market.SellerMenu.Items.VBar.Paint = function( s, w, h ) draw.RoundedBox( 4, 3, 13, 8, h-24, Color(0,0,0,70)) end
    rp.Market.SellerMenu.Items.VBar.btnUp.Paint = function( s, w, h ) end
    rp.Market.SellerMenu.Items.VBar.btnDown.Paint = function( s, w, h ) end
    rp.Market.SellerMenu.Items.VBar.btnGrip.Paint = function( s, w, h )draw.RoundedBox( 4, 5, 0, 4, h+22, Color(0,0,0,70)) end

end

function rp.Market.SellerSetup(marketid, category)
    if rp.Market.SellerMenu and rp.Market.SellerMenu.Items then
        rp.Market.SellerMenu.Items:Clear()
        rp.Market.SellerMenu.InvItems:Clear()
        rp.Market.Search:SetVisible(true)
        for k, data in pairs(rp.Market.Data) do
            if data.marketid == marketid and data.category == category and (data.seller == LocalPlayer():SteamID64()) then      

                local tbl = util.JSONToTable(data.tbl)
                local itemTable = Inventory.GetItem(data.category, data.class)
                if !itemTable then continue end

                local searchable = rp.Market.Search:GetValue() == "Введите название и нажмите ENTER" and "" or rp.Market.Search:GetValue()
                if not string.match( itemTable.name, searchable ) then continue end

                local colort =  Color( 30, 30, 30, 120 )

                local Item = rp.Market.SellerMenu.Items:Add("BButton")
                Item:Dock(TOP)
                Item:DockMargin(0,3,0,0)
                Item:SetTall(70)
                Item:SetText("")
                Item.Paint = function( self, w, h )
                end

                local icon = Item:Add("rp.itemmodel")
                icon:Dock(LEFT)
                icon:SetPos( 0, 0 )
                icon:SetModel(itemTable.model)
                icon:SetSize( Item:GetWide(), Item:GetTall() )
                icon:CenterCamera(1)

                local ItemDesc = Item:Add("DButton")
                ItemDesc:Dock(FILL)
                ItemDesc:SetText("")
                ItemDesc.Paint = function( self, w, h )
                    surface.SetDrawColor(Color(60,60,60))
                    surface.DrawOutlinedRect(0, 0, w, h)
                    draw.RoundedBox(0,0,0,w,h, colort)

                    draw.ShadowSimpleText( itemTable.name, "rp.ui.22",  w*0.01, h*0.06, Color( 200, 200, 200 ), TEXT_ALIGN_LEFT )
                    draw.ShadowSimpleText( KitsFormatTimeNice(data.exptime), "rp.ui.20", w-15, h-65, Color( 200, 200, 200 ), TEXT_ALIGN_RIGHT )
                    draw.ShadowSimpleText( "Цена: "..tbl.count, "rp.ui.20", w-15, h-45, Color( 200, 200, 200 ), TEXT_ALIGN_RIGHT )
                    draw.ShadowSimpleText( "Кол-во: "..data.price, "rp.ui.20", w-15, h-25, Color( 200, 200, 200 ), TEXT_ALIGN_RIGHT )
                    local text = ""
                    if data.category == INV_WEAPON then 
                        text = "прочность: "..tbl.health.."%, патронов в маг: "..tbl.ammo
                    end
                    draw.ShadowSimpleText( text, "rp.ui.22",  w*0.01, h*0.35, Color( 200, 200, 200 ), TEXT_ALIGN_LEFT )
                    draw.ShadowSimpleText( "Продавец: "..data.sellername, "rp.ui.22",  w*0.01, h*0.65, Color( 200, 200, 200 ), TEXT_ALIGN_LEFT )
                end
                ItemDesc.OnCursorEntered = function( self ) colort =  Color( 60, 60, 60, 150) end
                ItemDesc.OnCursorExited = function( self ) colort =  Color( 30, 30, 30, 120) end            
                ItemDesc.DoClick = function() 
                    local Menu = DermaMenu()
                    Menu:SetSkin('core')
                    Menu:AddSpacer()

                    local butbtn1 = Menu:AddOption( "Снять с продажи "..itemTable.name.. " (x1)" )
                    butbtn1:SetIcon( "icon16/basket.png" )
                    butbtn1.DoClick = function()
                        net.Start("rp.Market.RemoveItem")
                        net.WriteInt(data.itemid, 32)
                        net.WriteInt(1, 31)
                        net.WriteInt(marketid, 5)
                        net.WriteString(category)
                        net.SendToServer()
                    end

                    Menu:AddSpacer()

                    local butbtnn = Menu:AddOption( "Снять с продажи "..itemTable.name.. " (несколько)" )
                    butbtnn:SetIcon( "icon16/basket_add.png" )
                    butbtnn.DoClick = function()
                        Derma_StringRequest(
                            "Снять с продажи "..itemTable.name.. " (несколько)",
                            "Введите количество",
                            "",
                            function( text )
                                local num = tonumber(text)
                                if not isnumber(num) then return false end
                                net.Start("rp.Market.RemoveItem")
                                net.WriteInt(data.itemid, 32)
                                net.WriteInt(num, 31)
                                net.WriteInt(marketid, 5)
                                net.SendToServer()
                            end,
                            function( text ) end
                        )
                    end

                    Menu:AddSpacer()

                    Menu:Open()
                end 
            end
        end
        for type, classes in pairs(LocalPlayer().inv) do
        for class, classtbl in pairs(classes) do
            for key, itemtbl in pairs(classtbl) do
                local count = itemtbl.count or 1

                local itemTable1 = Inventory.GetItem(type, class)
                if !itemTable1 then continue end

                if category != type then continue end

                local colort =  Color( 30, 30, 30, 120 )

                local Item = rp.Market.SellerMenu.InvItems:Add("BButton")
                Item:Dock(TOP)
                Item:DockMargin(0,3,0,0)
                Item:SetTall(50)
                Item:SetText("")
                Item.Paint = function( self, w, h )
                end

                local icon = Item:Add("rp.itemmodel")
                icon:Dock(LEFT)
                icon:SetPos( 0, 0 )
                icon:SetModel(itemTable1.model)
                icon:SetSize( Item:GetWide(), Item:GetTall() )
                icon:CenterCamera(1)

                local ItemDesc = Item:Add("DButton")
                ItemDesc:Dock(FILL)
                ItemDesc:SetText("")
                ItemDesc.Paint = function( self, w, h )
                    surface.SetDrawColor(Color(60,60,60))
                    surface.DrawOutlinedRect(0, 0, w, h)
                    draw.RoundedBox(0,0,0,w,h, colort)
                
                    draw.ShadowSimpleText( itemTable1.name, "rp.ui.22",  w*0.01, h*0.06, Color( 200, 200, 200 ), TEXT_ALIGN_LEFT )
                    draw.ShadowSimpleText( "x"..count, "rp.ui.22", w-5, h*0.1, Color( 200, 200, 200 ), TEXT_ALIGN_RIGHT )
                    local text = Inventory.GetPrintWeight(itemTable1.weight)
                    if type == INV_WEAPON then 
                        text = text .. ", прочность: "..itemtbl.health.."%, патронов в маг: "..itemtbl.ammo
                    end
                    draw.ShadowSimpleText( text, "rp.ui.22",  w*0.01, h*0.5, Color( 200, 200, 200 ), TEXT_ALIGN_LEFT )
                end
                ItemDesc.OnCursorEntered = function( self ) colort =  Color( 60, 60, 60, 150) end
                ItemDesc.OnCursorExited = function( self ) colort =  Color( 30, 30, 30, 120) end            
                ItemDesc.DoClick = function() 
                    local Menu = DermaMenu()
                    Menu:SetSkin('core')
                    Menu:AddSpacer()

                    local butbtn1 = Menu:AddOption( "Выставить на продажу "..itemTable1.name.. " (x1)" )
                    butbtn1:SetIcon( "icon16/basket.png" )
                    butbtn1:SetSkin('core')
                    butbtn1.DoClick = function()
                        local strreq = Derma_StringRequest(
                            "Выставить "..itemTable1.name.. " (x1)",
                            "Введите цену",
                            "",
                            function( text )
                                local price = tonumber(text)
                                if not isnumber(price) then return false end
                                local attr = {}
                                attr.count = 1
                                if type == INV_WEAPON then
                                    attr.ammo = itemtbl.ammo
                                    attr.health = itemtbl.health
                                end
                                net.Start("rp.Market.SellItem")
                                net.WriteString(type)
                                net.WriteString(class)
                                net.WriteInt(key, 31)
                                net.WriteTable(attr)
                                net.WriteInt(price, 32)
                                net.WriteInt(marketid, 5)
                                net.WriteInt(7, 8)
                                net.SendToServer()
                                -- local qry = Derma_Query(
                                --     "Выберите сумму первоначального взноса:",
                                --     "Продать "..itemTable1.name.. " (x1)",
                                --     tostring(math.Round(price*0.01*3)+1) .."м. (3 дня)",
                                --     function()
                                --         local days = 3
                                --         local attr = {}
                                --         attr.count = 1
                                --         if type == INV_WEAPON then
                                --             attr.ammo = itemtbl.ammo
                                --             attr.health = itemtbl.health
                                --         end
                                --         net.Start("rp.Market.SellItem")
                                --         net.WriteString(type)
                                --         net.WriteString(class)
                                --         net.WriteInt(key, 31)
                                --         net.WriteInt(1, 31)
                                --         net.WriteTable(attr)
                                --         net.WriteInt(marketid, 5)
                                --         net.WriteInt(days, 8)
                                --         net.SendToServer()
                                --     end,
                                --     tostring(math.Round(price*0.01*7)+1) .."м. (7 дней)",
                                --     function()
                                --         local days = 7
                                --         local attr = {}
                                --         attr.count = 1
                                --         if type == INV_WEAPON then
                                --             attr.ammo = itemtbl.ammo
                                --             attr.health = itemtbl.health
                                --         end
                                --         net.Start("rp.Market.SellItem")
                                --         net.WriteString(type)
                                --         net.WriteString(class)
                                --         net.WriteInt(key, 31)
                                --         net.WriteTable(attr)
                                --         net.WriteInt(price, 32)
                                --         net.WriteInt(marketid, 5)
                                --         net.WriteInt(days, 8)
                                --         net.SendToServer()
                                --     end,
                                --     "Я передумал",
                                --     function()
                                --         return false
                                --     end
                                -- )
                                -- qry:SetSkin("core")
                            end,
                            function( text ) end
                        )
                        strreq:SetSkin("core")
                    end

                    Menu:AddSpacer()

                    local butbtnn = Menu:AddOption( "Выставить на продажу "..itemTable1.name.. " (несколько)" )
                    butbtnn:SetIcon( "icon16/basket_add.png" )
                    butbtnn.DoClick = function()
                        Derma_StringRequest(
                            "Выставить "..itemTable1.name.. " (несколько)",
                            "Введите количество",
                            "",
                            function( text )
                                local num = tonumber(text)
                                if not isnumber(num) then return false end
                                
                                local strreq = Derma_StringRequest(
                                    "Продать "..itemTable1.name.. " (x1)",
                                    "Введите цену",
                                    "",
                                    function( text )
                                        local price = tonumber(text)
                                        if not isnumber(price) then return false end
                                        local attr = {}
                                        attr.count = num
                                        if type == INV_WEAPON then
                                            attr.ammo = itemtbl.ammo
                                            attr.health = itemtbl.health
                                        end
                                        net.Start("rp.Market.SellItem")
                                        net.WriteString(type)
                                        net.WriteString(class)
                                        net.WriteInt(key, 31)
                                        net.WriteTable(attr)
                                        net.WriteInt(price, 32)
                                        net.WriteInt(marketid, 5)
                                        net.WriteInt(7, 8)
                                        net.SendToServer()
                                --         local qry = Derma_Query(
                                --             "Выберите сумму первоначального взноса:",
                                --             "Продать "..itemTable1.name.. " (x1)",
                                --             tostring(math.Round(price*0.01*num*3)+1) .."м. (3 дня)",
                                --             function()
                                --                 local days = 3
                                --                 local attr = {}
                                --                 attr.count = num
                                --                 if type == INV_WEAPON then
                                --                     attr.ammo = itemtbl.ammo
                                --                     attr.health = itemtbl.health
                                --                 end
                                --                 net.Start("rp.Market.SellItem")
                                --                 net.WriteString(type)
                                --                 net.WriteString(class)
                                --                 net.WriteInt(key, 31)
                                --                 net.WriteTable(attr)
                                --                 net.WriteInt(price, 32)
                                --                 net.WriteInt(marketid, 5)
                                --                 net.WriteInt(days, 8)
                                --                 net.SendToServer()
                                --             end,
                                --             tostring(math.Round(price*0.01*num*7)+1) .."м. (7 дней)",
                                --             function()
                                --                 local days = 7
                                --                 local attr = {}
                                --                 attr.count = num
                                --                 if type == INV_WEAPON then
                                --                     attr.ammo = itemtbl.ammo
                                --                     attr.health = itemtbl.health
                                --                 end
                                --                 net.Start("rp.Market.SellItem")
                                --                 net.WriteString(type)
                                --                 net.WriteString(class)
                                --                 net.WriteInt(key, 31)
                                --                 net.WriteTable(attr)
                                --                 net.WriteInt(price, 32)
                                --                 net.WriteInt(marketid, 5)
                                --                 net.WriteInt(days, 8)
                                --                 net.SendToServer()
                                --             end,
                                --             "Я передумал",
                                --             function()
                                --                 return false
                                --             end
                                --         )
                                --         qry:SetSkin("core")
                                    end,
                                    function( text ) end
                                )
                                strreq:SetSkin("core")
                            end,
                            function( text ) end
                        )
                    end

                    Menu:AddSpacer()

                    Menu:Open()
                end                
            end
        end
        end
    end
end