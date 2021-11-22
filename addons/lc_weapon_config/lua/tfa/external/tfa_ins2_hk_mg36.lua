local path = "/weapons/mg36/"
local pref = "TFA_INS2.MG36"

TFA.AddFireSound(pref .. ".Fire", path .. "fire.wav", false, ")")
TFA.AddFireSound(pref .. ".Fire_Suppressed", path .. "fire_suppressed.wav", false, ")")

TFA.AddWeaponSound(pref .. ".Boltback", path .. "boltback.wav")
TFA.AddWeaponSound(pref .. ".Boltrelease", path .. "boltrelease.wav")
TFA.AddWeaponSound(pref .. ".Empty", path .. "empty.wav")
TFA.AddWeaponSound(pref .. ".Magrelease", path .. "magrelease.wav")
TFA.AddWeaponSound(pref .. ".Magout", path .. "magout.wav")
TFA.AddWeaponSound(pref .. ".Magin", path .. "magin.wav")
TFA.AddWeaponSound(pref .. ".Rattle", path .. "rattle.wav")
TFA.AddWeaponSound(pref .. ".ROF", path .. "fireselect.wav")

TFA.AddWeaponSound(pref .. ".Draw", path .. "deploy.wav")
