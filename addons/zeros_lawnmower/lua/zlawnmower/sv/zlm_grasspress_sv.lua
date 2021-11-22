if (not SERVER) then return end
zlm = zlm or {}
zlm.f = zlm.f or {}

function zlm.f.AddGrass(grasspress, amount)
    grasspress:SetGrassCount(grasspress:GetGrassCount() + amount)
    zlm.f.debug("AddGrass: " .. grasspress:GetGrassCount())
    if zlm.f.GrassPress_RollCountCheck(grasspress) then
        zlm.f.GrassPress_ProductionCheck(grasspress)
    end
end

function zlm.f.GrassPress_Use(grasspress, ply)
    if grasspress.IsSpawningRoll then return end

    if grasspress:EnableButton(ply) then

        if zlm.f.GrassPress_RollCountCheck(grasspress) == false then
            zlm.f.Notify(ply, zlm.language.General["GrassRollLimitReached"], 1)
            return
        end

        grasspress:SetIsRunning(not grasspress:GetIsRunning())

        if grasspress:GetIsRunning() then
            -- Start Machine
            zlm.f.GrassPress_ProductionCheck(grasspress)

        else
            -- Stop Machine
            zlm.f.GrassPress_StopMachine(grasspress)
        end
    end

    if zlm.config.GrassPress.Upgrades.Enabled and grasspress:UpgradButton(ply) then
        zlm.f.GrassPress_Upgrade(grasspress, ply)
    end
end

function zlm.f.GrassPress_ProductionCheck(grasspress)
    if grasspress:GetIsRunning() == false then return end
    local grassStorage = grasspress:GetGrassCount()

    if grasspress:GetProgressState() == 0 then
        if grassStorage >= zlm.config.GrassPress.Production_Amount then
            zlm.f.GrassPress_Produce_GrassRoll(grasspress)
            zlm.f.debug("Starting Production")
        else
            zlm.f.debug("Not enough Grass!")
        end
    else
        zlm.f.debug("Machine is Busy!")
    end
end

function zlm.f.GrassPress_Produce_GrassRoll(grasspress)
    -- Start Inserting Grass
    grasspress:SetProgressState(1)
    zlm.f.debug("Start Inserting Grass")

    local p_Time
    if zlm.config.GrassPress.Upgrades.Enabled then
        //p_Time = zlm.config.GrassPress.Production_Time - ((zlm.config.GrassPress.Production_Time / zlm.config.GrassPress.Upgrades.Count) * grasspress:GetUpgradeLevel())
        p_Time = zlm.config.GrassPress.Production_Time - zlm.config.GrassPress.Production_TimeLimit
        p_Time = (p_Time / zlm.config.GrassPress.Upgrades.Count) * grasspress:GetUpgradeLevel()
        p_Time =  zlm.config.GrassPress.Production_Time - p_Time
        p_Time = math.Clamp(math.Round(p_Time), zlm.config.GrassPress.Production_TimeLimit, zlm.config.GrassPress.Production_Time)
    else
        p_Time = zlm.config.GrassPress.Production_Time
    end

    grasspress:SetProduction_TimeStamp(CurTime() + p_Time)

    timer.Create("zlm_grasspress_producetimer_" .. grasspress:EntIndex(), p_Time, 1, function()

        if IsValid(grasspress) then

            grasspress:SetGrassCount(grasspress:GetGrassCount() - zlm.config.GrassPress.Production_Amount)

            -- Release Grass Roll
            grasspress:SetProgressState(2)

            zlm.f.debug("Release Grass Roll")
            grasspress.IsSpawningRoll = true

            grasspress:SetProduction_TimeStamp(-1)

            timer.Simple(2.33, function()
                if IsValid(grasspress) then

                    -- Spawn Grass Roll
                    zlm.f.GrassPress_SpawnGrassRoll(grasspress)
                    grasspress.IsSpawningRoll = false
                end
            end)
        end
    end)
end

function zlm.f.GrassPress_StopMachine(grasspress)
    if timer.Exists("zlm_grasspress_producetimer_" .. grasspress:EntIndex()) then
        timer.Remove("zlm_grasspress_producetimer_" .. grasspress:EntIndex())
    end
    grasspress:SetProduction_TimeStamp(-1)
    grasspress:SetProgressState(0)
end

-- Checks if the GrassPress is allowed to produce another grassroll
function zlm.f.GrassPress_RollCountCheck(grasspress)

    local count = 0

    for k, v in pairs(grasspress.ProducedRolls) do
        if IsValid(v) then
            count = count + 1
        end
    end

    if count < zlm.config.GrassPress.GrassRoll_Limit then
        return true
    else
        return false
    end
end

function zlm.f.GrassPress_SpawnGrassRoll(grasspress)
    zlm.f.debug("SpawnGrassRoll")

    local ent = ents.Create("zlm_grassroll")
    ent:SetPos(grasspress:GetPos() - grasspress:GetForward() * 80 + grasspress:GetUp() * 40)
    ent:Spawn()
    ent:Activate()

    if math.random(1, 3) == 1 then
        local rand = math.random(1,3)
        local seed
        if rand == 1 then
            seed = "fs_lemon_seeds"
        elseif rand == 2 then
            seed = "fs_cabbage_seeds"
        else
            seed = "fs_apple_seeds"
        end

        local ent = ents.Create(seed)
        ent:SetPos(grasspress:GetPos() - grasspress:GetForward() * 80 + grasspress:GetUp() * 40)
        ent:Spawn()
    end

    table.insert(grasspress.ProducedRolls,ent)

    zlm.f.GrassPress_StopMachine(grasspress)

    if zlm.f.GrassPress_RollCountCheck(grasspress) then
        zlm.f.GrassPress_ProductionCheck(grasspress)
    else
        grasspress:SetIsRunning(false)
    end
