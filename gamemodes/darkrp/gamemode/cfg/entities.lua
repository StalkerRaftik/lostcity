rp.Ammo = {
    ["tfa_ammo_357"] = {
        AmmoType = "357",
        Name = ".357 патроны",
        Model = "models/Items/357ammo.mdl",
    },
    ["tfa_ammo_ar2"] = {
        AmmoType = "AR2",
        Name = "5.56x45 мм патроны",
        Model = "models/Items/BoxMRounds.mdl",
    },
    ["tfa_ammo_ar1"] = {
        AmmoType = "12mmRound",
        Name = "7.62x54 мм патроны",
        Model = "models/Items/BoxMRounds.mdl",
    },
    ["tfa_ammo_buckshot"] = {
        AmmoType = "Buckshot",
        Name = ".12 патроны",
        Model = "models/Items/BoxBuckshot.mdl",
    },
    ["tfa_ammo_smg"] = {
        AmmoType = "SMG1",
        Name = "9x19 мм патроны",
        Model = "models/Items/BoxSRounds.mdl",
    },
    ["tfa_ammo_pistol"] = {
        AmmoType = "Pistol",
        Name = ".45 ACP патроны",
        Model = "models/Items/BoxSRounds.mdl",
    },
    ["tfa_ammo_sniper_rounds"] = {
        AmmoType = "SniperPenetratedRound",
        Name = ".308 Win патроны",
        Model = "models/Items/sniper_round_box.mdl",
    },
    ["tfa_ammo_winchester"] = {
        AmmoType = "AirboatGun",
        Name = "5.45x39 мм патроны",
        Model = "models/Items/BoxSRounds.mdl",
    },
    ["arrow"] = {
        AmmoType = "tfbow_arrow",
        Name = "Стрела",
        Model = "models/weapons/w_tfa_arrow.mdl",
    },
    ["Hemostats"] = {
        AmmoType = "Hemostats",
        Name = "Гемостаты",
        Model = "models/Items/BoxMRounds.mdl",
    },
    ["Bandages"] = {
        AmmoType = "Bandages",
        Name = "Бинты",
        Model = "models/Items/BoxMRounds.mdl",
    },   
    ["Quikclots"] = {
        AmmoType = "Quikclots",
        Name = "Марля",
        Model = "models/Items/BoxMRounds.mdl",
    },   
    
}

rp.AmmoClass = {}
for k,v in pairs(rp.Ammo) do
    rp.AmmoClass[v.AmmoType] = table.Copy(v)
    rp.AmmoClass[v.AmmoType].AmmoType = k
end

rp.AddEntity("Семена капусты", {
    ent = "fs_cabbage_seeds",
    model = "models/props_lab/box01a.mdl",
    price = 0,
    max = 3,
    cmd = "",
    weight = 0.1,
    usable = false,
})

rp.AddEntity("Фильтр для противогаза", {
    ent = "rp_gasmaskfilter",
    model = "models/props_lab/box01a.mdl",
    price = 0,
    max = 3,
    cmd = "",
    weight = 0.1,
    usable = false,
})


rp.AddEntity("Бумага", {
    ent = "ent_notepad_page",
    model = "models/props_junk/garbage_newspaper001a.mdl",
    price = 0,
    max = 3,
    cmd = "",
    weight = 0.1,
    usable = false,
})


rp.AddEntity("Семена томата", {
    ent = "fs_tomato_seeds",
    model = "models/props_lab/box01a.mdl",
    price = 0,
    max = 3,
    cmd = "",
    weight = 0.1,
    usable = true
})

rp.AddEntity("Семена яблочного дерева", {
    ent = "fs_apple_seeds",
    model = "models/props_lab/box01a.mdl",
    price = 0,
    max = 3,
    cmd = "",
    weight = 0.1,
    usable = true
})

rp.AddEntity("Семена жаботикаба", {
    ent = "fs_lemon_seeds",
    model = "models/props_lab/box01a.mdl",
    price = 0,
    max = 3,
    cmd = "",
    weight = 0.1,
    usable = true
})

rp.AddEntity("Батарейка", {
    ent = "ent_battery",
    model = "models/illusion/eftcontainers/aabattery.mdl",
    price = 0,
    max = 1,
    cmd = "",
    weight = 0.05,
    usable = true
})

rp.AddEntity("Аптечка первой медицинской помощи", {
    ent = "ent_medkit",
    model = "models/firstaid/item_firstaid.mdl",
    price = 0,
    max = 1,
    cmd = "",
    weight = 1.4,
    usable = true
})

rp.AddEntity("Феназалгин", {
    ent = "ent_smallmedkit",
    model = "models/bloocobalt/l4d/items/w_eq_pills.mdl",
    price = 0,
    max = 1,
    cmd = "",
    weight = 0.3,
    usable = true
})

rp.AddEntity("Глицин-биотик(инжектор)", {
    ent = "med_boostinject",
    model = "models/bloocobalt/l4d/items/w_eq_adrenaline.mdl",
    price = 0,
    max = 1,
    cmd = "",
    weight = 0.3,
    usable = true
})


rp.AddEntity("Бинт", {
    ent = "ent_bandage",
    model = "models/bandage/bandage.mdl",
    price = 0,
    max = 1,
    cmd = "",
    weight = 0.2,
    usable = true
})

rp.AddEntity("Шина", {
    ent = "ent_shina",
    model = "models/snowzgmod/payday2/armour/armourrthigh.mdl",
    price = 0,
    max = 1,
    cmd = "",
    weight = 1.4,
    usable = true
})

rp.AddEntity("Эксперементальный регенеративный инъектор", {
    ent = "ent_medboost",
    model = "models/fless/befall/autoinjector.mdl",
    price = 0,
    max = 1,
    cmd = "",
    weight = 0.1,
    usable = true
})

rp.AddEntity("Антирадиационный инжектор", {
    ent = "med_antirad",
    model = "models/bloocobalt/l4d/items/w_eq_adrenaline.mdl",
    price = 0,
    max = 1,
    cmd = "",
    weight = 0.1,
    usable = true
})

rp.AddEntity("Домашняя настойка", {
    ent = "med_nastoyka",
    model = "models/foodnhouseholditems/beer_master.mdl",
    price = 0,
    max = 1,
    cmd = "",
    weight = 0.3,
    usable = true
})

rp.AddEntity("Грелка", {
    ent = "med_heatpack",
    model = "models/props_rpd/medical_iv.mdl",
    price = 0,
    max = 1,
    cmd = "",
    weight = 0.3,
    usable = true
})

rp.AddEntity("Антидот", {
    ent = "zombification_cure",
    model = "models/mosi/fallout4/props/aid/medx.mdl",
    price = 0,
    max = 1,
    cmd = "",
    weight = 0.6,
    usable = true
})

rp.AddEntity("Рация", {
    ent = "wep_jack_job_drpradio",
    model = "models/radio/w_radio.mdl",
    price = 0,
    max = 1,
    cmd = "",
    weight = 0.4,
    usable = true
})

rp.AddEntity("Набор для костра", {
    ent = "rp_firekit",
    model = "models/props_lab/box01a.mdl",
    price = 0,
    max = 1,
    cmd = "",
    weight = 0.3,
})


rp.AddEntity("Канистра(с бензином)", {
    ent = "ent_fuel",
    model = "models/illusion/eftcontainers/gasoline.mdl",
    price = 0,
    max = 1,
    cmd = "",
    weight = 0.4,
    usable = true
})

rp.AddEntity("Большая коробка с инструментами", {
    ent = "ent_repairkit",
    model = "models/instrument.mdl",
    price = 0,
    max = 1,
    cmd = "",
    weight = 0.4,
    usable = true
})


-- rp.AddEntity("Фильтр для противогаза", {
--     ent = "item_filter",
--     model = "models/teebeutel/metro/objects/gasmask_filter.mdl",
--     price = 0,
--     max = 1,
--     cmd = "",
--     weight = 0.6,
--     usable = true
-- })

-- rp.AddEntity("Противогаз", {
--     ent = "item_gasmask",
--     model = "models/half-dead/metroll/p_mask_1.mdl",
--     price = 0,
--     max = 1,
--     cmd = "",
--     weight = 1,
--     usable = true
-- })

