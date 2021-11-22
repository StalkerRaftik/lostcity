TFA.AddWeaponSound("weapon_dnf_manhatten.safety", "weapons/m1911/handling/m1911_safety.wav")
TFA.AddWeaponSound("weapon_dnf_manhatten.empty", "weapons/m1911/handling/m1911_empty.wav")
TFA.AddWeaponSound("weapon_dnf_manhatten.magout", "weapons/m1911/handling/m1911_magout.wav")
TFA.AddWeaponSound("weapon_dnf_manhatten.futz", "weapons/m1911/handling/m1911_magin.wav")
TFA.AddWeaponSound("weapon_dnf_manhatten.magin", "weapons/m1911/handling/m1911_maghit.wav")
TFA.AddWeaponSound("weapon_dnf_manhatten.slide", "weapons/m1911/handling/m1911_boltrelease.wav")

TFA.AddFireSound("weapon_dnf_manhatten.fire", {"weapons/1911_manhatten/DSPISTOL.wav"}, false, ")")
TFA.AddFireSound("weapon_dnf_manhatten.fire_silenced", {"weapons/m1911/m1911_suppressed_fp.wav"}, true, ")")
TFA.AddFireSound("weapon_dnf_manhatten.TailOutside", {"weapons/1911_manhatten/wpn_pistol_decay_ext.wav"}, true, ")")
TFA.AddFireSound("weapon_dnf_manhatten.TailInside", {"weapons/1911_manhatten/wpn_pistol_decay_int.wav"}, true, ")")

if CLIENT then
killicon.Add( "tfa_ins2_m1911_manhatten", "vgui/killicons/tfa_ins2_m1911_manhatten", Color( 255, 0, 0, 255 ) )
end 