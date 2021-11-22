rp.LootSystem = rp.LootSystem or {}
rp.LootSystem.CarSpawnSystem = {
    carTypes = {
        ["sim_fphys_bak_taxi"] = true,
        ["sim_fphys_bak_suv"] = true,
        ["sim_fphys_bak_gcpd_nova"] = true,
        ["sim_fphys_bak_pickup"] = true,
        ["sim_fphys_bak_wagon"] = true,
    },
    poses = {
        {
            pos = Vector(-10573.819336, -11860.996094, -13.415662),
            ang = Angle(-9.563, 161.861, 6.052),
        },
        {
            pos = Vector(8278.836914, -14049.953125, -9.162775),
            ang = Angle(0.097, 82.310, -0.325),
        },
        {
            pos = Vector(13941.940430, -11904.212891, -16.086178),
            ang = Angle(0.328, 90.185, 2.134),
        },
        {
            pos = Vector(9897.359375, -4185.896484, 6.210701),
            ang = Angle(0.283, 90.863, -5.396),
        },
        {
            pos = Vector(10776.916992, -2550.736328, -82.065979),
            ang = Angle(-11.479, 94.983, -1.048),
        },
        {
            pos = Vector(10295.582031, -2586.781006, 127.050446),
            ang = Angle(0.237, -179.665, -0.026),
        },
        {
            pos = Vector(11666.623047, -2072.847900, 295.017242),
            ang = Angle(0.270, 0.194, 0.003),            
        },
        {
            pos = Vector(11648.621094, -1543.974854, 631.041077),
            ang = Angle(0.232, -2.553, -0.042),
        },
        {
            pos = Vector(2196.832764, -157.773239, -4.946342),
            ang = Angle(0.220, -87.495, -0.026),            
        },
        {
            pos = Vector(7203.681641, 3817.652100, -4.870214),
            ang = Angle(0.615, -2.802, 0.522),            
        },
        {
            pos = Vector(-1324.161987, 5472.029297, -4.846438),
            ang = Angle(0.300, -176.817, 0.045),            
        },
        {
            pos = Vector(-8706.817383, 4133.251953, 7.968650),
            ang = Angle(-0.586, 112.168, -0.274),            
        },
        {
            pos = Vector(-12939.065430, 8086.387207, 84.886024),
            ang = Angle(-0.085, -94.470, -1.433),                       
        },
        {
            pos = Vector(-4848.587891, -1590.012817, 15.989633),
            ang = Angle(0.060, 89.937, 0.250),            
        },
    },
}


timer.Create("rp.LootSystem.RespawnCars", 600, 0, function()
    if not IsValid(rp.LootSystem.CarSpawnSystem.Car) then
        SpawnCar()
    end
end)

function SpawnCar()
    if IsValid(rp.LootSystem.CarSpawnSystem.Car) then return end

    local carpos = rp.LootSystem.CarSpawnSystem.poses[math.random(1, #rp.LootSystem.CarSpawnSystem.poses)]
    local _, carclass = table.Random(rp.LootSystem.CarSpawnSystem.carTypes)
    car = simfphys.SpawnVehicleSimple( carclass, carpos.pos + Vector( 0, 0, 15 ), carpos.ang );
	car.simfphys = true;
	car.simfphysClass = carclass;
    car:SetFuel(5)
    
    rp.LootSystem.CarSpawnSystem.Car = car
end

hook.Add( "InitPostEntity", "rp.LootSystem.CarInitSpawn", function()
    SpawnCar()
end)