end



function zlm.f.GrassPress_Upgrade(grasspress, ply)
    if table.Count(zlm.config.GrassPress.Upgrades.Ranks) > 0 and not table.HasValue(zlm.config.GrassPress.Upgrades.Ranks, ply:GetUserGroup()) then
        return
    end

    if grasspress:GetUpgradeLevel() >= zlm.config.GrassPress.Upgrades.Count then return end

    if CurTime() < grasspress:GetUCooldDown() then return end

    if not zlm.f.HasMoney(ply, zlm.config.GrassPress.Upgrades.Price) then
        zlm.f.Notify(ply, zlm.language.General["NotEnoughMoney"], 1)
        return
    end

    zlm.f.TakeMoney(ply, zlm.config.GrassPress.Upgrades.Price)

    local soundData = zlm.f.CatchSound("zlm_selling")
    grasspress:EmitSound(soundData.sound, soundData.lvl, soundData.pitch, soundData.volume, CHAN_STATIC)

    zlm.f.Machine_LevelUp(grasspress)

    zlm.f.Notify(ply, zlm.language.General["GrassPressSpeedIncreased"], 0)
    zlm.f.Notify(ply, "-" .. zlm.config.Currency .. zlm.config.GrassPress.Upgrades.Price, 0)

    if grasspress:GetUpgradeLevel() < zlm.config.GrassPress.Upgrades.Count then
        grasspress:SetUCooldDown(CurTime() + zlm.config.GrassPress.Upgrades.Cooldown)
    end

    -- If the machine is running then we restart it
    zlm.f.GrassPress_StopMachine(grasspress)
    zlm.f.GrassPress_ProductionCheck(grasspress)
end

function zlm.f.Machine_LevelUp(grasspress)
    grasspress:SetUpgradeLevel(grasspress:GetUpgradeLevel() + 1)
end




-- Global GrassPress
concommand.Add( "zlm_save_grasspress", function( ply, cmd, args )

    if IsValid(ply) and zlm.f.IsAdmin(ply) then
        zlm.f.Notify(ply, "GrassPress entities have been saved for the map " .. game.GetMap() .. "!", 0)
        zlm.f.Save_GrassPress()
    end
end )

concommand.Add( "zlm_remove_grasspress", function( ply, cmd, args )

    if IsValid(ply) and zlm.f.IsAdmin(ply) then
        zlm.f.Notify(ply, "GrassPress entities have been removed for the map " .. game.GetMap() .. "!", 0)
        zlm.f.Remove_GrassPress()
    end
end )

function zlm.f.Save_GrassPress()
    local data = {}

    for u, j in pairs(ents.FindByClass("zlm_grasspress")) do
        table.insert(data, {
            pos = j:GetPos(),
            ang = j:GetAngles()
        })
    end

    if not file.Exists("zlm", "DATA") then
        file.CreateDir("zlm")
    end
    if table.Count(data) > 0 then
        file.Write("zlm/" .. string.lower(game.GetMap()) .. "_grasspress" .. ".txt", util.TableToJSON(data))
    end
end

function zlm.f.Load_GrassPress()
    if file.Exists("zlm/" .. string.lower(game.GetMap()) .. "_grasspress" .. ".txt", "DATA") then
        local data = file.Read("zlm/" .. string.lower(game.GetMap()) .. "_grasspress" .. ".txt", "DATA")
        data = util.JSONToTable(data)

        if data and table.Count(data) > 0 then
            for k, v in pairs(data) do
                local ent = ents.Create("zlm_grasspress")
                ent:SetPos(v.pos)
                ent:SetAngles(v.ang)
                ent:Spawn()
                ent:Activate()

                local phys = ent:GetPhysicsObject()

                if (phys:IsValid()) then
                    phys:Wake()
                    phys:EnableMotion(false)
                end
            end

            print("[Zeros LawnMower] Finished loading GrassPress Entities.")
        end
    else
        print("[Zeros LawnMower] No map data found for GrassPress entities. Please place some and do !savezlm to create the data.")
    end
end

function zlm.f.Remove_GrassPress()
    if file.Exists("zlm/" .. string.lower(game.GetMap()) .. "_grasspress" .. ".txt", "DATA") then
        file.Delete("zlm/" .. string.lower(game.GetMap()) .. "_grasspress" .. ".txt")
    end

    for k, v in pairs(ents.FindByClass("zlm_grasspress")) do
        if IsValid(v) then
            v:Remove()
        end
    end
end

hook.Add("InitPostEntity", "zlm_SpawnGrassPress", zlm.f.Load_GrassPress)
hook.Add("PostCleanupMap", "zlm_SpawnGrassPressPostCleanUp", zlm.f.Load_GrassPress)
