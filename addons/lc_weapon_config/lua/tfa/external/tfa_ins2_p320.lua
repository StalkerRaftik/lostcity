local path = "weapons/p230/"
local pref = "Weapon_P320"
local hudcolor = Color(255, 255, 255, 255)

TFA.AddFireSound(pref .. "_1", path .. "m9_fp.wav", false, ")")
TFA.AddFireSound(pref .. "_2", path .. "m9_suppressed_fp.wav", false, ")")

TFA.AddWeaponSound(pref .. ".Empty", path .. "m9_empty.wav")
TFA.AddWeaponSound(pref .. ".Magrelease", path .. "m9_magrelease.wav")
TFA.AddWeaponSound(pref .. ".Magin", path .. "m9_magazine_in.wav")
TFA.AddWeaponSound(pref .. ".Magout", path .. "m9_magazine_out.wav")
TFA.AddWeaponSound(pref .. ".Boltback", path .. "m9_boltback.wav")
TFA.AddWeaponSound(pref .. ".Boltrelease", path .. "m9_boltrelease.wav")
TFA.AddWeaponSound(pref .. ".Magrelease", path .. "m9_magrelease.wav")
TFA.AddWeaponSound(pref .. ".MagHit", path .. "m9_maghit.wav")

if killicon and killicon.Add then
	killicon.Add("tfa_ins2_p320", "vgui/hud/tfa_ins2_p320", hudcolor)
end