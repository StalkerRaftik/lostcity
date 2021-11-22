-- Отослать инфу о количестве предмета игроку
util.AddNetworkString("Inventory.SendItemCount")
util.AddNetworkString("Inventory.SendItemCountToClient")
util.AddNetworkString("UpdateClientCosmetics")
net.Receive("Inventory.SendItemCount", function(_, ply)
	local ent = net.ReadEntity()
	local count = 1
	if ent and ent.attributes and ent.attributes.count then count = ent.attributes.count end
	net.Start("Inventory.SendItemCountToClient")
		net.WriteInt(count, 20)
	net.Send(ply)
end)



util.AddNetworkString("Inventory.Update")
util.AddNetworkString("Inventory.Update2")
util.AddNetworkString("Inventory.Set")
util.AddNetworkString("Inventory.Set2")
util.AddNetworkString("Inventory.OpenMenu")
util.AddNetworkString("Inventory.OpenMenuTrade")
util.AddNetworkString("Inventory.CloseStorage")
util.AddNetworkString("Inventory.EquipClothes")
util.AddNetworkString("Inventory.TakeFromStorageClothes")
util.AddNetworkString("Inventory.PutInStorageClothes")
util.AddNetworkString("Inventory.DropClothes")


hook.Add("Initialize", "Inventory.CreateTable", function()
	db:Query("CREATE TABLE IF NOT EXISTS darkrp_inventory(SteamID64 VARCHAR(255) NOT NULL, charid INT NOT NULL PRIMARY KEY, data TEXT NOT NULL)")
	db:Query("CREATE TABLE IF NOT EXISTS darkrp_inventorypocket(SteamID64 VARCHAR(255) NOT NULL, charid INT NOT NULL PRIMARY KEY, data TEXT NOT NULL)")
	db:Query("CREATE TABLE IF NOT EXISTS darkrp_space(SteamID64 VARCHAR(255) NOT NULL PRIMARY KEY, space INT)")
	db:Query("CREATE TABLE IF NOT EXISTS darkrp_pocketspace(SteamID64 VARCHAR(255) NOT NULL PRIMARY KEY, space INT)")
end)

net.Receive("Inventory.Set2", function(len, ply)
	if ply.inv2 then return end

	db:Query('SELECT data FROM darkrp_inventorypocket WHERE steamid64=' .. ply:SteamID64() .. ' AND charid='..ply:GetNVar('CurrentChar')..';', function(data)
		if data[1] and not (data[1].data == nil) then
			ply.inv2 = util.JSONToTable(data[1].data)
		elseif not data[1] then
			ply.inv2 = {}
			ply.inv2[INV_WEAPON] = {}
			ply.inv2[INV_ENTITY] = {}
			ply.inv2[INV_FOOD] = {}
			-- ply.inv2[INV_PROP] = {}
			ply.inv2[INV_HATS] = {}
      		ply.inv2[INV_CLOTHES] = {}
			db:Query('INSERT INTO darkrp_inventorypocket(steamid64, charid,  data) VALUES(?, ?, ?);', ply:SteamID64(), ply:GetNVar('CurrentChar'), util.TableToJSON(ply.inv2))
		else
			ply.inv2 = {}
			ply.inv2[INV_WEAPON] = {}
			ply.inv2[INV_ENTITY] = {}
			ply.inv2[INV_FOOD] = {}
			-- ply.inv2[INV_PROP] = {}
			ply.inv2[INV_HATS] = {}
      		ply.inv2[INV_CLOTHES] = {}
		end
	end)

end)

net.Receive("Inventory.Set", function(len, ply)
	if ply.inv then return end

	db:Query('SELECT data FROM darkrp_inventory WHERE steamid64=' .. ply:SteamID64() .. ' AND charid='..ply:GetNVar('CurrentChar')..';', function(data)
		if data[1] then
			ply.inv = util.JSONToTable(data[1].data)
		else
			ply.inv = {}
			ply.inv[INV_WEAPON] = {}
			ply.inv[INV_ENTITY] = {}
			ply.inv[INV_FOOD] = {}
			-- ply.inv[INV_PROP] = {}
			ply.inv[INV_HATS] = {}
      		ply.inv[INV_CLOTHES] = {}
			db:Query('INSERT INTO darkrp_inventory (steamid64, charid, data) VALUES(?, ?, ?);',ply:SteamID64(), ply:GetNVar('CurrentChar'), util.TableToJSON(ply.inv))
		end
	end)
end)

local playerMeta = FindMetaTable("Player")
local entityMeta = FindMetaTable("Entity")

function playerMeta:UpdateInventory(type)
	if not self.inv then return end
	if type then
		net.Start("Inventory.Update")
			net.WriteString(type)
			net.WriteTable(self.inv[type])
		net.Send(self)
	else
		net.Start("Inventory.Set")
			net.WriteTable(self.inv)
		net.Send(self)
	end
end

function playerMeta:UpdateInventory2(type)
	if not self.inv2 then return end
	if type then
		net.Start("Inventory.Update2")
			net.WriteString(type)
			net.WriteTable(self.inv2[type])
		net.Send(self)
	else
		net.Start("Inventory.Set2")
			net.WriteTable(self.inv2)
		net.Send(self)
	end
end

function playerMeta:ClearInventory()
	self.inv = {}
	self.inv2 = {}
	self:UpdateInventory()
	self:UpdateInventory2()
	db:Query("DELETE FROM darkrp_inventory WHERE SteamID64 = "..sql.SQLStr(self:SteamID64())..";")
	db:Query("DELETE FROM darkrp_inventorypocket WHERE SteamID64 = "..sql.SQLStr(self:SteamID64()).." AND charid="..self:GetNVar('CurrentChar')..";")
end

function playerMeta:RemoveNotDroppableItems()
	for type, items in pairs(self.inv) do
		for class, keys in pairs(items) do
			for key, attributes in pairs(keys) do
				if attributes.droppable == false then
					self.inv[type][class][key] = nil
				end
			end
		end
	end
end

function playerMeta:ClearInventory1()
	db:Query("DELETE FROM darkrp_inventory WHERE SteamID64 = "..sql.SQLStr(self:SteamID64()).." AND charid="..self:GetNVar('CurrentChar')..";")
	self.inv = {}
	self:UpdateInventory()
end

function entityMeta:HaveSpace(weight)
	return weight + Inventory.GetSpace(self.inv) <= self:GetDefaultSpace()
end

function entityMeta:HaveSpaceT(weight)
	return weight + Inventory.GetSpace(self.inv2) <= self:GetTradeDSpace()
end

function entityMeta:SetItemCount(type, class, attributes, count)
	local key = FindKeyByAttributes(self.inv, type, class, attributes)
	self.inv[type][class][key].count = count
end

function entityMeta:SetItemCount2(type, class, attributes, count)
	local key = FindKeyByAttributes(self.inv2, type, class, attributes)
	self.inv2[type][class][key].count = count
end

function entityMeta:RemoveItemTByKey(type, class, key, count)
	count = count or 1
	key = tonumber(key)
	if key then
		local itemcount = self.inv2[type][class][key].count or 1
		if itemcount - count <= 0 then
			self.inv2[type][class][key] = nil
			if self.inv2[type][class] == {} then self.inv2[type][class] = nil end
		else
			self.inv2[type][class][key].count = itemcount - count
		end
	end
	if self:IsPlayer() then
		db:Query('UPDATE darkrp_inventorypocket SET data=? WHERE steamid64=' .. self:SteamID64() .. ';', util.TableToJSON(self.inv2))
		self:UpdateInventory2(type)
		hook.Run( "rp.inv.DropItemT", self, type, class, count )
	end
  	self:UpdateInventory2()
end

function entityMeta:RemoveItemByKey(type, class, key, count)
	count = count or 1
	key = tonumber(key)
	if key then
		if self.inv[type][class][key].count - count <= 0 then
			self.inv[type][class][key] = nil
			if self.inv[type][class] == {} then self.inv[type][class] = nil end
		else
			self.inv[type][class][key].count = self.inv[type][class][key].count - count
		end
	end
	if self:IsPlayer() then
		hook.Run( "rp.inv.RemoveItem", self, type, class, count )
		db:Query('UPDATE darkrp_inventory SET data=? WHERE steamid64=' .. self:SteamID64() .. ' AND charid='..self:GetNVar('CurrentChar')..';', util.TableToJSON(self.inv))
		self:UpdateInventory(type)
		self:UpdateInventory()
	end
