local path = "weapons/tfa_ins2/sks/"
local pref = "TFA_INS2.SKS"
local hudcolor = Color(255, 80, 0, 191)

TFA.AddFireSound(pref .. ".1", path .. "sks_fire01.wav", false, ")")
TFA.AddFireSound(pref .. ".2", path .. "sks_suppressed_fp.wav", false, ")")

TFA.AddWeaponSound(pref .. ".Empty", path .. "sks_empty.wav")
TFA.AddWeaponSound(pref .. ".Magrelease", path .. "sks_magrelease.wav")
TFA.AddWeaponSound(pref .. ".Magin", path .. "sks_magazine_in.wav")
TFA.AddWeaponSound(pref .. ".Magout", path .. "sks_magazine_out.wav")
TFA.AddWeaponSound(pref .. ".Boltback", path .. "sks_boltpull.wav")
TFA.AddWeaponSound(pref .. ".Boltrelease", path .. "sks_boltrelease.wav")

if killicon and killicon.Add then
	killicon.Add("tfa_ins2_sks", "vgui/killicons/tfa_ins2_sks", hudcolor)
end