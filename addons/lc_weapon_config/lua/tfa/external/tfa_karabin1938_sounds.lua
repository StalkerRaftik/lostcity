local path = "weapons/tfa_ww2_karabin1938/"
local pref = "TFA_WW2_Karabin1938"
local hudcolor = Color(255, 255, 255, 255)

TFA.AddWeaponSound(pref .. ".Boltback", path .. "karabin1938_boltback.wav")
TFA.AddWeaponSound(pref .. ".Boltrelease", path .. "karabin1938_boltrelease.wav")
TFA.AddWeaponSound(pref .. ".Magin", path .. "karabin1938_magin.wav")
TFA.AddWeaponSound(pref .. ".Bulletsin", path .. "karabin1938_roundsin.wav")
TFA.AddWeaponSound(pref .. ".Clipremove", path .. "karabin1938_clipremove.wav")

if killicon and killicon.Add then
	killicon.Add("tfa_ww2_karabin1938", "vgui/hud/tfa_ww2_karabin1938", hudcolor)
end