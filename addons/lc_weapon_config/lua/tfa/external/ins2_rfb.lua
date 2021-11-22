local path = "weapons/tfa_ins2/rfb/"

TFA.AddFireSound("TFA_INS2_RFB.1", { path .. "RFBFire01.wav", path .. "RFBFire02.wav", path .. "RFBFire03.wav" }, false, ")" )
TFA.AddFireSound("TFA_INS2_RFB.2", path .. "m14_suppressed_fp.wav", false, ")" )

TFA.AddWeaponSound("TFA_INS2_RFB.Empty", path .. "m14_empty.wav")

TFA.AddWeaponSound("TFA_INS2_RFB.Magout", path .. "m14_magout.wav")
TFA.AddWeaponSound("TFA_INS2_RFB.Magin", path .. "m14_magin.wav")
TFA.AddWeaponSound("TFA_INS2_RFB.Hit", path .. "mk18_hit.wav")
TFA.AddWeaponSound("TFA_INS2_RFB.Boltback", path .. "RFBBoltPull01.wav")
TFA.AddWeaponSound("TFA_INS2_RFB.Boltclose", path .. "RFBBoltClose01.wav")
TFA.AddWeaponSound("TFA_INS2_RFB.Boltrelease", path .. "RFBBoltRelease01.wav")