rp.Conquest.Flags = rp.Conquest.Flags or {}

function SpawnFlags()
    
    for flagid,tbl in pairs(rp.Conquest.Config) do 
        local cpoint = ents.Create("flag")
        cpoint.id = flagid
        cpoint:SetPos(tbl.flag[1])
        cpoint:SetAngles(tbl.flag[2])
        cpoint:Spawn()

        rp.Conquest.Flags[flagid] = cpoint

        local ccontainer = ents.Create("conqueststorage")
        ccontainer.id = flagid
        ccontainer:SetPos(tbl.container[1])
        ccontainer:SetAngles(tbl.container[2])
        ccontainer:Spawn()

        cpoint.container = ccontainer
    end
end


function CheckFlag()
    for k, v in pairs(ents.GetAll()) do
        if v:GetClass() == "flag" then
            print(v.id .. " пренадлежит " .. v:GetNVar("FlagOwner"))
        end
    end
end


function PlayersOnTerritory(flag, team)
    local pos1 = rp.Conquest.Config[flag.id].coords[1]
    local pos2 = rp.Conquest.Config[flag.id].coords[2]
    local result = 0
    local b
    if pos1[1] > pos2[1] then 
        b = pos1[1]
        pos1[1] = pos2[1]
        pos2[1] = b
    end
    if pos1[2] > pos2[2] then 
        b = pos1[2]
        pos1[2] = pos2[2]
        pos2[2] = b
    end
    if pos1[3] > pos2[3] then 
        b = pos1[3]
        pos1[3] = pos2[3]
        pos2[3] = b
    end


    for k,v in pairs(player.GetAll()) do
        local plypos = v:GetPos()

        if v:getJobTable().category == team then
            if plypos[1] > pos1[1] and plypos[2] > pos1[2] and plypos[3] > pos1[3] then
                if plypos[1] < pos2[1] and plypos[2] < pos2[2] and plypos[3] < pos2[3] then
                    result = result + 1
                end
            end 
        end 
    end

    return result
end

function CaptureCheck(flag, activator)
    local CapturingPlayers = PlayersOnTerritory(flag, activator:getJobTable().category)
    local players = #player.GetAll()

    if flag:GetNVar("FlagOwner") == "Ничей" and CapturingPlayers >= 1 then
        return true
    else
        local OwnersOnTerritory = PlayersOnTerritory(flag, flag:GetNVar("FlagOwner"))

        if CapturingPlayers >= 1 and CapturingPlayers > OwnersOnTerritory then
            return true
        else
            return false
        end
    end
end

function PlayersOnTerritoryAsEntities(flag, team)
    local pos1 = rp.Conquest.Config[flag.id].coords[1]
    local pos2 = rp.Conquest.Config[flag.id].coords[2]
    local result = {}
    local b
    if pos1[1] > pos2[1] then 
        b = pos1[1]
        pos1[1] = pos2[1]
        pos2[1] = b
    end
    if pos1[2] > pos2[2] then 
        b = pos1[2]
        pos1[2] = pos2[2]
        pos2[2] = b
    end
    if pos1[3] > pos2[3] then 
        b = pos1[3]
        pos1[3] = pos2[3]
        pos2[3] = b
    end


    for k,v in pairs(player.GetAll()) do
        local plypos = v:GetPos()

        if v:getJobTable().category == team then
            if plypos[1] > pos1[1] and plypos[2] > pos1[2] and plypos[3] > pos1[3] then
                if plypos[1] < pos2[1] and plypos[2] < pos2[2] and plypos[3] < pos2[3] then
                    table.insert( result, k, v)
                end
            end 
        end 
    end

    return result
end



local rewardtimer = 0
-- NON ACTIVE
function HoldingTerritories()
    -- for k, v in pairs(ents.GetAll()) do -- Проверка на наличие людей на территории флага
    --     if v:GetClass() == "flag" then
    --         if v:GetNVar("FlagOwner") ~= "Ничей" then
    --             local plholding = PlayersOnTerritory(v, v:GetNVar("FlagOwner"))
    --             if plholding == 0 then
    --                 if v.losetick < 4 then
    --                     v.losetick = v.losetick + 1
    --                 else
    --                     rp.GlobalChat(CHAT_NONE, Color(255,0,0) ,"[Общая частота] ", Color(128, 128, 128), "Неизвестный", Color(255,255,255), ": " .. v:GetNVar("FlagOwner") .. " бросили свою территорию '" .. v.id .. "'")
    --                     v:SetNVar("FlagOwner", "Ничей", NETWORK_PROTOCOL_PUBLIC)
    --                     for _,storage in pairs(ents.GetAll()) do
    --                         if storage:GetClass() == "conqueststorage" then
    --                             if storage.id == v.id then
    --                                 v:SetNVar("FlagOwner", "Ничей", NETWORK_PROTOCOL_PUBLIC)
    --                             end
    --                         end
    --                     end
    --                     v:SetColor(Color(255,255,255, 0))
    --                     v.losetick = 0
    --                 end
    --             else
    --                 v.losetick = 0
    --             end
    --         end
    --     end
    -- end

    -- Выдача наград за удержание
    for k, flag in pairs(ents.GetAll()) do
        if flag:GetClass() == "flag" and flag:GetNVar("FlagOwner") ~= "Ничей" then
            for _,ply in pairs(player.GetAll()) do -- Выдача жалования всем из группировки
                if flag:GetNVar("FlagOwner") == ply:getJobTable().category then
                    ply:AddMoney(rp.Conquest.HoldReward)
                end
            end
            -- for _,cont in pairs(ents.GetAll()) do
            --     if cont:GetClass() == "conqueststorage" then
            --         if flag.id == cont.id then

            --             AddLootToContainer(cont, rp.LootSystem.RandomLootContainers[ math.random(#rp.Conquest.Config[cont.id].rewards) ])

            --             -- Спец награды
            --             -- for ownername,specrew in pairs(rp.Conquest.SpecRewards) do
            --             --     if ownername == cont:GetNVar("FlagOwner") then
            --             --         for specrewid,specrewtbl in pairs(specrew) do
            --             --             if specrewtbl.territories == cont.id then
            --             --                 for i = 1,2 do
            --             --                     cont:AddItem(INV_ENTITY, specrewtbl.rewards[ math.random( #specrewtbl.rewards ) ])
            --             --                 end
            --             --                 for k,v in pairs(PlayersOnTerritoryAsEntities(flag, flag:GetNVar("FlagOwner"))) do
            --             --                     v:ChatPrint( 'Умелое управление территорией позволило найти больше добычи.' )
            --             --                 end
            --             --             end
            --             --         end
            --             --     end
            --             -- end

            --         end
            --     end
            -- end
        end
    end

    for _,ply in pairs(player.GetAll()) do -- Информирование игроков
        local notifyHasSent = false
        for _,flag in pairs(ents.GetAll()) do
            if notifyHasSent == true then break end

            if flag:GetNVar("FlagOwner") == ply:getJobTable().category then
                notifyHasSent = true
                ply:SendSystemMessage("Территории", 'На склады поступила добыча с удерживаемых территорий.')
                ply:SendSystemMessage("Территории", 'Вы получили дополнительное жалование за захваченные вашей группировкой территории.')
            end
        end
    end
end

hook.Add( "InitPostEntity", "SpawnFlagsAndStartTimerForHoldingAndGiveRewards", function()
    SpawnFlags()
    --timer.Create( "HoldingTerritoriesTick", 600, 0, HoldingTerritories )
end)