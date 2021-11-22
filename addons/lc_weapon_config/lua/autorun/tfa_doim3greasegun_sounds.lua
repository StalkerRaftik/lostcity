if killicon and killicon.Add then
    killicon.Add( "tfa_doim3greasegun", "vgui/hud/tfa_doim3greasegun", Color( 0, 0, 0, 255 ) )
end

--sound.Add(
--{
--    name = "Weapon_m3.1",
--    channel = CHAN_USER_BASE+10,
--    volume = 1.0,
--    soundlevel = 75,
--    sound = "weapons/m3greasegun/m3_fp2.wav"
--})

sound.Add(
{
    name = "Weapon_m3.Magrelease",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/m3greasegun/handling/m3_magrelease.wav"
})
sound.Add(
{
    name = "Weapon_m3.Magin",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/m3greasegun/handling/m3_magin.wav"
})
sound.Add(
{
    name = "Weapon_m3.Maghit",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/m3greasegun/handling/m3_maghit.wav"
})
sound.Add(
{
    name = "Weapon_m3.Magout",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/m3greasegun/handling/m3_magout.wav"
})
sound.Add(
{
    name = "Weapon_m3.Boltback",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/m3greasegun/handling/m3_boltback.wav"
})