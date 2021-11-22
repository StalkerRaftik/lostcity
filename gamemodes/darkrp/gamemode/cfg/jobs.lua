-------------------------------------------------------
----------------------Переменные-----------------------
-------------------------------------------------------
INV_WEAPON = "weapon"
INV_ENTITY = "entity"
INV_FOOD = "food"
INV_INGREDIENT = "ingredient"
INV_PROP = "prop"
INV_HATS = "hats"
INV_CLOTHES = "clothes"
-------------------------------------------------------
-------------------------------------------------------
-------------------------------------------------------

















-------------------------------------------------------
----------------------Категория------------------------
-------------------------------------------------------
DarkRP.createCategory{
    name = "Поместье “Блэйк” Округа “Asheville”",
    categorises = "jobs",
    startExpanded = true,
    color = Color(0, 107, 0, 255),
    canSee = fp{fn.Id, true},
    sortOrder = 100,
    spawnPoint = {
        Vector(-10694.093750, 9744.975586, 16.368256),
    }
}
DarkRP.createCategory{
    name = "Полицейский департамент “Asheville”",
    categorises = "jobs",
    startExpanded = true,
    color = Color(214, 132, 96, 255),
    canSee = fp{fn.Id, true},
    sortOrder = 100,
    spawnPoint = {
        Vector(-11685.629883, -2536.478271, 69.031250),
    }
}
DarkRP.createCategory{
    name = "Бандиты города “Ashville”",
    categorises = "jobs",
    startExpanded = true,
    color = Color(199, 12, 12, 255),
    canSee = fp{fn.Id, true},
    sortOrder = 100,
    spawnPoint = {
        Vector(-5926.851563, -12364.190430, 57.031250),
    }

}
DarkRP.createCategory{
    name = "Легион",
    categorises = "jobs",
    startExpanded = true,
    color = Color(199, 12, 12, 255),
    canSee = fp{fn.Id, true},
    sortOrder = 100,
    spawnPoint = {
        Vector(8122.825195, 2000.564087, -380.968750),
    }
}

TEAM_CITIZEN = rp.addTeam("Выживший", {
    color = Color(128, 128, 128, 255),
    model = {
        "models/kerry/player/citizen/female_01.mdl",

    },
    description = [[Вы один из тех кто выжил..]],
    weapons = {},
    command = "citizen",
    max = 0,
    salary = 0,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false
})
-------------------------------------------------------
-------------------------------------------------------
-------------------------------------------------------




























-------------------------------------------------------
-----------ПОЛИЦЕЙСКИЙ ДЕПАРТАМЕНТ ASHEVILLE-----------
-------------------------------------------------------

TEAM_POL1 = rp.addTeam("Офицер «Департамента Asheville»", {
    color = Color(0, 191, 255, 255),
    model = {
        ---------------------------------------
		----ПОЛИЦЕЙСКИЙ ДЕПАРТАМЕНТ Мужские----
		---------------------------------------
        "models/player/icpd/cops/male_01_longsleeved.mdl",
        "models/player/icpd/cops/male_02_longsleeved.mdl",
        "models/player/icpd/cops/male_03_longsleeved.mdl",
        "models/player/icpd/cops/male_04_longsleeved.mdl",
        "models/player/icpd/cops/male_05_longsleeved.mdl",
        "models/player/icpd/cops/male_07_longsleeved.mdl",
        "models/player/icpd/cops/male_08_longsleeved.mdl",
		---------------------------------------
		----ПОЛИЦЕЙСКИЙ ДЕПАРТАМЕНТ Женские----
		---------------------------------------
        "models/player/icpd/cops/female_01_longsleeved.mdl",
        "models/player/icpd/cops/female_02_longsleeved.mdl",
        "models/player/icpd/cops/female_03_longsleeved.mdl",
        "models/player/icpd/cops/female_06_longsleeved.mdl",
        "models/player/icpd/cops/female_07_longsleeved.mdl",
    },
    
    
    description = [[Эта должность, наделенная особыми полномочиями, позволяющими ей поддерживать порядок, охранять спокойствие и мирную жизнь граждан во время апокалипсиса и по возможности предотвращать и раскрывать преступления… Он не может покидать территории полицейского департамента без разрешения Шерифа «Департамента Asheville»! Обязан работать на благо департамента: принимать заявления, защищать граждан, патрулировать местность и выполнять приказы Шерифа Округа. Зачастую обязуются следить за КПП департамента и отвечают за отстрел зараженных...]],
    weapons = {},
    kits = {
        [1] = { [INV_WEAPON] = {"weapon_handcuffer", "wep_jack_job_drpradio"}, },
        [2] = { [INV_WEAPON] = {"weapon_policebaton", "tfa_fas2_glock20",}, },
        [3] = { [INV_ENTITY] = {["tfa_ammo_pistol"] = 40}, },
        [4] = { [INV_ENTITY] = {["tfa_ammo_pistol"] = 80}, },
    },
    command = "pol1",
    max = 12,
    salary = 8,
    sortOrder = 1,
    admin = 0,
    category = "Полицейский департамент “Asheville”",
    vote = false,
    hasLicense = false,
    PlayerSpawn = function(ply)
        ply:SetBodygroup(1,0)
        ply:SetBodygroup(2,0) 
        ply:SetBodygroup(3,0) 
        ply:SetBodygroup(4,1) 
        ply:SetBodygroup(5,0) 
        ply:SetBodygroup(6,1) 
    end,
    type = "ubej",
    lvl = 14,
})



TEAM_POL2 = rp.addTeam("Парамедик «Департамента Asheville»", {
    color = Color(30, 144, 255, 255),
    model = {
        ---------------------------------------
		----ПОЛИЦЕЙСКИЙ ДЕПАРТАМЕНТ Мужские----
		---------------------------------------
        "models/player/gems_paramedic1/male_01.mdl",
        "models/player/gems_paramedic1/male_07.mdl",
        "models/player/gems_paramedic1/male_08.mdl",
        "models/player/gems_paramedic2/male_01.mdl",
        "models/player/gems_paramedic2/male_07.mdl",
        "models/player/gems_paramedic2/male_08.mdl",
		---------------------------------------
		----ПОЛИЦЕЙСКИЙ ДЕПАРТАМЕНТ Женские----
		---------------------------------------
        "models/player/gems_paramedic1/female_02.mdl",
        "models/player/gems_paramedic1/female_03.mdl",
        "models/player/gems_paramedic2/female_02.mdl",
        "models/player/gems_paramedic2/female_03.mdl",
    },


    description = [[Это специалист с медицинским образованием, работающий в департаменте города «Asheville» и обладающий навыками оказания экстренной медицинской помощи на дореанимационном этапе… Человек получивший настолько серьезную профессию дает клятву о том, что при любых обстоятельствах его главная задача – это спасти жизнь любому живому существу! Без надобности не желательно покидать департамент, а из-за очень скудного запаса медикаментов ему разрешено лечить исключительно своих сотрудников или тяжело раненных выживших, которые нуждаются в срочной госпитализации. Во всем остальном обязан слушать только лишь Шерифа «Департамента Asheville»…]],
    weapons = { },
    kits = {
        [1] = { [INV_WEAPON] = {"weapon_handcuffer", "wep_jack_job_drpradio", "wep_jack_job_drpstungun"}, },
        [2] = { [INV_WEAPON] = {"tfa_nmrih_etool", "fnfnp45", "fas2_ifak"}, },
        [3] = { [INV_ENTITY] = { ["tfa_ammo_pistol"] = 30, ["Bandages"] = 10 }, },
        [4] = { [INV_ENTITY] = { ["tfa_ammo_pistol"] = 80, ["Bandages"] = 15, ["Quikclots"] = 5, ["Hemostats"] = 2 }, },
    },
    command = "pol2",
    max = 3,
    salary = 14,
    sortOrder = 2,
    admin = 0,
    category = "Полицейский департамент “Asheville”",
    vote = false,
    hasLicense = false,
    type = "ubej",
    lvl = 18,
})


TEAM_POM111 = rp.addTeam("Повар «Департамента Asheville»'", {
    color = Color(188, 143, 143, 255),
    model = {
        "models/fearless/chef1.mdl",
    },

    description = [[Повар – это специалист нашего департамента, занимающийся приготовлением пищи… Он знает, как определить качество продуктов, как их правильно хранить, сочетать и готовить. Он не обязан готовить бесплатно полиции, но за продукты и малую материальную плату должен приготовить еду, ели при этом шериф не против. В свободное от работы в департаменте время может обосновать лавку и торговать неподалёку от участка едой или раздавать её бесплатно…]],
    weapons = { "tfa_nmrih_kknife", "wep_jack_job_drpradio"},
    command = "pol3",
    max = 1,
    salary = 6,
    sortOrder = 2,
    admin = 0,
    category = "Полицейский департамент “Asheville”",
    vote = false,
    hasLicense = false,
    type = "ubej",
    lvl = 10,
})