end

function entityMeta:RemoveItemT(type, class, attributes, count)
	if not attributes then attributes = {} end
	if not istable(attributes) then
		count = attributes or 1
		attributes = {}
	elseif istable(attributes) and attributes.count then
		count = attributes.count
	else
		count = count or 1
	end
	count = count or 1
	local key = FindKeyByAttributes(self.inv2, type, class, attributes)
	self:RemoveItemTByKey(type, class, key, count)
end

function entityMeta:RemoveItemIgnoringAttributes(type, class, count)
	for key, attributes in pairs(self.inv[type][class]) do
		if count < 0 then return end

		if attributes.count > count then
			self.inv[type][class][key].count = self.inv[type][class][key].count - count
			return
		elseif attributes.count == count then
			self.inv[type][class][key] = nil
			return
		else
			count = count - attributes.count
			self.inv[type][class][key] = nil
		end
	end
end

function entityMeta:RemoveItem(type, class, attributes, count)
	if not attributes then attributes = {} end
	if not istable(attributes) then
		count = attributes or 1
		attributes = {}
	elseif istable(attributes) and attributes.count then
		count = attributes.count
	else
		count = count or 1
	end
	local key = FindKeyByAttributes(self.inv, type, class, attributes)
	self:RemoveItemByKey(type, class, key, count)
end

function entityMeta:AddItemT(type, class, attributes, count)
	if not attributes then attributes = {} end
	if not istable(attributes) then
		count = attributes or 1
		attributes = {}
	elseif istable(attributes) and attributes.count then
		count = attributes.count
	else
		count = count or 1
	end

	if type == "weapon" then
		if not attributes.ammo then attributes.ammo = 0 end
		if not attributes.health then attributes.health = 100 end
	end

	local attrWithoutCount = table.Copy(attributes)
	if attrWithoutCount and attrWithoutCount.count then
		attrWithoutCount.count = nil
	end
	local key = FindKeyByAttributes(self.inv2, type, class, attrWithoutCount)
	if self.inv2[type][class] then
		if key then
			self.inv2[type][class][key].count = (self.inv2[type][class][key].count or 1) + count
		else
			local newitem = {}
			for attribute, attrinfo in pairs(attributes) do
				newitem[attribute] = attrinfo
			end
			newitem.count = newitem.count or count
			table.insert(self.inv2[type][class], newitem)
		end
	else
		local newitem = {}
		for attribute, attrinfo in pairs(attributes) do
			newitem[attribute] = attrinfo
		end
		newitem.count = newitem.count or count
		self.inv2[type][class] = {}
		table.insert(self.inv2[type][class], newitem)
	end
	if self:IsPlayer() then
		db:Query('UPDATE darkrp_inventorypocket SET data=? WHERE steamid64=' .. self:SteamID64() .. ';', util.TableToJSON(self.inv2))
		self:UpdateInventory2(type)
		hook.Run( "rp.inv.AddItemT", self, type, class, count )
	end
  	self:UpdateInventory2()
end

function entityMeta:AddItem(type, class, attributes, count)
	if not attributes then attributes = {} end
	if not istable(attributes) then
		count = attributes or 1
		attributes = {}
	elseif istable(attributes) and attributes.count then
		count = attributes.count
	else
		count = count or 1
	end

	if type == "weapon" then
		if not attributes.ammo then attributes.ammo = 0 end
		if not attributes.health then attributes.health = 100 end
	end

	local attrWithoutCount = table.Copy(attributes)
	if attrWithoutCount and attrWithoutCount.count then
		attrWithoutCount.count = nil
	end
	local key = FindKeyByAttributes(self.inv, type, class, attrWithoutCount)
	if self.inv[type] and self.inv[type][class] then
		if key then
			self.inv[type][class][key].count = (self.inv[type][class][key].count or 1) + count
		else
			local newitem = {}
			for attribute, attrinfo in pairs(attributes) do
				newitem[attribute] = attrinfo
			end
			newitem.count = newitem.count or count
			table.insert(self.inv[type][class], newitem)
		end
	else
		local newitem = {}
		for attribute, attrinfo in pairs(attributes) do
			newitem[attribute] = attrinfo
		end
		newitem.count = newitem.count or count
		if self.inv[type] == nil then
			self.inv[type] = {}
		end
		self.inv[type][class] = {}
		table.insert(self.inv[type][class], newitem)
	end
	if self:IsPlayer() then
		db:Query('UPDATE darkrp_inventory SET data=? WHERE steamid64=' .. self:SteamID64() .. ' AND charid='..self:GetNVar('CurrentChar')..';', util.TableToJSON(self.inv))
		self:UpdateInventory(type)
		self:UpdateInventory()
		hook.Run( "rp.inv.AddItem", self, type, class, count )
	end
end

function AddItem(steamid64, type, class, attributes, count)
	if not attributes then attributes = {} end
	if not istable(attributes) then
		count = attributes or 1
		attributes = {}
	elseif istable(attributes) and attributes.count then
		count = attributes.count
	else
		count = count or 1
	end

	if type == "weapon" then
		if not attributes.ammo then attributes.ammo = 0 end
		if not attributes.health then attributes.health = 100 end
	end

	local attrWithoutCount = table.Copy(attributes)
	if attrWithoutCount and attrWithoutCount.count then
		attrWithoutCount.count = nil
	end

	db:Query('SELECT * FROM darkrp_inventory WHERE SteamID64=' .. steamid64 .. ';', function(data)
		inv = util.JSONToTable(data)
		local key = FindKeyByAttributes(inv, type, class, attrWithoutCount)
		if inv[type][class] then
			if key then
				inv[type][class][key].count = (inv[type][class][key].count or 1) + count
			else
				local newitem = {}
				for attribute, attrinfo in pairs(attributes) do
					newitem[attribute] = attrinfo
				end
				newitem.count = newitem.count or 1
				table.insert(inv[type][class], newitem)
			end
		else
			local newitem = {}
			for attribute, attrinfo in pairs(attributes) do
				newitem[attribute] = attrinfo
			end
			newitem.count = newitem.count or 1
			inv[type][class] = {}
			table.insert(inv[type][class], newitem)
		end
		db:Query('UPDATE darkrp_inventory SET data=? WHERE steamid64=' .. steamid64 .. ';', util.TableToJSON(inv))
    end)

end

function playerMeta:Pickup(ent, type, class)
	if self:HaveSpace(Inventory.GetWeight(type, class)*(ent.attributes and ent.attributes.count or 1)) then
		local func = function(self)
			if not IsValid(ent) then return end
			net.Start("DoAnimation")
			net.WriteEntity(ply)
			net.WriteFloat(2025)
			net.Broadcast()
			if IsValid(ent) then
				ent.attributes = ent.attributes or {}

				if ent.Base == "spawned_food" then
					type = INV_FOOD
					class = ent.WorldModel
				end

				ent:Remove()
				self:AddItem(type, class, ent.attributes)
				self:EmitSound("items/ammo_pickup.wav")



				return
			end
		end
		local pickupTime = math.floor(Inventory.GetWeight(type, class))/2
		if pickupTime < 0.5 then pickupTime = 0.5 end
		self:StartProgressBar(pickupTime, func, "Поднимаю...")
	elseif self:HaveSpace(Inventory.GetWeight(type, class)*1) then
		local func = function(self)
			local space = self:GetDefaultSpace()
			local canpickup = (self:GetDefaultSpace()-self:GetSpace())/Inventory.GetWeight(type, class)
			canpickup = math.floor(canpickup)
			if canpickup > (ent.attributes and ent.attributes.count or 1) then
				canpickup = ent.attributes and ent.attributes.count or 1
			end
			if not IsValid(ent) then return end
			net.Start("DoAnimation")
			net.WriteEntity(ply)
			net.WriteFloat(2025)
			net.Broadcast()
			if IsValid(ent) then
				ent.attributes = ent.attributes or {}

				local tbl = table.Copy(ent.attributes)
				tbl.count = canpickup

				ent.attributes.count = ent.attributes.count - canpickup

				if ent.Base == "spawned_food" then
					type = INV_FOOD
					class = ent.WorldModel
				end

				if ent.attributes.count < 1 then
					ent:Remove()
				end

				self:AddItem(type, class, tbl)
				self:EmitSound("items/ammo_pickup.wav")

				return
			end
		end
		self:StartProgressBar(math.floor(Inventory.GetWeight(type, class))+0.5, func, "Поднимаю...")
	else
		DarkRP.notify(self, 1, 4, INV_TRANSLATION.not_enough)
		return false
	end
