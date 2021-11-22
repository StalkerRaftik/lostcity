Inventory = {}
Storage = {}
TradeM = {}
/* 
	MODIFY PART
*/
INV_ADDITIONALSPACE = {}
INV_ADDITIONALSPACE2 = {}
INV_ADDITIONALSPACE3 = {}

INV_DEFAULTSPACE = 6 // default player space
INV_DEFAULTSTORAGESPACE = 50
INV_DELAYBEFOREPICKUP = 0.3 // delay before pick up, set to false to disable

INV_BOXCONTAINS = 7 // how much box can hold

INV_DEFAULTWEAPONCOLOR = Color(231, 76, 60) // weapon color
INV_DEFAULTFOODCOLOR = Color(46, 204, 113) // food color
INV_DEFAULTFENTITYCOLOR = Color(230, 126, 34) // entity color
INV_BLURENABLED = false

TAKE_ALL = "_" -- Take All enum

INV_TRANSLATION = {
	deminsion = "kg", // change to "kg" if you live in 21 century
	not_enough = "Недостаточно места",
	on_fire = "Этот предмет горит!",
	non_pickup = "Это не может поместиться к вам",
	not_empty = "Эта коробка что то содержит",
	weight = "Weights",
	coitan = "Contains",
	count = "Amount",
	drop = "Drop",
	equip = "Equip",
	eat = "Eat",
	use = "Use",
	box = "Box",
	your_inv = "Your inventory",
	food_calorific_value = "Calorific value", // used in food description
}

Storage.List = {
	box  = {
		name = INV_TRANSLATION.box,
		weight = INV_BOXCONTAINS
	},
	prop_ragdoll  = {
		name = "loot",
		weight = 7
	}
}

table.insert(INV_ADDITIONALSPACE, function(ply)
	if ply:IsSponsor() then return 8 end
	if ply:IsPremium() then return 5 end
	if ply:IsVIP() then return 3 end
	if ply:IsIgrokPlus() then return 1 end
	-- if ply.Cosmetics and ply.Cosmetics[COSM_SLOT_MISC] == "smershvest" then return 2 end
	-- if ply.Cosmetics and ply.Cosmetics[COSM_SLOT_MISC] == "ukvest" then return 2 end
	-- if ply.Cosmetics and ply.Cosmetics[COSM_SLOT_MISC2] == "backpack_baselardwild" then return 5 end
	-- if ply.Cosmetics and ply.Cosmetics[COSM_SLOT_MISC2] == "backpack_blackjack" then return 7 end
	-- if ply.Cosmetics and ply.Cosmetics[COSM_SLOT_MISC2] == "backpack_molle" then return 2 end
	-- if ply.Cosmetics and ply.Cosmetics[COSM_SLOT_MISC2] == "backpack_pilgrim" then return 6 end
	-- if ply.Cosmetics and ply.Cosmetics[COSM_SLOT_MISC2] == "backpack_trizip" then return 3.5 end
	-- if ply.Cosmetics and ply.Cosmetics[COSM_SLOT_MISC2] == "backpack_pilgrim2a" then return 6 end
	-- if ply.Cosmetics and ply.Cosmetics[COSM_SLOT_MISC2] == "backpack_pilgrim2b" then return 6 end
	-- if ply.Cosmetics and ply.Cosmetics[COSM_SLOT_MISC2] == "backpack_pilgrim2c" then return 6 end
	-- if ply.Cosmetics and ply.Cosmetics[COSM_SLOT_MISC2] == "backpack_citya" then return 3.2 end
	-- if ply.Cosmetics and ply.Cosmetics[COSM_SLOT_MISC2] == "backpack_cityb" then return 3.2 end
	-- if ply.Cosmetics and ply.Cosmetics[COSM_SLOT_MISC2] == "backpack_cityc" then return 3.2 end
	-- if ply.Cosmetics and ply.Cosmetics[COSM_SLOT_MISC2] == "backpack_city2a" then return 3.2 end
	-- if ply.Cosmetics and ply.Cosmetics[COSM_SLOT_MISC2] == "backpack_city2b" then return 3.2 end
end)