TEAM_POL3 = rp.addTeam("Сержант «Департамента Asheville»", {
    color = Color(100, 149, 237, 255),
    model = {
        ---------------------------------------
		----ПОЛИЦЕЙСКИЙ ДЕПАРТАМЕНТ Мужские----
		---------------------------------------
        "models/player/icpd/cops/male_01_longsleeved.mdl",
        "models/player/icpd/cops/male_02_longsleeved.mdl",
        "models/player/icpd/cops/male_03_longsleeved.mdl",
        "models/player/icpd/cops/male_04_longsleeved.mdl",
        "models/player/icpd/cops/male_05_longsleeved.mdl",
        "models/player/icpd/cops/male_07_longsleeved.mdl",
        "models/player/icpd/cops/male_08_longsleeved.mdl",
		---------------------------------------
		----ПОЛИЦЕЙСКИЙ ДЕПАРТАМЕНТ Женские----
		---------------------------------------
        "models/player/icpd/cops/female_01_longsleeved.mdl",
        "models/player/icpd/cops/female_02_longsleeved.mdl",
        "models/player/icpd/cops/female_03_longsleeved.mdl",
        "models/player/icpd/cops/female_06_longsleeved.mdl",
        "models/player/icpd/cops/female_07_longsleeved.mdl",
    },

    description = [[Обычно такого уровня достигают не все, но все же… Эта должность так же, наделенная особыми полномочиями, позволяющими ей поддерживать порядок, охранять спокойствие и мирную жизнь граждан, но, кроме этого, у неё есть дополнительные сверхналоженные обязанности. Сержанты контролируют деятельность офицеров, которые, в свою очередь, занимаются или расследованием различных преступлений или борются с заражёнными в свободное от работы время… Сержанты могут покидать департамент, но не должны забывать об основной своей работе, которая наложена на него обязанностями и шерифом округа…]],
    weapons = { },
    kits = {
        [1] = { [INV_WEAPON] = {"weapon_handcuffer", "wep_jack_job_drpradio", "wep_jack_job_drpstungun"}, },
        [2] = { [INV_WEAPON] = {"weapon_policebaton", "tfa_fas2_glock20", "tfa_ins2_m590o"}, },
        [3] = { [INV_ENTITY] = { ["tfa_ammo_pistol"] = 40, ["tfa_ammo_buckshot"]= 20 }, },
        [4] = { [INV_ENTITY] = { ["tfa_ammo_pistol"] = 80, ["tfa_ammo_buckshot"]= 50 }, },
    },
    command = "pol4",
    max = 8,
    salary = 16,
    sortOrder = 3,
    admin = 0,
    category = "Полицейский департамент “Asheville”",
    vote = false,
    hasLicense = false,
    PlayerSpawn = function(ply)
        ply:SetBodygroup(1,2)
        ply:SetBodygroup(2,2) 
        ply:SetBodygroup(3,0) 
        ply:SetBodygroup(4,1) 
        ply:SetBodygroup(5,0) 
        ply:SetBodygroup(6,2) 
    end,
    type = "ubej",
    lvl = 20,
})


TEAM_POL4 = rp.addTeam("Лейтенант «Департамента Asheville»", {
    color = Color(65, 105, 225, 255),
    model = {
        ---------------------------------------
		----ПОЛИЦЕЙСКИЙ ДЕПАРТАМЕНТ Мужские----
		---------------------------------------
        "models/player/icpd/cops/male_01_longsleeved.mdl",
        "models/player/icpd/cops/male_02_longsleeved.mdl",
        "models/player/icpd/cops/male_03_longsleeved.mdl",
        "models/player/icpd/cops/male_04_longsleeved.mdl",
        "models/player/icpd/cops/male_05_longsleeved.mdl",
        "models/player/icpd/cops/male_07_longsleeved.mdl",
        "models/player/icpd/cops/male_08_longsleeved.mdl",
		---------------------------------------
		----ПОЛИЦЕЙСКИЙ ДЕПАРТАМЕНТ Женские----
		---------------------------------------
        "models/player/icpd/cops/female_01_longsleeved.mdl",
        "models/player/icpd/cops/female_02_longsleeved.mdl",
        "models/player/icpd/cops/female_03_longsleeved.mdl",
        "models/player/icpd/cops/female_06_longsleeved.mdl",
        "models/player/icpd/cops/female_07_longsleeved.mdl",
    },

    description = [[Очень ответственная работа, даже для действующих сотрудников... Эта должность так же, наделенная особыми полномочиями, позволяющими ей поддерживать порядок, охранять спокойствие и мирную жизнь граждан, но, кроме этого, у неё есть дополнительные сверхналоженные обязанности. Лейтенанты исполняют роль заместителей шерифа, которые в его отсутствии держат департамент в ежовых рукавицах… Они полностью отвечают головой за свои действия и обязаны все свои действия обговаривать, с шерифом. Могут покидать департамент в любой момент, а также руководить сержантами, парамедиками и обычными офицерами…]],
    weapons = {  },
    kits = {
        [1] = { [INV_WEAPON] = {"weapon_handcuffer", "wep_jack_job_drpradio", "wep_jack_job_drpstungun"}, },
        [2] = { [INV_WEAPON] = {"weapon_policebaton", "tfa_fas2_glock20", "tfa_ins2_cw_ar15"}, },
        [3] = { [INV_ENTITY] = { ["tfa_ammo_pistol"] = 40,["tfa_ammo_ar2"]= 50 }, },
        [4] = { [INV_ENTITY] = { ["tfa_ammo_pistol"] = 80,["tfa_ammo_ar2"]= 80 }, },
    },
    command = "pol99",
    max = 2,
    salary = 20,
    subleader = true,
    sortOrder = 4,
    admin = 0,
    category = "Полицейский департамент “Asheville”",
    vote = false,
    hasLicense = false,
    PlayerSpawn = function(ply)
        ply:SetBodygroup(1,1)
        ply:SetBodygroup(2,2) 
        ply:SetBodygroup(3,0) 
        ply:SetBodygroup(4,1) 
        ply:SetBodygroup(5,0) 
        ply:SetBodygroup(6,3) 
    end,
    type = "ubej",
    lvl = 30,
})


TEAM_POL5 = rp.addTeam("Шериф «Департамента Asheville»", {
    color = Color(0, 0, 255, 255),
    model = {
        ---------------------------------------
		----ПОЛИЦЕЙСКИЙ ДЕПАРТАМЕНТ Мужские----
		---------------------------------------
        "models/player/gpd/sheriff_ancient/male_08.mdl",
        "models/player/gpd/sheriff_ancient/male_gta_01.mdl",
		---------------------------------------
		----ПОЛИЦЕЙСКИЙ ДЕПАРТАМЕНТ Женские----
		---------------------------------------
        "models/player/gpd/sheriff_ancient/female_01.mdl",
        "models/player/gpd/sheriff_ancient/female_gta_02.mdl",
    },

    description = [[На самом деле, шериф – это не звание полицейского, а выборная сердцем должность! Главные обязанности шерифа – это помощь полицейским: следить за порядком в департаменте, расследование нарушений и борьба с противостоящими группировками. Может контролировать все в департаменте, кроме отряда S.W.A.T, так как у них есть свой руководитель. Человек на такой должности уполномочен: объявлять войны, решать глобальные вопросы, руководить всем персоналом департамента и исполнять роль главного человека на территории департамента. Шериф по уставу не может выходить за пределы департамента без сопровождения хотя бы двух других вооруженных сотрудников, но есть исключения в случае побега или экстренной ситуации…]],
    weapons = { },
    kits = {
        [1] = { [INV_WEAPON] = {"weapon_handcuffer", "wep_jack_job_drpradio", "wep_jack_job_drpstungun"}, },
        [2] = { [INV_WEAPON] = {"weapon_policebaton", "tfa_ins2_mateba", "tfa_ins2_m1014", "tfa_ins_rgo_grenade_owo"}, },
        [3] = { [INV_ENTITY] = { ["tfa_ammo_357"] = 12,["tfa_ammo_buckshot"]= 7 }, },
        [4] = { [INV_ENTITY] = { ["tfa_ammo_357"] = 24,["tfa_ammo_buckshot"]= 21 }, },
    },
    command = "pol6",
    max = 1,
    salary = 50,
    leader = true,
    sortOrder = 5,
    admin = 0,
    category = "Полицейский департамент “Asheville”",
    vote = false,
    hasLicense = false,
    type = "ubej",
    lvl = 44,
})



