if SERVER then AddCSLuaFile() end

sound.Add({
	['name'] = "TFA_L4D2_TALOSAXE.Deploy",
	['channel'] = CHAN_STATIC,
	['sound'] = { "weapons/l4d2_talosaxe/rifle_deploy_1.wav" },
	['pitch'] = {95,105},
	['level'] = 80
})

sound.Add({
	['name'] = "TFA_L4D2_TALOSAXE.Swing",
	['channel'] = CHAN_STATIC,
	['sound'] = { "weapons/l4d2_talosaxe/axe_swing_miss1.wav", "weapons/l4d2_talosaxe/axe_swing_miss2.wav"},
	['pitch'] = {95,105}
})
sound.Add({
	['name'] = "TFA_L4D2_TALOSAXE.HitFlesh",
	['channel'] = CHAN_STATIC,
	['sound'] = { "weapons/l4d2_talosaxe/melee_katana_01.wav", "weapons/l4d2_talosaxe/melee_katana_02.wav", "weapons/l4d2_talosaxe/melee_katana_03.wav"},
	['pitch'] = {95,105}
})
sound.Add({
	['name'] = "TFA_L4D2_TALOSAXE.HitWorld",
	['channel'] = CHAN_STATIC,
	['sound'] = { "weapons/l4d2_talosaxe/katana_impact_world1.wav", "weapons/l4d2_talosaxe/katana_impact_world2.wav" },
	['pitch'] = {95,105}
})
