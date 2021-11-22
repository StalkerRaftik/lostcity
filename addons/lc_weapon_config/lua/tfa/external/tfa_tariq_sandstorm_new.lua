local path = "weapons/tfa_ins_sandstorm_tariq/"
local pref = "Weapon_Tariq"
local hudcolor = Color(255, 255, 255, 255)

TFA.AddWeaponSound(pref .. ".Empty", path .. "m1911_empty.wav")
TFA.AddWeaponSound(pref .. ".Magrelease", path .. "m1911_magrelease.wav")
TFA.AddWeaponSound(pref .. ".Magin", path .. "m1911_magin.wav")
TFA.AddWeaponSound(pref .. ".Magout", path .. "m1911_magout.wav")
TFA.AddWeaponSound(pref .. ".Boltback", path .. "m9_boltback.wav")
TFA.AddWeaponSound(pref .. ".Boltrelease", path .. "m9_boltrelease.wav")
TFA.AddWeaponSound(pref .. ".MagHit", path .. "m1911_maghit.wav")

if killicon and killicon.Add then
	killicon.Add("tfa_ins_sandstorm_tariq", "vgui/hud/tfa_ins_sandstorm_tariq", hudcolor)
end