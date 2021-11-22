local meta = FindMetaTable( "Player" )

Cosmetics.PlayerInfos = Cosmetics.PlayerInfos or {}

function meta:CM_DropCloth( type, notif )

	if Cosmetics.Config.ForbiddenJobs[self:Team()] or Cosmetics.Config.ForbiddenJobsWithHeads[self:Team()] then
		self:CM_Notif(Cosmetics.Config.Sentences[36][Cosmetics.Config.Lang])
	return end

	local PlyDonateSkin = self:GetNVar("DonateSkin")
	if PlyDonateSkin then
		return 
	end

	if type ~= 1 and type ~= 2 then return end
	
	local infos = self:CM_GetInfos()
	
	if type == 1 then -- top
		-- print("no custom")
		local text = infos.teetexture.basetexture
		
		-- remove the top
		local steamid = self:SteamID64() or "novalue"
		local charid = self:GetNVar('CurrentChar') or 0
		
		-- drop to the ground the top
		
		local data
		if infos.sex == 1 then
			data = Cosmetics.Male
		else
			data = Cosmetics.Female
		end
		
		local name = "No name"
		
		for k, v in pairs( data.ListTops ) do
			
			if v.texture == text then
				
				name = k
				
				break
				
			end
			
		end
				
		-- local ent = ents.Create("cm_cloth")
		-- ent:SetModel("models/props_c17/suitcase_passenger_physics.mdl")
		-- ent:SetPos( self:GetPos() + self:GetAngles():Forward()*30 + self:GetAngles():Up()*30 )
		-- ent:Spawn()
		-- ent:SetCName(name)
		-- ent.Type = 1.2
		-- ent.Sex = infos.sex
		-- ent.Texture = text
		self:AddItem(INV_CLOTHES, name)
		
		-- change the PM
		if infos.sex == 1 then
			-- print("changing you clothes")
			infos.teetexture.basetexture = nil -- mettre les tons ici, à modifier
			infos.teetexture.id = nil
			infos.teetexture.hasCustomThings = false
			infos.bodygroups.top = "nude"
			-- print("that's done")
		else -- IF IT IS A FEMALE THEN
		
			infos.teetexture.basetexture = nil -- mettre les tons ici, à modifier
			infos.teetexture.id = nil
			infos.teetexture.hasCustomThings = false
			infos.bodygroups.top = "nude"
			
		end
		
		self:CM_SavePlayerInfos()
		self:CM_NetworkTableInfos()
		if notif then
			self:CM_Notif(Cosmetics.Config.Sentences[39][Cosmetics.Config.Lang])
		end
	else -- bottom
		local text = infos.panttexture.basetexture -- Текущая текстура штанов
		
		-- remove the top
		local steamid = self:SteamID64() or "novalue"
		local charid = self:GetNVar('CurrentChar') or 0
		Cosmetics.PlayerBottoms[steamid][charid] = Cosmetics.PlayerBottoms[steamid][charid] or {}
		local list = Cosmetics.PlayerBottoms[steamid][charid]
		
		if not Cosmetics.PlayerBottoms[steamid][charid][text] then 
			if notif then
				self:CM_Notif(Cosmetics.Config.Sentences[38][Cosmetics.Config.Lang])
			end
			return 
		end
		
		Cosmetics.PlayerBottoms[steamid][charid][text] = nil
		
		-- drop to the ground the top
		
		local data
		if infos.sex == 1 then
			data = Cosmetics.Male
		else
			data = Cosmetics.Female
		end
		
		local name = "No name"
		
		for k, v in pairs( data.ListBottoms ) do
			
			if v.texture == text then
				
				name = k
				
				break
				
			end
			
		end
				
		-- local ent = ents.Create("cm_cloth")
		-- ent:SetModel("models/props_c17/suitcase_passenger_physics.mdl")
		-- ent:SetPos( self:GetPos() + self:GetAngles():Forward()*30 + self:GetAngles():Up()*30 )
		-- ent:Spawn()
		-- ent:SetCName(name)
		-- ent.Type = 2
		-- ent.Sex = infos.sex
		-- ent.Texture = text
		self:AddItem(INV_CLOTHES, name)
		-- change the PM
		if infos.sex == 1 then
			-- print("changing you clothes")
			infos.panttexture.basetexture = nil -- mettre les tons ici, à modifier
			infos.panttexture.id = nil
			infos.panttexture.hasCustomThings = false
			infos.bodygroups.pant = "nude"
			-- print("that's done")
		else -- IF IT IS A FEMALE THEN
		
			infos.panttexture.basetexture = nil -- mettre les tons ici, à modifier
			infos.panttexture.id = nil
			infos.panttexture.hasCustomThings = false
			infos.bodygroups.pant = "nude"
			
		end
		--
		--
		
		self:CM_SavePlayerInfos()
		self:CM_NetworkTableInfos()
		if notif then
			self:CM_Notif(Cosmetics.Config.Sentences[40][Cosmetics.Config.Lang])
		end
	
	end

