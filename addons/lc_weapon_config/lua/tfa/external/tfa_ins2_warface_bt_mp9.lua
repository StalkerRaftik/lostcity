local path = "/weapons/bt_mp9/"
local pref = "TFA_INS2.Warface_BT_MP9"

TFA.AddFireSound(pref .. ".Fire", {path .. "mp9_fire.wav"})
TFA.AddFireSound(pref .. ".Fire_Suppressed", {path .. "mp9_fire_suppressed.wav"})

TFA.AddWeaponSound(pref .. ".Empty", path .. "mp5k_empty.wav")

TFA.AddWeaponSound(pref .. ".Magout", path .. "mp9_magout.wav")
TFA.AddWeaponSound(pref .. ".Magrelease", path .. "mp5k_magrelease.wav")
TFA.AddWeaponSound(pref .. ".Magin", path .. "mp9_magin.wav")

TFA.AddWeaponSound(pref .. ".Boltback", path .. "mp9_boltback.wav")
TFA.AddWeaponSound(pref .. ".Boltslap", path .. "mp9_boltback.wav")
TFA.AddWeaponSound(pref .. ".Boltrelease", path .. "mp9_boltrelease.wav")
TFA.AddWeaponSound(pref .. ".Boltlock", path .. "mp9_boltlock.wav")

TFA.AddWeaponSound(pref .. ".ROF", path .. "mp5k_rof.wav")