table.insert(INV_ADDITIONALSPACE3, function(ply)
	if ply.Cosmetics and ply.Cosmetics[COSM_SLOT_MISC] == "smershvest" then return 3 end
	if ply.Cosmetics and ply.Cosmetics[COSM_SLOT_MISC] == "ukvest" then return 3 end
	if ply.Cosmetics and ply.Cosmetics[COSM_SLOT_MISC2] == "backpack_baselardwild" then return 13 end
	if ply.Cosmetics and ply.Cosmetics[COSM_SLOT_MISC2] == "backpack_blackjack" then return 21 end
	if ply.Cosmetics and ply.Cosmetics[COSM_SLOT_MISC2] == "backpack_molle" then return 4 end
	if ply.Cosmetics and ply.Cosmetics[COSM_SLOT_MISC2] == "backpack_pilgrim" then return 16 end
	if ply.Cosmetics and ply.Cosmetics[COSM_SLOT_MISC2] == "backpack_trizip" then return 10 end
	if ply.Cosmetics and ply.Cosmetics[COSM_SLOT_MISC2] == "backpack_pilgrim2a" then return 16 end
	if ply.Cosmetics and ply.Cosmetics[COSM_SLOT_MISC2] == "backpack_pilgrim2b" then return 16 end
	if ply.Cosmetics and ply.Cosmetics[COSM_SLOT_MISC2] == "backpack_pilgrim2c" then return 16 end
	if ply.Cosmetics and ply.Cosmetics[COSM_SLOT_MISC2] == "backpack_citya" then return 6 end
	if ply.Cosmetics and ply.Cosmetics[COSM_SLOT_MISC2] == "backpack_cityb" then return 6 end
	if ply.Cosmetics and ply.Cosmetics[COSM_SLOT_MISC2] == "backpack_cityc" then return 6 end
	if ply.Cosmetics and ply.Cosmetics[COSM_SLOT_MISC2] == "backpack_city2a" then return 6 end
	if ply.Cosmetics and ply.Cosmetics[COSM_SLOT_MISC2] == "backpack_city2b" then return 6 end
end)

table.insert(INV_ADDITIONALSPACE2, function(ply)
	if ply:IsSponsor() then return 200 end	
	if ply:IsPremium() then return 100 end
	if ply:IsVIP() then return 50 end
	if ply:IsIgrokPlus() then return 30 end
end)

INV_WEAPON = "weapon"
INV_ENTITY = "entity"
INV_FOOD = "food"
INV_INGREDIENT = "ingredient"
INV_PROP = "prop"
INV_HATS = "hats"
INV_CLOTHES = "clothes"

INV_ACT_LOOKUP = 0
INV_ACT_TAKE = 1
INV_ACT_PUT = 2

function Storage:Get(name)
	return Storage.List[name]
end

function Inventory.IsEmpty(contents)
	-- for k, v in pairs(contents) do
	-- 	for _, item in pairs(v) do return false end
	-- end
	return true
end

function Inventory.GetWeight(type, class)
	if type == INV_WEAPON then
		for k, v in pairs(rp.shipments) do
			if v.entity == class then
				return v.weight or 0
			end
		end
		return 0
	elseif type == INV_ENTITY then
		for k, v in pairs(rp.entities) do
			if v.ent == class then
				return v.weight or 0
			end
		end
		return 0
	elseif type == INV_FOOD then
		for k, v in pairs(rp.Foods) do
			if v.model == class then
				return v.weight or 0.5
			end
		end
		return 0
	elseif type == INV_PROP then
		return 0
	elseif type == INV_PROP then
		return 0
	elseif type == INV_HATS then
		for k, v in pairs(Cosmetics.Items) do
			return 0.3
		end
	elseif type == INV_CLOTHES then
		return 1
	else
		return 0
	end
end

local entityMeta = FindMetaTable("Entity")

function entityMeta:GetTradeDSpace()
	local weight = INV_DEFAULTSTORAGESPACE
	for k, v in pairs(INV_ADDITIONALSPACE2) do
		if v(self) then
			weight = weight + v(self)
		end
	end
	return weight
end

function entityMeta:GetMailDSpace()
	local weight = tonumber(self:GetNWInt("mailspace"))
	return weight
end

function entityMeta:GetDefaultSpace()
	if self:IsPlayer() then
		local weight = INV_DEFAULTSPACE
		for k, v in pairs(INV_ADDITIONALSPACE) do
			if v(self) then
				weight = weight + v(self)
			end
		end
		for k, v in pairs(INV_ADDITIONALSPACE3) do
			if v(self) then
				weight = weight + v(self)
			end
		end
		return weight
	else
		return 10
	end
end

function FindKeyByAttributes(container, type, class, attributes)
	if container[type] == nil or container[type][class] == nil then return nil end
	if not attributes then attributes = {} end
	for key, tbl in pairs(container[type][class]) do
		local found = true
		for attribute, attInfo in pairs(attributes) do
			if not tbl.attribute or tbl.attribute ~= attInfo then
				found = false
				break
			end
		end
		if found then
			return key
		end
	end
	return nil
end

function entityMeta:GetItemCount(type, class, attributes)
	if not attributes then -- Считает количество всех предметов класса
		if not self.inv[type][class] then return 0 end
		local count = 0
		for k,v in pairs(self.inv[type][class]) do
			count = count + v.count
		end
		return count
	else -- Считает только с нужным атрибутом
		local key = FindKeyByAttributes(self.inv, type, class, attributes)
		if key then
			return self.inv[type][class][key].count
		else 
			return 0 
		end
	end
end


function entityMeta:GetItemCount2(type, class, attributes)
	if not attributes then -- Считает количество всех предметов класса
		local count = 0
		for k,v in pairs(self.inv2[type][class]) do
			count = count + v.count
		end
		return count
	else -- Считает только с нужным атрибутом
		local key = FindKeyByAttributes(self.inv, type, class, attributes)
		if key then
			return self.inv2[type][class][key].count
		else 
			return 0 
		end
	end