end

concommand.Add("Inventory.Drop", function(ply, cmd, args)
	if !ply:Alive() then return end
 	if args[1] && args[2] && args[3] then
 		local type = args[1]
 		local key = args[2]
 		key = tonumber(key)
 		local class = args[3]
 		local count = args[4] or 1
 		count = tonumber(count)

 		count = tonumber(count)
 		if not count or count <= 0 then
 			DarkRP.notify(ply, 1, 4, "Некорректное значение!")
			return false
 		end

 		if ply.inv[type] == nil or ply.inv[type][class] == nil or ply.inv[type][class][key] == nil then return end

 		if count > ply.inv[type][class][key].count then count = ply.inv[type][class][key].count end


 		if not ((type == INV_WEAPON or type == INV_ENTITY or type == INV_FOOD or type == INV_HATS or type == INV_CLOTHES) && ply:HaveItem(type, class, attributes)) then return end

	 	if ply.ProgressBar then
			DarkRP.notify(ply, 1, 4, "Вы не можете сделать это сейчас!")
			return false
		end

		if ply.inv[type][class][key].droppable == false then
			DarkRP.notify(ply, 1, 4, "Снаряжение было уничтожено!")
			ply:RemoveItemByKey(type, class, key, count)
			return false
		end

		local tr = util.TraceEntity({
			start = ply:EyePos(),
			endpos = ply:EyePos() + ply:GetAimVector() * 150 + Vector(0,0,50),
			filter = ply
		}, ply)


		local spawnPos = tr.HitPos
		-- Don't allows items to be spawned in the players feet
		local feetPos = ply:GetPos()
		if spawnPos:Distance(feetPos) < 64 then
			local feetDist = Vector(spawnPos.x, spawnPos.y, feetPos.z):Distance(feetPos)

			local offsetTr = util.TraceEntity({
				start = spawnPos,
				endpos = spawnPos + ply:GetForward() * (64 - feetDist)
			}, ply)

			spawnPos = offsetTr.HitPos
		end

		hook.Run( "rp.inv.DropItem", ply, type, class, count )
		if type == INV_WEAPON then
			for k, v in pairs(rp.shipments) do
				if v.entity == class then
					local weapon = ents.Create("spawned_weapon")
					weapon:SetModel(v.model)
					weapon.weaponclass = v.entity
					weapon.ShareGravgun = true
					weapon:SetPos(spawnPos)
					local tbl = {}
					for k,v in pairs(ply.inv[type][class][key]) do
						tbl[k] = v
					end
					weapon.attributes = tbl
					weapon.attributes.count = count
					weapon.nodupe = true
					weapon:Spawn()
					weapon.dropped = true
					weapon.ItemOwner = ply
       			-- weapon:CPPISetOwner(ply)
       			-- weapon:SetNVar('PropOwner', ply, NETWORK_PROTOCOL_PUBLIC)
       				weapon:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
       				ply:RemoveItemByKey(type, class, key, count)
					break
				end
			end
		elseif type == INV_ENTITY then
			for k, v in pairs(rp.entities) do
				if v.ent == class then
					local item = ents.Create(v.ent)
					item.dt = item.dt or {}
					item.dt.owning_ent = ply
					--if item.Setowning_ent then item:Setowning_ent(ply) end
					item:SetPos(spawnPos)
					item.SID = ply:SteamID()
					item.onlyremover = true
					local tbl = {}
					for k,v in pairs(ply.inv[type][class][key]) do
						tbl[k] = v
					end
					item.attributes = tbl
					item.attributes.count = count
					item.allowed = v.allowed
					item.DarkRPItem = v
					item:Spawn()
					item.dropped = shouldbedropped
					item.ItemOwner = ply
       			-- item:CPPISetOwner(ply)
       			-- item:SetNVar('PropOwner', ply, NETWORK_PROTOCOL_PUBLIC)
       				item:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
					ply:RemoveItemByKey(type, class, key, count)
					break
				end
			end
		elseif type == INV_FOOD then
			for k, v in pairs(rp.Foods) do
				if v.model == class then
					local item = v
					local SpawnedFood = ents.Create("spawned_food")
				--	SpawnedFood:Setowning_ent(ply)
					SpawnedFood.ShareGravgun = true
					SpawnedFood:SetPos(spawnPos)
					SpawnedFood.onlyremover = true
					SpawnedFood.SID = ply.SID
          		SpawnedFood:SetFoodAmount(v.amount or 0)
          		SpawnedFood:SetThirstAmount(v.thirst or 0)
					SpawnedFood:SetModel(v.model)
					SpawnedFood.FoodName = v.name
					local tbl = {}
					for k,v in pairs(ply.inv[type][class][key]) do
						tbl[k] = v
					end
					SpawnedFood.attributes = tbl
					SpawnedFood.attributes.count = count
					--SpawnedFood.FoodEnergy = v.energy
					SpawnedFood.FoodPrice = v.price
					SpawnedFood:Spawn()
					SpawnedFood.dropped = true
					SpawnedFood.ItemOwner = ply
       			-- SpawnedFood:CPPISetOwner(ply)
       			-- SpawnedFood:SetNVar('PropOwner', ply, NETWORK_PROTOCOL_PUBLIC)
       			SpawnedFood:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
       			ply:RemoveItemByKey(type, class, key, count)
				end
			end
		elseif type == INV_HATS then
			for k, v in pairs(Cosmetics.Items) do
				if k == class then
          			if not v.dropblock then
	  					local SpawnedHat = ents.Create("rp_cosmetics")
	  					SpawnedHat:SetModel(v.model)
						SpawnedHat:SetSkin(v.skin or 0)
	  					SpawnedHat:SetPos(spawnPos + Vector(0,0,15))
	  					SpawnedHat:DropToFloor()
	  					SpawnedHat:Spawn()
	  					SpawnedHat.dropped = true
	  					local tbl = {}
						for k,v in pairs(ply.inv[type][class][key]) do
							tbl[k] = v
						end
						SpawnedHat.attributes = tbl
	  					SpawnedHat.attributes.count = count
						SpawnedHat.ItemOwner = ply
	       				-- SpawnedFood:CPPISetOwner(ply)
	       				-- SpawnedFood:SetNVar('PropOwner', ply, NETWORK_PROTOCOL_PUBLIC)
	  					SpawnedHat:SetCosmeticType(class)
	       				SpawnedHat:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
	       				ply:RemoveItemByKey(type, class, key, count)
        			 else
            			DarkRP.notify(ply, 4, NOTIFY_ERROR, "Вы не можете выбросить "..v.name)
         			 end
				end
			end
		elseif type == INV_CLOTHES then
			for k, v in pairs(Cosmetics.Female.ListBottoms) do
					if k == class then
						local ent = ents.Create("cm_cloth")
						ent:SetModel("models/props_junk/cardboard_box003a.mdl")
						ent:SetPos( spawnPos )
						ent:Spawn()
						ent:SetCName(k)
						ent.Type = 2
						ent.dropped = true
						local tbl = {}
						for k,v in pairs(ply.inv[type][class][key]) do
							tbl[k] = v
						end
						ent.attributes = tbl
						ent.attributes.count = count
						ent.Sex = ply:CM_GetInfos().sex
						ent.ItemOwner = ply
						ent.Texture = v.texture
       					ent:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
						ply:RemoveItemByKey(type, class, key, count)
						return true
					end
				end
				for k, v in pairs(Cosmetics.Female.ListTops) do
					if k == class then
						local ent = ents.Create("cm_cloth")
						ent:SetModel("models/props_junk/cardboard_box003a.mdl")
						ent:SetPos( spawnPos )
						ent:Spawn()
						ent:SetCName(k)
						ent.Type = 1.2
						ent.Sex = ply:CM_GetInfos().sex
						local tbl = {}
						for k,v in pairs(ply.inv[type][class][key]) do
							tbl[k] = v
						end
						ent.attributes = tbl
						ent.attributes.count = count
						ent.ItemOwner = ply
						ent.dropped = true
						ent.Texture = v.texture
       					ent:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
						ply:RemoveItemByKey(type, class, key, count)
						return true
					end
				end
				for k, v in pairs(Cosmetics.Male.ListBottoms) do
					if k == class then
						local ent = ents.Create("cm_cloth")
						ent:SetModel("models/props_junk/cardboard_box003a.mdl")
						ent:SetPos( spawnPos )
						ent:Spawn()
						ent:SetCName(k)
						ent.Type = 2
						local tbl = {}
						for k,v in pairs(ply.inv[type][class][key]) do
							tbl[k] = v
						end
						ent.attributes = tbl
						ent.attributes.count = count
						ent.Sex = ply:CM_GetInfos().sex
						ent.ItemOwner = ply
						ent.Texture = v.texture
						ent.dropped = true
       					ent:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
						ply:RemoveItemByKey(type, class, key, count)
						return true
					end
				end
				for k, v in pairs(Cosmetics.Male.ListTops) do
					if k == class then
						local ent = ents.Create("cm_cloth")
						ent:SetModel("models/props_junk/cardboard_box003a.mdl")
						ent:SetPos( spawnPos )
						ent:Spawn()
						ent:SetCName(k)
						ent.Type = 1.2
						ent.Sex = ply:CM_GetInfos().sex
						local tbl = {}
						for k,v in pairs(ply.inv[type][class][key]) do
							tbl[k] = v
						end
						ent.attributes = tbl
						ent.attributes.count = count
						ent.ItemOwner = ply
						ent.dropped = true
						ent.Texture = v.texture
       					ent:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
						ply:RemoveItemByKey(type, class, key, count)
						return true
					end
				end
 		end
		net.Start("DoAnimation")
		net.WriteEntity(ply)
		net.WriteFloat(2021)
		net.Broadcast()
		ply:EmitSound('items/ammocrate_open.wav')
	end
end)

