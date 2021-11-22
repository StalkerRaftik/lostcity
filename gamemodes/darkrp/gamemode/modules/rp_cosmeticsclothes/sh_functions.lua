local meta = FindMetaTable( "Player" )

Cosmetics.PlayerInfos = Cosmetics.PlayerInfos or {}

function meta:CM_GetInfos(ID)
	local steamid = self:SteamID64()
	local charid = ID and ID or self:GetNVar('CurrentChar')
	local model = ""
	if self:Team() ~= 1 then
		model = team.GetModel(self:Team())
	else
		model = "models/kerry/player/citizen/male_01.mdl"
	end
	-- print(model)
	Cosmetics.PlayerInfos[steamid] = Cosmetics.PlayerInfos[steamid] or {}
	Cosmetics.PlayerInfos[steamid][charid] = Cosmetics.PlayerInfos[steamid][charid] or {}
	-- Cosmetics.PlayerInfos[steamid][charid].model = model
	return Cosmetics.PlayerInfos[steamid][charid] or {
			model = team.GetModel(self:Team()) or "models/kerry/player/citizen/male_01.mdl",
			name = self:SteamName() or "No name", -- DarkRP function
			id = charid,
			surname = "",
			sex = 1,
			playerColor = Vector(1,1,1),
			bodygroups = {
				top = "polo",
				pant = "pant",
			},
			skin = 0,
			eyestexture = {
				basetexture = {
					["r"] = "models/bloo_itcom_zel/citizens/facemaps/eyeball_r_blue",
					["l"] = "models/bloo_itcom_zel/citizens/facemaps/eyeball_l_blue",
				},
			},
			hasCostume = false, -- disable tee and pant and shoes texture
			teetexture = {
				basetexture = "models/bloo_itcom_zel/citizens/citizen_sheet2", -- name of the tee Choosen in the first part of the menu
				hasCustomThings = false, -- if has custom things or not, if true then basetexture should be an id
				id = 1,
			},
			panttexture = {
				basetexture = "models/bloo_itcom_zel/citizens/citizen_sheet2",
			},
		}
end

function meta:CM_GetSex()

	local steamid = self:SteamID64()
	local charid = self:GetNVar('CurrentChar') or 0
	return Cosmetics.PlayerInfos[steamid][charid].sex or 1

end

function CM_GetInfos()
	return Cosmetics.PlayerInfos
end

-- local getName = function( name, ply )
	-- local nameIsFree = false
	-- local nb = 2
	-- while not nameIsFree do
		-- nameIsFree = true
		-- for k,v in pairs( player.GetAll() ) do
			-- if v:CM_GetInfos().name == name and v != ply then
				-- nameIsFree = false
				-- name = name.." "..nb
			-- end
		-- end
		-- nb = nb +1
	-- end
	-- return name
-- end

