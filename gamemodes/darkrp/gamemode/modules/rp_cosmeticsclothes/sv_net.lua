util.AddNetworkString("Cosmetics:CharacterCreationMenu")
util.AddNetworkString("Cosmetics:BroadcastPlayersInfos")
util.AddNetworkString("Cosmetics:BroadcastPlayerInfos")
util.AddNetworkString("Cosmetics:ReceiveCharacterCreated")
util.AddNetworkString("Cosmetics:BroadcastShopsInfo")
util.AddNetworkString("Cosmetics:PlayerHasLoaded")
util.AddNetworkString("Cosmetics:ChangeNameMenu")
util.AddNetworkString("Cosmetics:ChangeName")
util.AddNetworkString("Cosmetics:ClothesShop")
util.AddNetworkString("Cosmetics:ClothesArmory")
util.AddNetworkString("Cosmetics:ChangeClothes")
util.AddNetworkString("Cosmetics:ClothesCreation")
util.AddNetworkString("Cosmetics:CustomTeeCreation")
util.AddNetworkString("Cosmetics:BroadcastTextureInfo")
util.AddNetworkString("Cosmetics:BuyClothes")
util.AddNetworkString("Cosmetics:CustomTeeCreationShop")
util.AddNetworkString("Cosmetics:OpenAdminMenu")
util.AddNetworkString("Cosmetics:DropClothesMenu")
util.AddNetworkString("Cosmetics:DropCloth")
util.AddNetworkString("Cosmetics:SurgeryMenu")
util.AddNetworkString("Cosmetics:Surgery")

local spamCooldowns = {}
local interval = .1

local function spamCheck(pl, name)
    if spamCooldowns[pl:SteamID()] then
        if spamCooldowns[pl:SteamID()][name] then
            if spamCooldowns[pl:SteamID()][name] > CurTime() then
                return false
            else
                spamCooldowns[pl:SteamID()][name] = CurTime() + interval
                return true
            end
        else
            spamCooldowns[pl:SteamID()][name] = CurTime() + interval
            return true
        end
    else
        spamCooldowns[pl:SteamID()] = {}
        spamCooldowns[pl:SteamID()][name] = CurTime() + interval

        return true
    end
end

local defMaleInfos = {
	model = "models/kerry/player/citizen/male_01.mdl",
	name = "Julien",
	surname = "Smith",
	sex = 1,
	playerColor = Vector(1,1,1),
	bodygroups = {
		top = "polo",
		pant = "pant",
	},
	skin = 0,
	eyestexture = {
		basetexture = {
			["r"] = "eyes/eyes/amber_r",
			["l"] = "eyes/eyes/amber_l",
		},
	},
	hasCostume = false, -- disable tee and pant and shoes texture
	teetexture = {
		basetexture = "models/citizen/body/citizen_sheet", -- name of the tee Choosen in the first part of the menu
		hasCustomThings = false, -- if has custom things or not, if true then basetexture should be an id
	},
	panttexture = {
		basetexture = "models/citizen/body/citizen_sheet",
	},
}

local defFemaleInfos = {
	model = "models/kerry/player/citizen/female_01.mdl",
	name = "Julien",
	surname = "Smith",
	sex = 0,
	playerColor = Vector(1,1,1),
	bodygroups = {
		top = "polo",
		pant = "pant",
	},
	skin = 0,
	eyestexture = {
		basetexture = {
			["r"] = "eyes/eyes/amber_r",
			["l"] = "eyes/eyes/amber_l",
		},
	},
	hasCostume = false, -- disable tee and pant and shoes texture
	teetexture = {
		basetexture = "models/humans/modern/female/sheet_01", -- name of the tee Choosen in the first part of the menu
		hasCustomThings = false, -- if has custom things or not, if true then basetexture should be an id
	},
	panttexture = {
		basetexture = "models/humans/modern/female/sheet_01",
	},
}