rp.AddEntity(".357 патроны", {
    ent = "tfa_ammo_357",
    model = "models/Items/357ammo.mdl",
    price = 0,
    max = 1,
    cmd = "",
    weight = 0.005,
    usable = true
})
rp.AddEntity("5.56x45 мм патроны", {
    ent = "tfa_ammo_ar2",
    model = "models/Items/BoxMRounds.mdl",
    price = 0,
    max = 1,
    cmd = "",
    weight = 0.005,
    usable = true
})
rp.AddEntity(".12 патроны", {
    ent = "tfa_ammo_buckshot",
    model = "models/Items/BoxBuckshot.mdl",
    price = 0,
    max = 1,
    cmd = "",
    weight = 0.005,
    usable = true
})
rp.AddEntity("7.62x54 мм патроны", {
    ent = "tfa_ammo_pistol",
    model = "models/Items/BoxSRounds.mdl",
    price = 0,
    max = 1,
    cmd = "",
    weight = 0.005,
    usable = true
})
rp.AddEntity("9x19 мм патроны", {
    ent = "tfa_ammo_smg",
    model = "models/Items/BoxSRounds.mdl",
    price = 0,
    max = 1,
    cmd = "",
    weight = 0.005,
    usable = true
})
rp.AddEntity(".45 ACP патроны", {
    ent = "tfa_ammo_smg",
    model = "models/Items/BoxSRounds.mdl",
    price = 0,
    max = 1,
    cmd = "",
    weight = 0.005,
    usable = true
})
rp.AddEntity(".308 Win патроны", {
    ent = "tfa_ammo_sniper_rounds",
    model = "models/Items/BoxSRounds.mdl",
    price = 0,
    max = 1,
    cmd = "",
    weight = 0.005,
    usable = true
})
rp.AddEntity("5.45x39 мм патроны", {
    ent = "tfa_ammo_winchester",
    model = "models/Items/BoxSRounds.mdl",
    price = 0,
    max = 1,
    cmd = "",
    weight = 0.005,
    usable = true
})


rp.AddShipment('Топор', {
    model  = "models/weapons/tfa_breadaxe/w_fireaxe.mdl", 
    entity = "tfa_breadnope_axe", 
    price = 0,
    type = "knife",
    weight = 1.3,
    pos = Vector(0,3,-4),
    ang = Angle(180,90,0),
})

rp.AddShipment('Бита', {
    model  = "models/weapons/tfa_nmrih/w_me_bat_metal.mdl", 
    entity = "tfa_nmrih_bat", 
    price = 0,
    type = "knife",
    weight = 1,
})

rp.AddShipment('Боун Крашер', {
    model  = "models/weapons/tfa_kf2/w_shield_mace.mdl", 
    entity = "tfa_kf2_mace", 
    price = 0,
    type = "knife",
    weight = 1.6,
    scale = 0,
})

rp.AddShipment('Лом', {
    model  = "models/weapons/tfa_nmrih/w_me_crowbar.mdl", 
    entity = "tfa_nmrih_crowbar", 
    price = 0,
    type = "knife",
    weight = 0.8,
    pos = Vector(0,3,-6),
    ang = Angle(-90,0,0),
})

rp.AddShipment('Пожарный топор', {
    model  = "models/weapons/tfa_nmrih/w_me_axe_fire.mdl", 
    entity = "tfa_nmrih_fireaxe", 
    price = 0,
    type = "knife",
    weight = 1.2,
    pos = Vector(0,3,-6),
    ang = Angle(-90,0,0),
})

rp.AddShipment('Фубар', {
    model  = "models/weapons/tfa_nmrih/w_me_fubar.mdl", 
    entity = "tfa_nmrih_fubar", 
    price = 0,
    type = "knife",
    weight = 2.2,
})

rp.AddShipment('Араэбо', {
    model  = "models/weapons/w_ararebo.mdl", 
    entity = "tfa_ararebo_bf1", 
    price = 0,
    type = "knife",
    weight = 1,
})

rp.AddShipment('Бензопила', {
    model  = "models/weapons/tfa_nmrih/w_me_chainsaw.mdl", 
    entity = "tfa_nmrih_chainsaw", 
    price = 0,
    type = "knife",
    weight = 1,
})

rp.AddShipment('Кирка', {
    model  = "models/weapons/tfa_nmrih/w_me_pickaxe.mdl", 
    entity = "tfa_nmrih_pickaxe", 
    price = 0,
    type = "knife",
    weight = 1,
})

rp.AddShipment('Каменный топор', {
    model  = "models/weapons/yurie_rustalpha/wm-stonehatchet.mdl", 
    entity = "tfa_rustalpha_stone_hatchet", 
    price = 0,
    type = "knife",
    weight = 1,
})

rp.AddShipment('Катана', {
    model  = "models/weapons/tfa_l4d2/w_kf2_katana.mdl", 
    entity = "tfa_l4d2_kfkat", 
    price = 0,
    type = "knife",
    weight = 1,
})

rp.AddShipment('Кукри', {
    model  = "models/weapons/tfa_ins2/w_gurkha.mdl", 
    entity = "tfa_ins2_gurkha", 
    price = 0,
    type = "knife",
    weight = 1,
})

rp.AddShipment('Молоток', {
    model  = "models/weapons/tfa_nmrih/w_tool_barricade.mdl", 
    entity = "tfa_nmrih_bcd", 
    price = 0,
    type = "knife",
    weight = 1,
})


rp.AddShipment('Охотничий нож', {
    model  = "models/weapons/tfa_ins2/w_marinebayonet.mdl", 
    entity = "tfa_ins2_kabar", 
    price = 0,
    type = "knife",
    weight = 1,
})


rp.AddShipment('Потрошитель', {
    model  = "models/weapons/yurie_customs/w_yog_crowbar.mdl", 
    entity = "tfa_yog_crowbar", 
    price = 0,
    type = "knife",
    weight = 1,
})


rp.AddShipment('Самодельная кирка', {
    model  = "models/weapons/yurie_rustalpha/wm-pickaxe.mdl", 
    entity = "tfa_rustalpha_pickaxe", 
    price = 0,
    type = "knife",
    weight = 1,
})

rp.AddShipment('Саперная лопатка', {
    model  = "models/weapons/tfa_nmrih/w_me_etool.mdl", 
    entity = "tfa_nmrih_etool", 
    price = 0,
    type = "knife",
    weight = 1,
})

rp.AddShipment('Складной топор', {
    model  = "models/weapons/tfa_l4d2/w_talosaxe.mdl", 
    entity = "tfa_l4d2_talaxe", 
    price = 0,
    type = "knife",
    weight = 1,
})

rp.AddShipment('Сувенирный нож', {
    model  = "models/weapons/w_xiandagger.mdl", 
    entity = "tfa_xiandagger", 
    price = 0,
    type = "knife",
    weight = 1,
})

rp.AddShipment('Танто', {
    model  = "models/weapons/w_tanto_knife.mdl", 
    entity = "tfa_japanese_exclusive_tanto", 
    price = 0,
    type = "knife",
    weight = 1,
})

rp.AddShipment('Улучшенная труба', {
    model  = "models/weapons/tfa_l4d2/w_pipeaxe.mdl", 
    entity = "tfa_l4d2_pipeaxe", 
    price = 0,
    type = "knife",
    weight = 1,
})

rp.AddShipment('Циркулярная пила', {
    model  = "models/weapons/tfa_nmrih/w_me_abrasivesaw.mdl", 
    entity = "tfa_nmrih_asaw", 
    price = 0,
    type = "knife",
    weight = 1,
})

rp.AddShipment('Электрогитара', {
    model  = "models/weapons/melee/w_electric_guitar.mdl", 
    entity = "weapon_l4d2_electricguitar", 
    price = 0,
    type = "knife",
    weight = 1,
})

rp.AddShipment('Тазер', {
    model  = "models/w_taser_pillar.mdl", 
    entity = "wep_jack_job_drpstungun", 
    price = 0,
    type = "knife",
    weight = 1,
})

rp.AddShipment('Полицейская дубинка', {
    model  = "models/drover/w_baton.mdl", 
    entity = "weapon_policebaton", 
    price = 0,
    type = "knife",
    weight = 1,
})

rp.AddShipment('Топорик', {
    model  = "models/weapons/tfa_nmrih/w_me_hatchet.mdl", 
    entity = "tfa_nmrih_hatchet", 
    price = 0,
    type = "knife",
    weight = 0.8,
    pos = Vector(0,3,-6),
    ang = Angle(-90,0,0),
})

rp.AddShipment('Нож', {
    model  = "models/weapons/tfa_nmrih/w_me_kitknife.mdl", 
    entity = "tfa_nmrih_kknife", 
    price = 0,
    type = "knife",
    weight = 0.5,
    pos = Vector(0,3,-6),
    ang = Angle(-90,0,0),
})

