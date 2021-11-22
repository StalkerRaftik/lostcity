rp.Spin = rp.Spin or {}
rp.Spin.Items = rp.Spin.Items or {}

rp.Spin.Chance = {
    ["immortal"]        = {color = Color(249,213,14), chance = 10,},
    ["ancient"]         = {color = Color(214,82,81), chance = 10,},
    ["legendary"]       = {color = Color(211,44,230), chance = 10,},
    ["mythical"]        = {color = Color(110,71,255), chance = 10,},
    ["rare"]            = {color = Color(55,105,255), chance = 10,},
    ["uncommon"]        = {color = Color(94,152,217), chance = 10,},
}

rp.Spin.Rewards = {
    [1] = {
        name    = "Привилегия",
        rarity  = "immortal",
        icon    = Material('samprp/moreicons/crown.png', 'noclamp smooth'),
        type    = "PRIVEL",
        items   = {
            ["sponsorforever"]      = {rarity  = "immortal",},
            ["premforever"]         = {rarity  = "immortal",},
            ["vipforever"]          = {rarity  = "immortal",},            
            ["igrokplusforever"]    = {rarity  = "immortal",},            
            ["prem1mo"]             = {rarity  = "legendary",},
            ["vip1mo"]              = {rarity  = "legendary",},
            ["igrokplus1mo"]        = {rarity  = "legendary",},
            ["sponsor1mo"]          = {rarity  = "legendary",},            
        },
    },
    [2] = {
        name    = "Донат валюта",
        rarity  = "ancient",
        icon    = Material('samprp/moreicons/gift_coin.png', 'noclamp smooth'),
        type    = "DONATEMONEY",
        items   = {
            [100]   = {rarity  = "immortal",},
            [50]    = {rarity  = "ancient",},
            [30]    = {rarity  = "legendary",},
            [20]    = {rarity  = "mythical",},
            [10]    = {rarity  = "rare",},
        },
    },
    [3] = {
        name    = "Уровень",
        rarity  = "legendary",
        type    = "LEVEL",
        icon    = Material('samprp/moreicons/badge_sale2.png', 'noclamp smooth'),
        items   = {
            [100]   = {rarity  = "immortal",},
            [50]    = {rarity  = "ancient",},
            [30]    = {rarity  = "legendary",},
            [20]    = {rarity  = "mythical",},
            [10]    = {rarity  = "rare",},
        },
    },
    [4] = {
        name    = "Аксессуар",
        rarity  = "mythical",
        type    = INV_HATS,
        items   = {
            ["pbf"]         = {rarity  = "immortal",},
            ["pilothelm2"]  = {rarity  = "ancient",},
            ["hatgeneral"]  = {rarity  = "legendary",},
            ["motohelmet1"] = {rarity  = "mythical",},
            ["bandit1"]     = {rarity  = "rare",},
        },
    },
    [5] = {
        name    = "Деньги",
        rarity  = "rare",
        type    = "MONEY",
        icon    = Material('samprp/moreicons/money_pack.png', 'noclamp smooth'),
        items   = {
            [100]   = {rarity  = "immortal",},
            [50]    = {rarity  = "ancient",},
            [30]    = {rarity  = "legendary",},
            [20]    = {rarity  = "mythical",},
            [10]    = {rarity  = "rare",},
        },
    },
    [6] = {
        name    = "Лут",
        rarity  = "uncommon",
        type    = "LOOT",
        items   = {
            -- ["hlam31"]      = {type = "entity", rarity  = "immortal",},
            -- ["hlam32"]      = {type = "entity", rarity  = "ancient",},
            ["tfa_fas2_glock20"]     = {type = "weapon", rarity  = "legendary",},
            ["tfa_ins2_rpk_74m"]    = {type = "weapon", rarity  = "mythical",},
            ["tfa_ins2_akm_bw"]     = {type = "weapon", rarity  = "rare",},
        },
    },
}

local count = 1

function rp.Spin.addLootItem(itemType, itemClass, itemRarity)
	rp.Spin.Items[count] = {}
	rp.Spin.Items[count].Type = itemType
	rp.Spin.Items[count].itemClass = itemClass
	rp.Spin.Items[count].itemRarity = itemRarity
	rp.Spin.Items[count].itemName = Inventory.GetItem(itemType, itemClass) and Inventory.GetItem(itemType, itemClass).name or ""
    rp.Spin.Items[count].itemChance = rp.Spin.Chance[itemRarity].chance
    rp.Spin.Items[count].itemColor = rp.Spin.Chance[itemRarity].color
    rp.Spin.Items[count].itemModel = Inventory.GetItem(itemType, itemClass) and Inventory.GetItem(itemType, itemClass).model or "models/weapons/w_pist_elite_dropped.mdl"

	count = count + 1
end

function rp.Spin.addMoneyItem(itemName , amount , itemRarity)
	rp.Spin.Items[count] = {}
	rp.Spin.Items[count].itemName = itemName
	rp.Spin.Items[count].Type = "MONEY"
	rp.Spin.Items[count].moneyAmount = amount
	rp.Spin.Items[count].itemRarity = itemRarity
	rp.Spin.Items[count].itemModel = "models/props/cs_assault/money.mdl"
    rp.Spin.Items[count].itemChance = rp.Spin.Chance[itemRarity].chance
    rp.Spin.Items[count].itemColor = rp.Spin.Chance[itemRarity].color

	count = count + 1
