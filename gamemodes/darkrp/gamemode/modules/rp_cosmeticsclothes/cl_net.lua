net.Receive("Cosmetics:BroadcastPlayerInfos", function()
	
	local infos = net.ReadTable()
	local infos2 = net.ReadTable()
	local infos3 = net.ReadTable()
	local ply = net.ReadEntity() or NULL
	local charid = net.ReadInt(20)

	if not IsValid( ply ) then return end
	
	local steamid = ply:SteamID64() or "novalue"
	if charid == -1 then charid = ply:GetNVar('CurrentChar') or 0 end 

	Cosmetics.PlayerInfos = Cosmetics.PlayerInfos or {}
	Cosmetics.PlayerInfos[steamid] = Cosmetics.PlayerInfos[steamid] or {}
	Cosmetics.PlayerInfos[steamid][charid] = infos
	
	Cosmetics.PlayerTops = Cosmetics.PlayerTops or {}
	Cosmetics.PlayerTops[steamid] = Cosmetics.PlayerTops[steamid] or {}
	Cosmetics.PlayerTops[steamid][charid] = infos2

	Cosmetics.PlayerBottoms = Cosmetics.PlayerBottoms or {}
	Cosmetics.PlayerBottoms[steamid] = Cosmetics.PlayerBottoms[steamid] or {}
	Cosmetics.PlayerBottoms[steamid][charid] = infos3
	
	ply:CM_ApplyModel()
	
end)

net.Receive("Cosmetics:BroadcastPlayersInfos", function()
	local infos = net.ReadTable()
	local infos2 = net.ReadTable()
	local infos3 = net.ReadTable()
	
	-- PrintTable( infos2 )
	Cosmetics.PlayerInfos = infos
	Cosmetics.PlayerTops = infos2
	Cosmetics.PlayerBottoms = infos3
	
	for k, ply in pairs( player.GetAll() ) do
		ply:CM_ApplyModel()
	end
	
end)

net.Receive("Cosmetics:CharacterCreationMenu", function()
	CM_OpenNewCharacterGUI()	
end)

net.Receive("Cosmetics:OpenAdminMenu", function()
	Cosmetics_OpenAdminGui()	
end)

Cosmetics.ShopTextures = Cosmetics.ShopTextures or {}

net.Receive("Cosmetics:BroadcastTextureInfo", function()
	local infos = net.ReadTable()
	
	Cosmetics.Textures = Cosmetics.Textures or {}
	
	Cosmetics.Textures[infos.id] = infos
	CM_CreateClothes( infos, infos.id )
	
end)
net.Receive("Cosmetics:BroadcastShopsInfo", function()
	local infos = net.ReadTable()
		
	Cosmetics.ShopTextures = infos
	
	for id, datas in pairs( infos ) do
		CM_CreateClothes( datas, id )
	end
	
end)

net.Receive("Cosmetics:ChangeNameMenu", function()
	
	local ent = net.ReadEntity()
	
	ent:OpenNameMenu()
	
end)

