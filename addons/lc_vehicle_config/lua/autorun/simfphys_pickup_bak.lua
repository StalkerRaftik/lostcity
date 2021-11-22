
AddCSLuaFile()

local light_table = {
	L_HeadLampPos = Vector(29,97,29),
	L_HeadLampAng = Angle(0,90,0),

	R_HeadLampPos = Vector(-29,97,29),
	R_HeadLampAng = Angle(0,90,0),

	L_RearLampPos = Vector(27,-104,29),
	L_RearLampAng = Angle(0,-90,0),

	R_RearLampPos = Vector(-27,-104,29),
	R_RearLampAng = Angle(0,-90,0),
	
	Headlight_sprites = { 
		Vector(25,86,29),
		Vector(-25,86,29),
	},
	Headlamp_sprites = { 
		Vector(25,86,29),
		Vector(-25,86,29),
	},
	FogLight_sprites = {
		Vector(25,86,29),
		Vector(-25,86,29),
	},
	Rearlight_sprites = {
		Vector(32.5,-107,31.5),
		Vector(-32.5,-107,31.5),
	},
	Brakelight_sprites = {
		Vector(32.5,-107,31.5),
		Vector(-32.5,-107,31.5),
	},
	Reverselight_sprites = {
		Vector(8,-107,20),
		Vector(-8,-107,20),
	},
	Turnsignal_sprites = {
		Left = {
		Vector(-26,88,18),
		
		Vector(-32.5,-109,40.5),
		},
		Right = {
		Vector(26,88,18),
		
		Vector(32.5,-109,40.5),
		},
	},
}
list.Set( "simfphys_lights", "BAK_pickup", light_table)

local V = {
	Name = "Шевроле 'Эль Камино'",
	Model = "models/bak_pickup/bak_pickup_rigged.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "LC Vehicles",
	SpawnAngleOffset = 0,
	
	Members = {
		Mass = 1380,
		MaxHealth = 5000,
		
		CustomMassCenter = Vector(0,0,5),
		EnginePos = Vector(0,70,10),
		
		SpeedoMax = 140,
		
		LightsTable = "BAK_pickup",
		
		CustomWheels = true,
		CustomSuspensionTravel = 15,
		
		CustomWheelModel = "models/bak_pickup/pickup_wheel.mdl",
	    CustomWheelPosFL = Vector(-33.5,59,16),
		CustomWheelPosFR = Vector(33.5,59,16),
		CustomWheelPosRL = Vector(-33.5,-60,16),	
		CustomWheelPosRR = Vector(33.5,-60,16),
		CustomWheelAngleOffset = Angle(0,-90,0),
		
		CustomSteerAngle = 30,
		
		SeatOffset = Vector(-6,-15,47),
        SeatPitch = 0,
		SeatYaw = 0,

		PassengerSeats = {
			{
				pos = Vector(17,-5,12),
				ang = Angle(0,0,0)
			},
		},
				
		ExhaustPositions = {
			{
				pos = Vector(-27,-110,14),
				ang = Angle(-90,90,0)
			},
		},
		
		FuelFillPos = Vector(-35,-22,32),
		FuelType = FUELTYPE_PETROL,
		FuelTankSize = 65,
		
		StrengthenSuspension = false,
		
		FrontHeight = 13,
		FrontConstant = 16000,
		FrontDamping = 1000,
		FrontRelativeDamping = 1000,
		
		RearHeight = 13,
		RearConstant = 17000,
		RearDamping = 1000,
		RearRelativeDamping = 1000,
		
		FastSteeringAngle = 30,
		SteeringFadeFastSpeed = 185,
		
		TurnSpeed = 2,
		
		MaxGrip = 45,
		Efficiency = 0.90,
		GripOffset = -1,
		BrakePower = 15,
		
		IdleRPM = 700, -- Банальная мощность двигателя
		LimitRPM = 2000, -- Максимальная скорость 
		PeakTorque = 180, -- Мощность разгона
		PowerbandStart = 1000, -- Начало переключения передач
		PowerbandEnd = 1800, -- Предел переключения передач
		Turbocharged = false,
		Supercharged = false,
		
		PowerBias = 1,
		
		EngineSoundPreset = 0,
		
		Sound_Idle = "simulated_vehicles/jeep/jeep_idle.wav",
		Sound_IdlePitch = 1.0,
		
		Sound_Mid = "simulated_vehicles/generic2/generic2_idle.wav",
		Sound_MidPitch = 1.8,
		Sound_MidVolume = 3.0,
		Sound_MidFadeOutRPMpercent = 70,		-- at wich percentage of limitrpm the sound fades out
		Sound_MidFadeOutRate = 0.34,                    --how fast it fades out   0 = instant       1 = never
		
		Sound_High = "simulated_vehicles/jeep/jeep_mid.wav",
		Sound_HighPitch = 0.8,
		Sound_HighVolume = 5.0,
		Sound_HighFadeInRPMpercent = 10,
		Sound_HighFadeInRate = 0.44,
		
		Sound_Throttle = "",		-- mutes the default throttle sound
		Sound_ThrottlePitch = 0,
		Sound_ThrottleVolume = 0,
		
		snd_horn = "simulated_vehicles/horn_3.wav",
		
		DifferentialGear = 0.60,
		Gears = {-0.15,0,0.19,0.28,0.36,0.43, 0.49, 0.56}
	}
}
list.Set( "simfphys_vehicles", "sim_fphys_bak_pickup", V )