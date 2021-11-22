local path = "weapons/tfa_ins2/pm/"
local pref = "TFA_INS2.PM"
local hudcolor = Color(255, 80, 0, 191)

TFA.AddSound(pref .. ".1", CHAN_WEAPON, 0.6, 140, {99, 101}, path .. "makarov_fp.wav", ")")
TFA.AddSound(pref .. ".2", CHAN_WEAPON, 0.6, 95, {99, 101}, path .. "makarov_suppressed_fp.wav", ")")

TFA.AddWeaponSound(pref .. ".Boltback", path .. "handling/makarov_boltback.wav")
TFA.AddWeaponSound(pref .. ".Boltrelease", path .. "handling/makarov_boltrelease.wav")
TFA.AddWeaponSound(pref .. ".Empty", path .. "handling/makarov_empty.wav")
TFA.AddWeaponSound(pref .. ".MagHit", path .. "handling/makarov_maghit.wav")
TFA.AddWeaponSound(pref .. ".Magin", path .. "handling/makarov_magin.wav")
TFA.AddWeaponSound(pref .. ".Magout", path .. "handling/makarov_magout.wav")
TFA.AddWeaponSound(pref .. ".Magrelease", path .. "handling/makarov_magrelease.wav")
TFA.AddWeaponSound(pref .. ".Safety", path .. "handling/makarov_safety.wav")

TFA.AddSound(pref .. ".SlideLock", CHAN_AUTO, 1, 120, 125, path .. "handling/makarov_boltback.wav", ")")

if killicon and killicon.Add then
	killicon.Add("tfa_ins2_pm", "vgui/killicons/tfa_ins2_pm", hudcolor)
end