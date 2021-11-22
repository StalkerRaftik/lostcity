// Sounds for TFRE guns
-- default settings
local icol = Color( 255, 80, 0, 191 ) 
if CLIENT then

	killicon.Add(  "tfa_tfre_hammerless",		"vgui/killicons/tfa_tfre_hammerless", icol  )

end
local defaultSoundTable = {
	channel = CHAN_AUTO, 
	volume = 1,
	level = 60, 
	pitchstart = 100,
	pitchend = 100,
	name = "noName",
	sound = "path/to/sound"
}

local fireSoundTable = {
	channel = CHAN_AUTO, 
	volume = 1,
	level = 97, 
	pitchstart = 92,
	pitchend = 112,
	name = "noName",
	sound = "path/to/sound"
}

local muteSoundTable = {
	channel = CHAN_AUTO, 
	volume = 0.001,
	level = 60, 
	pitchstart = 100,
	pitchend = 100,
	name = "noName",
	sound = "hl1/fvox/_comma.wav"
}

-- "<" makes the sound directional, refer to https://developer.valvesoftware.com/wiki/Soundscripts#Sound_Characters
local function makeSoundDirectional(snd)
	if type(snd) == "table" then
		for key, sound in ipairs(snd) do
			snd[key] = "<" .. sound
		end
	else
		snd = "<" .. snd
	end
	
	return snd
end

local function addDefaultSound(name, snd)
	snd = makeSoundDirectional(snd)
	
	defaultSoundTable.name = name
	defaultSoundTable.sound = snd

	sound.Add(defaultSoundTable)
	
	-- precache the registered sounds
	if type(defaultSoundTable.sound) == "table" then
		for k, v in pairs(defaultSoundTable.sound) do
			util.PrecacheSound(v)
		end
	else
		util.PrecacheSound(snd)
	end
end

local function addFireSound(name, snd, volume, soundLevel, channel, pitchStart, pitchEnd, noDirection)
	-- use defaults if no args are provided
	volume = volume or 1
	soundLevel = soundLevel or 97
	channel = channel or CHAN_AUTO
	pitchStart = pitchStart or 92
	pitchEnd = pitchEnd or 112
	
	if not noDirection then
		snd = makeSoundDirectional(snd)
	end
	
	fireSoundTable.name = name
	fireSoundTable.sound = snd
	
	fireSoundTable.channel = channel
	fireSoundTable.volume = volume
	fireSoundTable.level = soundLevel
	fireSoundTable.pitchstart = pitchStart
	fireSoundTable.pitchend = pitchEnd
	
	sound.Add(fireSoundTable)
	
	-- precache the registered sounds
	
	if type(fireSoundTable.sound) == "table" then
		for k, v in pairs(fireSoundTable.sound) do
			util.PrecacheSound(v)
		end
	else
		util.PrecacheSound(snd)
	end
end

local function muteSound(name)	
	muteSoundTable.name = name
	sound.Add(muteSoundTable)
end

// TFRE sounds
// firing sounds

addFireSound("Weapon_tfre_hammerless.Single", {
    "weapons/tfre/hammerless/hammerless_fire1.wav",
    "weapons/tfre/hammerless/hammerless_fire2.wav",
    "weapons/tfre/hammerless/hammerless_fire3.wav",},
    0.93, SNDLVL_GUNFIRE, CHAN_WEAPON, 88, 93
)

// reload/other sounds
addDefaultSound("Weapon_TFRE_Hammerless.Latch.Close", "weapons/tfre/hammerless/hammerless_latch_close.wav")
addDefaultSound("Weapon_TFRE_Hammerless.Latch.Open", "weapons/tfre/hammerless/hammerless_latch_open.wav")
addDefaultSound("Weapon_TFRE_Hammerless.Extraction.Snap", "weapons/tfre/hammerless/hammerless_extraction_snap.wav")
addDefaultSound("Weapon_TFRE_Hammerless.Loading1", "weapons/tfre/hammerless/hammerless_loading1.wav")
addDefaultSound("Weapon_TFRE_Hammerless.Loading2", "weapons/tfre/hammerless/hammerless_loading2.wav")
addDefaultSound("Weapon_TFRE_Hammerless.Loading3", "weapons/tfre/hammerless/hammerless_loading3.wav")
addDefaultSound("Weapon_TFRE_Hammerless.Draw", "weapons/tfre/hammerless/hammerless_draw.wav")

addFireSound("Weapon_TFRE_Hammerless.Empty", {
    "weapons/tfre/hammerless/hammerless_dryfire1.wav",
    "weapons/tfre/hammerless/hammerless_dryfire2.wav"},
	0.3, 60, CHAN_AUTO, 100, 100, true
)

addFireSound("Weapon_TFRE_Hammerless.Extraction", {
    "weapons/tfre/hammerless/hammerless_extraction1.wav",
    "weapons/tfre/hammerless/hammerless_extraction2.wav"},
	0.3, 60, CHAN_AUTO, 100, 100, true
)
