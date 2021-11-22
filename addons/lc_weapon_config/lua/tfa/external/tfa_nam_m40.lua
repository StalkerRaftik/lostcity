local path = "weapons/tfa_nam_m40/"
local pref = "Weapon_M400"
local hudcolor = Color(255, 255, 255, 255)

TFA.AddFireSound(pref .. "_1", path .. "m40a1_fp.wav", false, ")")

TFA.AddWeaponSound(pref .. ".BoltRelease", path .. "m40a1_boltrelease.wav")
TFA.AddWeaponSound(pref .. ".Boltback", path .. "m40a1_boltback.wav")
TFA.AddWeaponSound(pref .. ".Boltforward", path .. "m40a1_boltforward.wav")
TFA.AddWeaponSound(pref .. ".Empty", path .. "m40a1_empty.wav")
TFA.AddWeaponSound(pref .. ".BoltLatch", path .. "m40a1_boltlatch.wav")
TFA.AddWeaponSound(pref .. ".Rattle", path .. "ak47_rattle.wav")
TFA.AddWeaponSound(pref .. ".Roundin", path .. "m40a1_bulletin_1.wav")


if killicon and killicon.Add then
	killicon.Add("tfa_nam_m40", "vgui/hud/tfa_nam_m40", hudcolor)
end