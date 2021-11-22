local path = "weapons/tfa_ins2/cz805/"
local pref = "TFA_INS2.CZ805"
local hudcolor = Color(255, 80, 0, 191)

sound.Add({
	name = pref .. ".1",
	channel = CHAN_WEAPON,
	level = 140,
	sound = {
		")" .. path .. "fire-1.wav",
		")" .. path .. "fire-2.wav",
		")" .. path .. "fire-3.wav"
	}
})
sound.Add({
	name = pref .. ".2",
	channel = CHAN_WEAPON,
	level = 90,
	sound = ")" .. path .. "fire-sil.wav"
})

TFA.AddWeaponSound(pref .. ".Empty", path .. "empty.wav")
TFA.AddWeaponSound(pref .. ".Boltback", path .. "boltback.wav")
TFA.AddWeaponSound(pref .. ".Boltrelease", path .. "boltforward.wav")
TFA.AddWeaponSound(pref .. ".Magout", path .. "magout.wav")
TFA.AddWeaponSound(pref .. ".Magin", path .. "magin.wav")
TFA.AddWeaponSound(pref .. ".Hit", path .. "maghit.wav")
TFA.AddWeaponSound(pref .. ".ROF", path .. "fireselect.wav")

if killicon and killicon.Add then
	killicon.Add("tfa_ins2_cz805", "vgui/killicons/tfa_ins2_cz805", hudcolor)
end