end

function entityMeta:GetItemCountMail(type, class)
	return self.Mail[type][class] or 0
end

function entityMeta:HaveItem(type, class, attributes)
	if not attributes then
		return self:GetItemCount(type, class) >= 1
	else
		return self:GetItemCount(type, class, attributes) >= 1
	end
end

function entityMeta:HaveItem2(type, class, attributes)
	if not attributes then
		return self:GetItemCount2(type, class) >= 1
	else
		return self:GetItemCount2(type, class, attributes) >= 1
	end
end

function entityMeta:HaveItemMail(type, class, count)
	return self:GetItemCountMail(type, class) && self:GetItemCountMail(type, class) >= (count or 1)
end

function entityMeta:GetSpace()
	return Inventory.GetSpace(self.inv)
end

function entityMeta:GetSpace2()
	return Inventory.GetSpace(self.inv2)
end

function entityMeta:GetSpaceMail()
	return Inventory.GetSpace(self.Mail)
end

function Inventory.GetSpace(contents)
	local weight = 0
	for type, classes in pairs(contents) do
		for class, items in pairs(classes) do
			for key, item in pairs(items) do
				weight = weight + Inventory.GetWeight(type, class) * (item.count or 1)
			end
		end
	end
	return weight
end


function Inventory.GetItem(type, class)
	if type == INV_WEAPON then
		for k, v in pairs(rp.shipments) do
			if v.entity == class then
				local item = v
				return {model = item.model, name = item.name, desc = "", weight = item.weight, isweapon = true, class = class}
			end
		end
	elseif type == INV_ENTITY then
		for k, v in pairs(rp.entities) do
			if v.ent == class then
				local item = v
				return {model = item.model, name = scripted_ents.Get(class) and scripted_ents.Get(class).PrintName or v.name, desc = scripted_ents.Get(class) and scripted_ents.Get(class).Instructions or item.desc, weight = item.weight, class = class, usable = item.usable or false}
			end
		end
	elseif type == INV_FOOD then
		for k, v in pairs(rp.Foods) do
			if v.model == class then
				local item = v
				local desc 
				if item.thirst and item.thirst ~= 0 then desc = "Сытость: ".. item.amount*35 .. " ккал. Жажда: "..item.thirst*2/100 .. " л." else desc = "Сытость: ".. item.amount*35 .. 'ккал.' end
				return {model = item.model, name = item.name, desc = desc, weight = item.weight, isfood = true, amount = item.amount, thirst = item.thirst, class = class}
			end
		end
  elseif type == INV_CLOTHES then
	for k, v in pairs(Cosmetics.Female.ListBottoms) do
		if k == class then
			local item = v
			return {model = "models/props_junk/cardboard_box003a.mdl", text = item.texture, name = k, desc = item.category[1], weight = 1, sex = 0, id = 2, class = class}
		end
	end
	for k, v in pairs(Cosmetics.Female.ListTops) do
		if k == class then
			local item = v
			return {model = "models/props_junk/cardboard_box003a.mdl", text = item.texture, name = k, desc = item.category[1], weight = 1, sex = 0,id = 1.2, class = class}
		end
	end
	for k, v in pairs(Cosmetics.Male.ListBottoms) do
		if k == class then
			local item = v
			return {model = "models/props_junk/cardboard_box003a.mdl", text = item.texture, name = k, desc = item.category[1], weight = 1, sex = 1, id = 2, class = class}
		end
	end
	for k, v in pairs(Cosmetics.Male.ListTops) do
		if k == class then
			local item = v
			return {model = "models/props_junk/cardboard_box003a.mdl", text = item.texture, name = k, desc = item.category[1], weight = 1, sex = 1,id = 1.2, class = class}
		end
	end
	elseif type == INV_HATS then
		for k, v in pairs(Cosmetics.Items) do
			if k == class then 
				local item = v
			    return {model = item.model, name = item.name, weight = 0.3, ishat = true, class = class}
			end
		end
	elseif type == INV_PROP then
		return {model = "models/props_junk/cardboard_box003a.mdl", name = "kek", weight = 1, class = "kek"}
	elseif type == INV_INGREDIENT then
		if Crafting:GetIngredient(class) then
			local item = Crafting:GetIngredient(class)
			return {model = item.model, name = item.name, desc = item.desc, weight = item.weight, class = class}
		end
	end
end

function Inventory.GetItemByClass(class)
	local item = Inventory.GetItem(INV_ENTITY, class)
	local type = INV_ENTITY
	if not item then 
		item = Inventory.GetItem(INV_FOOD, class)
	end
	if not item then 
		item = Inventory.GetItem(INV_WEAPON, class)
	end
	if not item then 
		item = Inventory.GetItem(INV_HATS, class)
	end
	if not item then 
		item = Inventory.GetItem(INV_CLOTHES, class)
	end
	if not item then
		type = nil
	end
	return item, type
end