rp.AddShipment('Труба', {
    model  = "models/weapons/tfa_nmrih/w_me_pipe_lead.mdl", 
    entity = "tfa_nmrih_lpipe", 
    price = 0,
    type = "knife",
    weight = 0.9,
    pos = Vector(0,3,-6),
    ang = Angle(-90,0,0),
})

rp.AddShipment('Мачете', {
    model  = "models/weapons/tfa_nmrih/w_me_machete.mdl", 
    entity = "tfa_nmrih_machete", 
    price = 0,
    type = "knife",
    weight = 0.8,
    pos = Vector(0,3,-6),
    ang = Angle(-90,0,0),
})

rp.AddShipment('Молот', {
    model  = "models/weapons/tfa_nmrih/w_me_sledge.mdl", 
    entity = "tfa_nmrih_sledge", 
    price = 0,
    type = "knife",
    weight = 1.9,
    pos = Vector(0,3,-6),
    ang = Angle(-90,0,0),
})

rp.AddShipment('Лопата', {
    model  = "models/weapons/tfa_nmrih/w_me_spade.mdl", 
    entity = "tfa_nmrih_spade", 
    price = 0,
    type = "knife",
    weight = 0.9,
    pos = Vector(0,3,-6),
    ang = Angle(-90,0,0),
})

rp.AddShipment('Гаечный ключ', {
    model  = "models/weapons/tfa_nmrih/w_me_wrench.mdl", 
    entity = "tfa_nmrih_wrench", 
    price = 0,
    type = "knife",
    weight = 0.6,
    pos = Vector(0,3,-6),
    ang = Angle(-90,0,0),
})


rp.AddShipment('Отмычка', {
    model  = "models/weapons/w_crowbar.mdl", 
    entity = "lockpick", 
    price = 0,
    weight = 0.5,
})

Cosmetics.Items["lockpick"] = {
    name = "Отмычка",
    id = "lockpick",
    model = "models/weapons/w_crowbar.mdl",
    pos = Vector(0,2,-5),
    ang = Angle(0,0,0),
    slot=COSM_SLOT_MISC3,
    scale=1,
    bone = "ValveBiped.Bip01_Spine2",
    type = "weapon",
    price=0,
}  

rp.AddShipment('Гитара', {
    model  = "models/props_phx/misc/fender.mdl", 
    entity = "guitar_sad", 
    price = 0,
    weight = 0.5,
})

Cosmetics.Items["guitar_sad"] = {
    name = "Гитара",
    id = "guitar_sad",
    model = "models/props_phx/misc/fender.mdl",
    pos = Vector(0,2,-5),
    ang = Angle(0,0,0),
    slot=COSM_SLOT_MISC3,
    scale=0,
    bone = "ValveBiped.Bip01_Spine2",
    type = "weapon",
    price=0,
} 
--------Бинокли--------------
--------------------------
rp.AddShipment('Бинокль', {
    model  = "models/weapons/w_binocularsbp.mdl", 
    entity = "weapon_rpw_binoculars", 
    price = 0,
    weight = 0.8,
})

rp.AddShipment('Старый бинокль', {
    model  = "models/weapons/w_binocularsbp.mdl", 
    entity = "weapon_rpw_binoculars_explorer", 
    price = 0,
    weight = 0.9,
})
rp.AddShipment('Бинокль ночного видения', {
    model  = "models/weapons/w_binocularsbp.mdl", 
    entity = "weapon_rpw_binoculars_nvg", 
    price = 0,
    weight = 1,
})
rp.AddShipment('Бинокль разведчика', {
    model  = "models/weapons/w_binocularsbp.mdl", 
    entity = "weapon_rpw_binoculars_scout", 
    price = 0,
    weight = 0.8,
})
rp.AddShipment('Старый винтажный бинокль', {
    model  = "models/weapons/w_binocularsbp.mdl", 
    entity = "weapon_rpw_binoculars_vintage", 
    price = 0,
    weight = 0.9,
})

rp.AddShipment('Рация', {
    model = "models/radio/w_radio.mdl",
    entity = "wep_jack_job_drpradio",
    price = 0,
    weight = 0.3,
})

rp.AddShipment('Прибор для анализа крови', {
    model = "models/weapons/darky_m/w_imsyringe.mdl",
    entity = "rp_radiationchecker",
    price = 0,
    weight = 0.3,
})

rp.AddShipment('Дозиметр', {
    model = "models/lt_c/alienisolation/track3r/motion_track3r.mdl",
    entity = "rp_radiationdetector",
    price = 0,
    weight = 0.6,
})
Cosmetics.Items["rp_radiationdetector"] = {
    name = "Дозиметр",
    id = "rp_radiationdetector",
    model = "models/lt_c/alienisolation/track3r/motion_track3r.mdl",
    pos = Vector(6,-7,2),
    ang = Angle(0,-90,-10),
    slot=COSM_SLOT_MISC4,
    scale=0.8,
    bone = "ValveBiped.Bip01_Spine2",
    type = "weapon",
    price=0,
} 

rp.AddShipment('Удочка', {
    model = "models/oldprops/fishing_rod.mdl",
    entity = "st_fishingrod",
    price = 0,
    weight = 0.6,
})
Cosmetics.Items["st_fishingrod"] = {
    name = "Удочка",
    id = "st_fishingrod",
    model = "models/oldprops/fishing_rod.mdl",
    pos = Vector(6,-7,2),
    ang = Angle(0,-90,-10),
    slot=COSM_SLOT_MISC4,
    scale=0.8,
    bone = "ValveBiped.Bip01_Spine2",
    type = "weapon",
    price=0,
}  

rp.AddShipment('Осколочная граната', {
    model = "models/weapons/w_rgo.mdl",
    entity = "tfa_ins_rgo_grenade_owo",
    price = 0,
    weight = 0.3,
})
Cosmetics.Items["tfa_ins_rgo_grenade_owo"] = {
    name = "Осколочная граната",
    id = "tfa_ins_rgo_grenade_owo",
    model = "models/weapons/w_rgo.mdl",
    pos = Vector(6,-7,2),
    ang = Angle(0,-90,-10),
    slot=COSM_SLOT_MISC4,
    scale=0.8,
    bone = "ValveBiped.Bip01_Spine2",
    type = "weapon",
    price=0,
}   

Cosmetics.Items["rp_radiationchecker"] = {
    name = "Прибор для анализа крови",
    id = "rp_radiationchecker",
    model = "models/weapons/darky_m/w_imsyringe.mdl",
    pos = Vector(6,-7,2),
    ang = Angle(0,-90,-10),
    slot=COSM_SLOT_MISC4,
    scale=0.8,
    bone = "ValveBiped.Bip01_Spine2",
    type = "weapon",
    price=0,
} 

Cosmetics.Items["wep_jack_job_drpradio"] = {
    name = "Рация",
    id = "wep_jack_job_drpradio",
    model = "models/radio/w_radio.mdl",
    pos = Vector(6,-7,2),
    ang = Angle(0,-90,-10),
    slot=COSM_SLOT_MISC4,
    scale=0.8,
    bone = "ValveBiped.Bip01_Spine2",
    type = "weapon",
    price=0,
}   

Cosmetics.Items["weapon_rpw_binoculars"] = {
    name = "Бинокль",
    id = "weapon_rpw_binoculars",
    model = "models/weapons/w_binocularsbp.mdl",
    pos = Vector(0,-7,-7),
    ang = Angle(-90,0,0),
    slot=COSM_SLOT_MISC3,
    scale=1,
    bone = "ValveBiped.Bip01_Spine",
    type = "weapon",
    price=0,
}   

Cosmetics.Items["weapon_rpw_binoculars_explorer"] = {
    name = "Старый бинокль",
    id = "weapon_rpw_binoculars_explorer",
    model = "models/weapons/w_binocularsbp.mdl",
    pos = Vector(0,-7,-7),
    ang = Angle(-90,0,0),
    slot=COSM_SLOT_MISC3,
    scale=1,
    bone = "ValveBiped.Bip01_Spine",
    type = "weapon",
    price=0,
}   

Cosmetics.Items["weapon_rpw_binoculars_nvg"] = {
    name = "Бинокль ночного видения",
    id = "weapon_rpw_binoculars_nvg",
    model = "models/weapons/w_binocularsbp.mdl",
    pos = Vector(0,-7,-7),
    ang = Angle(-90,0,0),
    slot=COSM_SLOT_MISC3,
    scale=1,
    bone = "ValveBiped.Bip01_Spine",
    type = "weapon",
    price=0,
}   

