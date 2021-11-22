
AddCSLuaFile()

local light_table = {
	L_HeadLampPos = Vector(108,25,30),
	L_HeadLampAng = Angle(0,0,0),

	R_HeadLampPos = Vector(108,-25,30),
	R_HeadLampAng = Angle(0,0,0),

	L_RearLampPos = Vector(-96,25,30),
	L_RearLampAng = Angle(0,180,0),

	R_RearLampPos = Vector(-96,-25,30),
	R_RearLampAng = Angle(0,180,0),
	
	Headlight_sprites = { 
		Vector(106,28,31),
		Vector(106,-26,31),
	},
	Headlamp_sprites = { 
		Vector(106,28,31),
		Vector(106,-26,31),
		Vector(106,22,30),
		Vector(106,-20,30),
	},
	FogLight_sprites = {
		Vector(107,22,30),
		Vector(107,-20,30),
	},
	Rearlight_sprites = {
		Vector(-96,28,33),
		Vector(-96,-30,33),
		Vector(-96,26,33),
		Vector(-96,-28,33),
		Vector(-96,24,33),
		Vector(-96,-26,33),
		Vector(-96,28,32),
		Vector(-96,-30,32),
		Vector(-96,26,32),
		Vector(-96,-28,32),
		Vector(-96,24,32),
		Vector(-96,-26,32),
	},
	Brakelight_sprites = {
		Vector(-96,22,33),
		Vector(-96,-24,33),
		Vector(-96,20,33),
		Vector(-96,-22,33),
		Vector(-96,18,33),
		Vector(-96,-20,33),
		Vector(-96,22,32),
		Vector(-96,-24,32),
		Vector(-96,20,32),
		Vector(-96,-22,32),
		Vector(-96,18,32),
		Vector(-96,-20,32),
	},
	Reverselight_sprites = {
		Vector(-92,4,32),
		Vector(-92,-7,32),
	},
	Turnsignal_sprites = {
		Left = {
		Vector(51,41,30.5),
		Vector(53,40.8,30.5),
		
		Vector(-82,37.5,30.5),
		Vector(-84,37,30.5),
		},
		Right = {
		Vector(51,-41,30.5),
		Vector(53,-40.8,30.5),
		
		Vector(-82,-39.5,30.5),
		Vector(-84,-39,30.5),
		},
	},
	ems_sounds = {"simulated_vehicles/police/siren_1.wav","simulated_vehicles/police/siren_2.wav","simulated_vehicles/police/siren_3.wav"},
	ems_sprites = {
		{
			pos = Vector(0,-16,65),
			material = "sprites/light_glow02_add_noz",
			size = 45,
			Colors = {Color(0,5,250,255),Color(0,0,0,255),Color(0,0,0,250)}, -- the script will go from color to color
			Speed = 0.1, -- for how long each color will be drawn
		},
		{
			pos = Vector(0,-14,65),
			material = "sprites/light_glow02_add_noz",
			size = 45,
			Colors = {Color(0,5,250,255),Color(0,0,0,255),Color(0,0,0,250)}, -- the script will go from color to color
			Speed = 0.1, -- for how long each color will be drawn
		},
		{
			pos = Vector(0,-12,65),
			material = "sprites/light_glow02_add_noz",
			size = 45,
			Colors = {Color(0,5,250,255),Color(0,0,0,255),Color(0,0,0,250)}, -- the script will go from color to color
			Speed = 0.1, -- for how long each color will be drawn
		},
		{
			pos = Vector(0,-10,65),
			material = "sprites/light_glow02_add_noz",
			size = 45,
			Colors = {Color(0,5,250,255),Color(0,0,0,255),Color(0,0,0,250)}, -- the script will go from color to color
			Speed = 0.08, -- for how long each color will be drawn
		},
		{
			pos = Vector(0,16,65),
			material = "sprites/light_glow02_add_noz",
			size = 45,
			Colors = {Color(0,5,250,255),Color(0,0,0,255),Color(0,0,0,250)}, -- the script will go from color to color
			Speed = 0.1, -- for how long each color will be drawn
		},
		{
			pos = Vector(0,14,65),
			material = "sprites/light_glow02_add_noz",
			size = 45,
			Colors = {Color(0,5,250,255),Color(0,0,0,255),Color(0,0,0,250)}, -- the script will go from color to color
			Speed = 0.1, -- for how long each color will be drawn
		},
		{
			pos = Vector(0,12,65),
			material = "sprites/light_glow02_add_noz",
			size = 45,
			Colors = {Color(0,5,250,255),Color(0,0,0,255),Color(0,0,0,250)}, -- the script will go from color to color
			Speed = 0.1, -- for how long each color will be drawn
		},
		{
			pos = Vector(0,10,65),
			material = "sprites/light_glow02_add_noz",
			size = 45,
			Colors = {Color(0,5,250,255),Color(0,0,0,255),Color(0,0,0,250)}, -- the script will go from color to color
			Speed = 0.08, -- for how long each color will be drawn
		},
		{
			pos = Vector(0,4,65),
			material = "sprites/light_glow02_add_noz",
			size = 45,
			Colors = {Color(250,5,0,255),Color(0,0,0,255),Color(0,0,0,250)}, -- the script will go from color to color
			Speed = 0.1, -- for how long each color will be drawn
		},
		{
			pos = Vector(0,-4,65),
			material = "sprites/light_glow02_add_noz",
			size = 45,
			Colors = {Color(250,5,0,255),Color(0,0,0,255),Color(0,0,0,250)}, -- the script will go from color to color
			Speed = 0.1, -- for how long each color will be drawn
		},
		{
			pos = Vector(0,0,65),
			material = "sprites/light_glow02_add_noz",
			size = 45,
			Colors = {Color(250,5,0,255),Color(0,0,0,255),Color(0,0,0,250)}, -- the script will go from color to color
			Speed = 0.08, -- for how long each color will be drawn
		},
	}
}
list.Set( "simfphys_lights", "BAK_gcpd_nova", light_table)

