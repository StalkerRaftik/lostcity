if killicon and killicon.Add then
    killicon.Add( "tfa_doimp40", "vgui/hud/tfa_doimp40", Color( 0, 0, 0, 255 ) )
end

--sound.Add({
--    name = "Weapon_mp40.1",
--    channel = CHAN_USER_BASE+10,
--    volume = 1.0,
--    sound = "weapons/mp40/mp40_fp2.wav"
--})

sound.Add(
{
    name = "Weapon_mp40.Magrelease",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/mp40/handling/mp40_magrelease.wav"
})
sound.Add(
{
    name = "Weapon_mp40.Magin",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/mp40/handling/mp40_magin.wav"
})
sound.Add(
{
    name = "Weapon_mp40.Maghit",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/mp40/handling/mp40_maghit.wav"
})
sound.Add(
{
    name = "Weapon_mp40.Magout",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/mp40/handling/mp40_magout.wav"
})
sound.Add(
{
    name = "Weapon_mp40.Boltlock",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/mp40/handling/mp40_boltlock.wav"
})
sound.Add(
{
    name = "Weapon_mp40.Boltunlock",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/mp40/handling/mp40_boltunlock.wav"
})
sound.Add(
{
    name = "Weapon_mp40.Boltback",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/mp40/handling/mp40_boltback.wav"
})