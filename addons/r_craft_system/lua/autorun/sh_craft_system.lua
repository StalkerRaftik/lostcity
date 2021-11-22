R_CraftSystem = R_CraftSystem or {}

R_CraftSystem.UsageCooldown = 3

R_CraftSystem.HeaderColor = Color(100, 100, 100)


/*---------------------------------------------------------------------------
Категории
---------------------------------------------------------------------------*/

R_CraftSystem.Categories = {}

R_CraftSystem.Categories[1] = {
	color = Color(30, 30, 30),
	name = "Все",
}

R_CraftSystem.Categories[10] = {
	color = Color(128, 0, 128),
	name = "Боеприпасы",
	category = "entity",
}

R_CraftSystem.Categories[2] = {
	color = Color(92, 138, 191),
	name = "Самодельное",
	category = "weapon",
}

R_CraftSystem.Categories[3] = {
	color = Color(160, 0, 0),
	name = "Медикаменты", 
	category = "entity",
}


R_CraftSystem.Categories[4] = {
	color = Color(105, 105, 105),
	name = "Ловушки",
	category = "entity",
}

R_CraftSystem.Categories[5] = {
	color = Color(43, 43, 43),
	name = "Разное", 
	category = "entity",
}

R_CraftSystem.Categories[8] = {
	color = Color(92, 138, 191),
	name = "Починка",
	category = "weapon",
}

R_CraftSystem.Categories[9] = {
	color = Color(0, 204, 20),
	name = "Фракции", 
	category = "entity",
}


-- for i=4,25 do
-- 	R_CraftSystem.Categories[i] = {
-- 		color = Color(50,50,50),
-- 		name = "Починка"..i, 
-- 	}
-- end

/*---------------------------------------------------------------------------
Рецепты
---------------------------------------------------------------------------*/

R_CraftSystem.Recipes = {}

R_CraftSystem.Recipes["tfa_ins2_akm_bw"] = {
	category = "Починка",
	type = "main",
    pos = Vector(-10,-5,8),
    ang = Angle(0,-90,0),
    needbody = true,
	recipe = {
		["ent_repairkit"] = 1,
		["steel"] = 80,
		["zapchasti"] = 50,
		["wood"] = 40,
		["cloth"] = 30,
		["forend"] = 1,
		["handle"] = 1,
		["trigger"] = 1,
		["wbutt"] = 1,
	},
}

R_CraftSystem.Recipes["tfa_doim3greasegun"] = {
	category = "Починка",
	type = "main",
    pos = Vector(-10,-5,8),
    ang = Angle(0,-90,0),
    needbody = true,
	recipe = {
		["ent_repairkit"] = 1,
		["steel"] = 80,
		["zapchasti"] = 50,
		["wood"] = 40,
		["cloth"] = 30,
		["forend"] = 1,
		["handle"] = 1,
		["trigger"] = 1,
		["wbutt"] = 1,
	},
}

R_CraftSystem.Recipes["tfa_ins2_mr96"] = {
	category = "Починка",
	type = "pistol",
    pos = Vector(-10,-5,8),
    ang = Angle(0,-90,0),
    needbody = true,
	recipe = {
		["ent_repairkit"] = 1,
		["steel"] = 50,
		["zapchasti"] = 30,
		["wood"] = 25,
		["handle"] = 1,
		["trigger"] = 1,
	},
}

R_CraftSystem.Recipes["tfa_nam_sawed_off_shotty"] = {
	category = "Починка",
	type = "main",
    pos = Vector(-10,-5,8),
    ang = Angle(0,-90,0),
    needbody = true,
	recipe = {
		["ent_repairkit"] = 1,
		["steel"] = 70,
		["zapchasti"] = 50,
		["wood"] = 70,
		["wbutt"] = 1,
		["trigger"] = 1,
	},
}

R_CraftSystem.Recipes["tfa_nam_browning_hi_power"] = {
	category = "Починка",
	type = "pistol",
    pos = Vector(-10,-5,8),
    ang = Angle(0,-90,0),
    needbody = true,
	recipe = {
		["ent_repairkit"] = 1,
		["steel"] = 45,
		["zapchasti"] = 40,
		["wood"] = 20,
		["handle"] = 1,
		["trigger"] = 1,
	},
}

R_CraftSystem.Recipes["tfa_doublebarrel"] = {
	category = "Починка",
	type = "main",
    pos = Vector(-10,-5,8),
    ang = Angle(0,-90,0),
    needbody = true,
	recipe = {
		["ent_repairkit"] = 1,
		["steel"] = 70,
		["zapchasti"] = 50,
		["wood"] = 80,
		["wbutt"] = 1,
		["trigger"] = 1,
	},
}

R_CraftSystem.Recipes["tfa_ins2_p320"] = {
	category = "Починка",
	type = "pistol",
    pos = Vector(-10,-5,8),
    ang = Angle(0,-90,0),
    needbody = true,
	recipe = {
		["ent_repairkit"] = 1,
		["steel"] = 90,
		["zapchasti"] = 40,
		["plastic"] = 75,
		["handle"] = 1,
		["trigger"] = 1,
	},
}

R_CraftSystem.Recipes["tfa_ins2_imi_uzi"] = {
	category = "Починка",
	type = "main",
    pos = Vector(-10,-5,8),
    ang = Angle(0,-90,0),
    needbody = true,
	recipe = {
		["ent_repairkit"] = 1,
		["steel"] = 90,
		["zapchasti"] = 60,
		["plastic"] = 75,
		["handle"] = 1,
		["trigger"] = 1,
	},
}

R_CraftSystem.Recipes["tfa_ins2_sks"] = {
	category = "Починка",
	type = "main",
    pos = Vector(-10,-5,8),
    ang = Angle(0,-90,0),
    needbody = true,
	recipe = {
		["ent_repairkit"] = 1,
		["steel"] = 120,
		["zapchasti"] = 70,
		["wood"] = 90,
		["forend"] = 1,
		["trigger"] = 1,
		["wbutt"] = 1,
	},
}

R_CraftSystem.Recipes["fnfnp45"] = {
	category = "Починка",
	type = "pistol",
    pos = Vector(-10,-5,8),
    ang = Angle(0,-90,0),
    needbody = true,
	recipe = {
		["ent_repairkit"] = 1,
		["steel"] = 70,
		["zapchasti"] = 70,
		["plastic"] = 65,
		["handle"] = 1,
		["trigger"] = 1,
	},
}

R_CraftSystem.Recipes["tfa_ins2_ak105"] = {
	category = "Починка",
	type = "main",
    pos = Vector(-10,-5,8),
    ang = Angle(0,-90,0),
    needbody = true,
	recipe = {
		["ent_repairkit"] = 1,
		["steel"] = 120,
		["zapchasti"] = 80,
		["plastic"] = 50,
		["forend"] = 1,
		["handle"] = 1,
		["trigger"] = 1,
		["wbutt"] = 1,
	},
}

R_CraftSystem.Recipes["tfa_nam_ak47"] = {
	category = "Починка",
	type = "main",
    pos = Vector(-10,-5,8),
    ang = Angle(0,-90,0),
    needbody = true,
	recipe = {
		["ent_repairkit"] = 1,
		["steel"] = 105,
		["zapchasti"] = 80,
		["wood"] = 60,
		["forend"] = 1,
		["handle"] = 1,
		["trigger"] = 1,
		["wbutt"] = 1,
	},
}

R_CraftSystem.Recipes["tfa_ins2_cw_ar15"] = {
	category = "Починка",
	type = "main",
    pos = Vector(-10,-5,8),
    ang = Angle(0,-90,0),
    needbody = true,
	recipe = {
		["ent_repairkit"] = 1,
		["steel"] = 105,
		["zapchasti"] = 80,
		["plastic"] = 120,
		["forend"] = 1,
		["handle"] = 1,
		["trigger"] = 1,
		["wbutt"] = 1,
	},
}

R_CraftSystem.Recipes["tfa_ins2_aug"] = {
	category = "Починка",
	type = "main",
    pos = Vector(-10,-5,8),
    ang = Angle(0,-90,0),
    needbody = true,
	recipe = {
		["ent_repairkit"] = 1,
		["steel"] = 130,
		["zapchasti"] = 90,
		["plastic"] = 105,
		["handle"] = 1,
		["trigger"] = 1,
	},
}

R_CraftSystem.Recipes["tfa_ins2_gol"] = {
	category = "Починка",
	type = "main",
    pos = Vector(-10,-5,8),
    ang = Angle(0,-90,0),
    needbody = true,
	recipe = {
		["ent_repairkit"] = 1,
		["steel"] = 150,
		["zapchasti"] = 100,
		["plastic"] = 80,
		["forend"] = 1,
		["handle"] = 1,
		["trigger"] = 1,
		["wbutt"] = 1,	
	},
}

R_CraftSystem.Recipes["tfa_ins2_m590o"] = {
	category = "Починка",
	type = "main",
    pos = Vector(-10,-5,8),
    ang = Angle(0,-90,0),
    needbody = true,
	recipe = {
		["ent_repairkit"] = 1,
		["steel"] = 130,
		["zapchasti"] = 70,
		["wood"] = 110,
		["handle"] = 1,
		["trigger"] = 1,
		["wbutt"] = 1,	},
}

R_CraftSystem.Recipes["tfa_ins2_m9"] = {
	category = "Починка",
	type = "pistol",
    pos = Vector(-10,-5,8),
    ang = Angle(0,-90,0),
    needbody = true,
	recipe = {
		["ent_repairkit"] = 1,
		["steel"] = 105,
		["zapchasti"] = 60,
		["plastic"] = 40,
		["handle"] = 1,
		["trigger"] = 1,
	},
}

R_CraftSystem.Recipes["tfa_fas2_glock20"] = {
	category = "Починка",
	type = "pistol",
    pos = Vector(-10,-5,8),
    ang = Angle(0,-90,0),
    needbody = true,
	recipe = {
		["ent_repairkit"] = 1,
		["steel"] = 55,
		["zapchasti"] = 80,
		["plastic"] = 100,
		["handle"] = 1,
		["trigger"] = 1,
	},
}

R_CraftSystem.Recipes["tfa_ins2_mk18"] = {
	category = "Починка",
	type = "main",
    pos = Vector(-10,-5,8),
    ang = Angle(0,-90,0),
    needbody = true,
	recipe = {
		["ent_repairkit"] = 1,
		["steel"] = 175,
		["zapchasti"] = 130,
		["plastic"] = 150,
		["forend"] = 1,
		["handle"] = 1,
		["trigger"] = 1,
		["wbutt"] = 1,	
	},
}

R_CraftSystem.Recipes["tfa_ins2_codol_msr"] = {
	category = "Починка",
	type = "main",
    pos = Vector(-10,-5,8),
    ang = Angle(0,-90,0),
    needbody = true,
	recipe = {
		["ent_repairkit"] = 1,
		["steel"] = 210,
		["zapchasti"] = 170,
		["plastic"] = 150,
		["forend"] = 1,
		["handle"] = 1,
		["trigger"] = 1,
		["wbutt"] = 1,	
	},
}

R_CraftSystem.Recipes["tfa_ins2_m1014"] = {
	category = "Починка",
	type = "main",
    pos = Vector(-10,-5,8),
    ang = Angle(0,-90,0),
    needbody = true,
	recipe = {
		["ent_repairkit"] = 1,
		["steel"] = 95,
		["zapchasti"] = 70,
		["wood"] = 110,
		["handle"] = 1,
		["trigger"] = 1,
		["wbutt"] = 1,	
	},
}

