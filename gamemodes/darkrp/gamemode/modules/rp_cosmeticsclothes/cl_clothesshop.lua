local blur = Material("pp/blurscreen")

local DermaPanel
local infos 
local err = "" 
local cart = {}

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

local modelPanel
local OpenCharacterPage

local function DrawBlurRect(x, y, w, h, amount, heavyness)
	surface.SetDrawColor(255, 255, 255, 255)
	surface.SetMaterial(blur)

	for i = 1, heavyness do
		blur:SetFloat("$blur", (i / 3) * (amount or 6))
		blur:Recompute()

		render.UpdateScreenEffectTexture()

		render.SetScissorRect(x, y, x + w, y + h, true)
			surface.DrawTexturedRect(0 * -1, 0 * -1, ScrW(), ScrH())
		render.SetScissorRect(0, 0, 0, 0, false)
	end
	
end

local DPanel2
local CartP

local function OpenCart(Panel)
	
	CartP = vgui.Create( "SRP_ScrollPanel", Panel )

	local w, h = Panel:GetSize()
	
	CartP:SetSize( w, h )
	CartP:SetPos( 0,0 )
	CartP.Paint = function()
		-- draw.SimpleText( "Cart", "Bariol25",w/2,30,Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
	end
	
	local sbar = CartP:GetVBar()

	function sbar:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color(255, 255, 255,0) )
	end

	function sbar.btnUp:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color(0, 0, 0) )
	end
	
	function sbar.btnDown:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color(0, 0, 0) )
	end
	
	function sbar.btnGrip:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color(0, 0, 0,150) )
	end
	
	local head = vgui.Create( "DPanel", CartP )
	
	head:SetSize( w, 60 )
	head:SetPos( 0,0 )
	
	local ttprice = 0
	
	head.Paint = function()
		draw.ShadowSimpleText( Cosmetics.Config.Sentences[17][Cosmetics.Config.Lang].." - "..Cosmetics.Config.Sentences[18][Cosmetics.Config.Lang].." : "..ttprice..Cosmetics.Config.MoneyUnit, "Bariol25",w/2,60/2,Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
	end
	
	local nb = 0
	for name,tables in pairs( cart ) do

		local dCart = vgui.Create( "SRP_ScrollPanel", CartP )
		dCart:SetSize( w-20, 50 )
		dCart:SetPos( 10,60 + (50+10)*nb )
		dCart.Paint = function(pnl, wi,he)
			draw.ShadowSimpleText( string.sub(name,0,string.len(name)-1).." - "..tables.price..Cosmetics.Config.MoneyUnit, "font_base_24",wi/2,he/2,Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, 1 )
		end
		
		ttprice = ttprice + tables.price
		
		local DButton = vgui.Create( "BButton", dCart )
		DButton:SetSize( 30,30 )
		
		local X, Y = dCart:GetSize()
		
		DButton:SetPos( X-30-5,Y/2-15 )
		DButton:SetText("")
		DButton.Paint = function(p, w, h)
		
			draw.RoundedBox(0,0,0,w,h, Color(0,0,0,150))
			local m = 1
			-- draw.RoundedBox(0,0,0,w,2, Color(255,255,255,255 * m))
			-- draw.RoundedBox(0,0,h-2,w,2, Color(255,255,255,255 * m))
			-- draw.RoundedBox(0,0,0,2,h, Color(255,255,255,255  * m))
			-- draw.RoundedBox(0,w-2,0,2,h, Color(255,255,255,255 * m))
			draw.ShadowSimpleText( "X", "font_base_24",w/2,h/2,Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, 1 )

		end
		DButton.DoClick = function( pnl )
			cart[name] = nil
			
			if IsValid(CartP) then
				CartP:Remove()
			end
			OpenCart(Panel)
		end
		
		nb = nb+1
		
	end
	
end

local function OpenList( Panel, cat, CP )
	local DPanel = vgui.Create( "DPanel", Panel )

	local w, h = Panel:GetSize()
	
	DPanel:SetSize( w, h )
	DPanel:SetPos( 0,0 )
	DPanel.Paint = function()
		draw.SimpleText( Cosmetics.Config.Sentences[20][Cosmetics.Config.Lang], "font_base_24",w/2,30,Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
		if err != "" then
			draw.SimpleText( Cosmetics.Config.Sentences[10][Cosmetics.Config.Lang]..": "..err, "font_base_18",w/2,60,Color( 255, 0, 0, 255 ), TEXT_ALIGN_CENTER )
		end
	end
	
	DPanel2 = vgui.Create( "SRP_ScrollPanel", Panel )

	DPanel2:SetSize( w-40, h-100 )
	DPanel2:SetPos( 25,80 )
	DPanel2.Paint = function()
		draw.RoundedBox(0,0,0,w,h, Color(30,30,30,100))
	end
	
	local sbar = DPanel2:GetVBar()

	function sbar:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color(255, 255, 255,0) )
	end

	function sbar.btnUp:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color(30, 30, 30) )
	end
	
	function sbar.btnDown:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color(30, 30, 30) )
	end
	
	function sbar.btnGrip:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color(30, 30, 30,150) )
	end
	
	local listI = {}
	
	if infos.sex == 1 then
		listI = Cosmetics.Male
	else
		listI = Cosmetics.Female
	end
	
	local list = {}
	
	for k,v in pairs( listI.ListTops ) do
		
		for key, val in pairs( v.category ) do
			if cat[val] then
				list[k.."1"] = v
				list[k.."1"].type = "top"
				list[k.."1"].iscustom = false
			end
		end
		
	end
	
	for k,v in pairs( listI.ListBottoms ) do
		
		for key, val in pairs( v.category ) do
			if cat[val] then
				list[k.."2"] = v
				list[k.."2"].type = "bottom"
				list[k.."2"].iscustom = false
			end
		end

	end
	
	for k,v in pairs( Cosmetics.ShopTextures ) do
	
		if cat[Cosmetics.Config.Sentences[24][Cosmetics.Config.Lang]] or cat["Short-sleeved"] then
			list[v.name.."3"] = v
			list[v.name.."3"].type = "top"
			list[v.name.."3"].iscustom = true
		end

	end
	
	local nb = 0
	local line = -1
	
	-- PrintTable( list )
	
	-- if true then return end
	
	for name, tables in pairs ( list ) do
		
		local rname = name
		local name = string.sub(name,0,string.len(name)-1)
		
		local nbl = math.mod( nb, 2 )
		
		-- if nb >= 1 then return end
		
		if nbl == 0 then
			line = line + 1
			nb = 0
		end
		
		local sxb, syb = (w-40-10-10)/2-5, (w-40-10-10)/2-5-20
		local sxbb, sybb = sxb, 50
		
		local DPanel3 = vgui.Create( "BButton", DPanel2 )
		DPanel3:SetSize( sxb, syb )
		DPanel3:SetPos( 5 + (sxb+5)*nb, 5+(syb+5+sybb)* line )
		DPanel3:SetText("")
		-- DPanel3.Paint = function(p, w, h)
		-- end
		
		local DmodelPanel = vgui.Create( "DModelPanel", DPanel3 )
		DmodelPanel:SetSize( sxb, syb )
		DmodelPanel:SetPos( 0, 0 )
		function DmodelPanel:LayoutEntity( Entity ) return end
		DmodelPanel:SetModel( infos.model )
		
		local type = tables.type
		
		if type == "bottom" then
			local startpos = DmodelPanel.Entity:GetBonePosition( DmodelPanel.Entity:LookupBone( "ValveBiped.Bip01_R_Calf" ) or 0) + Vector( 0,5,0 )
			DmodelPanel:SetLookAt( startpos )
			DmodelPanel:SetCamPos( startpos - Vector( -30,-0,0) )
			DmodelPanel.Entity:SetEyeTarget( startpos - Vector( -30,-0,0) )
		else
			local startpos = DmodelPanel.Entity:GetBonePosition( DmodelPanel.Entity:LookupBone( "ValveBiped.Bip01_Spine2" ) or 0)
			DmodelPanel:SetLookAt( startpos )
			DmodelPanel:SetCamPos( startpos - Vector( -25,0,0) )
			DmodelPanel.Entity:SetEyeTarget( startpos - Vector( -25,0,0) )
		end
		--
		local data
		local datas 
		if infos.sex == 1 then
			data = Cosmetics.Male
		else
			data = Cosmetics.Female
		end
		
		
		local datas = data.ListDefaultPM[infos.model]
		
		local bodygroups
		local tindex
		local tbdg
		if type == "top" then
			
			if tables.iscustom then
				
				tbdg = data.EditableTop[tables.baseTexture]
		
				-- if true then return end
				tindex = datas.bodygroupstop[tbdg.bodygroup].tee 
				bodygroups = {
					datas.bodygroupstop[tbdg.bodygroup].group,
				}
			
			else
				tindex = datas.bodygroupstop[tables.bodygroup].tee 
				bodygroups = {
					datas.bodygroupstop[tables.bodygroup].group,
				}
			end
			
			
			-- local t = datas.bodygroupstop[tables.bodygroup]
			-- local tindex = t.tee 
			-- local bodygroups = {
				-- datas.bodygroupstop[tables.bodygroup].group,
			-- }
			
			-- local ent = DmodelPanel.Entity
			
			-- for k, v in pairs( bodygroups ) do
				-- ent:SetBodygroup( v[1], v[2] )
			-- end
		
		else
		
			tindex = datas.bodygroupsbottom[tables.bodygroup].pant 
			bodygroups = {
				datas.bodygroupsbottom[tables.bodygroup].group,
			}
		end
		local ent = DmodelPanel.Entity
		
		for k, v in pairs( bodygroups ) do
			ent:SetBodygroup( v[1], v[2] )
		end
		
		local txt = tables.texture
		
		for k, v in pairs( tindex ) do
			-- ent:SetSubMaterial( v, txt )
			if tables.iscustom then
				ent:SetSubMaterial( v, "!CM_"..tables.id )
			else
				ent:SetSubMaterial( v, txt )
			end
		end

		local DButton3 = vgui.Create( "DButton", DPanel3 )
		DButton3:SetSize( sxb,syb )
		DButton3:SetPos( 0,0 )
		DButton3:SetText("")
		DButton3.Paint = function(p, w, h)
		
			draw.RoundedBox(0,0,0,w,h, Color(0,0,0,150))
			local m = 0
			-- draw.RoundedBox(0,0,0,w,2, Color(255,255,255,255 * m))
			-- draw.RoundedBox(0,0,h-2,w,2, Color(255,255,255,255 * m))
			-- draw.RoundedBox(0,0,0,2,h, Color(255,255,255,255  * m))
			-- draw.RoundedBox(0,w-2,0,2,h, Color(255,255,255,255 * m))
		end
		DButton3.DoClick = function( pnl )
			if tables.type == "bottom" then
				infos.bodygroups.pant = tables.bodygroup
		
				infos.panttexture.basetexture = txt
				
				modelPanel.Actualize()
			elseif not tables.iscustom then
				
				infos.bodygroups.top = tables.bodygroup
		
				infos.teetexture.basetexture = txt
				
				infos.teetexture.hasCustomThings = false
							
				modelPanel.Actualize()
			
			else
			
				infos.bodygroups.top = tbdg.bodygroup
				infos.teetexture.basetexture = "!CM_"..tables.id
				infos.teetexture.id = tables.id
				infos.teetexture.hasCustomThings = true
							
				modelPanel.Actualize()
			end
		end
		
		local DButton2 = vgui.Create( "DButton", DPanel2)
		DButton2:SetSize( sxbb,sybb )
		DButton2:SetPos( 5 + (sxb+5)*nb, 5+(syb+5+sybb)* line + syb )
		DButton2:SetText( "" )	
		DButton2.Paint = function(pnl, w, h )
				
			draw.RoundedBox( 0, 0,0,w,h, Color(0,0,0,150))
			-- draw.RoundedBox(0,0,0,w,2, Color(255,255,255,255))
			-- draw.RoundedBox(0,0,h-2,w,2, Color(255,255,255,255))
			-- draw.RoundedBox(0,0,0,2,h, Color(255,255,255,255 ))
			-- draw.RoundedBox(0,w-2,0,2,h, Color(255,255,255,255))
		
			draw.SimpleText( name, "font_base_18",w/2,0,Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, 0 )
			draw.RoundedBox(0,0,17,w,2, Color(50,50,50,255))
			-- draw.SimpleText( "Add to cart", "Bariol20",w/2,h/2,Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, 0 )
			draw.SimpleText( tables.price..Cosmetics.Config.MoneyUnit, "font_base_18",w/2,h/2-6,Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, 0 )
			draw.SimpleText( Cosmetics.Config.Sentences[21][Cosmetics.Config.Lang], "font_base_18",w/2,h/2+6,Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, 0 )
		
		end
		DButton2.DoClick = function( pnl )
			
			local steamid = LocalPlayer():SteamID64() or "novalue"
			
			if tables.iscustom then
				for k, v in pairs( Cosmetics.PlayerTops[steamid]["customs"] ) do
					if v.id == tables.id then
						err = Cosmetics.Config.Sentences[22][Cosmetics.Config.Lang]
						return
					end
				end
			elseif tables.type == "bottom" then
				for k, v in pairs( Cosmetics.PlayerBottoms[steamid] ) do
					if txt ==  k then
						err = Cosmetics.Config.Sentences[22][Cosmetics.Config.Lang]
						return
					end
				end
			end
			
			err = ""
			
			cart[rname] = tables
			
			if IsValid(CartP) then
				CartP:Remove()
			end
			OpenCart(CP)
		end
	
		
		nb = nb + 1
		
	end
