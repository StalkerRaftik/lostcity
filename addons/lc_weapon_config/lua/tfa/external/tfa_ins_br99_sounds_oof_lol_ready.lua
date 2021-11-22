local path = "weapons/tfa_ins2_br99/"
local pref = "Weapon_BR99"
local hudcolor = Color(255, 255, 255, 255)

TFA.AddWeaponSound(pref .. ".Boltrelease", path .. "m16_boltrelease.wav")
TFA.AddWeaponSound(pref .. ".Boltback", path .. "m16_boltback.wav")
TFA.AddWeaponSound(pref .. ".Magrelease", path .. "m16_magrelease.wav")
TFA.AddWeaponSound(pref .. ".Empty", path .. "m16_empty.wav")
TFA.AddWeaponSound(pref .. ".Magout", path .. "m16_magout.wav")
TFA.AddWeaponSound(pref .. ".Magin", path .. "m16_magin.wav")
TFA.AddWeaponSound(pref .. ".Hit", path .. "m16_hit.wav")
TFA.AddWeaponSound(pref .. ".ROF", path .. "m16_fireselect.wav")


if killicon and killicon.Add then
	killicon.Add("tfa_ins2_br99", "vgui/hud/tfa_ins2_br99", hudcolor)
end