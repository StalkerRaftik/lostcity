util.AddNetworkString("SendRewardsToClient")
util.AddNetworkString("GivePlayerRewards")

hook.Add("Initialize", "rp.Compendium.CreateDB", function()
	db:Query("CREATE TABLE IF NOT EXISTS rp_compendium(SteamID64 VARCHAR(255) NOT NULL PRIMARY KEY, level INT, exp INT, rewards TEXT, drewards TEXT)")
end)

hook.Add("PlayerCharLoaded", "rp.Compendium.LoadlLevel", function(ply)
    db:Query('SELECT * FROM rp_compendium WHERE SteamID64=' .. ply:SteamID64() .. ';', function(_data)
        local data = _data[1] or {}
        if #_data <= 0 then
        	db:Query('INSERT INTO rp_compendium(SteamID64, level, exp, rewards, drewards) VALUES(?, ?, ?, ?, ?);', ply:SteamID64(), 0, 0, util.TableToJSON({}), util.TableToJSON({}) )
        	ply:SetCompendiumLevel(0)
        	ply:SetCompendiumExperience(0)
        	ply.comp = {}
        	ply.comp.rewards = {}
        	ply.comp.drewards = {}
        	net.Start("SendRewardsToClient")
        		net.WriteTable(ply.comp.rewards)
        		net.WriteTable(ply.comp.drewards)
        	net.Send(ply)
        	local haveDUpgrade = ply:GetUpgradeCount("CompendiumPass") >= 1
        	ply:SetNVar('HasCompUpgrade', haveDUpgrade, NETWORK_PROTOCOL_PRIVATE)
        else
        	ply:SetCompendiumLevel(data.level)
        	ply:SetCompendiumExperience(data.exp)
        	ply.comp = ply.comp or {}
        	ply.comp.rewards = util.JSONToTable(data.rewards)
        	ply.comp.drewards = util.JSONToTable(data.drewards)
        	net.Start("SendRewardsToClient")
        		net.WriteTable(ply.comp.rewards)
        		net.WriteTable(ply.comp.drewards)
        	net.Send(ply)
        	local haveDUpgrade = ply:GetUpgradeCount("CompendiumPass") >= 1
        	ply:SetNVar('HasCompUpgrade', haveDUpgrade, NETWORK_PROTOCOL_PRIVATE)
        end
    end)
end)

net.Receive("GivePlayerRewards", function( len, ply )
	local lvl = net.ReadInt(10)
	local isDonate = net.ReadBool()
	local rewtbl
	local haveAccess

	if ply:GetNVar('CompendiumLevel') < lvl then 
		DarkRP.notify(ply, 1, 4, "Вашего уровня компендиума недостаточно для получения подарка!")
		return
	end

	if isDonate then
		rewtbl = rp.Compendium.DonateRewards
		plRewarded = ply.comp.drewards[lvl]
	else
		rewtbl = rp.Compendium.Rewards
		plRewarded = ply.comp.rewards[lvl]
	end

	if plRewarded ~= true then	
		if isDonate then
			ply.comp.drewards[lvl] = true
			db:Query('UPDATE rp_compendium SET drewards=? WHERE SteamID64=' .. ply:SteamID64() .. ';', util.TableToJSON(ply.comp.drewards))
		else
			ply.comp.rewards[lvl] = true
			db:Query('UPDATE rp_compendium SET rewards=? WHERE SteamID64=' .. ply:SteamID64() .. ';', util.TableToJSON(ply.comp.rewards))
		end
		net.Start("SendRewardsToClient")
    		net.WriteTable(ply.comp.rewards)
    		net.WriteTable(ply.comp.drewards)
    	net.Send(ply)
		GiveReward(ply, lvl, rewtbl)
	end
end)

