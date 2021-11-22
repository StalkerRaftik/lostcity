if SERVER then
	AddCSLuaFile()
end

sound.Add({
	name = 			"TFA_GTAV_Railgun.1",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 		"weapons/gtav/railgun/fire.wav"
})

sound.Add({
	name = 			"TFA_GTAV_Railgun.Tonal",
	channel = 		CHAN_USER_BASE+11,
	volume = 		1.0,
	sound = 		"weapons/gtav/railgun/tonal.wav"
})

sound.Add({
	name = 			"TFA_GTAV_Railgun.Draw",
	channel = 		CHAN_USER_BASE+11,
	volume = 		1.0,
	sound = 		"weapons/gtav/railgun/bright.wav"
})

sound.Add({
	name = 			"TFA_GTAV_Railgun.Bright",
	channel = 		CHAN_USER_BASE+11,
	volume = 		1.0,
	sound = 		"weapons/gtav/railgun/bright.wav"
})