R_CraftSystem.Recipes["tfa_ins_rgo_grenade_owo"] = {
	category = "Починка",
    pos = Vector(-10,-5,8),
    ang = Angle(0,-90,0),
	recipe = {
		["ent_repairkit"] = 1,
		["reaktiv"] = 200,
		["plastic"] = 50,
		["steel"] = 150,
		["zapchasti"] = 40,
	},
}

R_CraftSystem.Recipes["tfa_ins2_pm"] = {
	category = "Починка",
	type = "pistol",
    pos = Vector(-10,-5,8),
    ang = Angle(0,-90,0),
    needbody = true,
	recipe = {
		["ent_repairkit"] = 1,
		["steel"] = 60,
		["zapchasti"] = 60,
		["wood"] = 50,
		["plastic"] = 15,
		["handle"] = 1,
		["trigger"] = 1,
	},
}

R_CraftSystem.Recipes["tfa_ins_sandstorm_tariq"] = {
	category = "Починка",
	type = "pistol",
    pos = Vector(-10,-5,8),
    ang = Angle(0,-90,0),
    needbody = true,
	recipe = {
		["ent_repairkit"] = 1,
		["steel"] = 60,
		["zapchasti"] = 50,
		["plastic"] = 45,
		["handle"] = 1,
		["trigger"] = 1,
	},
}

R_CraftSystem.Recipes["weapon_bfh_tec9"] = {
	category = "Оружие [Первый Тир]",
	type = "main",
    pos = Vector(-10,-5,8),
    ang = Angle(0,-90,0),
    needbody = true,
	recipe = {
		["ent_repairkit"] = 1,
		["steel"] = 70,
		["zapchasti"] = 60,
		["plastic"] = 75,
		["handle"] = 1,
		["trigger"] = 1,
	},
}

R_CraftSystem.Recipes["tfa_ins2_gsh18"] = {
	category = "Починка",
	type = "pistol",
    pos = Vector(-10,-5,8),
    ang = Angle(0,-90,0),
    needbody = true,
	recipe = {
		["ent_repairkit"] = 1,
		["steel"] = 85,
		["zapchasti"] = 60,
		["plastic"] = 45,
		["handle"] = 1,
		["trigger"] = 1,
	},
}

R_CraftSystem.Recipes["tfa_ins2_fort500"] = {
	category = "Починка",
	type = "main",
    pos = Vector(-10,-5,8),
    ang = Angle(0,-90,0),
    needbody = true,
	recipe = {
		["ent_repairkit"] = 1,
		["steel"] = 95,
		["zapchasti"] = 70,
		["wood"] = 110,
		["handle"] = 1,
		["trigger"] = 1,
		["wbutt"] = 1,
	},
}

R_CraftSystem.Recipes["tfa_ins2_mp5k_pdw"] = {
	category = "Починка",
	type = "main",
    pos = Vector(-10,-5,8),
    ang = Angle(0,-90,0),
    needbody = true,
	recipe = {
		["ent_repairkit"] = 1,
		["steel"] = 95,
		["zapchasti"] = 70,
		["wood"] = 110,
		["handle"] = 1,
		["trigger"] = 1,
		["wbutt"] = 1,
	},
}


R_CraftSystem.Recipes["tfa_doisten"] = {
	category = "Починка",
	type = "main",
    pos = Vector(-10,-5,8),
    ang = Angle(0,-90,0),
    needbody = true,
	recipe = {
		["ent_repairkit"] = 1,
		["steel"] = 95,
		["zapchasti"] = 80,
		["plastic"] = 55,
		["handle"] = 1,
		["trigger"] = 1,
		["wbutt"] = 1,
		["forend"] = 1,
	},
}

R_CraftSystem.Recipes["tfa_nam_m40"] = {
	category = "Починка",
	type = "main",
    pos = Vector(-10,-5,8),
    ang = Angle(0,-90,0),
    needbody = true,
	recipe = {
		["ent_repairkit"] = 1,
		["steel"] = 90,
		["zapchasti"] = 50,
		["wood"] = 120,
		["handle"] = 1,
		["trigger"] = 1,
		["wbutt"] = 1,
		["forend"] = 1,
	},
}

R_CraftSystem.Recipes["tfa_ins2_mp7"] = {
	category = "Починка",
	type = "main",
    pos = Vector(-10,-5,8),
    ang = Angle(0,-90,0),
    needbody = true,
	recipe = {
		["ent_repairkit"] = 1,
		["steel"] = 185,
		["zapchasti"] = 140,
		["plastic"] = 135,
		["handle"] = 1,
		["trigger"] = 1,
		["wbutt"] = 1,
		["forend"] = 1,
	},
}


R_CraftSystem.Recipes["tfa_ins2_mk14ebr"] = {
	category = "Починка",
	type = "main",
    pos = Vector(-10,-5,8),
    ang = Angle(0,-90,0),
    needbody = true,
	recipe = {
		["ent_repairkit"] = 1,
		["steel"] = 200,
		["zapchasti"] = 90,
		["plastic"] = 170,
		["handle"] = 1,
		["trigger"] = 1,
		["wbutt"] = 1,
		["forend"] = 1,
	},
}

R_CraftSystem.Recipes["tfa_ins2_rpk_74m"] = {
	category = "Починка",
	type = "main",
    pos = Vector(-10,-5,8),
    ang = Angle(0,-90,0),
    needbody = true,
	recipe = {
		["ent_repairkit"] = 1,
		["steel"] = 250,
		["zapchasti"] = 170,
		["plastic"] = 200,
		["handle"] = 1,
		["trigger"] = 1,
		["wbutt"] = 1,
		["forend"] = 1,
	},
}


R_CraftSystem.Recipes["tfa_rustalpha_stone_hatchet"] = {
	category = "Самодельное",
	type = "knife",
    pos = Vector(-10,-5,8),
    ang = Angle(0,-90,0),
	recipe = {
		["ducttape"] = 1,
		["steel"] = 10,
		["zapchasti"] = 10,
		["wood"] = 30,
	},
}

R_CraftSystem.Recipes["tfa_rustalpha_pickaxe"] = {
	category = "Самодельное",
	type = "knife",
    pos = Vector(-10,-5,8),
    ang = Angle(0,-90,0),
	recipe = {
		["hlam2"] = 1,
		["ducttape"] = 2,
		["steel"] = 30,
		["zapchasti"] = 20,
		["wood"] = 40,
	},
}

R_CraftSystem.Recipes["tfa_rustalpha_revolver"] = {
	category = "Самодельное",
	type = "pistol",
    pos = Vector(-10,-5,8),
    ang = Angle(0,-90,0),
	recipe = {
		["wrench"] = 1,
		["steel"] = 90,
		["cloth"] = 90,
		["wood"] = 90,
	},
}

R_CraftSystem.Recipes["tfa_rustalpha_pipeshotgun"] = {
	category = "Самодельное",
	type = "main",
    pos = Vector(-10,-5,8),
    ang = Angle(0,-90,0),
	recipe = {
		["wrench"] = 1,
		["steel"] = 90,
		["zapchasti"] = 30,
		["cloth"] = 90,
		["wood"] = 80,
		["tfa_nmrih_lpipe"] = 1,
	},
}

R_CraftSystem.Recipes["tfa_rustalpha_handcannon"] = {
	category = "Самодельное",
	type = "pistol",
    pos = Vector(-10,-5,8),
    ang = Angle(0,-90,0),
	recipe = {
		["wrench"] = 1,
		["steel"] = 30,
		["cloth"] = 10,
		["wood"] = 30,
		["update01_hlam6"] = 1,
	},
}

R_CraftSystem.Recipes["tfa_rustalpha_bolt_action_rifle"] = {
	category = "Самодельное",
	type = "main",
    pos = Vector(-10,-5,8),
    ang = Angle(0,-90,0),
	recipe = {
		["wrench"] = 1,
		["steel"] = 170,
		["cloth"] = 80,
		["zapchasti"] = 80,
		["wood"] = 170,
	},
}

R_CraftSystem.Recipes["tfbow_shortbow"] = {
	category = "Самодельное",
	type = "main",
    pos = Vector(-10,-5,8),
    ang = Angle(0,-90,0),
	recipe = {
		["cloth"] = 50,
		["wood"] = 80,
		["tfa_nmrih_kknife"] = 1,
	},
}

R_CraftSystem.Recipes["tfbow_sf2"] = {
	category = "Самодельное",
	type = "main",
    pos = Vector(-10,-5,8),
    ang = Angle(0,-90,0),
	recipe = {
		["steel"] = 80,
		["plastic"] = 80,
		["zapchasti"] = 15,
		["cloth"] = 30,
	},
}

R_CraftSystem.Recipes["tfa_tfre_hammerless"] = {
	category = "Самодельное",
	type = "pistol",
    pos = Vector(-10,-5,8),
    ang = Angle(0,-90,0),
	recipe = {
		["wrench"] = 1,
		["steel"] = 60,
		["wood"] = 30,
		["zapchasti"] = 20,
		["update01_hlam6"] = 1,
	},
}

-- АААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА
R_CraftSystem.Recipes["tfa_ammo_buckshot"] = {
	name = "Патроны .12 [Количество x10]",
	model = "models/Items/BoxBuckshot.mdl",
	category = "Боеприпасы",
	count = 10,
	recipe = {
		["tfa_ammo_buckshot_raw"] = 10,
		["gpblue"] = 2,
		["reaktiv"] = 5,
	},
}

R_CraftSystem.Recipes["tfa_ammo_sniper_rounds"] = {
	name = "Патроны .308 Win [Количество x10]",
	model = "models/Items/sniper_round_box.mdl",
	category = "Боеприпасы",
	count = 10,
	recipe = {
		["tfa_ammo_sniper_rounds_raw"] = 10,
		["gpgreen"] = 2,
		["reaktiv"] = 9,
	},
}

R_CraftSystem.Recipes["tfa_ammo_357"] = {
	name = "Патроны .357 [Количество x10]",
	model = "models/Items/357ammo.mdl",
	category = "Боеприпасы",
	count = 10,
	recipe = {
		["tfa_ammo_357_raw"] = 10,
		["gpgreen"] = 2,
		["reaktiv"] = 9,
	},
}

R_CraftSystem.Recipes["tfa_ammo_pistol"] = {
	name = "Патроны .45 ACP [Количество x10]",
	model = "models/Items/BoxSRounds.mdl",
	category = "Боеприпасы",
	count = 10,
	recipe = {
		["tfa_ammo_pistol_raw"] = 10,
		["gpred"] = 2,
		["reaktiv"] = 4,
	},
}

R_CraftSystem.Recipes["tfa_ammo_winchester"] = {
	name = "Патроны 5.45x39 мм [Количество x10]",
	model = "models/Items/BoxSRounds.mdl",
	category = "Боеприпасы",
	count = 10,
	recipe = {
		["tfa_ammo_winchester_raw"] = 10,
		["gpblue"] = 2,
		["reaktiv"] = 6,
	},
}

