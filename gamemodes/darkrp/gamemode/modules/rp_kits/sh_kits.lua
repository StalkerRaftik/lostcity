rp.Kits = rp.Kits or {}

-- lvl = уровень для кита, не заполнять если не нужен
-- Изначально стоящее количество часов обновлени наборов 86400

rp.Kits.NiceNames = {
  {name = "Бесплатные наборы", cooldown = 1, color = Color(100, 210, 13,150)},
  {name = "Стандартные наборы", cooldown = 1, color = Color(100, 210, 13,150)},
  {name = "Профессиональные наборы", cooldown = 1, color = Color(255, 236, 0,150), last = true},
}

rp.Kits.Config = {
	
 -------------------------------------------------------
 ----------------------Бесплатные-----------------------
 -------------------------------------------------------
	{
		{
			Name = " «Голодный День» [Набор Новичка]",
			Items = {
				["food_31"] = {INV_ENTITY, 1},
				["food_29"] = {INV_ENTITY, 1},
				["food_94"] = {INV_ENTITY, 1},
				["food_60"] = {INV_ENTITY, 2},
				["food_10"] = {INV_ENTITY, 1},
			},
			Level = 5,
			Price = 450,
			Description = "Люди зачастую среди множества ненужных вещей находят самый нужные... Проверив свои запасы Вы обнаружили такой набор вещей:\n\n▶ Вы получите: Чипсы «Doritos» с кукурузой, Чипсы «Doritos» с Луком и Зеленью, Грязную и протухшую воду, Два свежих апельсина и один немного чёрствый Хлеб...", 
			color = Color(222, 184, 135,200),
			model = "models/props_interiors/refrigerator01a.mdl"
		},

		{
			Name = " «Здорово Жить» [Набор Новичка]",
			Items = {
				["med_coal"] = {INV_ENTITY, 5},
				["ent_bandage"] = {INV_ENTITY, 1},
				["medpile"] = {INV_ENTITY, 2},
				["usedbandage"] = {INV_ENTITY, 2},
			},
			Level = 10,
			Price = 700,
			Description = "Медицина — это лучшее, что придумало человечество... Наверное... Набор таких лекарств неплохо Вам поможет:\n\n▶ Вы получите: Старую пачку активированного угля, Один стерильный бинт в немного потёртой упаковке, Какие-то использованные медикаменты и два использованных бинта...", 
			color = Color(255, 235, 205,200),
			model = "models/props/cs_office/shelves_metal3.mdl"
		},

		{
			Name = " «Незаменимая Помощь» [Набор Новичка]",
			Items = {
				["ent_battery"] = {INV_ENTITY, 2},
				["matches"] = {INV_ENTITY, 1},
				["insulatingtape"] = {INV_ENTITY, 1},
				["update01_hlam9"] = {INV_ENTITY, 2},
				["tfa_nmrih_wrench"] = {INV_WEAPON},
				["gta_beanie01e"] = {INV_HATS},
				["backpack_molle"] = {INV_HATS},
			},
			Level = 15,
			Price = 1200,
			Description = "Хлам иногда бывает полезен, особенно тот, который затерялся... Такой набор даст Вам немалый шанс выжить:\n\n▶ Вы получите: Ржавый гаечный ключ, Чуть-чуть закисленные батарейки, Почти потраченные Спички, Один клубок синей изоленты, Шапка по размеру, Потрепанная походная сумка и туалетная бумага...", 
			color = Color(188, 143, 143,200),
			model = "models/props_c17/FurnitureDresser001a.mdl"
		},
	},


















 -------------------------------------------------------
 -----------------------Обычные-------------------------
 -------------------------------------------------------
	{
		{
			Name = " «Везунчик»",
			Items = {
				["food_62"] = {INV_ENTITY, 1},
				["food_15"] = {INV_ENTITY, 1},
				["food_93"] = {INV_ENTITY, 1},
				["usedbandage"] = {INV_ENTITY, 2},
				["tfa_nmrih_kknife"] = {INV_WEAPON},
				["gta_cap02g"] = {INV_HATS},
				["pilotgoggles"] = {INV_HATS},
			},
			Level = 1,
			DonatePrice = 55,
			Price = 20000,
			Description = "Вы очень «Везучий» человек, да! Вы смогли найти пару вещичек, которые помогут Вам прожить ещё немного в этой страшной и сложной ситуации:\n\n▶ Вы получите: Сочные грушу и яблоко, Бутылку минеральной вкусной воды, Два не очень стерильных бинта, Кухонный нож из Вашего дома, Кепка и очки «Неудачника»...", 
			color = Color(0, 128, 128,200),
			model = "models/props/cs_office/snowman_hat.mdl"
		},

		{
			Name = " «Специалист»",
			Items = {
				["food_78"] = {INV_ENTITY, 2},
				["food_1"] = {INV_ENTITY, 1},
				["food_10"] = {INV_ENTITY, 1},
				["medsyringe"] = {INV_ENTITY, 1},
				["ent_bandage"] = {INV_ENTITY, 1},
				["tfa_nmrih_crowbar"] = {INV_WEAPON},
				["backpack_molle"] = {INV_HATS},
				["motohelmet7"] = {INV_HATS},
			},
			Level = 2,
			DonatePrice = 105,
			Price = 35000,
			Description = "Вы уже - «Специалист»! Поэтому Вам как «Специалисту» совсем не трудно собрать такой набор:\n\n▶ Вы получите: Две вкуснейших куриных ножки, Один яблочный сок, Буханка запечённого хлеба, Один неиспользованный шприц, Стерильный бинт, Чёрная и лакированная монтировка, Маленькая походная сумка и Шлем от мотоцикла...", 
			color = Color(85, 107, 47,200),
			model = "models/props/cs_office/radio_p1.mdl"
		},

		{
			Name = " «Фермер»",
			Items = {
				["food_48"] = {INV_ENTITY, 3},
				["food_79"] = {INV_ENTITY, 2},
				["food_14"] = {INV_ENTITY, 1},
				["food_58"] = {INV_ENTITY, 2},
				["food_56"] = {INV_ENTITY, 5},
				["food_19"] = {INV_ENTITY, 2},
				["food_67"] = {INV_ENTITY, 1},
				["ducttape"] = {INV_ENTITY, 1},
				["ent_bandage"] = {INV_ENTITY, 2},
				["fs_apple_seeds"] = {INV_ENTITY, 1},
				["fs_tomato_seeds"] = {INV_ENTITY, 1},
				["fs_melon_seeds"] = {INV_ENTITY, 1},
				["tfa_nmrih_spade"] = {INV_WEAPON},
				["gta_beret01"] = {INV_HATS},
				["gta_glasses01c"] = {INV_HATS},
				["backpack_citya"] = {INV_HATS},
			},
			Level = 3,
			DonatePrice = 145,
			Price = 40000,
			Description = "Цветочки, бабочки, семена и капуста... Вы нашли занятие по душе, а так же набор «Фермера»:\n\n▶ Вы получите: Три кукурузы, Два помидора, Одну Капусту, Свежее Молоко, Два стерильных бинта, Белая «Фермерская» изолента, Ржавая и старая лопата, Тыква, Два Сыра, Рюкзак, Зелень, Прекрасная Кепи и различные семена...", 
			color = Color(0, 128, 0, 200),
			model = "models/props/de_inferno/crate_fruit_break_p1.mdl"
		},

		{
			Name = " «Строитель»",
			Items = {
				["food_86"] = {INV_ENTITY, 1},
				["food_51"] = {INV_ENTITY, 1},
				["food_53"] = {INV_ENTITY, 1},
				["food_72"] = {INV_ENTITY, 2},
				["ent_smallmedkit"] = {INV_ENTITY, 1},
				["ent_bandage"] = {INV_ENTITY, 2},
				["toolset"] = {INV_ENTITY, 1},
				["tfa_nmrih_bcd"] = {INV_WEAPON},
				["building_resources"] = {INV_ENTITY, 40},
				["backpack_baselardwild"] = {INV_HATS},
				["pilothelm2"] = {INV_HATS},
				["gta_bandana01"] = {INV_HATS},
			},
			Level = 4,
			DonatePrice = 185,
			Price = 49500,
			Description = "Работа, работа и ещё раз работа! Строить или делать ремонт? Для Вас как для «Строителя» это не проблема:\n\n▶ Вы получите: Две пачки печенья, Сосиску в тесте, Энергетик «RedBull», Два стерильных бинта, Одно обезболивающее, Ваш молоток, Рюкзак «Строителя», Шлем «Пилота» с банданой, Инструментарий для строительства и ресурсы...", 
			color = Color(210, 180, 140,200),
			model = "models/props/CS_militia/circularsaw01.mdl"
		},

		{
			Name = " «Пожарный»",
			Items = {
				["food_71"] = {INV_ENTITY, 2},
				["food_81"] = {INV_ENTITY, 1},
				["food_64"] = {INV_ENTITY, 2},
				["ent_smallmedkit"] = {INV_ENTITY, 1},
				["ent_bandage"] = {INV_ENTITY, 2},
				["ent_shina"] = {INV_ENTITY, 1},
				["tfa_nmrih_fireaxe"] = {INV_WEAPON},
				["weapon_rpw_binoculars_explorer"] = {INV_WEAPON},
				["tfa_rustalpha_flare"] = {INV_WEAPON},				
				["pbf"] = {INV_HATS},
				["firehelmet"] = {INV_HATS},
				["backpack_trizip"] = {INV_HATS},
			},
			Level = 5,
			DonatePrice = 215,
			Price = 56700,
			Description = "Находка снаряжения пожарного — это крутая находка! Вы нашли и собрали именного это снаряжение:\n\n▶ Вы получите: Две банки «Кока-колы», Стейк, Два рогалика, Два стерильных бинта, Обезболивающее из аптечки, Шина от переломов, Пожарный топор, Пожарный противогаз «PBF-30», Рюкзак «Трип-зип», Пожарный Шлем, Бинокль...", 
			color = Color(255, 0, 0, 200),
			model = "models/props/cs_office/Fire_Extinguisher.mdl"
		},

 		{
 			Name = "«Мародер»",
 			Items = {
 				["food_6"] = {INV_ENTITY, 2},
 				["food_7"] = {INV_ENTITY, 1},
 				["food_84"] = {INV_ENTITY, 1},
 				["food_66"] = {INV_ENTITY, 2},
 				["med_heatpack"] = {INV_ENTITY, 1},
 				["ent_bandage"] = {INV_ENTITY, 2},
 				["tfa_ammo_buckshot"] = {INV_ENTITY, 10},
 				["tfa_yog_crowbar"] = {INV_WEAPON},
 				["tfa_rustalpha_pipeshotgun"] = {INV_WEAPON},
 				["manmask2"] = {INV_HATS},
 				["backpack_baselardwild"] = {INV_HATS},
 				["gmod_fedora"] = {INV_HATS},
 			},
 			Level = 6,
 			DonatePrice = 265,
			Price = 63450,
 			Description = "Грабить, убивать и разбойничать это плохо, но... Набор «Мародёра» здесь будет очень кстати:\n\n▶ Вы получите: Три банки пива, Сэндвич, Два недоеденных кусочка пиццы, Два стерильных бинта, Одна грелка, Уникальная монтировка «Потрошитель», Маска «Мародёра» и шляпа, Рюкзак «Мародеров», Дробовик и патроны...", 
 			color = Color(105, 105, 105, 200),
 			model = "models/Gibs/HGIBS.mdl"
 		},
	},
	


















 -------------------------------------------------------
 -----------------------Элитные-------------------------
 -------------------------------------------------------
 	{
		{
			Name = "«Самурай»",
			Items = {
				["food_70"] = {INV_ENTITY, 2},
				["food_74"] = {INV_ENTITY, 2},
				["food_96"] = {INV_ENTITY, 1},
				["chain"] = {INV_ENTITY, 1},
				["ent_bandage"] = {INV_ENTITY, 2},
				["med_boostinject"] = {INV_ENTITY, 1},
				["tfa_l4d2_kfka"] = {INV_WEAPON},
				["guitar_sad"] = {INV_WEAPON},
				["headbandage2"] = {INV_HATS},
				["backpack_pilgrim2c"] = {INV_HATS},
			},
			Level = 6,
			DonatePrice = 305,
			Price = 72000,
			Description = "Не позволяйте другим превзойти себя на пути самурая... Набор даст Вам нечто большее, чем шанс на выживание:\n\n▶ Вы получите: Две жареных рыбы, Травяной японский чай, Две банки «Спрайта», Золотую цепочку, Два стерильных бинта, Глицин-Биотик «Инжектор», Фамильная Катана, Маска «Самурая» из бинтов, Гитара, Походный рюкзак...", 
			color = Color(0, 0, 0, 0),
			model = "models/props_junk/garbage_takeoutcarton001a.mdl"
		},

		{
			Name = "«Охотник»",
			Items = {
				["food_92"] = {INV_ENTITY, 3},
				["food_20"] = {INV_ENTITY, 2},
				["food_98"] = {INV_ENTITY, 1},
				["ent_smallmedkit"] = {INV_ENTITY, 2},
				["ent_bandage"] = {INV_ENTITY, 2},
				["matches"] = {INV_ENTITY, 2},
				["rp_firekit"] = {INV_ENTITY, 1},
				["arrow"] = {INV_ENTITY, 20},
				["tfa_ins2_kabar"] = {INV_WEAPON},
				["tfbow_sf2"] = {INV_WEAPON},
				["ukvest"] = {INV_HATS},
				["confederate_hat"] = {INV_HATS},
				["backpack_molle"] = {INV_HATS},
			},
			Level = 7,
			DonatePrice = 395,
			Price = 84678,
			Description = "Промысел, состоящий в поиске, выслеживании, преследовании добычи... Найденное Вами снаряжение поможет Вам в этом:\n\n▶ Вы получите: Три банки с огурцами, Две вкуснейших шаурмы, Домашняя настойка, Два стерильных бинта, Обезболивающее, «Охотничий» ножик, «Охотничий» лук, Боевые стрелы, Разгрузка «Лес», Спички, Кепка «Охотника» и набор «Разведения костра»...", 
			color = Color(199, 21, 133, 200),
			model = "models/props/cs_militia/haybale_target_02.mdl"
		},

		{
			Name = "«Громила»",
			Items = {
				["food_61"] = {INV_ENTITY, 2},
				["food_91"] = {INV_ENTITY, 1},
				["food_9"] = {INV_ENTITY, 3},
				["ent_shina"] = {INV_ENTITY, 2},
				["ent_medkit"] = {INV_ENTITY, 1},
				["ent_bandage"] = {INV_ENTITY, 3},
				["usedbandage"] = {INV_ENTITY, 2},
				["tfa_nmrih_sledge"] = {INV_WEAPON},
				["pressvest"] = {INV_HATS},
				["hocmask3"] = {INV_HATS},
				["backpack_pilgrim"] = {INV_HATS},
			},
			Level = 8,
			DonatePrice = 445,
			Price = 93974,
			Description = "Не всегда в апокалипсис решает смекалка... Найденное Вами снаряжение докажет, что сила покрывает отсутствие смекалки:\n\n▶ Вы получите: Два апельсиновых сока, Тарелка блинчиков, Три пачки хлопьев, Три стерильных бинта, Две Шины от переломов, Очень Тяжёлая Кувалда, Рюкзак «Пилигрим», Легкий бронежилет, Хоккейная и крепкая маска...", 
			color = Color(255, 255, 255, 200),
			model = "models/props/de_nuke/cinderblock_stack.mdl"
		},

		{
			Name = "«Городской стрелок»",
			Items = {
				["food_72"] = {INV_ENTITY, 2},
				["food_93"] = {INV_ENTITY, 3},
				["food_77"] = {INV_ENTITY, 2},
				["food_95"] = {INV_ENTITY, 1},
				["ent_bandage"] = {INV_ENTITY, 3},
				["ent_medkit"] = {INV_ENTITY, 1},
				["ent_smallmedkit"] = {INV_ENTITY, 2},
				["tfa_ammo_pistol"] = {INV_ENTITY, 25},
				["tfa_xiandagger"] = {INV_WEAPON},
				["rust_sap"] = {INV_WEAPON},
				["backpack_cityb"] = {INV_HATS},
				["balaclava9"] = {INV_HATS},
				["gta_cap01b"] = {INV_HATS},
			},
			Level = 9,
			DonatePrice = 495,
			Price = 98732,
			Description = "Город на сегодняшний день очень опасен... Заполучив этот набор, Вы облегчите себе жизнь:\n\n▶ Вы получите: Два энергетика «Red Bull», Три бутылки воды, Шоколад «Tofifi», Домашняя Курица-гриль, Три стерильных бинта, Аптечка, Обезболивающее, Сувенирный нож, Пистолет «Туканчик», Городской Рюкзак, Патроны, Городская кепка...", 
			color = Color(0, 128, 128, 200),
			model = "models/props/cs_assault/noparking.mdl"
		}, 

		{
			Name = "«Полицейский»",
			Items = {
				["food_52"] = {INV_ENTITY, 3},
				["food_46"] = {INV_ENTITY, 2},
				["food_13"] = {INV_ENTITY, 2},
				["ent_bandage"] = {INV_ENTITY, 3},
				["ent_medkit"] = {INV_ENTITY, 2},
				["ent_smallmedkit"] = {INV_ENTITY, 1},
				["tfa_ammo_pistol"] = {INV_ENTITY, 20},
				["weapon_policebaton"] = {INV_WEAPON},
				["tfa_fas2_glock20"] = {INV_WEAPON},
				["policevest"] = {INV_HATS},
				["hatgeneral"] = {INV_HATS},
				["gta_glasses01"] = {INV_HATS},
			},
			Level = 10,
			DonatePrice = 610,
			Price = 110567,
			Description = "«Полицейские» такие неряхи... Собрав такой набор, Вы сможете дать отпор любому человеку, даже полицейскому:\n\n▶ Вы получите: Три «Полицейских» пончика, Две маленьких «Кока-колы», Два Бургера, Три стерильных бинта, Две аптечки, Обезболивающее, «Полицейская» дубинка, Glock-20, Патроны, «Полицейский» бронежилет, Фуражка и чёрные очки...", 
			color = Color(0, 0, 128, 200),
			model = "models/weapons/w_eq_eholster_elite.mdl"
		}, 

		{
			Name = "«Военный комплект»",
			Items = {
				["food_13"] = {INV_ENTITY, 2},
				["food_73"] = {INV_ENTITY, 3},
				["food_8"] = {INV_ENTITY, 2},
				["food_3"] = {INV_ENTITY, 4},
				["ent_bandage"] = {INV_ENTITY, 3},
				["ent_medkit"] = {INV_ENTITY, 3},
				["flashlight"] = {INV_ENTITY, 1},
				["ent_battery"] = {INV_ENTITY, 3},
				["tfa_ammo_ar2"] = {INV_ENTITY, 75},
				["tfa_nmrih_etool"] = {INV_WEAPON},
				["tfa_ins2_akm_bw"] = {INV_WEAPON},
				["smershvest"] = {INV_HATS},
				["ssh68"] = {INV_HATS},
			},
			Level = 12,
			DonatePrice = 1200,
			Price = 188567,
			Description = "Военных давно не видать на территории города... Набор такого типа испугает любого беднягу на Вашем пути:\n\n▶ Вы получите: Два бургера, Три маленьких «PEPSI», Четыре Бекона, Три стерильных бинта, Три аптечки, Сапёрную Лопату, AK-47, Патроны, «Военная» разгрузка, Каска, «Военный» фонарик и батарейки...", 
			color = Color(0, 128, 0, 200),
			model = "models/props/de_prodigy/ammo_can_03.mdl"
		}, 
	},
}


