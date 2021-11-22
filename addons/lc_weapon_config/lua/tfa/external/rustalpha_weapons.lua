TFA.RUSTALPHA = TFA.RUSTALPHA or {}

if killicon and killicon.Add then
	local color_white = color_white

	killicon.Add("tfa_rustalpha_bolt_action_rifle", "vgui/entities/tfa_rustalpha_bolt_action_rifle", color_white)
	killicon.Add("tfa_rustalpha_f1_grenade", "vgui/entities/tfa_rustalpha_f1_grenade", color_white)
	killicon.AddAlias("tfa_rustalpha_f1_thrown", "tfa_rustalpha_f1_grenade")
	killicon.Add("tfa_rustalpha_flare", "vgui/entities/tfa_rustalpha_flare", color_white)
	killicon.AddAlias("tfa_rustalpha_flare_thrown", "tfa_rustalpha_flare")
	killicon.Add("tfa_rustalpha_handcannon", "vgui/entities/tfa_rustalpha_handcannon", color_white)
	killicon.Add("tfa_rustalpha_hatchet", "vgui/entities/tfa_rustalpha_hatchet", color_white)
	killicon.Add("tfa_rustalpha_hunting_bow", "vgui/entities/tfa_rustalpha_hunting_bow", color_white)
	killicon.Add("tfa_rustalpha_m4", "vgui/entities/tfa_rustalpha_m4", color_white)
	killicon.Add("tfa_rustalpha_mp5", "vgui/entities/tfa_rustalpha_mp5", color_white)
	killicon.Add("tfa_rustalpha_p250", "vgui/entities/tfa_rustalpha_p250", color_white)
	killicon.Add("tfa_rustalpha_pickaxe", "vgui/entities/tfa_rustalpha_pickaxe", color_white)
	killicon.Add("tfa_rustalpha_pipeshotgun", "vgui/entities/tfa_rustalpha_pipeshotgun", color_white)
	killicon.Add("tfa_rustalpha_pistol", "vgui/entities/tfa_rustalpha_pistol", color_white)
	killicon.Add("tfa_rustalpha_revolver", "vgui/entities/tfa_rustalpha_revolver", color_white)
	killicon.Add("tfa_rustalpha_rocktool", "vgui/entities/tfa_rustalpha_rocktool", color_white)
	killicon.Add("tfa_rustalpha_shotgun", "vgui/entities/tfa_rustalpha_shotgun", color_white)
	killicon.Add("tfa_rustalpha_stone_hatchet", "vgui/entities/tfa_rustalpha_stone_hatchet", color_white)
	killicon.Add("tfa_rustalpha_torch", "vgui/entities/tfa_rustalpha_torch", color_white)
end

if game and game.AddAmmoType then
	game.AddAmmoType({ name = "yurie_rustalpha_arrow" })
	game.AddAmmoType({ name = "yurie_rustalpha_flare" })
	game.AddAmmoType({ name = "yurie_rustalpha_handmade_shell" })
end

if language and language.Add then
	language.Add("yurie_rustalpha_arrow_ammo", "Arrows")
	language.Add("yurie_rustalpha_flare_ammo", "Flares")
	language.Add("yurie_rustalpha_handmade_shell_ammo", "Handmade Shells")
end

local dir = "weapons/yurie_rustalpha/"
local pref = "YURIE_RUSTALPHA."

TFA.AddWeaponSound(pref .. "Draw", dir .. "shared/draw_generic_rustle.ogg", "")

TFA.AddWeaponSound(pref .. "AttachSight", dir .. "mod/attachment_on.wav", "")
TFA.AddWeaponSound(pref .. "AttachLight", dir .. "mod/attachment_on2.ogg", "")
TFA.AddWeaponSound(pref .. "AttachSilencer", dir .. "mod/silencer_on.wav", "")

-- Melee
TFA.AddFireSound(pref .. "Melee.Swing", dir .. "hatchet/swing.ogg", false, "")

TFA.AddWeaponSound(pref .. "Melee.ImpactFlesh", {
	dir .. "hatchet/melee_body_hit-1.wav",
	dir .. "hatchet/melee_body_hit-2.wav"
}, "")
TFA.AddWeaponSound(pref .. "Melee.ImpactGeneric", dir .. "hatchet/impact_generic.ogg", "")
TFA.AddWeaponSound(pref .. "Melee.ImpactWood", dir .. "hatchet/impact_wood.ogg", "")

-- Bolt Rifle
TFA.AddFireSound(pref .. "Bolt.1", dir .. "boltactionrifle/boltrifle_fire_boosted.wav", false, "")
TFA.AddFireSound(pref .. "Bolt.2", dir .. "boltactionrifle/boltrifle_fire_silenced.wav", false, "")

TFA.AddWeaponSound(pref .. "Bolt.Draw", dir .. "boltactionrifle/boltrifle_draw.wav", "")
TFA.AddWeaponSound(pref .. "Bolt.Reload", dir .. "boltactionrifle/boltrifle_multireload.wav", "")