R_CraftSystem.Recipes["tfa_ammo_ar2"] = {
	name = "Патроны 5.56x45 мм [Количество x10]",
	model = "models/Items/BoxMRounds.mdl",
	category = "Боеприпасы",
	count = 10,
	recipe = {
		["tfa_ammo_ar2_raw"] = 10,
		["gpgreen"] = 2,
		["reaktiv"] = 9,
	},
}

R_CraftSystem.Recipes["tfa_ammo_ar1"] = {
	name = "Патроны 7.62x54 мм [Количество x10]",
	model = "models/Items/BoxMRounds.mdl",
	category = "Боеприпасы",
	count = 10,
	recipe = {
		["tfa_ammo_ar1_raw"] = 10,
		["gpgreen"] = 2,
		["reaktiv"] = 10,
	},
}

R_CraftSystem.Recipes["tfa_ammo_smg"] = {
	name = "Патроны 9x19 мм [Количество x10]",
	model = "models/Items/BoxSRounds.mdl",
	category = "Боеприпасы",
	count = 10,
	recipe = {
		["tfa_ammo_smg_raw"] = 10,
		["gpred"] = 1,
		["reaktiv"] = 5,

	},
}

R_CraftSystem.Recipes["arrow"] = {
	name = "Стрелы [Количество x10]",
	model = "models/weapons/w_tfa_arrow.mdl",
	category = "Боеприпасы",
	count = 10,
	recipe = {
		["steel"] = 15,
		["wood"] = 30,
		["zapchasti"] = 1,
	},
}

R_CraftSystem.Recipes["tfa_ammo_buckshot_raw"] = {
	name = "Гильза Патрона .12 [Количество x10]",
	model = "models/tfa/rifleshell.mdl",
	category = "Боеприпасы",
	count = 10,
	recipe = {
		["steel"] = 46,
		["zapchasti"] = 21,
		["plastic"] = 62,
		["coil"] = 27,

	},
}

R_CraftSystem.Recipes["tfa_ammo_sniper_rounds_raw"] = {
	name = "Гильза Патрона .308 Win [Количество x10]",
	model = "models/tfa/rifleshell.mdl",
	category = "Боеприпасы",
	count = 10,
	recipe = {
		["steel"] = 29,
		["zapchasti"] = 67,
		["coil"] = 47,

	},
}

R_CraftSystem.Recipes["tfa_ammo_357_raw"] = {
	name = "Гильза Патрона .357 [Количество x10]",
	model = "models/tfa/rifleshell.mdl",
	category = "Боеприпасы",
	count = 10,
	recipe = {
		["steel"] = 21,
		["zapchasti"] = 49,
		["coil"] = 51,

	},
}

R_CraftSystem.Recipes["tfa_ammo_pistol_raw"] = {
	name = "Гильза Патрона .45 ACP [Количество x10]",
	model = "models/tfa/rifleshell.mdl",
	category = "Боеприпасы",
	count = 10,
	recipe = {
		["steel"] = 11,
		["zapchasti"] = 21,
		["coil"] = 18,

	},
}

R_CraftSystem.Recipes["tfa_ammo_winchester_raw"] = {
	name = "Гильза Патрона 5.45x39 мм [Количество x10]",
	model = "models/tfa/rifleshell.mdl",
	category = "Боеприпасы",
	count = 10,
	recipe = {
		["steel"] = 21,
		["zapchasti"] = 39,
		["coil"] = 34,

	},
}

R_CraftSystem.Recipes["tfa_ammo_ar2_raw"] = {
	name = "Гильза Патрона 5.56x45 мм [Количество x10]",
	model = "models/tfa/rifleshell.mdl",
	category = "Боеприпасы",
	count = 10,
	recipe = {
		["steel"] = 24,
		["zapchasti"] = 39,
		["coil"] = 31,

	},
}

R_CraftSystem.Recipes["tfa_ammo_ar1_raw"] = {
	name = "Гильза Патрона 7.62x54 мм [Количество x10]",
	model = "models/tfa/rifleshell.mdl",
	category = "Боеприпасы",
	count = 10,
	recipe = {
		["steel"] = 38,
		["zapchasti"] = 62,
		["coil"] = 45,

	},
}

R_CraftSystem.Recipes["tfa_ammo_smg_raw"] = {
	name = "Гильза Патрона 9x19 мм [Количество x10]",
	model = "models/tfa/rifleshell.mdl",
	category = "Боеприпасы",
	count = 10,
	recipe = {
		["steel"] = 8,
		["zapchasti"] = 22,
		["coil"] = 21,

	},
}

-- АААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА


R_CraftSystem.Recipes["gpblue"] = {
	name = "Порох",
	model = "models/illusion/eftcontainers/gpblue.mdl",
	sell = 1300,
	category = "Боеприпасы",
	recipe = {
		["sulfur"] = 8,
		["coil"] = 10,
		["reaktiv"] = 6,

	},
}

R_CraftSystem.Recipes["gpgreen"] = {
	name = "Качественный порох",
	model = "models/illusion/eftcontainers/gpgreen.mdl",
	sell = 1000,
	category = "Боеприпасы",
	recipe = {
		["sulfur"] = 25,
		["coil"] = 34,
		["reaktiv"] = 12,
		["dryfuel"] = 4,
	},
}

R_CraftSystem.Recipes["gpred"] = {
	name = "Пистолетный порох",
	model = "models/illusion/eftcontainers/gpred.mdl",
	category = "Боеприпасы",
	recipe = {
		["sulfur"] = 16,
		["coil"] = 21,
		["reaktiv"] = 9,
	},
}

R_CraftSystem.Recipes["bloodexample_empty"] = {
	name = "Пустая склянка",
	model = "models/illusion/eftcontainers/bloodsample.mdl",
	category = "Разное",
	recipe = {
		["plastic"] = 3,
	},
}

R_CraftSystem.Recipes["ent_notepad"] = {
	name = "Блокнот",
	dropontable = true,
	model = "models/props_lab/clipboard.mdl",
	category = "Разное",
	recipe = {
		["ent_notepad_page"] = 1,
		["cloth"] = 10,
		["wood"] = 5,
	},
}

R_CraftSystem.Recipes["ent_notepad_page"] = {
	name = "Бумага",
	model = "models/props_junk/garbage_newspaper001a.mdl",
	category = "Разное",
	recipe = {
		["cloth"] = 20,
	},
}

R_CraftSystem.Recipes["st_fishingrod"] = {
	name = "Удочка",
	model = "models/oldprops/fishing_rod.mdl",
	category = "Разное",
	recipe = {
		["plastic"] = 10,
		["cloth"] = 20,
		["wood"] = 30,
	},
}

R_CraftSystem.Recipes["toolset"] = {
	name = "Набор для строительства",
	model = "models/illusion/eftcontainers/toolset.mdl",
	category = "Разное",
	recipe = {
		["hlam2"] = 1,
		["wrench"] = 1,
		["update01_hlam6"] = 1,
		["insulatingtape"] = 1,
		["electricdrill"] = 1,
		["ent_battery"] = 2,
	},
}

R_CraftSystem.Recipes["ent_battery"] = {
	name = "Батарейка(x2)",
	model = "models/illusion/eftcontainers/aabattery.mdl",
	category = "Разное",
	count = 2,
	recipe = {
		["steel"] = 20,
		["zapchasti"] = 20,
		["reaktiv"] = 15,
		["insulatingtape"] = 1,
	},
}

R_CraftSystem.Recipes["flashlight"] = {
	name = "Фонарик",
	model = "models/raviool/flashlight.mdl",
	category = "Разное",
	count = 2,
	recipe = {
		["hlam13"] = 1,
		["insulatingtape"] = 1,
		["zapchasti"] = 20,
		["reaktiv"] = 10,
		["steel"] = 25,
		["wires"] = 1,
	},
}

R_CraftSystem.Recipes["aquafilter"] = {
	name = "Самодельный фильтр для воды[x5]",
	model = "models/illusion/eftcontainers/aquamari.mdl",
	count = 5,
	category = "Разное",
	recipe = {
		["reaktiv"] = 2,
		["cloth"] = 5,
		["zapchasti"] = 1,
		["coil"] = 1,
	},
}

R_CraftSystem.Recipes["matches"] = {
	name = "Спички(x5)",
	model = "models/illusion/eftcontainers/matches.mdl",
	category = "Разное",
	count = 5,
	recipe = {
		["sulfur"] = 1,
		["wood"] = 5,
	},
}

R_CraftSystem.Recipes["lockpick"] = {
	name = "Отмычка",
	model = "models/weapons/w_crowbar.mdl",
	category = "Разное",
	recipe = {
		["zapchasti"] = 5,
		["steel"] = 20,
	},
}

R_CraftSystem.Recipes["rp_firekit"] = {
	name = "Набор для костра",
	model = "models/Items/CrossbowRounds.mdl",
	category = "Разное",
	recipe = {
		["stone"] = 5,
		["wood"] = 10,
		["cloth"] = 2,
	},
}

R_CraftSystem.Recipes["ent_notepad"] = {
	name = "Блокнот",
	model = "models/props_lab/clipboard.mdl",
	category = "Разное",
	recipe = {
		["wood"] = 2,
		["cloth"] = 10,
	},
}

R_CraftSystem.Recipes["tripwiregrenade"] = {
	name = "Ловушка с гранатой",
	model = "models/props_c17/trappropeller_lever.mdl",
	category = "Ловушки",
	recipe = {
		["tfa_ins_rgo_grenade_owo"] = 1,
		["cloth"] = 10,
		["steel"] = 10,
	},
}

R_CraftSystem.Recipes["tripwireextender"] = {
	name = "Переходник для мин",
	model = "models/props_wasteland/prison_throwswitchbase001.mdl",
	category = "Ловушки",
	recipe = {
		["zapchasti"] = 10,
		["steel"] = 30,
	},
}


R_CraftSystem.Recipes["usedbandage"] = {
	name = "Нестерильный бинт",
	model = "models/illusion/eftcontainers/bandage.mdl",
	category = "Медикаменты",
	recipe = {
		["cloth"] = 10,
	},
}


R_CraftSystem.Recipes["ent_bandage"] = {
	name = "Бинт",
	model = "models/bandage/bandage.mdl",
	category = "Медикаменты",
	ent = "ent_bandage",
	recipe = {
		["medpile"] = 3,
	},
}

R_CraftSystem.Recipes["ent_bandage_alt1"] = {
	name = "Бинт",
	ent = "ent_bandage",
	model = "models/bandage/bandage.mdl",
	category = "Медикаменты",
	recipe = {
		["usedbandage"] = 1,
		["reaktiv"] = 1,
	},
}

R_CraftSystem.Recipes["ent_bandage_alt"] = {
	name = "Бинт(x8)",
	model = "models/bandage/bandage.mdl",
	ent = "ent_bandage",
	category = "Медикаменты",
	count = 8,
	recipe = {
		["usedbandage"] = 5,
		["med_nastoyka"] = 1,
	},
}


R_CraftSystem.Recipes["med_boostinject"] = {
	name = "Глицин-биотик(адреналин)",
	model = "models/bloocobalt/l4d/items/w_eq_adrenaline.mdl",
	category = "Медикаменты",
	recipe = {
		["airfilter"] = 1,
		["wires"] = 1,
		["helix"] = 1,
		["bloodexample"] = 1,
	},
}