function playerMeta:TakeAll(container)
	net.Start("DoAnimation")
	net.WriteEntity(self)
	net.WriteFloat(2021)
	net.Broadcast()
	self:EmitSound("items/ammo_pickup.wav")

	for type, classes in pairs(container.inv) do
		for class, items in pairs(classes) do
			for key, attr in pairs(items) do
				local count = attr.count and tonumber(attr.count) or 1
				if not self:HaveSpace(Inventory.GetWeight(type, class)*count) then
					continue
				end
				container:RemoveItemByKey(type, class, key, count)
				self:AddItem(type, class, attr)
			end
		end
	end
	UpdateInventory(self, container)

end

concommand.Add("Inventory.TakeFromStorage", function(ply, cmd, args)
	if ply.lastPickup && ply.lastPickup > CurTime() then return end

	if !ply:Alive() then return end
	if !(args[1] && args[2]) then return end

	local storage = ply:GetEyeTrace().Entity

	if not storage:IsPlayer() then
		ply.lastPickup = CurTime() + 0.2
	else
		ply.lastPickup = CurTime() + 2
	end
	--if !(storage && storage.IsStorage ) then return end
	-- && storage:Check(ply, INV_ACT_TAKE)
	local type = args[1]
	local key = args[3]
	key = tonumber(key)
	local class = args[2]
	local count = args[4] or 1
	count = tonumber(count)
	local type2
	local class2

	if ply.ProgressBar then
		DarkRP.notify(ply, 1, 4, "Вы не можете сделать это сейчас!")
		return false
	end

	if args[1] == TAKE_ALL and args[2] == TAKE_ALL then
		if storage:IsPlayer() then return end

		local proccessTime = math.floor(storage:GetSpace())/2
		if proccessTime < 1 then proccessTime = 1 end

		net.Start("Inventory.CloseStorage")
		net.Send(ply)
		ply:StartProgressBar(proccessTime, function()
			ply:TakeAll(storage)
		end, "Хватаю вещи...")
		return
	end

	if storage.inv[type][class][key].count < count then count = storage.inv[type][class][key].count end


	if type == INV_HATS then
		if Cosmetics.Items[class] then
			--
		else
			for _, v in pairs(Cosmetics.Def) do
				for strNumber in string.gmatch(class, "%d+") do
					d = tonumber(strNumber)
				end
				if Cosmetics.Items[d] then
					class2 = Cosmetics.Items[d].id
					if Cosmetics.Items[d].type == "weapon" then
						type2 = INV_WEAPON
					else
						type2 = INV_HATS
					end
				end
			end
		end
	end

	if class2 and type2 then
		if not ((type == INV_CLOTHES or type == INV_WEAPON or type == INV_ENTITY or type == INV_FOOD or type == INV_HATS) && storage.inv[type][d][key]) then return end
	else
		if not ((type == INV_CLOTHES or type == INV_WEAPON or type == INV_ENTITY or type == INV_FOOD or type == INV_HATS) && storage.inv[type][class][key]) then return end
	end

	if class2 and type2 then
		if not ply:HaveSpace(Inventory.GetWeight(type2, class2)*count) then return end

		net.Start("DoAnimation")
		net.WriteEntity(ply)
		net.WriteFloat(2021)
		net.Broadcast()

		ply:EmitSound("items/ammo_pickup.wav")
		local attr = table.Copy(storage.inv[type2][class2][key])
		attr.count = count
		ply:AddItem(type2, class2, attr)
		storage:RemoveItemByKey(type, d, key, count)
		if not storage:IsPlayer() then
			UpdateInventory(ply, storage)
		end
		hook.Call( "PlayerTakeFromStorageInventory", nil, type2, class2 )
		if storage:IsPlayer() then
			hook.Run( "rp.inv.RoberryPlayer", ply, type, class, count, storage )
			net.Start("Inventory.CloseStorage")
			net.Send(ply)
		end
	else
		if not ply:HaveSpace(Inventory.GetWeight(type, class)*count) then return end

		net.Start("DoAnimation")
		net.WriteEntity(ply)
		net.WriteFloat(2021)
		net.Broadcast()

		ply:EmitSound("items/ammo_pickup.wav")
		local attr = table.Copy(storage.inv[type][class][key])
		attr.count = count
		ply:AddItem(type, class, attr)
		storage:RemoveItemByKey(type, class, key, count)
		if not storage:IsPlayer() then
			UpdateInventory(ply, storage)
		end
		hook.Call( "PlayerTakeFromStorageInventory", nil, type, class )
		if storage:IsPlayer() then
			hook.Run( "rp.inv.RoberryPlayer", ply, type, class, key, count, storage )
		end
	end

end)

net.Receive("Inventory.TakeFromStorageClothes", function(_, ply)
	if not IsValid(ply) then return end
	local type = net.ReadString()
	local class = net.ReadString()
	local storage = ply:GetEyeTrace().Entity

	if !((type == INV_CLOTHES) && storage:HaveItem(type, class)) then return end

	if !ply:HaveSpace(Inventory.GetWeight(type, class)) then return end

	net.Start("DoAnimation")
	net.WriteEntity(ply)
	net.WriteFloat(2021)
	net.Broadcast()

	ply:EmitSound("items/ammo_pickup.wav")
	ply:AddItem(type, class)
	storage:RemoveItem(type, class)
	if not storage:IsPlayer() then
		UpdateInventory(ply, storage)
	end
	hook.Call( "PlayerTakeFromStorageInventory", nil, type, class )
	if storage:IsPlayer() then
		hook.Run( "rp.inv.RoberryPlayer", ply, type, class, count, storage )
		net.Start("Inventory.CloseStorage")
			net.Send(pyl)
	end
end)

net.Receive("Inventory.PutInStorageClothes", function(_, ply)
	if not IsValid(ply) then return end
	local type = net.ReadString()
	local class = net.ReadString()
	local storage = ply:GetEyeTrace().Entity

	if storage:IsPlayer() then return end

	if !((type == INV_CLOTHES) && ply:HaveItem(type, class)) then return end

	if !ply:HaveSpace(Inventory.GetWeight(type, class)) then return end

	net.Start("DoAnimation")
	net.WriteEntity(ply)
	net.WriteFloat(2021)
	net.Broadcast()

	ply:EmitSound("items/ammo_pickup.wav")
	storage:AddItem(type, class)
	ply:RemoveItem(type, class)
	if not storage:IsPlayer() then
		UpdateInventory(ply, storage)
	end
	hook.Call( "PlayerTakeFromStorageInventory", nil, type, class )
end)


