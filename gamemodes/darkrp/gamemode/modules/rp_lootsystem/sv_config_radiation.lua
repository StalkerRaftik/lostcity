local RadiationRespawnTimer = 15 -- in minutes
local EntsAmount = 2

rp.LootSystem = rp.LootSystem or {}
rp.LootSystem.Radiation = rp.LootSystem.Radiation or {}
rp.LootSystem.Radiation.Config = {
	Vector(-5279.634765625, -2942.9301757812, -123.96876525879),
	Vector(1464.5025634766, -2233.3525390625, 15.031234741211),
	Vector(-1214.3298339844, 1202.8134765625, 49.296493530273),
	Vector(-19.658067703247, 5949.337890625, 71.616878509521),
	Vector(5867.37890625, 5352.7915039062, 28.012027740479),
	Vector(11352.545898438, 853.24755859375, -88.96875),
	Vector(9147.123046875, -4153.5590820312, 23.03125),
	Vector(7708.1220703125, -13097.616210938, 37.031253814697),
	Vector(13330.794921875, -12611.059570312, 46.220558166504),
	Vector(1429.7775878906, -14241.721679688, -214.62289428711),
	Vector(-5261.0947265625, -7289.6630859375, 36.03125),
	Vector(-10501.5859375, -11907.372070312, -0.58721923828125),
	Vector(-11308.944335938, 3535.0029296875, 12.80729675293),
}


rp.LootSystem.Radiation.Ents = rp.LootSystem.Radiation.Ents or {}

function SpawnRadEnts()
    if not rp.LootSystem.Radiation.Config then return end

    for _, ent in pairs(rp.LootSystem.Radiation.Ents) do
        if IsValid(ent) then 
            ent:Remove()
            ent = nil
        end
    end

    for i = 1, EntsAmount do
	    local newrad = rp.LootSystem.Radiation.Config[math.random(1, #rp.LootSystem.Radiation.Config)]
	    local radent = ents.Create("rp_newradiation")
	    table.insert(rp.LootSystem.Radiation.Ents, radent)

	    if istable(newrad) then
		    radent:SetPos(newrad.pos)
		    radent:SetAngles(newrad.ang)
		else
			radent:SetPos(newrad)
		end
	    radent:Spawn()
	    local phys = radent:GetPhysicsObject()
	    if IsValid(phys) then
	        phys:EnableMotion(false)
	    end
	    constraint.RemoveAll(radent)
	end
end

timer.Create("rp.LootSystem.SpawnNewRadiation", 60 * RadiationRespawnTimer, 0, function()
    SpawnRadEnts()
end)