R_CraftSystem.Recipes["ent_smallmedkit"] = {
	name = "Феназалгин",
	model = "models/bloocobalt/l4d/items/w_eq_pills.mdl",
	category = "Медикаменты",
	recipe = {
		["plastic"] = 10,
		["medsyringe"] = 1,
		["reaktiv"] = 3,
	},
}

R_CraftSystem.Recipes["ent_shina"] = {
	name = "Шина",
	model = "models/snowzgmod/payday2/armour/armourrthigh.mdl",
	category = "Медикаменты",
	recipe = {
		["ent_bandage"] = 1,
		["medtape"] = 1,
		["steel"] = 1,
		["wood"] = 5,
	},
}

R_CraftSystem.Recipes["ent_medkit"] = {
	name = "Аптечка первой помощи",
	model = "models/firstaid/item_firstaid.mdl",
	category = "Медикаменты",
	recipe = {
		["ent_smallmedkit"] = 1,
		["medpile"] = 5,
		["bloodexample"] = 4,
		["medtape"] = 1,
	},
}

R_CraftSystem.Recipes["ent_medkit_alt"] = {
	name = "Аптечка первой помощи(x5)",
	model = "models/firstaid/item_firstaid.mdl",
	ent = "ent_medkit",
	count = 5,
	category = "Медикаменты",
	recipe = {
		["diagset"] = 1,
		["bloodexample"] = 20,
		["medtape"] = 2,
	},
}

R_CraftSystem.Recipes["med_flupill"] = {
	name = "Препарат 'Тамифлю'",
	model = "models/fless/pill03fix.mdl",
	category = "Медикаменты",
	recipe = {
		["medpile"] = 10,
		["bloodexample"] = 3,
		["reaktiv"] = 10,
		["resources"] = 1,
	},
}

R_CraftSystem.Recipes["efferalgan"] = {
	name = "Препарат 'Эффералган'",
	model = "models/codeandmodeling_efferalgan_lucian/codeandmodeling_efferalgan_lucian.mdl",
	category = "Медикаменты",
	recipe = {
		["medpile"] = 10,
		["bloodexample"] = 15,
		["reaktiv"] = 15,
		["resources"] = 1,
	},
}

R_CraftSystem.Recipes["amox"] = {
	name = "Препарат 'Амоксициллин'(2 капсулы)",
	model = "models/fless/pill02.mdl",
	category = "Медикаменты",
	count = 2,
	recipe = {
		["diagset"] = 1,
		["medtape"] = 1,
		["medpile"] = 30,
		["bloodexample"] = 15,
		["reaktiv"] = 50,
		["resources"] = 10,
	},
}

R_CraftSystem.Recipes["med_coal"] = {
	name = "Препарат 'Активированный уголь'(7 таблеток)",
	model = "models/zworld_health/somnifere.mdl",
	category = "Медикаменты",
	count = 7,
	recipe = {
		["medpile"] = 5,
		["reaktiv"] = 10,
		["coil"] = 2,
	},
}


R_CraftSystem.Recipes["medpile"] = {
	name = "Использованные медикаменты",
	model = "models/illusion/eftcontainers/medpile.mdl",
	category = "Медикаменты",
	recipe = {
		["usedbandage"] = 3,
		["bloodexample"] = 3,
	},
}

R_CraftSystem.Recipes["building_resources"] = {
	name = "Разобрать ресурсы на строительные ресурсы(x2)",
	model = "models/props_junk/metal_paintcan001a.mdl",
	count = 2,
	category = "Фракции",
	recipe = {
		["resources"] = 1,
	},
}

R_CraftSystem.Recipes["building_resources_x20"] = {
	name = "Разобрать ресурсы на строительные ресурсы(x20)",
	ent = "building_resources",
	model = "models/props_junk/metal_paintcan001a.mdl",
	count = 20,
	category = "Фракции",
	recipe = {
		["resources"] = 10,
	},
}

R_CraftSystem.Recipes["resources"] = {
	name = "Собрать ресурсы",
	model = "models/props/cs_office/Cardboard_box03.mdl",
	count = 1,
	category = "Фракции",
	recipe = {
		["plastic"] = 10,
		["steel"] = 10,
		["wood"] = 10,
		["cloth"] = 10,
	},
}

R_CraftSystem.Recipes["resources_x3"] = {
	name = "Собрать ресурсы(x3)",
	ent = "resources",
	model = "models/props/cs_office/Cardboard_box03.mdl",
	count = 3,
	category = "Фракции",
	recipe = {
		["reaktiv"] = 5,
		["plastic"] = 10,
		["steel"] = 10,
		["wood"] = 10,
		["cloth"] = 10,
		["zapchasti"] = 5,
	},
}

-- R_CraftSystem.Recipes["benznatriya"] = {
-- 	name = "Бензоат Натрия",
-- 	model = "models/winningrook/gtav/meth/sacid/sacid.mdl",
-- 	category = "Разное",
-- 	recipe = {
-- 		["reaktiv"] = 1,
-- 		["plastic"] = 4,
-- 	},
-- }

-- R_CraftSystem.Recipes["bismuth"] = {
-- 	name = "Висмут",
-- 	model = "models/winningrook/gtav/meth/hcacid/hcacid.mdl",
-- 	category = "Разное",
-- 	recipe = {
-- 		["reaktiv"] = 1,
-- 		["plastic"] = 4,
-- 	},
-- }

-- R_CraftSystem.Recipes["toluol"] = {
-- 	name = "Толуол",
-- 	model = "models/winningrook/gtav/meth/toulene/toulene.mdl",
-- 	category = "Разное",
-- 	recipe = {
-- 		["reaktiv"] = 1,
-- 		["plastic"] = 4,
-- 	},
-- }


/*---------------------------------------------------------------------------
Детали
---------------------------------------------------------------------------*/

R_CraftSystem.Details = {} -- Это детали - пустышки, просто энтити, которые используются исключительно для крафта(так же можно использовать любые нормальные энтити)

R_CraftSystem.Details["wood"] = {
	name = "Дерево",
	model = "models/fallout/components/wood.mdl",
}

R_CraftSystem.Details["steel"] = {
	name = "Сталь",
	model = "models/fallout/components/ingot.mdl",
}

R_CraftSystem.Details["cloth"] = {
	name = "Текстиль",
	model = "models/fallout/components/spool_2.mdl",
}

R_CraftSystem.Details["reaktiv"] = {
	name = "Хим. реактивы",
	model = "models/fallout/components/nuclear_material.mdl",
}

R_CraftSystem.Details["plastic"] = {
	name = "Пластмасса",
	model = "models/fallout/components/box.mdl",
}

R_CraftSystem.Details["zapchasti"] = {
	name = "Запчасти",
	model = "models/fallout/components/circuitry.mdl",
}

R_CraftSystem.Details["flashlight"] = {
	name = "Фонарик",
	model = "models/raviool/flashlight.mdl",
}

R_CraftSystem.Details["hlam12"] = {
	name = "Сломанная гитара",
	model = "models/hgn/srp/items/guitar.mdl",
}

R_CraftSystem.Details["hlam19"] = {
	name = "Сломанное радио",
	model = "models/stalker/item/handhelds/radio.mdl",
}

R_CraftSystem.Details["stone"] = {
	name = "Известняковый камень",
	model = "models/weapons/yurie_rustalpha/wm-rock.mdl",
}

R_CraftSystem.Details["coil"] = {
	name = "Уголь",
	model = "models/weapons/yurie_rustalpha/wm-rock.mdl",
}

R_CraftSystem.Details["sulfur"] = {
	name = "Сера",
	model = "models/weapons/yurie_rustalpha/wm-rock.mdl",
}

R_CraftSystem.Details["ins2_br_supp"] = {
	name = "Глушитель",
	model = "models/illusion/eftcontainers/ammocase.mdl",
}
R_CraftSystem.Details["ar15_si_folded"] = {
	name = "Открытый прицел для AR-15",
	model = "models/illusion/eftcontainers/ammocase.mdl",
}
R_CraftSystem.Details["ins2_si_eotech"] = {
	name = "Голографический прицел",
	model = "models/illusion/eftcontainers/ammocase.mdl",
}
R_CraftSystem.Details["ins2_si_rds"] = {
	name = "Коллиматорный прицел",
	model = "models/illusion/eftcontainers/ammocase.mdl",
}
R_CraftSystem.Details["ins2_si_2xrds"] = {
	name = "Прицел Aimpoint X2",
	model = "models/illusion/eftcontainers/ammocase.mdl",
}
R_CraftSystem.Details["ar15_magpul_barrel"] = {
	name = "Цевье Magpul для AR-15",
	model = "models/illusion/eftcontainers/ammocase.mdl",
}
R_CraftSystem.Details["ar15_m16_barrel"] = {
	name = "Цевье M16 для AR-15",
	model = "models/illusion/eftcontainers/ammocase.mdl",
}
R_CraftSystem.Details["ar15_ris_barrel"] = {
	name = "Цевье RIS для AR-15",
	model = "models/illusion/eftcontainers/ammocase.mdl",
}
R_CraftSystem.Details["ar15_ext_ris_barrel"] = {
	name = "Цевье RIS удлененный для AR-15",
	model = "models/illusion/eftcontainers/ammocase.mdl",
}
R_CraftSystem.Details["ins2_fg_grip"] = {
	name = "Оружейная рукоять",
	model = "models/illusion/eftcontainers/ammocase.mdl",
}
R_CraftSystem.Details["ar15_magpul_stock"] = {
	name = "Приклад Magpul для AR-15",
	model = "models/illusion/eftcontainers/ammocase.mdl",
}
R_CraftSystem.Details["ar15_m16_stock"] = {
	name = "Приклад M16 для AR-15",
	model = "models/illusion/eftcontainers/ammocase.mdl",
}
R_CraftSystem.Details["ins2_si_po4x"] = {
	name = "Прицел PO X4",
	model = "models/illusion/eftcontainers/ammocase.mdl",
}
R_CraftSystem.Details["xps2"] = {
	name = "Голографический прицел с пистолетным креплением",
	model = "models/illusion/eftcontainers/ammocase.mdl",
}
R_CraftSystem.Details["rmr"] = {
	name = "Триикон прицел для пистолета",
	model = "models/illusion/eftcontainers/ammocase.mdl",
}
R_CraftSystem.Details["ins2_si_mosin"] = {
	name = "Прицел для снайперской винтовки X7",
	model = "models/illusion/eftcontainers/ammocase.mdl",
}
R_CraftSystem.Details["ins2_br_heavy"] = {
	name = "Тяжелый оружейный ствол",
	model = "models/illusion/eftcontainers/ammocase.mdl",
}
R_CraftSystem.Details["ins2_mag_speedloader"] = {
	name = "Лоэдер для револьвера",
	model = "models/illusion/eftcontainers/ammocase.mdl",
}

R_CraftSystem.Details["forend"] = {
	name = "Цевье",
	model = "models/illusion/eftcontainers/ammocase.mdl",
}
R_CraftSystem.Details["wbutt"] = {
	name = "Приклад",
	model = "models/illusion/eftcontainers/ammocase.mdl",
}
R_CraftSystem.Details["handle"] = {
	name = "Рукоять",
	model = "models/illusion/eftcontainers/ammocase.mdl",
}
R_CraftSystem.Details["trigger"] = {
	name = "Курок",
	model = "models/illusion/eftcontainers/ammocase.mdl",
}
R_CraftSystem.Details["medtape"] = {
	name = "Медицинская изолента",
	model = "models/aphelion/props_junk/gauze_tape.mdl",
}