-- M4
TFA.AddFireSound(pref .. "M4.1", dir .. "m4/danieldefensem4-2.wav", false, ")")
TFA.AddFireSound(pref .. "M4.2", dir .. "mod/silenced_shot.wav", false, "")

TFA.AddWeaponSound(pref .. "M4.Draw", dir .. "m4/m4_deploy.wav")
TFA.AddWeaponSound(pref .. "M4.Reload", dir .. "gsr1911_reload-1.wav")

-- P250
TFA.AddFireSound(pref .. "P250.1", dir .. "pistol/pistol_fire_5.ogg", false, "")
TFA.AddFireSound(pref .. "P250.2", dir .. "effect/silencer_2.ogg", false, "")

TFA.AddWeaponSound(pref .. "P250.Draw", dir .. "vertec/deploy.wav")
TFA.AddWeaponSound(pref .. "P250.Reload", dir .. "gsr1911_reload-1.wav")

-- Revolver
TFA.AddFireSound(pref .. "REVOLVER.1", dir .. "revolver/revolver_fire.wav", false, "")
TFA.AddFireSound(pref .. "REVOLVER.2", dir .. "effect/silencer_2.ogg", false, "")

TFA.AddWeaponSound(pref .. "REVOLVER.Draw", dir .. "revolver/revolver_draw_cocking.wav", "")
TFA.AddWeaponSound(pref .. "REVOLVER.Reload", dir .. "revolver/revolver_reload_placeholder.wav", "")

-- Bow
TFA.AddFireSound(pref .. "BOW.1", dir .. "bow/bow_fire.ogg", false, ")")

TFA.AddWeaponSound(pref .. "BOW.Draw", dir .. "bow/bow_deploy.ogg", "")
TFA.AddWeaponSound(pref .. "BOW.DrawArrow", dir .. "bow/bow_draw_arrow.ogg", "")
TFA.AddWeaponSound(pref .. "BOW.DrawCancel", dir .. "bow/bow_draw_cancel.ogg", "")

-- Pipe Shotgun
TFA.AddFireSound(pref .. "WATERPIPE.1", dir .. "pipeshotgun/waterpipe_fire.ogg", false, "")

TFA.AddWeaponSound(pref .. "WATERPIPE.Reload", dir .. "pipeshotgun/waterpipe_reload.ogg", "")

-- Shotgun
TFA.AddFireSound(pref .. "FP6.1", dir .. "fp6/shotgun_fire.ogg", false, "")
TFA.AddFireSound(pref .. "FP6.2", dir .. "effect/silenced_shot.wav", false, "")

TFA.AddWeaponSound(pref .. "FP6.Draw", dir .. "fp6/shotgun_deploy.ogg", "")
TFA.AddWeaponSound(pref .. "FP6.Reload", dir .. "fp6/shotgun_reload.ogg", "")

-- MP5A4
TFA.AddFireSound(pref .. "MP5.1", dir .. "mp5/mp5_fire-3.ogg", false, "")
TFA.AddFireSound(pref .. "MP5.2", dir .. "effect/silencer_2.ogg", false, "")

TFA.AddWeaponSound(pref .. "MP5.Draw", dir .. "mp5/mp5_deploy-1.wav", "")
TFA.AddWeaponSound(pref .. "MP5.Reload", dir .. "mp5/mp5_reload-1.wav", "")

-- Vertec
TFA.AddFireSound(pref .. "9MM.1", dir .. "pistol/pistol_fire_3.wav", false, "")
TFA.AddFireSound(pref .. "9MM.2", dir .. "effect/silencer_2.ogg", false, "")

TFA.AddWeaponSound(pref .. "9MM.Draw", dir .. "vertec/deploy.wav", "")
TFA.AddWeaponSound(pref .. "9MM.Reload", dir .. "gsr1911_reload-1.wav", "")

-- F1 Grenade
TFA.AddWeaponSound(pref .. "F1.Arm", dir .. "grenade_arm.ogg", "")

sound.Add({name = pref .. "F1.Bounce", channel = CHAN_VOICE, level = 75, sound = dir .. "grenade_bounce_1.ogg"})
sound.Add({name = pref .. "F1.Explosion", channel = CHAN_STATIC, level = 140, sound = dir .. "grenade_explosion.ogg"})

-- Flare
TFA.AddWeaponSound(pref .. "Flare.Strike", dir .. "flare/flare_strike.ogg")

sound.Add({name = pref .. "Flare.Loop", channel = CHAN_STREAM, level = 60, volume = 0.5, sound = dir .. "flare/flare_loop.wav"})

-- HandCannon
TFA.AddFireSound(pref .. "EOKA.1", dir .. "handcannon/fire.ogg", false, "")

TFA.AddWeaponSound(pref .. "EOKA.Reload", dir .. "handcannon/reload.ogg")
TFA.AddWeaponSound(pref .. "EOKA.Strike1", dir .. "handcannon/strike1.ogg", "")
TFA.AddWeaponSound(pref .. "EOKA.Strike2", dir .. "handcannon/strike2.ogg", "")
TFA.AddWeaponSound(pref .. "EOKA.Strike3", dir .. "handcannon/strike3.ogg", "")
