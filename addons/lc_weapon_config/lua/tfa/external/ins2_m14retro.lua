local path = "/weapons/tfa_ins2/springm14/"
local pref = "TFA_INS2.SPRINGM14"
local hudcolor = Color(255, 80, 0, 191)

TFA.AddFireSound(pref .. ".1", path .. "m14_fp.wav", false, ")")
TFA.AddFireSound(pref .. ".2", path .. "m14_suppressed_fp.wav", false, ")")

TFA.AddWeaponSound(pref .. ".Empty", path .. "m14_empty.wav")
TFA.AddWeaponSound(pref .. ".Magrelease", path .. "m14_magrelease.wav")
TFA.AddWeaponSound(pref .. ".Boltback", path .. "m14_boltback.wav")
TFA.AddWeaponSound(pref .. ".Boltbackslap", path .. "m14_boltbackslap.wav")
TFA.AddWeaponSound(pref .. ".Boltrelease", path .. "m14_boltrelease.wav")
TFA.AddWeaponSound(pref .. ".Boltslap", path .. "m14_boltslap.wav")
TFA.AddWeaponSound(pref .. ".Magrelease", path .. "m14_magrelease.wav")
TFA.AddWeaponSound(pref .. ".Magout", path .. "m14_magout.wav")
TFA.AddWeaponSound(pref .. ".Magoutrattle", path .. "m14_magout_rattle.wav")
TFA.AddWeaponSound(pref .. ".Magin", path .. "m14_magin.wav")

if killicon and killicon.Add then
	killicon.Add("tfa_ins2_m14retro", "vgui/killicons/tfa_ins2_m14retro", hudcolor)
end