
AddCSLuaFile()

local light_table = {
	L_HeadLampPos = Vector(29,96,34),
	L_HeadLampAng = Angle(0,90,0),

	R_HeadLampPos = Vector(-29,96,34),
	R_HeadLampAng = Angle(0,90,0),

	L_RearLampPos = Vector(36,-93,35),
	L_RearLampAng = Angle(0,-90,0),

	R_RearLampPos = Vector(-36,-93,35),
	R_RearLampAng = Angle(0,-90,0),
	
	Headlight_sprites = { 
		Vector(29,96,34),
		Vector(-29,96,34),
	},
	Headlamp_sprites = { 
		Vector(22,96,34),
		Vector(-22,96,34),
	},
	FogLight_sprites = {
		Vector(29,96,34),
		Vector(-29,96,34),
	},
	Rearlight_sprites = {
		Vector(36,-93,35),
		Vector(-36,-93,35),
		Vector(36,-93,35),
		Vector(-36,-93,35),
	},
	Brakelight_sprites = {
		Vector(36,-93,35),
		Vector(-36,-93,35),
		Vector(36,-93,35),
		Vector(-36,-93,35),
	},
	Reverselight_sprites = {
		Vector(8,-95,25),
		Vector(-8,-95,25),
	},
	Turnsignal_sprites = {
		Left = {
		Vector(-37,91,28),
		Vector(-37,89,28),
		Vector(-37,87,28),
		},
		Right = {
		Vector(37,91,28),
		Vector(37,89,28),
		Vector(37,87,28),
		},
	}
}
list.Set( "simfphys_lights", "BAK_suv", light_table)

local V = {
	Name = "Джип 'Вэгонер'",
	Model = "models/bak_suv/bak_suv_rigged.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "LC Vehicles",
	SpawnAngleOffset = 0,
	
	Members = {
		Mass = 1650,
		MaxHealth = 5400,
		
		CustomMassCenter = Vector(0,0,5),
		EnginePos = Vector(0,60,10),
		
		SpeedoMax = 140,
		
		LightsTable = "BAK_suv",
		
		CustomWheels = true,
		CustomSuspensionTravel = 15,
		
		CustomWheelModel = "models/chevrolet_nova_gcpd/nova_wheel.mdl",
	    CustomWheelPosFL = Vector(-34,67,20),
		CustomWheelPosFR = Vector(34,67,20),
		CustomWheelPosRL = Vector(-34,-53,20),	
		CustomWheelPosRR = Vector(34,-53,20),
		CustomWheelAngleOffset = Angle(0,90,0),
		
		CustomSteerAngle = 30,
		
		SeatOffset = Vector(0,-15,55),
        SeatPitch = 0,
		SeatYaw = 0,

		PassengerSeats = {
			{
				pos = Vector(15,2,20),
				ang = Angle(0,0,0)
			},
			{
				pos = Vector(15,-28,20),
				ang = Angle(0,0,0)
			},
			{
				pos = Vector(0,-28,20),
				ang = Angle(0,0,0)
			},
			{
				pos = Vector(-15,-28,20),
				ang = Angle(0,0,0)
			},
		},
				
		ExhaustPositions = {
			{
				pos = Vector(-26,-98,20),
				ang = Angle(-90,90,0)
			},
		},
		
		FuelFillPos = Vector(-37,-53,45),
		FuelType = FUELTYPE_DIESEL,
		FuelTankSize = 70,
		
		StrengthenSuspension = false,
		
		FrontHeight = 12,
		FrontConstant = 28000,
		FrontDamping = 1500,
		FrontRelativeDamping = 1500,
		
		RearHeight = 12,
		RearConstant = 28000,
		RearDamping = 1500,
		RearRelativeDamping = 1500,
		
		FastSteeringAngle = 30,
		SteeringFadeFastSpeed = 185,
		
		TurnSpeed = 4,
		
		MaxGrip = 45,
		Efficiency = 0.95,
		GripOffset = -1,
		BrakePower = 15,
		
		IdleRPM = 500, -- Банальная мощность двигателя
		LimitRPM = 2000, -- Максимальная скорость 
		PeakTorque = 200, -- Мощность разгона
		PowerbandStart = 1000, -- Начало переключения передач
		PowerbandEnd = 1800, -- Предел переключения передач
		Turbocharged = false,
		Supercharged = false,
		
		PowerBias = 0,
		
		EngineSoundPreset = 0,
		
		Sound_Idle = "simulated_vehicles/alfaromeo/alfons_idle.wav",
		Sound_IdlePitch = 0.8,
		
		Sound_Mid = "simulated_vehicles/alfaromeo/alfaromeo_low.wav",
		Sound_MidPitch = 0.8,
		Sound_MidVolume = 3.0,
		Sound_MidFadeOutRPMpercent = 70,		-- at wich percentage of limitrpm the sound fades out
		Sound_MidFadeOutRate = 0.34,                    --how fast it fades out   0 = instant       1 = never
		
		Sound_High = "simulated_vehicles/misc/m50.wav",
		Sound_HighPitch = 0.9,
		Sound_HighVolume = 2.0,
		Sound_HighFadeInRPMpercent = 15,
		Sound_HighFadeInRate = 0.44,
		
		Sound_Throttle = "",		-- mutes the default throttle sound
		Sound_ThrottlePitch = 0,
		Sound_ThrottleVolume = 0,
		
		snd_horn = "simulated_vehicles/horn_3.wav",
		
		DifferentialGear = 0.60,
		Gears = {-0.15,0,0.16,0.28,0.36,0.43, 0.49, 0.56}
	}
}
list.Set( "simfphys_vehicles", "sim_fphys_bak_suv", V )