net.Receive("Inventory.DropClothes", function(_, ply)
	if not IsValid(ply) then return end
	local type = net.ReadString()
	local class = net.ReadString()

	if !((type == INV_CLOTHES) && ply:HaveItem(type, class)) then return end

	local tr = util.TraceEntity({
		start = ply:EyePos(),
		endpos = ply:EyePos() + ply:GetAimVector() * 150 + Vector(0,0,50),
		filter = ply
	}, ply)

	local spawnPos = tr.HitPos
	-- Don't allows items to be spawned in the players feet
	local feetPos = ply:GetPos()
	if spawnPos:Distance(feetPos) < 64 then
		local feetDist = Vector(spawnPos.x, spawnPos.y, feetPos.z):Distance(feetPos)

		local offsetTr = util.TraceEntity({
			start = spawnPos,
			endpos = spawnPos + ply:GetForward() * (64 - feetDist)
		}, ply)

		spawnPos = offsetTr.HitPos
	end

	for k, v in pairs(Cosmetics.Female.ListBottoms) do
		if k == class then
			local ent = ents.Create("cm_cloth")
			ent:SetModel("models/props_junk/cardboard_box003a.mdl")
			ent:SetPos( spawnPos )
			ent:Spawn()
			ent:SetCName(k)
			ent.Type = 2
			ent.Sex = ply:CM_GetInfos().sex
			ent.ItemOwner = ply
			ent.Texture = v.texture
			ent:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
			ply:RemoveItem(type, class)
			return true
		end
	end
	for k, v in pairs(Cosmetics.Female.ListTops) do
		if k == class then
			local ent = ents.Create("cm_cloth")
			ent:SetModel("models/props_junk/cardboard_box003a.mdl")
			ent:SetPos( spawnPos )
			ent:Spawn()
			ent:SetCName(k)
			ent.Type = 1.2
			ent.Sex = ply:CM_GetInfos().sex
			ent.ItemOwner = ply
			ent.Texture = v.texture
			ent:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
			ply:RemoveItem(type, class)
			return true
		end
	end
	for k, v in pairs(Cosmetics.Male.ListBottoms) do
		if k == class then
			local ent = ents.Create("cm_cloth")
			ent:SetModel("models/props_junk/cardboard_box003a.mdl")
			ent:SetPos( spawnPos )
			ent:Spawn()
			ent:SetCName(k)
			ent.Type = 2
			ent.Sex = ply:CM_GetInfos().sex
			ent.ItemOwner = ply
			ent.Texture = v.texture
			ent:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
			ply:RemoveItem(type, class)
			return true
		end
	end
	for k, v in pairs(Cosmetics.Male.ListTops) do
		if k == class then
			local ent = ents.Create("cm_cloth")
			ent:SetModel("models/props_junk/cardboard_box003a.mdl")
			ent:SetPos( spawnPos )
			ent:Spawn()
			ent:SetCName(k)
			ent.Type = 1.2
			ent.Sex = ply:CM_GetInfos().sex
			ent.ItemOwner = ply
			ent.Texture = v.texture
			ent:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
			ply:RemoveItem(type, class)
			return true
		end
	end

	net.Start("DoAnimation")
	net.WriteEntity(ply)
	net.WriteFloat(2021)
	net.Broadcast()

	ply:EmitSound("items/ammocrate_open.wav")
	ply:RemoveItem(type, class)
	if not storage:IsPlayer() then
		UpdateInventory(ply, storage)
	end
	hook.Call( "PlayerTakeFromStorageInventory", nil, type, class )
	if storage:IsPlayer() then
		hook.Run( "rp.inv.RoberryPlayer", ply, type, class, count, storage )
		net.Start("Inventory.CloseStorage")
			net.Send(pyl)
	end
end)

concommand.Add("Inventory.PutInStorage", function(ply, cmd, args)
	if ply.lastPickup && ply.lastPickup > CurTime() then return end

	if !ply:Alive() then return end
	if !(args[1] && args[2]) then return end

	ply.lastPickup = CurTime() + 0.2

	local storage = ply:GetEyeTrace().Entity
	if storage:IsPlayer() then return end
	--if !(storage && storage.IsStorage ) then return end
	-- storage:Check(ply, INV_ACT_PUT)
	local type = args[1]
	local class = args[2]
	local key = args[3]
	key = tonumber(key)
	local count = args[4] or 1
	local count = tonumber(count)

	if ply.inv[type][class][key].count < count then count = ply.inv[type][class][key].count end

	if !((type == INV_CLOTHES or type == INV_WEAPON or type == INV_ENTITY or type == INV_FOOD or type == INV_HATS) && ply:HaveItem(type, class)) then return end

	if ply.ProgressBar then
		DarkRP.notify(ply, 1, 4, "Вы не можете сделать это сейчас!")
		return false
	end

	if ply.inv[type][class][key].droppable == false then
		DarkRP.notify(ply, 1, 4, "Вы не можете положить данное снаряжение в хранилище!")
		return false
	end

	net.Start("DoAnimation")
	net.WriteEntity(ply)
	net.WriteFloat(2021)
	net.Broadcast()
	ply:EmitSound("items/ammo_pickup.wav")

	local tbl = table.Copy(ply.inv)
	tbl.count = count

	storage:AddItem(type, class, tbl)
	ply:RemoveItemByKey(type, class, key, count)
	if not storage:IsPlayer() then
		UpdateInventory(ply, storage)
	end
	hook.Call( "PlayerPutInStorageInventory", nil, type, class )
end)

concommand.Add("Inventory.Eat", function(ply, cmd, args)
	if !ply:Alive() then return end
 	if args[1] && args[2] then

 		local type = args[1]
 		local class = args[2]

 		k = 3
 		while args[k] do
 			if args[k] then
 				class = class.. " "..args[k]
 				k = k + 1
 			else
 				break
 			end
 		end
 		if !((type == INV_FOOD) && ply:HaveItem(type, class)) then return end

	 	if ply.ProgressBar then
			DarkRP.notify(ply, 1, 4, "Вы не можете сделать это сейчас!")
			return false
		end

		if type == INV_FOOD then
			local eat = function(ply)
				for k, v in pairs(rp.Foods) do
					if v.model == class then
						ply:AddHunger(v.amount)
          				ply:AddThirst(v.thirst)
						ply:RemoveItem(type, class)

						v.customFunc(ply)

						hook.Run( "PlayerUseInventory", ply, type, class )
					end
				end
		 	end
			for k, v in pairs(rp.Foods) do
				if v.model == class then
       			if v.thirst > v.amount then
       				ply:EmitSound("eating_and_drinking/soda.wav")
       				ply:StartProgressBar(5, eat, "Пью "..v.name.."...")
       			else
					ply:EmitSound("eating_and_drinking/eating.wav")
					timer.Simple(2.5, function() ply:EmitSound("eating_and_drinking/eating.wav") end)
					ply:StartProgressBar(5, eat, "Ем "..v.name.."...")
					end
				end
			end
		end

	end
	hook.Call( "PlayerEatInventory", nil, type, class )
end)