net.Receive("Cosmetics:ChangeClothes", function(len, ply)
	
	if not spamCheck( ply, "Cosmetics:ChangeClothes" ) then return end

	local PlyDonateSkin = ply:GetNVar("DonateSkin")
	if PlyDonateSkin then
		return 
	end
	
	if Cosmetics.Config.ForbiddenJobs[ply:Team()] or Cosmetics.Config.ForbiddenJobsWithHeads[ply:Team()]then
		ply:CM_Notif(Cosmetics.Config.Sentences[36][Cosmetics.Config.Lang])
	return end
	
	local top = net.ReadString()
	local bottom = net.ReadString()
	local iscustom = net.ReadBool()
	local steamid = ply:SteamID64() or "novalue"
	local charid = ply:GetNVar('CurrentChar') or 0
	local ent = net.ReadEntity() or NULL

	if not IsValid( ent ) then return end
	if ent:GetClass() != "cm_armory" then return end
	if ent:GetPos():Distance( ply:GetPos() ) > 250 then return end
	
	local infos = ply:CM_GetInfos()
	
	if not iscustom then
		if ply:CM_GetTopList()["ncustoms"][top] then
			infos.teetexture.basetexture = top
			infos.teetexture.hasCustomThings = false
			infos.bodygroups.top = ply:CM_GetTopList()["ncustoms"][top].bodygroup
		end
	else
		for k, v in pairs( ply:CM_GetTopList()["customs"] ) do

			if tonumber(v.id) != tonumber(top) then continue end

			infos.teetexture.basetexture = "!CM_"..top
			infos.teetexture.id = tonumber(top)
			infos.teetexture.hasCustomThings = true
			
			-- print("vb:")
			-- PrintTable(v)
			
			infos.bodygroups.top = v.bodygroup
			
			break
			
		end
	end

	if ply:CM_GetBottomList()[bottom] then
		infos.panttexture.basetexture = bottom
		infos.bodygroups.pant = ply:CM_GetBottomList()[bottom].bodygroup
	end
		
	Cosmetics.PlayerInfos = Cosmetics.PlayerInfos or {}
	Cosmetics.PlayerInfos[steamid] = Cosmetics.PlayerInfos[steamid] or {}
	Cosmetics.PlayerInfos[steamid][charid] = infos
	
	ply:CM_Notif(Cosmetics.Config.Sentences[45][Cosmetics.Config.Lang])
	
	ply:CM_NetworkTableInfos()
	ply:CM_SavePlayerInfos()
	
end)


function loadClothes(ply)
	local steamid = ply:SteamID64()
	print(steamid)
	PrintTable(ply:GetNVar('CharData'))
	for k, v in pairs(ply:GetNVar('CharData')) do
		local charid = v.id
		
		if steamid == nil then
			steamid = "novalue"
		end
		print("Ffwfawfaw")
		net.Start("Cosmetics:BroadcastShopsInfo")
			net.WriteTable(Cosmetics.ShopTextures)
		net.Send( ply )
		Cosmetics.PlayerInfos[steamid] = Cosmetics.PlayerInfos[steamid] or {}
		Cosmetics.PlayerInfos[steamid][charid] = Cosmetics.PlayerInfos[steamid][charid] or {}
		
		if file.Exists("cosmetics/"..steamid.."/"..charid.."/clothes_infos.txt", "DATA") then
			print("Twat")
			local json = file.Read( "cosmetics/"..steamid.."/"..charid.."/clothes_infos.txt", "DATA" )
			
			Cosmetics.PlayerInfos[steamid][charid] = util.JSONToTable( json )
			PrintTable(Cosmetics.PlayerInfos[steamid][charid])
			print(steamid, charid)
			timer.Simple( 1, function()
				ply:CM_ApplyModel()
			end)
			
			if file.Exists("cosmetics/"..steamid.."/"..charid.."/tops.txt", "DATA") then
		
				local json = file.Read( "cosmetics/"..steamid.."/"..charid.."/tops.txt", "DATA" )
			
				Cosmetics.PlayerTops = Cosmetics.PlayerTops or {}
				local steamid = ply:SteamID64() or "novalue"
				local charid = ply:GetNVar('CurrentChar') or 0
				Cosmetics.PlayerTops[steamid] = Cosmetics.PlayerTops[steamid] or {}
				Cosmetics.PlayerTops[steamid][charid] = Cosmetics.PlayerTops[steamid][charid] or {}
				Cosmetics.PlayerTops[steamid][charid] = util.JSONToTable(json )
			end
			
			if file.Exists("cosmetics/"..steamid.."/"..charid.."/bottoms.txt", "DATA") then
			
				local json = file.Read( "cosmetics/"..steamid.."/"..charid.."/bottoms.txt", "DATA" )
				
				Cosmetics.PlayerBottoms = Cosmetics.PlayerBottoms or {}
				local steamid = ply:SteamID64() or "novalue"
				local charid = ply:GetNVar('CurrentChar') or 0
				Cosmetics.PlayerBottoms[steamid] = Cosmetics.PlayerBottoms[steamid] or {}
				Cosmetics.PlayerBottoms[steamid][charid] = util.JSONToTable(json )
			end


			ply:CM_NetworkTableInfos(charid)
			-- net.Start('OpenMOTD')
			-- net.Send(ply)			
			
		else
			print("[LC Cosmetics System] Cosmetics data not found for character with id: " .. charid)
		end
		
		--ply:CM_NetworkTableInfos()
		
		ply.CanCreateCharacter = true

	end
	-- net.Start('OpenMOTD')
	-- net.Send(ply)
