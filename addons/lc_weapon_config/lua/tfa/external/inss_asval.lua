local path = "weapons/tfa_inss/asval/"
local pref = "TFA_INSS.ASVAL"
local hudcolor = Color(255, 80, 0, 191)

TFA.AddFireSound(pref .. ".1", {path .. "fire.wav"}, false, ")")
--TFA.AddFireSound(pref .. ".1", {path .. "ar15_fp1.wav", path .. "ar15_fp2.wav", path .. "ar15_fp3.wav", path .. "ar15_fp4.wav"}, true, ")")

TFA.AddWeaponSound(pref .. ".Empty", path .. "empty.wav")
TFA.AddWeaponSound(pref .. ".Boltback", path .. "slideback.wav")
TFA.AddWeaponSound(pref .. ".Boltrelease", path .. "slideforward.wav")
TFA.AddWeaponSound(pref .. ".Magrelease", path .. "magrelease.wav")
TFA.AddWeaponSound(pref .. ".Magout", path .. "magout.wav")
TFA.AddWeaponSound(pref .. ".Magin", path .. "magin.wav")
TFA.AddWeaponSound(pref .. ".Sprintout", path .. "sprintout.wav")
TFA.AddWeaponSound(pref .. ".Sprintin", path .. "sprintin.wav")
TFA.AddWeaponSound(pref .. ".ADSout", path .. "adsout.wav")
TFA.AddWeaponSound(pref .. ".ADSin", path .. "adsin.wav")
TFA.AddWeaponSound(pref .. ".Guntap", path .. "guntap.wav")
TFA.AddWeaponSound(pref .. ".StockOpen", path .. "stockpull.wav")
TFA.AddWeaponSound(pref .. ".StockLock", path .. "stockend.wav")
TFA.AddWeaponSound(pref .. ".BashHit", path .. "impactflesh.wav")
TFA.AddWeaponSound(pref .. ".BashHitWall", path .. "impactwall.wav")
TFA.AddWeaponSound(pref .. ".Bash", {path .. "bash1.wav", path .. "bash2.wav", path .. "bash3.wav", path .. "bash4.wav" } )
TFA.AddWeaponSound(pref .. ".Rustle", {path .. "rustle1.wav", path .. "rustle2.wav", path .. "rustle3.wav"} )

if killicon and killicon.Add then
	killicon.Add("tfa_inss_asval", "vgui/killicons/tfa_inss_asval", hudcolor)
end