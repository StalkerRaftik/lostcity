local units = {
    ['seconds'] = 1,
    ['milliseconds'] = 1000,
    ['microseconds'] = 1000000,
    ['nanoseconds'] = 1000000000
}

function benchmark(unit, decPlaces, n, f, ...)
    local elapsed = 0
    local multiplier = units[unit]
    for i = 1, n do
        local now = os.clock()
        f(...)
        elapsed = elapsed + (os.clock() - now)
    end
    print(string.format('Benchmark results: %d function calls | %.'.. decPlaces ..'f %s elapsed | %.'.. decPlaces ..'f %s avg execution time.', n, elapsed * multiplier, unit, (elapsed / n) * multiplier, unit))
end

hook.Add( "PlayerUse", "DisableEnteringLockedVehicle", function( ply, ent )
	if not ent:IsVehicle() then return end
	if not ent.__WCDOwner or ent.Locked != true then return end

	return false
end )

hook.Add("PlayerCharLoaded", "LoadPlayerFriendsList", function(pl)
  db:Query('SELECT FriendsList FROM player_data WHERE SteamID=' .. pl:SteamID64() .. ' AND id ='..pl:GetNVar('CurrentChar')..';', function(_data)
    local data = _data[1] or {}
    if data.FriendsList and data.FriendsList ~= nil then
	    local flist = util.JSONToTable(data.FriendsList)
	    pl:SetNVar('FriendsList', flist, NETWORK_PROTOCOL_PUBLIC)
	 else
	    pl:SetNVar('FriendsList', {}, NETWORK_PROTOCOL_PUBLIC)
	  end
  end)
end)


hook.Add( "EntityEmitSound", "ZombieAI_ReactToSound", function( soundData )
	if not soundData.Entity:IsPlayer() then return end

	local ply = soundData.Entity
	local slevel = soundData.SoundLevel
	
	if ply.NextEmitSoundThink and ply.NextEmitSoundThink > CurTime() then return end

	ply.NextEmitSoundThink = CurTime() + 1
	ZombieAI_ReactToSound(ply, slevel)
end)

function ZombieAI_ReactToSound(ply, slevel)
	for _, zombie in pairs(ents.FindInSphere(ply:GetPos(), slevel*5)) do
		if zombie.Base and (zombie.Base == "npc_vj_creature_base" or zombie.Base == "npc_vj_l4d_com_male") and zombie:GetEnemy() == nil  then
			-- print(ply:Name())
			zombie:VJ_DoSetEnemy(ply,true,true)
			zombie:SetEnemy(ply)
		end
	end
end

hook.Add( "TFA_PostPrimaryAttack", "ZombieAI_ReactToGunfire", function( weapon )
	-- print(weapon)
	local ply = weapon.Owner
	if ply.NextGunfireSoundThink and ply.NextGunfireSoundThink > CurTime() then return end

	local SoundLevel = 400
	if weapon.Attachments and weapon.Attachments[1] and weapon.Attachments[1] and weapon.Attachments[1].atts[1] and weapon.Attachments[1].sel == 1 then
		if weapon.Attachments[1].atts[1] == 'ins2_br_supp' then
			SoundLevel = 133
		end
	end

	ply.NextGunfireSoundThink = CurTime() + 1
	ZombieAI_ReactToSound(weapon.Owner, SoundLevel)
end)