end

function meta:CM_AddTop( infos, iscustom )

	local steamid = self:SteamID64() or "novalue"
	local charid = self:GetNVar('CurrentChar') or 0
	
	Cosmetics.PlayerTops = Cosmetics.PlayerTops or {}
	Cosmetics.PlayerTops[steamid] = Cosmetics.PlayerTops[steamid] or {}
	Cosmetics.PlayerTops[steamid][charid] = Cosmetics.PlayerTops[steamid][charid] or {}
	Cosmetics.PlayerTops[steamid][charid]["customs"] = Cosmetics.PlayerTops[steamid][charid]["customs"] or {}
	Cosmetics.PlayerTops[steamid][charid]["ncustoms"] = Cosmetics.PlayerTops[steamid][charid]["ncustoms"] or {}
	
	if iscustom then
	
		local id = infos.id or -1
		
		local tab 
		if self:CM_GetInfos().sex == 1 then
			tab = Cosmetics.Male
		else
			tab = Cosmetics.Female
		end
		
		local bodygroupn = tab.EditableTop[CM_GetTextureInfos( id ).baseTexture].bodygroup
		
		Cosmetics.PlayerTops[steamid][charid]["customs"][#Cosmetics.PlayerTops[steamid][charid]["customs"]+1] = {
			bodygroup = bodygroupn or "polo",
			id = id,
			-- id = id,
			-- isInShop = infos.isInShop or false,
			-- price = infos.price or 100,
			-- sex = infos.sex or 1,
			-- allowPlayerColor = infos.allowPlayerColor or false,
			-- baseTexture = infos.baseTexture or "",
			-- customThings = infos.customThings or { Images = {}, Texts = {} }
		}
		
	else
		
		Cosmetics.PlayerTops[steamid][charid]["ncustoms"][infos.texture] = {
			bodygroup = infos.bodygroup or "polo",
		}
		
	end
		
end

function meta:CM_AddBottom( infos )
	
	local steamid = self:SteamID64() or "novalue"
	local charid = self:GetNVar('CurrentChar') or 0
	
	Cosmetics.PlayerBottoms = Cosmetics.PlayerBottoms or {}
	Cosmetics.PlayerBottoms[steamid] = Cosmetics.PlayerBottoms[steamid] or {}
	Cosmetics.PlayerBottoms[steamid][charid] = Cosmetics.PlayerBottoms[steamid][charid] or {}
	
	
	Cosmetics.PlayerBottoms[steamid][charid][infos.texture] = {
		bodygroup = infos.bodygroup or "pant",
	}
	
end

function meta:CM_GetBottomList(ID)
	local emptytbl = {
		customs = {},
		ncustoms = {},
	}
	
	local list = Cosmetics.PlayerBottoms or {}
	local steamid = self:SteamID64() or "novalue"
	if not list or not list[steamid] then
		return emptytbl
	end
	local charid = ID and ID or self:GetNVar('CurrentChar') or 0
	local list2 = list[steamid][charid] or {}

	return list2
	
end

function meta:CM_GetTopList(ID)
	local emptytbl = {
		customs = {},
		ncustoms = {},
	}

	local list = Cosmetics.PlayerTops or {}
	local steamid = self:SteamID64() or "novalue"
	if not list or not list[steamid] then
		return emptytbl
	end
	local charid = ID and ID or self:GetNVar('CurrentChar') or 0
	local list2 = list[steamid][charid] or {}

	return list2
	
end

function meta:CM_GetCustomTops()
	
	local list = self:CM_GetTopList()
	local list2 = list["customs"] or {}
	
	return list2
	
end

function meta:CM_GetNCustomTops()
	
	local list = self:CM_GetTopList()
	local list2 = list["ncustoms"] or {}
	
	return list2
	
end

function meta:CM_SavePlayerInfos(ID) 
	ID = ID or nil

	local json1 = util.TableToJSON( self:CM_GetInfos(ID) )
	local json2 = util.TableToJSON( self:CM_GetTopList(ID) )
	local json3 = util.TableToJSON( self:CM_GetBottomList(ID) )
	
	local steamid = self:SteamID64() or "novalue"
	local charid = ID and ID or self:GetNVar('CurrentChar') or 0
	print("Сохраняем персонажа " .. charid)
	-- print(charid)
	
	file.CreateDir( "cosmetics/"..steamid.."/"..charid.."/" )
	
	file.Write( "cosmetics/"..steamid.."/"..charid.."/clothes_infos.txt", json1 )
	file.Write( "cosmetics/"..steamid.."/"..charid.."/tops.txt", json2 )
	file.Write( "cosmetics/"..steamid.."/"..charid.."/bottoms.txt", json3 )
	
