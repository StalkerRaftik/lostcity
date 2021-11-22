
net.Receive( "LMMPrivKeysAdminMenu", function()
	local keys = net.ReadTable()

	local DFrame = vgui.Create( "DFrame" )
	DFrame:SetSize( 450, 400 )
	DFrame:Center()
	DFrame:SetDraggable( false )
	DFrame:MakePopup()
	DFrame:SetTitle( "Управление промокодами" )
	DFrame:ShowCloseButton( false )
  DFrame:SetSkin('core')
	-- DFrame.Paint = function( self, w, h )
	-- 	DrawBlur(DFrame, 2)
	-- 	drawRectOutline( 0, 0, w, h, Color( 0, 0, 0, 85 ) )	
	-- 	draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 85))
	-- 	drawRectOutline( 2, 2, w - 4, h / 8.9, Color( 0, 0, 0, 85 ) )
	-- 	draw.RoundedBox(0, 2, 2, w - 4, h / 9, Color(0,0,0,125))
	-- 	draw.SimpleText( "PrivKey Admin Menu", "PrivKeyTitleFont", DFrame:GetWide() / 2, 25, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	-- end
	
	local frameclose = vgui.Create( "DButton", DFrame )
	frameclose:SetSize( 35, 35 )
	frameclose:SetPos( DFrame:GetWide() - 36,9 )
	frameclose:SetText( "X" )
	frameclose:SetFont( "rp.ui.18" )
	frameclose:SetTextColor( Color( 255, 255, 255 ) )
	frameclose.Paint = function()
		
	end
	frameclose.DoClick = function()
		DFrame:Close()
		DFrame:Remove()
	end

  local DermaNumSlider = vgui.Create( "DNumSlider", DFrame )
  DermaNumSlider:SetPos( 10, 60 )   
  DermaNumSlider:SetSize( DFrame:GetWide() - 210, 20 )   
  DermaNumSlider:SetText( "Введите количество кридитов" ) 
  DermaNumSlider:SetMin( 0 )     
  DermaNumSlider:SetMax( 100000 )      

	local DListView = vgui.Create( "DListView", DFrame )
	DListView:SetSize( DFrame:GetWide() - 20, DFrame:GetTall() - 100 )
	DListView:SetPos( 10, 85 )
	DListView:AddColumn( "Промокод" )
	DListView:AddColumn( "Кредиты" )
	DListView.OnRowRightClick = function( id, line)
		local value = DListView:GetLine( line ):GetValue( 1 )
		SetClipboardText( value )
		notification.AddLegacy( "Промокод был скопирован", NOTIFY_GENERIC, 3 )
	end
	
	local DButton = vgui.Create( "DButton", DFrame )
	DButton:SetSize( 90, 20 )
	DButton:SetText("Создать")
	DButton:SetPos( DFrame:GetWide() - 195, 60 )
	DButton.DoClick = function()		
		if DermaNumSlider:GetValue() <= 0 then return end
	
		local menu = DermaMenu()
		menu:AddOption( "Случайный", function()
			net.Start("LMMPrivKeysGenerateKey")
				net.WriteString( DermaNumSlider:GetValue() )
			net.SendToServer()
			DFrame:Remove()
		end )
		menu:AddOption( "Индивидуальный", function()
			Derma_StringRequest(
				"Создание промокода",
				"Введите промокод",
				"",
				function( text )
					net.Start("LMMPrivKeyGenerateCustomKey")
						net.WriteString( DermaNumSlider:GetValue() )
						net.WriteString( text )
					net.SendToServer()
					DFrame:Remove()					
				end,
				function( text )
				end
			 )		
		end	)
		
		menu:Open()
	end
	
	local DButton = vgui.Create( "DButton", DFrame )
	DButton:SetSize( 90, 20 )
	DButton:SetText("Удалить")
	DButton:SetPos( DFrame:GetWide() - 100, 60 )
	DButton.DoClick = function()
	
		local line = DListView:GetSelectedLine()
		local value = DListView:GetLine( line ):GetValue( 1 )

		net.Start("LMMPrivKeysDestroyKey")
			net.WriteString( value .. ".txt" )
		net.SendToServer()
		
		DFrame:Remove()
	end
	
	if #keys > 0 then
		for k,v in pairs( keys ) do
			DListView:AddLine( string.StripExtension( v[1] ), v[2] )
		end
	end
end )

net.Receive( "LMMPrivKeysUserMenu", function()
	local DFrame = vgui.Create( "DFrame" )
	DFrame:SetSize( 450, 100 )
	DFrame:Center()
	DFrame:SetDraggable( false )
	DFrame:MakePopup()
  DFrame:SetSkin('core')
	DFrame:SetTitle( "" )
	DFrame:ShowCloseButton( true )

	local DTextEntry = vgui.Create("DTextEntry", DFrame )
	DTextEntry:SetSize( DFrame:GetWide() - 110, 20 )
	DTextEntry:SetPos( 10, 55 )

	local DButton = vgui.Create( "DButton", DFrame )
	DButton:SetSize( 90, 20 )
	DButton:SetText("Ок")
	DButton:SetPos( DFrame:GetWide() - 95, 55 )
	DButton.DoClick = function()
		net.Start("LMMPrivKeysRedeemKey")
			local value = DTextEntry:GetValue()
		
			net.WriteString( value .. ".txt" )
		net.SendToServer()
		
		DFrame:Remove()
	end		
end )

concommand.Add( lmmprivkeyconfig.ConsoleCommand, function( ply, cmd, arg )
	-- Make sure they've actually put something as the argument
	if !arg[1] then
		ply:ChatPrint("Key cannot be blank")
		return
	end

	net.Start("LMMPrivKeysRedeemKey")	
		net.WriteString( arg[1] .. ".txt" )
	net.SendToServer()	
--	ply:ChatPrint( "Key success! you have been added to rank: " .. contents )
end )
