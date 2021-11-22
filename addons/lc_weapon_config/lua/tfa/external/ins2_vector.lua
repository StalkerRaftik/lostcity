local path = "weapons/tfa_ins2/vector/"
local pref = "TFA_INS2.VECTOR"
local hudcolor = Color(255, 80, 0, 191)

TFA.AddSound(pref .. ".FireLoop", CHAN_WEAPON, 1, 140, 100, path .. "kriss_loop2.wav", ")")
TFA.AddSound(pref .. ".FireLoop_Tail", CHAN_WEAPON, 1, 140, 100, path .. "kriss_loop_tail.wav", ")")

TFA.AddSound(pref .. ".FireLoop_Silenced", CHAN_WEAPON, 1, 120, 100, path .. "kriss_close_silenced_loop.wav", ")")
TFA.AddSound(pref .. ".FireLoop_Silenced_Tail", CHAN_WEAPON, 1, 120, 100, path .. "kriss_close_silenced_loop_tail.wav", ")")

TFA.AddSound(pref .. ".MagInFoley", CHAN_STATIC, 1, 90, {98, 102}, path .. "handling/maginfoley.wav", "")
TFA.AddSound(pref .. ".MagTransition", CHAN_STATIC, 1, 90, 100, path .. "handling/magtransition.wav", "")
TFA.AddSound(pref .. ".ReturnToIdle", CHAN_STATIC, 1, 90, {98, 102}, path .. "handling/returntoidle.wav", "")
TFA.AddSound(pref .. ".StartReload", CHAN_STATIC, 1, 90, {98, 102}, path .. "handling/startreload.wav", "")

TFA.AddWeaponSound(pref .. ".MagHit", path .. "handling/maghit.wav")
TFA.AddWeaponSound(pref .. ".MagIn", path .. "handling/magin.wav")
TFA.AddWeaponSound(pref .. ".MagOut", path .. "handling/magout.wav")
TFA.AddWeaponSound(pref .. ".MagRelease", path .. "handling/magrelease.wav")
TFA.AddWeaponSound(pref .. ".BoltUnlock", path .. "handling/boltunlock.wav", "")
TFA.AddWeaponSound(pref .. ".Empty", path .. "handling/empty.wav", "")
TFA.AddWeaponSound(pref .. ".ROF", path .. "handling/fireselect.wav", "")
TFA.AddWeaponSound(pref .. ".BoltBack", path .. "handling/boltback.wav")
TFA.AddWeaponSound(pref .. ".BoltRelease", path .. "handling/boltrelease.wav")

if killicon and killicon.Add then
	killicon.Add("tfa_ins2_vector", "vgui/killicons/tfa_ins2_vector", hudcolor)
end