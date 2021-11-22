local path = "/weapons/tfa_ins2/usp_match/"
local pref = "TFA_INS2.USP_M"
local hudcolor = Color(255, 80, 0, 191)

TFA.AddFireSound(pref .. ".1", path .. "usp_unsil-1.wav", false, ")")
TFA.AddFireSound(pref .. ".2", path .. "usp1.wav", false, ")")

TFA.AddWeaponSound(pref .. ".Empty", path .. "usp_match_empty.wav")
TFA.AddWeaponSound(pref .. ".Boltback", path .. "usp_match_boltback.wav")
TFA.AddWeaponSound(pref .. ".Boltrelease", path .. "usp_match_boltrelease.wav")
TFA.AddWeaponSound(pref .. ".Magrelease", path .. "usp_match_magrelease.wav")
TFA.AddWeaponSound(pref .. ".Magout", path .. "usp_match_magout.wav")
TFA.AddWeaponSound(pref .. ".Magin", path .. "usp_match_magin.wav")
TFA.AddWeaponSound(pref .. ".MagHit", path .. "usp_match_maghit.wav")

if killicon and killicon.Add then
	killicon.Add("tfa_ins2_usp_match", "vgui/killicons/tfa_ins2_usp_match", hudcolor)
end