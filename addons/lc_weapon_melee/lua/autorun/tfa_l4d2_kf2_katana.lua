if SERVER then AddCSLuaFile() end

sound.Add({
	['name'] = "TFA_L4D2_KF2_KATANA.Deploy",
	['channel'] = CHAN_STATIC,
	['sound'] = { "weapons/l4d2_kf2_katana/knife_deploy.wav" },
	['pitch'] = {95,105}
})

sound.Add({
	['name'] = "TFA_L4D2_KF2_KATANA.Swing",
	['channel'] = CHAN_STATIC,
	['sound'] = { "weapons/l4d2_kf2_katana/katana_swing_miss1.wav", "weapons/l4d2_kf2_katana/katana_swing_miss2.wav"},
	['pitch'] = {95,105}
})
sound.Add({
	['name'] = "TFA_L4D2_KF2_KATANA.HitFlesh",
	['channel'] = CHAN_STATIC,
	['sound'] = { "weapons/l4d2_kf2_katana/melee_katana_01.wav", "weapons/l4d2_kf2_katana/melee_katana_02.wav", "weapons/l4d2_kf2_katana/melee_katana_03.wav"},
	['pitch'] = {95,105}
})
sound.Add({
	['name'] = "TFA_L4D2_KF2_KATANA.HitWorld",
	['channel'] = CHAN_STATIC,
	['sound'] = { "weapons/l4d2_kf2_katana/katana_impact_world1.wav", "weapons/l4d2_kf2_katana/katana_impact_world2.wav" },
	['pitch'] = {95,105}
})
