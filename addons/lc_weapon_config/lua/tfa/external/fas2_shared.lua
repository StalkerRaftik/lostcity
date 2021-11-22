local path = "weapons/tfa_fas2/generic/"
local pref = "TFA_FAS2"
local hudcolor = Color(255, 80, 0, 191)

TFA.AddWeaponSound(pref .. ".SightRaise", {path .. "weapon_sightraise.wav", path .. "weapon_sightraise2.wav"})
TFA.AddWeaponSound(pref .. ".SightLower", {path .. "weapon_sightlower.wav", path .. "weapon_sightlower2.wav"})

TFA.AddWeaponSound(pref .. ".Cloth_Movement", {path .. "generic_cloth_movement4.wav", path .. "generic_cloth_movement8.wav", path .. "generic_cloth_movement12.wav", path .. "generic_cloth_movement16.wav"})

TFA.AddWeaponSound(pref .. ".Deploy", {path .. "weapon_deploy1.wav", path .. "weapon_deploy2.wav", path .. "weapon_deploy3.wav"})
TFA.AddWeaponSound(pref .. ".Holster", {path .. "weapon_holster1.wav", path .. "weapon_holster2.wav", path .. "weapon_holster3.wav"})
TFA.AddWeaponSound(pref .. ".MagPouch", path .. "generic_magpouch1.wav")
