
AddCSLuaFile()

local light_table = {
	L_HeadLampPos = Vector(29,98,26),
	L_HeadLampAng = Angle(0,90,0),

	R_HeadLampPos = Vector(-29,98,26),
	R_HeadLampAng = Angle(0,90,0),

	L_RearLampPos = Vector(36,-96,26),
	L_RearLampAng = Angle(0,-90,0),

	R_RearLampPos = Vector(-36,-96,26),
	R_RearLampAng = Angle(0,-90,0),
	
	Headlight_sprites = { 
		Vector(29,98,26),
		Vector(-29,98,26),
	},
	Headlamp_sprites = { 
		Vector(22,98,26),
		Vector(-22,98,26),
	},
	FogLight_sprites = {
		Vector(30,99,15),
		Vector(-30,99,15),
	},
	Rearlight_sprites = {
		Vector(36,-96,27),
		Vector(-36,-96,27),
		Vector(36,-96,27),
		Vector(-36,-96,27),
	},
	Brakelight_sprites = {
		Vector(36,-96,27),
		Vector(-36,-96,27),
		Vector(36,-96,27),
		Vector(-36,-96,27),
	},
	Reverselight_sprites = {
		Vector(7,-100,19),
		Vector(-7,-100,19),
	},
	Turnsignal_sprites = {
		Left = {
		Vector(-37,93,20.5),
		Vector(-37,91,20.5),
		Vector(-37,89,20.5),
		},
		Right = {
		Vector(37,93,20.5),
		Vector(37,91,20.5),
		Vector(37,89,20.5),
		},
	}
}
list.Set( "simfphys_lights", "BAK_wagon", light_table)

local V = {
	Name = "Эстейт Вегон",
	Model = "models/bak_wagon/bak_wagon_rigged.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "LC Vehicles",
	SpawnAngleOffset = 0,
	
	Members = {
		Mass = 1550,
		MaxHealth = 5000,
		
		CustomMassCenter = Vector(0,0,5),
		EnginePos = Vector(0,80,10),
		
		SpeedoMax = 70,
		
		LightsTable = "BAK_wagon",
		
		CustomWheels = true,
		CustomSuspensionTravel = 15,
		
		CustomWheelModel = "models/bak_wagon/wagon_wheel.mdl",
	    CustomWheelPosFL = Vector(-34,70,20),
		CustomWheelPosFR = Vector(34,70,20),
		CustomWheelPosRL = Vector(-34,-50,20),	
		CustomWheelPosRR = Vector(34,-50,20),
		CustomWheelAngleOffset = Angle(0,-90,0),
		
		CustomSteerAngle = 30,
		
		SeatOffset = Vector(5,-15,45),
        SeatPitch = 0,
		SeatYaw = 0,

		PassengerSeats = {
			{
				pos = Vector(15,5,10),
				ang = Angle(0,0,0)
			},
			{
				pos = Vector(15,-23,10),
				ang = Angle(0,0,0)
			},
			{
				pos = Vector(0,-23,10),
				ang = Angle(0,0,0)
			},
			{
				pos = Vector(-15,-23,10),
				ang = Angle(0,0,0)
			},
		},
				
		ExhaustPositions = {
			{
				pos = Vector(-29,-101,14),
				ang = Angle(90,-90,0)
			},
		},
		
		FuelFillPos = Vector(-37,-65,30),
		FuelType = FUELTYPE_PETROL,
		FuelTankSize = 60,
		
		StrengthenSuspension = false,
		
		FrontHeight = 12,
		FrontConstant = 25000,
		FrontDamping = 1500,
		FrontRelativeDamping = 1500,
		
		RearHeight = 12,
		RearConstant = 25000,
		RearDamping = 1500,
		RearRelativeDamping = 1500,
		
		FastSteeringAngle = 30,
		SteeringFadeFastSpeed = 100,
		
		TurnSpeed = 3,
		
		MaxGrip = 45,
		Efficiency = 0.90,
		GripOffset = -1,
		BrakePower = 15,
		
		IdleRPM = 800, -- Банальная мощность двигателя
		LimitRPM = 1700, -- Максимальная скорость 
		PeakTorque = 180, -- Мощность разгона
		PowerbandStart = 1000, -- Начало переключения передач
		PowerbandEnd = 1600, -- Предел переключения передач
		Turbocharged = false,
		Supercharged = false,
		
		PowerBias = 1,
		
		EngineSoundPreset = 10,
		
		Sound_Idle = "simulated_vehicles/generic4/generic4_idle.wav",
		Sound_IdlePitch = 1.0,
		
		Sound_Mid = "simulated_vehicles/misc/v8high2.wav",
		Sound_MidPitch = 0.9,
		Sound_MidVolume = 3.0,
		Sound_MidFadeOutRPMpercent = 70,		-- at wich percentage of limitrpm the sound fades out
		Sound_MidFadeOutRate = 0.34,                    --how fast it fades out   0 = instant       1 = never
		
		Sound_High = "simulated_vehicles/jeep/jeep_mid.wav",
		Sound_HighPitch = 0.75,
		Sound_HighVolume = 5.0,
		Sound_HighFadeInRPMpercent = 20,
		Sound_HighFadeInRate = 0.44,
		
		Sound_Throttle = "",		-- mutes the default throttle sound
		Sound_ThrottlePitch = 0,
		Sound_ThrottleVolume = 0,
		
		snd_horn = "simulated_vehicles/horn_3.wav",
		
		DifferentialGear = 0.60,
		Gears = {-0.15,0,0.11,0.17,0.32,0.39, 0.46, 0.53}
	}
}
list.Set( "simfphys_vehicles", "sim_fphys_bak_wagon", V )