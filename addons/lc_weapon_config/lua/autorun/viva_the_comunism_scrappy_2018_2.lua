local icol = Color( 255, 255, 255, 255 ) 
if CLIENT then
       killicon.Add(  "tfa_nam_sawed_off_shotty",		"vgui/hud/tfa_nam_sawed_off_shotty", icol  )

end

sound.Add(
{
name = "Weapon_Doublebarrel.Closebarrel",
channel = CHAN_USER_BASE + 13,
volume = VOL_NORM,
soundlevel = SNDLVL_NORM,
sound = "weapons/tfa_doublebarrel/breakclose.wav"
} )
sound.Add(
{
name = "Weapon_Doublebarrel.Openbarrel",
channel = CHAN_USER_BASE + 13,
volume = VOL_NORM,
soundlevel = SNDLVL_NORM,
sound = "weapons/tfa_doublebarrel/breakopen.wav"
} )
sound.Add(
{
name = "Weapon_Doublebarrel.Ejectshell",
channel = CHAN_USER_BASE + 13,
volume = VOL_NORM,
soundlevel = SNDLVL_NORM,
sound = "weapons/tfa_doublebarrel/shellseject.wav"
} )
sound.Add(
{
name = "Weapon_Doublebarrel.Shellinsert",
channel = CHAN_USER_BASE + 13,
volume = VOL_NORM,
soundlevel = SNDLVL_NORM,
sound = "weapons/tfa_doublebarrel/shellinsert1.wav"
} )
sound.Add(
{
name = "Weapon_Doublebarrel.Ejectshells",
channel = CHAN_USER_BASE + 13,
volume = VOL_NORM,
soundlevel = SNDLVL_NORM,
sound = "weapons/tfa_doublebarrel/shellseject.wav"
} )
sound.Add(
{
name = "Weapon_Doublebarrel.Empty",
channel = CHAN_USER_BASE + 13,
volume = VOL_NORM,
soundlevel = SNDLVL_NORM,
sound = "weapons/tfa_doublebarrel/empty.wav"
} )