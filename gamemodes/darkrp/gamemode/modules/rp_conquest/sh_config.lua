rp = rp or {}
rp.Conquest = rp.Conquest or {}

rp.Conquest.HoldReward = 50
rp.Conquest.InvadersAmountBetween0and15 = 1
rp.Conquest.InvadersAmountBetween16and30 = 2
rp.Conquest.InvadersAmountBetween31andInfinite = 3

rp.Conquest.Config = {
    ["Заброшенный госпиталь"] = {
        coords = {
            [1] = Vector(6617.9272460938, -434.54022216797, 673.03125),
            [2] = Vector(5184.1518554688, 1255.8677978516, 15.03125),
        },
        flag = {Vector(6048.257812, 1042.198364, 103.609299), Angle(0.000, 262.597, 0.000)},
        container = {Vector(6302.742188, -299.877838, 48.508389), Angle(0.000, 178.800, 0.000)},
        comment = "бинты, аптечки и другие медикаменты",
        rewards = { "Медицина" },
    },
    ["Порт"] = {
        coords = {
            [1] = Vector(-5122.55078125, -4740.7041015625, 688.03125),
            [2] = Vector(-7226.104492, -1771.182983, 79.178444),
        },
        flag = {Vector(-7016.501953, -2627.705322, 314.290985), Angle(0.000, 179.065, 0.000)},
        container = {Vector(-6975.513672, -2569.974121, 234.508377), Angle(0.000, 178.409, 0.000)},
        comment = "хлам и химикаты",
        rewards = { "ХламИлиМусор" },
    },
    ["Заброшенная заправка"] = {
        coords = {
            [1] = Vector(-1129.694824, 8062.329102, 404.404144),
            [2] = Vector(554.887756, 7056.873047, 59.153652),
        },
        flag = {Vector(327.138123, 7296.878906, 287.057190), Angle(0.000, 300.601, 0.000)},
        container = {Vector(-1031.415039, 7914.420898, 2.508389), Angle(0.000, 1.021, 0.000)},
        comment = "топливо",
        rewards = { "ХламИлиМусор" },
    },
    ["Последний этаж"] = {
        coords = {
            [1] = Vector(8019.031250, 7359.031250, 1700.031250),
            [2] = Vector(9176.441406, 7706.954590, 2164.382080),
        },
        flag = {Vector(8019.496094, 7420.962402, 1749.031250), Angle(-44.694, 2.193, -0.567)},
        container = {Vector(9119.663086, 7658.218262, 1917.491943), Angle(0.000, 270.592, 0.000)},
        comment = "различные патроны и редкий хлам",
        rewards = { "ХламИлиМусор" },
    },
}

rp.Conquest.SpecRewards = {
	-- ["Убежище"] = {
	-- 	[1] = {rewards = {"update01_hlam2", "hlam35", "hlam10", "update01_hlam4", "update01_hlam1", "item_ammo_pistol", "item_ammo_pistol", "item_ammo_357", "item_ammo_357", "item_box_buckshot", "item_box_buckshot", "tfa_ammo_smg", "tfa_ammo_smg"}, territories = "Кафе у заброшенного города"},
	-- 	[2] = {rewards = {"ent_bandage","ent_smallmedkit","ent_smallmedkit","ent_smallmedkit","ent_shina", "ent_medkit", "ent_bandage", "ent_bandage", "ent_bandage", "ent_bandage", "item_ammo_pistol", "item_ammo_pistol", "item_ammo_357", "item_ammo_357", "item_box_buckshot", "item_box_buckshot", "tfa_ammo_smg"}, territories = "Больница"},
	-- },
	-- ["Военные"] = {
	-- 	[1] = {rewards = {"item_ammo_pistol","item_ammo_pistol", "item_ammo_357", "item_box_buckshot", "item_box_buckshot","tfa_ammo_ar2", "tfa_ammo_smg"}, territories = "Кафе у заброшенного города"},
	-- 	[2] = {rewards = {"item_ammo_pistol","item_ammo_pistol", "item_ammo_357", "item_box_buckshot", "item_box_buckshot", "tfa_ammo_ar2", "tfa_ammo_smg"}, territories = "Школа"},
	-- },
	-- ["Ренегаты"] = {
	-- 	[1] = {rewards = {"update01_hlam2", "hlam35", "hlam10", "update01_hlam4", "hlam15", "hlam16", "hlam17", "hlam18", "update01_hlam1", "item_ammo_pistol", "item_ammo_pistol", "item_ammo_357", "item_ammo_357", "item_box_buckshot", "item_box_buckshot"}, territories = "Кафе у заброшенного города"},
	-- 	[2] = {rewards = {"update01_hlam2", "hlam35", "hlam10", "update01_hlam4", "hlam15", "hlam16", "hlam17", "hlam18", "update01_hlam1", "item_ammo_pistol", "item_ammo_pistol", "item_ammo_357", "item_ammo_357", "item_box_buckshot", "item_box_buckshot"}, territories = "Разрушенная школа"},
	-- },
	-- ["Ученые"] = {
	-- 	[1] = {rewards = {"bismuth","toluol","benznatriya","acetone"}, territories = "Завод"},
	-- },
	-- ["Вознесение"] = {
	-- 	[1] = {rewards = {"update01_hlam2", "hlam35", "hlam10", "update01_hlam4", "hlam15", "hlam16", "hlam17", "hlam18", "update01_hlam1", "item_ammo_pistol", "item_ammo_pistol", "item_ammo_357", "item_ammo_357", "item_box_buckshot", "item_box_buckshot"}, territories = "Кафе у заброшенного города"},
	-- 	[2] = {rewards = {"ent_bandage","ent_smallmedkit","ent_smallmedkit","ent_smallmedkit","ent_shina", "ent_medkit", "ent_bandage", "ent_bandage", "ent_bandage", "ent_bandage"}, territories = "Больница"},
	-- },
	-- ["Хаос"] = {
	-- 	[1] = {rewards = {"item_ammo_pistol", "item_ammo_357", "item_box_buckshot", "item_box_buckshot","tfa_ammo_ar2", "tfa_ammo_smg", "tfa_ammo_winchester"}, territories = "Кафе у заброшенного города"},
	-- 	[2] = {rewards = {"hlam5", "update01_hlam2", "hlam4", "hlam11", "hlam2", "hlam3", "hlam8", "hlam10", "hlam14", "hlam36", "hlam35", "update01_hlam4", "hlam15", "hlam16", "hlam17", "hlam18", "update01_hlam1"}, territories = "Завод"},
	-- },
}











