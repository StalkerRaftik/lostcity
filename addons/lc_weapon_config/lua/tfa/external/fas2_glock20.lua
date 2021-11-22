local path = "weapons/tfa_fas2/glock20/"
local pref = "TFA_FAS2.Glock20"
local hudcolor = Color(255, 80, 0, 191)

TFA.AddFireSound(pref .. ".1", path .. "glock20_fire1.wav", true, ")")
TFA.AddFireSound(pref .. ".2", path .. "glock20_suppressed_fire1.wav", true, ")")

TFA.AddWeaponSound(pref .. ".SlideForward", path .. "glock20_sliderelease.wav")
TFA.AddWeaponSound(pref .. ".MagIn", path .. "glock20_magin.wav")
TFA.AddWeaponSound(pref .. ".MagOut", path .. "glock20_magout.wav")
TFA.AddWeaponSound(pref .. ".MagOutEmpty", path .. "glock20_magout_empty.wav")
