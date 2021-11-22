local path = "weapons/tfa_ins2/mk18/"
local pref = "TFA_INS2.MK18"
local hudcolor = Color(255, 80, 0, 191)

TFA.AddFireSound(pref .. ".1", path .. "mk18_fp.wav", false, ")")
TFA.AddFireSound(pref .. ".2", path .. "mk18_suppressed_fp.wav", false, ")")

TFA.AddWeaponSound(pref .. ".Empty", path .. "mk18_empty.wav")
TFA.AddWeaponSound(pref .. ".Boltback", path .. "mk18_boltback.wav")
TFA.AddWeaponSound(pref .. ".Boltrelease", path .. "mk18_boltrelease.wav")
TFA.AddWeaponSound(pref .. ".Magrelease", path .. "mk18_magrelease.wav")
TFA.AddWeaponSound(pref .. ".Magout", path .. "mk18_magout.wav")
TFA.AddWeaponSound(pref .. ".Magin", path .. "mk18_magin.wav")
TFA.AddWeaponSound(pref .. ".Hit", path .. "mk18_hit.wav")
TFA.AddWeaponSound(pref .. ".Rattle", path .. "mk18_rattle.wav")

if killicon and killicon.Add then
	killicon.Add("tfa_ins2_mk18", "vgui/killicons/tfa_ins2_mk18", hudcolor)
end