local path = "weapons/tfa_ins2/mp7/"
local pref = "TFA_INS2.MP7"
local hudcolor = Color(255, 80, 0, 191)

TFA.AddFireSound(pref .. ".1", path .. "fp.wav", false, ")")
TFA.AddFireSound(pref .. ".2", path .. "fp_suppressed.wav", false, ")")

TFA.AddWeaponSound("TFA_INS2.BipodSwivel", { "weapons/tfa_ins2/uni/uni_bipod_swivel_01.wav", "weapons/tfa_ins2/uni/uni_bipod_swivel_02.wav", "weapons/tfa_ins2/uni/uni_bipod_swivel_03.wav", "weapons/tfa_ins2/uni/uni_bipod_swivel_04.wav", "weapons/tfa_ins2/uni/uni_bipod_swivel_05.wav" })

TFA.AddWeaponSound(pref .. ".Empty", path .. "empty.wav")
TFA.AddWeaponSound(pref .. ".Boltback", path .. "boltback.wav")
TFA.AddWeaponSound(pref .. ".Boltrelease", path .. "boltrelease.wav")
TFA.AddWeaponSound(pref .. ".Magrelease", path .. "magrelease.wav")
TFA.AddWeaponSound(pref .. ".Magout", path .. "magout.wav")
TFA.AddWeaponSound(pref .. ".Magin", path .. "magin.wav")
TFA.AddWeaponSound(pref .. ".ROF", path .. "fireselect.wav")

if killicon and killicon.Add then
	killicon.Add("tfa_ins2_mp7", "vgui/killicons/tfa_ins2_mp7", hudcolor)
end