net.Receive("Cosmetics:DropClothesMenu", function()
	
	local ent = net.ReadEntity()
	
	local blur = Material("pp/blurscreen")

	local function DrawBlur( p, a, d )


		local x, y = p:LocalToScreen(0, 0)
		
		surface.SetDrawColor( 255, 255, 255 )
		
		surface.SetMaterial( blur )
		
		for i = 1, d do
		
		
			blur:SetFloat( "$blur", (i / d ) * ( a ) )
			
			blur:Recompute()
			
			render.UpdateScreenEffectTexture()
			
			surface.DrawTexturedRect( x * -1, y * -1, ScrW(), ScrH() )
			
			
		end
		
		
	end
	
	
	local infos = net.ReadTable()	
	local ent = net.ReadEntity()
	
	local sizex = 400
	local sizey = 110+50+10
	
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( (ScrW()-sizex)/2, (ScrH()-sizey)/2 )
	DermaPanel:SetSize( sizex, sizey )
	DermaPanel:SetTitle( "" )
	DermaPanel:SetDraggable( false )
	DermaPanel:ShowCloseButton( false )
	DermaPanel:MakePopup()
	DermaPanel.Paint = function( pnl, w, h )
		DrawBlur( pnl, 3, 4 )
		draw.RoundedBox(0,0,0, w, h, Color(0, 0, 0,150))
		draw.RoundedBox(0,0,0, 2, h, Color(0, 0, 0))
		draw.RoundedBox(0,0,0, w, 2, Color(0, 0, 0))
		draw.RoundedBox(0,0,h-2, w, 2, Color(0, 0, 0))
		draw.RoundedBox(0,w-2,0, 2, h, Color(0, 0, 0))
		
	end
	
	local Panel = vgui.Create( "DPanel", DermaPanel )
	Panel:SetPos( 2, 2 )
	Panel:SetSize( sizex-4, 40 )
	Panel.Paint = function( pnl, w, h )
		draw.RoundedBox(0,0,0, w, h, Color(0, 0, 0,150))
		draw.SimpleText( Cosmetics.Config.Sentences[25][Cosmetics.Config.Lang], "Bariol25", 10,7.5, Color(255,255,255) )
	end
	
	local DermaButtonClose = vgui.Create( "DButton", DermaPanel )
	DermaButtonClose:SetText( "" )
	DermaButtonClose:SetPos( sizex-42, 2 )
	DermaButtonClose:SetSize( 40, 40 )
	DermaButtonClose.DoClick = function()
		DermaPanel:Close()
	end	
	DermaButtonClose.Paint = function( pnl, w , h )
		
		draw.RoundedBox( 0, 0, 0, w, h, Color( 0,0,0,120 ) )
		draw.SimpleText( "X", "Bariol25", w/2, h/2, Color(255,255,255),1,1 )
		
	end
	

	local ButtonAccept = vgui.Create( "DButton", DermaPanel )
	ButtonAccept:SetText( "" )
	ButtonAccept:SetPos( 10, 50 )
	ButtonAccept:SetSize( sizex-20, 50 )
	ButtonAccept.DoClick = function()
		DermaPanel:Close()
		net.Start("Cosmetics:DropCloth")
			net.WriteBool( true )
		net.SendToServer()
	end	
	ButtonAccept.Paint = function( pnl, w , h )
		
		draw.RoundedBox( 0, 0, 0, w, h, Color( 0,0,0,200 ) )
		draw.SimpleText( Cosmetics.Config.Sentences[26][Cosmetics.Config.Lang], "Bariol25", w/2, h/2, Color(255,255,255),1,1 )
		
	end
	
	local ButtonAccept2 = vgui.Create( "DButton", DermaPanel )
	ButtonAccept2:SetText( "" )
	ButtonAccept2:SetPos( 10, 50 + 50 +10)
	ButtonAccept2:SetSize( sizex-20, 50 )
	ButtonAccept2.DoClick = function()
		DermaPanel:Close()
		net.Start("Cosmetics:DropCloth")
			net.WriteBool( false )
		net.SendToServer()
	end	
	ButtonAccept2.Paint = function( pnl, w , h )
		
		draw.RoundedBox( 0, 0, 0, w, h, Color( 0,0,0,200 ) )
		draw.SimpleText( Cosmetics.Config.Sentences[27][Cosmetics.Config.Lang], "Bariol25", w/2, h/2, Color(255,255,255),1,1 )
		
	end
	
end)

net.Receive("Cosmetics:ClothesShop", function()

	local ent = net.ReadEntity()
	CM_OpenShop(ent)
	
end)

net.Receive("Cosmetics:ClothesArmory", function()
	
	local ent = net.ReadEntity()
	
	CM_OpenArmory(ent)
	
end)

net.Receive("Cosmetics:ClothesCreation", function()
	
	local ent = net.ReadEntity()
	
	ent:OpenGUI()
	
end)

net.Receive("Cosmetics:SurgeryMenu", function()
	
	local ent = net.ReadEntity()
	
	ent:OpenGUI()
	
end)