TEAM_POL7 = rp.addTeam("Полицейская собака [VIP]", {
    color = Color(95, 158, 160, 255),
    model = {
        ---------------------------------------
		----ПОЛИЦЕЙСКИЙ ДЕПАРТАМЕНТ Мужские----
		---------------------------------------
        "models/falloutdog/falloutdog.mdl",
        "models/falloutdog/black/falloutdog.mdl",
        "models/falloutdog/greyblack/falloutdog.mdl",
    },

    description = [[Очень люблю животных! Это собака подразделения K-9… В её обязанности входит: задержание преступников, осмотр человека, поиск наркотиков и взрывчатки, атака заражённых, охрана объектов и послушание Кинолога! Так же у нее есть и другие способности, которым её обучает кинолог. Перенос грузов, раненых бойцов и выполнение трудных задач, которые не подвластны человеку. Во всём слушается Кинолога и выполняет приказы и работу четвероногого офицера, может отбиться от департамента и сбежать только в случае не надлежащего ухода, допустим долгого голодания или из-за недостатка внимания… Полностью отсутствуют страхи, так как была обучена работать даже в боевых условиях…]],
    weapons = { },
    command = "pol7",
    max = 8,
    salary = 1,
    sortOrder = 7,
    admin = 0,
    category = "Полицейский департамент “Asheville”",
    vote = false,
    hasLicense = false,
    donatejob = true,
    customCheck = function(ply) return ply:GetRank() == "Iventolog" or ply:IsPremium() or ply:IsSuperAdmin() or ply:IsSponsor() or ply:IsVIP() end,
    CustomCheckFailMsg = "Эта работа только для донатеров!",
    type = "ubej",
    lvl = 4,
})


TEAM_POL8 = rp.addTeam("Кинолог «Департамента» [VIP]", {
    color = Color(0, 128, 128, 255),
    model = {
        ---------------------------------------
		----ПОЛИЦЕЙСКИЙ ДЕПАРТАМЕНТ Мужские----
		---------------------------------------
        'models/player/odessa.mdl',
    },

    description = [[Должность кинолога, подразумевает работу по воспитанию и разведению щенков и взрослых собак департамента… Они отвечают за их полноценную и счастливую жизнь среди офицеров и департамента! Кинологи обязаны следить за их режимом дня, кормить, учить новым командам и в общем заботиться о животном. Изучайте их физиологию, особенности поведения собак и учитесь использовать навыки вашего четвероногого друга для извлечения пользы для человека. Вы слушаетесь всех офицеров департамента и в особенности шерифа. Обязаны заниматься собаками, отвечать за их распределение и обучать офицеров управлению ими…]],
    weapons = {  },
    kits = {
        [1] = { [INV_WEAPON] = {"weapon_handcuffer", "wep_jack_job_drpradio", "wep_jack_job_drpstungun"}, },
        [2] = { [INV_WEAPON] = {"wep_jack_job_drpstungun", "weapon_bfh_tec9"}, },
        [3] = { [INV_ENTITY] = { ["tfa_ammo_smg"] = 20 }, },
        [4] = { [INV_ENTITY] = { ["tfa_ammo_smg"] = 40 }, },
    },
    command = "pol8",
    max = 1,
    salary = 38,
    sortOrder = 8,
    admin = 0,
    category = "Полицейский департамент “Asheville”",
    vote = false,
    hasLicense = false,
    donatejob = true,
    customCheck = function(ply) return ply:GetRank() == "Iventolog" or ply:IsPremium() or ply:IsSuperAdmin() or ply:IsSponsor() end,
    CustomCheckFailMsg = "Эта работа только для донатеров!",
    type = "ubej",
    lvl = 10,
})


TEAM_POL6 = rp.addTeam("Боец «ХБ» [PREMIUM]", {
    color = Color(127, 255, 212, 255),
    model = {
        ---------------------------------------
        ----ПОЛИЦЕЙСКИЙ ДЕПАРТАМЕНТ Мужские----
        ---------------------------------------
        "models/humans/group03/chemsuit.mdl",
    },

    description = [[Работка только для образованных людей! Боец Химической Безопасности – это учёный или специалист, получивший образование и специализирующийся на изучении химии как науки, а также обладающий навыками работы с химикатами, а также немного разбирающийся во всей сфере биологии и медицины… Так как настоящих ученых в городе осталось совсем мыло, специалист этой группы очень важен для нашего департамента. В его обязанности входит: контролирование радиационной обстановки в городе, производство лекарств и другие виды деятельности обычных ученых… Вам разрешено покидать полицейский департамент и устраивать свои пункты лечения или исследования, только в сопровождении других Бойцов или любых вооруженных лиц, которые в дальнейшем обеспечат им охрану! Он не является частью полиции, но если хочет обитать в департаменте – должен подчиняться шерифу…]],
    weapons = { },
    kits = {
        [1] = { [INV_WEAPON] = { "weapon_handcuffer", "wep_jack_job_drpradio", "wep_jack_job_drpstungun", "rp_radiationdetector" }, },
        [2] = { [INV_WEAPON] = { "tfa_l4d2_talaxe", "tfa_ins2_mp5k_pdw" }, },
        [3] = { [INV_ENTITY] = { ["tfa_ammo_smg"] = 50, }, },
        [4] = { [INV_ENTITY] = { ["tfa_ammo_smg"] = 75, }, },
    },
    command = "pol6",
    max = 4,
    salary = 40,
    sortOrder = 6,
    admin = 0,
    category = "Полицейский департамент “Asheville”",
    vote = false,
    hasLicense = false,
    PlayerSpawn = function(ply)
        ply:SetSkin(math.random(1, 3))
    end,
    donatejob = true,
    type = "ubej",
    lvl = 15,
})


TEAM_POL9 = rp.addTeam("Сотрудник подразделения S.W.A.T [OCTOLORD]", {
    color = Color(192, 192, 192, 255),
    model = {
        ---------------------------------------
		----ПОЛИЦЕЙСКИЙ ДЕПАРТАМЕНТ Мужские----
		---------------------------------------
        'models/player/PMC_4/PMC__03.mdl',
		'models/player/PMC_4/PMC__05.mdl',
		'models/player/PMC_4/PMC__06.mdl',
		'models/player/PMC_4/PMC__07.mdl',
        'models/player/PMC_4/PMC__08.mdl',
		'models/player/PMC_4/PMC__09.mdl',
		'models/player/PMC_4/PMC__13.mdl',
		'models/player/PMC_4/PMC__14.mdl',
    },

    description = [[Сотрудник S.W.A.T – это сотрудник боевого подразделения специального назначения! Из-за секретной и экстремальной деятельности эти войска относятся к элитному классу и очень почитаемы в нашем департаменте… Боец S.W.A.T обязан беспрекословно подчиняться командованию, обеспечивать безопасности граждан, департамента и его правительственного аппарата. Могут выходить за пределы департамента только по разрешения оператора или если его нет на рабочем месте! Обязаны помогать полиции и постоянно быть на чеку, контролируя обстановку в городе. Если вы сотрудник S.W.A.T, то вы единственный человек, у которого здесь есть по-настоящему убойное оружие. Да, ресурсов мы для Вас не жалеем…]],
    weapons = {  },
    kits = {
        [1] = { [INV_WEAPON] = {"weapon_handcuffer", "wep_jack_job_drpradio", "weapon_rpw_binoculars_nvg"}, },
        [2] = { [INV_WEAPON] = {"weapon_policebaton", "tfa_ins2_m9", "tfa_ins2_mk18", "tfa_csgo_smoke", "tfa_csgo_flash", "deployable_shield"}, },
        [3] = { [INV_ENTITY] = { ["tfa_ammo_pistol"] = 40, ["tfa_ammo_ar2"] = 90 }, },
        [4] = { [INV_ENTITY] = { ["tfa_ammo_pistol"] = 80, ["tfa_ammo_ar2"] = 150 }, },
    },
    command = "pol9",
    max = 8,
    salary = 65,
    sortOrder = 9,
    admin = 0,
    category = "Полицейский департамент “Asheville”",
    vote = false,
    hasLicense = false,
    donatejob = true,
    customCheck = function(ply) return ply:GetRank() == "Iventolog" or ply:IsSuperAdmin() or ply:IsSponsor() end,
    CustomCheckFailMsg = "Эта работа только для донатеров!",
    type = "ubej",
    lvl = 18,
})


TEAM_POL77 = rp.addTeam("Оператор подразделения S.W.A.T [OCTOLORD]", {
    color = Color(128, 128, 128, 255),
    model = {
        ---------------------------------------
		----ПОЛИЦЕЙСКИЙ ДЕПАРТАМЕНТ Мужские----
		---------------------------------------
        'models/player/PMC_4/PMC__01.mdl',
    },

    description = [[Если Вы Оператор S.W.A.T, то Вам любая задача по плечу! Вы так же относитесь к элитному классу, но более того Вы им управляете… Вы абсолютно равны по правам и статусу с шерифом департамента, поэтому Вы можете принимать решения так же ответственно, как и он. В Ваши обязанности входит контролировать сотрудников подразделения и естественно занимается делами, которые входят в ваши возможности и обязанности. Старайтесь держать отношения с полицией и следите за порядком в городе, пока ученые и люди с энтузиазмом пытаются спасти мир…]],
    weapons = {  },
    kits = {
        [1] = { [INV_WEAPON] = {"weapon_handcuffer", "wep_jack_job_drpradio", "weapon_rpw_binoculars_nvg"}, },
        [2] = { [INV_WEAPON] = {"weapon_policebaton", "tfa_ins2_m9", "tfa_ins2_gol", "tfa_csgo_smoke", "tfa_csgo_flash", "deployable_shield"}, },
        [3] = { [INV_ENTITY] = { ["tfa_ammo_pistol"] = 50, ["tfa_ammo_ar1"] = 15 }, },
        [4] = { [INV_ENTITY] = { ["tfa_ammo_pistol"] = 100, ["tfa_ammo_ar1"] = 40 }, },
    },
    command = "pol9",
    max = 2,
    salary = 75,
    sortOrder = 9,
    admin = 0,
    category = "Полицейский департамент “Asheville”",
    vote = false,
    hasLicense = false,
    donatejob = true,
    customCheck = function(ply) return ply:GetRank() == "Iventolog" or ply:IsSuperAdmin() or ply:IsSponsor() end,
    CustomCheckFailMsg = "Эта работа только для донатеров!",
    type = "ubej",
    lvl = 22,
})
-------------------------------------------------------
-------------------------------------------------------
-------------------------------------------------------











































