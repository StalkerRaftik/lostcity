local path = "weapons/tfa_ins2_gsh18/"
local pref = "Weapon_GSH18_TFA"
local hudcolor = Color(255, 255, 255, 255)

TFA.AddFireSound(pref .. "_1", path .. "m9_fp.wav", false, ")")
TFA.AddFireSound(pref .. "_2", path .. "m9_suppressed_fp.wav", false, ")")

TFA.AddWeaponSound(pref .. ".Empty", path .. "makarov_empty.wav")
TFA.AddWeaponSound(pref .. ".Magrelease", path .. "makarov_magrelease.wav")
TFA.AddWeaponSound(pref .. ".Magin", path .. "makarov_magin.wav")
TFA.AddWeaponSound(pref .. ".Magout", path .. "makarov_magout.wav")
TFA.AddWeaponSound(pref .. ".Boltback", path .. "makarov_boltback.wav")
TFA.AddWeaponSound(pref .. ".Boltrelease", path .. "makarov_boltrelease.wav")
TFA.AddWeaponSound(pref .. ".Magrelease", path .. "makarov_magrelease.wav")
TFA.AddWeaponSound(pref .. ".MagHit", path .. "makarov_maghit.wav")

if killicon and killicon.Add then
	killicon.Add("tfa_ins2_gsh18", "vgui/hud/tfa_ins2_gsh18", hudcolor)
end