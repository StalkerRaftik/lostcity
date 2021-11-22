local path = "weapons/tfa_ins2_imi_uzi/"
local pref = "Weapon_IMIUZI_TFA_N"
local hudcolor = Color(255, 255, 255, 255)

TFA.AddFireSound(pref .. "_1", path .. "uzi_fire.wav", false, ")")

TFA.AddWeaponSound(pref .. ".Hit", path .. "m4a1_maghitrelease.wav")
TFA.AddWeaponSound(pref .. ".Boltback", path .. "aks_boltback.wav")
TFA.AddWeaponSound(pref .. ".MagoutRattle", path .. "aks_magout_rattle.wav")
TFA.AddWeaponSound(pref .. ".Empty", path .. "kar98_empty.wav")
TFA.AddWeaponSound(pref .. ".Magrelease", path .. "m1carbine_para_magrelease.wav")
TFA.AddWeaponSound(pref .. ".Magout", path .. "mp40_magout.wav")
TFA.AddWeaponSound(pref .. ".Magin", path .. "mp40_magin.wav")
TFA.AddWeaponSound(pref .. ".Boltlock", path .. "mp40_boltlock.wav")
TFA.AddWeaponSound(pref .. ".Boltunlock", path .. "mp40_boltunlock.wav")


if killicon and killicon.Add then
	killicon.Add("tfa_ins2_imi_uzi", "vgui/hud/tfa_ins2_imi_uzi", hudcolor)
end