-------------------------------------------------------
---------------БАНДИТЫ ГОРОДА ASHEVILLE----------------
-------------------------------------------------------

TEAM_BAN1 = rp.addTeam("Шнырь 'Мародеров'", {
    color = Color(245, 222, 179, 255),
    model = {
        ---------------------------------------
		---------БАНДИТЫ ГОРОДА Мужские--------
		---------------------------------------
        'models/dizcordum/citizens/playermodels/pm_male_06.mdl',
        'models/dizcordum/citizens/playermodels/pm_male_05.mdl',
        'models/dizcordum/citizens/playermodels/pm_male_04.mdl',
        'models/dizcordum/citizens/playermodels/pm_male_03.mdl',
        'models/dizcordum/citizens/playermodels/pm_male_02.mdl',
        'models/dizcordum/citizens/playermodels/pm_male_01.mdl',
		---------------------------------------
		---------БАНДИТЫ ГОРОДА Женские--------
		---------------------------------------
        'models/dizcordum/citizens/playermodels/p_female_07.mdl',
        'models/dizcordum/citizens/playermodels/p_female_03.mdl',
        'models/dizcordum/citizens/playermodels/p_female_01.mdl',
    },

    description = [[Это самая тупая халявка нашей банды… Ха-ха. Обычно мы этих шестёрок пускаем под пули, но мы тоже люди. Задача Новитто служить нашему лидеру и отдаваться всем своим телом за нашу фракцию. Это глупое создание должно только уметь стрелять, бегать и грабить… Ему разрешается ходить и грабить одному если его отпустили или иных нагонов не поступало.]],
    weapons = {  },
    kits = {
        [1] = {"tfa_nmrih_crowbar"},
    },
    command = "ban1",
    max = 12,
    salary = 2,
    sortOrder = 1,
    admin = 0,
    category = "Бандиты города “Ashville”",
    vote = false,
    hasLicense = false,
    PlayerSpawn = function(ply)
        ply:SetBodygroup(1,0)
        ply:SetBodygroup(2,3) 
        ply:SetBodygroup(3,1) 
        ply:SetBodygroup(4,1) 
    end,
    type = "ubej",
    lvl = 9,
})


TEAM_POM222 = rp.addTeam("Похлебщик 'Мародеров'", {
    color = Color(218, 165, 32, 255),
    model = {
        ---------------------------------------
		---------БАНДИТЫ ГОРОДА Мужские--------
		---------------------------------------
        'models/player/clannysurvivors/male_02.mdl',
        'models/player/clannysurvivors/male_06.mdl',
    },

    description = [[ О-о да! Пожрать у Нас все любят... Похлебщики очень ценный ресурс, а особенно вечером под стаканчик пива. Самым важным для тебя становиться полный желудок таварища... Можешь ещё и поторговать где-то на стороне, когда будешь свободен от повседневной рутины и кормежки наших ребят!]],
    weapons = { "tfa_nmrih_hatchet", "wep_jack_job_drpradio"},
    command = "ban33",
    max = 2,
    salary = 4,
    sortOrder = 2,
    admin = 0,
    category = "Бандиты города “Ashville”",
    vote = false,
    hasLicense = false,
    PlayerSpawn = function(ply)
        ply:SetBodygroup(1,2)
        ply:SetBodygroup(2,5) 
        ply:SetBodygroup(4,1) 
    end,
    type = "ubej",
    lvl = 14,
})


TEAM_BAN2 = rp.addTeam("Бандит 'Мародеров'", {
    color = Color(210, 105, 30, 255),
    model = {
        ---------------------------------------
		---------БАНДИТЫ ГОРОДА Мужские--------
		---------------------------------------
        'models/asais10/maskrebel/actual_spec_ops_rebel_pm.mdl',
		'models/asais10/maskrebel/gasmask_rebel_pm.mdl',
		'models/asais10/maskrebel/spec_ops_rebel_pm.mdl',
    },

    description = [[Здесь работка уже чуть посложнее. Со склада уже выдается самый настоящий огнестрел. Но дает ли это толк? Конечно же нет, ведь люди с этим погонялом не могут банально решить простой математический пример. Действуют только лишь по приказу бывалых и не суются туда, куда им не нужно. Грабят уже намного увереннее, ведь в руках уже настоящий ствол!]],
    weapons = {},
    kits = {
        [1] = { [INV_WEAPON] = {"tfa_nmrih_lpipe"}, },
        [2] = { [INV_WEAPON] = {"tfa_ins2_pm"}, },
        [3] = { [INV_ENTITY] = { ["tfa_ammo_pistol"] = 30 }, },
        [4] = { [INV_ENTITY] = { ["tfa_ammo_pistol"] = 80 }, },
    },
    command = "ban2",
    max = 10,
    salary = 5,
    sortOrder = 2,
    admin = 0,
    category = "Бандиты города “Ashville”",
    vote = false,
    hasLicense = false,
    type = "ubej",
    lvl = 19,
})


TEAM_BAN3 = rp.addTeam("Комендант 'Мародеров'", {
    color = Color(160, 82, 45, 255),
    model = {
        ---------------------------------------
		---------БАНДИТЫ ГОРОДА Мужские--------
		---------------------------------------
        'models/csgobalkan1pm.mdl',
		'models/csgobalkan2pm.mdl',
		'models/csgobalkan3pm.mdl',
		'models/csgobalkan3pm.mdl',
    },

    description = [[Воу… Да ты поднялся, братик! Теперь ты уже можешь крушить черепа с еле работающим, но часто эффективным автоматом Калашникова. Знаешь, а ты не так уж и глуп, если дошел до этого уровня. Задача этой работенки заключается в грабеже и хоть какой никакой защите поселения. Так же можно воровать людей и вести работорговлю! Очень веселое занятие. Поверь мне…]],
    weapons = { "weapon_handcuffer", "wep_jack_job_drpradio", "tfa_ins2_akm_bw", "tfa_nmrih_bat" },
    kits = {
        [1] = { [INV_WEAPON] = {"weapon_handcuffer", "wep_jack_job_drpradio"}, },
        [2] = { [INV_WEAPON] = {"tfa_ins2_akm_bw", "tfa_nmrih_bat"}, },
        [3] = { [INV_ENTITY] = { ["AR2"] = 30 }, },
        [4] = { [INV_ENTITY] = { ["AR2"] = 60 }, },
    },
    command = "ban3",
    max = 4,
    salary = 8,
    sortOrder = 3,
    admin = 0,
    category = "Бандиты города “Ashville”",
    vote = false,
    hasLicense = false,
    type = "ubej",
    lvl = 30,
})


TEAM_BAN5 = rp.addTeam("Господин 'Биг-Эйшви'", {
    color = Color(165, 42, 42, 255),
    model = {
        ---------------------------------------
		---------БАНДИТЫ ГОРОДА Мужские--------
		---------------------------------------
        'models/players/mj_re3_mikhail.mdl',
    },

    description = [[Простите сэр, я даже не знал, что вы так далеко пойдете. Теперь вы очень значимый человек. Вся банда в вашем распоряжении. Вы можете объявлять воины, захватывать точки, организовывать вылазки и так далее. С вашей силой не сравнится не один человек в округе. Но все же выходить одному я бы вам не советовал. Берите в сопровождение себе всегда пару человек и никогда не воходите один без причины! Ваши возможности ограничиваются только вашими фантазиями…]],
    weapons = {  },
    kits = {
        [1] = { [INV_WEAPON] = {"weapon_handcuffer", "wep_jack_job_drpradio"}, },
        [2] = { [INV_WEAPON] = {"tfa_doublebarrel", "tfa_ins2_gurkha", "tfa_ins2_mr96"}, },
        [3] = { [INV_ENTITY] = { ["tfa_ammo_buckshot"] = 8, ["tfa_ammo_357"] = 30}, },
        [4] = { [INV_ENTITY] = { ["tfa_ammo_buckshot"] = 21, ["tfa_ammo_357"] = 80}, },
    },
    command = "ban5",
    max = 1,
    salary = 30,
    sortOrder = 5,
    admin = 0,
    leader = true,
    category = "Бандиты города “Ashville”",
    vote = false,
    hasLicense = false,
    type = "ubej",
    lvl = 60,
})


