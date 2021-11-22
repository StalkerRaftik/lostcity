DarkRP.validateCategory = tc.checkTable{
    name =
        tc.addHint(
            isstring,
            "The name must be a string."
        ),

    categorises =
        tc.addHint(
            tc.oneOf{"jobs", "entities", "shipments", "weapons", "vehicles", "ammo"},
            [[The categorises must be one of "jobs", "entities", "shipments", "weapons", "vehicles", "ammo"]],
            {
                "Mind that this is case sensitive.",
                "Also mind the quotation marks."
            }
        ),

    startExpanded =
        tc.addHint(
            isbool,
            "The startExpanded must be either true or false."
        ),

    color =
        tc.addHint(
            tc.tableOf(isnumber),
            "The color must be a Color value."
        ),

    canSee =
        tc.addHint(
            tc.optional(isfunction),
            "The canSee must be a function."
        ),

    sortOrder =
        tc.addHint(
            tc.optional(isnumber),
            "The sortOrder must be a number."
        ),
}


DarkRP.errorNoHalt = fc{
    simplerr.wrapHook,
    simplerr.wrapLog,
    simplerr.runError,
    function(msg, err, ...) return msg, err and err + 3 or 4, ... end -- Raise error level one higher
}

DarkRP.simplerrRun = fc{
    fn.Snd, -- On success ignore the first return value
    simplerr.wrapError,
    simplerr.wrapHook,
    simplerr.wrapLog,
    simplerr.safeCall
}
DarkRP.error = fc{
    simplerr.wrapError,
    DarkRP.errorNoHalt
}

local categories = {
    jobs = {},
    entities = {},
    shipments = {},
    weapons = {},
    vehicles = {},
    ammo = {},
}
local categoriesMerged = false -- whether categories and custom items are merged.

DarkRP.getCategories = fp{fn.Id, categories}

local categoryOrder = function(a, b)
    local aso = a.sortOrder or 100
    local bso = b.sortOrder or 100
    return aso < bso or aso == bso and a.name < b.name
end

local function insertCategory(destination, tbl)
    -- Override existing category of applicable
    for k, cat in pairs(destination) do
        if cat.name ~= tbl.name then continue end

        destination[k] = tbl
        tbl.members = cat.members
        return
    end

    table.insert(destination, tbl)
    local i = #destination

    while i > 1 do
        if categoryOrder(destination[i - 1], tbl) then break end
        destination[i - 1], destination[i] = destination[i], destination[i - 1]
        i = i - 1
    end
end

function DarkRP.createCategory(tbl)
    local valid, err, hints = DarkRP.validateCategory(tbl)
    if not valid then DarkRP.error(string.format("Corrupt category: %s!\n%s", tbl.name or "", err), 2, hints) end
    tbl.members = {}

    local destination = categories[tbl.categorises]
    insertCategory(destination, tbl)

    -- Too many people made the mistake of not creating a category for weapons as well as shipments
    -- when having shipments that can also be sold separately.
    if tbl.categorises == "shipments" then
        insertCategory(categories.weapons, table.Copy(tbl))
    end
end

function DarkRP.addToCategory(item, kind, cat)
    cat = cat or "Other"
    item.category = cat

    -- The merge process will take care of the category:
    -- if not categoriesMerged then return end

    -- Post-merge: manual insertion into category
    local cats = categories[kind]
    for _, c in ipairs(cats) do
        if c.name ~= cat then continue end

        insertCategory(c.members, item)
        return
    end

    DarkRP.errorNoHalt(string.format([[The category of "%s" ("%s") does not exist!]], item.name, cat), 2, {
        "Make sure the category is created with DarkRP.createCategory.",
        "The category name is case sensitive!",
        "Categories must be created before DarkRP finished loading.",
    })
end

function DarkRP.removeFromCategory(item, kind)
    local cats = categories[kind]
    if not cats then DarkRP.error(string.format("Invalid category kind '%s'.", kind), 2) end
    local cat = item.category
    if not cat then return end
    for _, v in pairs(cats) do
        if v.name ~= item.category then continue end
        for k, mem in pairs(v.members) do
            if mem ~= item then continue end
            table.remove(v.members, k)
            break
        end
        break
    end
end

-- Assign custom stuff to their categories
local function mergeCategories(customs, catKind, path)
    -- local cats = categories[catKind]
    -- PrintTable(cats)
    -- local catByName = {}
    -- for k,v in pairs(cats) do catByName[v.name] = v end
    -- for k,v in pairs(customs) do
    --     -- Override default thing categories:
    --     local catName = v.category or "Other"
    --     local cat = catByName[catName]
    --     if not cat then
    --         DarkRP.errorNoHalt(string.format([[The category of "%s" ("%s") does not exist!]], v.name, catName), 3, {
    --             "Make sure the category is created with DarkRP.createCategory.",
    --             "The category name is case sensitive!",
    --             "Categories must be created before DarkRP finished loading."
    --         }, path, -1, path)
    --         cat = catByName.Other
    --     end

    --     cat.members = cat.members or {}
    --     table.insert(cat.members, v)
    -- end

    -- -- Sort category members
    -- for k,v in pairs(cats) do table.sort(v.members, categoryOrder) end
