local path = "weapons/tfa_ins2/melee_doi/"
local pref = "TFA_INS2.MELEE"
local hudcolor = Color(255, 80, 0, 191)

TFA.AddWeaponSound(pref .. ".Swing", {path .. "weapon_melee_01.wav", path .. "weapon_melee_02.wav", path .. "weapon_melee_03.wav", path .. "weapon_melee_04.wav", path .. "weapon_melee_05.wav", path .. "weapon_melee_06.wav"})
TFA.AddWeaponSound(pref .. ".HitFlesh", {path .. "weapon_melee_hitflesh_01.wav", path .. "weapon_melee_hitflesh_02.wav", path .. "weapon_melee_hitflesh_03.wav", path .. "weapon_melee_hitflesh_04.wav"}, false, ")")
TFA.AddWeaponSound(pref .. ".HitWorld", {path .. "weapon_melee_hitworld_01.wav", path .. "weapon_melee_hitworld_02.wav"}, false, ")")

if killicon and killicon.Add then
	killicon.Add("tfa_ins2_kabar", "vgui/killicons/tfa_ins2_kabar", hudcolor)
	killicon.Add("tfa_ins2_gurkha", "vgui/killicons/tfa_ins2_gurkha", hudcolor)
end