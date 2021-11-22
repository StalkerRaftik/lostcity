local path = "weapons/tfa_ins2/deagle/"
local pref = "TFA_INS2.DEAGLE"
local hudcolor = Color(255, 80, 0, 191)

TFA.AddFireSound(pref .. ".1", path .. "de_single.wav", false, ")")
TFA.AddFireSound(pref .. ".2", path .. "de_single_silenced.wav", false, ")")

TFA.AddWeaponSound(pref .. ".Boltback", path .. "handling/deagle_boltback.wav")
TFA.AddWeaponSound(pref .. ".Boltrelease", path .. "handling/deagle_boltrelease.wav")
TFA.AddWeaponSound(pref .. ".Boltslap", path .. "handling/deagle_boltslap.wav")
TFA.AddWeaponSound(pref .. ".Boltbackslap", path .. "handling/deagle_boltbackslap.wav")
TFA.AddWeaponSound(pref .. ".Empty", path .. "handling/deagle_empty.wav")
TFA.AddWeaponSound(pref .. ".Magrelease", path .. "handling/deagle_magrelease.wav")
TFA.AddWeaponSound(pref .. ".Magout", path .. "handling/deagle_magout.wav")
TFA.AddWeaponSound(pref .. ".Magin", path .. "handling/deagle_magin.wav")
TFA.AddWeaponSound(pref .. ".MagHit", path .. "handling/deagle_maghit.wav")

if killicon and killicon.Add then
	killicon.Add("tfa_ins2_deagle", "vgui/killicons/tfa_ins2_deagle", hudcolor)
end