net.Receive("Inventory.EquipClothes", function(_, ply)
	if not IsValid(ply) then return end
	local type = net.ReadString()
	local class = net.ReadString()

	if not ((type == INV_HATS or type == INV_CLOTHES) && ply:HaveItem(type, class)) then return end

 	if ply.ProgressBar then
		DarkRP.notify(ply, 1, 4, "Вы не можете сделать это сейчас!")
		return false
	end

	local cname
	local itype
	if type == INV_CLOTHES then
		local plyInfos = ply:CM_GetInfos()
		for k, v in pairs(Cosmetics.Female.ListBottoms) do
			if k == class then
				cname = k
				itype = 2
			end
		end
		for k, v in pairs(Cosmetics.Female.ListTops) do
			if k == class then
				cname = k
				itype = 1.2
			end
		end
		for k, v in pairs(Cosmetics.Male.ListBottoms) do
			if k == class then
				cname = k
				itype = 2
			end
		end
		for k, v in pairs(Cosmetics.Male.ListTops) do
			if k == class then
				cname = k
				itype = 1.2
			end
		end
		if itype == 1.2 then
			net.Start("DoAnimation")
			net.WriteEntity(ply)
			net.WriteFloat(2021)
			net.Broadcast()


			local data
			if plyInfos.sex == 1 then
				data = Cosmetics.Male
			else
				data = Cosmetics.Female
			end

			local infos = data.ListTops[cname]
			if not infos then
				DarkRP.notify(ply, 1, 4, "Вы не можете надеть это!")
				return false
			end
			ply:CM_DropCloth( 1 )
			ply:CM_AddTop( infos, false )

			plyInfos.teetexture.basetexture = infos.texture
			plyInfos.teetexture.id = nil
			plyInfos.teetexture.hasCustomThings = false
			plyInfos.bodygroups.top = infos.bodygroup

			ply:CM_SavePlayerInfos()
			ply:CM_NetworkTableInfos()
			ply:RemoveItem(INV_CLOTHES, class)
			hook.Run( "PlayerUseInventory", ply, INV_CLOTHES, class )
		elseif itype == 2 then

			net.Start("DoAnimation")
			net.WriteEntity(ply)
			net.WriteFloat(2021)
			net.Broadcast()

			local data
			if plyInfos.sex == 1 then
				data = Cosmetics.Male
			else
				data = Cosmetics.Female
			end

			local infos = data.ListBottoms[cname]
			if not infos then
				DarkRP.notify(ply, 1, 4, "Вы не можете надеть это!")
				return false
			end
			ply:CM_DropCloth( 2 )
			ply:CM_AddBottom( infos )

			plyInfos.panttexture.basetexture = infos.texture
			plyInfos.bodygroups.pant = infos.bodygroup

			ply:CM_SavePlayerInfos()
			ply:CM_NetworkTableInfos()
			ply:RemoveItem(INV_CLOTHES, class)
			hook.Run( "PlayerUseInventory", ply, INV_CLOTHES, class )
		end
		net.Start("UpdateClientCosmetics")
		net.Send(ply)
		hook.Call( "PlayerEquipInventory", nil, type, class )
	end
end)

concommand.Add("Inventory.Equip", function(ply, cmd, args)
	if !ply:Alive() then return end
 	if args[1] && args[2] then

		local type = args[1]
		local key = args[2]
		key = tonumber(key)
		local class = args[3]


		k = 4
		while args[k] do
			if args[k] then
				class = class.. " "..args[k]
				k = k + 1
			else
				break
			end
		end

		if !((type == INV_HATS or type == INV_CLOTHES) && ply:HaveItem(type, class)) then return end

	 	if ply.ProgressBar then
			DarkRP.notify(ply, 1, 4, "Вы не можете сделать это сейчас!")
			return false
		end

		if type == INV_HATS then
			if Cosmetics.Items[class].type == "weapon" then return end
			local data = Cosmetics.Items[class]

			if ply.Cosmetics[data.slot] then
				DarkRP.notify(ply, 1, 8, "У вас уже есть предмет в этом слоте ("..Cosmetics.Slots[data.slot].."). Сначала снимите его")
				return false
			end

			local func = function(ply)

				net.Start("DoAnimation")
				net.WriteEntity(ply)
				net.WriteFloat(2021)
				net.Broadcast()

				ply:RemoveItem(INV_HATS, class)
				ply:EquipCosmetic(class)

				net.Start("UpdateClientCosmetics")
				net.Send(ply)


				hook.Run( "PlayerUseInventory", ply, type, class )
				hook.Call( "PlayerEquipInventory", nil, type, class )

			end
			ply:StartProgressBar(2, func, "Надеваю "..Cosmetics.Items[class].name)
		end
	end
end)

concommand.Add("Inventory.Unequip", function(ply, cmd, args)
	if !ply:Alive() then return end
 	if args[1] && args[2] then

 		local type = args[1]
 		local class = args[2]

 		k = 3
 		while args[k] do
 			if args[k] then
 				class = class.. " "..args[k]
 				k = k + 1
 			else
 				break
 			end
 		end


 	if ply.ProgressBar then
		DarkRP.notify(ply, 1, 4, "Вы не можете сделать это сейчас!")
		return false
	end

		if type == INV_HATS then
			local data = Cosmetics.Items[class]
			if ply.Cosmetics[data.slot] and ply.Cosmetics[data.slot] == class then
				if ply.Cosmetics and class == "smershvest" and (ply:GetSpace() > (ply:GetDefaultSpace() - 2)) then DarkRP.notify(ply, 1, 6, "Ваш рюкзак переполнен, вы не можете его снять") return false end
				if ply.Cosmetics and class == "ukvest" and (ply:GetSpace() > (ply:GetDefaultSpace() - 2)) then DarkRP.notify(ply, 1, 6, "Ваш рюкзак переполнен, вы не можете его снять") return false end
				if ply.Cosmetics and class == "backpack_baselardwild" and (ply:GetSpace() > (ply:GetDefaultSpace() - 5)) then DarkRP.notify(ply, 1, 6, "Ваш рюкзак переполнен, вы не можете его снять") return false end
				if ply.Cosmetics and class == "backpack_blackjack" and (ply:GetSpace() > (ply:GetDefaultSpace() - 7)) then DarkRP.notify(ply, 1, 6, "Ваш рюкзак переполнен, вы не можете его снять") return false end
				if ply.Cosmetics and class == "backpack_molle" and (ply:GetSpace() > (ply:GetDefaultSpace() - 2)) then DarkRP.notify(ply, 1, 6, "Ваш рюкзак переполнен, вы не можете его снять") return false end
				if ply.Cosmetics and class == "backpack_pilgrim" and (ply:GetSpace() > (ply:GetDefaultSpace() - 6)) then DarkRP.notify(ply, 1, 6, "Ваш рюкзак переполнен, вы не можете его снять") return false end
				if ply.Cosmetics and class == "backpack_trizip" and (ply:GetSpace() > (ply:GetDefaultSpace() - 3.5)) then DarkRP.notify(ply, 1, 6, "Ваш рюкзак переполнен, вы не можете его снять") return false end
				if ply.Cosmetics and class == "backpack_pilgrim2a" and (ply:GetSpace() > (ply:GetDefaultSpace() - 6)) then DarkRP.notify(ply, 1, 6, "Ваш рюкзак переполнен, вы не можете его снять") return false end
				if ply.Cosmetics and class == "backpack_pilgrim2b" and (ply:GetSpace() > (ply:GetDefaultSpace() - 6)) then DarkRP.notify(ply, 1, 6, "Ваш рюкзак переполнен, вы не можете его снять") return false end
				if ply.Cosmetics and class == "backpack_pilgrim2c" and (ply:GetSpace() > (ply:GetDefaultSpace() - 6)) then DarkRP.notify(ply, 1, 6, "Ваш рюкзак переполнен, вы не можете его снять") return false end
				if ply.Cosmetics and class == "backpack_citya" and (ply:GetSpace() > (ply:GetDefaultSpace() - 3.2)) then DarkRP.notify(ply, 1, 6, "Ваш рюкзак переполнен, вы не можете его снять") return false end
				if ply.Cosmetics and class == "backpack_cityb" and (ply:GetSpace() > (ply:GetDefaultSpace() - 3.2)) then DarkRP.notify(ply, 1, 6, "Ваш рюкзак переполнен, вы не можете его снять") return false end
				if ply.Cosmetics and class == "backpack_cityc" and (ply:GetSpace() > (ply:GetDefaultSpace() - 3.2)) then DarkRP.notify(ply, 1, 6, "Ваш рюкзак переполнен, вы не можете его снять") return false end
				if ply.Cosmetics and class == "backpack_city2a" and (ply:GetSpace() > (ply:GetDefaultSpace() - 3.2)) then DarkRP.notify(ply, 1, 6, "Ваш рюкзак переполнен, вы не можете его снять") return false end
				if ply.Cosmetics and class == "backpack_city2b" and (ply:GetSpace() > (ply:GetDefaultSpace() - 3.2)) then DarkRP.notify(ply, 1, 6, "Ваш рюкзак переполнен, вы не можете его снять") return false end

				net.Start("DoAnimation")
				net.WriteEntity(ply)
				net.WriteFloat(2021)
				net.Broadcast()
				-- DarkRP.notify(ply, 0, 6, "Вы сняли с себя " .. data.name .. ".")

				ply:UnequipCosmetic(class)
				ply:AddItem(INV_HATS, class)
			else
				DarkRP.notify(ply, 1, 6, "На вас не надета эта вещь (" .. class .. ").")
			end
 		end
	end
	hook.Call( "PlayerUnequipInventory", nil, type, class )
	hook.Run( "PlayerUnequipInventory", ply, type, class )
end)

