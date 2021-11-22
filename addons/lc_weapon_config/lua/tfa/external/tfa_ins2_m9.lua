local path = "weapons/tfa_ins2/m9/"
local pref = "TFA_INS2.M9"
local hudcolor = Color(255, 80, 0, 191)

TFA.AddFireSound(pref .. ".1", {path .. "fire_1.wav", path .. "fire_2.wav", path .. "fire_3.wav"}, false, ")")
TFA.AddFireSound(pref .. ".2", path .. "fire_sil.wav", false, ")")

TFA.AddWeaponSound(pref .. ".Boltback", path .. "handling/m9_boltback.wav")
TFA.AddWeaponSound(pref .. ".Boltrelease", path .. "handling/m9_boltrelease.wav")
TFA.AddWeaponSound(pref .. ".Empty", path .. "handling/m9_empty.wav")
TFA.AddWeaponSound(pref .. ".Magrelease", path .. "handling/m9_magrelease.wav")
TFA.AddWeaponSound(pref .. ".Magout", path .. "handling/m9_magout.wav")
TFA.AddWeaponSound(pref .. ".Magin", path .. "handling/m9_magin.wav")
TFA.AddWeaponSound(pref .. ".MagHit", path .. "handling/m9_maghit.wav")

if killicon and killicon.Add then
	killicon.Add("tfa_ins2_m9", "vgui/killicons/tfa_ins2_m9", hudcolor)
end