Cosmetics.Items["weapon_rpw_binoculars_scout"] = {
    name = "Бинокль разведчика",
    id = "weapon_rpw_binoculars_scout",
    model = "models/weapons/w_binocularsbp.mdl",
    pos = Vector(0,-7,-7),
    ang = Angle(-90,0,0),
    slot=COSM_SLOT_MISC3,
    scale=1,
	bone = "ValveBiped.Bip01_Spine",
    type = "weapon",
    price=0,
}   

Cosmetics.Items["weapon_rpw_binoculars_vintage"] = {
    name = "Старый винтажный бинокль",
    id = "weapon_rpw_binoculars_vintage",
    model = "models/weapons/w_binocularsbp.mdl",
    pos = Vector(0,-7,-7),
    ang = Angle(-90,0,0),
    slot=COSM_SLOT_MISC3,
    scale=1,
	bone = "ValveBiped.Bip01_Spine",
    type = "weapon",
    price=0,
}   




hook.Call("rp.AddEntities", GAMEMODE)
-- Cook

function Alcohol(ply, effect)
    effect = effect or 10
    if ply.radiation then
        timer.Create( "AntiradBeer"..ply:SteamID64(), 6, 10, function()
            ply:SetRadiation(ply:GetRadiation() - 10)
            if ply:GetRadiation() <= 0 then timer.Remove( "AntiradBeer"..ply:SteamID64() ) end
        end )
    end

    local beer = ents.Create("durgz_alcohol")
    beer:SetPos(Vector(0,0,0))
    beer:Spawn()
    beer:Use( ply, ply, USE_SET, 1)
    beer:Remove()
end

function StrongAlcohol(ply)
    Alcohol(ply, 75)
end

function InfectionedFood(ply)
    ply:SetIll("Отравление")
end

