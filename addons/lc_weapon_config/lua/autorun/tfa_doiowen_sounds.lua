if killicon and killicon.Add then
    killicon.Add( "tfa_doiowen", "vgui/hud/tfa_doiowen", Color( 0, 0, 0, 255 ) )
end

--sound.Add(
--{
--    name = "Weapon_Owen.1",
--    channel = CHAN_USER_BASE+10,
--    volume = 1.0,
--    soundlevel = 75,
--    sound = "weapons/owen/owen_fp.wav"
--})

sound.Add(
{
    name = "Weapon_Owen.Magrelease",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/owen/handling/owen_magrelease.wav"
})
sound.Add(
{
    name = "Weapon_Owen.Magout",
    channel = CHAN_USER_BASE+10,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/owen/handling/owen_magout.wav"
})
sound.Add(
{
    name = "Weapon_Owen.MagFetch",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/owen/handling/owen_fetchmag.wav"
})
sound.Add(
{
    name = "Weapon_Owen.MagIn",
    channel = CHAN_USER_BASE+10,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/owen/handling/owen_magin.wav"
})
sound.Add(
{
    name = "Weapon_Owen.Boltrelease",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/owen/handling/owen_boltback.wav"
})
sound.Add(
{
    name = "Weapon_Owen.Rattle",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/owen/handling/owen_rattle.wav"
})
