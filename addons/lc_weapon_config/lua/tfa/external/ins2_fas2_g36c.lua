local path = "weapons/tfa_ins2/fas2_g36c/"
local pref = "TFA_INS2.FAS2_G36C"
local hudcolor = Color(255, 80, 0, 191)

do
	local looppitch = 100 * (750 / (60 / (1.333333 / 16))) -- basepitch * (target rpm / (60 / (loop file length / number of shots)))

	sound.Add({name = pref .. ".FireLoop", channel = CHAN_WEAPON, level = 140, pitch = looppitch, sound = ")" .. path .. "g36_close_loop.wav"})
	sound.Add({name = pref .. ".FireLoop_Tail", channel = CHAN_WEAPON, level = 140, pitch = looppitch, sound = ")" .. path .. "g36_close_loop_tail.wav"})

	sound.Add({name = pref .. ".FireLoop_Silenced", channel = CHAN_WEAPON, level = 90, pitch = looppitch, sound = ")" .. path .. "g36_close_silenced_loop.wav"})
	sound.Add({name = pref .. ".FireLoop_Silenced_Tail", channel = CHAN_WEAPON, level = 90, pitch = looppitch, sound = ")" .. path .. "g36_close_silenced_loop_tail.wav"})
end

TFA.AddFireSound(pref .. ".1", path .. "g36c_fire1.wav", true, ")")
TFA.AddFireSound(pref .. ".2", path .. "g36c_suppressed_fire1.wav", true, ")")

TFA.AddWeaponSound(pref .. ".SightRaise", {path .. "generic/weapon_sightraise.wav", path .. "generic/weapon_sightraise2.wav"})
TFA.AddWeaponSound(pref .. ".SightLower", {path .. "generic/weapon_sightlower.wav", path .. "generic/weapon_sightlower2.wav"})

TFA.AddWeaponSound(pref .. ".Cloth_Movement", {path .. "generic/generic_cloth_movement4.wav", path .. "generic/generic_cloth_movement8.wav", path .. "generic/generic_cloth_movement12.wav", path .. "generic/generic_cloth_movement16.wav"})

TFA.AddWeaponSound(pref .. ".Deploy", {path .. "generic/weapon_deploy1.wav", path .. "generic/weapon_deploy2.wav", path .. "generic/weapon_deploy3.wav"})
TFA.AddWeaponSound(pref .. ".Holster", {path .. "generic/weapon_holster1.wav", path .. "generic/weapon_holster2.wav", path .. "generic/weapon_holster3.wav"})
TFA.AddWeaponSound(pref .. ".BoltHandle", path .. "g36c_handle.wav")
TFA.AddWeaponSound(pref .. ".BoltBack", path .. "g36c_boltback.wav")
TFA.AddWeaponSound(pref .. ".BoltForward", path .. "g36c_boltforward.wav")
TFA.AddWeaponSound(pref .. ".Stock", path .. "g36c_stock.wav")
TFA.AddWeaponSound(pref .. ".Switch", path .. "generic/switch.wav")
TFA.AddWeaponSound(pref .. ".MagIn", path .. "g36c_magin.wav")
TFA.AddWeaponSound(pref .. ".MagOut", path .. "g36c_magout.wav")
TFA.AddWeaponSound(pref .. ".MagOutEmpty", path .. "g36c_magout_empty.wav")
TFA.AddWeaponSound(pref .. ".MagPouch", path .. "generic/generic_magpouch1.wav")

TFA.AddWeaponSound(pref .. ".BoltForwardLewd", path .. "bruh/g36_boltrelease_cut.wav")
TFA.AddWeaponSound(pref .. ".MagInLewd", path .. "bruh/g36_magin.wav")
TFA.AddWeaponSound(pref .. ".MagOutLewd", path .. "bruh/g36_magout.wav")

if killicon and killicon.Add then
	killicon.Add("tfa_ins2_fas2_g36c", "vgui/killicons/tfa_ins2_fas2_g36c", hudcolor)
end