rp.AddFoodItem("Яблочный сок","models/foodnhouseholditems/juicesmall.mdl",8,0.2,"applejuice", 20, "samprp/moreicons/can-1.png")
rp.AddFoodItem("Яблочный сок(большой)","models/foodnhouseholditems/juice3.mdl",11,0.3,"applejuice3", 40, "samprp/moreicons/can-1.png")
rp.AddFoodItem("Палка бекона","models/foodnhouseholditems/baconcooked.mdl",20,1,"bacon2", 0, "samprp/moreicons/bacon.png")
rp.AddFoodItem("Бублик","models/foodnhouseholditems/bagel3.mdl",25,1,"bagel3", 0,"samprp/emoji/1f369.png")
rp.AddFoodItem("Багет","models/foodnhouseholditems/bagette.mdl",35,1,"bagette", 0, "samprp/moreicons/baguette.png")
rp.AddFoodItem("Пиво (Duff)","models/foodnhouseholditems/beercan01.mdl",0,0.345,"beercan1", 15, "samprp/moreicons/pint.png", Alcohol)
rp.AddFoodItem("Пиво (Hop Knot)","models/foodnhouseholditems/beercan03.mdl",0,0.367,"beercan3", 15, "samprp/moreicons/pint.png", Alcohol)
rp.AddFoodItem("Пиво (Master)","models/foodnhouseholditems/beer_master.mdl",0,0.350,"beer1", 15, "samprp/moreicons/pint.png", Alcohol)
rp.AddFoodItem("Хлопья","models/foodnhouseholditems/cokopops.mdl",30,1,"bread5", 0, "samprp/moreicons/baguette.png")
rp.AddFoodItem("Хлеб","models/foodnhouseholditems/bread_loaf.mdl",25,1,"bread5", 0, "samprp/moreicons/baguette.png")
rp.AddFoodItem("Яичница","models/foodnhouseholditems/egg.mdl",10,1,"friedegg", 0, "samprp/moreicons/baguette.png")
rp.AddFoodItem("Бургер","models/foodnhouseholditems/burgergtaiv.mdl",50,1,"burger2", 0, "samprp/moreicons/food_burger.png")
rp.AddFoodItem("Бургер","models/foodnhouseholditems/burgergtasa.mdl",50,1,"burger1", 0, "samprp/moreicons/food_burger.png")
rp.AddFoodItem("Капуста","models/foodnhouseholditems/cabbage1.mdl",10,0.8,"cabbage1", 2, "samprp/moreicons/cabbage.png")
rp.AddFoodItem("Яблоко","models/foodnhouseholditems/apple.mdl",5,0.2,"cabbage1", 3, "samprp/moreicons/cabbage.png")
rp.AddFoodItem("Виноград","models/foodnhouseholditems/grapes1.mdl",6,0.4,"fruitapple18", 8, "samprp/moreicons/food_pancake.png")
rp.AddFoodItem("Морковь","models/foodnhouseholditems/carrot.mdl",15,0.2,"vegcarrot", 10, "samprp/moreicons/carrot.png")
rp.AddFoodItem("Шампанское","models/foodnhouseholditems/champagne2.mdl",0,1,"champagne3", 20, "samprp/emoji/1f37e.png", Alcohol)
rp.AddFoodItem("Сыр","models/foodnhouseholditems/cheesewheel1c.mdl",25,1,"cheesewheel1c",0, "samprp/moreicons/cheese-1.png")
rp.AddFoodItem("Шаурма","models/foodnhouseholditems/chicken_wrap.mdl",50,1,"chickenwrap",0, "samprp/moreicons/food_wrap.png")
rp.AddFoodItem("Перец чили","models/foodnhouseholditems/chili.mdl",10,0.1,"vegchili",10, "samprp/moreicons/chili.png")
rp.AddFoodItem("Чипсы - Cassava Chips","models/foodnhouseholditems/chipsbag1.mdl",18,0.3,"chipsbag1",0, "samprp/moreicons/chips.png")
rp.AddFoodItem("Чипсы - Cheez It","models/foodnhouseholditems/chipscheezit.mdl",18,0.3,"chipscheezit",0, "samprp/moreicons/chips.png")
rp.AddFoodItem("Чипсы - Crunch Tators","models/foodnhouseholditems/chipsbag2.mdl",18,0.3,"chipsbag2",0, "samprp/moreicons/chips.png")
rp.AddFoodItem("Чипсы - Doritos","models/foodnhouseholditems/chipsdoritos2.mdl",18,0.3,"chipsdoritos2",0, "samprp/moreicons/chips.png")
rp.AddFoodItem("Чипсы - Doritos","models/foodnhouseholditems/chipsdoritos.mdl",18,0.3,"chipsdoritos",0, "samprp/moreicons/chips.png")
rp.AddFoodItem("Чипсы - Doritos - Cool Ranch","models/foodnhouseholditems/chipsdoritos5.mdl",18,0.3,"chipsdoritos5",0, "samprp/moreicons/chips.png")
rp.AddFoodItem("Чипсы - Doritos - Diablo","models/foodnhouseholditems/chipsdoritos4.mdl",18,0.3,"chipsdoritos4",0, "samprp/moreicons/chips.png")
rp.AddFoodItem("Чипсы - Doritos - Guacamole","models/foodnhouseholditems/chipsdoritos6.mdl",18,0.3,"chipsdoritos6",0, "samprp/moreicons/chips.png")
rp.AddFoodItem("Чипсы - Fritos Twists","models/foodnhouseholditems/chipsfritostwists.mdl",18,0.3,"chipsfritost", 0, "samprp/moreicons/chips.png")
rp.AddFoodItem("Чипсы - Fritos BarBQ Hoops","models/foodnhouseholditems/chipsfritoshoops.mdl",18,0.35,"chipsfritoshoops", 0, "samprp/moreicons/chips.png")
rp.AddFoodItem("Чипсы - Fritos Twists","models/foodnhouseholditems/chipsfritostwists.mdl",18,0.35,"chipsfritost", 0, "samprp/moreicons/chips.png")
rp.AddFoodItem("Чипсы - Lays","models/foodnhouseholditems/chipslays.mdl",18,0.35,"chipslays", 0, "samprp/moreicons/chips.png")
rp.AddFoodItem("Чипсы - Lays Salt and Vinegar","models/foodnhouseholditems/chipslays2.mdl",18,0.35,"chipslays2", 0, "samprp/moreicons/chips.png")
rp.AddFoodItem("Чипсы - Lays Flamin Hot","models/foodnhouseholditems/chipslays6.mdl",18,0.35,"chipslays6", 0, "samprp/moreicons/chips.png")
rp.AddFoodItem("Чипсы - Lays Dill Pickle","models/foodnhouseholditems/chipslays5.mdl",18,0.35,"chipslays5", 0, "samprp/moreicons/chips.png")
rp.AddFoodItem("Чипсы - Lays Barbeque","models/foodnhouseholditems/chipslays3.mdl",18,0.35,"chipslays3", 0, "samprp/moreicons/chips.png")
rp.AddFoodItem("Чипсы - Lays - Fight for your Flavour","models/foodnhouseholditems/chipslays8.mdl",18,0.35,"chipslays8", 0, "samprp/moreicons/chips.png")
rp.AddFoodItem("Чипсы - Lays - BBQ","models/foodnhouseholditems/chipslays7.mdl",18,0.35,"chipslays7", 0, "samprp/moreicons/chips.png")
rp.AddFoodItem("Чипсы - Lays Sour Cream and Onion","models/foodnhouseholditems/chipslays4.mdl",18,0.35,"chipslays4", 0, "samprp/moreicons/chips.png")
rp.AddFoodItem("Чипсы - Master Hot n' Spicy","models/foodnhouseholditems/chipsbag3.mdl",18,0.35,"chipsbag3", 0, "samprp/moreicons/chips.png")
rp.AddFoodItem("Чипсы - Tropical","models/foodnhouseholditems/chipstropical.mdl",18,0.35,"chipstropical", 0, "samprp/moreicons/chips.png")
rp.AddFoodItem("Чипсы - Twisties","models/foodnhouseholditems/chipstwisties.mdl",18,0.35,"chipstwisties", 0, "samprp/moreicons/chips.png")
rp.AddFoodItem("Кокос","models/foodnhouseholditems/coconut.mdl",25,2,"fruitcoconut", 35, "samprp/moreicons/coconut.png")
rp.AddFoodItem("Cola (большая)","models/foodnhouseholditems/colabig.mdl",5,1,"sodacolalarge", 50, "samprp/moreicons/can.png")
rp.AddFoodItem("Cola (маленькая)","models/foodnhouseholditems/cola_swift2.mdl",2,0.425,"colas2", 25, "samprp/moreicons/can.png")
rp.AddFoodItem("Печенье","models/foodnhouseholditems/cookies.mdl",10,0.1,"cookies", 0, "samprp/moreicons/cookies.png")
rp.AddFoodItem("Кукуруза","models/foodnhouseholditems/corn.mdl",20,0.2,"vegcorn", 10, "samprp/moreicons/corn.png")
rp.AddFoodItem("Круассан","models/foodnhouseholditems/croissant.mdl",30,0.3,"croissant", 0, "samprp/moreicons/croissant.png")
rp.AddFoodItem("Шарлотка","models/foodnhouseholditems/pie.mdl",65,2,"pie", 0, "samprp/moreicons/croissant.png")
rp.AddFoodItem("Печенье","models/foodnhouseholditems/digestive.mdl",25,0.5,"digestivechoko", 0, "samprp/moreicons/food_choco.png")
rp.AddFoodItem("Пончик","models/foodnhouseholditems/donut.mdl",30,0.2,"donut", 0, "samprp/moreicons/doughnut-1.png")
rp.AddFoodItem("Сосиска в тесте","models/foodnhouseholditems/hotdog.mdl",61,0.5,"hotdog", 0, "samprp/moreicons/hot-dog-1.png")
rp.AddFoodItem("Мороженое","models/foodnhouseholditems/icecream.mdl",20,0.5,"icecream", 0, "samprp/moreicons/food_icecream.png")
rp.AddFoodItem("Мёд","models/foodnhouseholditems/honey_jar.mdl",50,1,"honeyjar", 0, "samprp/moreicons/food_honey.png")
rp.AddFoodItem("Зелень","models/foodnhouseholditems/lettuce.mdl",10,0.1,"veglettuce", 10, "samprp/moreicons/food_lettuce.png")
rp.AddFoodItem("Жареная картошка","models/foodnhouseholditems/mcdfrenchfries.mdl",38,0.2,"mcdfries", 0, "samprp/moreicons/food_fries.png")
rp.AddFoodItem("Молоко","models/foodnhouseholditems/milk.mdl",0,0.4,"milk", 40, "samprp/moreicons/milk-1.png")
rp.AddFoodItem("Энергетик","models/foodnhouseholditems/sodacanb01.mdl",0,0.3,"sodacanb01", 20, "samprp/moreicons/can-1.png")
rp.AddFoodItem("Апельсин","models/foodnhouseholditems/orange.mdl",10,0.2,"fruitorange", 15, "samprp/moreicons/orange.png")
rp.AddFoodItem("Апельсиновый сок","models/foodnhouseholditems/juice4.mdl",0,0.3,"orangejuice2", 50, "samprp/moreicons/can-1.png")
rp.AddFoodItem("Груша","models/foodnhouseholditems/pear.mdl",15,0.2,"fruitpear", 15, "samprp/moreicons/pear.png")
rp.AddFoodItem("Перец (жёлтый)","models/foodnhouseholditems/pepper2.mdl",27,0.2,"vegpepper2", 0, "samprp/moreicons/pepper.png")
rp.AddFoodItem("Рогалик","models/foodnhouseholditems/pretzel.mdl",20,0.3,"pretzel", 0, "samprp/moreicons/pretzel.png")
rp.AddFoodItem("Пицца","models/foodnhouseholditems/pizza.mdl",70,1,"pizza1", 0, "samprp/moreicons/pizza-3.png")
rp.AddFoodItem("Кусочек пиццы","models/foodnhouseholditems/pizzaslicehalf.mdl",20,0.3,"pizzaslicehalf", 0, "samprp/moreicons/pizza.png")
rp.AddFoodItem("Тыква","models/foodnhouseholditems/pumpkin01.mdl",60,2,"fruitpumpkin", 0, "samprp/moreicons/pumpkin.png")
rp.AddFoodItem("Сырая рыба","models/foodnhouseholditems/fishbass.mdl",15,0.5,"fish1", 0, "samprp/moreicons/fish.png", InfectionedFood)
rp.AddFoodItem("Кусочки сырой рыбы","models/foodnhouseholditems/fishsteak.mdl",5,0.3,"fish2", 0, "samprp/moreicons/fish.png")
rp.AddFoodItem("Жареная рыба","models/foodnhouseholditems/salmon.mdl",20,0.3,"fish3", 0, "samprp/moreicons/fish.png")
rp.AddFoodItem("Кока Кола","models/foodnhouseholditems/sodacan01.mdl",0,0.240,"sodacan01", 20, "samprp/moreicons/can-1.png")
rp.AddFoodItem("Ред Бул","models/foodnhouseholditems/sodacanc01.mdl",0,0.225,"sodacanc01", 20, "samprp/moreicons/can-1.png")
rp.AddFoodItem("Пепси","models/foodnhouseholditems/sodacan04.mdl",0,0.225,"sodacan04", 20, "samprp/moreicons/can-1.png")
rp.AddFoodItem("Спрайт","models/foodnhouseholditems/sodacan05.mdl",0,0.224,"sodacan05", 20, "samprp/moreicons/can-1.png")
rp.AddFoodItem("Спранк","models/foodnhouseholditems/sprunk1.mdl",0,1,"sodasprunk1", 50, "samprp/moreicons/can-1.png")
rp.AddFoodItem("Тост","models/foodnhouseholditems/toast.mdl",35,0.3,"toast", 0, "samprp/moreicons/toast.png")
rp.AddFoodItem("Шоколад Тофифи","models/foodnhouseholditems/toffifee.mdl",23,0.4,"toffifee", 0, "samprp/moreicons/food_choco.png")
rp.AddFoodItem("Куриная ножка","models/foodnhouseholditems/turkeyleg.mdl",30,0.3,"turkeyleg", 0, "samprp/moreicons/turkey.png")
rp.AddFoodItem("Помидор","models/foodnhouseholditems/tomato.mdl",12,0.2,"vegtomato", 10, "samprp/moreicons/tomato.png")
rp.AddFoodItem("Арбуз","models/foodnhouseholditems/watermelon_unbreakable.mdl",20,2,"fruitwatermelon", 40, "samprp/moreicons/watermelon.png")
rp.AddFoodItem("Стейк на углях","models/foodnhouseholditems/meat6.mdl",30,0.2,"fruitapple30", 0, "samprp/moreicons/food_meat5.png")
rp.AddFoodItem("Тако","models/deadrising/cap6/taco.mdl",60,0.2,"fruitapple20", 0, "samprp/moreicons/taco.png")
rp.AddFoodItem("Бургер","models/foodnhouseholditems/burgersims2.mdl",55,0.2,"fruitapple5", 0, "samprp/moreicons/food_burger.png")
rp.AddFoodItem("Сэндвич","models/foodnhouseholditems/sandwich.mdl",70,0.2,"fruitapple7", 0, "samprp/moreicons/sandwich.png")
rp.AddFoodItem("Картофель фри","models/deadrising/cap6/fries.mdl",40,0.2,"fruitapple8", 0, "samprp/moreicons/fries.png")
rp.AddFoodItem("Печенье","models/foodnhouseholditems/digestive2.mdl",35,0.2,"fruitapple9", 0, "samprp/moreicons/food_cookies.png")
rp.AddFoodItem("Хотдог","models/bioshockinfinite/hotdog.mdl",50,0.2,"fruitapple10", 0, "samprp/moreicons/hot-dog.png")
rp.AddFoodItem("Двойной бургер","models/foodnhouseholditems/mcdburger.mdl",80,0.2,"fruitapple11", 0, "samprp/moreicons/food_burger.png")
rp.AddFoodItem("Мультиобед","models/foodnhouseholditems/mcdmeal2.mdl",90,0.2,"fruitapple12", 30, "samprp/moreicons/food_sushi2.png")
rp.AddFoodItem("Упаковочный обед","models/braxen/tvdinner_contents.mdl",100,0.2,"fruitapple13", 10, "samprp/moreicons/food_sushi2.png")
rp.AddFoodItem("Блины","models/foodnhouseholditems/pancakes.mdl",40,0.2,"fruitapple14", 0, "samprp/moreicons/food_pancake.png")
rp.AddFoodItem("Банка огурцов","models/foodnhouseholditems/picklejar.mdl",30,0.4,"fruitapple15", 40, "samprp/moreicons/food_pancake.png")
rp.AddFoodItem("Бутылка воды","models/illusion/eftcontainers/waterbottle.mdl",0,0.3,"fruitapple16", 30, "samprp/moreicons/food_pancake.png")
rp.AddFoodItem("Грязная вода","models/props_junk/garbage_milkcarton001a.mdl",0,0.3,"fruitapple16", 30, "samprp/moreicons/food_pancake.png", InfectionedFood)
rp.AddFoodItem("Курица-грилль","models/foodnhouseholditems/turkey2.mdl",80,0.4,"fruitapple17", 0, "samprp/moreicons/food_pancake.png")
rp.AddFoodItem("Травяной чай","models/props_junk/glassjug01.mdl",10,0.4,"fruitapple19", 40, "samprp/moreicons/food_pancake.png")
rp.AddFoodItem("Сырое мясо","models/foodnhouseholditems/steak2.mdl",10,0.4,"fruitapple19", 0, "samprp/moreicons/food_pancake.png", InfectionedFood)
rp.AddFoodItem("Домашняя настойка","models/props_junk/GlassBottle01a.mdl",0,0.4,"fruitapple19", 10, "samprp/moreicons/food_pancake.png", StrongAlcohol)