end

OpenCharacterPage = function( Frame, sizex, sizey, ent )

	local DPanel = vgui.Create( "DPanel", Frame )
	DPanel:SetPos( 0,50 )
	DPanel:SetSize( sizex, sizey )
	local removeTime = -1
	local startTime = CurTime()
	DPanel:SetAlpha( 0 )
	
	local sizeym = sizey * 0.9
	local sizexm = sizeym * 0.7
	
	DPanel.Paint = function(pnl, w, h)
		local perc = 1
	
		if removeTime != -1 then
		
			perc = (1-math.Clamp(CurTime() - removeTime, 0, 1))/2
		else
			
			perc = ( math.Clamp(CurTime() - startTime, 0, 1) )
			
		end
		
		DPanel:SetAlpha(255 * perc)			
	end
	
	local panelx, panely = 310,392
	-- DPanelMenuC2:SetPos( ScrW()-panelx-50,(sizey-panely)/2 )
	
	local DButton2 = vgui.Create( "BButton", DPanel)
	DButton2:SetSize( panelx/2+1,30 )
	DButton2:SetPos(  ScrW()-(panelx/2-2)-50-3,sizey/2+panely/2-2 )
	DButton2:SetText(Cosmetics.Config.Sentences[19][Cosmetics.Config.Lang])	
	DButton2.DoClick = function( pnl )
		DermaPanel:Close()
	end	
	local DButton1 = vgui.Create( "BButton", DPanel)
	DButton1:SetSize( panelx/2+1,30 )
	DButton1:SetPos(  ScrW()-(panelx/2-2)-50-panelx/2-2,sizey/2+panely/2-2 )
	DButton1:SetText(Cosmetics.Config.Sentences[23][Cosmetics.Config.Lang])	
	DButton1.DoClick = function( pnl )
		DermaPanel:Close()
		net.Start("Cosmetics:BuyClothes")
			net.WriteTable(cart)
			net.WriteEntity(ent)
		net.SendToServer()
	end
	
	modelPanel = vgui.Create( "DModelPanel", DPanel )
	
	modelPanel:SetSize( sizexm, sizeym )
	modelPanel:SetPos( 50, sizey-sizeym )
	
	function modelPanel:LayoutEntity( Entity ) return end
	modelPanel:SetModel( infos.model )
	local startpos = modelPanel.Entity:GetBonePosition( modelPanel.Entity:LookupBone( "ValveBiped.Bip01_Pelvis" ) or 0 )

	modelPanel.LastChangePos = CurTime()

	modelPanel.pos = startpos
	modelPanel.el = Vector(-40,10,-0)
	modelPanel.isChanged = false

	modelPanel.oldPos = modelPanel.pos
	modelPanel.oldel = modelPanel.el
	
	modelPanel.Actualize = function()
	
		local datas 
		if infos.sex == 1 then
			datas = Cosmetics.Male.ListDefaultPM[infos.model]
		else
			datas = Cosmetics.Female.ListDefaultPM[infos.model]
		end
		modelPanel:SetModel( infos.model )
		
		local tindex = datas.bodygroupstop[infos.bodygroups.top].tee
		local pindex = datas.bodygroupsbottom[infos.bodygroups.pant].pant
		local eindex = datas.eyes
		local bodygroups = {
			datas.bodygroupstop[infos.bodygroups.top].group,
			datas.bodygroupsbottom[infos.bodygroups.pant].group
		}
		local skin = infos.skin
		local ent = modelPanel.Entity
		local pcolor = infos.playerColor
		local tops = infos.teetexture.basetexture
		local pants = infos.panttexture.basetexture
		ent:SetSkin( skin )
		for k, v in pairs( bodygroups ) do
			ent:SetBodygroup( v[1], v[2] )
		end
		for k, v in pairs( tindex ) do
			ent:SetSubMaterial( v, tops )
		end
		for k, v in pairs( pindex ) do
			ent:SetSubMaterial( v, pants )
		end

		ent.GetPlayerColor = function() return pcolor end
			
		for k, v in pairs( infos.eyestexture ) do
			
			local matr = v["r"]
			local matl = v["l"]
			local indexr = eindex["r"]
			local indexl = eindex["l"]
			ent:SetSubMaterial( indexr, matr )
			ent:SetSubMaterial( indexl, matl )
		
		end
		
		modelPanel.Entity:SetEyeTarget( modelPanel.pos-modelPanel.el )
		
	end

	modelPanel:Actualize()
	
	modelPanel.Think = function( pnl )
		
		if CurTime() - modelPanel.LastChangePos > 1 then return end
		
		if modelPanel.isChanged then
			modelPanel.oldPos = modelPanel.pos
			modelPanel.oldel = modelPanel.el
			modelPanel.pos = modelPanel.npos
			modelPanel.el = modelPanel.nel
			modelPanel.isChanged = false
		end
	
		local frac = CurTime() - modelPanel.LastChangePos
		
		modelPanel:SetLookAt( LerpVector( frac, modelPanel.oldPos, modelPanel.pos ) )

		modelPanel:SetCamPos( LerpVector( frac, modelPanel.oldPos-modelPanel.oldel, modelPanel.pos-modelPanel.el) )
		
		modelPanel.Entity:SetEyeTarget( LerpVector( frac, modelPanel.oldPos-modelPanel.oldel, modelPanel.pos-modelPanel.el ) )
		
	end
	
	local panelx, panely = DPanel:GetWide()/2.2, DPanel:GetTall()/1.3
	local pnOpen = 1
	
	local DPanelMenu = vgui.Create( "DPanel",DPanel )
	DPanelMenu:SetPos( (sizex-panelx)/2, (sizey-panely)/2 )
	DPanelMenu:SetSize( 80+50, panely )
	
	local list
	
	if LocalPlayer():CM_GetInfos().sex == 1 then
		list = Cosmetics.Male
	else
		list = Cosmetics.Female
	end
	
	local categories = {}
	
	categories[Cosmetics.Config.Sentences[24][Cosmetics.Config.Lang]]=true
	
	for k,v in pairs( list.ListTops ) do
		for key, val in pairs( v.category ) do
			if not table.HasValue(categories,val) then
				categories[val] = true
			end
		end
	end
	
	for k,v in pairs( list.ListBottoms ) do
		for key, val in pairs( v.category ) do
			if not table.HasValue(categories,val) then
				categories[val] = true
			end
		end
	end
	
	DPanelMenu.Paint = function(pnl, w, h)
		
		local we = 2
		draw.RoundedBox(0,0,0,w,h, Color(50, 50, 50,200))
		draw.ShadowSimpleText("Категории", "font_base_24", w/2,10,Color(255,255,255),1)
		
		local nbc2 = 0
		
		for k,v in pairs( categories ) do
			
			surface.SetFont("font_base_24")
			
			local x = surface.GetTextSize(k)
			if x + 20 + 10 >= 80+50 then
				draw.ShadowSimpleText(k, "font_base_18", 20+10,48+30*nbc2+10,Color(255,255,255),0,1)
			else
				draw.ShadowSimpleText(k, "font_base_18", 20+10,48+30*nbc2+10,Color(255,255,255),0,1)
			end
			nbc2 = nbc2 + 1
			
		end
	end
	
	local DPanelMenuC = vgui.Create( "DPanel",DPanel )
	DPanelMenuC:SetPos( 78+50+(sizex-panelx)/2, (sizey-panely)/2 )
	DPanelMenuC:SetSize( panelx - 80, panely )
	
	DPanelMenuC.Paint = function(pnl, w, h)
		
		local we = 2
		draw.RoundedBox(0,0,0,w,h, Color(50, 50, 50,200))
		
	end
	
	panelx,panely = 310,392
	
	local DPanelMenuC2 = vgui.Create( "DPanel",DPanel )
	DPanelMenuC2:SetPos( ScrW()-panelx-50,(sizey-panely)/2 )
	DPanelMenuC2:SetSize( panelx, panely )
	
	DPanelMenuC2.Paint = function(pnl, w, h)
		
		local we = 2
		draw.RoundedBox(0,0,0,w,h, Color(50, 50, 50,200))

	end
	
	local nbc = 0
	for k,v in pairs( categories ) do
		
		local DermaCheckbox = vgui.Create( "DCheckBox", DPanelMenu )
		DermaCheckbox:SetPos( 10, 50 + 30*nbc )
		DermaCheckbox:SetChecked( v )
		function DermaCheckbox:OnChange( bVal )
			if ( bVal ) then
				categories[k] = true
			else
				categories[k] = false
			end
			
			if IsValid( DPanel2 ) then
				DPanel2:Remove()
			end
			
			OpenList( DPanelMenuC, categories, DPanelMenuC2 )
		end
		nbc = nbc + 1
		
	end
	
	OpenList( DPanelMenuC, categories, DPanelMenuC2 )
	OpenCart( DPanelMenuC2 )
