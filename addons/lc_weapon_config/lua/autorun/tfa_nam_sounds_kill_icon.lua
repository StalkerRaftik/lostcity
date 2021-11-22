local icol = Color( 255, 255, 255, 255 ) 
if CLIENT then
       killicon.Add(  "tfa_nam_m79",		"vgui/hud/tfa_nam_m79", icol  )

end

sound.Add(
{
name = "Weapon_M79.CloseBarrel",
channel = CHAN_USER_BASE + 13,
volume = VOL_NORM,
soundlevel = SNDLVL_NORM,
sound = "weapons/tfa_nam_m79/m79_closebarrel.wav"
} )
sound.Add(
{
name = "Weapon_M79.OpenBarrel",
channel = CHAN_USER_BASE + 13,
volume = VOL_NORM,
soundlevel = SNDLVL_NORM,
sound = "weapons/tfa_nam_m79/m79_openbarrel.wav"
} )
sound.Add(
{
name = "Weapon_M79.GrenadeDrop",
channel = CHAN_USER_BASE + 13,
volume = VOL_NORM,
soundlevel = SNDLVL_NORM,
sound = "weapons/tfa_nam_m79/m79_shell_concrete_01.wav"
} )
sound.Add(
{
name = "Weapon_M79.GrenadeIn",
channel = CHAN_USER_BASE + 13,
volume = VOL_NORM,
soundlevel = SNDLVL_NORM,
sound = "weapons/tfa_nam_m79/m79_insertgrenade_01.wav"
} )
sound.Add(
{
name = "Weapon_M79.Empty",
channel = CHAN_USER_BASE + 13,
volume = VOL_NORM,
soundlevel = SNDLVL_NORM,
sound = "weapons/tfa_nam_m79/m79_empty.wav"
} )