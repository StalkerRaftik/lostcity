local path = "weapons/barrett_m98b/"
local pref = "TFA_INS2.M98B"

TFA.AddFireSound(pref .. ".Fire", {path .. "m98b_shot-1.wav", path .. "m98b_shot-2.wav" })
TFA.AddFireSound( pref .. ".Fire_Suppressed", { path .. "m98b_shot_suppressed.wav" })

TFA.AddWeaponSound( pref .. ".BoltRelease", path .. "m98b_boltforward.wav" )
TFA.AddWeaponSound( pref .. ".Boltback", path .. "m98b_boltback.wav" )
TFA.AddWeaponSound( pref .. ".Boltforward", path .. "m98b_boltpush.wav" )
TFA.AddWeaponSound( pref .. ".BoltLatch", path .. "m98b_boltlock.wav" )

TFA.AddWeaponSound( pref .. ".Magrelease", path .. "m98b_cliptap.wav" )
TFA.AddWeaponSound( pref .. ".Magout", path .. "m98b_clipout.wav" )
TFA.AddWeaponSound( pref .. ".Magin", path .. "m98b_clipin.wav" )

TFA.AddWeaponSound( pref .. ".Empty", path .. "m98b_empty.wav" )