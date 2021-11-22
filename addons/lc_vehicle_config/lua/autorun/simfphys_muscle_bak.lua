
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
		Vector(29,97,29),
		Vector(-29,97,29),
	},
	Headlamp_sprites = { 
		Vector(29,97,29),
		Vector(-29,97,29),
	},
	FogLight_sprites = {
		Vector(29,97,29),
		Vector(-29,97,29),
	},
	Rearlight_sprites = {
		Vector(27.5,-104,29.5),
		Vector(-27.5,-104,29.5),
		Vector(27.5,-104,29.5),
		Vector(-27.5,-104,29.5),
	},
	Brakelight_sprites = {
		Vector(27.5,-104,29.5),
		Vector(-27.5,-104,29.5),
		Vector(27.5,-104,29.5),
		Vector(-27.5,-104,29.5),
	},
	Reverselight_sprites = {
		Vector(27.5,-105,27),
		Vector(-27.5,-105,27),
		Vector(27.5,-105,27),
		Vector(-27.5,-105,27),
	},
	Turnsignal_sprites = {
		Left = {
		Vector(-35,99,29.5),
		Vector(-35,99,26.5),
		Vector(-39,92,23.5),
		Vector(-39,90,23.5),
		Vector(-39,88,23.5),
		
		Vector(-22.5,-105,27),
		Vector(-22.5,-104,29.5),
		Vector(-39,-94,23.5),
		Vector(-39,-92,23.5),
		Vector(-39,-90,23.5),
		},
		Right = {
		Vector(35,99,29.5),
		Vector(35,99,26.5),
		Vector(39,92,23.5),
		Vector(39,90,23.5),
		Vector(39,88,23.5),
		
		Vector(22.5,-105,27),
		Vector(22.5,-104,29.5),
		Vector(39,-94,23.5),
		Vector(39,-92,23.5),
		Vector(39,-90,23.5),
		},
	},
}
list.Set( "simfphys_lights", "BAK_muscle", light_table)

local V = {
	Name = "Форд 'Мустанг'",
	Model = "models/bak_muscle/bak_muscle_rigged.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "LC Vehicles",
	SpawnAngleOffset = 0,
	
	Members = {
		Mass = 1250,
		MaxHealth = 3700,
		
		CustomMassCenter = Vector(0,0,5),
		EnginePos = Vector(0,70,10),
		
		SpeedoMax = 140,
		
		LightsTable = "BAK_muscle",
		
		CustomWheels = true,
		CustomSuspensionTravel = 15,
		
		CustomWheelModel = "models/bak_muscle/muscle_wheel.mdl",
	    CustomWheelPosFL = Vector(-34,70,20),
		CustomWheelPosFR = Vector(34,70,20),
		CustomWheelPosRL = Vector(-34,-50,20),	
		CustomWheelPosRR = Vector(34,-50,20),
		CustomWheelAngleOffset = Angle(0,-90,0),
		
		CustomSteerAngle = 30,
		
		SeatOffset = Vector(8,-15,45),
        SeatPitch = 0,
		SeatYaw = 0,

		PassengerSeats = {
			{
				pos = Vector(15,5,10),
				ang = Angle(0,0,0)
			},
			{
				pos = Vector(-15,-25,10),
				ang = Angle(0,0,0)
			},
			{
				pos = Vector(0,-25,10),
				ang = Angle(0,0,0)
			},
			{
				pos = Vector(15,-25,10),
				ang = Angle(0,0,0)
			},
		},
				
		ExhaustPositions = {
			{
				pos = Vector(-26,-105,16),
				ang = Angle(-90,90,0)
			},
			{
				pos = Vector(26,-105,16),
				ang = Angle(-90,90,0)
			},
		},
		
		FuelFillPos = Vector(36,-30,35),
		FuelType = FUELTYPE_PETROL,
		FuelTankSize = 45,
		
		StrengthenSuspension = false,
		
		FrontHeight = 13,
		FrontConstant = 25000,
		FrontDamping = 1500,
		FrontRelativeDamping = 1500,
		
		RearHeight = 13,
		RearConstant = 25000,
		RearDamping = 1500,
		RearRelativeDamping = 1500,
		
		FastSteeringAngle = 30,
		SteeringFadeFastSpeed = 195,
		
		TurnSpeed = 4,
		
		MaxGrip = 45,
		Efficiency = 0.80,
		GripOffset = -1,
		BrakePower = 15,
		
		IdleRPM = 900,
		LimitRPM = 6000,
		PeakTorque = 180,
		PowerbandStart = 1000,
		PowerbandEnd = 5400,
		Turbocharged = false,
		Supercharged = false,
		
		PowerBias = 1,
		
		EngineSoundPreset = 0,
		
		Sound_Idle = "simulated_vehicles/generic4/generic4_idle.wav",
		Sound_IdlePitch = 1.0,
		
		Sound_Mid = "simulated_vehicles/jalopy/jalopy_mid.wav",
		Sound_MidPitch = 0.9,
		Sound_MidVolume = 4.0,
		Sound_MidFadeOutRPMpercent = 75,		-- at wich percentage of limitrpm the sound fades out
		Sound_MidFadeOutRate = 0.34,                    --how fast it fades out   0 = instant       1 = never
		
		Sound_High = "simulated_vehicles/misc/gto_onlow.wav",
		Sound_HighPitch = 0.9,
		Sound_HighVolume = 4.0,
		Sound_HighFadeInRPMpercent = 10,
		Sound_HighFadeInRate = 0.44,
		
		Sound_Throttle = "",		-- mutes the default throttle sound
		Sound_ThrottlePitch = 0,
		Sound_ThrottleVolume = 0,
		
		snd_horn = "simulated_vehicles/horn_3.wav",
		
		DifferentialGear = 0.7,
		Gears = {-0.15,0,0.10,0.13,0.17,0.21, 0.25}
	}
}
list.Set( "simfphys_vehicles", "sim_fphys_bak_muscle", V )