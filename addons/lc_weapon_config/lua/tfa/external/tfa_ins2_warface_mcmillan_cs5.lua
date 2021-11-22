local path = "weapons/warface_mcmillan_cs5/"
local pref = "TFA_INS2.Warface_McMillan_CS5"

TFA.AddFireSound( pref .. ".Fire", {path .. "cs5_fire_suppressed.wav"})
-- TFA.AddFireSound( pref .. ".Fire_Suppressed", {path .. "cs5_fire_suppressed.wav"})

TFA.AddWeaponSound( pref .. ".BoltRelease", path .. "cs5_boltforward.wav" )
TFA.AddWeaponSound( pref .. ".Boltback", path .. "cs5_boltback.wav" )
TFA.AddWeaponSound( pref .. ".Boltforward", path .. "cs5_boltup.wav" )
TFA.AddWeaponSound( pref .. ".BoltLatch", path .. "cs5_boltdown.wav" )

TFA.AddWeaponSound( pref .. ".Magrelease", path .. "cs5_magrelease.wav" )
TFA.AddWeaponSound( pref .. ".Magout", path .. "cs5_magout.wav" )
TFA.AddWeaponSound( pref .. ".Magin", path .. "cs5_magin.wav" )
TFA.AddWeaponSound( pref .. ".Maghit", path .. "cs5_maghit.wav" )

TFA.AddWeaponSound( pref .. ".Empty", path .. "cs5_empty.wav" )