function PLAYER:AllowedToUseKit(kit)
	if kit.Upgrade then
		return self:HasUpgrade(kit.Upgrade[1]) or self:HasUpgrade(kit.Upgrade[2])
	end
  	return true
end


hook.Add( "OnGamemodeLoaded", "RegisterKitsInDonateSystem", function()
	local KitCounter = 1
	for gid, KitGroup in pairs(rp.Kits.Config) do 
		for kid, Kit in pairs(KitGroup) do
			if not Kit.DonatePrice then continue end

			rp.shop.Add(Kit.Name .. " [Неделя]", "kit_"..KitCounter)
			  :SetCat('Наборы')
			  :SetPrice(Kit.DonatePrice)
			  :SetIcon(Kit.model)
			  :SetDesc(Kit.Description)
			  :SetDuration(604800)
			  :SetStackable(false)
			  :SetNetworked(true)

			--rp.shop.Add(Kit.Name .. " [Месяц]", "kit_"..KitCounter.."_month")
			--  :SetCat('Наборы')
			--  :SetPrice(Kit.DonatePrice)
			--  :SetIcon(Kit.model)
			--  :SetDesc(Kit.Description)
			--  :SetDuration(2629743)
			--  :SetStackable(false)
			--  :SetNetworked(true)

			rp.Kits.Config[gid][kid].Upgrade = {}
			rp.Kits.Config[gid][kid].Upgrade[1] = "kit_"..KitCounter
			rp.Kits.Config[gid][kid].Upgrade[2] = "kit_"..KitCounter.."_month"
		end
	end
end )