TEAM_BAN4 = rp.addTeam("Телескоп 'Мародеров'[VIP]", {
    color = Color(244, 164, 96, 255),
    model = {
        ---------------------------------------
        ---------БАНДИТЫ ГОРОДА Мужские--------
        ---------------------------------------
        'models/bala/anarcho_p/anarcho_pirate.mdl',
    },

    description = [[Слушай. Эта работа требует меткости. Ты точно хотел бы проверить свой лоб на прочность? Всем уже давно знакомый Lee Enfield будет твоим другом на всю оставшуюся жизнь… Твоя задача прикрывать союзников и, как ни странно, отыгрывать роль снайпера со своими братками. Грабить тебе, к сожалению, нельзя. Опасно для твоего здоровья. Ты очень хрупкий. Будь аккуратен…]],
    weapons = { },
    kits = {
        [1] = { [INV_WEAPON] = {"weapon_handcuffer", "wep_jack_job_drpradio"}, },
        [2] = { [INV_WEAPON] = {"tfa_fml_dabrits_lil_enfield", "tfa_nmrih_hatchet"}, },
        [3] = { [INV_ENTITY] = { ["SniperPenetratedRound"] = 10 }, },
        [4] = { [INV_ENTITY] = { ["SniperPenetratedRound"] = 30 }, },
    },
    command = "ban4",
    max = 4,
    salary = 10,
    sortOrder = 4,
    admin = 0,
    category = "Бандиты города “Ashville”",
    vote = false,
    hasLicense = false,
    PlayerSpawn = function(ply)
        ply:SetSkin(math.random(0, 4))
        ply:SetBodygroup(1,1)
    end,
    donatejob = true,
    customCheck = function(ply) return ply:GetRank() == "Iventolog" or ply:IsPremium() or ply:IsSuperAdmin() or ply:IsSponsor() or ply:IsVIP() end,
    CustomCheckFailMsg = "Эта работа только для донатеров!",
    type = "ubej",
    lvl = 16,
})


TEAM_BAN6 = rp.addTeam("Мистер 'Лока' [PREMIUM]", {
    color = Color(255, 165, 0, 255),
    model = {
        ---------------------------------------
		---------БАНДИТЫ ГОРОДА Мужские--------
		---------------------------------------
        'models/player/tfa_trent_cleaner_grenadier.mdl',
    },

    description = [[Это очень интересная работёнка. Если ты когда-нибудь нюхал клей, то ты понимаешь, о чем я... Тебе нужно изучить пару инструкций и готовить для нас целебные травы и не только. Есть очень много веществ, которые помогли бы нам в бою. Твоя задача сделать их и обеспечить нашу группировку. Работа не пыльная, с учетом того, что полиции сейчас точно не до нас. Ты можешь участвовать в защите нашей территории, но на вылазки тебе с нами нельзя. Слишком ты полезный для какой-нибудь нелепой смерти…]],
    weapons = { },
    kits = {
        [1] = { [INV_WEAPON] = {"weapon_handcuffer", "wep_jack_job_drpradio", "weapon_rpw_binoculars"}, },
        [2] = { [INV_WEAPON] = {"tfa_ins2_gsh18"}, },
        [3] = { [INV_ENTITY] = { ["tfa_ammo_pistol"] = 30}, },
        [4] = { [INV_ENTITY] = { ["tfa_ammo_pistol"] = 80}, },
    },
    command = "ban6",
    max = 2,
    salary = 18,
    sortOrder = 6,
    admin = 0,
    category = "Бандиты города “Ashville”",
    vote = false,
    hasLicense = false,
    PlayerSpawn = function(ply)
        ply:SetBodygroup(5,1)
    end,
    donatejob = true,
    customCheck = function(ply) return ply:GetRank() == "Iventolog" or ply:IsPremium() or ply:IsSuperAdmin() or ply:IsSponsor() end,
    CustomCheckFailMsg = "Эта работа только для донатеров!",
    type = "ubej",
    lvl = 18,
})


TEAM_BAN7 = rp.addTeam("Наемник [SPONSOR]", {
    color = Color(75, 0, 130, 255),
    model = {
        ---------------------------------------
        ---------Поместье Блейк Мужские--------
        ---------------------------------------
        'models/mfc_new.mdl',
    },

    description = [[]],
    weapons = { "weapon_handcuffer", "wep_jack_job_drpradio", "tfa_ins2_gurkha", "tfa_ins2_imi_uzi", "tfa_ins2_gsh18" },
    command = "pom775",
    max = 3,
    salary = 10,
    sortOrder = 7,
    admin = 0,
    category = "Бандиты города “Ashville”",
    vote = false,
    hasLicense = false,
    donatejob = true,
    PlayerLoadout = function(ply)
        ply:GiveAmmo( 80, 'Pistol', true )
        ply:GiveAmmo( 90, 'smg1', true )
    end,
    customCheck = function(ply) return ply:GetRank() == "Iventolog" or ply:IsSuperAdmin() or ply:IsSponsor() end,
    CustomCheckFailMsg = "Эта работа только для донатеров!",
    type = "ubej",
    lvl = 12,
})


TEAM_BAN8 = rp.addTeam("Скала 'Тагилла' [OCTOLORD]", {
    color = Color(184, 134, 11, 255),
    model = {
        ---------------------------------------
		---------БАНДИТЫ ГОРОДА Мужские--------
		---------------------------------------
        'models/player/eft/tagilla/eft_tagilla/models/eft_tagilla_pm.mdl',
    },

    description = [[Если ты сможешь съесть целую и сырую свинью, то тебе нужно работать нашим громилой. У этой халтурки очень приличные плюшки. Хорошая броня, неплохое оружие, а самое главное интересная работа. Тебе можно не только грабить людей, но и сопровождать главу как его телохранитель. Естественно, это не останется не оплаченным. Твоя задача исполнять роль Джаггернаута и слушаться Биг “Эйшви” … Ты единственный, кто может из себя что-то представить.]],
    weapons = {  },
    kits = {
        [1] = { [INV_WEAPON] = {"weapon_handcuffer", "wep_jack_job_drpradio"}, },
        [2] = { [INV_WEAPON] = {"tfa_ins2_sks", "tfa_ararebo_bf1"}, },
        [3] = { [INV_ENTITY] = { ["AR2"] = 20}, },
        [4] = { [INV_ENTITY] = { ["AR2"] = 60}, },
    },
    command = "ban7",
    max = 2,
    salary = 28,
    sortOrder = 7,
    admin = 0,
    category = "Бандиты города “Ashville”",
    vote = false,
    donatejob = true,
    hasLicense = false,
    PlayerSpawn = function(ply)
        ply:SetBodygroup(1,0)
        ply:SetBodygroup(2,0) 
        ply:SetBodygroup(3,1) 
    end,
    customCheck = function(ply) return ply:GetRank() == "Iventolog" or ply:IsSuperAdmin() or ply:IsSponsor() end,
    CustomCheckFailMsg = "Эта работа только для донатеров!",
    type = "ubej",
    lvl = 20,
})
-------------------------------------------------------
-------------------------------------------------------
-------------------------------------------------------





































-------------------------------------------------------
-------------Поместье "Блэйк" Округа “Asheville”-----------
-------------------------------------------------------

TEAM_POM1 = rp.addTeam("Сторож 'Блэйк'", {
    color = Color(128, 128, 0, 255),
    model = {
        ---------------------------------------
		---------Поместье Блейк Мужские--------
		---------------------------------------
        'models/player/missinginfo_male_02.mdl',
		'models/player/missinginfo_male_01.mdl',
		'models/player/missinginfo_male_03.mdl',
		'models/player/missinginfo_male_04.mdl',
		'models/player/missinginfo_male_05.mdl',
		'models/player/missinginfo_male_06.mdl',
		'models/player/missinginfo_male_08.mdl',
		---------------------------------------
		---------Поместье Блейк Женские--------
		---------------------------------------
        'models/player/missinginfo_female_01.mdl',
		'models/player/missinginfo_female_02.mdl',
		'models/player/missinginfo_female_03.mdl',
		'models/player/missinginfo_female_07.mdl',
    },

    description = [[Сторож... Довольно легкая, но очень важная для поместья работа. На нем лежит самая важная задача "Убежища" - защищать. Ему нельзя покидать территорию базы ни при каких обстоятельствах. Довольно часто нужно делать обходы и охранять вход в поместье. Естественно подчиняться Главе "Блэйка"...]],
    weapons = {  },
    kits = {
        [1] = {
            [INV_WEAPON] = { "weapon_handcuffer", "wep_jack_job_drpradio"},
        },
        [2] = {
            [INV_ENTITY] = {["flashlight"] = 1,},
            [INV_WEAPON] = {"rust_nailgun", "tfa_nmrih_lpipe"},
        },
        [3] = {
            [INV_ENTITY] = {["tfa_ammo_smg"] = 45, ["ent_battery"] = 1, },
        },
        [4] = {
            [INV_ENTITY] = {["tfa_ammo_smg"] = 80, ["ent_battery"] = 2, }, 
        },
    },
    command = "pom1",
    max = 10,
    salary = 5,
    sortOrder = 1,
    admin = 0,
    category = "Поместье “Блэйк” Округа “Asheville”",
    vote = false,
    hasLicense = false,
    PlayerSpawn = function(ply)
    	ply:SetSkin(math.random(1, 9))
        ply:SetBodygroup(1,0)
    end,
    type = "ubej",
    lvl = 7,
})