local invtypes = {"hats", "entity", "weapon", "food"}
function GiveReward(ply, lvl, rewtbl)
	ply:EmitSound( "buttons/button14.wav" )
	DarkRP.notify(ply, 1, 4, "Вы получили свою награду! Посмотрите в инвентарь!")

	for class, reward in pairs(rewtbl[lvl]) do
		if table.HasValue(invtypes, class) then
			ply:AddItem(class, reward)
		end
		if class == "money" then
			ply:AddMoney(reward)
		end
		if class == "case" then
			//
		end		
		if class == "vip1mo" then
			db:Query('INSERT INTO kshop_purchases(Time, SteamID, Upgrade, expiretime) VALUES(?, ?, ?, ?);', os.time(), ply:SteamID(), "vip1mo", os.time() + reward, function(dat) 
				local upgrades = ply:GetVar('Upgrades')
				upgrades["vip1mo"] = upgrades["vip1mo"] and (upgrades["vip1mo"] + 1) or 1
				ply:SetVar('Upgrades', upgrades)

				upg_obj:OnBuy(ply)
				
			end)
		end		
		if class == "premium1mo" then
			db:Query('INSERT INTO kshop_purchases(Time, SteamID, Upgrade, expiretime) VALUES(?, ?, ?, ?);', os.time(), ply:SteamID(), "premium1mo", os.time() + reward, function(dat) 
				local upgrades = ply:GetVar('Upgrades')
				upgrades["premium1mo"] = upgrades["premium1mo"] and (upgrades["premium1mo"] + 1) or 1
				ply:SetVar('Upgrades', upgrades)

				upg_obj:OnBuy(ply)
				
			end)
		end	
		if class == "igrokplus1mo" then
			db:Query('INSERT INTO kshop_purchases(Time, SteamID, Upgrade, expiretime) VALUES(?, ?, ?, ?);', os.time(), ply:SteamID(), "igrokplus1mo", os.time() + reward, function(dat) 
				local upgrades = ply:GetVar('Upgrades')
				upgrades["igrokplus1mo"] = upgrades["igrokplus1mo"] and (upgrades["igrokplus1mo"] + 1) or 1
				ply:SetVar('Upgrades', upgrades)

				upg_obj:OnBuy(ply)
				
			end)
		end	
		if class == "sponsor1mo" then
			db:Query('INSERT INTO kshop_purchases(Time, SteamID, Upgrade, expiretime) VALUES(?, ?, ?, ?);', os.time(), ply:SteamID(), "sponsor1mo", os.time() + reward, function(dat) 
				local upgrades = ply:GetVar('Upgrades')
				upgrades["sponsor1mo"] = upgrades["sponsor1mo"] and (upgrades["sponsor1mo"] + 1) or 1
				ply:SetVar('Upgrades', upgrades)

				upg_obj:OnBuy(ply)
				
			end)
		end																	
	end
end

function PLAYER:SetCompendiumLevel(lvl)
    db:Query('UPDATE rp_compendium SET level=? WHERE SteamID64=' .. self:SteamID64() .. ';', lvl, function(data) end)
	self:SetNVar('CompendiumLevel', lvl, NETWORK_PROTOCOL_PRIVATE)

	--DarkRP.notify(self, 1, 4, "Уровень боевого пропуска вырос! Теперь он "..self:GetNVar('CompendiumLevel').." уровня.")
end

function PLAYER:AddCompendiumLevel(lvl)   
	lvl = self:GetCompendiumLevel() + lvl
	self:SetCompendiumLevel(lvl)
end

function PLAYER:isPassedCompendiumLevel()
	if (self:GetCompendiumExperience() >= self:GetCompendiumNeedExperience()) then
		self:SetCompendiumExperience(0)
		self:AddCompendiumLevel(1)
	end
end

function PLAYER:SetCompendiumExperience(xp)
    db:Query('UPDATE rp_compendium SET exp=? WHERE SteamID64=' .. self:SteamID64() .. ';', xp, function(data) end)
	self:SetNVar('CompendiumExperience', xp, NETWORK_PROTOCOL_PRIVATE)

	self:isPassedCompendiumLevel()
end

function PLAYER:AddCompendiumExperience(xp1)
	xp2 = self:GetCompendiumExperience() + xp1
	self:SetCompendiumExperience(xp2)
	-- net.Start("ShowLevelUPGreets")
	-- net.WriteInt(xp1, 32)
	-- net.WriteEntity(self)
	-- net.Send(self)
end
