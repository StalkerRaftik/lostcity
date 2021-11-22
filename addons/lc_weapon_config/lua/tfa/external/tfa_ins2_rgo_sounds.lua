local path = "weapons/tfa_ins2_rgo/"
local pref = "Weapon_RGO"
local hudcolor = Color(255, 255, 255, 255)

TFA.AddFireSound(pref .. "_1", path .. "g98_fp.wav", false, ")")

TFA.AddWeaponSound(pref .. ".PinPull", path .. "rgo_pinpull.wav")
TFA.AddWeaponSound(pref .. ".ArmThrow", path .. "rgo_throw.wav")
TFA.AddWeaponSound(pref .. ".ArmDraw", path .. "rgo_armdraw.wav")


if killicon and killicon.Add then
	killicon.Add("tfa_ins_rgo_grenade", "vgui/hud/tfa_ins_rgo_grenade", hudcolor)
        killicon.Add("tfa_ins_rgo_grenade_owo", "vgui/hud/tfa_ins_rgo_grenade_owo", hudcolor)
end