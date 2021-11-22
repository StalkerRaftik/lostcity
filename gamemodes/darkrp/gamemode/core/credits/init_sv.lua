util.AddNetworkString 'rp.CreditShop'

function PLAYER:AddCredits(amount, note, cback)
	rp.data.AddCredits(self:SteamID(), amount, note, function()
		self:SetNetVar('Credits', self:GetCredits() + amount)
		if (cback) then cback() end
	end)
end

function PLAYER:TakeCredits(amount, note, cback)
	rp.data.AddCredits(self:SteamID(), -amount, note, function()
		self:SetNetVar('Credits', self:GetCredits() - amount)
		if (cback) then cback() end
	end)
end

function PLAYER:GetUpgradeCount(uid)
	return (self:GetVar('Upgrades', {})[uid] or 0)
end

function PLAYER:GetPermaWeapons()
	return self:GetVar('PermaWeapons', {})
end

function PLAYER:GetTimeWeapons()
	return self:GetVar('TimeWeapons', {})
end

function rp.shop.OpenMenu(pl)
	if pl.OpeningCreditMenu then return end
	pl.OpeningCreditMenu = true
	rp.data.LoadCredits(pl, function()
		pl.OpeningCreditMenu = false
		local ret = {}
		for k, v in ipairs(rp.shop.GetTable()) do
			if (!v:CanSee(pl)) then continue end
			
			local canbuy, reason = v:CanBuy(pl)
			if (not canbuy) then
				ret[v:GetID()] = reason
			else
				ret[v:GetID()] = v:GetPrice(pl)
			end
		end
		net.Start('rp.CreditShop')
			net.WriteUInt(table.Count(ret), 8)
			for k, v in pairs(ret) do
				if isstring(v) then
					net.WriteBool(false)
					net.WriteUInt(k, 8)
					net.WriteString(v)
				else
					net.WriteBool(true)
					net.WriteUInt(k, 8)
					net.WriteUInt(v, 16)
				end
			end
		net.Send(pl)
	end)
end
rp.AddCommand('/upgrades', rp.shop.OpenMenu)
rp.AddCommand('/donate', rp.shop.OpenMenu)

hook.Add("PlayerButtonDown", "OpenDonateMenuF6", function(ply, button)
	if button == 97 then
		rp.shop.OpenMenu(ply)
	end
end)

-- Data
local db = rp._Credits


function rp.data.AddCredits(steamid, amount, note, cback)
	db:Query('INSERT INTO `kshop_credits_transactions` (`Time`, `SteamID`, `Change`, `Note`) VALUES(?, ?, ?, ?);', os.time(), steamid, amount, (note or ''), cback)
end

function rp.data.LoadCredits(pl, cback)
	db:Query('SELECT COALESCE(SUM(`Change`), 0) AS `Credits` FROM `kshop_credits_transactions` WHERE `SteamID`="' .. pl:SteamID() .. '";', function(data)
		if IsValid(pl) then
			pl:SetNetVar('Credits', tonumber(data[1]['Credits']))
			if cback then cback(data) end
		end
	end)
end

function rp.data.RemoveUpgrade(id, sid, upgid)
	local upg_obj = rp.shop.GetByUID(upgid)
	db:Query('DELETE FROM kshop_purchases WHERE id = '..id..';', function() end)
	if sid and string.StartWith(upg_obj.UID, "weaponskin_") then
		local skinid = upg_obj.SkinID
		-- SV_EASYSKINS.RemoveSkinDonate(ply, skinid)
		db:Query('DELETE FROM ESKINS_PURCHASES WHERE SteamID64 = '..sid..' AND SkinID = '..skinid..';', function() end)
	end
end


function rp.data.AddUpgradeUID(pl, id)
	local upg_obj = rp.shop.GetByUID(id)
	if not upg_obj then return end
	local duration = upg_obj:GetDuration() or 0
	if duration and (duration ~= 0) and (duration ~= nil) then
		db:Query('INSERT INTO kshop_purchases(Time, SteamID, Upgrade, expiretime) VALUES(?, ?, ?, ?);', os.time(), pl:SteamID(), upg_obj:GetUID(), os.time() + upg_obj:GetDuration(), function(dat) 
			local upgrades = pl:GetVar('Upgrades')
			upgrades[upg_obj:GetUID()] = upgrades[upg_obj:GetUID()] and (upgrades[upg_obj:GetUID()] + 1) or 1
			pl:SetVar('Upgrades', upgrades)

			upg_obj:OnBuy(pl)
			
		end)
	else
		db:Query('INSERT INTO kshop_purchases(Time, SteamID, Upgrade, expiretime) VALUES(?, ?, ?, ?);', os.time(), pl:SteamID(), upg_obj:GetUID(), 0, function(dat) 
			local upgrades = pl:GetVar('Upgrades')
			upgrades[upg_obj:GetUID()] = upgrades[upg_obj:GetUID()] and (upgrades[upg_obj:GetUID()] + 1) or 1
			pl:SetVar('Upgrades', upgrades)

			upg_obj:OnBuy(pl)
			
		end)
	end
