local path = "/weapons/tfa_ins2/m590o/"
local pref = "TFA_INS2_M590_OLLI"
local hudcolor = Color(255, 80, 0, 191)

TFA.AddFireSound(pref .. ".1", { path .. "Fire-1.wav", path .. "Fire-2.wav", path .. "Fire-3.wav"},true, ")")
TFA.AddFireSound(pref .. ".2", path .. "m590_suppressed_fp.wav", true, ")")

TFA.AddWeaponSound(pref .. ".Boltback", path .. "PumpBack.wav")
TFA.AddWeaponSound(pref .. ".Boltrelease", path .. "PumpForward.wav")
TFA.AddWeaponSound(pref .. ".Empty", path .. "m590_empty.wav")
TFA.AddWeaponSound(pref .. ".ShellInsert", {path .. "InsertShell-1.wav", path .. "InsertShell-2.wav", path .. "InsertShell-3.wav", path .. "InsertShell-4.wav", path .. "InsertShell-5.wav"})
TFA.AddWeaponSound(pref .. ".ShellInsertSingle", {path .. "m590_single_shell_insert_1.wav", path .. "m590_single_shell_insert_2.wav", path .. "m590_single_shell_insert_3.wav"})

if killicon and killicon.Add then
	killicon.Add("tfa_ins2_m590o", "vgui/killicons/tfa_ins2_m590o", hudcolor)
end