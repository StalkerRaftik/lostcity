if (not SERVER) then return end

zlm = zlm or {}
zlm.f = zlm.f or {}
zlm.VehicleSpawns = zlm.VehicleSpawns or {}


util.AddNetworkString("zlm_NPCInterface_Open")
util.AddNetworkString("zlm_NPCInterface_Close")
util.AddNetworkString("zlm_NPCInterface_Buy")



function zlm.f.NPC_OpenInterface(NPC,ply)
    net.Start("zlm_NPCInterface_Open")
    net.WriteEntity(NPC)
    net.Send(ply)
end

function zlm.f.NPC_CloseInterface(ply)
    net.Start("zlm_NPCInterface_Close")
    net.Send(ply)
end

function zlm.f.NPC_Initialize(NPC)
    NPC:RefreshBuyRate()
    zlm.f.Add_BuyerNPC(NPC)
end

function zlm.f.NPC_USE(NPC, ply)
    if zlm.config.NPC.Interaction[team.GetName(ply:Team())] then
        zlm.f.NPC_OpenInterface(NPC,ply)
    else
        zlm.f.Notify(ply, zlm.language.General["WrongJob"], 1)
    end
end



net.Receive("zlm_NPCInterface_Buy", function(len,ply)
    if zlm.f.NW_Player_Timeout(ply) then return end

    local npc = net.ReadEntity()
    local pid = net.ReadInt(4)

    if IsValid(ply) and IsValid(npc) and pid then
        zlm.f.NPC_Buy(npc, ply,pid)
    end
end)

function zlm.f.NPC_Buy(NPC, ply,pid)


    // Check for spawn point
    local spawn = zlm.f.VehicleSpawn_FindFreeSpot(NPC:GetPos())

    if spawn == false then
        zlm.f.Notify(ply,zlm.language.General["NofreeVehicleSpawn"], 1)
        return
    end

    // Checks for cost
    local price = 0

    if pid == 1 then
        price = zlm.config.NPC.Shop["lawnmower"]

        if IsValid(ply.zlm_Tractor) then
            zlm.f.Notify(ply, zlm.language.General["YouallreadyownaLawnMower"], 1)
            return
        end

    elseif pid == 2 then
        price = zlm.config.NPC.Shop["trailer"]

        if IsValid(ply.zlm_Tractor_Trailer) then
            zlm.f.Notify(ply, zlm.language.General["YouallreadyownaTrailer"], 1)
            return
        end
    end

    if zlm.f.HasMoney(ply, price) == false then
        zlm.f.Notify(ply, zlm.language.General["NotEnoughMoney"] .. " " .. zlm.language.General["Cost"] .. ": " .. zlm.config.Currency .. price, 1)
        return
    end

    zlm.f.TakeMoney(ply, price)

    // Spawn vehicle
    zlm.f.SpawnVehicle(pid,spawn,ply)

    zlm.f.Notify(ply, zlm.language.General["VehiclePurchased"], 0)
end

function zlm.f.SpawnVehicle(pid,spawn,ply)
    local vClass
    local ang = spawn:GetAngles()

    if pid == 1 then
        vClass = "zlm_tractor"
        ang:RotateAroundAxis(ang:Up(),90)
    elseif pid == 2 then
        vClass = "zlm_tractor_trailer"
    end

    local spawnpos = spawn:GetPos() + spawn:GetUp() * 5

    local ent = ents.Create(vClass)
    ent:SetPos(spawnpos)
    ent:SetAngles(ang)
    ent:Spawn()
    ent:Activate()


    // Creates the Sell Effect
    --zlm.f.CreateEffectAtPos("zlm_sell", spawnpos)

    --local soundData = zlm.f.CatchSound("zlm_selling")
    --spawn:EmitSound(soundData.sound, soundData.lvl, soundData.pitch, soundData.volume, CHAN_STATIC)


    if pid == 1 then
        ply.zlm_Tractor = ent
    elseif pid == 2 then
        ply.zlm_Tractor_Trailer = ent
    end

    if vClass == "zlm_tractor_trailer" then
        local phys = ent:GetPhysicsObject()

        if IsValid(phys) then
            phys:Wake()
            phys:EnableMotion(false)
        end
    end


    --zlm.f.SetOwner(ent, ply)
    if ent:GetClass() == "zlm_tractor" and IsValid(ent.Vehicle) then
        ent.Vehicle.__WCDOwner = ply
	    ent.Vehicle.Locked = true
    end
