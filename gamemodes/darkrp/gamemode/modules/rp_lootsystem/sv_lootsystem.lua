rp.curLoot = rp.curLoot or {}



function SpawnLootOnFloor()
    rp.LootSystem.CurLoot = {}

    function BuildChances(tblWithRawChances)
        -- Если нет шансов - создаем их
        local chanceSummary = 0
        for lootid, loot in pairs(tblWithRawChances) do
            if (not loot.chance1 or not loot.chance2) then
                loot.chance1 = chanceSummary
                loot.chance2 = chanceSummary + loot.chance
            end
            chanceSummary = chanceSummary + loot.chance
        end

        return chanceSummary
    end

    function GetInfoFromLootExamples(examplesTbl)
        local value, key = table.Random( examplesTbl )
        local class = key
        local count = 1
        if istable(value) then
            count = math.random(value[1], value[2])
        else
            class = value
        end

        return class, count
    end


    function SpawnOnPlaceInstance(globalTable, place, summaryChance, availablePoses, globalTableKey, lootPlaceKey)
        local itemRoll = math.Rand(0, summaryChance)

        for lootTypeName, lootTypeTbl in pairs(globalTable.loot) do
            if lootTypeTbl.chance1 < itemRoll and lootTypeTbl.chance2 >= itemRoll then

                local lootTypeInstancesTbl = rp.LootSystem.LootTypes[lootTypeName]
                local poskey = math.random(1, #availablePoses)

                local inventoryType = lootTypeInstancesTbl.type
                local class, count = GetInfoFromLootExamples(lootTypeInstancesTbl.loot)
                local pos = availablePoses[poskey]

                rp.LootSystem.CurLoot[globalTableKey] = rp.LootSystem.CurLoot[globalTableKey] or {}
                rp.LootSystem.CurLoot[globalTableKey][lootPlaceKey] = rp.LootSystem.CurLoot[globalTableKey][lootPlaceKey] or {}
                rp.LootSystem.CurLoot[globalTableKey][lootPlaceKey]['Places'] = rp.LootSystem.CurLoot[globalTableKey][lootPlaceKey]['Places'] or {}
                rp.LootSystem.CurLoot[globalTableKey][lootPlaceKey]['Spawned'] = rp.LootSystem.CurLoot[globalTableKey][lootPlaceKey]['Spawned'] or false
                table.insert( rp.LootSystem.CurLoot[globalTableKey][lootPlaceKey]['Places'], {
                    type = inventoryType,
                    class = class,
                    count = count,
                    pos = pos,
                    looted = false,
                    ent = nil,
                })

                ShouldLootEntsSpawnOrDelete(rp.LootSystem.CurLoot[globalTableKey][lootPlaceKey])

                table.remove( availablePoses, tblkey)
            end
        end
    end

    function SpawnLootOnPlace(globalTable, place, summaryChance, globalTableKey, lootPlaceKey)
        local lootAmount = place.count
        availablePoses = table.Copy(place.poses)
        if lootAmount > #availablePoses then lootAmount = #availablePoses end

        for cycles = 1, lootAmount do
            local result = SpawnOnPlaceInstance(globalTable, place, summaryChance, availablePoses, globalTableKey, lootPlaceKey)
        end
    end



    for globalTableKey, globalTable in pairs(rp.LootSystem.RandomLoot) do
        local summaryChance = BuildChances(globalTable.loot)

        for lootPlaceKey, lootPlace in pairs(globalTable.places) do
            SpawnLootOnPlace(globalTable, lootPlace, summaryChance, globalTableKey, lootPlaceKey)
        end  
    end
end

function IsPlayersAround(pos, radius)
    radius = radius or 4000
    for _,ply in pairs(player.GetAll()) do
        if pos:DistToSqr(ply:GetPos()) < radius*radius then 
            return true
        end
    end
    return false
end

function ShouldLootEntsSpawnOrDelete(curLootTbl)
    local randLootForCheckKey = math.random(1, #curLootTbl["Places"])  
    local randLootForCheck = curLootTbl['Places'][randLootForCheckKey]
    if IsPlayersAround(randLootForCheck.pos) then
        if curLootTbl.Spawned == true then return end
        curLootTbl.Spawned = true
        for curLootKey, curLootTblInstance in pairs(curLootTbl['Places']) do
            if curLootTblInstance.looted == true then continue end

            --print("Спавню " .. curLootTblInstance.class)
            curLootTblInstance.ent = SpawnLoot(curLootTblInstance.class, curLootTblInstance.pos, curLootTblInstance.type, k, curLootTblInstance.count)
            timer.Simple(3, function()
                if IsValid(curLootTblInstance.ent) then
                    curLootTblInstance.ent:SetMoveType(MOVETYPE_NONE)
                    curLootTblInstance.ent:SetSolid(SOLID_VPHYSICS)
                end
            end)
        end
    else
        if curLootTbl.Spawned == false then return end
        curLootTbl.Spawned = false
        for curLootKey, curLootTblInstance in pairs(curLootTbl['Places']) do
            if IsValid(curLootTblInstance.ent) then 
            	--print("Удаляю " .. curLootTblInstance.class)
                curLootTblInstance.ent:Remove()   
            else
            	--print("Был залутан " .. curLootTblInstance.class)
                curLootTblInstance.looted = true
            end
        end
    end
end

function DeleteAllFloorLootByAttribute()
    for _,ent in pairs(ents.GetAll()) do
        if ent.IsLoot == true then 
            ent:Remove()
        end
    end
end

function DeleteAllFloorLoot()
    for _, globalTableCurLootTbl in pairs(rp.LootSystem.CurLoot) do
        for _, lootPlaceCurLootTbl in pairs(globalTableCurLootTbl) do
            for _, lootInstanceTbl in pairs(lootPlaceCurLootTbl.Places) do
                if IsValid(lootInstanceTbl.ent) then lootInstanceTbl.ent:Remove() end
            end
        end
    end
end

timer.Create("rp.LootSystem.PlayerNearLootTimer", 20, 0, function()
    if rp.LootSystem.CurLoot == nil then return end

    for globalTableKey, globalTableCurLootTbl in pairs(rp.LootSystem.CurLoot) do
        for lootPlaceKey, lootPlaceCurLootTbl in pairs(globalTableCurLootTbl) do
            ShouldLootEntsSpawnOrDelete(lootPlaceCurLootTbl)
        end
    end
end)



function SpawnLootContainers()
    rp.LootSystem.CurContainers = {}
    for type, typetbl in pairs(rp.LootSystem.RandomLootContainers) do
        for _, variant in pairs(typetbl.variants) do
            for _, pos in pairs(variant.pos) do
                local containerent = ents.Create("loot_container")
                -- containerent:SetNVar('LootContainerId', contid, NETWORK_PROTOCOL_PUBLIC)
                containerent.spawnedloot = true
                containerent:SetPos(pos[1])
                containerent:SetAngles(pos[2])
                containerent:SetModel(variant.model)
                containerent:Spawn()
                local phys = containerent:GetPhysicsObject()
                if IsValid(phys) then
                    phys:EnableMotion(false)
                end
                constraint.RemoveAll(containerent)

                table.insert(rp.LootSystem.CurContainers, {ent = containerent, typetbl = typetbl})

                AddLootToContainer(containerent, typetbl) 
            end
        end
    end  
end

function ClearContainer(container)
    container.inv = {}   
    container.inv[INV_WEAPON] = {}
    container.inv[INV_ENTITY] = {}
    container.inv[INV_FOOD] = {}
    container.inv[INV_PROP] = {}
    container.inv[INV_HATS] = {}
    container.inv[INV_CLOTHES] = {}
end

function RespawnLootContainers()
    for containerKey, containerTbl in pairs(rp.LootSystem.CurContainers) do
        local container = containerTbl.ent
        if IsValid(container) then
            ClearContainer(container)
            AddLootToContainer(container, containerTbl.typetbl)
        else
            --print("[LootSystem] Container won't spawn, better to check...")
        end
    end 
end

function AddLootToContainer(container, typetbl)
    local chanceSummary = 0

    for lootid, loot in pairs(typetbl.loot) do
        if (not loot.chance1 or not loot.chance2) then
            loot.chance1 = chanceSummary
            loot.chance2 = chanceSummary + loot.chance
        end
        chanceSummary = chanceSummary + loot.chance
    end

    local cyclesAmount = 5
    for i=1, cyclesAmount do
        local chanceitems = math.Rand(0, chanceSummary)
        for lootname1, loottable1 in pairs(typetbl.loot) do
            if loottable1.chance1 <= chanceitems and loottable1.chance2 > chanceitems then
                for lootname, loottable in pairs(rp.LootSystem.LootTypes) do
                    if lootname == lootname1 then
                        local count = 1
                        local value, key = table.Random(loottable.loot)
                        if istable(value) then
                            count = math.random(value[1], value[2])
                        else
                            key = value
                        end

                        local rand = math.random(loottable1.count[1], loottable1.count[2])
                        if rand > 0 then
                            for i = 1, rand do 
                                container:AddItem(loottable.type, key, count)    
                            end
                        end
                        break
                    end
                end  
                break         
            end
        end
    end 
end

concommand.Add("lootTest", function( ply, cmd, args )
    ply:ChatPrint("Лут на полу:")
    local successCheck = true
    for type, typetbl in pairs(rp.LootSystem.RandomLoot) do
        local summarychance = 0
        for _, variant in pairs(typetbl.loot) do
            summarychance = summarychance + variant.chance
        end
        if summarychance ~= 100 then
            successCheck = false
            ply:ChatPrint( type .. " имеет " .. summarychance .. " суммарных процентов шанса")
        end
    end
    if successCheck == true then
        ply:ChatPrint("Лут на полу успешно прошел проверку")
    end

    ply:ChatPrint("Лут в ящиках:")
    local successCheck = true
    for type, typetbl in pairs(rp.LootSystem.RandomLootContainers) do
        local summarychance = 0
        for _, variant in pairs(typetbl.loot) do
            summarychance = summarychance + variant.chance
        end
        if summarychance ~= 100 then
            successCheck = false
            ply:ChatPrint( type .. " имеет " .. summarychance .. " суммарных процентов шанса")
        end
    end
    if successCheck == true then
        ply:ChatPrint("Лут в ящиках успешно прошел проверку")
    end
end)

hook.Add( "InitPostEntity", "rp.LootSystem.InitSpawn", function()
    SpawnLootContainers()
    SpawnLootOnFloor()
    
    SpawnRadEnts()
end)

timer.Create("rp.LootSystem.RespawnTimer", rp.LootSystem.RespawnTimer, 0, function()
    DeleteAllFloorLoot()
    SpawnLootOnFloor()

    RespawnLootContainers()
    SpawnRocks()
end)




-------------------------------------------
-------------------------------------------
-------------------------------------------

function SpawnLoot(class, pos, type, id, count, isLoot)
	isLoot = isLoot and isLoot or true
    if type == INV_WEAPON then
        for k, v in pairs(rp.shipments) do
            if v.entity == class then
                local weapon = ents.Create("spawned_weapon")
                weapon:SetModel(v.model)
                weapon.weaponclass = v.entity
                weapon.ShareGravgun = true
                weapon:SetPos(pos)
                weapon.nodupe = true
                weapon.id = id
                weapon:Spawn()
                weapon.attributes = weapon.attributes or {}
                weapon.attributes.count = count or 1
                if isLoot then
                	weapon.IsLoot = true
                end
                weapon:DropToFloor()
            -- weapon:CPPISetOwner(ply)
            -- weapon:SetNVar('PropOwner', ply, NETWORK_PROTOCOL_PUBLIC)
                weapon:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
                return weapon
            end
        end
    elseif type == INV_ENTITY then
        for k, v in pairs(rp.entities) do
            if v.ent == class then
                local item = ents.Create(v.ent)
                item.dt = item.dt or {}
                --if item.Setowning_ent then item:Setowning_ent(ply) end
                item:SetPos(pos)
                item.onlyremover = true
                item.allowed = v.allowed
                item.DarkRPItem = v
                item.attributes = item.attributes or {}
                item.attributes.count = count or 1
                item:Spawn()
                item.id = id
                item:DropToFloor()
                if isLoot then
                	item.IsLoot = true
                end
            -- item:CPPISetOwner(ply)
            -- item:SetNVar('PropOwner', ply, NETWORK_PROTOCOL_PUBLIC)
                item:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
                return item
            end
        end
    elseif type == INV_FOOD then
        for k, v in pairs(rp.Foods) do
            if v.model == class then    
                local item = v
                local SpawnedFood = ents.Create("spawned_food")
            --  SpawnedFood:Setowning_ent(ply)
                SpawnedFood.ShareGravgun = true
                SpawnedFood:SetPos(pos)
                SpawnedFood.onlyremover = true
                SpawnedFood:SetFoodAmount(v.amount or 0)
                SpawnedFood:SetThirstAmount(v.thirst or 0)
                SpawnedFood:SetModel(v.model)
                SpawnedFood.attributes = SpawnedFood.attributes or {}
                SpawnedFood.attributes.count = count or 1
                SpawnedFood.FoodName = v.name
                SpawnedFood.id = id
                --SpawnedFood.FoodEnergy = v.energy
                SpawnedFood.FoodPrice = v.price
                SpawnedFood:Spawn()
                SpawnedFood:DropToFloor()
                if isLoot then
                	SpawnedFood.IsLoot = true
                end
            -- SpawnedFood:CPPISetOwner(ply)
            -- SpawnedFood:SetNVar('PropOwner', ply, NETWORK_PROTOCOL_PUBLIC)
            	SpawnedFood:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
            	return SpawnedFood
            end
        end
    elseif type == INV_HATS then
        for k, v in pairs(Cosmetics.Items) do
            if k == class then
                local SpawnedHat = ents.Create("rp_cosmetics")
                SpawnedHat:SetModel(v.model)
                SpawnedHat:SetSkin(v.skin or 0)                   
                SpawnedHat:SetPos(pos + Vector(0,0,15))
                SpawnedHat:DropToFloor()
                SpawnedHat:Spawn()
                if isLoot then
                	SpawnedHat.IsLoot = true
                end
                SpawnedHat.attributes = SpawnedHat.attributes or {}
                SpawnedHat.attributes.count = count or 1
                SpawnedHat.id = id
                SpawnedHat:DropToFloor()
                -- SpawnedFood:CPPISetOwner(ply)
                -- SpawnedFood:SetNVar('PropOwner', ply, NETWORK_PROTOCOL_PUBLIC)
                SpawnedHat:SetCosmeticType(class)
                SpawnedHat:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
                return SpawnedHat
            end
        end
    elseif type == INV_CLOTHES then
        for k, v in pairs(Cosmetics.Female.ListBottoms) do
            if k == class then
                local ent = ents.Create("cm_cloth")
                ent:SetModel("models/props_junk/cardboard_box003a.mdl")
                ent:SetPos( pos )
                ent:Spawn()
                ent:SetCName(k)
                ent.Type = 2
                ent.Sex = 1
                ent.attributes = ent.attributes or {}
                ent.attributes.count = count or 1
                ent.id = id
                ent:DropToFloor()
                if isLoot then
                	ent.IsLoot = true
                end
                ent.Texture = v.texture
                ent:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
                return ent
            end
        end
        for k, v in pairs(Cosmetics.Female.ListTops) do
            if k == class then
                local ent = ents.Create("cm_cloth")
                ent:SetModel("models/props_junk/cardboard_box003a.mdl")
                ent:SetPos( pos )
                ent:Spawn()
                ent:SetCName(k)
                ent.Type = 1.2
                ent.Sex = 1
                ent.attributes = ent.attributes or {}
                ent.attributes.count = count or 1
                ent.id = id
                ent:DropToFloor()
                if isLoot then
                	ent.IsLoot = true
                end
                ent.Texture = v.texture
                ent:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
                return ent
            end
        end
        for k, v in pairs(Cosmetics.Male.ListBottoms) do
            if k == class then
                local ent = ents.Create("cm_cloth")
                ent:SetModel("models/props_junk/cardboard_box003a.mdl")
                ent:SetPos( pos )
                ent:Spawn()
                ent:SetCName(k)
                ent.Type = 2
                ent.Sex = 1
                ent.attributes = ent.attributes or {}
                ent.attributes.count = count or 1
                ent.id = id
                ent:DropToFloor()
                if isLoot then
                	ent.IsLoot = true
                end
                ent.Texture = v.texture
                ent:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
                return ent
            end
        end
        for k, v in pairs(Cosmetics.Male.ListTops) do
            if k == class then
                local ent = ents.Create("cm_cloth")
                ent:SetModel("models/props_junk/cardboard_box003a.mdl")
                ent:SetPos( pos )
                ent:Spawn()
                ent:SetCName(k)
                ent.Type = 1.2
                ent.Sex = 1
                ent.attributes = ent.attributes or {}
                ent.attributes.count = count or 1
                ent.id = id
                ent:DropToFloor()
                if isLoot then
               		ent.IsLoot = true
               	end
                ent.Texture = v.texture
                ent:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
                return ent
            end
        end         
    end
end

function SpawnRocks()
    for key, info in pairs(rp.LootSystem.Rocks) do
        local vec = info.tbl[1]
        local ang = info.tbl[2]
        local exist = info.exist or false
        local shouldspawn = math.random(1,2)
        if not exist and shouldspawn == 1 then 
            info.exist = true
            local rock = ents.Create("ent_rock")
            rock:SetPos(vec)
            rock:SetAngles(ang)
            rock:Spawn()
            rock.id = key
            local phys = rock:GetPhysicsObject()
            if IsValid(phys) then
                phys:EnableMotion(false)
            end
            constraint.RemoveAll(rock)
        end
    end
end


 function SpawnLootOnFloorIndependent(globalTable, summaryChance, pos)
        local itemRoll = math.Rand(0, summaryChance)

        for lootTypeName, lootTypeTbl in pairs(globalTable.loot) do
            if lootTypeTbl.chance1 < itemRoll and lootTypeTbl.chance2 >= itemRoll then

                local lootTypeInstancesTbl = rp.LootSystem.LootTypes[lootTypeName]

                local inventoryType = lootTypeInstancesTbl.type
                local class, count = GetInfoFromLootExamples(lootTypeInstancesTbl.loot)

                local item = SpawnLoot(class, pos, inventoryType, "zombieLoot", count, false)
                if item then
                    item.lifetime = CurTime() + 600
                end
            end
        end
    end

hook.Add("OnNPCKilled", "ZombieLootDrop", function(npc, attacker)
	local rand = math.random(1, 100)

	local lootVariant
	if rand <= 5 then 
		lootVariant = rp.LootSystem.ZombieLoot["Лут с зомби(еда)"]
	elseif rand <= 20 then 
		lootVariant = rp.LootSystem.ZombieLoot["Лут с зомби(обычный)"]
	end

	if lootVariant ~= nil then
		local summaryChance = BuildChances(lootVariant.loot)
		SpawnLootOnFloorIndependent(lootVariant, summaryChance, npc:GetPos())
	end
end)


timer.Create( "LifetimeEntityCleaner", 60, 0, function()
	for _, ent in pairs(ents.GetAll()) do
		if ent.lifetime and ent.lifetime < CurTime() then
			ent:Remove()
		end
	end
end)