concommand.Add("Inventory.Unequipwep", function(ply, cmd, args)
	if not ply:Alive() then return end
 	if args[1] && args[2] then

 		local type = args[1]
 		local class = args[2] -- Or this can be a table

 		k = 3
 		while args[k] do
 			if args[k] then
 				class = class.. " "..args[k]
 				k = k + 1
 			else
 				break
 			end
 		end

 	if ply.ProgressBar then
		DarkRP.notify(ply, 1, 4, "Вы не можете сделать это сейчас!")
		return false
	end

	if type == INV_HATS then
		local func = function(ply)
			local data = Cosmetics.Items[class]
			if ply.Cosmetics[data.slot] and (ply.Cosmetics[data.slot] == class or ply.Cosmetics[data.slot].class == class) then
				net.Start("DoAnimation")
				net.WriteEntity(ply)
				net.WriteFloat(2021)
				net.Broadcast()
				local attributes = {ammo = ply:GetWeapon(class).Clip1 and ply:GetWeapon(class):Clip1() or -1, health = ply.Cosmetics[data.slot].health or 100}
				ply:UnequipCosmetic(class)
				for k2, v2 in pairs(Cosmetics.Items) do
					if k2 == class then
						ply:AddItem(INV_WEAPON, class, attributes)
						ply:StripWeapon(v2.id)
					end
				end
			else
				DarkRP.notify(ply, 1, 6, "На вас не надета эта вещь (" .. class .. ").")
			end
		end

		ply:StartProgressBar(1, func, "Снимаю "..Cosmetics.Items[class].name)

 		end
	end
	hook.Call( "PlayerUnequipInventory", nil, type, class )
end)

concommand.Add("Inventory.Use", function(ply, cmd, args)
	if not ply:Alive() then return end

 	if args[1] && args[2] then

 		local type = args[1]
 		local key = args[2]
 		key = tonumber(key)
 		local class = args[3]

 		k = 4
 		while args[k] do
 			if args[k] then
 				class = class.. " "..args[k]
 				k = k + 1
 			else
 				break
 			end
 		end

 		if not ((type == INV_CLOTHES or type == INV_WEAPON or type == INV_ENTITY or type == INV_FOOD) && ply:HaveItem(type, class)) then return end

	 	if ply.ProgressBar then
			DarkRP.notify(ply, 1, 4, "Вы не можете сделать это сейчас!")
			return false
		end
		if type == INV_WEAPON then
			local func = function(ply)
				for k, v in pairs(rp.shipments) do
					if v.entity == class then
						for k2, v2 in pairs(Cosmetics.Items) do
							if v2.id and v2.id == v.entity then
								local item = v2.id
								if Cosmetics.Items[v.entity] then -- if exists
									ply.Cosmetics = ply.Cosmetics or {}

									local data = Cosmetics.Items[v.entity]

									if ply.Cosmetics[data.slot] then
										DarkRP.notify(ply, 1, 8, "У вас уже есть предмет в этом слоте ("..Cosmetics.Slots[data.slot].."). Сначала снимите его")
										return false
									end

									net.Start("DoAnimation")
									net.WriteEntity(ply)
									net.WriteFloat(2021)
									net.Broadcast()
									ply:Give(class)
									ply:GetWeapon(class):SetClip1(ply.inv[type][class][key].ammo or 0)
									ply.Cosmetics[data.slot] = {
										class = class,
										ammo = ply.inv[type][class][key].ammo or 0,
										health = ply.inv[type][class][key].health or 100,
									}
									ply:SavePlayerData("cosmetics", ply.Cosmetics)
									updateplayer(ply)

									-- DarkRP.notify(ply, 0, 6, "Вы экипировали " .. data.name .. ".")
									ply:RemoveItemByKey(type, class, key)
									hook.Run( "PlayerUseInventory", ply, type, class )


									ply:EmitSound("items/ammo_pickup.wav")

									-- if data.equipsound then
									-- 	ply:EmitSound( data.equipsound )
									-- end

									-- if data.gasmask == true then
									-- 	ply:ViewPunch( Angle( -3,0,0 ) )
									-- end

									ply:NetVars("Cosmetics", ply.Cosmetics, true)

									hook.Call("CosmeticsChanged", GAMEMODE, ply, class)

									return true
								end
								return true
							end
						end
						return true
					end
				end
			end
			ply:StartProgressBar(2, func, "Экипирую...")

		elseif type == INV_ENTITY then
			local ent = scripted_ents.Get(class)
			local item = Inventory.GetItem(type , class)
			if !item then return true end
			if not item.usable then return end
			local func = function(ply)
				net.Start("DoAnimation")
				net.WriteEntity(ply)
				net.WriteFloat(2021)
				net.Broadcast()
				local success = ent.Use(ply, ply)
				if success ~= false then
					ply:RemoveItem(type, class)
				end
				hook.Run( "PlayerUseInventory", ply, type, class )
			end
			ply:StartProgressBar(3, func, "Использую...")
		end
 	end
end)

concommand.Add("Inventory.PutInTrade", function(ply, cmd, args)
	if ply.lastPickup && ply.lastPickup > CurTime() then return end

	if !ply:Alive() then return end
	if !(args[1] && args[2]) then return end

	ply.lastPickup = CurTime() + 0.5

	local type = args[1]
	local class = args[2]
	local key = args[3]
	key = tonumber(key)
	local count = args[4] or 1
	count = tonumber(count)

	if ply.inv[type][class][key].count < count then count = ply.inv[type][class][key].count end

 	if ply.ProgressBar then
		DarkRP.notify(ply, 1, 4, "Вы не можете сделать это сейчас!")
		return false
	end

	if !((type == INV_CLOTHES or type == INV_WEAPON or type == INV_ENTITY or type == INV_FOOD or type == INV_HATS or type == INV_CLOTHES) && ply:HaveItem(type, class)) then return end

	if !ply:HaveSpaceT(Inventory.GetWeight(type, class)*count) then
		DarkRP.notify(ply, 1, 4, "В хранилище недостаточно места!")
		return false
	end

	if ply.inv[type][class][key].droppable == false then
        DarkRP.notify(ply, 1, 4, "Вы не можете сложить данное снаряжение!")
        return false
    end

	net.Start("DoAnimation")
	net.WriteEntity(ply)
	net.WriteFloat(2021)
	net.Broadcast()

	local tbl = table.Copy(ply.inv[type][class][key])
	tbl.count = count

	ply:EmitSound("items/ammo_pickup.wav")
	ply:AddItemT(type, class, tbl)
	ply:RemoveItemByKey(type, class, key, count)
	ply:UpdateInventory2()
  	hook.Call( "PlayerPutInTradeInventory", nil, type, class )
end)

concommand.Add("Inventory.TakeFromTrade", function(ply, cmd, args)
	if ply.lastPickup && ply.lastPickup > CurTime() then return end

	if !ply:Alive() then return end
	if !(args[1] && args[2]) then return end

	ply.lastPickup = CurTime() + 0.5

	local type = args[1]
	local class = args[2]
	local key = args[3]
	key = tonumber(key)
	local count = args[4] or 1
	count = tonumber(count)

	if ply.inv2[type][class][key].count < count then count = ply.inv2[type][class][key].count end

	if !((type == INV_CLOTHES or type == INV_WEAPON or type == INV_ENTITY or type == INV_FOOD or type == INV_HATS) && ply:HaveItem2(type, class)) then return end
	if !ply:HaveSpace(Inventory.GetWeight(type, class)*count) then
		DarkRP.notify(ply, 1, 4, "У вас недостаточно места!")
		return false
	end

	net.Start("DoAnimation")
	net.WriteEntity(ply)
	net.WriteFloat(2021)
	net.Broadcast()

	local tbl = table.Copy(ply.inv2[type][class][key])
	tbl.count = count

	ply:EmitSound("items/ammo_pickup.wav")
	ply:AddItem(type, class, tbl)
	ply:RemoveItemTByKey(type, class, key, count)
	ply:UpdateInventory2()
  hook.Call( "PlayerTakeFromTradeInventory", nil, type, class )
end)

