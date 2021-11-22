include('shared.lua')

SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/weapon_tfa_win73")
killicon.Add("tfa_win73", "vgui/hud/weapon_tfa_win73", Color(255, 255, 255, 255))

local soundData = {
    name 		= "Weapon_WIN73.Shell" ,
    channel 	= CHAN_WEAPON,
    volume 		= 0.5,
    soundlevel 	= 80,
    pitchstart 	= 100,
    pitchend 	= 100,
    sound 		= "weapons/winchester73/73_insertshell.wav"
}
sound.Add(soundData)
local soundData = {
    name 		= "Weapon_WIN73.Pump" ,
    channel 	= CHAN_WEAPON,
    volume 		= 0.5,
    soundlevel 	= 80,
    pitchstart 	= 100,
    pitchend 	= 100,
    sound 		= "weapons/winchester73/rifle_slideforward.wav"
}
sound.Add(soundData)
local soundData = {
    name 		= "Weapon_WIN73.Pump2" ,
    channel 	= CHAN_WEAPON,
    volume 		= 0.5,
    soundlevel 	= 80,
    pitchstart 	= 100,
    pitchend 	= 100,
    sound 		= "weapons/winchester73/rifle_slideback.wav"
}
sound.Add(soundData)
local soundData = {
    name 		= "Weapon_WIN73.draw" ,
    channel 	= CHAN_WEAPON,
    volume 		= 0.5,
    soundlevel 	= 80,
    pitchstart 	= 100,
    pitchend 	= 100,
    sound 		= "weapons/winchester73/holster_1.wav"
}
sound.Add(soundData)
local soundData = {
    name 		= "Weapon_WIN73.holster" ,
    channel 	= CHAN_WEAPON,
    volume 		= 0.5,
    soundlevel 	= 80,
    pitchstart 	= 100,
    pitchend 	= 100,
    sound 		= "weapons/winchester73/holster_2.wav"
}
sound.Add(soundData)
local soundData = {
    name 		= "Weapon_WIN73.rattle" ,
    channel 	= CHAN_WEAPON,
    volume 		= 0.5,
    soundlevel 	= 80,
    pitchstart 	= 100,
    pitchend 	= 100,
    sound 		= "weapons/winchester73/rifle_rattle.wav"
}
sound.Add(soundData)