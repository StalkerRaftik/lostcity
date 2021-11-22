rp.LootSystem = rp.LootSystem or {}

rp.LootSystem.LootTypes = {

    -- РАЗДЕЛ [ОРУЖИЕ] --
    ["КорпусОружияТир-1"] = { loot = {
        "tfa_ins2_pm_body", 
        "tfa_ins2_mr96_body",
        "tfa_ins_sandstorm_tariq_body",
        "weapon_bfh_tec9_body",
        "tfa_ins2_akm_bw_body",
        "tfa_nam_browning_hi_power_body",
        "tfa_nam_sawed_off_shotty_body",
    }, type = INV_ENTITY},

    ["КорпусОружияТир-2"] = { loot = {
        "fnfnp45_body",
        "tfa_ins2_fort500_body",
        "tfa_ins2_gsh18_body",
        "tfa_ins2_imi_uzi_body",
        "tfa_ww2_karabin1938_body",
        "tfa_nam_m40_body",
        "tfa_doimp40_body",
        "tfa_doiowen_body",
        "tfa_ins2_p320_body",
        "tfa_fml_dabrits_lil_enfield_body",
        "tfa_ins2_sks_body",
        "tfa_doisten_body",
        "tfa_win73_body",
        "tfa_doublebarrel_body",
    }, type = INV_ENTITY},

    ["КорпусОружияТир-3"] = { loot = {
        "tfa_ins2_ak105_body",
        "tfa_nam_ak47_body",
        "tfa_ins2_cw_ar15_body",
        "tfa_ins2_gol_body",
        "weapon_mf_kar98k_body",
        "tfa_ins2_m590o_body",
        "tfa_ins2_m9_body",
        "tfa_ins2_swmodel10_body",
        "tfa_ins2_mp5k_pdw_body",
        "tfa_ins2_mp7_body",
    }, type = INV_ENTITY},

    ["КорпусОружияТир-4"] = { loot = {
        "tfa_ins2_aug_body",
        "tfa_ins2_m1014_body",
        "_body",
        "tfa_ins2_m14retro_body",
        "tfa_ins2_mk14ebr_body",
        "tfa_ins2_mk18_body",
        "tfa_ins2_codol_msr_body",
        "tfa_ins2_rpk_74m_body",
        "tfa_fas2_glock20_body",
        "tfa_ins2_at4_body",
    }, type = INV_ENTITY},


    ["ХолодноеОружиеСтандартное"] = { loot = {
        "tfa_breadnope_axe",
        "tfa_nmrih_bat",
        "tfa_nmrih_crowbar",
        "tfa_nmrih_hatchet",
        "tfa_nmrih_kknife",
        "tfa_nmrih_lpipe",
        "tfa_nmrih_machete",
        "tfa_nmrih_spade",
        "tfa_nmrih_wrench",
        "tfa_rustalpha_rocktool",
    }, type = INV_WEAPON},

    ["ХолодноеОружиеРедкое"] = { loot = {
        "tfa_kf2_mace",
        "tfa_nmrih_fubar",
        "tfa_nmrih_sledge",
        "tfa_nmrih_fireaxe",
    }, type = INV_WEAPON},




    ["РедкоеГражданское"] = { loot = {
        "tfa_ins2_pm",
        "tfa_tfre_hammerless",
        "tfa_nam_browning_hi_power",
    }, type = INV_WEAPON},

    ["ОхотничьеОружиеОченьРедкое"] = { loot = {
        "tfa_nam_sawed_off_shotty",
        "tfa_ins2_remington_m24_sws",
        "tfa_ins2_fort500",
        "tfa_ins2_swmodel10",
    }, type = INV_WEAPON},


    









    



    -- Раздел [Модули для оружия] --
    ["Обвесы [Entity]"] = { loot = {
        "ins2_br_supp",
        "ins2_si_eotech",
        "xps2",
        "ins2_si_rds",
        "ar15_si_folded",
        "ar15_m16_stock",
        "ar15_magpul_stock",
        "ins2_si_2xrds",
        "ins2_fg_grip",
    }, type = INV_ENTITY},

    ["ОбвесыРедкие [Entity]"] = { loot = {
        "ins2_si_po4x",
        "ins2_si_mosin",
        "rmr",
        "ar15_m16_barrel",
        "ar15_magpul_barrel",
        "ar15_ris_barrel",
        "ar15_ext_ris_barrel",
        "ins2_mag_speedloader",
        "ins2_br_heavy",
    }, type = INV_ENTITY},

    
    ["ОсновныеСостовляющиеОружия [Entity]"] = { loot = {
        "trigger",
        "wbutt",
        "handle",
        "forend",
    }, type = INV_ENTITY},

    


   














    -- Медицина [Другие Хим. вещества] --
    ["Медицина [ХЛАМ]"] = { loot = {
        "usedbandage",
        "medpile",
        "medsyringe",
        "bloodexample",
    }, type = INV_ENTITY},


    ["Медицина [Weapon]"] = { loot = {
        "fas2_ifak",
    }, type = INV_WEAPON},

    ["Медицина [Entity]"] = { loot = {
        "ent_bandage",
        "ent_medkit",
        "med_boostinject",
        "ent_smallmedkit",
        "ent_shina",
        "ent_medboost",
    }, type = INV_ENTITY},

    
    ["Химия [Entity]"] = { loot = {
        "acetone",
        "benznatriya",
        "bismuth",
        "pervodoroda",
        "propglicogol",
        "toluol",
    }, type = INV_ENTITY},




   









    -- Боеприпасы [Гильзы, патроны, рожки] --
    ["Гильзы"] = { loot = {
        ["12_bullet_raw"] = {1,10},
        ["308_bullet_raw"] = {1,10},
        ["357_bullet_raw"] = {1,10},
        ["45_acp_bullet_raw"] = {1,10},
        ["545_39_bullet_raw"] = {1,10},
        ["556_45_bullet_raw"] = {1,10},
        ["762_54_bullet_raw"] = {1,10},
        ["9_19_bullet_raw"] = {1,10},
        ["arrow_raw"] = {1,10},
    }, type = INV_ENTITY},

    ["Пули"] = { loot = {
        ["12_bullet"] = {1,10},
        ["308_bullet"] = {1,10},
        ["357_bullet"] = {1,10},
        ["45_acp_bullet"] = {1,10},
        ["545_39_bullet"] = {1,10},
        ["556_45_bullet"] = {1,10},
        ["762_54_bullet"] = {1,10},
        ["9_19_bullet"] = {1,10},
        ["arrow"] = {1,10},
    }, type = INV_ENTITY},
















    -- Пища [Еда, Вода, Хлам пища] --
    ["Еда"] = { loot = {       
        "models/foodnhouseholditems/chipsbag1.mdl",
        "models/foodnhouseholditems/chipscheezit.mdl",
        "models/foodnhouseholditems/chipsbag2.mdl",
        "models/foodnhouseholditems/chipsdoritos2.mdl",
        "models/foodnhouseholditems/chipsdoritos.mdl",
        "models/foodnhouseholditems/chipsdoritos5.mdl",
        "models/foodnhouseholditems/chipsdoritos4.mdl",
        "models/foodnhouseholditems/chipsdoritos6.mdl",
        "models/foodnhouseholditems/chipslays.mdl",
        "models/foodnhouseholditems/chipsfritostwists.mdl",
        "models/foodnhouseholditems/chipsfritoshoops.mdl",
        "models/foodnhouseholditems/chipsfritostwists.mdl",
        "models/foodnhouseholditems/chipslays.mdl",
        "models/foodnhouseholditems/chipslays2.mdl",
        "models/foodnhouseholditems/chipslays6.mdl",
        "models/foodnhouseholditems/chipslays5.mdl",
        "models/foodnhouseholditems/chipslays3.mdl",
        "models/foodnhouseholditems/chipslays8.mdl",
        "models/foodnhouseholditems/chipslays7.mdl",
        "models/foodnhouseholditems/chipslays4.mdl",
        "models/foodnhouseholditems/chipsbag3.mdl",
        "models/foodnhouseholditems/chipstropical.mdl",
        "models/foodnhouseholditems/chipstwisties.mdl",
        "models/foodnhouseholditems/cookies.mdl",
        "models/foodnhouseholditems/digestive.mdl",
        "models/foodnhouseholditems/toffifee.mdl",
    }, type = INV_FOOD},

    ["Вода"] = { loot = {
        "models/props_junk/garbage_milkcarton001a.mdl",
        "models/foodnhouseholditems/cola_swift2.mdl",
        "models/foodnhouseholditems/sodacan01.mdl",
        "models/foodnhouseholditems/sodacanc01.mdl",
        "models/foodnhouseholditems/sodacan04.mdl",
        "models/foodnhouseholditems/sodacan05.mdl",
        "models/foodnhouseholditems/sprunk1.mdl",
        "models/foodnhouseholditems/sodacanb01.mdl",
        "models/foodnhouseholditems/juicesmall.mdl",
        "models/foodnhouseholditems/juice3.mdl",
    }, type = INV_FOOD},

    ["МусорЕда"] = { loot = {
        "food_94",
        "hlam29",
        "update01_hlam7", 
        "update01_hlam3", 
        "update01_hlam11", 
        "hlam29", 
        "update01_hlam7", 
        "update01_hlam3",
    }, type = INV_ENTITY},



    















    












    -- ДРУГОЕ --
    ["Остальное"] = { loot = {
        "item_lighter",
        "guitar_sad",
    }, type = INV_WEAPON},

    
    ["Бинокли"] = { loot = {
        "weapon_rpw_binoculars_explorer",
        "weapon_rpw_binoculars_scout",
        "weapon_rpw_binoculars_vintage",
        "weapon_rpw_binoculars",
        "weapon_rpw_binoculars_nvg",
    }, type = INV_WEAPON},
















    


    -- Разнообразные Материалы --
    ["ЛутПослеРазбора"] = { loot = {
        "wood",
        "zapchasti",
        "stone",
        "plastic",
        "sulfur",
        "steel",
        "cloth",
        "coil",
        "reaktiv",
    }, type = INV_ENTITY},




   



















    -- Лут [Хлам и т.д.] --
    ["ХламОбычный"] = { loot = {
        "food_94",
        "hlam31",
        "ducttape",
        "magnet",
        "hlam34",
        "copypaper",
        "hlam32",
        "update01_hlam2",
        "nuts",   
        "hlam26",
        "gyrotachometer",
        "hlam27",
        "newhlam6",
        "newhlam5",
        "hlam21",
        "intel",   
        "newhlam3",
        "newhlam1",
        "toothpaste",
        "hlam22",
        "hlam33",
        "hlam20",
        "lightbulb",   
        "update01_hlam8",
        "hlam9",
        "newhlam4",
        "packofscrews",
        "hlam2",   
        "hlam3",
        "hlam8",
        "hlam10",
        "newhlam2",
        "bleach",   
        "update01_hlam6",
        "update01_hlam10",
        "nailpack",
        "circuitboard",
        "gpred",   
        "pliers",
        "wires",
        "update01_hlam11",
        "update01_hlam7",   
        "lcddirty",
        "pen",
        "hlam14",
        "hlam25",
        "hlam13",   
        "matches",
        "update01_hlam4",
        "washing",
        "hlam30",   
        "hlam24",
        "hlam28",
    }, type = INV_ENTITY},

    ["ХламРедкий"] = { loot = {
        "food_94",
        "carbattery",
        "powersupplyunit",
        "graphicscard",
        "wrench",
        "gyroscope",
        "engine",
        "hdd",
        "gasoline",   
        "militarycable",
        "gpgreen",
        "hlam4",
        "nixxorlens",
        "pressuregauge",
        "soap",
        "hlam11",   
        "toolset",
        "capacitors",
        "powerbank",
        "plexiglass",
        "gpblue",   
        "hlam29",
        "update01_hlam3",
        "lcdclean",
        "insulatingtape",
        "gphone",   
        "hlam15",
        "hlam17",
        "hlam16",
        "horse",   
        "phaserelay",
        "aquafilter",
        "update01_hlam1",
        "chain",
        "shampoo",   
        "hlam1",
        "ent_battery",
        "ent_repairkit",
    }, type = INV_ENTITY},

    ["ХламОченьРедкий"] = { loot = {
        "30mmround",
        "sparkplug",
        "militarybattery",
        "laptop",
        "airfilter",
        "gasanalyser",
        "phaseantenna",
        "goldchain",   
        "kerosine",
        "ammocase",
        "labskeycard",
        "diagset",
        "armorrepair",
        "flashstorage",
        "paracord",   
        "gphonex",
        "hlam36",
        "hlam35",
        "hlam18",
        "catfigure",   
        "hose",
        "powercord",
        "powerfilter",
        "electricdrill",
        "ent_fuel",
    }, type = INV_ENTITY},

    



    

























    -- ЭКИПИРОВКА [Бронежелеты, Шлема, Аксессуары] --
    ["Бронежелеты и Разгрузка [Обычные]"] = { loot = {
        "armor_kirasa",
        "armor_paca",
        "armor_un",
        "armor_zhuk3",
    }, type = INV_HATS},

    ["Бронежелеты и Разгрузка [Редкие]"] = { loot = {
        "ballisticvest",
        "armor_iotv",
        "pressvest",
        "policevest",
        "tacticalvest",
    }, type = INV_HATS},

    ["Бронежелеты и Разгрузка [ОченьРедкие]"] = { loot = {
        "armor_6b13",
        "armor_6b13_flora",
        "armor_6b13_killa",
        "armor_6b23",
        "armor_6b23_mflora",
        "armor_6b34",
        "armor_gjel",
        "armor_zhuk3",
        "armourvest",
    }, type = INV_HATS},


    ["Шлема"] = { loot = {
        "michhelmet",
        "helmetmich",
        "pilothelm1",
        "pilothelm2",
        "pilothelm3",
        "motohelmet",
        "motohelmet2",
        "motohelmet5",
        "motohelmet6",
        "motohelmet3",
        "motohelmet4",
        "motohelmet10",
        "motohelmet9",
        "motohelmet8",
        "motohelmet1",
        "motohelmet7",
        "firehelmet",
        "ssh68",
        "assaulthelmet",
        "helmet_psh97_jeta",
        "helmet_kiverm",
        "helmet_6b47_camo",
        "helmet_shpm",
        "helmet_maska_1sh_killa",
    }, type = INV_HATS},


    ["Противогазы"] = { loot = {
        "m17",
        "m40",
        "pbf",
        "s10",
        "m10",
    }, type = INV_HATS},


    ["РюкзакиОбычные"] = { loot = {
        "backpack_molle",
        "backpack_citya",
        "backpack_cityc",
        "backpack_city2b",
        "backpack_cityb",
        "backpack_city2a",
        "backpack_molle",
    }, type = INV_HATS},

    ["РюкзакиРедкие"] = { loot = {
        "backpack_trizip",
    }, type = INV_HATS},

    ["РюкзакиОченьРедкие"] = { loot = {
        "backpack_baselardwild",
        "backpack_blackjack",
        "backpack_pilgrim2a",
        "backpack_pilgrim",
        "backpack_pilgrim2b",
        "backpack_pilgrim2c",
    }, type = INV_HATS},
    







    ["Одежда"] = { loot = {
        "Брюки 1 (муж.)",
        "Брюки 2 (муж.)",
        "Брюки 3 (муж.)",
        "Брюки 4 (муж.)",
        "Брюки 5 (муж.)",
        "Брюки 6 (муж.)",
        "Брюки 7 (муж.)",
        "Брюки 8 (муж.)",
        "Брюки 9 (муж.)",
        "Брюки 10 (муж.)",
        "Футболка 1 (муж.)",
        "Футболка 2 (муж.)",
        "Футболка 3 (муж.)",
        "Футболка 4 (муж.)",
        "Футболка 5 (муж.)",
        "Футболка 6 (муж.)",
        "Футболка 7 (муж.)",
        "Футболка 8 (муж.)",
        "Футболка 9 (муж.)",
        "Футболка 10 (муж.)",
        "Футболка 10 (муж.)",
        "Футболка 11 (муж.)",
        "Футболка 12 (муж.)",
        "Футболка 13 (муж.)",
        "Футболка 14 (муж.)",
        "Футболка 15 (муж.)",
        "Футболка 16 (муж.)",
        "Футболка 17 (муж.)",
        "Футболка 18 (муж.)",
        "Футболка 19 (муж.)",
        "Футболка 20 (муж.)",
        "Футболка 21 (муж.)",
        "Футболка 22 (муж.)",
        "Футболка 23 (муж.)",
        "Футболка 24 (муж.)",
        "Футболка 25 (муж.)",
        "Футболка 26 (муж.)",
        "Футболка 27 (муж.)",
        "Футболка 28 (муж.)",
        "Красная парка (муж.)",
        "Синяя парка (муж.)",
        "Куртка 3 (муж.)",
        "Костюм 1 (муж.)",
    }, type = INV_CLOTHES},




    --АКСЕССУАРЫ--
    ["Маски и Кепки и Балаклавы"] = { loot = {
        "balaclava8",
        "balaclava9",
        "balaclava2",
        "balaclava7",
        "balaclava4",
        "balaclava4",
        "balaclava3",
        "balaclava10",
        "balaclava1",
        "gta_bandana01",
        "gta_cap02f",
        "gta_cap02f",
        "gta_cap02f",
        "gta_cap02f",
        "gta_cap02f",
        "gta_cap02i",
        "gta_cap02k",
        "gta_cap01i",
        "gta_cap01g",
        "headbandage3",
        "headbandage4",
        "headbandage1",
        "manmask3",
        "manmask1",
        "hocmask14",
        "hocmask14",
        "hocmask8",
        "hocmask2",
        "gta_beanie01e",
        "gta_beanie01a",
        "gta_beanie02b",
        "gta_beanie02d",
        "gta_beanie01d",
        "gmod_fedora",
    }, type = INV_HATS},


    ["РедкиеАксессуары"] = { loot = {   
        "confederate_hat",
        "confederate_hat",
        "balaclava6",
        "balaclava11",
        "gta_beret01",
        "gta_cap02l",
        "gta_cap02h",
        "gta_cap02c",
        "gta_cap01a",
        "gta_cap01a",
        "bandit1",
        "bandit3",
        "bandit2",
        "headbandage2",
        "manmask4",
        "butcher2",
        "butcher2",
        "butcher2",
        "gta_owlmask01",
        "manmask1",
        "gta_hat01",
        "hocmask15",
        "hocmask12",
        "gta_beanie02a",
        "pilotgoggles",
    }, type = INV_HATS},  

    ["РедкиеАксессуарыОчки"] = { loot = {
        "gta_glasses02",
        "gta_glasses02",
        "gta_glasses01d",
        "gta_glasses01e",
        "pilotgoggles",
        "gta_glasses01f",
    }, type = INV_HATS},
}