RegisterFood()

rp.lootweights = {
    --Оружие [Остальное] 
tfa_ins_rgo_grenade_owo = 0.53,
tfa_rustalpha_flare = 0.1,
item_lighter = 0.1,
wep_jack_job_drpradio = 0.2,
lockpick = 0.05,
guitar_sad = 2.2,
ent_battery = 0.01,
stormfox_miniclock = 1,
stormfox_clock = 6,
ent_notepad = 0.3,


--Оружие [Холодное]
tfa_breadnope_axe = 1.7,
tfa_nmrih_bat = 0.85,
tfa_kf2_mace = 3.2,
tfa_nmrih_crowbar = 0.7,
tfa_nmrih_fireaxe = 1.2,
tfa_nmrih_fubar = 2.1,
tfa_nmrih_hatchet = 0.6,
tfa_nmrih_kknife = 0.21,
tfa_nmrih_lpipe = 0.7,
tfa_nmrih_machete = 0.53,
tfa_nmrih_sledge = 5.20,
tfa_nmrih_spade = 2,
tfa_nmrih_wrench = 0.2,
tfa_rustalpha_rocktool = 3,
tfa_rustalpha_pickaxe = 3.2,
tfa_rustalpha_stone_hatchet = 1.3,


--Оружие [Самодельное]
tfa_rustalpha_bolt_action_rifle = 4.3,
tfa_rustalpha_revolver = 3.1,
tfbow_sf2 = 1.2,
tfbow_shortbow = 0.65,
tfa_rustalpha_hunting_bow = 0.7,
tfa_rustalpha_pipeshotgun = 3.15,
tfa_rustalpha_handcannon = 0.8,


--Оружие [Первый Тир]
tfa_doim3greasegun = 3.4,
tfa_ins2_pm = 0.8,
tfa_ins2_mr96 = 1.4,
tfa_tfre_hammerless = 0.8,
tfa_ins_sandstorm_tariq = 1.5,
weapon_bfh_tec9 = 1.6,
tfa_ins2_akm_bw = 4.4,
tfa_nam_browning_hi_power = 1.3,
tfa_nam_sawed_off_shotty = 1.8,


--Оружие [Второй Тир]
fnfnp45 = 1,
tfa_ins2_fort500 = 3.8,
tfa_ins2_gsh18 = 0.8,
tfa_ins2_imi_uzi = 1.8,
tfa_ww2_karabin1938 = 3.9,
tfa_nam_m40 = 4.8,
tfa_doimp40 = 5,
tfa_doiowen = 4.2,
tfa_ins2_p320 = 1,
tfa_fml_dabrits_lil_enfield = 5,
tfa_ins2_sks = 3.8,
tfa_doisten = 3.3,
tfa_win73 = 4.1,
tfa_doublebarrel = 3,


--Оружие [Тертий Тир]
tfa_ins2_ak105 = 3.2,
tfa_nam_ak47 = 4,
tfa_ins2_cw_ar15 = 3.4,
tfa_ins2_gol = 6,
weapon_mf_kar98k = 4.1,
tfa_ins2_m590o = 3.2,
tfa_ins2_m9 = 0.9,
tfa_ins2_swmodel10 = 0.9,
tfa_ins2_mp5k_pdw = 2.6,
tfa_ins2_mp7 = 1.7,


--Оружие [Четвертый Тир]
tfa_ins2_at4 = 8,
tfa_ins2_aug = 3.6,
tfa_ins2_m1014 = 3.8,
tfa_ins2_m14retro = 6,
tfa_ins2_mk14ebr = 3.7,
tfa_ins2_mk18 = 3.2,
tfa_ins2_codol_msr = 7.7,
tfa_ins2_rpk_74m = 5,
tfa_fas2_glock20 = 0.8,
weapon_sanic_m2_flamethrower = 16,

--Каркасы [Оружия]
tfa_ins2_ak105_body = 2.8,
tfa_nam_ak47_body = 2.7,
tfa_ins2_cw_ar15_body = 2.5,
tfa_ins2_aug_body = 2.9, 
fnfnp45_body = 0.35,
tfa_ins2_fort500_body = 2.6,
tfa_ins2_gol_body = 4,
tfa_ins2_gsh18_body = 0.45,
tfa_ins2_imi_uzi_body = 0.9,
tfa_ins2_m1014_body = 2.8,
tfa_nam_m40_body = 3,
tfa_ins2_m590o_body = 2.4,
tfa_ins2_m9_body = 0.4,
tfa_ins2_pm_body = 0.35,
tfa_ins2_mk14ebr_body = 2.9,
tfa_ins2_mk18_body = 2.4,
tfa_ins2_mp7_body = 0.8,
tfa_ins2_mr96_body = 0.9,
tfa_ins2_codol_msr_body = 5.6,
tfa_ins2_p320_body = 0.45,
tfa_ins2_rpk_74m_body = 2.7,
tfa_ins2_sks_body = 2.3,
tfa_doisten_body = 1.9,
tfa_ins_sandstorm_tariq_body = 0.7,
weapon_bfh_tec9_body = 0.9,
tfa_doublebarrel_body = 1.7,
tfa_ins2_akm_bw_body = 2.6,
tfa_nam_browning_hi_power_body = 0.7,
tfa_fas2_glock20_body = 0.4,
tfa_nam_sawed_off_shotty_body = 0.95,


-- Бинокли
weapon_rpw_binoculars_nvg = 1.5,
weapon_rpw_binoculars = 1.2,
weapon_rpw_binoculars_vintage = 1.6,
weapon_rpw_binoculars_scout = 1.3,
weapon_rpw_binoculars_explorer = 1.8,


--Семена [Упаковка]
fs_melon_seeds = 0.2,
fs_orange_seeds = 0.1,
fs_potato_seeds = 0.1,
fs_tomato_seeds = 0.1,
fs_cabbage_seeds = 0.2,
fs_apple_seeds = 0.3,


--Радио [Дальнобойная рация (Установка)]
sent_djaddon_mic = 0.3,
sent_djaddon_mic_alt = 0.3,
sent_djaddon_radio = 12,
sent_djaddon_transmitter = 4.8,


--Медицина [Аптечки и т.д.]
ent_medkit = 2,
ent_bandage = 0.2,
med_boostinject = 0.1,
med_flupill = 0.015,
ent_smallmedkit = 0.1,
ent_shina = 1,
ent_medboost = 0.02,


--Ловушки
bouncingmortar = 7.5,
tripwiregrenade = 0.6,
harpoontrap = 4,
springgun = 5,
tripwireextender = 0.3,


--Обвесы [На оружие]
ins2_br_supp = 0.5,
ins2_si_eotech = 0.35,
xps2 = 0.5,
ins2_si_rds = 0.2,
ins2_mag_speedloader = 0.12,
ins2_fg_grip = 0.1,
ar15_si_folded = 0.2,
ar15_m16_stock = 0.4,
ar15_magpul_stock = 0.8,
ins2_si_2xrds = 0.4,
ins2_si_po4x = 0.6,
ins2_si_mosin = 0.6,
rmr = 0.3,
ins2_br_heavy = 1,
ar15_m16_barrel = 0.7,
ar15_magpul_barrel = 0.1,
ar15_ris_barrel = 0.5,
ar15_ext_ris_barrel = 0.3,


--Гильзы [Каркас патрона]
['12_bullet_raw'] = 0.016,
['308_bullet_raw'] = 0.013,
['357_bullet_raw'] = 0.09,
['45_acp_bullet_raw'] = 0.011, 
['545_39_bullet_raw'] = 0.03,
['556_45_bullet_raw'] = 0.04,
['762_54_bullet_raw'] = 0.022,
['9_19_bullet_raw'] = 0.05,
['arrow_raw'] = 0.04,


-- Снаряды [Патроны и т.д]
tfa_rustalpha_ammo_arrow = 0.01,
tfa_rustalpha_ammo_handmade_shell = 0.01,
tfa_ammo_buckshot = 0.05,
tfa_ammo_sniper_rounds = 0.07,
tfa_ammo_357 = 0.015,
tfa_ammo_pistol = 0.014,
tfa_ammo_winchester = 0.01,
tfa_ammo_ar2 = 0.012, 
tfa_ammo_ar1 = 0.07,
tfa_ammo_smg = 0.05,
tfa_ammo_smg1_grenade = 0.3,


--Ресурсы [Дерево и т.д]
wood = 0.2,
zapchasti = 0.05,
stone = 0.04,
plastic = 0.07,
sulfur = 0.05,
steel = 0.05,
cloth = 0.02,
coil = 0.03,
reaktiv = 0.02,


--Лут[Все что есть в категории Лут]
['30mmround'] = 8,
sparkplug = 0.05,
carbattery = 12,
hlam31 = 0.9,
ducttape = 0.06,
powersupplyunit = 1.3,
hlam5 = 5,
magnet = 0.1,
hlam34 = 0.8,
copypaper = 1,
hlam32 = 0.4,
update01_hlam2 = 0.8,
graphicscard = 0.7,
militarybattery = 20, 
laptop = 5.2,
airfilter = 10,
wrench = 0.8,
hlam26 = 0.8,
gasanalyser = 0.2,
nuts = 0.1,
gyroscope = 0.4,
gyrotachometer = 0.7,
hlam27 = 0.8,
engine = 10,
newhlam5 = 0.05,
newhlam6 = 0.05,
hlam23 = 0.085,
hlam21 = 0.085,
intel = 0.5,
hdd = 0.7,
newhlam1 = 0.6,
newhlam3 = 0.065,
phaseantenna = 2.5,
goldchain = 0.7, 
toothpaste = 0.2,
gasoline = 0.2,
kerosine = 2,
hlam33 = 0.9,
gasoline_filledwithfuel = 2.5, 
militarycable = 0.2,
gpgreen = 0.6,
ammocase = 0.4, 
labskeycard = 0.01,
hlam22 = 0.2,
hlam20 = 0.2, 
hlam4 = 0.7,
trigger = 0.05,
lightbulb = 0.04,
nixxorlens = 0.2,
pressuregauge = 0.46,
update01_hlam8 = 4,
hlam9 = 0.1,
newhlam4 = 0.3,
soap = 0.1,
packofscrews = 0.3,
diagset = 0.5,
armorrepair = 4, 
hlam11 = 1.4,
hlam2 = 2,
toolset = 1.7,
hlam3 = 1.5,
capacitors = 0.2,
medpile = 0.1,
hlam8 = 0.1,
medsyringe = 0.030,
hlam10 = 3.5,
newhlam2 = 0.2,
bleach = 0.6,
update01_hlam6 = 0.5,
powerbank = 0.3,
update01_hlam10 = 0.1,
nailpack = 0.8,
flashstorage = 0.6,
circuitboard = 0.2,
gpred = 0.9,
plexiglass = 0.2,
pliers = 0.3,
gpblue = 0.8,
wbutt = 0.8,
wires = 0.1,
paracord = 0.25,
update01_hlam3 = 0.030, 
hlam29 = 0.050,
update01_hlam11 = 0.1,
update01_hlam7 = 0.2,
lcdclean = 0.3,
gphonex = 0.2,
gphone = 0.1,
hlam14 = 0.2,
lcddirty = 0.2,
handle = 0.3,
pen = 0.01,
insulatingtape = 0.040,
hlam36 = 5,
bloodexample = 0.1, 
hlam25 = 0.5,
hlam12 = 2,
hlam35 = 0.1,
hlam19 = 0.1,
hlam13 = 0.2,
matches = 0.2,
update01_hlam4 = 0.5,
washing = 0.7,
hlam30 = 0.1,
hlam24 = 0.2,
hlam15 = 0.1,
hlam16 = 0.1,
hlam18 = 0.2,
hlam17 = 0.3,
horse = 1,
lionstatue = 2,
update01_hlam5 = 0.1, 
dryfuel = 0.2,
geigercounter = 0.1,
fuelconditioner = 1,
helix = 0.1,
update01_hlam9 = 0.1,
booster = 4,
phaserelay = 0.1,
catfigure = 1.5,
aquafilter = 0.2,
update01_hlam1 = 0.5,
forend = 0.1,
chain = 0.1, 
hlam28 = 1,
shampoo = 0.2, 
hose = 0.3,
powercord = 0.2,
powerfilter = 1.8,
electricdrill = 2.6,
hlam1 = 1.5,


--Одежда [Одежда и вещи]
balaclava8 = 0.030,
balaclava9 = 0.030,
balaclava2 = 0.030,
balaclava7 = 0.030,
balaclava4 = 0.030,
balaclava5 = 0.030,
balaclava3 = 0.030,
balaclava6 = 0.030,
balaclava11 = 0.030,
balaclava10 = 0.030,
balaclava1 = 0.030,
ballisticvest = 5,
gta_bandana01 = 0.030, 
backpack_blackjack = 2,
armourvest = 12,
michhelmet = 1.2,
confederate_hat = 0.050, 
hatgeneral = 0.1,
backpack_citya = 0.7,
backpack_cityc = 0.7,
backpack_city2b = 0.7,
backpack_cityb = 0.7,
backpack_city2a = 0.7,
helmetmich = 1.1,
pressvest = 5,
pilothelm1 = 1.2,
pilothelm2 = 1.2,
pilothelm3 = 1.2,
gta_beret01 = 0.1,
gta_cap02f = 0.050, 
gta_cap02e = 0.050, 
gta_cap02j = 0.050, 
gta_cap02a = 0.050, 
gta_cap02g = 0.050, 
gta_cap02i = 0.050, 
gta_cap02l = 0.050, 
gta_cap02h = 0.050, 
gta_cap02d = 0.050, 
gta_cap02c = 0.050, 
gta_cap02k = 0.050, 
gta_cap01c = 0.050, 
gta_cap01f = 0.050, 
gta_cap01d = 0.050, 
gta_cap01e = 0.050, 
gta_cap01h = 0.050, 
gta_cap02b = 0.050, 
gta_cap01b = 0.050, 
gta_cap01j = 0.050, 
gta_cap01i = 0.050, 
gta_cap01g = 0.050, 
gta_cap01a = 0.050, 
bandit4 = 0.025, 
bandit1 = 0.025,
bandit3 = 0.025,
bandit2 = 0.025,
headbandage3 = 0.035,
headbandage4 = 0.025,
headbandage1 = 0.025,
headbandage2 = 0.025,
manmask3 = 0.1,
manmask4 = 0.1,
manmask2 = 0.1,
butcher1 = 0.1,
butcher2 = 0.1,
monkey = 0.1,
gta_owlmask01 = 0.1, 
manmask1 = 0.1,
motohelmet = 0.7,
motohelmet2 = 0.7,
motohelmet5 = 0.7,
motohelmet6 = 0.7,
motohelmet3 = 0.7,
motohelmet4 = 0.7,
motohelmet10 = 0.7,
motohelmet9 = 0.7,
motohelmet8 = 0.7,
motohelmet1 =0.7,
motohelmet7 = 0.7,
gta_glasses02 = 0.040,
gta_glasses01c = 0.040,
gta_glasses01d = 0.040,
gta_glasses01e = 0.040,
gta_glasses01f = 0.040,
gta_glasses01b = 0.040,
pilotgoggles = 0.1,
gta_glasses01 = 0.040,
firehelmet = 1.1,
policevest = 4,
backpack_molle = 0.5,
m17 = 0.9,
m40 = 0.9,
pbf = 0.8,
s10 = 0.9,
m10 = 0.9,
backpack_trizip = 1,
backpack_baselardwild = 0.8,
ssh68 = 1,
ukvest = 1.2,
smershvest = 2,
tacticalvest = 1.5,
backpack_pilgrim2a = 1,
backpack_pilgrim = 1,
backpack_pilgrim2b = 1,
backpack_pilgrim2c = 1,
gta_hat01 = 0.1,
hocmaskmaniac = 0.2,
hocmask14 = 0.2,
hocmask10 = 0.2,
hocmask7 = 0.2,
hocmask13 = 0.2,
hocmask6 = 0.2,
hocmask5 = 0.2,
hocmask3 = 0.2,
hocmask4 = 0.2,
hocmask11 = 0.2,
hocmask9 = 0.2,
hocmask8 = 0.2,
hocmask1 = 0.2,
hocmask2 = 0.2,
hocmask15 = 0.2,
hocmask12 = 0.2,
gta_beanie01e = 0.1,
gta_beanie01c = 0.1,
gta_beanie01a = 0.1,
gta_beanie02c = 0.1,
gta_beanie02b = 0.1,
gta_beanie01b = 0.1,
gta_beanie02d = 0.1,
gta_beanie02a = 0.1,
gta_beanie01d = 0.1,
gmod_fedora = 0.1,
assaulthelmet = 2,

-- РЕСУРСЫ
resources = 0.5,
building_resources = 0.25,


oat = 0.2,
testo = 0.2,
}