end

function rp.data.AddUpgradeUIDOffline(sid, id)
	local upg_obj = rp.shop.GetByUID(id)
	if not upg_obj then return end
	local duration = upg_obj:GetDuration() or 0
	if duration and (duration ~= 0) and (duration ~= nil) then
		db:Query('INSERT INTO kshop_purchases(Time, SteamID, Upgrade, expiretime) VALUES(?, ?, ?, ?);', os.time(), sid, upg_obj:GetUID(), os.time() + upg_obj:GetDuration(), function(dat) 
		end)
	else
		db:Query('INSERT INTO kshop_purchases(Time, SteamID, Upgrade, expiretime) VALUES(?, ?, ?, ?);', os.time(), sid, upg_obj:GetUID(), 0, function(dat) 
		end)
	end
end

function rp.data.AddUpgrade(pl, id)
	local upg_obj = rp.shop.Get(id)
	local canbuy, reason = upg_obj:CanBuy(pl)

	if (not canbuy) then
		pl:Notify(NOTIFY_ERROR, rp.Term('CantPurchaseUpgrade'), reason)
	else
		local cost = upg_obj:GetPrice(pl)
		local duration = upg_obj:GetDuration()
		pl:TakeCredits(cost, 'Purchase: ' .. upg_obj:GetUID(), function()
			if duration and duration ~= 0 then
				db:Query('INSERT INTO kshop_purchases(Time, SteamID, Upgrade, expiretime) VALUES(?, ?, ?, ?);', os.time(), pl:SteamID(), upg_obj:GetUID(), os.time() + upg_obj:GetDuration(), function(dat) 
					local upgrades = pl:GetVar('Upgrades')
					upgrades[upg_obj:GetUID()] = upgrades[upg_obj:GetUID()] and (upgrades[upg_obj:GetUID()] + 1) or 1
					pl:SetVar('Upgrades', upgrades)

					upg_obj:OnBuy(pl)
					
					rp.shop.OpenMenu(pl)
				end)
			else
				db:Query('INSERT INTO kshop_purchases(Time, SteamID, Upgrade, expiretime) VALUES(?, ?, ?, ?);', os.time(), pl:SteamID(), upg_obj:GetUID(), 0, function(dat) 
					local upgrades = pl:GetVar('Upgrades')
					upgrades[upg_obj:GetUID()] = upgrades[upg_obj:GetUID()] and (upgrades[upg_obj:GetUID()] + 1) or 1
					pl:SetVar('Upgrades', upgrades)

					upg_obj:OnBuy(pl)
					
					rp.shop.OpenMenu(pl)
				end)
			end
		end)
	end
end

