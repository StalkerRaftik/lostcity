local path = "weapons/tfa_ins2/p90/"

TFA.AddFireSound("TFA_INS2_p90.1", { path .. "p90_fire.wav" } )
TFA.AddFireSound("TFA_INS2_p90.2", { path .. "p90_suppressed.wav", } )

TFA.AddWeaponSound("Weapon_p90.Empty", { path .. "p90_empty.wav" } )

TFA.AddWeaponSound("Weapon_p90.Magout", { path .. "p90_magout.wav", path .. "mag_drop.wav" } )
TFA.AddWeaponSound("Weapon_p90.Magin", { path .. "p90_magin.wav", path .. "mag_in.wav" } )
TFA.AddWeaponSound("Weapon_p90.Boltback", path .. "p90_boltback.wav")
TFA.AddWeaponSound("Weapon_p90.Boltlock", path .. "p90_boltrelease.wav")
TFA.AddWeaponSound("Weapon_p90.Magrelease", path .. "p90_magrelease.wav")
TFA.AddWeaponSound("Weapon_p90.Hit", path .. "mag_drop.wav")
TFA.AddWeaponSound("p90.Draw", path .. "p90_draw.wav")
TFA.AddWeaponSound("p90.Holster", path .. "holster.wav")