end

-- mergeCategories(rp.teams, "jobs", "your jobs")
hook.Add("Initialize", "mergeCategories", function()
    -- local shipments = fn.Filter(fc{fn.Not, fp{fn.GetValue, "noship"}}, CustomShipments)
    -- local guns = fn.Filter(fp{fn.GetValue, "separate"}, CustomShipments)

    mergeCategories(rp.teams, "jobs", "your jobs")
    mergeCategories(DarkRPEntities, "entities", "your custom entities")
    -- mergeCategories(shipments, "shipments", "your custom shipments")
    -- mergeCategories(guns, "weapons", "your custom weapons")
    mergeCategories(CustomVehicles, "vehicles", "your custom vehicles")
    mergeCategories(GAMEMODE.AmmoTypes, "ammo", "your custom ammo")

    categoriesMerged = true
end)


local blockTypes = {"Physgun1", "Spawning1", "Toolgun1"}
local checkModel = function(model) return model ~= nil and (CLIENT or util.IsValidModel(model)) end
local requiredTeamItems = {"color", "model", "description", "weapons", "command", "max", "salary", "admin"}

local validShipment = {
	model = checkModel,
"entity", "price", "amount", "seperate", "allowed"
}

local validVehicle = {
	"name",
	model = checkModel,
"price"
}

local validEntity = {
	"ent",
	model = checkModel,
"price", "max", "cmd", "name"
}

local function checkValid(tbl, requiredItems)
	for k, v in pairs(requiredItems) do
		local isFunction = type(v) == "function"
		if (isFunction and not v(tbl[k])) or (not isFunction and tbl[v] == nil) then return isFunction and k or v end
	end
end

rp.teams = {}
local jobByCmd = {}
DarkRP.getJobByCommand = function(cmd)
    if not jobByCmd[cmd] then return nil, nil end
    return rp.teams[jobByCmd[cmd]], jobByCmd[cmd]