end

function meta:CM_NetworkTableInfos(ID)
	ID = ID or nil

	print(ID)
	local tab1 = self:CM_GetInfos(ID)
	local tab2 = self:CM_GetTopList(ID)
	local tab3 = self:CM_GetBottomList(ID)
	
	self:CM_ApplyModel()
	
	net.Start("Cosmetics:BroadcastPlayerInfos")
		net.WriteTable(tab1)
		net.WriteTable(tab2)
		net.WriteTable(tab3)
		net.WriteEntity(self)
		net.WriteInt(ID and ID or -1, 20)
	net.Broadcast()

end

function CM_NetworkTableInfos()
	net.Start("Cosmetics:BroadcastPlayersInfos")
		net.WriteTable(Cosmetics.PlayerInfos or {})
		net.WriteTable(Cosmetics.PlayerTops or {})
		net.WriteTable(Cosmetics.PlayerBottoms or {})
	net.Broadcast()
end

-- local baseTextures = {}
-- local baseTextures = {
	-- id = 10,
	-- name = "Test",
	-- isInShop = true,
	-- price = 100,
	-- sex = 1,
	-- allowPlayerColor = true,
	-- baseTexture = "",
	-- customThings = {
		-- Texts = {
			-- [1] = {
				-- posx = 10,
				-- posy = 10,
				-- text = "Test",
				-- textsize = 10,
				-- color = Color(255,255,255,255)
			-- },
		-- },
		-- Images = {
			-- [1] = {
				-- posx = 10,
				-- posy = 10,
				-- sizex = 10,
				-- sizey = 10,
				-- link = "",
				-- alpha = 255
			-- },
		-- },
	-- },
-- }

function CM_CheckTextureInfos( infos )

	if infos.isInShop and (not infos.name or not infos.price) then
		return false, "1"
	end

	infos.price = tonumber( infos.price )
	
	if not infos.baseTexture then return false, "2" end
	
	if not infos.sex then return false, "3" end
	
	local bt
	
	if infos.sex == 1 then
		if not Cosmetics.Male.EditableTop[infos.baseTexture] then
			return false, "4"
		else
			bt = Cosmetics.Male.EditableTop[infos.baseTexture]
		end
	elseif infos.sex == 0 then
		if not Cosmetics.Female.EditableTop[infos.baseTexture] then
			return false, "5"
		else
			bt = Cosmetics.Female.EditableTop[infos.baseTexture]
		end
	else
		return false, "6"
	end
	
	if not infos.customThings then return false, "6.1" end
	
	local cust = infos.customThings 
	
	local texts = cust.Texts or {}
	local images = cust.Images or {}
	
	local stop = false
	
	local btsizex = bt.sizex
	local btsizey = bt.sizey
	
	local nbtxt = #texts
	local nbimg = #images
	if nbtxt == 0 and nbimg	== 0 then return false, "6.1.2" end
	
	for key, datas in pairs ( texts ) do
		
		-- max txts
		if key > 10 then stop = true return false, "6.2" end
		if not datas.posx or not datas.posy or not datas.text or not datas.textsize then stop = true return false, "6.3" end
		
		datas.posx = tonumber( datas.posx )
		datas.posy = tonumber( datas.posy )
		
		local posx = datas.posx
		local posy = datas.posy
		local text = datas.text
		local clr = datas.color or Color(255,255,255,255)
		
		if not isstring( text ) then stop = true return false, "6.4" end
		
		local textsize = tonumber(datas.textsize)
		
		-- font sizes
		if textsize < 10 or textsize > 100 then stop = true return false, "6.5" end
		
		if not clr or not clr.r or not clr.g or not clr.b or not clr.a then stop = true return false, "6.6" end
		
		local color = Color(clr.r,clr.g,clr.b,clr.a)
		
		infos.customThings.Texts[key].color = color
		
	end

	if stop then return false, "7" end

	stop = false
	
	for key, datas in pairs ( images ) do
		
		-- max imgs
		if key > 5 then stop = true return false, "8" end
		if not datas.posx or not datas.posy or not datas.sizex or not datas.sizey or not datas.link then stop = true return false, "9" end
		
		datas.posx = tonumber( datas.posx )
		datas.posy = tonumber( datas.posy )
		datas.sizex = tonumber( datas.sizex )
		datas.sizey = tonumber( datas.sizey )
		
		if datas.alpha then
			datas.alpha = tonumber( datas.alpha )
		end
		
		-- local posx = datas.posx
		-- local posy = datas.posy
		-- local sizex = datas.sizex
		-- local sizey = datas.sizey
		local link = datas.link
		
		if not isstring( link ) then stop = true return false, "10" end
		
	end
	
	if stop then return false, "11" end
	
	return infos
	
