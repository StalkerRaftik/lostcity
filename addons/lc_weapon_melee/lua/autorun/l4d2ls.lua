util.PrecacheModel( "models/weapons/melee/v_pitchfork.mdl" )
util.PrecacheModel( "models/weapons/melee/w_pitchfork.mdl" )
util.PrecacheModel( "models/weapons/melee/v_shovel.mdl" )
util.PrecacheModel( "models/weapons/melee/w_shovel.mdl" )

sound.Add(
{
	name = "Weapon.Swing",
	channel = CHAN_STATIC,
	soundlevel = SNDLVL_NORM,
	volume = 1.0,
	sound = { "player/survivor/swing/Swish_WeaponSwing_Swipe5.wav",  "player/survivor/swing/Swish_WeaponSwing_Swipe6.wav" }
})
sound.Add(
{
	name = "Weapon.HitInfected",
	channel = CHAN_STATIC,
	soundlevel = SNDLVL_NORM,
	volume = 1.0,
	sound = { "player/survivor/hit/rifle_swing_hit_infected7.wav", "player/survivor/hit/rifle_swing_hit_infected8.wav", "player/survivor/hit/rifle_swing_hit_infected9.wav", "player/survivor/hit/rifle_swing_hit_infected10.wav", "player/survivor/hit/rifle_swing_hit_infected11.wav", "player/survivor/hit/rifle_swing_hit_infected12.wav" }
})
sound.Add(
{
	name = "Melee.HitWorld",
	channel = CHAN_STATIC,
	soundlevel = SNDLVL_NORM,
	volume = 1.0,
	sound = "player/survivor/hit/melee_swing_hit_world.wav"
})

-- Pitchfork -------------------------------------------------------------------
sound.Add(
{
    name = "Pitchfork.Deploy",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = SNDLVL_NORM,
    sound = "weapons/Pitchfork/Pitchfork_deploy_1.wav"
})
sound.Add(
{
    name = "Pitchfork.Miss",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = SNDLVL_NORM,
    pitchstart = 95,
    pitchend = 105,
    sound = { "weapons/Pitchfork/Pitchfork_swing_miss1.wav", "weapons/Pitchfork/Pitchfork_swing_miss2.wav" }
})
sound.Add(
{
    name = "Pitchfork.ImpactFlesh",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = SNDLVL_NORM,
    pitchstart = 95,
    pitchend = 105,
    sound = { "weapons/pitchfork/pitchfork_impact_flesh1.wav", "weapons/pitchfork/pitchfork_impact_flesh2.wav", "weapons/pitchfork/pitchfork_impact_flesh3.wav", "weapons/pitchfork/pitchfork_impact_flesh4.wav" }
})
sound.Add(
{
    name = "Pitchfork.ImpactWorld",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = SNDLVL_NORM,
    pitchstart = 95,
    pitchend = 105,
    sound = { "weapons/pitchfork/pitchfork_impact_world1.wav", "weapons/pitchfork/pitchfork_impact_world2.wav", "weapons/pitchfork/pitchfork_impact_world3.wav", "weapons/pitchfork/pitchfork_impact_world4.wav" }
})

-- Shovel -------------------------------------------------------------------
sound.Add(
{
    name = "Shovel.Deploy",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = SNDLVL_NORM,
    sound = "weapons/Shovel/Shovel_deploy_1.wav"
})
sound.Add(
{
    name = "Shovel.Miss",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = SNDLVL_NORM,
    pitchstart = 95,
    pitchend = 105,
    sound = { "weapons/Shovel/Shovel_swing_miss1.wav", "weapons/Shovel/Shovel_swing_miss2.wav" }
})
sound.Add(
{
    name = "Shovel.ImpactFlesh",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = SNDLVL_NORM,
    pitchstart = 95,
    pitchend = 105,
    sound = { "weapons/Shovel/Shovel_impact_flesh1.wav", "weapons/Shovel/Shovel_impact_flesh2.wav", "weapons/Shovel/Shovel_impact_flesh3.wav", "weapons/Shovel/Shovel_impact_flesh4.wav" }
})
sound.Add(
{
    name = "Shovel.ImpactWorld",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = SNDLVL_NORM,
    pitchstart = 95,
    pitchend = 105,
    sound = { "weapons/Shovel/Shovel_impact_world1.wav", "weapons/Shovel/Shovel_impact_world2.wav" }
})