end

function rp.Spin.addCosmeticItem(itemClass, itemRarity)
	rp.Spin.Items[count] = {}
	rp.Spin.Items[count].Type = INV_HATS
	rp.Spin.Items[count].itemClass = itemClass
	rp.Spin.Items[count].itemRarity = itemRarity
	rp.Spin.Items[count].itemName = Cosmetics.Items[itemClass].name
    rp.Spin.Items[count].itemChance = rp.Spin.Chance[itemRarity].chance
    rp.Spin.Items[count].itemColor = rp.Spin.Chance[itemRarity].color
    rp.Spin.Items[count].itemModel = Inventory.GetItem(INV_HATS, itemClass).model

	count = count + 1
end

function rp.Spin.addDonateItem(itemName, itemRarity, amount)
	rp.Spin.Items[count] = {}
	rp.Spin.Items[count].Type = "DONATEMONEY"
	rp.Spin.Items[count].itemAmount = amount
    rp.Spin.Items[count].itemRarity = itemRarity
	rp.Spin.Items[count].itemName = itemName
    rp.Spin.Items[count].itemChance = rp.Spin.Chance[itemRarity].chance
    rp.Spin.Items[count].itemColor = rp.Spin.Chance[itemRarity].color
    rp.Spin.Items[count].itemIcon = 'samprp/moreicons/gift_coin.png'

	count = count + 1
end

function rp.Spin.addLevelItem(itemName, itemRarity, amount)
	rp.Spin.Items[count] = {}
	rp.Spin.Items[count].Type = "LEVEL"
	rp.Spin.Items[count].itemAmount = amount
    rp.Spin.Items[count].itemRarity = itemRarity
	rp.Spin.Items[count].itemName = itemName
    rp.Spin.Items[count].itemChance = rp.Spin.Chance[itemRarity].chance
    rp.Spin.Items[count].itemColor = rp.Spin.Chance[itemRarity].color
    rp.Spin.Items[count].itemIcon = 'samprp/moreicons/badge_sale2.png'

	count = count + 1
end

function rp.Spin.addPrivelItem(itemName, itemRarity, privel)
	rp.Spin.Items[count] = {}
	rp.Spin.Items[count].Type = "PRIVEL"
	rp.Spin.Items[count].itemPrivel = privel
    rp.Spin.Items[count].itemRarity = itemRarity
	rp.Spin.Items[count].itemName = itemName
    rp.Spin.Items[count].itemChance = rp.Spin.Chance[itemRarity].chance
    rp.Spin.Items[count].itemColor = rp.Spin.Chance[itemRarity].color
    rp.Spin.Items[count].itemIcon = 'samprp/moreicons/crown.png'

	count = count + 1
end
-- for k, v in pairs(rp.Spin.Rewards) do
--     if not v.items then continue end
--     if v.type == "LOOT" then
--         for class, tab in pairs(v.items) do
--             rp.Spin.addLootItem(tab.type, class, tab.rarity)
--         end
--     end
--     if v.type == "MONEY" then
--         for num, tab in pairs(v.items) do
--             rp.Spin.addMoneyItem("$"..num, num, tab.rarity)
--         end
--     end
--     if v.type == "DONATEMONEY" then
--         for num, tab in pairs(v.items) do
--             rp.Spin.addDonateItem(num.." Доната",tab.rarity, num)
--         end
--     end
--     if v.type == "LEVEL" then
--         for num, tab in pairs(v.items) do
--             rp.Spin.addLevelItem(num.." LVL", tab.rarity, num)
--         end
--     end
--     if v.type == "PRIVEL" then
--         for privel, tab in pairs(v.items) do
--             rp.Spin.addPrivelItem(rp.shop.GetByUID(privel).Name, tab.rarity, privel)
--         end
--     end   
--     if v.type == INV_HATS then
--         for class, tab in pairs(v.items) do
--             rp.Spin.addCosmeticItem(class, tab.rarity)
--         end
--     end             
-- end
hook.Add( "InitPostEntity", "rp.Spin.InitConfig", function()
    for k, v in pairs(rp.Spin.Rewards) do
        if not v.items then continue end
        if v.type == "LOOT" then
            for class, tab in pairs(v.items) do
                rp.Spin.addLootItem(tab.type, class, tab.rarity)
            end
        end
        if v.type == "MONEY" then
            for num, tab in pairs(v.items) do
                rp.Spin.addMoneyItem("$"..num, num, tab.rarity)
            end
        end
        if v.type == "DONATEMONEY" then
            for num, tab in pairs(v.items) do
                rp.Spin.addDonateItem(num.." Доната",tab.rarity, num)
            end
        end
        if v.type == "LEVEL" then
            for num, tab in pairs(v.items) do
                rp.Spin.addLevelItem(num.." LVL", tab.rarity, num)
            end
        end
        if v.type == "PRIVEL" then
            for privel, tab in pairs(v.items) do
                rp.Spin.addPrivelItem(rp.shop.GetByUID(privel).Name, tab.rarity, privel)
            end
        end   
        if v.type == INV_HATS then
            for class, tab in pairs(v.items) do
                rp.Spin.addCosmeticItem(class, tab.rarity)
            end
        end          	
    end
end)