R_CraftSystem.Details["resources"] = {
	name = "Ресурсы",
	model = "models/props/cs_office/Cardboard_box03.mdl",
}

R_CraftSystem.Details["building_resources"] = {
	name = "Строительные ресурсы",
	model = "models/props_junk/metal_paintcan001a.mdl",
}

R_CraftSystem.Details["testo"] = {
  name = "Тесто",
  model = "models/props_junk/garbage_bag001a.mdl",
}

R_CraftSystem.Details["oat"] = {
	name = "Овёс",
	model = "models/props/cs_italy/it_mkt_container1a.mdl",
  }

R_CraftSystem.Details["myaso"] = {
  name = "Сырое мясо",
  model = "models/foodnhouseholditems/steak1.mdl",
}

R_CraftSystem.Details["chickenraw"] = {
  name = "Сырая курица",
  model = "models/foodnhouseholditems/turkey.mdl",
}

R_CraftSystem.Details["gorchica"] = {
  name = "Горчица",
  model = "models/deadrising/mustard.mdl",
}

R_CraftSystem.Details["ketchup"] = {
  name = "Кетчуп",
  model = "models/foodnhouseholditems/ketchup.mdl",
}

R_CraftSystem.Details["sugar"] = {
  name = "Сахар",
  model = "models/bioshockinfinite/caramel_box_open.mdl",
}

R_CraftSystem.Details["maslo"] = {
  name = "Растительное масло",
  model = "models/foodnhouseholditems/lemoncleaner.mdl",
}

R_CraftSystem.Details["egg"] = {
  name = "Сырое яйцо",
  model = "models/foodnhouseholditems/egg1.mdl",
}


/*---------------------------------------------------------------------------
Энтити на разбор
---------------------------------------------------------------------------*/

R_CraftSystem.Disassembly = {}

R_CraftSystem.Disassembly["handle"] = {
	name = "Рукоять",
	model = "models/illusion/eftcontainers/ammocase.mdl",
	sell = 500,
	player_get = {
		["steel"] = 1,
	}
}

R_CraftSystem.Disassembly["wbutt"] = {
	name = "Приклад",
	model = "models/illusion/eftcontainers/ammocase.mdl",
	sell = 500,
	player_get = {
		["wood"] = 1,
	}
}

R_CraftSystem.Disassembly["trigger"] = {
	name = "Курок",
	model = "models/illusion/eftcontainers/ammocase.mdl",
	sell = 500,
	player_get = {
		["steel"] = 1,
	}
}

R_CraftSystem.Disassembly["forend"] = {
	name = "Цевье",
	model = "models/illusion/eftcontainers/ammocase.mdl",
	sell = 500,
	player_get = {
		["steel"] = 1,
	}
}

R_CraftSystem.Disassembly["hlam1"] = {
	name = "Электронный хлам",
	model = "models/box_condensers.mdl",
	sell = 25,
	player_get = {
		["zapchasti"] = {2,5},
		["plastic"] = {1,3},
	}
}

R_CraftSystem.Disassembly["hlam2"] = {
	name = "Набор инструментов",
	model = "models/box_toolkit_2.mdl",
	sell = 1500,
	player_get = {
		["steel"] = {-3,1},
		["plastic"] = 2,
		["wood"] = {1,2},
	}
}

R_CraftSystem.Disassembly["hlam3"] = {
	name = "Набор инструментов №2",
	model = "models/box_toolkit_3.mdl",
	sell = 500,
	player_get = {
		["plastic"] = 4,
		["wood"] = {2,3},
		["steel"] = {-3,1},
	}
}

R_CraftSystem.Disassembly["hlam4"] = {
	name = "Коробка с транзисторами",
	model = "models/box_transistors.mdl",
	sell = 1600,
	player_get = {
		["zapchasti"] = {2,5},
		["plastic"] = {1,3},
		["steel"] = {-1,1},
	}
}

R_CraftSystem.Disassembly["ent_repairkit"] = {
	name = "Большая коробка с инструментами",
	model = "models/instrument.mdl",
	sell = 4500,
	player_get = {
		["zapchasti"] = {3,7},
		["steel"] = {-9,1},
		["plastic"] = {2,4},
		["wood"] = {1,2},
	}	
}

R_CraftSystem.Disassembly["hlam8"] = {
	name = "Набор микрочипов",
	model = "models/materials_textolite.mdl",
	sell = 130,
	player_get = {
		["plastic"] = {1,3},
		["zapchasti"] = {2,4},
	}
}

R_CraftSystem.Disassembly["hlam9"] = {
	name = "Медная леска",
	model = "models/materials_wire.mdl",
	sell = 60,
	player_get = {
		["steel"] = {-8,1},
		["zapchasti"] = {-3,1},
	}
}

R_CraftSystem.Disassembly["hlam10"] = {
	name = "Нерабочий ноутбук",
	model = "models/noteb.mdl",
	sell = 150,
	player_get = {
		["steel"] = {1,3},
		["plastic"] = {3,7},
		["zapchasti"] = {2,5},
	}
}

R_CraftSystem.Disassembly["hlam11"] = {
	name = "Набор для чистки ствола",
	model = "models/toolkit_p.mdl",
	sell = 1200,
	player_get = {
		["steel"] = 2,
		["plastic"] = {1,3},
		["wood"] = {1,4},
		["reaktiv"] = {0,1},
		["zapchasti"] = 2,
	}
}

R_CraftSystem.Disassembly["hlam12"] = {
	name = "Сломанная гитара",
	model = "models/hgn/srp/items/guitar.mdl",
	sell = 60,
	player_get = {
		["wood"] = {3,9},
	}
}

R_CraftSystem.Disassembly["hlam13"] = {
	name = "Сломанный фонарик",
	model = "models/raviool/flashlight.mdl",
	sell = 20,
	player_get = {
		["zapchasti"] = {1,2},
		["plastic"] = 2,
	}
}

R_CraftSystem.Disassembly["hlam14"] = {
	name = "Разбитый телефон",
	model = "models/samsung_s7/samsung_s7.mdl",
	sell = 70,
	player_get = {
		["plastic"] = {1,3},
		["steel"] = {-1,1},
		["zapchasti"] = {2,5},	
	}
}

R_CraftSystem.Disassembly["hlam15"] = {
	name = "Старые документы",
	model = "models/stalker/item/handhelds/files1.mdl",
	sell = 30,
	player_get = {
		["cloth"] = {3,6},
	}
}

R_CraftSystem.Disassembly["hlam16"] = {
	name = "Старые документы",
	model = "models/stalker/item/handhelds/files2.mdl",
	sell = 400,
	player_get = {
		["cloth"] = {2,4},
	}
}

R_CraftSystem.Disassembly["hlam17"] = {
	name = "Старые документы",
	model = "models/stalker/item/handhelds/files3.mdl",
	sell = 500,
	player_get = {
		["cloth"] = {4,7},
	}
}

R_CraftSystem.Disassembly["hlam18"] = {
	name = "Старые документы",
	model = "models/stalker/item/handhelds/files4.mdl",
	sell = 600,
	player_get = {
		["cloth"] = {3,8},
	}
}

R_CraftSystem.Disassembly["hlam19"] = {
	name = "Сломанное радио",
	model = "models/stalker/item/handhelds/radio.mdl",
	sell = 300,
	player_get = {
		["zapchasti"] = {1,4},
		["plastic"] = {1,3},
	}
}

R_CraftSystem.Disassembly["hlam20"] = {
	name = "Коробка с игрой",
	model = "models/unconid/pc_models/big_box_v2.mdl",
	sell = 35,
	player_get = {
		["plastic"] = {1,3},
		["zapchasti"] = 1,
	}
}

R_CraftSystem.Disassembly["hlam21"] = {
	name = "Диск с игрой",
	model = "models/unconid/pc_models/big_box_v2_slim.mdl",
	sell = 35,
	player_get = {
		["plastic"] = {1,3},
	}
}

R_CraftSystem.Disassembly["hlam22"] = {
	name = "Коробка с игрой",
	model = "models/unconid/pc_models/big_box_v3.mdl",
	sell = 35,
	player_get = {
		["plastic"] = {2,4},
		["cloth"] = 1,
	}
}

R_CraftSystem.Disassembly["hlam23"] = {
	name = "Диск с игрой",
	model = "models/unconid/pc_models/cd_jewel_case.mdl",
	sell = 35,
	player_get = {
		["plastic"] = {1,3},
	}
}

R_CraftSystem.Disassembly["hlam24"] = {
	name = "Старая сломанная кукла",
	model = "models/props_c17/doll01.mdl",
	sell = 10,
	player_get = {
		["plastic"] = {1,2},
	}
}

R_CraftSystem.Disassembly["hlam25"] = {
	name = "Сковорода",
	model = "models/props_c17/metalPot002a.mdl",
	sell = 10,
	player_get = {
		["steel"] = 1,
	}
}

R_CraftSystem.Disassembly["hlam26"] = {
	name = "Гаечный ключ(ржавый)",
	model = "models/props_c17/tools_wrench01a.mdl",
	sell = 15,
	player_get = {
		["steel"] = {-8,1},
	}
}

R_CraftSystem.Disassembly["hlam27"] = {
	name = "Глобус",
	model = "models/props_combine/breenglobe.mdl",
	sell = 35,
	player_get = {
		["cloth"] = 1,
		["plastic"] = {1,3},
		["wood"] = {1,3},
	}
}

R_CraftSystem.Disassembly["hlam28"] = {
	name = "Чайник",
	model = "models/props_interiors/pot01a.mdl",
	player_get = {
		["steel"] = 2,
	}
}

R_CraftSystem.Disassembly["hlam29"] = {
	name = "Пустая банка",
	model = "models/props_junk/garbage_metalcan002a.mdl",
	sell = 10,
	player_get = {
		["steel"] = 1,
	}
}

R_CraftSystem.Disassembly["hlam30"] = {
	name = "Старая газета",
	model = "models/props_junk/garbage_newspaper001a.mdl",
	sell = 10,
	player_get = {
		["cloth"] = {1,3},
	}
}

R_CraftSystem.Disassembly["hlam31"] = {
	name = "Банка с краской",
	model = "models/props/cs_militia/paintbucket01.mdl",
	sell = 25,
	player_get = {
		["plastic"] = {1,4},
		["wood"] = {-1,1},
	}
}

R_CraftSystem.Disassembly["hlam32"] = {
	name = "Ведро",
	model = "models/props_junk/MetalBucket01a.mdl",
	sell = 25,
	player_get = {
		["steel"] = {1,2},
	}
}

R_CraftSystem.Disassembly["hlam33"] = {
	name = "Канистра(ржавая)",
	model = "models/props_junk/metalgascan.mdl",
	player_get = {
		["steel"] = {1,3},
		["reaktiv"] = {1,3},
		["plastic"] = {1,4},
		["wood"] = {1,3},
	}
}

R_CraftSystem.Disassembly["hlam34"] = {
	name = "Ботинок",
	model = "models/props_junk/Shoe001a.mdl",
	sell = 15,
	player_get = {
		["cloth"] = 2,
	}
}

R_CraftSystem.Disassembly["hlam35"] = {
	name = "Сломанное настольное радио",
	model = "models/condemned criminal origins/radio.mdl",
	sell = 600,
	player_get = {
		["steel"] = 1,
		["zapchasti"] = {2,5},

	}
}