timer.Create('rp.data.SyncUpgrades', 60, 0, function()
	for k, v in pairs(player.GetAll()) do
		if IsValid(v) then 
			db:Query('SELECT * FROM `kshop_purchases` WHERE `SteamID`="' .. v:SteamID() .. '";', function(data)
				for k, tab in pairs(data) do
					if (tonumber(tab.expiretime) ~= 0) and (tonumber(os.time()) >= tonumber(tab.expiretime)) then
						rp.data.RemoveUpgrade(tab.id, v:SteamID64(), tab.Upgrade)
						DarkRP.notify(v, 1, 4, "Скоре действия "..tostring(tab.Upgrade).." истёк!")
					end
				end
			end)
			timer.Simple(1, function()
				db:Query('SELECT `Upgrade` FROM `kshop_purchases` WHERE `SteamID`="' .. v:SteamID() .. '";', function(data)
					if IsValid(v) then
						local upgrades 	= {}
						local weps 		= {}
						local timeweps 		= {}
						local networked = {}
						for k, v in ipairs(data) do
							local uid = v.Upgrade
							local obj = rp.shop.GetByUID(uid)
							local wep = rp.shop.Weapons[uid]
							local timewep = rp.shop.TimeWeapons[uid]
							upgrades[uid] = upgrades[uid] and (upgrades[uid] + 1) or 1
							if (wep ~= nil) then
								-- pl:Give(wep)
								-- v:AddItem("weapon", wep)
								weps[#weps + 1] = wep
							end
							if (timewep ~= nil) then
								-- pl:Give(timewep)
								-- v:AddItem("weapon", timewep)
								timeweps[#timeweps + 1] = timewep
							end
							if (obj ~= nil) and obj:IsNetworked() then
								networked[#networked + 1] = obj:GetID()
							end
						end
						v:SetVar('Upgrades', upgrades)
						v:SetVar('PermaWeapons', weps)
						v:SetVar('TimeWeapons', timeweps)
						if (#networked > 0) then
							v:SetNetVar('Upgrades', networked)
						end
						hook.Call('PlayerUpgradesLoaded', nil, v)
					end
				end)		
			end)
		end
	end
end)

hook('PlayerAuthed', 'rp.shop.LoadCredits', function(pl)
	db:Query('SELECT * FROM `kshop_purchases` WHERE `SteamID`="' .. pl:SteamID() .. '";', function(data)
		for k, tab in pairs(data) do
			if (tonumber(tab.expiretime) ~= 0) and (tonumber(os.time()) >= tonumber(tab.expiretime)) then
				rp.data.RemoveUpgrade(pl.id, pl:SteamID64(), tab.Upgrade)
			end
		end
	end)
	db:Query('SELECT `Upgrade` FROM `kshop_purchases` WHERE `SteamID`="' .. pl:SteamID() .. '";', function(data)
		if IsValid(pl) then
			local upgrades 	= {}
			local weps 		= {}
			local timeweps 		= {}
			local networked = {}
			for k, v in ipairs(data) do
				local uid = v.Upgrade
				local obj = rp.shop.GetByUID(uid)
				local wep = rp.shop.Weapons[uid]
				local timewep = rp.shop.TimeWeapons[uid]
				upgrades[uid] = upgrades[uid] and (upgrades[uid] + 1) or 1
				if (wep ~= nil) then
					-- pl:Give(wep)
					-- pl:AddItem("weapon", wep)
					pl:Give(wep)
					weps[#weps + 1] = wep
				end
				if (timewep ~= nil) then
					pl:Give(timewep)
					-- pl:AddItem("weapon", timewep)
					timeweps[#timeweps + 1] = timewep
				end
				if (obj ~= nil) and obj:IsNetworked() then
					networked[#networked + 1] = obj:GetID()
				end
			end
			pl:SetVar('Upgrades', upgrades)
			pl:SetVar('PermaWeapons', weps)
			pl:SetVar('TimeWeapons', timeweps)
			if (#networked > 0) then
				pl:SetNetVar('Upgrades', networked)
			end
			hook.Call('PlayerUpgradesLoaded', nil, pl)
		end
	end)
end)

hook('PlayerSpawn', 'rp.shop.PlayerLoadout', function(pl)
	for k, v in ipairs(pl:GetPermaWeapons()) do
		pl:Give(v)
		-- pl:AddItem("weapon", v)
	end
	for k, v in ipairs(pl:GetTimeWeapons()) do
		pl:Give(v)
		-- pl:AddItem("weapon", v)
	end
end)

rp.AddCommand('/buyupgrade', function(pl, text, args)
	if (not args[1]) or (not rp.shop.Get(tonumber(args[1]))) then return end
	local id = tonumber(args[1])
	local upg_obj = rp.shop.Get(id)

	if upg_obj:GetFunction() then
		upg_obj:GetFunction()(pl)
	else
		rp.data.AddUpgrade(pl, id)
	end
end)


// Выдача зарплаты администраторам
concommand.Add("GiveSalary", function( ply, cmd, args )

	if not IsValid(ply) then return end
	for i = 1,6 do 
		if not args[i] then ply:PrintMessage( HUD_PRINTCONSOLE, "Слишком мало аргументов! Вы что-то забыли указать." ) return end 
	end
	if not ply:GetUserGroup() == "globalmanager" then ply:PrintMessage( HUD_PRINTCONSOLE, "Недостаточно прав для этой команды." ) return end



    local steamid = table.concat( args, "", 1, 5 )
    local steamid64 = util.SteamIDTo64(steamid)

    db:Query('SELECT rank FROM `ba_ranks` WHERE steamid = ' .. steamid64, function(Data)
    	if not Data[1] then ply:PrintMessage( HUD_PRINTCONSOLE, "Игрок с таким стимид не был найден в базе данных!") return end
    	if Data[1].rank <= 2 then ply:PrintMessage( HUD_PRINTCONSOLE, "Вы пытаетесь выдать зарплату не администратору!") return end



	    ply:PrintMessage( HUD_PRINTCONSOLE, "Зарплата была успешно выдана человеку со стимид " .. steamid .. ' в размере ' .. args[6] )
	    rp.data.AddCredits(steamid, args[6], 'Head Admin Gives Salary')



	end)

end)