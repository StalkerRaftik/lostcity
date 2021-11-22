local path = "weapons/tfa_ins2/xm8/"
local pref = "TFA_INS2.XM8"
local hudcolor = Color(255, 80, 0, 191)

TFA.AddFireSound(pref .. ".1", path .. "mk18_fp.wav", false, ")")
TFA.AddFireSound(pref .. ".2", path .. "mk18_suppressed_fp.wav", false, ")")

TFA.AddWeaponSound(pref .. ".Empty", path .. "handling/mk18_empty.wav")
TFA.AddWeaponSound(pref .. ".Boltback", path .. "handling/mk18_boltback.wav")
TFA.AddWeaponSound(pref .. ".Boltrelease", path .. "handling/mk18_boltrelease.wav")
TFA.AddWeaponSound(pref .. ".Magdrop", path .. "handling/sterling_magout.wav")
TFA.AddWeaponSound(pref .. ".Magrelease", path .. "handling/mk18_magrelease.wav")
TFA.AddWeaponSound(pref .. ".Magout", path .. "handling/mk18_magout.wav")
TFA.AddWeaponSound(pref .. ".Magin", path .. "handling/mk18_magin.wav")
TFA.AddWeaponSound(pref .. ".Hit", path .. "handling/mk18_hit.wav")
TFA.AddWeaponSound(pref .. ".ROF", path .. "handling/mk18_fireselect.wav")

TFA.AddWeaponSound(pref .. ".BipodSwivel", {path .. "uni_bipod_swivel_01.wav", path .. "uni_bipod_swivel_02.wav", path .. "uni_bipod_swivel_03.wav", path .. "uni_bipod_swivel_04.wav", path .. "uni_bipod_swivel_05.wav"})

if killicon and killicon.Add then
	killicon.Add("tfa_ins2_xm8", "vgui/killicons/tfa_ins2_xm8", hudcolor)
end