R_CraftSystem.Disassembly["update01_hlam1"] = {
	name = "Фотоаппарат",
	model = "models/condemned criminal origins/camera_2.mdl",
	sell = 200,
	player_get = {
		["plastic"] = {1,3},
		["zapchasti"] = {2,5},
	}
}

R_CraftSystem.Disassembly["update01_hlam2"] = {
	name = "Видеокамера",
	model = "models/condemned criminal origins/camera.mdl",
	sell = 40,
	player_get = {
		["plastic"] = {1,3},
		["zapchasti"] = 1,
	}
}

R_CraftSystem.Disassembly["update01_hlam3"] = {
	name = "Пустая банка",
	model = "models/condemned criminal origins/soda_can.mdl",
	sell = 10,
	player_get = {
		["steel"] = {1,2},
	}
}

R_CraftSystem.Disassembly["update01_hlam4"] = {
	name = "Средство для мытья окон",
	model = "models/condemned criminal origins/spray_bottle.mdl",
	sell = 30,
	player_get = {
		["plastic"] = {1,3},
		["reaktiv"] = {0,1},
	}
}

R_CraftSystem.Disassembly["update01_hlam5"] = {
	name = "Степлер",
	model = "models/condemned criminal origins/stapler.mdl",
	sell = 25,
	player_get = {
		["plastic"] = {2,5},
		["zapchasti"] = {1,2},

	}
}

R_CraftSystem.Disassembly["update01_hlam6"] = {
	name = "Отвёртка",
	model = "models/props/generic/screwer01.mdl",
	sell = 50,
	player_get = {
		["plastic"] = {1,4},
		["steel"] = {-1,1},
	}
}

R_CraftSystem.Disassembly["update01_hlam7"] = {
	name = "Пустая чашка",
	model = "models/condemned criminal origins/cup_plastic.mdl",
	sell = 10,
	player_get = {
		["cloth"] = {1,4},
	}
}

R_CraftSystem.Disassembly["update01_hlam8"] = {
	name = "Машинное масло",
	model = "models/condemned criminal origins/oil.mdl",
	sell = 100,
	player_get = {
		["plastic"] = {3,8},
		["reaktiv"] = {-3,1},
	}
}

R_CraftSystem.Disassembly["update01_hlam9"] = {
	name = "Туалетная бумага",
	model = "models/foodnhouseholditems/toiletpaper2.mdl",
	sell = 60,
	player_get = {
		["cloth"] = {3,7},
	}
}

R_CraftSystem.Disassembly["update01_hlam10"] = {
	name = "Пакет",
	model = "models/foodnhouseholditems/paperbag3.mdl",
	sell = 10,
	player_get = {
		["cloth"] = {1,2},
	}
}

R_CraftSystem.Disassembly["update01_hlam11"] = {
	name = "Пустая пачка из под яиц",
	model = "models/foodnhouseholditems/egg_box3.mdl",
	sell = 10,
	player_get = {
		["plastic"] = {1,3},
	}
}

R_CraftSystem.Disassembly["hlam36"] = {
	name = "Системный блок",
	model = "models/props_lab/harddrive01.mdl",
	sell = 1550,
	sell = 490,
	player_get = {
		["plastic"] = {3,7},
		["steel"] = 1,
		["zapchasti"] = {4,9},
		["cloth"] = {2,4},
	}
}



R_CraftSystem.Disassembly["newhlam1"] = {
	name = "Жесткий диск(нерабочий)",
	model = "models/props/cs_office/computer_caseb_p6b.mdl",
	sell = 40,
	player_get = {
		["zapchasti"] = {1,3},
		["plastic"] = {1,3},
	}
}

R_CraftSystem.Disassembly["newhlam2"] = {
	name = "Ножницы",
	model = "models/unconid/props_pack/scissors_u.mdl",
	sell = 30,
	player_get = {
		["steel"] = {-1,1},
		["plastic"] = {1,4},
	}
}

R_CraftSystem.Disassembly["newhlam3"] = {
	name = "Зажигалка",
	model = "models/unconid/props_pack/lighter.mdl",
	sell = 25,
	player_get = {
		["plastic"] = 1,
		["zapchasti"] = {0,1},
	}
}

R_CraftSystem.Disassembly["newhlam4"] = {
	name = "Мухобойка",
	model = "models/unconid/props_pack/fly_swatter.mdl",
	sell = 15,
	player_get = {
		["plastic"] = {1,3},
	}
}

R_CraftSystem.Disassembly["newhlam5"] = {
	name = "Деревянный хлам",
	model = "models/props/de_inferno/crate_fruit_break_p9.mdl",
	sell = 40,
	player_get = {
		["wood"] = {1,4},
	}
}

R_CraftSystem.Disassembly["newhlam6"] = {
	name = "Деревянный хлам",
	model = "models/props/de_inferno/flower_barrel_p3.mdl",
	sell = 40,
	player_get = {
		["wood"] = {3,7},
	}
}

R_CraftSystem.Disassembly["toluol"] = {
	name = "Толуол",
	model = "models/winningrook/gtav/meth/hcacid/hcacid.mdl",
	player_get = {
		["reaktiv"] = 1,
	}
}

R_CraftSystem.Disassembly["bismuth"] = {
	name = "Висмут",
	model = "models/winningrook/gtav/meth/hcacid/hcacid.mdl",
	player_get = {
		["reaktiv"] = 1,
	}
}

R_CraftSystem.Disassembly["benznatriya"] = {
	name = "Бензоат натрия",
	model = "models/winningrook/gtav/meth/sacid/sacid.mdl",
	player_get = {
		["reaktiv"] = 1,
	}
}

R_CraftSystem.Disassembly["acetone"] = {
	name = "Ацетон",
	model = "models/winningrook/gtav/meth/acetone/acetone.mdl",
	player_get = {
		["reaktiv"] = 1,
	}
}

R_CraftSystem.Disassembly["pervodoroda"] = {
	name = "Пероксид водорода",
	model = "models/winningrook/gtav/meth/sodium/sodium.mdl",
	player_get = {
		["reaktiv"] = 2,
	}
}

R_CraftSystem.Disassembly["propglicogol"] = {
	name = "Пропиленгликоль",
	model = "models/winningrook/gtav/meth/ammonia/ammonia.mdl",
	player_get = {
		["reaktiv"] = 2,
	}
}

--[[
====================НОВЫЙ ЛУТ==========================================
]]

R_CraftSystem.Disassembly["30mmround"] = {
	name = "30-миллиметровый снаряд",
	model = "models/illusion/eftcontainers/30mmround.mdl",
	sell = 4000,
	player_get = {
		["steel"] = {1,2},
		["plastic"] = {0,1},
	}
}

R_CraftSystem.Disassembly["airfilter"] = {
	name = "Воздушный фильтр",
	model = "models/illusion/eftcontainers/airfilter.mdl",
	sell = 2900,
	player_get = {
		["steel"] = {2,5},
		["plastic"] = {5,8},
		["reaktiv"] = {1,3},
	}
}

R_CraftSystem.Disassembly["washing"] = {
	name = "Средство для стирки",
	model = "models/illusion/eftcontainers/alkali.mdl",
	sell = 40,
	player_get = {
		["plastic"] = {2,6},
		["reaktiv"] = 1,
	}
}

R_CraftSystem.Disassembly["ammocase"] = {
	name = "Кейс для патронов",
	model = "models/illusion/eftcontainers/ammocase.mdl",
	sell = 2600,
	player_get = {
		["steel"] = {3,5},
		["plastic"] = {4,8},
		["zapchasti"] = {2,4},
		["wood"] = {4,9},
	}
}

R_CraftSystem.Disassembly["aquafilter"] = {
	name = "Фильтр для воды",
	model = "models/illusion/eftcontainers/aquamari.mdl",
	sell = 30,
	player_get = {
		["plastic"] = {3,7},
	}
}

R_CraftSystem.Disassembly["armorrepair"] = {
	name = "Набор для ремонта брони",
	model = "models/illusion/eftcontainers/armorrepair.mdl",
	sell = 2900,
	player_get = {
		["steel"] = {2,6},
		["plastic"] = {4,9},
		["zapchasti"] = {4,7},
		["wood"] = {3,8},
	}
}

R_CraftSystem.Disassembly["usedbandage"] = {
	name = "Нестерильный бинт",
	model = "models/illusion/eftcontainers/bandage.mdl",
	sell = 20,
	player_get = {
		["cloth"] = {0,3},
	}
}


R_CraftSystem.Disassembly["bleach"] = {
	name = "Отбеливатель",
	model = "models/illusion/eftcontainers/bleach.mdl",
	sell = 30,
	player_get = {
		["plastic"] = {1,4},
		["reaktiv"] = {0,1},
	}
}

R_CraftSystem.Disassembly["bloodexample"] = {
	name = "Склянка с группой крови 0(I)",
	model = "models/illusion/eftcontainers/bloodsample.mdl",
	sell = 700,
	player_get = {
		["reaktiv"] = {-49,1},
		["plastic"] = {1,3},
	}
}

R_CraftSystem.Disassembly["bloodexample_empty"] = {
	name = "Пустая склянка",
	model = "models/illusion/eftcontainers/bloodsample.mdl",
	sell = 30,
	player_get = {
		["plastic"] = {1,3},
	}
}

R_CraftSystem.Disassembly["bloodexample_blood"] = {
	name = "Склянка с кровью",
	model = "models/illusion/eftcontainers/bloodsample.mdl",
	sell = 35,
	player_get = {
		["plastic"] = {1,3},
	}
}

R_CraftSystem.Disassembly["capacitors"] = {
	name = "Набор конденсаторов",
	model = "models/illusion/eftcontainers/capacitors.mdl",
	sell = 900,
	player_get = {
		["steel"] = {1,2},
		["plastic"] = {2,5},
		["zapchasti"] = {2,5},
	}
}

R_CraftSystem.Disassembly["carbattery"] = {
	name = "Аккумулятор",
	model = "models/illusion/eftcontainers/carbattery.mdl",
	sell = 2500,
	player_get = {
		["zapchasti"] = {1,3},
		["plastic"] = {2,5},
		["steel"] = {1,3},
		["reaktiv"] = {-2,1},
	}
}

R_CraftSystem.Disassembly["catfigure"] = {
	name = "Фигурка кота",
	model = "models/illusion/eftcontainers/catfigurine.mdl",
	sell = 30,
	player_get = {
		["wood"] = {2,5},
	}
}

R_CraftSystem.Disassembly["chain"] = {
	name = "Цепочка",
	model = "models/illusion/eftcontainers/chain.mdl",
	sell = 4000,
	player_get = {
		["steel"] = {-8,1},
	}
}

R_CraftSystem.Disassembly["circuitboard"] = {
	name = "Печатная плата",
	model = "models/illusion/eftcontainers/circuitboard.mdl",
	sell = 50,
	player_get = {
		["plastic"] = {3,6},
		["zapchasti"] = {1,3},
		["steel"] = {-5,1},
	}
}

R_CraftSystem.Disassembly["booster"] = {
	name = "Усилитель",
	model = "models/illusion/eftcontainers/controller.mdl",
	sell = 800,
	player_get = {
		["plastic"] = {2,4},
		["zapchasti"] = {3,6},
		["steel"] = {3,6},
	}
}