for class, tbl in pairs(rp.Drugs) do
    rp.AddEntity(tbl.name,{
        ent = class,
        model = tbl.model,
        price = 0,
        usable = true,
        max = 0,
        cmd = '',
        weight = tbl.weight or rp.lootweights[class] or 0.1,
    })
end

for k,v in pairs(R_CraftSystem.Details) do
    rp.AddEntity(v.name,{
        category = 'Крафт',
        ent = k,
        model = v.model,
        price = 0,
        max = 0,
        cmd = '',
        pocket = false,
        weight = rp.lootweights[k] or 0.5,
        npcsell = false,
    })
end 

for class,tbl in pairs(rp.Ammo) do
    local ENT = {}
    ENT.Base = "base_gmodentity"
    ENT.Type = "anim"
    ENT.PrintName = tbl.Name
    ENT.WorldModel = tbl.Model
    ENT.Model = tbl.Model

    ENT.Category = "Пули"
    ENT.Spawnable = true

    if SERVER then
        function ENT:Initialize()
            self:SetModel( self.WorldModel )
            self:PhysicsInit(SOLID_VPHYSICS)
            self:SetMoveType(MOVETYPE_VPHYSICS)
            self:SetSolid(SOLID_VPHYSICS)
            self:SetUseType(SIMPLE_USE)
            local phys = self:GetPhysicsObject()
            phys:Wake()
        end
    end
    scripted_ents.Register( ENT, class )

    rp.AddEntity(tbl.Name,{
        ent = class,
        model = tbl.Model,
        price = 0,
        max = 0,
        cmd = '',
        pocket = false,
        weight = rp.Ammo[class].weight or 0.01,
        npcsell = false,
    })

    local ENT = {}
    ENT.Base = "base_gmodentity"
    ENT.Type = "anim"
    ENT.PrintName = "Гильза для "..tbl.Name
    ENT.WorldModel = tbl.Model
    ENT.Model = tbl.Model

    ENT.Category = "Гильзы"
    ENT.Spawnable = true

    if SERVER then
        function ENT:Initialize()
            self:SetModel( self.WorldModel )
            self:PhysicsInit(SOLID_VPHYSICS)
            self:SetMoveType(MOVETYPE_VPHYSICS)
            self:SetSolid(SOLID_VPHYSICS)
            self:SetUseType(SIMPLE_USE)
            local phys = self:GetPhysicsObject()
            phys:Wake()
        end
    end
    scripted_ents.Register( ENT, class.."_raw" )

    rp.AddEntity("Гильза для "..tbl.Name,{
        ent = class.."_raw",
        model = tbl.Model,
        price = 0,
        max = 0,
        cmd = '',
        pocket = false,
        weight = rp.Ammo[class].weight or 0.01,
        npcsell = false,
    })
