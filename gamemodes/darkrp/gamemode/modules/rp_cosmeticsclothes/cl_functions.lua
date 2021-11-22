local linkmaterialssave = {}
local GetPageMaterials

function CM_CreateClothes( infos, id )
	-- print("S--------------\n\n\n")
	-- print(debug.traceback())
	-- print("Creating the cloth : "..id)
	-- print("message arrivé")
	if not infos.HTMLTexturesCreated then GetPageMaterials( infos, id ) return end
	-- print("html matériaux créés")
	if not infos.baseTexture then return end
	-- print("basetexture "..id.." ok")
	if not Cosmetics.Male or not Cosmetics.Male.EditableTop or not Cosmetics.Male.EditableTop[infos.baseTexture] then return end

	local originalMat = Material( infos.baseTexture )
	local originalTex
	local newMat
	local newTex

	if not originalMat then print("not org. mat") return end

	newMat = originalMat:GetKeyValues()

	local w,h = 512,512

	newTex = GetRenderTargetEx( "CM_"..id, w,h, RT_SIZE_OFFSCREEN, MATERIAL_RT_DEPTH_NONE, 2, 0, IMAGE_FORMAT_RGB888 )
	
	-- newTex = GetRenderTarget( "CM_"..id, w,h,false )
	newMat["$basetexture"] = "CM_"..id
	
	newMat["$flags"] = nil
	newMat["$flags2"] = nil
	newMat["$flags_defined"] = nil
	newMat["$flags_defined2"] = nil

	newMat = CreateMaterial( "CM_"..id, originalMat:GetShader(), newMat )

	local posx =  Cosmetics.Male.EditableTop[infos.baseTexture].posx
	local posy =  Cosmetics.Male.EditableTop[infos.baseTexture].posy
	local sizex =  Cosmetics.Male.EditableTop[infos.baseTexture].sizex
	local sizey =  Cosmetics.Male.EditableTop[infos.baseTexture].sizey

	

	hook.Add( "PostRender", "Cosmetics_PostRender"..id, function()
		hook.Remove( "PostRender", "Cosmetics_PostRender"..id )
		if originalTex==nil then
			-- print("original tex of the material "..id.." is nil")
		   originalTex = originalMat:GetTexture( "$basetexture" ) or false -- must be loaded late!
		end
		if originalTex then
			render.PushRenderTarget( newTex )
				cam.Start2D()
					-- print("generating "..id.."..")
					render.Clear( 128,128,128,255, true, true )
					render.DrawTextureToScreen( originalTex )

					for key, text in pairs( infos.customThings.Texts ) do

						surface.SetFont( "Bariol"..math.Round(text.textsize/4) )
						surface.SetTextColor( Color(text.color.r, text.color.g, text.color.b, text.color.a ) )
						surface.SetTextPos( posx + text.posx/4, posy + text.posy/4 )
						surface.DrawText( text.text )
						
						-- print("text:"..id)
						-- print(text.text)
						
					end
					
					for key, img in pairs( infos.customThings.Images ) do

						local mat = linkmaterialssave[img.link]
						
						if not mat then continue end
						
						surface.SetDrawColor( 255, 255, 255, 255 )
						surface.SetMaterial( mat )
						surface.DrawTexturedRect( posx + img.posx/4, posy + img.posy/4, img.sizex/3 - 2, img.sizey/3.5 + 2)
						
						
					end
					
				cam.End2D()
			render.PopRenderTarget()
		end
	end )
	
	-- print("The material"..id.."has been created")
	
	-- set the material again
	
	timer.Simple(5, function()
		
		for k, ply in pairs ( player.GetAll() ) do
			
			for key, value in pairs( ply:GetMaterials() ) do
				
				local mat = ply:GetSubMaterial( key )
				
				if mat == "!CM_"..id then
					-- print(ply)
					-- print("has this")
					-- print(id)
					ply:SetSubMaterial( key, "!CM_"..id )
				end
				
			end
			
		end
	
	end)
		
	--[[	if true then return end
		
		if ply:CM_GetInfos().teetexture.hasCustomThings then
			-- print(ply:Name().." has custom things")
			if ply:CM_GetInfos().teetexture.id == id then
				print(ply:Name().." has custom things with this id "..id)
				local tab
				if ply:CM_GetSex() == 1 then
					tab = Cosmetics.Male
				else
					tab = Cosmetics.Female
				end

				local topgroup = ply:CM_GetInfos().bodygroups.top or "polo"
				local list = tab.ListDefaultPM[ply:GetModel()] or {}
				local teeindex = list.bodygroupstop[topgroup].tee or -1
				-- print("var")
				if teeindex == -1 then return end
				-- print("applying")
				for k, v in pairs( teeindex ) do
					-- print("material reset"..id)
					ply:SetSubMaterial( v, "!CM_"..id )
				end
					
			end
			
		end
		
	end
	--]]
	-- print("\n\n\n--------------E")

end

GetPageMaterials = function( infos, id )
	
	local list = {}
	
	for k, v in pairs( infos.customThings.Images ) do

		local link = v.link
		
		if linkmaterialssave[link] then continue end
		
		local Panel = vgui.Create( "DHTML" )
		Panel:Dock( FILL )
		
		if not link then return end
		
		Panel:SetHTML( [[
	
			<html><head><style>body{
				background-attachment: fixed;
				background-image: url("]]..link..[[");
				background-repeat: repeat;
				background-size: 100% 100%;
				overflow: hidden;
			}</style></head><body></body></html>
			
			]] 	)
		
		Panel:SetAlpha( 0 )
		Panel:SetMouseInputEnabled( false )
		function Panel:ConsoleMessage( msg ) end
		
		Panel.link = link
		
		list[k] = Panel
		
		-- while Panel:IsLoading() do
			-- print("loading..")
		-- end
		
		-- print("loading finished")
		
		-- local html_mat = Panel:GetHTMLMaterial()

		
		-- if IsValid( Panel ) then
			
			-- Panel:Remove()
			
		-- end
		
		-- v.Mat = html_mat
		-- print("material:")
		-- print(v.Mat)
	end
	
	timer.Create("CM_CreatingMaterial"..id, 1, 0, function()
		
		local allloaded = true
		
		for k, v in pairs( list ) do
			
			if IsValid( v ) and not v:IsLoading() then
				continue
			else
				allloaded = false
			end
			
		end
		
		if allloaded then
			for k, v in pairs( list ) do
					
				local html_mat = v:GetHTMLMaterial()

				
				if IsValid( Panel ) then
					
					Panel:Remove()
					
				end
				
				v.Mat = html_mat
				
				linkmaterialssave[v.link] = v.Mat
					
			end
			
			infos.HTMLTexturesCreated = true
			
			CM_CreateClothes( infos, id )
			timer.Remove("CM_CreatingMaterial"..id)
			
		end
		
	end)

end