end

function CM_OpenShop(ent)
	local sizex, sizey = ScrW(),ScrH()

	DermaPanel = vgui.Create( "BFrame" )
	DermaPanel:SetPos(0,0)
	DermaPanel:SetSize( sizex, sizey )
	DermaPanel:SetTitle( "Магазин одежды" )
	DermaPanel:SetDraggable( false )
	DermaPanel:ShowCloseButton( false )
	DermaPanel:MakePopup()
	-- DermaPanel.Paint = function( pnl, w, h )
	-- 	DrawBlurRect(0,0, sizex, sizey*0.15, 6, 10)
	-- 	DrawBlurRect(0,ScrH()-sizey*0.15, sizex, sizey*0.15, 6, 10)
		
	-- 	DrawBlur( pnl, 8, 16 )
		
	-- 	draw.RoundedBox( 0, 0,0,sizex,sizey*0.15, Color(0,0,0,245))
	-- 	draw.RoundedBox( 0, 0,ScrH()-sizey*0.15,sizex,sizey*0.15, Color(0,0,0,245))

	-- 	DrawBlur( pnl, 8, 16 )
		
	-- 	draw.RoundedBox( 0, 0,0,sizex,sizey*0.15, Color(0,0,0,245))
	-- 	draw.RoundedBox( 0, 0,ScrH()-sizey*0.15,sizex,sizey*0.15, Color(0,0,0,245))

		
	-- end
	
	local DPanel = vgui.Create( "DPanel",DermaPanel )
	-- DPanel:SetPos( 0,sizey*0.15 )
	DPanel:SetSize( DermaPanel:GetWide(), DermaPanel:GetTall())
	DPanel.Paint = function() end
	
	infos = table.Copy(LocalPlayer():CM_GetInfos())
	cart = {}
	OpenCharacterPage( DPanel, DermaPanel:GetWide(), DermaPanel:GetTall(), ent )
end