end

for k,v in pairs(R_CraftSystem.Disassembly) do
    for k2,v2 in pairs(rp.lootweights) do
        if k2 == k then
            setweight = v2
            break
        else
            setweight = 1 
        end 
    end
    rp.AddEntity(v.name,{
        category = 'Крафт',
        ent = k,
        model = v.model,
        price = 0,
        usable = false,
        max = 0,
        cmd = '',
        pocket = false,
        weight = rp.lootweights[k] or 0.5,
        npcsell = false,
    })
end
timer.Simple(1, function()
    for k, v in pairs(R_CraftSystem.Recipes) do
        if not v.name then v.name = weapons.GetStored(k).PrintName end
        if not v.model then v.model = weapons.GetStored(k).WorldModel end

        for k2,v2 in pairs(rp.lootweights) do
            if k2 == k then
                setweight = v2
                break
            else
                setweight = 1 
            end 
        end
        if v.type == "main" then
            rp.AddShipment(v.name, {
                model  = v.model, 
                entity = k, 
                price = 0,
                type = "main",
                weight = v.weight or rp.lootweights[k] or 0.5,
            })
            Cosmetics.Items[k] = {
                name= v.name,
                id = k,
                model= v.model, 
                pos = v.pos,
                ang = v.ang,
                slot=COSM_SLOT_RHAND,
                type = "weapon",
                scale=1,
                bone = "ValveBiped.Bip01_Spine2",
                price=0,
            }
        elseif v.type == "pistol" then
            rp.AddShipment(v.name, {
                model  = v.model, 
                entity = k, 
                type = "pistol",
                price = 0,
                weight = v.weight or rp.lootweights[k] or 0.5,
            })
            Cosmetics.Items[k] = {
                name= v.name,
                id = k,
                model= v.model,
                pos = v.pos,
                ang = v.ang,
                slot=COSM_SLOT_LHAND,
                scale=v.scale or 1,
                bone = "ValveBiped.Bip01_Spine",
                type = "weapon",
                price=0,
            }          
        end
    end
end)
-- hook.Add( "InitPostEntity", "SetupMaxMinZsysVectors", function()
timer.Simple(1, function()
    for k, v in pairs(rp.shipments) do
        if v.type == "knife" then
            Cosmetics.Items[v.entity] = {
                name= v.name,
                id = v.entity,
                model= v.model,
                pos = v.pos or Vector(-5,3,-3),
                ang = v.ang or Angle(-90,0,0),
                slot=COSM_SLOT_PET,
                scale=v.scale or 1,
		        bone = "ValveBiped.Bip01_Spine2",
                type = "weapon",
                price=0,
            }
        end
    end
end)

