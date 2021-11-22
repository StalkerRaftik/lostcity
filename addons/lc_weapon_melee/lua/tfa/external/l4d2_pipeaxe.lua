local path = "weapons/tfa_l4d2/pipeaxe/"
local pref = "TFA_L4D2.PIPEAXE"
local hudcolor = Color(255, 80, 0, 191)

TFA.AddWeaponSound(pref .. ".Swing", {path .. "crowbar_swing_miss1.wav", path .. "crowbar_swing_miss2.wav"})
TFA.AddWeaponSound(pref .. ".HitFlesh", {path .. "crowbar_impact_flesh1.wav", path .. "crowbar_impact_flesh2.wav"})
TFA.AddWeaponSound(pref .. ".HitWorld", {path .. "crowbar_impact_world1.wav", path .. "crowbar_impact_world2.wav"})

if killicon and killicon.Add then
    killicon.Add("tfa_l4d2_pipeaxe", "vgui/killicons/tfa_l4d2_pipeaxe", hudcolor)
end