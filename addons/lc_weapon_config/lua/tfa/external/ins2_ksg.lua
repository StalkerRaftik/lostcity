local path = "weapons/tfa_ins2/ksg/"

TFA.AddFireSound("TFA_INS2_KSG.1", path .. "toz_fp.wav", true, ")" )
TFA.AddFireSound("TFA_INS2_KSG.2", path .. "toz_suppressed_fp.wav", true, ")" )
TFA.AddWeaponSound("TFA_INS2_KSG.Boltback", path .. "toz_pumpback.wav")
TFA.AddWeaponSound("TFA_INS2_KSG.Boltrelease", path .. "toz_pumpforward.wav")
TFA.AddWeaponSound("TFA_INS2_KSG.ShellInsert", { path .. "insertshell-1.wav", path .. "insertshell-2.wav", path .. "insertshell-3.wav" } )
TFA.AddWeaponSound("TFA_INS2_KSG.ShellInsertSingle", { path .. "insertshell-1.wav", path .. "insertshell-2.wav", path .. "insertshell-3.wav" } )
TFA.AddWeaponSound("TFA_INS2_KSG.Empty", path .. "m590_empty.wav")