local path = "weapons/warface_amp_dsr1/"
local pref = "TFA_INS2.Warface_AMP_DSR1"

TFA.AddFireSound( pref .. ".Fire", {path .. "dsr1_fp.wav"})
TFA.AddFireSound( pref .. ".Fire_Suppressed", {path .. "dsr1_suppressed_fp.wav"})

TFA.AddWeaponSound( pref .. ".BoltRelease", path .. "dsr1_boltforward.wav" )
TFA.AddWeaponSound( pref .. ".Boltback", path .. "dsr1_boltback.wav" )
TFA.AddWeaponSound( pref .. ".Boltforward", path .. "dsr1_boltup.wav" )
TFA.AddWeaponSound( pref .. ".BoltLatch", path .. "dsr1_boltdown.wav" )

TFA.AddWeaponSound( pref .. ".Magrelease", path .. "dsr1_magrelease.wav" )
TFA.AddWeaponSound( pref .. ".Magout", path .. "dsr1_clipout.wav" )
TFA.AddWeaponSound( pref .. ".Magin", path .. "dsr1_clipin.wav" )

TFA.AddWeaponSound( pref .. ".Empty", path .. "dsr1_empty.wav" )