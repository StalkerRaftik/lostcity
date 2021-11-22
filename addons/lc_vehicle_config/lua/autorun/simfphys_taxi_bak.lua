
AddCSLuaFile()

local light_table = {
	L_HeadLampPos = Vector(23,90,35),
	L_HeadLampAng = Angle(0,90,0),

	R_HeadLampPos = Vector(-23,90,35),
	R_HeadLampAng = Angle(0,90,0),

	L_RearLampPos = Vector(36,-93,35),
	L_RearLampAng = Angle(0,-90,0),

	R_RearLampPos = Vector(-36,-93,35),
	R_RearLampAng = Angle(0,-90,0),
	
	Headlight_sprites = { 
		Vector(29,90,35),
		Vector(-29,90,35),
	},
	Headlamp_sprites = { 
		Vector(23,90,35),
		Vector(-23,90,35),
	},
	FogLight_sprites = {
		Vector(25,90,23),
		Vector(-25,90,23),
	},
	Rearlight_sprites = {
		Vector(30,-93,31),
		Vector(-30,-93,31),
	},
	Brakelight_sprites = {
		Vector(30,-93,27),
		Vector(-30,-93,27),
	},
	Reverselight_sprites = {
		Vector(26.5,-91,21),
		Vector(-26.5,-91,21),
	},
	Turnsignal_sprites = {
		Left = {
		Vector(-26,90,28.5),
		Vector(-28,90,28.5),
		Vector(-34.5,80,30),
		
		Vector(-30,-92.5,36),
		Vector(-34.5,-81.5,27),
		},
		Right = {
		Vector(26,90,28.5),
		Vector(28,90,28.5),
		Vector(34.5,80,30),
		
		Vector(30,-92.5,36),
		Vector(34.5,-81.5,27),
		},
	},
	ems_sounds = {"common/null.wav"},
	ems_sprites = {
		{   --//main light
			pos = Vector(-10,1,64),
			material = "sprites/light_glow02_add_noz",
			size = 35,
			Colors = {Color(250,155,0,255),Color(250,155,0,255),Color(250,155,0,250)}, -- the script will go from color to color
			Speed = 1, -- for how long each color will be drawn
		},
		{
			pos = Vector(10,1,64),
			material = "sprites/light_glow02_add_noz",
			size = 35,
			Colors = {Color(250,155,0,255),Color(250,155,0,255),Color(250,155,0,250)}, -- the script will go from color to color
			Speed = 1, -- for how long each color will be drawn
		},
	}
}
list.Set( "simfphys_lights", "BAK_taxi", light_table)

local V = {
	Name = "'Марафон'",
	Model = "models/bak_taxi/bak_taxi_rigged.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "LC Vehicles",
	SpawnAngleOffset = 0,
	
	Members = {
		Mass = 1350,
		MaxHealth = 5000,
		
		CustomMassCenter = Vector(0,0,5),
		EnginePos = Vector(0,70,10),
		
		SpeedoMax = 140,
		
		LightsTable = "BAK_taxi",
		
		CustomWheels = true,
		CustomSuspensionTravel = 15,
		
		CustomWheelModel = "models/bak_taxi/taxi_wheel.mdl",
	    CustomWheelPosFL = Vector(-29,63,15),
		CustomWheelPosFR = Vector(29,63,15),
		CustomWheelPosRL = Vector(-29,-55,15),	
		CustomWheelPosRR = Vector(29,-55,15),
		CustomWheelAngleOffset = Angle(0,90,0),
		
		CustomSteerAngle = 30,
		
		SeatOffset = Vector(8,-15,48),
        SeatPitch = 0,
		SeatYaw = 0,

		PassengerSeats = {
			{
				pos = Vector(15,10,15),
				ang = Angle(0,0,0)
			},
			{
				pos = Vector(-15,-40,15),
				ang = Angle(0,0,0)
			},
			{
				pos = Vector(0,-40,15),
				ang = Angle(0,0,0)
			},
			{
				pos = Vector(15,-40,15),
				ang = Angle(0,0,0)
			},
		},
				
		ExhaustPositions = {
			{
				pos = Vector(22,-92,10),
				ang = Angle(-90,90,0)
			},
		},
		
		FuelFillPos = Vector(-18.5,-91,24),
		FuelType = FUELTYPE_PETROL,
		FuelTankSize = 60,
		
		StrengthenSuspension = false,
		
		FrontHeight = 12,
		FrontConstant = 20000,
		FrontDamping = 1000,
		FrontRelativeDamping = 1000,
		
		RearHeight = 12,
		RearConstant = 20000,
		RearDamping = 1000,
		RearRelativeDamping = 1000,
		
		FastSteeringAngle = 30,
		SteeringFadeFastSpeed = 185,
		
		TurnSpeed = 4,
		
		MaxGrip = 45,
		Efficiency = 0.7,
		GripOffset = -2,
		BrakePower = 12,
		
		IdleRPM = 1700,
		LimitRPM = 3200,
		PeakTorque = 190,
		PowerbandStart = 1200,
		PowerbandEnd = 2500,
		Turbocharged = false,
		Supercharged = false,
		
		PowerBias = 1,
		
		EngineSoundPreset = 0,
		
		Sound_Idle = "simulated_vehicles/jeep/jeep_idle.wav",
		Sound_IdlePitch = 0.9,
		
		Sound_Mid = "simulated_vehicles/jalopy/jalopy_mid.wav",
		Sound_MidPitch = 0.65,
		Sound_MidVolume = 4.0,
		Sound_MidFadeOutRPMpercent = 76,		-- at wich percentage of limitrpm the sound fades out
		Sound_MidFadeOutRate = 0.34,                    --how fast it fades out   0 = instant       1 = never
		
		Sound_High = "simulated_vehicles/jeep/jeep_mid.wav",
		Sound_HighPitch = 1.0,
		Sound_HighVolume = 5.0,
		Sound_HighFadeInRPMpercent = 10,
		Sound_HighFadeInRate = 0.44,
		
		Sound_Throttle = "",		-- mutes the default throttle sound
		Sound_ThrottlePitch = 0,
		Sound_ThrottleVolume = 0,
		
		snd_horn = "simulated_vehicles/horn_3.wav",
		
		DifferentialGear = 0.50,
		Gears = {-0.15,0,0.13,0.22,0.29,0.36, 0.41}
	}
}
list.Set( "simfphys_vehicles", "sim_fphys_bak_taxi", V )