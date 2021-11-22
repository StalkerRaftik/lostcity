local path = "weapons/tfa_ins2/aksz/"
local pref = "TFA_INS2.AKSZ"

TFA.AddFireSound(pref .. ".1", path .. "aks_fp.wav", false, ")")
TFA.AddFireSound(pref .. ".2", path .. "aks_suppressed_fp.wav", false, ")")

TFA.AddWeaponSound(pref .. ".Empty", path .. "aks_empty.wav")
TFA.AddWeaponSound(pref .. ".Boltback", path .. "aks_boltback.wav")
TFA.AddWeaponSound(pref .. ".Boltrelease", path .. "aks_boltrelease.wav")
TFA.AddWeaponSound(pref .. ".Magout", path .. "aks_magout.wav")
TFA.AddWeaponSound(pref .. ".Magin", path .. "aks_magin.wav")
TFA.AddWeaponSound(pref .. ".Magrelease", path .. "aks_magrelease.wav")
TFA.AddWeaponSound(pref .. ".ROF", {path .. "aks_fireselect_1.wav", path .. "aks_fireselect_2.wav"})