R_CraftSystem.Disassembly["copypaper"] = {
	name = "Бумага для принтера",
	model = "models/illusion/eftcontainers/copypaper.mdl",
	sell = 20,
	player_get = {
		["cloth"] = 1,
	}
}

R_CraftSystem.Disassembly["diagset"] = {
	name = "Набор для диагностики",
	model = "models/illusion/eftcontainers/diagset.mdl",
	sell = 2000,
	player_get = {
		["reaktiv"] = 2,
	}
}

R_CraftSystem.Disassembly["dryfuel"] = {
	name = "Сухое топливо",
	model = "models/illusion/eftcontainers/dryfuel.mdl",
	sell = 1270,
	player_get = {
		["plastic"] = {1,3},
		["reaktiv"] = {3,6},
	}
}

R_CraftSystem.Disassembly["ducttape"] = {
	name = "Белая изолента",
	model = "models/illusion/eftcontainers/ducttape.mdl",
	sell = 50,
	player_get = {
		["cloth"] = {2,5},
		["reaktiv"] = {-8,1},
	}
}

R_CraftSystem.Disassembly["electricdrill"] = {
	name = "Электро-дрель",
	model = "models/illusion/eftcontainers/electricdrill.mdl",
	sell = 300,
	player_get = {
		["steel"] = {0,1},
		["plastic"] = {2,5},
		["zapchasti"] = {4,7},
	}
}

R_CraftSystem.Disassembly["engine"] = {
	name = "Двигатель",
	model = "models/illusion/eftcontainers/engine.mdl",
	sell = 35,
	player_get = {
		["steel"] = {1,3},
		["plastic"] = {1,4},
		["reaktiv"] = 1,
		["zapchasti"] = {1,4},
	}
}

R_CraftSystem.Disassembly["flashstorage"] = {
	name = "Переносной жесткий диск",
	model = "models/illusion/eftcontainers/flashstorage.mdl",
	sell = 40,
	player_get = {
		["steel"] = 1,
		["plastic"] = 2,
	}
}

R_CraftSystem.Disassembly["fuelconditioner"] = {
	name = "Топливный кондиционер",
	model = "models/illusion/eftcontainers/fuelconditioner.mdl",
	sell = 1500,
	player_get = {
		["steel"] = {1,3},
		["reaktiv"] = {2,5},
		["plastic"] = {2,4},
	}
}

R_CraftSystem.Disassembly["gasanalyser"] = {
	name = "Газоанализатор",
	model = "models/illusion/eftcontainers/gasanalyser.mdl",
	sell = 1850,
	player_get = {
		["steel"] = {-3,1},
		["zapchasti"] = {2,4},
		["plastic"] = {3,6},
		["reaktiv"] = {2,4},
	}
}

R_CraftSystem.Disassembly["rp_radiationdetector"] = {
	name = "Дозиметр",
	model = "models/lt_c/alienisolation/track3r/motion_track3r.mdl",
	sell = 500,
	player_get = {
		["steel"] = {0,1},
		["zapchasti"] = {2,4},
		["plastic"] = {1,3},
		["reaktiv"] = {1,2},
	}
}

R_CraftSystem.Disassembly["gasoline"] = {
	name = "Канистра",
	model = "models/illusion/eftcontainers/gasoline.mdl",
	sell = 380,
	player_get = {
		["reaktiv"] = 2,
	}
}

R_CraftSystem.Disassembly["ent_fuel"] = {
	name = "Канистра(с бензином)",
	model = "models/illusion/eftcontainers/gasoline.mdl",
	sell = 1300,
	player_get = {
		["steel"] = {2,5},
		["reaktiv"] = {1,2},
		["plastic"] = {1,4},
		["wood"] = {1,5},
	}
}

R_CraftSystem.Disassembly["geigercounter"] = {
	name = "Счетчик гейгера",
	model = "models/illusion/eftcontainers/geigercounter.mdl",
	sell = 2000,
	player_get = {
		["steel"] = {0,1},
		["zapchasti"] = {1,3},
		["plastic"] = {4,8},
		["reaktiv"] = {1,4},
	}
}

R_CraftSystem.Disassembly["goldchain"] = {
	name = "Золотая цепь",
	model = "models/illusion/eftcontainers/goldchain.mdl",
	sell = 1200,
	player_get = {
		["steel"] = 1,
	}
}

R_CraftSystem.Disassembly["gpblue"] = {
	name = "Порох",
	model = "models/illusion/eftcontainers/gpblue.mdl",

	player_get = {
		["plastic"] = {3,6},
		["reaktiv"] = {1,2},
	}
}

R_CraftSystem.Disassembly["gpgreen"] = {
	name = "Качественный порох",
	model = "models/illusion/eftcontainers/gpgreen.mdl",
	player_get = {
		["reaktiv"] = {1,2},
		["plastic"] = {3,6},
	}
}

R_CraftSystem.Disassembly["gphone"] = {
	name = "Разбитый iPhone 5",
	model = "models/illusion/eftcontainers/gphone.mdl",
	sell = 70,
	player_get = {
		["plastic"] = {2,5},
		["steel"] = {0,1},
		["zapchasti"] = {3,7},
	}
}

R_CraftSystem.Disassembly["gphonex"] = {
	name = "Разбитый iPhone 10",
	model = "models/illusion/eftcontainers/gphonex.mdl",
	sell = 1200,
	player_get = {
		["plastic"] = {3,7},
		["steel"] = {0,1},
		["zapchasti"] = {1,2},
	}
}

R_CraftSystem.Disassembly["gpred"] = {
	name = "Пистолетный порох",
	model = "models/illusion/eftcontainers/gpred.mdl",
	sell = 35,
	player_get = {
		["plastic"] = {1,4},
		["reaktiv"] = {-8,1},
	}
}

R_CraftSystem.Disassembly["graphicscard"] = {
	name = "Видеокарта",
	model = "models/illusion/eftcontainers/graphicscard.mdl",
	sell = 1800,
	player_get = {
		["steel"] = {-2,1},
		["zapchasti"] = {2,6},
		["cloth"] = {1,3},
		["plastic"] = {2,4},
	}
}

R_CraftSystem.Disassembly["gyroscope"] = {
	name = "Гироскоп",
	model = "models/illusion/eftcontainers/gyroscope.mdl",
	sell = 700,
	player_get = {
		["steel"] = {-3,1},
		["zapchasti"] = {-30,1},
		["reaktiv"] = 1,
	}
}

R_CraftSystem.Disassembly["gyrotachometer"] = {
	name = "Гироскоп-тахометр",
	model = "models/illusion/eftcontainers/gyrotachometer.mdl",
	sell = 200,
	player_get = {
		["steel"] = {0,1},
		["zapchasti"] = {2,4},
		["reaktiv"] = 1,
	}
}

R_CraftSystem.Disassembly["hdd"] = {
	name = "Жесткий диск",
	model = "models/illusion/eftcontainers/hdd.mdl",
	sell = 40,
	player_get = {
		["plastic"] = {4,7},
		["zapchasti"] = {3,6},
	}
}

R_CraftSystem.Disassembly["helix"] = {
	name = "Трубка",
	model = "models/illusion/eftcontainers/helix.mdl",
	sell = 40,
	player_get = {
		["plastic"] = {3,7},
	}
}

R_CraftSystem.Disassembly["horse"] = {
	name = "Статуя коня",
	model = "models/illusion/eftcontainers/horse.mdl",
	sell = 30,
	player_get = {
		["steel"] = 1,
	}
}

R_CraftSystem.Disassembly["hose"] = {
	name = "Шланг",
	model = "models/illusion/eftcontainers/hose.mdl",
	sell = 150,
	player_get = {
		["plastic"] = {5,9},
	}
}

R_CraftSystem.Disassembly["insulatingtape"] = {
	name = "Синяя изолента",
	model = "models/illusion/eftcontainers/insulatingtape.mdl",
	sell = 50,
	player_get = {
		["cloth"] = {2,5},
		["reaktiv"] = {-8,1},
	}
}

R_CraftSystem.Disassembly["intel"] = {
	name = "Документы",
	model = "models/illusion/eftcontainers/intel.mdl",
	sell = 60,
	player_get = {
		["cloth"] = {1,3},
	}
}

R_CraftSystem.Disassembly["kerosine"] = {
	name = "Канистра с керосином",
	model = "models/illusion/eftcontainers/kerosine.mdl",
	sell = 1600,
	player_get = {
		["steel"] = {0,1},
		["reaktiv"] = {3,6},
		["plastic"] = {3,9},
		["wood"] = {3,7},
	}
}


R_CraftSystem.Disassembly["labskeycard"] = {
	name = "Ключ-карта",
	model = "models/illusion/eftcontainers/labskeycard.mdl",
	sell = 20000,
	player_get = {
		["plastic"] = {0,3},
		["zapchasti"] = {0,1},
	}
}

R_CraftSystem.Disassembly["laptop"] = {
	name = "Военный ноутбук",
	model = "models/illusion/eftcontainers/laptop.mdl",
	sell = 1800,
	player_get = {
		["steel"] = {1,2},
		["zapchasti"] = {2,8},
		["plastic"] = 3,
		["reaktiv"] = 1,
	}
}

R_CraftSystem.Disassembly["lcdclean"] = {
	name = "Рабочий экран",
	model = "models/illusion/eftcontainers/lcdclean.mdl",
	sell = 1790,
	player_get = {
		["plastic"] = {3,7},
		["steel"] = {0,1},
		["zapchasti"] = {1,3},
	}
}

R_CraftSystem.Disassembly["lcddirty"] = {
	name = "Разбитый экран",
	model = "models/illusion/eftcontainers/lcddirty.mdl",
	sell = 20,
	player_get = {
		["plastic"] = {1,4},
		["steel"] = {-3,1},
		["zapchasti"] = 1,
	}
}

R_CraftSystem.Disassembly["lightbulb"] = {
	name = "Лампочка",
	model = "models/illusion/eftcontainers/lightbulb.mdl",
	sell = 30,
	player_get = {
		["zapchasti"] = {1,3},
		["plastic"] = {1,3},
	}
}

R_CraftSystem.Disassembly["lionstatue"] = {
	name = "Статуя льва",
	model = "models/illusion/eftcontainers/lionstatue.mdl",
	sell = 30,
	player_get = {
		["steel"] = 1,
	}
}

R_CraftSystem.Disassembly["magnet"] = {
	name = "Большой магнит",
	model = "models/illusion/eftcontainers/magnet.mdl",
	sell = 80,
	player_get = {
		["steel"] = {0,1},
		["zapchasti"] = {-9,1},
	}
}

R_CraftSystem.Disassembly["matches"] = {
	name = "Спички",
	model = "models/illusion/eftcontainers/matches.mdl",
	sell = 30,
	player_get = {
		["wood"] = 1,
		["reaktiv"] = {-10,1},
 	}
}

R_CraftSystem.Disassembly["medsyringe"] = {
	name = "Неиспользованный шприц",
	model = "models/illusion/eftcontainers/medsyringe.mdl",
	sell = 20,
	player_get = {
		["cloth"] = {1,3},
		["plastic"] = {2,5},
	}
}