end

hook.Add("PlayerDataLoaded", "Cosmetics.PlayerDataLoaded", function(ply)
	loadClothes(ply)
end)

net.Receive("Cosmetics:ReceiveCharacterCreated", function( len, ply )
	
	
	if not spamCheck( ply, "Cosmetics:ReceiveCharacterCreated" ) then return end

	if #ply:GetNVar('CharData') >= 2 + ply:GetUpgradeCount('newcharacter') then return end
	
	-- if not ply.CanCreateCharacter then ply:CM_Notif("A problem has happened, please retry (0)") return end

	infos = net.ReadTable()
	
	local model = infos.model or ""
	local sex = infos.sex or 1
	local skin = infos.skin or -1
	infos.playerColor = infos.playerColor or Vector( 1,1,1 )
	
	if not isvector( infos.playerColor ) then ply:CM_Notif("A problem has happened, please retry (C)") return end
	
	local tab 
	if sex == 1 then
		tab = Cosmetics.Male
	else
		tab = Cosmetics.Female
	end
	
	if not tab.ListDefaultPM[model] then ply:CM_Notif("A problem has happened, please retry (1)") return end
	if sex != tab.ListDefaultPM[model].sex then ply:CM_Notif("A problem has happened, please retry (2)") return end
	if not tab.ListDefaultPM[model].skins or not table.HasValue( tab.ListDefaultPM[model].skins , skin ) then ply:CM_Notif("A problem has happened, please retry (3)") return end
	
	if not infos.name or not infos.surname or not isstring( infos.name ) or not isstring( infos.surname ) or #infos.surname < 3 or #infos.name < 3 or #infos.surname > 50 or #infos.name > 50 then ply:CM_Notif("A problem has happened, please retry (N)") return end
	
	if not infos.bodygroups or not infos.bodygroups.top or not infos.bodygroups.pant then ply:CM_Notif("A problem has happened, please retry (BG)") return end
	
	if not infos.eyestexture or not infos.eyestexture.basetexture or not infos.eyestexture.basetexture["r"] or not infos.eyestexture.basetexture["l"] then ply:CM_Notif("A problem has happened, please retry (EYE)") return end
	local eyesr, eyesl = infos.eyestexture.basetexture["r"],infos.eyestexture.basetexture["l"]
	-- local eyestext = eyes.basetexture or {}
	
	-- local stop = false
	
	-- for k, v in pairs(eyestext) do
		-- for key, val in pairs(Cosmetics.ListEyesTextures) do
			-- if not table.HasValue(val, v) then stop = true end
		-- end
	-- end
	
	if stop then ply:CM_Notif("A problem has happened, please retry (4)") return end
	if infos.hasCostume then ply:CM_Notif("A problem has happened, please retry (5)") return end
	
	local tee = infos.teetexture or {}
	local teetexture = tee.basetexture or ""

	local pant = infos.panttexture or {}
	local panttexture = pant.basetexture or ""
	
	local valid1,valid2,valid3 = true,true,true
	
	if sex == 1 then
		
		for k, v in pairs( Cosmetics.Male.ListTops ) do
			if v.texture and v.texture == teetexture and infos.bodygroups.top == v.bodygroup  and v.default then
				valid1 = false
			end
		end
		
		for k, v in pairs( Cosmetics.Male.ListBottoms ) do
			if v.texture and v.texture == panttexture and infos.bodygroups.pant == v.bodygroup then
				valid3 = false
			end
		end
		
			
		for k, v in pairs( Cosmetics.Male.ListEyesTextures ) do
			
			if v["r"] == eyesr and v["l"]== eyesl then
				valid2 = false
			end
			
		end
		
	elseif sex == 0 then
		
		for k, v in pairs( Cosmetics.Female.ListTops ) do
			if v.texture and v.texture == teetexture and infos.bodygroups.top == v.bodygroup  and v.default then
				valid1 = false
			end
		end	
		for k, v in pairs( Cosmetics.Female.ListBottoms ) do
			if v.texture and v.texture == panttexture and infos.bodygroups.pant == v.bodygroup then
				valid3 = false
			end
		end
		
		for k, v in pairs( Cosmetics.Female.ListEyesTextures ) do
			
			if v["r"] == eyesr and v["l"]== eyesl then
				valid2 = false
			end
			
		end
	
	end

	if valid1 then ply:CM_Notif("A problem has happened, please retry (6.1)") return end
	if valid2 then ply:CM_Notif("A problem has happened, please retry (6.2)") return end
	if valid3 then ply:CM_Notif("A problem has happened, please retry (6.3)") return end
	
	local name = infos.name..' '..infos.surname

	-- Make sure nobody on this server already has this RP name
	local lowername = string.lower(tostring(name))
	rp.data.GetNameCount(name, function(taken)
		if string.len(lowername) < 2 then return end
		if taken then
			name = rp.names.Random(infos.sex)
			rp.Notify(ply, NOTIFY_ERROR, "Такое имя уже существует, придётся выдать вам случайное имя. Вы сможете его изменить позже.")
		end
	end)	

	db:Query('INSERT INTO player_data(SteamID, Name, Money, Gender, Model, Skin, Level, Experience, FriendsList, TeamBan) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?);', ply:SteamID64(), name, rp.cfg.StartMoney, infos.sex, infos.model, skin, 1, 1, '{}', '{}', function()
		db:Query('SELECT * FROM player_data WHERE SteamID=' .. ply:SteamID64()..';', function(data)
		    if IsValid(ply) then
		    	local createdCharID = -1
		    	for _,v in pairs(data) do
		    		if v.id > createdCharID then createdCharID = v.id end
		    	end

				infos.id = createdCharID
				ply:SetNVar('CurrentChar', createdCharID, NETWORK_PROTOCOL_PRIVATE)
				
				local steamid = ply:SteamID64()
				local charid = createdCharID

				Cosmetics.PlayerInfos[steamid] = Cosmetics.PlayerInfos[steamid] or {}
				Cosmetics.PlayerInfos[steamid][charid] = Cosmetics.PlayerInfos[steamid][charid] or {}
				Cosmetics.PlayerInfos[steamid][charid] = infos
				
				ply:CM_AddTop( { texture = teetexture, bodygroup = infos.bodygroups.top  }, false )
				ply:CM_AddBottom( { texture = panttexture, bodygroup = infos.bodygroups.pant  } )
				
				ply:CM_NetworkTableInfos()
				CM_NetworkTableInfos()
				ply:CM_SavePlayerInfos(charid)
		    end
		end)
	end)
end)