function meta:CM_ApplyModel()

	if self.skinID then
		if self:CanUseThisModel(self:Team(), self.skinID) then // Donate or not donate
			self:SetModel(self.skinID)
			return
		else
			self.skinID = nil
		end
	end

	for k,v in pairs( self:GetMaterials() ) do
		self:SetSubMaterial( k )
	end

	if not Cosmetics or not Cosmetics.Config or not Cosmetics.Config.ForbiddenJobs or not Cosmetics.Config.ForbiddenJobsWithHeads then
		if SERVER then
			print("---------------------")
			print("ERROR Cosmetics :")
			print("It looks like there is an issue with the forbidden jobs config")
			print("Open a support ticket to the Character & Clothes addon on gmodstore")
			print("Include this error to it")
			if Cosmetics then
				print("Cosmetics : ok")
			else
				print("Cosmetics : error")
			end
			if Cosmetics.Config.ForbiddenJobs then
				print("Cosmetics.Config : ok")
			else
				print("Cosmetics.Config : error")
			end
			if Cosmetics.Config.ForbiddenJobs then
				print("Cosmetics.Config.ForbiddenJobs : ok")
			else
				print("Cosmetics.Config.ForbiddenJobs : error")
			end
			print("---------------------")
		end
	else
		if Cosmetics.Config.ForbiddenJobs[self:Team()] then
		return end

		if Cosmetics.Config.ForbiddenJobsWithHeads[self:Team()] then
			local infos = self:CM_GetInfos()

			local tab
			if infos.sex == 1 then
				tab = Cosmetics.Male
			else
				tab = Cosmetics.Female
			end

			local minfos = tab.ListDefaultPM[infos.model]

			if not minfos then return end
			local name = minfos.name or ""

			local models = Cosmetics.Config.ForbiddenJobsWithHeads[self:Team()]

			local mhead = models[name] or table.Random( models )
			self:SetModel( mhead )
		return
		end
	end

	local infos = self:CM_GetInfos()

	if infos.hasCostume then
		self:SetModel( infos.model )
		return
	end

	-- if SERVER and self:Name() != infos.name.." "..infos.surname then

	-- 	local name = infos.name.." "..infos.surname
	-- 	self:setRPName(name, false)

	-- 	if self:Name() != name then
	-- 		self:setRPName(name, true)
	-- 	end
	-- end

	local tab
	if infos.sex == 1 then
		tab = Cosmetics.Male
	else
		tab = Cosmetics.Female
	end

	if not tab.ListDefaultPM or not tab.ListDefaultPM[infos.model] then print("returned") return end

	local mdli = tab.ListDefaultPM[infos.model]

	self:SetModel(infos.model)
	-- PrintTable(infos.bodygroups)
	-- print("bodygroup:")
	-- print(infos.bodygroups.pant)
	-- PrintTable(mdli)
	-- print("--")
	-- PrintTable(mdli.bodygroupsbottom[infos.bodygroups.pant])
	-- print("---")
	local bodygroups = {
		mdli.bodygroupstop[infos.bodygroups.top].group,
		mdli.bodygroupsbottom[infos.bodygroups.pant].group
	}

	for k, v in pairs( bodygroups ) do
		self:SetBodygroup( unpack( v ) )
	end

	self:SetSkin( infos.skin )

	self:SetSubMaterial( mdli.eyes["r"], infos.eyestexture.basetexture["r"] )
	self:SetSubMaterial( mdli.eyes["l"], infos.eyestexture.basetexture["l"] )

	local topgroup = self:CM_GetInfos().bodygroups.top or "polo"
	local teeindex = mdli.bodygroupstop[topgroup].tee or -1
	if teeindex == -1 then return end

	for k, v in pairs( teeindex ) do

		if not infos.teetexture.hasCustomThings then
			self:SetSubMaterial( v, infos.teetexture.basetexture )
		else
			if SERVER then
				local id = infos.teetexture.id
				-- print("custom tee id: "..id)
				local datas = CM_GetTextureInfos( id )

				if not datas then return end

				self:CM_ApplyCustomTee( datas )
			end

		end

	end

	self:SetPlayerColor( infos.playerColor )

	local botgroup = self:CM_GetInfos().bodygroups.pant or "pant"
	local pantindex = mdli.bodygroupsbottom[botgroup].pant or -1
	if pantindex == -1 then return end

	for k, v in pairs( pantindex ) do

		self:SetSubMaterial( v, infos.panttexture.basetexture )

	end



end

function meta:CM_ApplyRagModel( rag )

	local PlyDonateSkin = self:GetNVar("DonateSkin")
	if PlyDonateSkin then
		rag:SetModel(PlyDonateSkin)
		return
	end

	for k,v in pairs( self:GetMaterials() ) do
		self:SetSubMaterial( k )
	end

	if Cosmetics.Config.ForbiddenJobs[self:Team()] or Cosmetics.Config.ForbiddenJobsWithHeads[self:Team()] then
		-- if Cosmetics.Config.ForbiddenJobsWithHeads[self:Team()] then
			-- rag:SetModel( self:GetModel() )
		-- end
	return end

	local infos = self:CM_GetInfos()

	if infos.hasCostume then
		rag:SetModel( infos.model )
		return
	end

	local tab
	if infos.sex == 1 then
		tab = Cosmetics.Male
	else
		tab = Cosmetics.Female
	end

	if not tab.ListDefaultPM or not tab.ListDefaultPM[infos.model] then print("returned") return end

	local mdli = tab.ListDefaultPM[infos.model]

	rag:SetModel(infos.model)

	local bodygroups = {
		mdli.bodygroupstop[infos.bodygroups.top].group,
		mdli.bodygroupsbottom[infos.bodygroups.pant].group
	}

	for k, v in pairs( bodygroups ) do
		rag:SetBodygroup( unpack( v ) )
	end

	rag:SetSkin( infos.skin )

	rag:SetSubMaterial( mdli.eyes["r"], infos.eyestexture.basetexture["r"] )
	rag:SetSubMaterial( mdli.eyes["l"], infos.eyestexture.basetexture["l"] )

	local topgroup = self:CM_GetInfos().bodygroups.top or "polo"
	local teeindex = mdli.bodygroupstop[topgroup].tee or -1
	if teeindex == -1 then return end

	for k, v in pairs( teeindex ) do

		if not infos.teetexture.hasCustomThings then
			rag:SetSubMaterial( v, infos.teetexture.basetexture )
		else
			if SERVER then
				local id = infos.teetexture.id
				-- print("custom tee id: "..id)
				local datas = CM_GetTextureInfos( id )

				if not datas then return end

				self:CM_ApplyRagCustomTee( datas, rag )
			end

		end

	end

	-- rag:SetPlayerColor( infos.playerColor )

	local botgroup = self:CM_GetInfos().bodygroups.pant or "pant"
	local pantindex = mdli.bodygroupsbottom[botgroup].pant or -1
	if pantindex == -1 then return end

	for k, v in pairs( pantindex ) do

		rag:SetSubMaterial( v, infos.panttexture.basetexture )

	end

end

function PLAYER:IsCharLoaded()
	local char = self:GetNVar('CurrentChar')
	return not (char == nil or isbool(char))
end