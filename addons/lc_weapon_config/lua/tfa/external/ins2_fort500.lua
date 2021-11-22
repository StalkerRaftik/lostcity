local path = "/weapons/tfa_ins2/fort500/"
local pref = "TFA_INS2_FORT500"
local hudcolor = Color(255, 80, 0, 191)

TFA.AddFireSound(pref .. ".1", path .. "toz_fp.wav",true, ")")
TFA.AddFireSound(pref .. ".2", path .. "toz_suppressed_fp.wav", true, ")")

TFA.AddWeaponSound(pref .. ".Boltback", path .. "toz_pumpback.wav")
TFA.AddWeaponSound(pref .. ".Boltrelease", path .. "toz_pumpforward.wav")
TFA.AddWeaponSound(pref .. ".Empty", path .. "toz_empty.wav")
TFA.AddWeaponSound(pref .. ".ShellInsert", {path .. "toz_shell_insert_1.wav", path .. "toz_shell_insert_1.wav", path .. "toz_shell_insert_3.wav" })
TFA.AddWeaponSound(pref .. ".ShellInsertSingle", {path .. "toz_single_shell_insert_1.wav", path .. "toz_single_shell_insert_2.wav", path .. "toz_single_shell_insert_3.wav"})

if killicon and killicon.Add then
	killicon.Add("tfa_ins2_fort500", "vgui/killicons/tfa_ins2_fort500", hudcolor)
end