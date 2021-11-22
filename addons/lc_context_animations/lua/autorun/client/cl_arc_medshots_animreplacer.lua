-- 8Z veri gamer
-- fucking pigeon cant even animate smh

hook.Add("InitPostEntity", "ARC_MedShot_AnimReplacer", function()
timer.Simple(1, function()
    VManip:RegisterAnim("arc_vm_medshot_inject", {
        ["model"] = "weapons/c_mifl_vm_medshot2.mdl",
        ["lerp_peak"] = 1.6,
        ["lerp_speed_in"] = 1.2,
        ["lerp_speed_out"] = 0.85,
        ["lerp_curve"] = 1,
        ["speed"] = 0.5,
        ["startcycle"] = 0,
        ["loop"] = false,
        ["sounds"] = {
            ["weapons/arc_vm_medshot/healthshot_prepare_01.wav"] = 0,
            ["weapons/arc_vm_medshot/adrenaline_cap_off.wav"] = 12 / 60,
            ["weapons/arc_vm_medshot/healthshot_thud_01.wav"] = 38 / 60,
            ["weapons/arc_vm_medshot/healthshot_success_01.wav"] = 45 / 60
        },
        ["segmented"] = false,
        ["preventquit"] = false,
        ["locktoply"] = true,
        ["cam_ang"] = Angle(0, 90, 90),
        ["cam_angint"] = {.2, .75, .4},
    })
end)
    hook.Remove("InitPostEntity", "ARC_MedShot_AnimReplacer")
end)