R_CraftSystem.Disassembly["medpile"] = {
	name = "Использованные медикаменты",
	model = "models/illusion/eftcontainers/medpile.mdl",
	sell = 800,
	player_get = {
		["tamiflu"] = {-5,1},
		["efferalgan"] = {-5,1},
		["usedbandage"] = {1,3},
		["medsyringe"] = {-1,1},
		["medtape"] = {-3, 1},
	}
}

R_CraftSystem.Disassembly["militarybattery"] = {
	name = "Военный аккумулятор",
	model = "models/illusion/eftcontainers/militarybattery.mdl",
	sell = 2500,
	player_get = {
		["steel"] = {1,5},
		["zapchasti"] = {2,6},
		["plastic"] = {2,4},
		["reaktiv"] = {1,2},
	}
}

R_CraftSystem.Disassembly["militarycable"] = {
	name = "Качественный кабель",
	model = "models/illusion/eftcontainers/militarycable.mdl",
	sell = 300,
	player_get = {
		["plastic"] = {1,3},
		["cloth"] = {3,6},
	}
}

R_CraftSystem.Disassembly["pen"] = {
	name = "Ручка",
	model = "models/illusion/eftcontainers/morphine.mdl",
	sell = 10,
	player_get = {
		["plastic"] = {0,3},
	}
}

R_CraftSystem.Disassembly["nailpack"] = {
	name = "Пачка гвоздей",
	model = "models/illusion/eftcontainers/nailpack.mdl",
	sell = 50,
	player_get = {
		["plastic"] = 1,
		["steel"] = {-5,1}
	}
}

R_CraftSystem.Disassembly["nixxorlens"] = {
	name = "Линза для фотоаппарата",
	model = "models/illusion/eftcontainers/nixxorlens.mdl",
	sell = 500,
	player_get = {
		["zapchasti"] = {2,5},
		["plastic"] = {3,5},
		["steel"] = {-4,1},
	}
}

R_CraftSystem.Disassembly["nuts"] = {
	name = "Гайки",
	model = "models/illusion/eftcontainers/nuts.mdl",
	sell = 30,
	player_get = {
		["steel"] = {-98,1},
	}
}

R_CraftSystem.Disassembly["packofscrews"] = {
	name = "Набор гвоздей",
	model = "models/illusion/eftcontainers/packofscrews.mdl",
	sell = 30,
	player_get = {
		["steel"] = {-8,1},
		["plastic"] = {1,3},
	}
}

R_CraftSystem.Disassembly["paracord"] = {
	name = "Прочная верёвка",
	model = "models/illusion/eftcontainers/paracord.mdl",
	sell = 1300,
	player_get = {
		["cloth"] = {4,9},
	}
}

R_CraftSystem.Disassembly["phaseantenna"] = {
	name = "Запчасть антенны",
	model = "models/illusion/eftcontainers/phaseantenna.mdl",
	sell = 2500,
	player_get = {
		["wood"] = {2,5},
		["steel"] = {1,4},
		["zapchasti"] = {3,6},
		["plastic"] = {2,7},
	}
}

R_CraftSystem.Disassembly["phaserelay"] = {
	name = "Фазовое реле",
	model = "models/illusion/eftcontainers/phaserelay.mdl",
	sell = 40,
	player_get = {
		["steel"] = {1,2},
		["zapchasti"] = {2,5},
		["plastic"] = {1,3},
	}
}

R_CraftSystem.Disassembly["plexiglass"] = {
	name = "Плексиглас",
	model = "models/illusion/eftcontainers/plexiglass.mdl",
	sell = 1444,
	player_get = {
		["reaktiv"] = {0,1},
	}
}

R_CraftSystem.Disassembly["pliers"] = {
	name = "Плоскогубцы",
	model = "models/illusion/eftcontainers/pliers.mdl",
	sell = 30,
	player_get = {
		["plastic"] = {2,5},
		["steel"] = {-3,1},
	}
}

R_CraftSystem.Disassembly["powerbank"] = {
	name = "Павер-банк",
	model = "models/illusion/eftcontainers/powerbank.mdl",
	sell = 1300,
	player_get = {
		["steel"] = {-3,1},
		["plastic"] = {1,4},
		["zapchasti"] = {2,5},
	}
}

R_CraftSystem.Disassembly["powercord"] = {
	name = "Шнур для питания",
	model = "models/illusion/eftcontainers/powercord.mdl",
	sell = 88,
	player_get = {
		["plastic"] = {1,3},
		["zapchasti"] = {2,5},
	}
}

R_CraftSystem.Disassembly["powerfilter"] = {
	name = "ЭМИ-фильтр",
	model = "models/illusion/eftcontainers/powerfilter.mdl",
	sell = 2000,
	player_get = {
		["plastic"] = {3,6},
		["zapchasti"] = {3,6},
		["reaktiv"] = 1,
	}
}

R_CraftSystem.Disassembly["powersupplyunit"] = {
	name = "Блок питания",
	model = "models/illusion/eftcontainers/powersupplyunit.mdl",
	player_get = {
		["steel"] = {-3,1},
		["zapchasti"] = {2,4},
		["cloth"] = 1,
	}
}

R_CraftSystem.Disassembly["pressuregauge"] = {
	name = "Манометр",
	model = "models/illusion/eftcontainers/pressuregauge.mdl",
	sell = 800,
	player_get = {
		["steel"] = {-3,1},
		["zapchasti"] = {3,8},
		["wood"] = {2,7},
	}
}

R_CraftSystem.Disassembly["sparkplug"] = {
	name = "Авто свеча",
	model = "models/illusion/eftcontainers/sparkplug.mdl",
	sell = 27,
	player_get = {
		["steel"] = 1,
		["zapchasti"] = {0,1},
	}
}

R_CraftSystem.Disassembly["soap"] = {
	name = "Мыло",
	model = "models/illusion/eftcontainers/soap.mdl",
	sell = 20,
	player_get = {
		["reaktiv"] = {-5,1},
	}
}

R_CraftSystem.Disassembly["shampoo"] = {
	name = "Шампунь",
	model = "models/illusion/eftcontainers/shampoo.mdl",
	sell = 50,
	player_get = {
		["reaktiv"] = {-10,1},
	}
}

R_CraftSystem.Disassembly["toolset"] = {
	name = "Набор инструментов для строительства",
	model = "models/illusion/eftcontainers/toolset.mdl",
	sell = 900,
	player_get = {
		["steel"] = 1,
		["plastic"] = {3,7},
		["wood"] = {3,6},
		["zapchasti"] = {2,5},
	}
}

R_CraftSystem.Disassembly["toothpaste"] = {
	name = "Зубная паста",
	model = "models/illusion/eftcontainers/toothpaste.mdl",
	sell = 15,
	player_get = {
		["plastic"] = 1,
	}
}

R_CraftSystem.Disassembly["wires"] = {
	name = "Провода",
	model = "models/illusion/eftcontainers/wires.mdl",
	sell = 30,
	player_get = {
		["plastic"] = {1,2},
		["cloth"] = {1,4},
	}
}

R_CraftSystem.Disassembly["wrench"] = {
	name = "Гаечный ключ",
	model = "models/illusion/eftcontainers/wrench.mdl",
	sell = 50,
	player_get = {
		["steel"] = {-8,1},
	}
}


/*---------------------------------------------------------------------------
Функции
---------------------------------------------------------------------------*/

function GetCraftPrice(id)
	local count = R_CraftSystem.Recipes[id].count and R_CraftSystem.Recipes[id].count or 1
	if R_CraftSystem.Recipes[id].CraftPrice then
		return R_CraftSystem.Recipes[id].CraftPrice
	else
		local priceForOne = 0
		for k,v in pairs(R_CraftSystem.Recipes[id].recipe) do
			priceForOne = priceForOne + v
		end
		return priceForOne
	end
end

/*---------------------------------------------------------------------------
Дальше идет код :D
---------------------------------------------------------------------------*/


function R_CraftSystem:RegisterBodies(class, weptbl)
	if not weptbl.name then weptbl.name = weapons.GetStored(class).PrintName end
    if not weptbl.model then weptbl.model = weapons.GetStored(class).WorldModel end

	local ENT = {}
	ENT.Base = "base_gmodentity"
	ENT.Type = "anim"
	ENT.PrintName = "Корпус "..weptbl.name
	ENT.WorldModel = weptbl.model
	ENT.Model = weptbl.model

	ENT.Category = "Корпус для оружия"
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
	scripted_ents.Register( ENT, class.."_body" )

	rp.AddEntity(weptbl.name,{
        ent = class.."_body",
        model = weptbl.model,
        price = 0,
        usable = false,
        max = 0,
        cmd = '',
        weight = weptbl.weight or rp.lootweights[class.."_body"] or 0.5,
    })
end

function R_CraftSystem:RegisterDetail(class, detail)
	local ENT = {}
	ENT.Base = "base_gmodentity"
	ENT.Type = "anim"
	ENT.PrintName = detail.name
	ENT.WorldModel = detail.model
	ENT.Model = detail.model

	ENT.Category = "R_CraftSystem"
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
	-- local k = {
	-- 	name= v.name,
	-- 	id = k,
	-- 	model= v.model,
	-- 	pos = v.pos,
	-- 	ang = v.ang,
	-- 	slot=COSM_SLOT_RHAND,
	-- 	type = "weapon",
	-- 	scale=1,
	-- 	attach = "chest",
	-- 	price=0,
	-- }
	-- table.insert(Cosmetics.Items, k)
end

function R_CraftSystem:RegisterDissamblies(class, dissamblies)
	if scripted_ents.Get(class) then return end

	local ENT = {}
	ENT.Base = "base_gmodentity"
	ENT.Type = "anim"
	ENT.PrintName = dissamblies.name
	ENT.WorldModel = dissamblies.model
	ENT.Model = dissamblies.model
	if IsUselessModel(dissamblies.model) then
		print(dissamblies.model .. "isn't exist![CRAFT SYSTEM ERROR]")
	end

	ENT.Category = "Лут"
	ENT.Spawnable = true

	if SERVER then
		function ENT:Initialize()
			self:SetModel( self.WorldModel )
			self:PhysicsInit(SOLID_VPHYSICS)
			self:SetMoveType(MOVETYPE_VPHYSICS)
			self:SetSolid(SOLID_VPHYSICS)
			self:SetUseType(SIMPLE_USE)
			local phys = self:GetPhysicsObject()
			if IsValid(phys) then
				phys:Wake()
			end
		end
	end

	scripted_ents.Register( ENT, class )
end

hook.Add( "OnGamemodeLoaded", "rp.CraftSystem.RegisterAllInstances", function()
	for k,v in pairs(R_CraftSystem.Recipes) do
		if v.needbody then
			R_CraftSystem:RegisterBodies(k, v)
		end
	end
	for class,weptbl in pairs(R_CraftSystem.Recipes) do
		if weptbl.needbody then
			rp.AddEntity(weptbl.name,{
		        ent = class.."_body",
		        model = weptbl.model,
		        price = 0,
		        usable = false,
		        max = 0,
		        cmd = '',
		        weight = weptbl.weight or rp.lootweights[class.."_body"] or 0.5,
		    })
			weptbl.recipe[class.."_body"] = 1
		end
	end
	for k,v in pairs(R_CraftSystem.Details) do
		R_CraftSystem:RegisterDetail(k, v)
	end
	for k,v in pairs(R_CraftSystem.Disassembly) do
		R_CraftSystem:RegisterDissamblies(k, v)
	end
end)