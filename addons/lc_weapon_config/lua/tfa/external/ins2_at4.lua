local path = "weapons/at4/"

TFA.AddFireSound("AT4_FIRE", path .. "at4_fp.wav", true, ")" )
TFA.AddWeaponSound("Universal.Draw", {"weapons/universal/uni_weapon_draw_01.wav", "weapons/universal/uni_weapon_draw_02.wav", "weapons/universal/uni_weapon_draw_03.wav"})
TFA.AddWeaponSound("Universal.LeanOut", { "weapons/universal/uni_lean_out_01.wav", "weapons/universal/uni_lean_out_02.wav", "weapons/universal/uni_lean_out_03.wav", "weapons/universal/uni_lean_out_04.wav"})
TFA.AddWeaponSound("Universal.WeaponLower", "weapons/universal/uni_weapon_lower_01.wav")
TFA.AddWeaponSound("Universal.Holster", "weapons/universal/uni_weapon_holster.wav")
TFA.AddWeaponSound("Weapon_M9.safety", "weapons/m9/handling/m9_safety.wav")
TFA.AddWeaponSound("Weapon_AT4.Latch_01", path .. "/handling/at4_latch_01.wav")
TFA.AddWeaponSound("Weapon_AT4.Latch_02", path .. "/handling/at4_latch_02.wav")
TFA.AddWeaponSound("Weapon_AT4.Ready", path .. "/handling/at4_ready.wav")
TFA.AddWeaponSound("Weapon_AT4.Shoulder", path .. "/handling/at4_shoulder.wav")

TFA.AddAmmo( "at4", "AT4" )
--[[

TFA.AddWeaponSound("TFA_INS2_RPG7.Empty", path .. "ak74_empty.wav")

TFA.AddWeaponSound("TFA_INS2_RPG7.MagRelease", path .. "ak74_magrelease.wav")
TFA.AddWeaponSound("TFA_INS2_RPG7.Magout", path .. "ak74_magout.wav")
TFA.AddWeaponSound("TFA_INS2_RPG7.Rattle", path .. "ak74_rattle.wav")
TFA.AddWeaponSound("TFA_INS2_RPG7.Magin", path .. "ak74_magin.wav")
TFA.AddWeaponSound("TFA_INS2_RPG7.Boltback", path .. "ak74_boltback.wav")
TFA.AddWeaponSound("TFA_INS2_RPG7.Boltrelease", path .. "ak74_boltrelease.wav")

]]--