end
function rp.addTeam(Name, CustomTeam)
	CustomTeam.name = Name
	local corrupt = checkValid(CustomTeam, requiredTeamItems)

	if corrupt then
		ErrorNoHalt("Corrupt team \"" .. (CustomTeam.name or "") .. "\": element " .. corrupt .. " is incorrect.\n")
	end

	table.insert(rp.teams, CustomTeam)
	team.SetUp(#rp.teams, Name, CustomTeam.color)
	local t = #rp.teams
	CustomTeam.team = t
	CustomTeam.requiredTime = CustomTeam.requiredTime || 0

	timer.Simple(0, function()
		GAMEMODE:AddTeamCommands(CustomTeam, CustomTeam.max)
	end)

	for k, v in pairs(CustomTeam.spawns or {}) do
		rp.cfg.TeamSpawns[k] = rp.cfg.TeamSpawns[k] or {}
		rp.cfg.TeamSpawns[k][t] = v
	end

  CustomTeam.unlockTime = CustomTeam.unlockTime or 0
  CustomTeam.lvl = CustomTeam.lvl
  CustomTeam.leader = CustomTeam.leader or false
  CustomTeam.subleader = CustomTeam.subleader or false
  
  DarkRP.addToCategory(CustomTeam, "jobs", CustomTeam.category)

	if CLIENT then
		local f = function()
			if CustomTeam.unlockPrice then
				CustomTeam.description = "Стоимость разблокировки: "..rp.FormatMoney(CustomTeam.unlockPrice)..'\n\n'..CustomTeam.description
			end
			local AddToDesc
			if #CustomTeam.weapons > 0 then
				for k,v in ipairs(CustomTeam.weapons) do
					AddToDesc = (AddToDesc or "\n\nОружие:").." "..(weapons.GetStored(v) and weapons.GetStored(v).PrintName or v)
					AddToDesc = next(CustomTeam.weapons, k) and (AddToDesc..",") or (AddToDesc..".\n")
				end
			end
			CustomTeam.description = CustomTeam.description..(AddToDesc or '')
		end
		hook('OnReloaded', 'Initialize.Reload'..t, f)
		hook('Initialize', 'Initialize.LoadDescInfo'..t, f)
	end
	
	-- Precache model here. Not right before the job change is done
	if type(CustomTeam.model) == "table" then
		for k, v in pairs(CustomTeam.model) do
			util.PrecacheModel(v)
		end
	else
		util.PrecacheModel(CustomTeam.model)
	end

	return t
end

rp.teamDoors = {}

function rp.AddDoorGroup(name, ...)
	rp.teamDoors[name] = rp.teamDoors[name] or {}

	for k, v in ipairs({...}) do
		rp.teamDoors[name][v] = true
	end
end

rp.shipments = {}
rp.shipmentsEntityMap = {}
function rp.AddShipment(name, model, entity, price, Amount_of_guns_in_one_shipment, Sold_seperately, price_seperately, noshipment, classes, shipmodel, CustomCheck)
	local tableSyntaxUsed = type(model) == "table"
	local AllowedClasses = classes or {}

	if not classes then
		for k, v in ipairs(team.GetAllTeams()) do
			table.insert(AllowedClasses, k)
		end
	end

	local price = tonumber(price)
	local shipmentmodel = shipmodel or "models/Items/item_item_crate.mdl"

	local customShipment = tableSyntaxUsed and model or {
		model = model,
		entity = entity,
		price = price,
		amount = Amount_of_guns_in_one_shipment,
		seperate = Sold_seperately,
		pricesep = price_seperately,
		noship = noshipment,
		allowed = AllowedClasses,
		shipmodel = shipmentmodel,
		customCheck = CustomCheck,
		weight = 5
	}

	customShipment.seperate = customShipment.separate or customShipment.seperate
	customShipment.name = name
	customShipment.allowed = customShipment.allowed or {}

	for k, v in ipairs(customShipment.allowed) do
		customShipment.allowed[v] = true
	end

	-- local corrupt = checkValid(customShipment, validShipment)

	-- -- if corrupt then
	-- -- 	ErrorNoHalt("Corrupt shipment \"" .. (name or "") .. "\": element " .. corrupt .. " is corrupt.\n")
	-- -- end

	-- if SERVER then
	-- 	rp.nodamage[entity] = true
	-- end

	rp.shipmentsEntityMap[customShipment.entity] = customShipment
	table.insert(rp.shipments, customShipment)
	-- rp.shipmentsEntityMap[entity] = customShipment
	util.PrecacheModel(customShipment.model)
end

--[[---------------------------------------------------------------------------
Decides whether a custom job or shipmet or whatever can be used in a certain map
---------------------------------------------------------------------------]]
function GM:CustomObjFitsMap(obj)
	if not obj or not obj.maps then return true end
	local map = string.lower(game.GetMap())

	for k, v in pairs(obj.maps) do
		if string.lower(v) == map then return true end
	end

	return false
end

rp.entities = {}

function rp.AddEntity(name, entity, model, price, max, command, classes, pocket)
	local tableSyntaxUsed = type(entity) == "table"

	local tblEnt = tableSyntaxUsed and entity or {
		ent = entity,
		model = model,
		price = price,
		max = max,
		cmd = command,
		allowed = classes,
		pocket = pocket
	}

	tblEnt.name = name
	tblEnt.allowed = tblEnt.allowed or {}

	if type(tblEnt.allowed) == "number" then
		tblEnt.allowed = {tblEnt.allowed}
	end

	if #tblEnt.allowed == 0 then
		for k, v in ipairs(team.GetAllTeams()) do
			table.insert(tblEnt.allowed, k)
		end
	end

	-- local corrupt = checkValid(tblEnt, validEntity)

	-- if corrupt then
	-- 	ErrorNoHalt("Corrupt Entity \"" .. (name or "") .. "\": element " .. corrupt .. " is corrupt.\n")
	-- end

	if SERVER then
		rp.nodamage[entity] = true
	end

	for k, v in ipairs(tblEnt.allowed) do
		tblEnt.allowed[v] = true
	end

	table.insert(rp.entities, tblEnt)

	timer.Simple(0, function()
		GAMEMODE:AddEntityCommands(tblEnt)
	end)

end

function rp.AddWeapon(name, model, entity, price, Amount_of_guns_in_one_shipment, Sold_seperately, price_seperately, noshipment, classes)
	rp.AddShipment(name, model, entity, price, Amount_of_guns_in_one_shipment, Sold_seperately, price_seperately, noshipment, classes)
	rp.AddCopItem(name, price_seperately, model, entity)
end

rp.groupChats = {}

function rp.addGroupChat(...)
	local classes = {...}

	table.foreach(classes, function(k, class)
		rp.groupChats[class] = {}

		table.foreach(classes, function(k, class2)
			rp.groupChats[class][class2] = true
		end)
	end)
end

rp.ammoTypes = {}

function rp.AddAmmoType(ammoType, name, model, price, amountGiven, customCheck)
	table.insert(rp.ammoTypes, {
		ammoType = ammoType,
		name = name,
		model = model,
		price = price,
		amountGiven = amountGiven,
		customCheck = customCheck
	})
end