-- hook.Add("PlayerCharLoaded", "RestorePlayerAmmo", function(ply)
-- 	db:Query('SELECT ammo FROM player_data WHERE SteamID=' .. ply:SteamID64() .. ' AND id ='..ply:GetNVar('CurrentChar')..';', function(_data)
-- 		local data = _data[1] or {}

-- 		if IsValid(ply) then
-- 			if (#_data <= 0) then
-- 				ply.ammoreturn = ply:GetAmmo()
-- 			end
-- 			if data.ammo then
-- 				ply.ammoreturn = util.JSONToTable(data.ammo)
-- 			end
-- 			local ammoreturn = ply.ammoreturn
-- 			if ammoreturn and istable(ammoreturn) then
-- 				for k, v in pairs(ammoreturn) do
-- 					ply:GiveAmmo(v, k)
-- 				end
-- 			end
-- 			ply.ammoreturn = nil
-- 		end
-- 	end)
-- end)

-- hook.Add("PlayerDisconnected", "PlayerDisconnectedAmmoSave", function(ply)
-- 	db:Query('UPDATE player_data SET ammo=? WHERE SteamID=' .. ply:SteamID64() .. ' AND id='..ply:GetNVar('CurrentChar')..';', util.TableToJSON(ply:GetAmmo()), function(data) end)
-- end)

-- hook.Add("PlayerDeath", "PlayerDeathAmmoSave", function(ply)
-- 	ply.ammoreturn = nil
-- 	db:Query('UPDATE player_data SET ammo=? WHERE SteamID=' .. ply:SteamID64() .. ' AND id='..ply:GetNVar('CurrentChar')..';', nil, function(data) end)
-- end)

-- hook.Add("OnPlayerChangedTeam", "GiveAmmoBackChange", function(ply, prevt, t)
-- 	ply.ammoreturn = ply:GetAmmo()
-- end)

-- hook.Add("PlayerSpawn", "GiveAmmoBackSpawn", function(ply)
-- 	local ammoreturn = ply.ammoreturn
-- 	if ammoreturn and istable(ammoreturn) then
-- 		for k, v in pairs(ammoreturn) do
-- 			ply:GiveAmmo(v, k)
-- 		end
-- 	end
-- 	ply.ammoreturn = nil
-- end)

-- hook.Add("PlayerAmmoChanged", "PlayerAmmoChangedHook", function(ply, ammoid, oldc, num)
-- 	ply.ammoreturn = ply:GetAmmo()
-- 	db:Query('UPDATE player_data SET ammo=? WHERE SteamID=' .. ply:SteamID64() .. ' AND id='..ply:GetNVar('CurrentChar')..';', util.TableToJSON(ply:GetAmmo()), function(data) end)
-- end)

-- hook.Add("PostGamemodeLoaded", "DayZ_MapHacker", function()
-- 	engine.LightStyle(0, "c") -- Making maps look spooky since 2009
-- end)
-- rp.AddCommand("/returnlevel", function(pl, text, args)
-- 	db:Query('SELECT * FROM `darkrp_lvlsreturn` WHERE `sid`="' .. pl:SteamID() .. '";', function(data)
-- 		if data[1] and (data[1].cashback and data[1].cashback ~= 1) then
-- 			rp.Notify(pl, NOTIFY_GENERIC, "Вы вернули себе 50% уровня: "..math.Round(tonumber(data[1].lvl)/2))
-- 			pl:SetLevel(math.Round(tonumber(data[1].lvl)/2))
-- 			db:Query('UPDATE darkrp_lvlsreturn SET cashback=? WHERE sid="' .. pl:SteamID() .. '";', 1)
-- 		end
-- 	end)
-- end)

-- local uid = {
-- 	-- ["1k_deneg"] = "1k_RP_Cash",
-- 	-- ["5k_deneg"] = "5k_RP_Cash",
-- 	-- ["10k_deneg"] = "10k_RP_Cash",
-- 	-- ["20k_deneg"] = "20k_RP_Cash",
-- 	["admin_na_mesyac"] = "admin1lvl",
-- 	["admin_navsegda"] = "admin1lvlforever",
-- 	["igrok_plus_na_mesyac"] = "igrokplus1mo",
-- 	["vip_na_mesyac"] = "vip1mo",
-- 	["premium_na_mesyac"] = "prem1mo",
-- 	["sponsor_na_mesyac"] = "sponsor1mo",
-- 	["adminvip_na_mesyac"] = "admin1lvl",
-- 	["adminpremium_na_mesyac"] = "admin1lvl",
-- 	["adminsponsor_na_mesyac"] = "admin1lvl",
-- 	["igrok_plus_navsegda"] = "igrokplusforever",
-- 	["vip_navsegda"] = "vipforever",
-- 	["premium_navsegda"] = "premforever",
-- 	["sponsor_navsegda"] = "sponsorforever",

-- }

-- hook.Add("PlayerDataLoaded","ReturnPlayersDonate", function(pl)
-- 	db:Query('SELECT * FROM `igs_inv_log` WHERE `owner`="' .. pl:SteamID64() .. '" AND `date` > 1575200000;', function(data)
-- 		if data[1] and (data[1].cashback and data[1].cashback ~= 1) then
-- 			if string.StartWith(data[1].gift_uid, "wep_") then return end
-- 			if string.StartWith(data[1].gift_uid, "level_") then return end
-- 			if string.find(data[1].gift_uid, "navsegda") then return end

-- 			if uid[data[1].gift_uid] then
-- 				rp.data.AddUpgradeUID(pl, uid[data[1].gift_uid])
-- 			end
			
-- 			db:Query('UPDATE igs_inv_log SET cashback=? WHERE owner="' .. pl:SteamID64() .. '" AND gift_uid="'..data[1].gift_uid..'";', 1)
-- 		end
-- 	end)
-- 	db:Query('SELECT * FROM `igs_inv_log` WHERE `owner`="' .. pl:SteamID64() .. '";', function(data)
-- 		if data[1] and (data[1].cashback and data[1].cashback ~= 1) then
-- 			if string.StartWith(data[1].gift_uid, "wep_") then return end
-- 			if string.StartWith(data[1].gift_uid, "level_") then return end			
-- 			if not string.find(data[1].gift_uid, "navsegda") then return end
-- 			if uid[data[1].gift_uid] then
-- 				rp.data.AddUpgradeUID(pl, uid[data[1].gift_uid])
-- 			end
			
-- 			db:Query('UPDATE igs_inv_log SET cashback=? WHERE owner="' .. pl:SteamID64() .. '" AND gift_uid="'..data[1].gift_uid..'";', 1)
-- 		end
-- 	end)
-- end)

