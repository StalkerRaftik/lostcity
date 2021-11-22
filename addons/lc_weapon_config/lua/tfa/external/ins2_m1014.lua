local path = "weapons/tfa_ins2/m1014/"

TFA.AddFireSound("TFA_INS2.M1014.1", path .. "m1014_fire.wav")
TFA.AddFireSound("TFA_INS2.M1014.2", path .. "m1014_suppressed.wav")

TFA.AddWeaponSound("TFA_INS2.M1014.Empty", path .. "toz_empty.wav")

TFA.AddWeaponSound("TFA_INS2.M1014.Magout", path .. "toz_magout.wav")
TFA.AddWeaponSound("TFA_INS2.M1014.Magin", path .. "toz_magin.wav")
TFA.AddWeaponSound("TFA_INS2.M1014.ShellInsertSingle", { path .. "toz_single_shell_insert_1.wav", path .. "toz_single_shell_insert_2.wav", path .. "toz_single_shell_insert_3.wav" } )
TFA.AddWeaponSound("TFA_INS2.M1014.ShellInsert", { path .. "toz_shell_insert_1.wav", path .. "toz_shell_insert_2.wav", path .. "toz_shell_insert_3.wav" } )
TFA.AddWeaponSound("TFA_INS2.M1014.Boltback", path .. "toz_pumpback.wav")
TFA.AddWeaponSound("TFA_INS2.M1014.Boltrelease", path .. "toz_pumpforward.wav")