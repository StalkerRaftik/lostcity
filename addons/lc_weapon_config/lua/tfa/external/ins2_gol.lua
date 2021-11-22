local path = "weapons/tfa_ins2/gol/"

TFA.AddFireSound("TFA_INS2_GOL.1", path .. "m40a1_fp.wav", true, ")" )
TFA.AddFireSound("TFA_INS2_GOL.2", path .. "m40a1_suppressed_fp.wav", true, ")" )
TFA.AddWeaponSound("TFA_INS2_SPAS12.Draw", { path .. "uni_weapon_draw_01.wav", path .. "uni_weapon_draw_02.wav", path .. "uni_weapon_draw_03.wav" } ) --, path .. "bash1.wav"})
TFA.AddWeaponSound("TFA_INS2_SPAS12.Holster", path .. "uni_weapon_holster.wav")
TFA.AddWeaponSound("TFA_INS2_GOL.Boltback", path .. "m40a1_boltback.wav")
TFA.AddWeaponSound("TFA_INS2_GOL.Boltrelease", path .. "m40a1_boltrelease.wav")
TFA.AddWeaponSound("TFA_INS2_GOL.Boltforward", path .. "m40a1_boltforward.wav")
TFA.AddWeaponSound("TFA_INS2_GOL.BoltLatch", path .. "m40a1_boltlatch.wav")
TFA.AddWeaponSound("TFA_INS2_GOL.Roundin", { path .. "m40a1_bulletin_1.wav", path .. "m40a1_bulletin_2.wav", path .. "m40a1_bulletin_3.wav", path .. "m40a1_bulletin_4.wav" } )
TFA.AddWeaponSound("TFA_INS2_GOL.Empty", path .. "m40a1_empty.wav")