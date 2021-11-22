local path = "/weapons/tfa_ins2/swmodel10/"
local pref = "TFA_INS2.SWM10"
local hudcolor = Color(255, 80, 0, 191)

TFA.AddFireSound(pref .. ".1", path .. "38shoot.wav", false, ")")

TFA.AddWeaponSound(pref .. ".Empty", path .. "revolver_empty.wav")
TFA.AddWeaponSound(pref .. ".OpenChamber", path .. "revolver_open_chamber.wav")
TFA.AddWeaponSound(pref .. ".CloseChamber", path .. "revolver_close_chamber.wav")
TFA.AddWeaponSound(pref .. ".CockHammer", path .. "revolver_cock_hammer.wav")
TFA.AddWeaponSound(pref .. ".DumpRounds", {path .. "revolver_dump_rounds_01.wav", path .. "revolver_dump_rounds_02.wav", path .. "revolver_dump_rounds_03.wav"})
TFA.AddWeaponSound(pref .. ".RoundInsertSpeedLoader", path .. "revolver_speed_loader_insert_01.wav")
TFA.AddWeaponSound(pref .. ".RoundInsertSingle", {path .. "revolver_round_insert_single_01.wav", path .. "revolver_round_insert_single_02.wav", path .. "revolver_round_insert_single_03.wav", path .. "revolver_round_insert_single_03.wav", path .. "revolver_round_insert_single_04.wav", path .. "revolver_round_insert_single_05.wav", path .. "revolver_round_insert_single_06.wav"})

if killicon and killicon.Add then
	killicon.Add("tfa_ins2_swmodel10", "vgui/killicons/tfa_ins2_swmodel10", hudcolor)
end