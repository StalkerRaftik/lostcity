rp.airdrop = rp.airdrop or {}
local airdrop = rp.airdrop

local locations = {
    Vector(-9468, 8689, -24),    -- Original
    Vector(-9468, 8689, -24), -- Military
    Vector(-9468, 8689, -24),    -- Airfield
    Vector(-9468, 8689, -24),  -- Pipes by APC
    Vector(-9468, 8689, -24),  -- College / electrical tower
    Vector(-9468, 8689, -24),      -- School roof
    Vector(-9468, 8689, -24),   -- Swamp ship
}

local centerX -- X-coordinate center of the map.
local centerY -- Y-coordinate center of the map
local angQ4   -- Angle for quadrant iv corner.
local angQ1   -- Angle for quadrant i corner.
local angQ2   -- Angle for quadrant ii corner.
local angQ3   -- Angle for quadrant iii corner.

--------------------------------------------------------------------------------

--[[ Get a map boundary coordinate by projecting a line from the origin of the
     map towards the map's boundaries.
     @param radians - Direction from the center of the map.
     @returns point - The map boundary coordinate. ]]
function airdrop.Point(radians)
    local altitude = 50
    local xMin = Vector(-13123.96875, -12309.2265625, -545.69677734375)
    local xMax = Vector(-13474.018554688, 13389.024414063, 115.57395172119)
    local yMin = Vector(13537.749023438, 13352.88671875, 175.03584289551)
    local yMax = Vector(14603.96875, -14461.814453125, 2308.8103027344)

    radians = radians % (math.pi*2)

    -- Get the point on the unit circle.
    local unitX = math.cos(radians)
    local unitY = math.sin(radians)

    -- Calculate the map center and unit angles for each map corner.
    -- This only needs to be done once.
    if not centerX then
        centerX = (xMin + xMax)/2
        centerY = (yMin + yMax)/2

        angQ1 = math.atan((yMax-centerY)/(xMax-centerX))
        angQ2 = math.atan((yMax-centerY)/(xMin-centerX)) + math.pi
        angQ3 = math.atan((yMin-centerY)/(xMin-centerX)) + math.pi
        angQ4 = math.atan((yMin-centerY)/(xMax-centerX)) + math.pi*2
    end

    local ratio
    print(angQ1)
    if radians >= angQ1 and radians <= angQ2 then
        -- Positive Y
        ratio = yMax/unitY
    elseif radians >= angQ2 and radians <= angQ3 then
        -- Negative X
        ratio = xMin/unitX
    elseif radians >= angQ3 and radians <= angQ4 then
        -- Negative Y
        ratio = yMin/unitY
    else
        -- Positive X
        ratio = xMax/unitX
    end

    -- Scale point to be on the map boundary edge.
    local x = unitX * ratio
    local y = unitY * ratio

    -- Clamp just to be safe.
    x = math.Clamp(x, xMin, xMax)
    y = math.Clamp(y, yMin, yMax)

    return Vector(x, y, altitude)
end

--[[ Construct a path across the map using two angles.
     @param radiansx - Start angle.
     @param radiansy - End angle.
     @returns pointx, pointy - The start and end coordinates for the path. ]]
function airdrop.Path(radiansx, radiansy)
    return airdrop.Point(radiansx), airdrop.Point(radiansy)
end

--[[ Construct a random path across the map.
     @returns pointx, pointy - The start and end coordinates for the path. ]]
function airdrop.RandomPath()
    local a = math.random() * 2*math.pi
    local b = a + 110 + math.random()*140
    return airdrop.Path(a, b)
end

--------------------------------------------------------------------------------

-- For testing: starts at bunker and crosses through town.
-- rp.CallAirdrop(Vector(449, -14386, 4000), Vector(641, 11297, 4000))
function airdrop.SpawnPlane(from, to)
    if not from then
        from, to = airdrop.RandomPath()
    end

    local ent = ents.Create("rp_airdrop_plane")
    ent:Spawn()
    ent:SetCourse(from, to)

    rp.GlobalChat(CHAT_NONE, Color(255,0,0) ,"[Общая частота] ", Color(128, 128, 128), "Неизвестный", Color(255,255,255), ": В городе замечен вертолёт с гуманитарной помощью, найдите его, но будьте осторожны!")
end

function airdrop.SpawnPackage(plane)
    local package = ents.Create("loot_container")
    package:SetModel('models/props/de_prodigy/ammo_can_01.mdl')
    package:SetPos(plane:GetPos())
    package:Spawn()
    package:SetModel('models/props/de_prodigy/ammo_can_01.mdl')    
    package:AddItem("weapon", "tfa_pkm")
    package:AddItem("hats", "pbf", 2)

    for i=1, 5 do  
        local flare = ents.Create("obj_vj_flareround")
        flare:SetPos(package:GetPos() - Vector(math.random(100,200),math.random(100,200),50))
        -- flare:SetParent(package)
        flare:Spawn()
        flare.airdroplive = CurTime() + 900 
        local physobj = flare:GetPhysicsObject()
        if IsValid(physobj) then
            physobj:Wake()
        end            
        constraint.NoCollide(flare, plane, 0, 0)
        constraint.NoCollide(plane, flare, 0, 0)
    end


    local flare = ents.Create("obj_vj_flareround")
    flare:SetPos(package:GetPos())
    flare:SetParent(package)
    flare:Spawn()
    flare.airdroplive = CurTime() + 900 
    constraint.NoCollide(flare, plane, 0, 0)
    constraint.NoCollide(plane, flare, 0, 0)

    constraint.NoCollide(package, plane, 0, 0)

    local physobj = package:GetPhysicsObject()
    if IsValid(physobj) then
        physobj:Wake()
    end
end

--------------------------------------------------------------------------------

local nextThink
local lastAirdrop
function airdrop.Think()
    if nextThink and CurTime() < nextThink then return end
    nextThink = CurTime() + 60

    if player.GetCount() < rp.airdrop_minplayers:GetFloat() then
        return
    end

    local interval = rp.airdrop_interval:GetFloat()
    if lastAirdrop and CurTime() < lastAirdrop + interval then return end

    local ratePerMinute = rp.airdrop_rateperhour:GetFloat() / 60
    if math.Rand(0, 1) > ratePerMinute then return end

    lastAirdrop = CurTime()
    airdrop.SpawnPlane()
end

--------------------------------------------------------------------------------

concommand.Add("rp_airdrop_spawn", function(ply)
    if not ply:IsSuperAdmin() then return end
    airdrop.SpawnPlane()
    ply:PrintMessage(HUD_PRINTCONSOLE, "Airdrop spawned.")
    ply:Log("Spawned an airdrop.")
end)

timer.Create("CheckForAirdropFlares", 300, 0, function()
    for k, v in pairs(ents.GetAll()) do
        if v.airdroplive and v.airdroplive >= CurTime() then
            v:Remove()
        end
    end
end)
        
   