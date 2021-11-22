local path = "weapons/tfa_ins2_mp5k_pdw_hardline/"
local pref = "Weapon_mp5k_NEW"
local hudcolor = Color(255, 255, 255, 255)

TFA.AddFireSound(pref .. "_1", path .. "k2-1.wav", false, ")")
TFA.AddFireSound(pref .. "_2", path .. "k2_sil-1.wav", false, ")")

TFA.AddWeaponSound(pref .. ".Boltlock", path .. "mp5k_boltlock.wav")
TFA.AddWeaponSound(pref .. ".Boltrelease", path .. "mp5k_boltrelease.wav")
TFA.AddWeaponSound(pref .. ".Empty", path .. "mp5k_empty.wav")
TFA.AddWeaponSound(pref .. ".Boltback", path .. "mp5k_boltback.wav")
TFA.AddWeaponSound(pref .. ".MagRelease", path .. "mp5k_magrelease.wav")
TFA.AddWeaponSound(pref .. ".Magout", path .. "mp5k_magout.wav")
TFA.AddWeaponSound(pref .. ".Magin", path .. "mp5k_magin.wav")
TFA.AddWeaponSound(pref .. ".ROF", path .. "mp5k_fireselect.wav")
TFA.AddWeaponSound(pref .. ".ROF", path .. "mp5k_fireselect.wav")

if killicon and killicon.Add then
	killicon.Add("tfa_ins2_mp5k_pdw", "vgui/hud/tfa_ins2_mp5k_pdw", hudcolor)
end