TEAM_POM2 = rp.addTeam("Фермер 'Блэйк'", {
    color = Color(127, 255, 0, 255),
    model = {
        ---------------------------------------
		---------Поместье Блейк Мужские--------
		---------------------------------------
        'models/sal/farmer_01.mdl',
		'models/sal/farmer_02.mdl',
		'models/sal/farmer_03.mdl',
		'models/sal/farmer_04.mdl',
		'models/sal/farmer_05.mdl',
		'models/sal/farmer_06.mdl',
		'models/sal/farmer_07.mdl',
		'models/sal/farmer_08.mdl',
		'models/sal/farmer_09.mdl',
    },

    description = [[Кормилец нашего родного дома. Если ты часто проводил время на даче и знаешь как обращаться с растениями, то эта работа не доставит хлопот... Покидать поместье фермеру запрещено без разрешения Главы. Может продавать свои плоды за небольшую сумму денег и располагать свои грядки на территории огорода. Очень интересная и умиротворенная работка...]],
    weapons = {  },
    kits = {
        [1] = {
            [INV_WEAPON] = { "wep_jack_job_drpradio", },
        },
        [2] = {
            [INV_WEAPON] = {"tfa_nmrih_spade"},
        },
        [3] = {
        },
        [4] = {
        },
    },
    command = "pom2",
    max = 6,
    salary = 6,
    sortOrder = 2,
    admin = 0,
    category = "Поместье “Блэйк” Округа “Asheville”",
    vote = false,
    hasLicense = false,
    type = "ubej",
    lvl = 12,
})


TEAM_POM3 = rp.addTeam("Повар 'Блэйк'", {
    color = Color(210, 105, 30, 255),
    model = {
        ---------------------------------------
		---------Поместье Блейк Мужские--------
		---------------------------------------
        'models/fearless/chef3.mdl',
		---------------------------------------
		---------Поместье Блейк Женские--------
		---------------------------------------
        'models/fearless/chef2.mdl',
    },

    description = [[ Поварёшки... Если бы они халявили, то мы загнулись бы через неделю от желания пожрать и выпить холодный грибочник. Ихние руки и знания кормят выживших и сотрудников нашего столь благопочтенного убежища. Ха-ха.... Скупайте ингредиенты, у выживших и у фермеров. И помните, что только вы можете готовить нормальную, здоровую пищу и конечно, без сомнения, брать себе что-то в карман...]],
    weapons = { },
    kits = {
        [1] = {
            [INV_WEAPON] = { "wep_jack_job_drpradio", },
        },
        [2] = {
            [INV_WEAPON] = {"tfa_nmrih_cleaver"},
        },
        [3] = {
        },
        [4] = {
        },
    },
    command = "pom33",
    max = 2,
    salary = 4,
    sortOrder = 2,
    admin = 0,
    category = "Поместье “Блэйк” Округа “Asheville”",
    vote = false,
    hasLicense = false,
    type = "ubej",
    lvl = 16,
})


TEAM_POM4 = rp.addTeam("Боец 'Блэйк'", {
    color = Color(0, 100, 0, 255),
    model = {
        ---------------------------------------
		---------Поместье Блейк Мужские--------
		---------------------------------------
        'models/player/rusty/natguard/male_01.mdl',
		'models/player/rusty/natguard/male_02.mdl',
		'models/player/rusty/natguard/male_03.mdl',
		'models/player/rusty/natguard/male_04.mdl',
		'models/player/rusty/natguard/male_05.mdl',
		'models/player/rusty/natguard/male_06.mdl',
		'models/player/rusty/natguard/male_07.mdl',
		'models/player/rusty/natguard/male_08.mdl',
		'models/player/rusty/natguard/male_09.mdl',
    },

    description = [[Боевая единица нашего поместья! Сильно физически подготовлен и прилично вооружен... Его задача заключается в защите "Блэйк" и в участии разных родов вылазок или рейдов. Может покидать убежище, но в любое время обязан сорваться и отдать долг поместью!]],
    weapons = {  },
    kits = {
        [1] = {
            [INV_WEAPON] = { "weapon_handcuffer", "wep_jack_job_drpradio", "weapon_rpw_binoculars_explorer"},
        },
        [2] = {
            [INV_WEAPON] = {"rust_sar", "tfa_ins2_p320", "tfa_ins2_kabar"},
        },
        [3] = {
            [INV_ENTITY] = {["tfa_ammo_pistol"] = 20, ["tfa_ammo_ar2"] = 16},
        },
        [4] = {
            [INV_ENTITY] = {["tfa_ammo_pistol"] = 60, ["tfa_ammo_ar2"] = 28}, 
        },
    },
    command = "pom3",
    max = 12,
    salary = 12,
    sortOrder = 3,
    admin = 0,
    category = "Поместье “Блэйк” Округа “Asheville”",
    vote = false,
    hasLicense = false,
    PlayerSpawn = function(ply)
        ply:SetBodygroup(1,0)
        ply:SetBodygroup(2,0)
    end,
    type = "ubej",
    lvl = 22,
})


TEAM_POM5 = rp.addTeam("Лекарь 'Блэйк'", {
    color = Color(46, 139, 87, 255),
    model = {
        ---------------------------------------
		---------Поместье Блейк Мужские--------
		---------------------------------------
        'models/player/missinginfo_male_02.mdl',
		'models/player/missinginfo_male_01.mdl',
		'models/player/missinginfo_male_03.mdl',
		'models/player/missinginfo_male_04.mdl',
		'models/player/missinginfo_male_05.mdl',
		'models/player/missinginfo_male_06.mdl',
		'models/player/missinginfo_male_08.mdl',
		---------------------------------------
		---------Поместье Блейк Женские--------
		---------------------------------------
        'models/player/missinginfo_female_01.mdl',
		'models/player/missinginfo_female_02.mdl',
		'models/player/missinginfo_female_03.mdl',
		'models/player/missinginfo_female_07.mdl',
    },

    description = [[У каждого бывают проблемы со здоровьем, но не каждый может их решить. Если у вас есть опыт в медицине или вы просто разбирающийся человек, то эта форма вам не только к лицу. Лекари отдают все свои силы, что бы обеспечить безопасность окружающим их людям. За счет множественных запасов, медики "Блэйк" могут оказать помощь любому нуждающемуся. Так же им можно отправляться на вылазки и выходить из поместья по приказу или разрешению...]],
    weapons = {  },
    kits = {
        [1] = {
            [INV_WEAPON] = { "wep_jack_job_drpradio"},
        },
        [2] = {
            [INV_WEAPON] = {"tfa_nmrih_kknife", "weapon_bfh_tec9", "fas2_ifak"},
        },
        [3] = {
            [INV_ENTITY] = {["tfa_ammo_pistol"] = 30, ["Bandages"] = 10},
        },
        [4] = {
            [INV_ENTITY] = {["tfa_ammo_pistol"] = 80, ["Bandages"] = 15, ["Quikclots"] = 5, ["Hemostats"] = 2}, 
        },
    },
    command = "pom4",
    max = 4,
    salary = 10,
    sortOrder = 4,
    admin = 0,
    category = "Поместье “Блэйк” Округа “Asheville”",
    vote = false,
    hasLicense = false,
    PlayerSpawn = function(ply)
    	ply:SetSkin(math.random(1, 9))
        ply:SetBodygroup(1,1)
    end,
    type = "ubej",
    lvl = 28,
})


TEAM_POM6 = rp.addTeam("Смотритель 'Блэйк'", {
    color = Color(102, 205, 170, 255),
    model = {
        ---------------------------------------
		---------Поместье Блейк Мужские--------
		---------------------------------------
        'models/players/mj_dbd_adam.mdl',
    },

    description = [[Это не такая уж и простая работа, как порой кажется. Смотритель, кроме своих функций наблюдателя выполняет еще и роли управленца и военачальника. Может управлять сотрудниками, которые ниже его по иерархии и руководить поместьем в отсутствии его хозяина. Одному покидать территорию запрещено. Вести переговоры с другими группировками может в исключительно редких случаях...]],
    weapons = {  },
    kits = {
        [1] = {
            [INV_WEAPON] = { "wep_jack_job_drpradio", "weapon_handcuffer"},
        },
        [2] = {
            [INV_WEAPON] = {"tfa_nmrih_fireaxe", "tfa_ww2_karabin1938", "tfa_ins2_pm"},
        },
        [3] = {
            [INV_ENTITY] = {["tfa_ammo_pistol"] = 30, ["tfa_ammo_ar2"] = 20},
        },
        [4] = {
            [INV_ENTITY] = {["tfa_ammo_pistol"] = 80, ["tfa_ammo_ar2"] = 60}, 
        },
    },
    command = "pom5",
    max = 1,
    salary = 20,
    sortOrder = 5,
    admin = 0,
    subleader = true,
    category = "Поместье “Блэйк” Округа “Asheville”",
    vote = false,
    hasLicense = false,
    PlayerSpawn = function(ply)
        ply:SetBodygroup(1,1)
        ply:SetBodygroup(2,1)
        ply:SetBodygroup(3,1)
        ply:SetBodygroup(4,1)
    end,
    type = "ubej",
    lvl = 34,
})


