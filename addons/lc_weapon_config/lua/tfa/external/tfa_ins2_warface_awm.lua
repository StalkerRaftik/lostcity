local path = "weapons/warface_awm/"
local pref = "TFA_INS2.Warface_AWM"

TFA.AddFireSound( pref .. ".Fire", {path .. "awm_fire.wav"})
TFA.AddFireSound( pref .. ".Fire_Suppressed", {path .. "awm_fire_suppressed.wav"})

TFA.AddWeaponSound( pref .. ".BoltRelease", path .. "awm_boltup.wav" )
TFA.AddWeaponSound( pref .. ".Boltback", path .. "awm_boltrelease.wav" )
TFA.AddWeaponSound( pref .. ".Boltforward", path .. "awm_boltback.wav" )
TFA.AddWeaponSound( pref .. ".BoltLatch", path .. "awm_boltdown.wav" )

TFA.AddWeaponSound( pref .. ".Magrelease", path .. "awm_magrelease.wav" )
TFA.AddWeaponSound( pref .. ".Magout", path .. "awm_magout.wav" )
TFA.AddWeaponSound( pref .. ".Magin", path .. "awm_magin.wav" )

TFA.AddWeaponSound( pref .. ".Empty", path .. "awm_empty.wav" )