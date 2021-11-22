zlm = zlm or {}
zlm.f = zlm.f or {}
zlm.sounds = zlm.sounds or {}

-- This packs the requested sound Data
function zlm.f.CatchSound(id)
	local soundData = {}
	local soundTable = zlm.sounds[id]
	soundData.sound = soundTable.paths[math.random(#soundTable.paths)]
	soundData.lvl = soundTable.lvl
	soundData.pitch = math.Rand(soundTable.pitchMin, soundTable.pitchMax)
	local vol = 1
	if CLIENT then
		vol = GetConVar("zlm_cl_sfx_volume"):GetFloat()
	end
	soundData.volume = vol * soundTable.pref_volume

	return soundData
end

zlm.sounds["zlm_tractor_engine_start"] = {
	paths = {"zlm/zlm_engine_start.wav"},
	lvl = SNDLVL_80dB,
	pitchMin = 100,
	pitchMax = 100,
	pref_volume = 0.25
}

zlm.sounds["zlm_tractor_engine_stop"] = {
	paths = {"zlm/zlm_engine_stop.wav"},
	lvl = SNDLVL_80dB,
	pitchMin = 100,
	pitchMax = 100,
	pref_volume = 0.25
}

zlm.sounds["zlm_tractor_engine_stop"] = {
	paths = {"zlm/zlm_engine_stop.wav"},
	lvl = SNDLVL_80dB,
	pitchMin = 100,
	pitchMax = 100,
	pref_volume = 0.25
}

zlm.sounds["zlm_tractor_unload"] = {
	paths = {"zlm/zlm_unload.wav"},
	lvl = SNDLVL_80dB,
	pitchMin = 100,
	pitchMax = 100,
	pref_volume = 0.3
}

zlm.sounds["zlm_grass_fall"] = {
	paths = {"zlm/zlm_grass_fall.wav"},
	lvl = SNDLVL_80dB,
	pitchMin = 100,
	pitchMax = 100,
	pref_volume = 1
}

zlm.sounds["zlm_selling"] = {
	paths = {"zlm/zlm_cash01.wav"},
	lvl = SNDLVL_80dB,
	pitchMin = 100,
	pitchMax = 100,
	pref_volume = 1
}

sound.Add({
	name = "zlm_tractor_engine_idle",
	channel = CHAN_STATIC,
	volume = 1.0,
	soundlevel = 80,
	sound = "zlm/zlm_engine_idle.wav"
})

sound.Add({
	name = "zlm_tractor_cutting",
	channel = CHAN_STATIC,
	volume = 1,
	soundlevel = 80,
	sound = "zlm/zlm_cutting_loop.wav"
})

sound.Add({
	name = "zlm_grassroll_hit",
	channel = CHAN_STATIC,
	volume = 1,
	soundlevel = 80,
	sound = "zlm/zlm_grassroll_hit.wav"
})

sound.Add({
	name = "zlm_cut_grass_loop",
	channel = CHAN_STATIC,
	volume = 1,
	soundlevel = 80,
	sound = "zlm/zlm_cutting_grass_loop.wav"
})


sound.Add({
	name = "zlm_grasspress_run",
	channel = CHAN_VOICE,
	volume = 1.0,
	soundlevel = 80,
	pitchstart = 100,
	sound = "zlm/zlm_grasspress_run.wav"
})

sound.Add({
	name = "zlm_grasspress_idle",
	channel = CHAN_VOICE,
	volume = 1.0,
	soundlevel = 80,
	pitchstart = 100,
	sound = "zlm/zlm_grasspress_idle.wav"
})












sound.Add({
	name = "zlm_tractor_engine_null",
	channel = CHAN_STATIC,
	volume = 1.0,
	soundlevel = 80,
	sound = "common/null.wav"
})

sound.Add({
	name = "zlm_tractor_rev",
	channel = CHAN_STATIC,
	volume = 0.9,
	soundlevel = 80,
	pitchstart = 98,
	pitchend = 105,
	sound = "common/null.wav"
})

sound.Add({
	name = "zlm_tractor_reverse",
	channel = CHAN_STATIC,
	volume = 1.0,
	soundlevel = 80,
	pitchstart = 100,
	sound = "common/null.wav"
})

sound.Add({
	name = "zlm_tractor_firstgear",
	channel = CHAN_STATIC,
	volume = 1.0,
	soundlevel = 80,
	pitchstart = 100,
	sound = "common/null.wav"
})

sound.Add({
	name = "zlm_tractor_fourthgear",
	channel = CHAN_STATIC,
	volume = 1.0,
	soundlevel = 80,
	pitchstart = 105,
	pitchend = 105,
	sound = "common/null.wav"
})

sound.Add({
	name = "zlm_tractor_firstgear_noshift",
	channel = CHAN_STATIC,
	volume = 1.0,
	soundlevel = 80,
	pitchstart = 105,
	pitchend = 105,
	sound = "common/null.wav"
})

sound.Add({
	name = "zlm_tractor_fourthgear_noshift",
	channel = CHAN_STATIC,
	volume = 1.0,
	soundlevel = 80,
	pitchstart = 105,
	pitchend = 105,
	sound = "common/null.wav"
})

sound.Add({
	name = "zlm_tractor_throttleoff_slowspeed",
	channel = CHAN_STATIC,
	volume = 1.0,
	soundlevel = 80,
	pitchstart = 90,
	pitchend = 105,
	sound = "common/null.wav"
})

sound.Add({
	name = "zlm_tractor_throttleoff_fastspeed",
	channel = CHAN_STATIC,
	volume = 1.0,
	soundlevel = 80,
	pitchstart = 90,
	pitchend = 105,
	sound = "common/null.wav"
})

sound.Add({
	name = "zlm_tractor_skid_lowfriction",
	channel = CHAN_BODY,
	volume = 1.0,
	soundlevel = 80,
	pitchstart = 90,
	pitchend = 110,
	sound = "vehicles/v8/skid_lowfriction.wav"
})

sound.Add({
	name = "zlm_tractor_skid_normalfriction",
	channel = CHAN_BODY,
	volume = 1.0,
	soundlevel = 80,
	pitchstart = 90,
	pitchend = 110,
	sound = "vehicles/v8/skid_normalfriction.wav"
})

sound.Add({
	name = "zlm_tractor_skid_highfriction",
	channel = CHAN_BODY,
	volume = 1.0,
	soundlevel = 80,
	pitchstart = 90,
	pitchend = 110,
	sound = "vehicles/v8/skid_highfriction.wav"
})

sound.Add({
	name = "zlm_tractor_impact_heavy",
	channel = CHAN_STATIC,
	volume = 1.0,
	soundlevel = 80,
	pitchstart = 95,
	pitchend = 110,
	sound = {"vehicles/v8/vehicle_impact_heavy1.wav", "vehicles/v8/vehicle_impact_heavy2.wav", "vehicles/v8/vehicle_impact_heavy3.wav", "vehicles/v8/vehicle_impact_heavy4.wav"}
})

sound.Add({
	name = "zlm_tractor_impact_medium",
	channel = CHAN_STATIC,
	volume = 1.0,
	soundlevel = 80,
	pitchstart = 95,
	pitchend = 110,
	sound = {"vehicles/v8/vehicle_impact_medium1.wav", "vehicles/v8/vehicle_impact_medium2.wav", "vehicles/v8/vehicle_impact_medium3.wav", "vehicles/v8/vehicle_impact_medium4.wav"}
})

sound.Add({
	name = "zlm_tractor_rollover",
	channel = CHAN_STATIC,
	volume = 1.0,
	soundlevel = 80,
	pitchstart = 95,
	pitchend = 110,
	sound = {"vehicles/v8/vehicle_rollover1.wav", "vehicles/v8/vehicle_rollover2.wav"}
})

sound.Add({
	name = "zlm_tractor_start_in_water",
	channel = CHAN_VOICE,
	volume = 1.0,
	soundlevel = 80,
	pitchstart = 100,
	sound = "vehicles/jetski/jetski_no_gas_start.wav"
})

sound.Add({
	name = "zlm_tractor_stall_in_water",
	channel = CHAN_VOICE,
	volume = 1.0,
	soundlevel = 80,
	pitchstart = 100,
	sound = "vehicles/jetski/jetski_off.wav"
})