local V = {
	Name = "Полицейский Шевроле 'Нова'",
	Model = "models/chevrolet_nova_gcpd/nova_rigged.mdl",
	ModelOffset = Angle(0,90,0),
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "LC Vehicles",
	SpawnAngleOffset = 90,
	
	Members = {
		Mass = 1230,
		MaxHealth = 5000,
		
		CustomMassCenter = Vector(3,0,5),
		EnginePos = Vector(65,0,10),
		
		SpeedoMax = 140,
		
		LightsTable = "BAK_gcpd_nova",
		
		CustomWheels = true,
		CustomSuspensionTravel = 15,
		
		CustomWheelModel = "models/chevrolet_nova_gcpd/nova_wheel.mdl",
	    CustomWheelPosFL = Vector(77,34,20),
		CustomWheelPosFR = Vector(77,-34,20),
		CustomWheelPosRL = Vector(-48,35,20),	
		CustomWheelPosRR = Vector(-48,-35,20),
		CustomWheelAngleOffset = Angle(0,-90,0),
		
		CustomSteerAngle = 30,
		
		SeatOffset = Vector(8,-15,49),
        SeatPitch = 0,
		SeatYaw = 90,

		PassengerSeats = {
			{
				pos = Vector(10,-15,15),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(-25,15,15),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(-25,0,15),
				ang = Angle(0,-90,0)
			},
			{
				pos = Vector(-25,-15,15),
				ang = Angle(0,-90,0)
			},
		},
				
		ExhaustPositions = {
			{
				pos = Vector(-99,28,15),
				ang = Angle(-90,0,0)
			},
		},
		
		FuelFillPos = Vector(-49,-36,38),
		FuelType = FUELTYPE_PETROL,
		FuelTankSize = 65,
		
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
		SteeringFadeFastSpeed = 185,
		
		TurnSpeed = 4,
		
		MaxGrip = 45,
		Efficiency = 0.90,
		GripOffset = -1,
		BrakePower = 15,
		
		IdleRPM = 800, -- Банальная мощность двигателя
		LimitRPM = 2000, -- Максимальная скорость 
		PeakTorque = 180, -- Мощность разгона
		PowerbandStart = 1000, -- Начало переключения передач
		PowerbandEnd = 1800, -- Предел переключения передач
		Turbocharged = false,
		Supercharged = false,
		
		PowerBias = 1,
		
		EngineSoundPreset = 0,
		
		Sound_Idle = "simulated_vehicles/gta5_gauntlet/gauntlet_idle.wav",
		Sound_IdlePitch = 1.0,
		
		Sound_Mid = "simulated_vehicles/gta5_dukes/dukes_low.wav",
		Sound_MidPitch = 0.7,
		Sound_MidVolume = 3.0,
		Sound_MidFadeOutRPMpercent = 70,		-- at wich percentage of limitrpm the sound fades out
		Sound_MidFadeOutRate = 0.34,                    --how fast it fades out   0 = instant       1 = never
		
		Sound_High = "simulated_vehicles/jeep/jeep_mid.wav",
		Sound_HighPitch = 0.8,
		Sound_HighVolume = 5.0,
		Sound_HighFadeInRPMpercent = 50,
		Sound_HighFadeInRate = 0.44,
		
		Sound_Throttle = "",		-- mutes the default throttle sound
		Sound_ThrottlePitch = 0,
		Sound_ThrottleVolume = 0,
		
		snd_horn = "simulated_vehicles/horn_3.wav",
		
		DifferentialGear = 0.60,
		Gears = {-0.15,0,0.16,0.25,0.32,0.39, 0.46, 0.53}
	}
}
list.Set( "simfphys_vehicles", "sim_fphys_bak_gcpd_nova", V )