end



///////////////////////////////////////
//////////// Vehicle Spawns ///////////
///////////////////////////////////////
function zlm.f.VehicleSpawn_SpotFree(_ents)
    local IsFree = true
    for k, v in pairs(_ents) do
        if IsValid(v) then
            local _class = v:GetClass()

            if _class == "zlm_tractor" or _class == "zlm_tractor_trailer" or _class == "zlm_corb"  then
                IsFree = false
                break
            end
        end
    end
    return IsFree
end

function zlm.f.VehicleSpawn_FindFreeSpot(npc_pos)
    if table.Count(zlm.VehicleSpawns) <= 0 then
        return false
    end

    local spot = false
    for k, v in pairs(zlm.VehicleSpawns) do
        if IsValid(v) and zlm.f.InDistance(v:GetPos(), npc_pos, 2000) then

            local _ents = ents.FindInSphere(v:GetPos(),100)
            local IsFree = zlm.f.VehicleSpawn_SpotFree(_ents)

            if IsFree then
                spot = v
                break
            else
                continue
            end
        end
    end
    return spot
end

concommand.Add( "zlm_save_vehiclespawn", function( ply, cmd, args )

    if IsValid(ply) and zlm.f.IsAdmin(ply) then
        zlm.f.Notify(ply, "Vehicle Spawns have been saved for the map " .. game.GetMap() .. "!", 0)
        zlm.f.Save_VehicleSpawns()
    end
end )

concommand.Add( "zlm_remove_vehiclespawn", function( ply, cmd, args )

    if IsValid(ply) and zlm.f.IsAdmin(ply) then
        zlm.f.Notify(ply, "Vehicle Spawns have been removed for the map " .. game.GetMap() .. "!", 0)
        zlm.f.Remove_VehicleSpawns()
    end
end )

function zlm.f.Save_VehicleSpawns()
    local data = {}

    for u, j in pairs(ents.FindByClass("zlm_spawn")) do
        table.insert(data, {
            pos = j:GetPos(),
            ang = j:GetAngles()
        })
    end

    if not file.Exists("zlm", "DATA") then
        file.CreateDir("zlm")
    end
    if table.Count(data) > 0 then
        file.Write("zlm/" .. string.lower(game.GetMap()) .. "_vehiclespawn" .. ".txt", util.TableToJSON(data))
    end
end

function zlm.f.Load_VehicleSpawns()
    if file.Exists("zlm/" .. string.lower(game.GetMap()) .. "_vehiclespawn" .. ".txt", "DATA") then
        local data = file.Read("zlm/" .. string.lower(game.GetMap()) .. "_vehiclespawn" .. ".txt", "DATA")
        data = util.JSONToTable(data)

        if data and table.Count(data) > 0 then
            for k, v in pairs(data) do
                local ent = ents.Create("zlm_spawn")
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

            print("[Zeros LawnMower] Finished loading Vehicle Spawns.")
        end
    else
        print("[Zeros LawnMower] No map data found for Vehicle Spawns. Please place some and do !savezlm to create the data.")
    end
end

function zlm.f.Remove_VehicleSpawns()
    if file.Exists("zlm/" .. string.lower(game.GetMap()) .. "_vehiclespawn" .. ".txt", "DATA") then
        file.Delete("zlm/" .. string.lower(game.GetMap()) .. "_vehiclespawn" .. ".txt")
    end

    for k, v in pairs(ents.FindByClass("zlm_spawn")) do
        if IsValid(v) then
            v:Remove()
        end
    end
end

hook.Add("InitPostEntity", "zlm_SpawnVehicleSpawns", zlm.f.Load_VehicleSpawns)
hook.Add("PostCleanupMap", "zlm_SpawnVehicleSpawnsPostCleanUp", zlm.f.Load_VehicleSpawns)

///////////////////////////////////////
///////////////////////////////////////