TEAM_POM7 = rp.addTeam("Глава поместья 'Блэйк'", {
    color = Color(0, 128, 128, 255),
    model = {
        ---------------------------------------
		---------Поместье Блейк Мужские--------
		---------------------------------------
        'models/players/mj_dbd_bill.mdl',
    },

    description = [[Чем больше дом, тем сложнее следить за ним. Это выражение, точно не про Главу поместья. Тотальный контроль над происходящим, активное участие во всех делах не смотря на свой преклонный возраст - это про нашего управленца. Ему нельзя выходить одному за пределы. В его сопровождении обязательно должно быть хотя бы три человека. Всем, что происходит на территории "Блэйка" управляет он. Глава обязуется всегда заботиться о нуждающихся!]],
    weapons = {  },
    kits = {
        [1] = {
            [INV_WEAPON] = {"wep_jack_job_drpradio", "weapon_handcuffer", "weapon_rpw_binoculars_explorer"},
        },
        [2] = {
            [INV_WEAPON] = {"tfa_xiandagger", "tfa_ins2_mr96", "rust_thompson"},
        },
        [3] = {
            [INV_ENTITY] = {["tfa_ammo_pistol"] = 30, ["tfa_ammo_357"] = 30},
        },
        [4] = {
            [INV_ENTITY] = {["tfa_ammo_pistol"] = 90, ["tfa_ammo_357"] = 80}, 
        },
    },
    command = "pom6",
    max = 1,
    salary = 28,
    sortOrder = 6,
    admin = 0,
    leader = true,
    category = "Поместье “Блэйк” Округа “Asheville”",
    vote = false,
    hasLicense = false,
    PlayerSpawn = function(ply)
        ply:SetBodygroup(1,0)
    end,
    type = "ubej",
    lvl = 50,
})


TEAM_POM334 = rp.addTeam("Рыбак 'Блэйк' [VIP]", {
    color = Color(160, 82, 45, 255),
    model = {
        ---------------------------------------
		---------Поместье Блейк Мужские--------
		---------------------------------------
        'models/player/missinginfo_male_02.mdl',
		'models/player/missinginfo_male_01.mdl',
		'models/player/missinginfo_male_03.mdl',
		'models/player/missinginfo_male_04.mdl',
		'models/player/missinginfo_male_05.mdl',
		'models/player/missinginfo_male_06.mdl',
		'models/player/missinginfo_male_08.mdl',
		---------------------------------------
		---------Поместье Блейк Женские--------
		---------------------------------------
        'models/player/missinginfo_female_01.mdl',
		'models/player/missinginfo_female_02.mdl',
		'models/player/missinginfo_female_03.mdl',
		'models/player/missinginfo_female_07.mdl',
    },

    description = [[ Кхм... Можем дать удочку! Рыболов - это человек, промышляющий рыболовством, рыбалкой или рыбной ловлей. Рыбак является одним из наиболее древних занятий человечества, уходящим в эпоху охоты и собирательства... Очень важно понимать, что это одно из важнейших занятий в нашем убежище! Ловите рыбу, готовьте её или продавайте... ]],
    weapons = { "st_fishingrod", },
    kits = {
        [1] = {
            [INV_WEAPON] = {"tfa_nmrih_spade", "st_fishingrod", "guitar_sad"},
        },
    },
    command = "pom334",
    max = 6,
    salary = 4,
    sortOrder = 2,
    admin = 0,
    category = "Поместье “Блэйк” Округа “Asheville”",
    vote = false,
    hasLicense = false,
    donatejob = true,
    PlayerSpawn = function(ply)
        ply:SetSkin(math.random(1, 9))
        ply:SetBodygroup(1, 2)
    end,
    type = "ubej",
    lvl = 6,
})


TEAM_POM8 = rp.addTeam("Баллистик 'Блэйк' [PREMIUM]", {
    color = Color(105, 105, 105, 255),
    model = {
        ---------------------------------------
		---------Поместье Блейк Мужские--------
		---------------------------------------
        'models/humans/personalrebels/pm_suitmale_06.mdl',
        'models/humans/personalrebels/pm_suitmale_01.mdl',
		---------------------------------------
		---------Поместье Блейк Женские--------
		---------------------------------------
        'models/humans/personalrebels/pm_suitfemale_06.mdl',
        'models/humans/personalrebels/pm_suitfemale_01.mdl',
    },

    description = [[Оружие не дешевое удовольствие с учетом нынешних обстоятельств. Однако, если вы хотите жить, вам нужно иметь огнестрел. В этой работе есть некоторые сложности, если вы не механик или не оружейник. Однако ваша задача чинить оружие и продавать его другим людям. Естественно для этого нужны материалы и средства, которые вы можете выкупить у выживших или добыть сами. За счет ваших способностей вы сможете собирать оружие выжившим в 2 раза дешевле и чинить его используя меньшее количество материалов чем делают это любители. Так же вы сможете чинить бронежилеты и тому подобное...]],
    weapons = {  },
    kits = {
        [1] = {
            [INV_WEAPON] = {"tfa_nmrih_wrench",},
        },
        [2] = {
            [INV_WEAPON] = {"tfa_rustalpha_revolver"},
        },
        [3] = {
            [INV_ENTITY] = {["tfa_ammo_357"] = 30},
        },
        [4] = {
            [INV_ENTITY] = {["tfa_ammo_357"] = 80}, 
        },
    },
    command = "pom78",
    max = 2,
    salary = 6,
    sortOrder = 7,
    admin = 0,
    category = "Поместье “Блэйк” Округа “Asheville”",
    vote = false,
    hasLicense = false,
    PlayerSpawn = function(ply)
        ply:SetBodygroup(3,4)
        ply:SetBodygroup(4,0)
    end,
    donatejob = true,
    customCheck = function(ply) return ply:GetRank() == "Iventolog" or ply:IsSuperAdmin() or ply:IsSponsor() end,
    CustomCheckFailMsg = "Эта работа только для донатеров!",
    type = "ubej",
    lvl = 15,
})


TEAM_POM9 = rp.addTeam("Наемник [SPONSOR]", {
    color = Color(75, 0, 130, 255),
    model = {
        ---------------------------------------
		---------Поместье Блейк Мужские--------
		---------------------------------------
        'models/mfc_new.mdl',
    },

    description = [[На самом деле эта работа не из нашего поместья. Нам платят много денег, что бы мы давали эту форму и вооружение. Насколько мне помнится, основная их задача - это выполнять какой либо заказ человека за определенную сумму денег. Принести что-то, провести кого-то, а возможно даже и убийство... Он волен делать, что хочет. Человек просто у нас проживает и нечего более. Честно сказать, иногда нас напрягает такой расклад, но пока это не трогает наше убежище и приносит только пользу...]],
    weapons = { "weapon_handcuffer", "wep_jack_job_drpradio", "tfa_ins2_gurkha", "tfa_ins2_imi_uzi", "tfa_ins2_gsh18" },
    command = "pom77",
    max = 3,
    salary = 10,
    sortOrder = 7,
    admin = 0,
    category = "Поместье “Блэйк” Округа “Asheville”",
    vote = false,
    hasLicense = false,
    donatejob = true,
    PlayerLoadout = function(ply)
        ply:GiveAmmo( 80, 'Pistol', true )
        ply:GiveAmmo( 90, 'smg1', true )
    end,
    customCheck = function(ply) return ply:GetRank() == "Iventolog" or ply:IsSuperAdmin() or ply:IsSponsor() end,
    CustomCheckFailMsg = "Эта работа только для донатеров!",
    type = "ubej",
    lvl = 12,
})


