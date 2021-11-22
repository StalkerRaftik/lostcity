local path = "weapons/tfa_ins2_rpg7_scoped/"
local pref = "TFA_SCOPED_RPG7"
local hudcolor = Color(255, 255, 255, 255)

TFA.AddFireSound(pref .. ".1", path .. "rhino_1.wav", false, ")")

TFA.AddWeaponSound(pref .. ".Fetch", path .. "rpg7_fetch.wav")
TFA.AddWeaponSound(pref .. ".Load1", path .. "rpg7_load1.wav")
TFA.AddWeaponSound(pref .. ".Load2", path .. "rpg7_load2.wav")
TFA.AddWeaponSound(pref .. ".EndGrab", path .. "rpg7_endgrab.wav")
TFA.AddWeaponSound(pref .. ".safety", path .. "m9_safety.wav")

if killicon and killicon.Add then
	killicon.Add("tfa_anti_tank", "vgui/hud/tfa_anti_tank", hudcolor)
        killicon.Add("tfa_crocket_rpg", "vgui/hud/tfa_crocket_rpg", hudcolor)
        killicon.Add("tfa_ins2_rpg7_scoped", "vgui/hud/tfa_ins2_rpg7_scoped", hudcolor)
end