hook.Add('PlayerCharLoaded', "RPRestoreInventoryData", function(ply)
  db:Query('SELECT data FROM darkrp_inventory WHERE steamid64=' .. ply:SteamID64() .. ' AND charid='..ply:GetNVar('CurrentChar')..';', function(data)
		if data[1] then
			ply.inv = util.JSONToTable(data[1].data)
		else
			ply.inv = {}
			ply.inv[INV_WEAPON] = {}
			ply.inv[INV_ENTITY] = {}
			ply.inv[INV_FOOD] = {}
			-- ply.inv[INV_PROP] = {}
			ply.inv[INV_HATS] = {}
      		ply.inv[INV_CLOTHES] = {}
			db:Query('INSERT INTO darkrp_inventory (steamid64, charid, data) VALUES(?, ?, ?);', ply:SteamID64(), ply:GetNVar('CurrentChar'), util.TableToJSON(ply.inv))
			ply:UpdateInventory()
		end
	end)
	timer.Simple(1, function()
		ply:UpdateInventory()
		ply:UpdateAllAmmo()
	end)
  if ply.inv2 then return end
  db:Query('SELECT data FROM darkrp_inventorypocket WHERE steamid64=' .. ply:SteamID64() .. ' AND charid='..ply:GetNVar('CurrentChar')..';', function(data)
    if data[1] then
      ply.inv2 = util.JSONToTable(data[1].data)
    else
      ply.inv2 = {}
      ply.inv2[INV_WEAPON] = {}
      ply.inv2[INV_ENTITY] = {}
      ply.inv2[INV_FOOD] = {}
    --   ply.inv2[INV_PROP] = {}
      ply.inv2[INV_HATS] = {}
      ply.inv2[INV_CLOTHES] = {}
      db:Query('INSERT INTO darkrp_inventorypocket (steamid64, charid,  data) VALUES(?, ?, ?);', ply:SteamID64(), ply:GetNVar('CurrentChar'), util.TableToJSON(ply.inv2))
      ply:UpdateInventory2()
    end
  end)
  timer.Simple(1, function()
    ply:UpdateInventory2()
  end)
end)

function LoadInventory(ply)
db:Query('SELECT data FROM darkrp_inventory WHERE steamid64=' .. ply:SteamID64() .. ' AND charid='..ply:GetNVar('CurrentChar')..';', function(data)
		if data[1] then
			ply.inv = util.JSONToTable(data[1].data)
		else
			ply.inv = {}
			ply.inv[INV_WEAPON] = {}
			ply.inv[INV_ENTITY] = {}
			ply.inv[INV_FOOD] = {}
			-- ply.inv[INV_PROP] = {}
			ply.inv[INV_HATS] = {}
      	ply.inv[INV_CLOTHES] = {}
			db:Query('INSERT INTO darkrp_inventory (steamid64, charid, data) VALUES(?, ?, ?);', ply:SteamID64(), ply:GetNVar('CurrentChar'), util.TableToJSON(ply.inv))
			ply:UpdateInventory()
		end
	end)
	timer.Simple(1, function()
		ply:UpdateInventory()
	end)
  if ply.inv2 then return end
  db:Query('SELECT data FROM darkrp_inventorypocket WHERE steamid64=' .. ply:SteamID64() .. ' AND charid='..ply:GetNVar('CurrentChar')..';', function(data)
    if data[1] then
      ply.inv2 = util.JSONToTable(data[1].data)
    else
      ply.inv2 = {}
      ply.inv2[INV_WEAPON] = {}
      ply.inv2[INV_ENTITY] = {}
      ply.inv2[INV_FOOD] = {}
    --   ply.inv2[INV_PROP] = {}
      ply.inv2[INV_HATS] = {}
      ply.inv2[INV_CLOTHES] = {}
      db:Query('INSERT INTO darkrp_inventorypocket (steamid64, charid,  data) VALUES(?, ?, ?);', ply:SteamID64(), ply:GetNVar('CurrentChar'), util.TableToJSON(ply.inv2))
      ply:UpdateInventory2()
    end
  end)
  timer.Simple(1, function()
    ply:UpdateInventory2()
  end)
end

function GM:PlayerUse(ply, ent)
	local type = ""

	if not IsValid(ent) then return false end

	if ply.lastInvPickup and ply.lastInvPickup > CurTime() then return false end
	ply.lastInvPickup = CurTime() + 0.3

	if ent.burningup || ent.nonPickup then return false end

	local class = ent:GetClass()

	if class == "spawned_weapon" then
		type = INV_WEAPON
		class = ent.weaponclass
		local item = Inventory.GetItem(type , class)
		if !item then return true end
		ply:Pickup(ent, INV_WEAPON, ent.weaponclass)
		return false
	elseif class == "spawned_food" then
		type = INV_FOOD
		class = ent:GetModel()
		local item = Inventory.GetItem(type , class)
		if !item then return true end
		ply:Pickup(ent, INV_FOOD, ent:GetModel())
		return false
	elseif class == "cm_cloth" then
		local infos = ply:CM_GetInfos()
		type = INV_CLOTHES
		class = ent:GetCName()
		sex = ent.sex or ent.Sex
		if not class then return false end
		if sex ~= infos.sex then
	      DarkRP.notify(ply, 4, NOTIFY_ERROR, 'Эта одежда не для вашего пола!')
		end
		local item = Inventory.GetItem(type , class)
		if !item then return true end
		ply:Pickup(ent, INV_CLOTHES, class)
		return false
	elseif class == "rp_cosmetics" then
		for k, v in pairs(Cosmetics.Items) do
			if k == ent:GetCosmeticType() then
				local item = Inventory.GetItem(INV_HATS , ent:GetCosmeticType())
				if !item then return true end
				ply:Pickup(ent, INV_HATS, ent:GetCosmeticType())
				return false
			end
		end
	else
		for k, v in pairs(rp.entities) do
			if v.ent == class then
				local item = Inventory.GetItem(INV_ENTITY , class)
				if !item then return true end
				ply:Pickup(ent, INV_ENTITY, class)
				return false
			end
		end
	end
end


timer.Create("DeleteDroppedItems", 1000, 0, function()
	for k, v in pairs(ents.GetAll()) do
		if v.dropped == true then
			v:Remove()
		end
	end
end)
-- -- TRUNK
-- function TrunkSearch(ply,key)
-- 	if key == IN_USE and IsValid(ply) then

-- 	local tr = util.TraceLine({ start  = ply:GetShootPos(), endpos = ply:GetShootPos() + ply:GetAimVector() * 84, filter = ply, mask = MASK_SHOT });

-- 		if (ply.lastTrunk or 0) < CurTime() and IsValid(tr.Entity) and tr.Entity:GetClass() == "gmod_sent_vehicle_fphysics_base" and tr.Entity.IsStorage then

-- 		local vPosition = Vector( tr.Entity:OBBCenter()[1], tr.Entity:OBBMins()[2], 10 )
-- 		vPosition = tr.Entity:LocalToWorld( vPosition)
-- 		-- ply:SetPos(vPosition)
-- 		if (ply:GetPos():DistToSqr(vPosition) >= 2000) then return end
-- 			print(ply:GetPos():DistToSqr(vPosition))
-- 			ply.lastTrunk = CurTime() + 0.3
-- 			if tr.Entity.inv then
-- 				net.Start("Inventory.StorageLookup")
-- 					net.WriteEntity(tr.Entity)
-- 					net.WriteTable(tr.Entity.inv)
-- 				net.Send(ply)
-- 			end
-- 		end

-- 	end
-- end
-- hook.Add("KeyRelease","TrunkSearch", TrunkSearch)

-- hook.Add("CanPlayerEnterVehicle", "Trunk.EnterVehicle", function( player, vehicle, role )
-- 	return true
-- end)