TEAM_POM10 = rp.addTeam("Шофер 'Блэйк' [OCTOLORD]", {
    color = Color(143, 188, 143, 255),
    model = {
        ---------------------------------------
		---------Поместье Блейк Мужские--------
		---------------------------------------
        'models/players/mj_re2_kendo.mdl',
    },

    description = [[Я всегда завидовал этой работе... Единственный человек, который имеет личную работу в поместье. Если вы занимаете данную должность, то вы получаете: Старый разваленный Минивэн, особенный набор для качественного ремонта транспорта, определенное количество топлива за счет убежища. Тратить ресурсы понапрасну нельзя. Ездить можно лишь только по разрешению главы поместья или при острой необходимости. Обслуживание машины за Ваш счет...]],
    weapons = {  },
    kits = {
        [1] = {
            [INV_WEAPON] = {"wep_jack_job_drpradio",},
        },
        [2] = {
            [INV_WEAPON] = {"tfa_rustalpha_pipeshotgun", "tfa_nmrih_crowbar"},
        },
        [3] = {
            [INV_ENTITY] = {["tfa_ammo_buckshot"] = 8},
        },
        [4] = {
            [INV_ENTITY] = {["tfa_ammo_buckshot"] = 21}, 
        },
    },
    command = "pom79",
    max = 1,
    salary = 12,
    sortOrder = 7,
    admin = 0,
    category = "Поместье “Блэйк” Округа “Asheville”",
    vote = false,
    hasLicense = false,
    donatejob = true,
    customCheck = function(ply) return ply:GetRank() == "Iventolog" or ply:IsSuperAdmin() or ply:IsSponsor() end,
    CustomCheckFailMsg = "Эта работа только для донатеров!",
    type = "ubej",
    lvl = 10,
})
-------------------------------------------------------
-------------------------------------------------------
-------------------------------------------------------




































-------------------------------------------------------
------------------------Легион-------------------------
-------------------------------------------------------

TEAM_LEG1 = rp.addTeam("Адепт", {
    color = Color(80, 163, 41, 255),
    model = {
        "models/players/mj_dbd_kk.mdl",
        "models/players/mj_dbd_kk_joey.mdl",
        "models/players/mj_dbd_kk_julie.mdl",
        "models/players/mj_dbd_kk_susie.mdl",
    },
    description = [[*Тяжелое дыхание* Ты захотел стать одним из нас-с? Будешь адептом и говорить не о чем. *Вздох* Твоя задача убивать... Не покидай пещеру - это твой родной дом... После заражения ты станешь очень глупым, но сильным...]],
    weapons = { "tfa_nmrih_kknife", "weapon_handcuffer"},
    command = "leg1",
    max = 6,
    salary = 12,
    sortOrder = 1,
    admin = 0,
    category = "Легион",
    vote = false,
    hasLicense = false,
    lvl = 17,
})


TEAM_LEG2 = rp.addTeam("Стрелок 'Легиона'", {
    color = Color(80, 163, 41, 255),
    model = {
        "models/splinks/kf2/characters/player_djskully.mdl",
    },
    description = [[*Тяжелое рычание* Смотрю ты мутировал... Хвыр-хвыр... Ты очень поменялся и даже не только видом. Думаю ты не забыл как пользоваться оружием. Смотри мне. Постарайся не лишиться конечностей. Выходи только по разрешению нашего Ли-и-идера]],
    weapons = { "tfa_ins2_mr96", "tfa_ins2_kabar", "weapon_handcuffer", "wep_jack_job_drpradio" },
    command = "leg2",
    max = 4,
    salary = 22,
    sortOrder = 2,
    admin = 0,
    category = "Легион",
    vote = false,
    hasLicense = false,
    PlayerLoadout = function(ply)
    	ply:GiveAmmo( 30, 'tfa_ammo_357', true )
	end,
    lvl = 30,
})


TEAM_LEG3 = rp.addTeam("Ночной охотник", {
    color = Color(80, 163, 41, 255),
    model = {
        "models/bala/monsterboys_pm.mdl",
    },
    description = [[Оо-рх... На этой стадии ты сможешь выходить на улицу в ночное время и действовать под покровом темного полотна... Однако каким бы темным он *кхъ* не было ты будешь очень ярки. Тебе дадут "Солнечную" смесь для того что-бы ты защищал легион. Ночью ты будешь ярче солнца... На прогулку можно выходить тебе только ночью.]],
    weapons = { "tfa_xiandagger", "weapon_rpw_binoculars_nvg", "tfa_rustalpha_hunting_bow", "weapon_handcuffer", "wep_jack_job_drpradio",},
    command = "leg3",
    max = 3,
    salary = 40,
    sortOrder = 3,
    admin = 0,
    category = "Легион",
    vote = false,
    hasLicense = false,
    PlayerLoadout = function(ply)
    	ply:GiveAmmo( 40, 'tfbow_arrow', true )
	end,
    lvl = 33,
})


TEAM_LEG4 = rp.addTeam("Лидер 'Легиона'", {
    color = Color(80, 163, 41, 255),
    model = {
        "models/player/tfa_trent_cleaner_boss.mdl",
    },
    description = [[Феникс-с... Вас обычно так называют за глаза. Вы конечно и без меня знаете ваши задачи, но все же... Вам нужно руководить Легионом и принимать большинство решений. Кто-то должен вести все это тупое стадо... *Резкий Ревк* Надеюсь вы не захотите выйти один. Старайтесь держаться с группой...]],
    weapons = { "tfa_nmrih_fubar", "weapon_handcuffer", "tfa_ins2_rpk_74m", "wep_jack_job_drpradio"},
    command = "leg4",
    max = 1,
    salary = 70,
    sortOrder = 4,
    leader = true,
    admin = 0,
    category = "Легион",
    vote = false,
    hasLicense = false,
    PlayerLoadout = function(ply)
    	ply:GiveAmmo( 60, 'AR2', true )
	end,
    lvl = 55,
})


TEAM_LEG5 = rp.addTeam("Безымянный [VIP]", {
    color = Color(80, 163, 41, 255),
    model = {
        "models/models/konnie/jasonpart2/jasonpart2.mdl",
    },
    description = [[Ооо-брфх. Какой же ты все таки урод... Даже по нашим меркам ты выглядишь ужасно. Но к счастью, кроме твоего глаза тебе ничего и не нужно. Ты будешь вооружен вот этим лу... Все равно не поймешь. Твоя задача оберегать союзников и метко стрелять в противников. Покидать Легион ты можешь в любое время, но Лидера слушаться обязательно!]],
    weapons = { "tfa_nmrih_machete", "tfa_rustalpha_bolt_action_rifle", "tfa_rustalpha_revolver", "wep_jack_job_drpradio", "weapon_handcuffer" },
    command = "leg5",
    max = 1,
    salary = 70,
    sortOrder = 5,
    admin = 0,
    category = "Легион",
    vote = false,
    hasLicense = false,
    donatejob = true,
    PlayerLoadout = function(ply)
    	ply:GiveAmmo( 20, 'SniperPenetratedRound', true )
    	ply:GiveAmmo( 60, 'tfa_ammo_357', true )
	end,
    customCheck = function(ply) return ply:GetRank() == "Iventolog" or ply:IsPremium() or ply:IsSuperAdmin() or ply:IsSponsor() or ply:IsVIP() end,
    CustomCheckFailMsg = "Эта работа только для донатеров!",
    lvl = 35,
})


TEAM_LEG6 = rp.addTeam("Павший [PREMIUM]", {
    color = Color(80, 163, 41, 255),
    model = {
        "models/ninja/resident_evil_orc_ubcs_zombie.mdl",
    },
    description = [[Да ты "чёр-рт", прекрасно выглядишь. Я даже подумал, что ты человек. Ну после моих слов тебе понятно-х, что ты должен делать. Ты единственный кого можно хоть чуть чуть спутать с человеком. Твоя задач-ха это разведка. Ты дашь нам всю информацию об этих мертвецах... Выходить ты можешь в любое время. Но не лезь на рожон. Беги - если страшно.]],
    weapons = { "tfa_ins2_mr96", "weapon_cuff_police", "wep_jack_job_drpradio" },
    command = "leg6",
    max = 2,
    salary = 40,
    sortOrder = 6,
    admin = 0,
    category = "Легион",
    vote = false,
    hasLicense = false,
    donatejob = true,
    PlayerLoadout = function(ply)
    	ply:GiveAmmo( 80, 'tfa_ammo_357', true )
	end,
    customCheck = function(ply) return ply:GetRank() == "Iventolog" or ply:IsPremium() or ply:IsSuperAdmin() or ply:IsSponsor() end,
    CustomCheckFailMsg = "Эта работа только для донатеров!",
    lvl = 25,
})


TEAM_LEG7 = rp.addTeam("Некромант [SPONSOR]", {
    color = Color(80, 163, 41, 255),
    model = {
        "models/players/mj_dbd_doctor1.mdl",
    },
    description = [[У нас есть прибор... Он позволит поднимать наших соратников, если вдруг им что-нибудь или где нибудь отстрелят. Стоит нажать вот эти две кнопки одновременно и наш друг встанет... Я понимаю, что особым умом ты не отличаешься, но все же сократить свои мышцы одновременно ты сможешь...]],
    weapons = { "tfa_yog_crowbar", "weapon_handcuffer", "wep_jack_job_drpradio" },
    command = "leg7",
    max = 2,
    salary = 55,
    sortOrder = 7,
    admin = 0,
    category = "Легион",
    vote = false,
    hasLicense = false,
    donatejob = true,
    customCheck = function(ply) return ply:GetRank() == "Iventolog" or ply:IsSuperAdmin() or ply:IsSponsor() end,
    CustomCheckFailMsg = "Эта работа только для донатеров!",
    lvl = 40,
})
-------------------------------------------------------
-------------------------------------------------------
-------------------------------------------------------