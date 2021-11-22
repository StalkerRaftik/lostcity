local path = "weapons/tfa_l4d2/eguitar/"
local pref = "TFA_L4D2.EGUITAR"
local hudcolor = Color(255, 80, 0, 191)

TFA.AddWeaponSound(pref .. ".Swing", {path .. "guitar_swing_miss1.wav", path .. "guitar_swing_miss2.wav"})
TFA.AddWeaponSound(pref .. ".HitFlesh", {path .. "melee_guitar_01.wav", path .. "melee_guitar_02.wav", path .. "melee_guitar_03.wav", path .. "melee_guitar_04.wav", path .. "melee_guitar_05.wav", path .. "melee_guitar_06.wav", path .. "melee_guitar_07.wav", path .. "melee_guitar_08.wav", path .. "melee_guitar_09.wav"})
TFA.AddWeaponSound(pref .. ".HitWorld", {path .. "guitar_hit_world_01.wav", path .. "guitar_hit_world_02.wav", path .. "guitar_hit_world_03.wav", path .. "guitar_hit_world_04.wav", path .. "guitar_hit_world_05.wav"})
TFA.AddWeaponSound(pref .. ".BashHit", {path .. "guitarrifle_swing_hit_infected8.wav", path .. "guitarrifle_swing_hit_infected9.wav"})
TFA.AddWeaponSound(pref .. ".BashWorld", {path .. "guitarpunch_boxing_facehit4.wav", path .. "guitarpunch_boxing_facehit5.wav"})
TFA.AddWeaponSound(pref .. ".BashMiss", {path .. "guitarswish_weaponswing_swipe5.wav", path .. "guitarswish_weaponswing_swipe6.wav"})