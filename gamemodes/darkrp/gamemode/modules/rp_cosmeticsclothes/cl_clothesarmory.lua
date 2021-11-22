surface.CreateFont( "CosmeticsTitle1", {
	font = "Walking in the Street", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 100,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

local blur = Material("pp/blurscreen")

local DermaPanel
local infos

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

local param = Material("materials/cosmetics/003-note.png")
local head = Material("materials/cosmetics/002-people-1.png")
local eyes = Material("materials/cosmetics/007-medical.png")
local top = Material("materials/cosmetics/006-game.png")
local pant = Material("materials/cosmetics/001-fashion.png")
local male = Material("materials/cosmetics/male.png")
local female = Material("materials/cosmetics/female.png")

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

local OpenPantPage = function( Panel )
	local DPanel = vgui.Create( "DPanel", Panel )

	local w, h = Panel:GetSize()
	
	DPanel:SetSize( w, h )
	DPanel:SetPos( 0,0 )
	DPanel.Paint = function()
		draw.SimpleText( Cosmetics.Config.Sentences[14][Cosmetics.Config.Lang], "Bariol25",w/2,30,Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
	end
	
	local DPanel2 = vgui.Create( "SRP_ScrollPanel", Panel )

	DPanel2:SetSize( w-20, h-100 )
	DPanel2:SetPos( 10,80 )
	DPanel2.Paint = function()
		draw.RoundedBox(0,0,0,w,h, Color(0,0,0,100))
	end
	
	local sbar = DPanel2:GetVBar()

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
	
	local list = Cosmetics.PlayerBottoms[LocalPlayer():SteamID64()] or {}
	
	local nb = 0	
	local line = -1
	
	for pant, tables in pairs ( list ) do
				
		local nbl = math.mod( nb, 3 )

		if nbl == 0 then
			line = line + 1
			nb = 0
		end
		
		local DPanel3 = vgui.Create( "DButton", DPanel2 )
		DPanel3:SetSize( 40+45, 40+45 )
		DPanel3:SetPos( 5 + 90*nb, 5+95* line )
		DPanel3:SetText("")
		DPanel3.Paint = function(p, w, h)
		end
		
		local DmodelPanel = vgui.Create( "DModelPanel", DPanel3 )
		DmodelPanel:SetSize( 85, 85 )
		DmodelPanel:SetPos( 0, 0 )
		function DmodelPanel:LayoutEntity( Entity ) return end
		DmodelPanel:SetModel( infos.model )
		
		local startpos = DmodelPanel.Entity:GetBonePosition( DmodelPanel.Entity:LookupBone( "ValveBiped.Bip01_R_Calf" ) or 0) + Vector( 0,5,0 )
		DmodelPanel:SetLookAt( startpos )
		DmodelPanel:SetCamPos( startpos - Vector( -30,-0,0) )
		DmodelPanel.Entity:SetEyeTarget( startpos - Vector( -30,-0,0) )
	
		--
		local datas 
		if infos.sex == 1 then
			datas = Cosmetics.Male.ListDefaultPM[infos.model]
		else
			datas = Cosmetics.Female.ListDefaultPM[infos.model]
		end
			
		local tindex = datas.bodygroupsbottom[tables.bodygroup].pant 
		local bodygroups = {
			datas.bodygroupsbottom[tables.bodygroup].group,
		}
		
		local ent = DmodelPanel.Entity
		
		for k, v in pairs( bodygroups ) do
			ent:SetBodygroup( v[1], v[2] )
		end
		
		local pants = pant
		
		for k, v in pairs( tindex ) do
			ent:SetSubMaterial( v, pants )
		end

		local DButton3 = vgui.Create( "DButton", DPanel3 )
		DButton3:SetSize( 40+45, 40+45 )
		DButton3:SetPos( 0,0 )
		DButton3:SetText("")
		DButton3.Paint = function(p, w, h)
			draw.RoundedBox(0,0,0,w,h, Color(0,0,0,150))
			local m = 0
			if infos.panttexture.basetexture == pants then
				m = 1
			end
			
			draw.RoundedBox(0,0,0,w,2, Color(255,255,255,255 * m))
			draw.RoundedBox(0,0,h-2,w,2, Color(255,255,255,255 * m))
			draw.RoundedBox(0,0,0,2,h, Color(255,255,255,255  * m))
			draw.RoundedBox(0,w-2,0,2,h, Color(255,255,255,255 * m))
		end
		DButton3.DoClick = function( pnl )

			infos.bodygroups.pant = tables.bodygroup
	
			infos.panttexture.basetexture = pants
			
			modelPanel.Actualize()
			
		end
		
		nb = nb + 1
	end
end

local OpenTopMenu = function( Panel )
	local DPanel = vgui.Create( "DPanel", Panel )

	local w, h = Panel:GetSize()
	
	DPanel:SetSize( w, h )
	DPanel:SetPos( 0,0 )
	DPanel.Paint = function()
		draw.SimpleText( Cosmetics.Config.Sentences[14][Cosmetics.Config.Lang], "Bariol25",w/2,30,Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
	end
	
	local DPanel2 = vgui.Create( "SRP_ScrollPanel", Panel )

	DPanel2:SetSize( w-20, h-100 )
	DPanel2:SetPos( 10,80 )
	DPanel2.Paint = function()
		draw.RoundedBox(0,0,0,w,h, Color(0,0,0,100))
	end
	
	local sbar = DPanel2:GetVBar()

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
	
	local list = Cosmetics.PlayerTops[LocalPlayer():SteamID64()] or {}
	
	local nb = 0	
	local line = -1
		
	for iscustom, newlist in pairs ( list ) do
		for tee, tables in pairs ( newlist ) do
				
			local nbl = math.mod( nb, 3 )

			if nbl == 0 then
				line = line + 1
				nb = 0
			end
			
			local DPanel3 = vgui.Create( "DButton", DPanel2 )
			DPanel3:SetSize( 40+45, 40+45 )
			DPanel3:SetPos( 5 + 90*nb, 5+95* line )
			DPanel3:SetText("")
			DPanel3.Paint = function(p, w, h)
			end
			
			local DmodelPanel = vgui.Create( "DModelPanel", DPanel3 )
			DmodelPanel:SetSize( 85, 85 )
			DmodelPanel:SetPos( 0, 0 )
			function DmodelPanel:LayoutEntity( Entity ) return end
			DmodelPanel:SetModel( infos.model )

			local startpos = DmodelPanel.Entity:GetBonePosition( DmodelPanel.Entity:LookupBone( "ValveBiped.Bip01_Spine2" ) or 0)
			DmodelPanel:SetLookAt( startpos )
			DmodelPanel:SetCamPos( startpos - Vector( -25,0,0) )
			DmodelPanel.Entity:SetEyeTarget( startpos - Vector( -25,0,0) )
			
			--
			local data
			local datas 
			if infos.sex == 1 then
				data = Cosmetics.Male
			else
				data = Cosmetics.Female
			end
			
			
			local datas = data.ListDefaultPM[infos.model]
			
			local tindex
			local bodygroups
			local tbdg
			
			local bodygroupname
			
			if tables.id and Cosmetics.Textures and data.EditableTop[Cosmetics.Textures[tables.id].baseTexture] then
				
				tbdg = data.EditableTop[Cosmetics.Textures[tables.id].baseTexture]
		
				-- if true then return end
				tindex = datas.bodygroupstop[tbdg.bodygroup].tee 
				
				bodygroups = {
					datas.bodygroupstop[tbdg.bodygroup].group,
				}
				
				bodygroupname = tbdg.bodygroup
				
			else
				local t = datas.bodygroupstop[tables.bodygroup]
				tindex =  t.tee 
				bodygroups =  {
					datas.bodygroupstop[tables.bodygroup].group,
				}
				
				bodygroupname = tables.bodygroup
				
			end
			
			local ent = DmodelPanel.Entity
			
			for k, v in pairs( bodygroups ) do
				ent:SetBodygroup( v[1], v[2] )
			end
		
			local tops = tee
						
			for k, v in pairs( tindex ) do
				if iscustom == "customs" then
					ent:SetSubMaterial( v, "!CM_"..tables.id )
				else
					ent:SetSubMaterial( v, tops )
				end
			end

			local DButton3 = vgui.Create( "DButton", DPanel3 )
			DButton3:SetSize( 40+45, 40+45 )
			DButton3:SetPos( 0,0 )
			DButton3:SetText("")
			DButton3.Paint = function(p, w, h)
				draw.RoundedBox(0,0,0,w,h, Color(0,0,0,150))
				local m = 0
				if tables.id then
					if tables.id == infos.teetexture.id and infos.teetexture.basetexture == "!CM_"..tables.id then
						m = 1
					end
				else
					if infos.teetexture.basetexture == tops then
						m = 1
					end
				end
			
				draw.RoundedBox(0,0,0,w,2, Color(255,255,255,255 * m))
				draw.RoundedBox(0,0,h-2,w,2, Color(255,255,255,255 * m))
				draw.RoundedBox(0,0,0,2,h, Color(255,255,255,255  * m))
				draw.RoundedBox(0,w-2,0,2,h, Color(255,255,255,255 * m))
			end
			DButton3.DoClick = function( pnl )

				infos.bodygroups.top = bodygroupname
		
				if iscustom == "customs" then
					infos.teetexture.basetexture = "!CM_"..tables.id
					infos.teetexture.id = tables.id
					infos.teetexture.hasCustomThings = true
				else
					infos.teetexture.basetexture = tops
					infos.teetexture.hasCustomThings = false
				end
				modelPanel.Actualize()
				
			end
			
			nb = nb + 1
		end
	end
end

OpenCharacterPage = function( Frame, sizex, sizey, ent )

	local DPanel = vgui.Create( "DPanel",Frame )
	DPanel:SetPos( 0,50 )
	DPanel:SetSize( sizex, sizey )
	local removeTime = -1
	local startTime = CurTime()
	DPanel:SetAlpha( 0 )
	DPanel:MoveTo( 0,0,1,0,-1, function() end )
	
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

	local DButton = vgui.Create( "DButton", DPanel)
	DButton:SetSize( panelx/2-2.5,30 )
	DButton:SetPos( ScrW()/2-panelx/2, sizey - 50 )
	DButton:SetText( "" )	
	DButton.Paint = function(pnl, w, h )
		
		local perc = 1
		
		if removeTime != -1 then
		
			perc = (1-math.Clamp(CurTime() - removeTime, 0, 1))/2
		
		end
	
		draw.RoundedBox( 0, 0,0,w,h, Color(0,0,0,100))
		draw.RoundedBox(0,0,0,w,2, Color(255,255,255,255))
		draw.RoundedBox(0,0,h-2,w,2, Color(255,255,255,255))
		draw.RoundedBox(0,0,0,2,h, Color(255,255,255,255 ))
		draw.RoundedBox(0,w-2,0,2,h, Color(255,255,255,255))
		
		draw.SimpleText( Cosmetics.Config.Sentences[15][Cosmetics.Config.Lang], "Bariol25",(panelx/2-2.5)/2,30/2-1,Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	
	end
	DButton.DoClick = function( pnl )
		net.Start("Cosmetics:ChangeClothes")
			if infos.teetexture.hasCustomThings then
				net.WriteString(infos.teetexture.id)
			else
				net.WriteString(infos.teetexture.basetexture)
			end
			net.WriteString(infos.panttexture.basetexture)
			net.WriteBool(infos.teetexture.hasCustomThings)
			net.WriteEntity(ent)
		net.SendToServer()
		DermaPanel:Close()
	end
	
	local DButton2 = vgui.Create( "DButton", DPanel)
	DButton2:SetSize( panelx/2-2.5,30 )
	DButton2:SetPos( ScrW()/2-panelx/2 + panelx/2+2.5, sizey - 50 )
	DButton2:SetText( "" )	
	DButton2.Paint = function(pnl, w, h )
		
		local perc = 1
		
		if removeTime != -1 then
		
			perc = (1-math.Clamp(CurTime() - removeTime, 0, 1))/2
		
		end
	
		draw.RoundedBox( 0, 0,0,w,h, Color(0,0,0,100))
		draw.RoundedBox(0,0,0,w,2, Color(255,255,255,255))
		draw.RoundedBox(0,0,h-2,w,2, Color(255,255,255,255))
		draw.RoundedBox(0,0,0,2,h, Color(255,255,255,255 ))
		draw.RoundedBox(0,w-2,0,2,h, Color(255,255,255,255))
		
		draw.SimpleText( Cosmetics.Config.Sentences[19][Cosmetics.Config.Lang], "Bariol25",(panelx/2-2.5)/2,30/2-1,Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	
	end
	DButton2.DoClick = function( pnl )
		DermaPanel:Close()
	end
	
	modelPanel = vgui.Create( "DModelPanel", DPanel )
	
	modelPanel:SetSize( sizexm, sizeym )
	modelPanel:SetPos( ScrW()/2-sizexm/2, 0 )
	
	function modelPanel:LayoutEntity( Entity ) return end
	modelPanel:SetModel( infos.model )
	local startpos = modelPanel.Entity:GetBonePosition( modelPanel.Entity:LookupBone( "ValveBiped.Bip01_Pelvis" ) or 0 )

	modelPanel.LastChangePos = CurTime()
	
	modelPanel.pos = startpos
	modelPanel.el = Vector(-40,-10,-0)
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
	
	local pnOpen = 1
	
	local DPanelMenu = vgui.Create( "DPanel",DPanel )
	DPanelMenu:SetPos( 50, (sizey-panely)/2 )
	DPanelMenu:SetSize( panelx, 40 )
	
	DPanelMenu.Paint = function(pnl, w, h)
		
		local we = 2
		draw.RoundedBox(0,0,0,w,h, Color(0, 0, 0,200))
		draw.RoundedBox(0,0,0,w,we,Color(255,255,255,255))
		draw.RoundedBox(0,0,h-we,w,we,Color(255,255,255,255))
		draw.RoundedBox(0,0,0,we,h,Color(255,255,255,255))
		draw.RoundedBox(0,w-we,0,we,h,Color(255,255,255,255))
		draw.SimpleText( Cosmetics.Config.Sentences[16][Cosmetics.Config.Lang], "Bariol25", w/2, h/2 ,Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

	end
	
	local DPanelMenuC = vgui.Create( "DPanel",DPanel )
	DPanelMenuC:SetPos( 50,(sizey-panely)/2+38 )
	DPanelMenuC:SetSize( panelx, panely )
	
	DPanelMenuC.Paint = function(pnl, w, h)
		
		local we = 2
		draw.RoundedBox(0,0,0,w,h, Color(0, 0, 0,200))
		draw.RoundedBox(0,0,0,w,we,Color(255,255,255,255))
		draw.RoundedBox(0,0,h-we,w,we,Color(255,255,255,255))
		draw.RoundedBox(0,0,0,we,h,Color(255,255,255,255))
		draw.RoundedBox(0,w-we,0,we,h,Color(255,255,255,255))
		
	end
	OpenTopMenu( DPanelMenuC )
	
	local DPanelMenu2 = vgui.Create( "DPanel",DPanel )
	DPanelMenu2:SetPos( ScrW()-50-panelx, (sizey-panely)/2 )
	DPanelMenu2:SetSize( panelx, 40 )
	
	DPanelMenu2.Paint = function(pnl, w, h)
		
		local we = 2
		draw.RoundedBox(0,0,0,w,h, Color(0, 0, 0,200))
		draw.RoundedBox(0,0,0,w,we,Color(255,255,255,255))
		draw.RoundedBox(0,0,h-we,w,we,Color(255,255,255,255))
		draw.RoundedBox(0,0,0,we,h,Color(255,255,255,255))
		draw.RoundedBox(0,w-we,0,we,h,Color(255,255,255,255))
		draw.SimpleText( Cosmetics.Config.Sentences[16][Cosmetics.Config.Lang], "Bariol25", w/2, h/2 ,Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

	end
	
	local DPanelMenuC2 = vgui.Create( "DPanel",DPanel )
	DPanelMenuC2:SetPos( ScrW()-50-panelx,(sizey-panely)/2+38 )
	DPanelMenuC2:SetSize( panelx, panely )
	
	DPanelMenuC2.Paint = function(pnl, w, h)
		
		local we = 2
		draw.RoundedBox(0,0,0,w,h, Color(0, 0, 0,200))
		draw.RoundedBox(0,0,0,w,we,Color(255,255,255,255))
		draw.RoundedBox(0,0,h-we,w,we,Color(255,255,255,255))
		draw.RoundedBox(0,0,0,we,h,Color(255,255,255,255))
		draw.RoundedBox(0,w-we,0,we,h,Color(255,255,255,255))
		
	end
	OpenPantPage( DPanelMenuC2 )

end

function CM_OpenArmory(ent)

	local sizex, sizey = ScrW(),ScrH()

	DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( (ScrW()-sizex)/2, (ScrH()-sizey)/2 )
	DermaPanel:SetSize( sizex, sizey )
	DermaPanel:SetTitle( "" )
	DermaPanel:SetDraggable( false )
	DermaPanel:ShowCloseButton( false )
	DermaPanel:MakePopup()
	DermaPanel.Paint = function( pnl, w, h )
		DrawBlurRect(0,0, sizex, sizey*0.15, 6, 10)
		DrawBlurRect(0,ScrH()-sizey*0.15, sizex, sizey*0.15, 6, 10)
		
		DrawBlur( pnl, 8, 16 )
		
		draw.RoundedBox( 0, 0,0,sizex,sizey*0.15, Color(0,0,0,245))
		draw.RoundedBox( 0, 0,ScrH()-sizey*0.15,sizex,sizey*0.15, Color(0,0,0,245))

		DrawBlur( pnl, 8, 16 )
		
		draw.RoundedBox( 0, 0,0,sizex,sizey*0.15, Color(0,0,0,245))
		draw.RoundedBox( 0, 0,ScrH()-sizey*0.15,sizex,sizey*0.15, Color(0,0,0,245))

		
	end
	
	local DPanel = vgui.Create( "DPanel",DermaPanel )
	DPanel:SetPos( 0,sizey*0.15 )
	DPanel:SetSize( sizex, sizey*0.7 )
	DPanel.Paint = function() end
	
	infos = table.Copy(LocalPlayer():CM_GetInfos())
	
	OpenCharacterPage( DPanel, sizex, sizey*0.7, ent )
end