end

Cosmetics.TopsMakesIds = Cosmetics.TopsMakesIds or {}
function meta:CM_RemovePlayerFromTable()
	local ply = self
	
	for k, v in pairs( Cosmetics.TopsMakesIds ) do
		
		if table.HasValue( v.ply, ply ) then
			
			table.RemoveByValue( v.ply, ply )
			
		end
		
		local count = table.Count( v.ply )
		
		if count <= 0 then
			table.remove( Cosmetics.TopsMakesIds, k )
		end
		
	end
end

function meta:CM_ApplyCustomTee( datas )
	local PlyDonateSkin = self:GetNVar("DonateSkin")
	if PlyDonateSkin then
		return 
	end

	if Cosmetics.Config.ForbiddenJobs[self:Team()] or Cosmetics.Config.ForbiddenJobsWithHeads[self:Team()] then
		self:CM_Notif(Cosmetics.Config.Sentences[36][Cosmetics.Config.Lang])
	return end

	local ply = self
	
	local id = datas.id
	
	local mdl = ply:GetModel()
	
	local tab
	if ply:CM_GetSex() == 1 then
		tab = Cosmetics.Male
	else
		tab = Cosmetics.Female
	end

	local topgroup = ply:CM_GetInfos().bodygroups.top or "polo"
	local teeindex = tab.ListDefaultPM[mdl].bodygroupstop[topgroup].tee or -1
	if teeindex == -1 then return end

	if Cosmetics.ShopTextures[id] then

		for k, v in pairs( teeindex ) do
			ply:SetSubMaterial( v, "!CM_"..id )
		end
		
	else
		
		net.Start("Cosmetics:BroadcastTextureInfo")
			net.WriteTable( datas ) 
		net.Broadcast()
		for k, v in pairs( teeindex ) do
			ply:SetSubMaterial( v, "!CM_"..id )
		end
		
	end

end

function meta:CM_ApplyRagCustomTee( datas, rag )
	local PlyDonateSkin = self:GetNVar("DonateSkin")
	if PlyDonateSkin then
		return 
	end

	if Cosmetics.Config.ForbiddenJobs[self:Team()] or Cosmetics.Config.ForbiddenJobsWithHeads[self:Team()] then
		self:CM_Notif(Cosmetics.Config.Sentences[36][Cosmetics.Config.Lang])
	return end

	local ply = self
	
	local id = datas.id
	
	local mdl = ply:GetModel()
	
	local tab
	if ply:CM_GetSex() == 1 then
		tab = Cosmetics.Male
	else
		tab = Cosmetics.Female
	end

	local topgroup = ply:CM_GetInfos().bodygroups.top or "polo"
	local teeindex = tab.ListDefaultPM[mdl].bodygroupstop[topgroup].tee or -1
	if teeindex == -1 then return end

	if Cosmetics.ShopTextures[id] then

		for k, v in pairs( teeindex ) do
			rag:SetSubMaterial( v, "!CM_"..id )
		end
		
	else
		
		net.Start("Cosmetics:BroadcastTextureInfo")
			net.WriteTable( datas ) 
		net.Broadcast()
		for k, v in pairs( teeindex ) do
			rag:SetSubMaterial( v, "!CM_"..id )
		end
		
	end

end

function CM_SaveTextureInfos( infos )
	
	local datas = CM_CheckTextureInfos( infos )
	
	if not datas then return end
		
	local files, directories = file.Find( "cosmetics/customclothes/*", "DATA" )
	
	local id = table.Count( directories ) + 1
	
	datas.id = id
		
	local json = util.TableToJSON( datas )
	
	file.CreateDir( "cosmetics/customclothes/"..id )
	
	file.Write( "cosmetics/customclothes/"..id.."/clothes_infos.txt", json)
	
	Cosmetics.Textures[id] = datas
	
end

function CM_GetTextureInfos( id )

	-- if not file.Exists( "cosmetics/CustomClothes/"..id.."/clothes_infos.txt", "DATA" ) then return false end
	
	-- local json = file.Read( "cosmetics/CustomClothes/"..id.."/clothes_infos.txt" )
	
	-- local tab = util.JSONToTable( json )
	
	-- return tab
	
	return Cosmetics.Textures[tonumber(id)]

end