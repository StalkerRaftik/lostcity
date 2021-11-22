--initialize an empty table
FISH_TYPES = {}
--fill the models table to precache
VALID_FISH_MODELS = {
    "models/tsbb/fishes/anchovy.mdl",
    "models/tsbb/fishes/angelfish.mdl",
    "models/tsbb/fishes/anglerfish.mdl",
    "models/tsbb/fishes/arapaima.mdl",
    "models/tsbb/fishes/arowana.mdl",
    "models/tsbb/fishes/ayu.mdl",
    "models/tsbb/fishes/barracuda.mdl",
    "models/tsbb/fishes/barramundi.mdl",
    "models/tsbb/fishes/bass.mdl",
    "models/tsbb/fishes/betta.mdl",
    "models/tsbb/fishes/bitterling.mdl",
    "models/tsbb/fishes/blobfish.mdl",
    "models/tsbb/fishes/blue_marlin.mdl",
    "models/tsbb/fishes/carp.mdl",
    "models/tsbb/fishes/catfish.mdl",
    "models/tsbb/fishes/cod.mdl",
    "models/tsbb/fishes/coelacanth.mdl",
    "models/tsbb/fishes/eel.mdl",
    "models/tsbb/fishes/flying_fish.mdl",
    "models/tsbb/fishes/frogfish.mdl",
    "models/tsbb/fishes/goby.mdl",
    "models/tsbb/fishes/goldfish.mdl",
    "models/tsbb/fishes/grouper.mdl",
    "models/tsbb/fishes/guitarfish.mdl",
    "models/tsbb/fishes/guppy.mdl",
    "models/tsbb/fishes/halibut.mdl",
    "models/tsbb/fishes/humphead_wrasse.mdl",
    "models/tsbb/fishes/japanese_perch.mdl",
    "models/tsbb/fishes/lamprey.mdl",
    "models/tsbb/fishes/loach.mdl",
    "models/tsbb/fishes/lungfish.mdl",
    "models/tsbb/fishes/mackerel.mdl",
    "models/tsbb/fishes/mantaray.mdl",
    "models/tsbb/fishes/minnow.mdl",
    "models/tsbb/fishes/mullet.mdl",
    "models/tsbb/fishes/neon_tetra.mdl",
    "models/tsbb/fishes/oarfish.mdl",
    "models/tsbb/fishes/parrot_fish.mdl",
    "models/tsbb/fishes/pike.mdl",
    "models/tsbb/fishes/piranha.mdl",
    "models/tsbb/fishes/pollock.mdl",
    "models/tsbb/fishes/remora.mdl",
    "models/tsbb/fishes/rockfish.mdl",
    "models/tsbb/fishes/sardine.mdl",
    "models/tsbb/fishes/sculpin.mdl",
    "models/tsbb/fishes/sheephead.mdl",
    "models/tsbb/fishes/siamese_tigerfish.mdl",
    "models/tsbb/fishes/snakehead.mdl",
    "models/tsbb/fishes/snapper.mdl",
    "models/tsbb/fishes/sockeye_salmon.mdl",
    "models/tsbb/fishes/stickleback.mdl",
    "models/tsbb/fishes/sunfish.mdl",
    "models/tsbb/fishes/surgeon_fish.mdl",
    "models/tsbb/fishes/tiger_fish.mdl",
    "models/tsbb/fishes/trout.mdl",
    "models/tsbb/fishes/tuna.mdl"
}
--global lure info
LURE_TYPES = {
    ["clam"] = {
        model = "models/foodnhouseholditems/lobster.mdl",
        scale = 1.3,
        name = "Кусочки омаров",
        desc = "Пригоден для поиска рыбы любого вида.",
        blacklist = {
            ["anglerfish"] = true,
            ["barracuda"] = true,
            ["frogfish"] = true,
            ["oarfish"] = true,
            ["siamese_tigerfish"] = true,
            ["tiger_fish"] = true,
            ["blobfish"] = true,
            ["stickleback"] = true,
            ["coelacanth"] = true
        },
        price = 100
    },
    ["carrot"] = {
        model = "models/foodnhouseholditems/carrot.mdl",
        scale = .9,
        name = "Морковь",
        desc = "Лучше всего подходит для ловли небольших рыбок",
        blacklist = {
            ["arapaima"] = true,
            ["barracuda"] = true,
            ["barramundi"] = true,
            ["bass"] = true,
            ["blobfish"] = true,
            ["blue_marlin"] = true,
            ["catfish"] = true,
            ["coelacanth"] = true,
            ["eel"] = true,
            ["grouper"] = true,
            ["halibut"] = true,
            ["lamprey"] = true,
            ["lungfish"] = true,
            ["oarfish"] = true,
            ["pike"] = true,
            ["sheephead"] = true,
            ["siamese_tigerfish"] = true,
            ["snakehead"] = true,
            ["stickleback"] = true,
            ["tiger_fish"] = true,
            ["trout"] = true,
            ["tuna"] = true
        },
        price = 50
    },
    ["apple"] = {
        model = "models/foodnhouseholditems/apple.mdl",
        scale = 1,
        name = "Яблоко",
        desc = "Для поиска домашней рыбы.",
        blacklist = {
            ["arapaima"] = true,
            ["anglerfish"] = true,
            ["barracuda"] = true,
            ["barramundi"] = true,
            ["bass"] = true,
            ["blobfish"] = true,
            ["blue_marlin"] = true,
            ["carp"] = true,
            ["catfish"] = true,
            ["cod"] = true,
            ["coelacanth"] = true,
            ["eel"] = true,
            ["frogfish"] = true,
            ["grouper"] = true,
            ["guitarfish"] = true,
            ["halibut"] = true,
            ["humphead_wrasse"] = true,
            ["lamprey"] = true,
            ["mackerel"] = true,
            ["mantaray"] = true,
            ["piranha"] = true,
            ["lungfish"] = true,
            ["oarfish"] = true,
            ["pike"] = true,
            ["remora"] = true,
            ["sheephead"] = true,
            ["siamese_tigerfish"] = true,
            ["snakehead"] = true,
            ["stickleback"] = true,
            ["tiger_fish"] = true
        },
        price = 25
    },
    ["tomato"] = {
        model = "models/foodnhouseholditems/steak1.mdl",
        scale = 1,
        name = "Кусочек мяса",
        desc = "Пригоден для поимки хищной рыбы.",
        blacklist = {
            ["anchovy"] = true,
            ["angelfish"] = true,
            ["arowana"] = true,
            ["ayu"] = true,
            ["betta"] = true,
            ["bitterling"] = true,
            ["cod"] = true,
            ["flying_fish"] = true,
            ["goby"] = true,
            ["goldfish"] = true,
            ["guitarfish"] = true,
            ["guppy"] = true,
            ["japanese_perch"] = true,
            ["loach"] = true,
            ["mantaray"] = true,
            ["minnow"] = true,
            ["mullet"] = true,
            ["neon_tetra"] = true,
            ["parrot_fish"] = true,
            ["pollock"] = true,
            ["rockfish"] = true,
            ["sardine"] = true,
            ["snapper"] = true,
            ["stickleback"] = true,
            ["surgeon_fish"] = true,
            ["trout"] = true,
            ["tuna"] = true
        },
        price = 150
    },
    ["mushroom"] = {
        model = "models/foodnhouseholditems/pear.mdl",
        scale = 1.2,
        name = "Кусочки фруктов",
        desc = "Хорош для поиска не хищных рыб.",
        blacklist = {
            ["anglerfish"] = true,
            ["arapaima"] = true,
            ["arowana"] = true,
            ["barracuda"] = true,
            ["barramundi"] = true,
            ["bass"] = true,
            ["blobfish"] = true,
            ["blue_marlin"] = true,
            ["carp"] = true,
            ["catfish"] = true,
            ["cod"] = true,
            ["coelacanth"] = true,
            ["frogfish"] = true,
            ["grouper"] = true,
            ["guitarfish"] = true,
            ["halibut"] = true,
            ["humphead_wrasse"] = true,
            ["lungfish"] = true,
            ["mackerel"] = true,
            ["mantaray"] = true,
            ["oarfish"] = true,
            ["pike"] = true,
            ["piranha"] = true,
            ["pollock"] = true,
            ["remora"] = true,
            ["sheephead"] = true,
            ["siamese_tigerfish"] = true,
            ["snapper"] = true,
            ["sockeye_salmon"] = true,
            ["sunfish"] = true,
            ["tiger_fish"] = true,
            ["trout"] = true,
            ["tuna"] = true
        },
        price = 10
    },
    ["heart"] = {
        model = "models/tsbb/fishes/ayu.mdl",
        scale = 1,
        name = "Блесна",
        desc = "Привлекает все виды рыб.",
        blacklist = {},
        price = 75
    },
    ["bread"] = {
        model = "models/foodnhouseholditems/bread_slice.mdl",
        scale = 1,
        name = "Хлеб",
        desc = "Старый хлеб. Хорош для приманки морской и глубоководной рыбы.",
        blacklist = {
            ["anchovy"] = true,
            ["angelfish"] = true,
            ["arapaima"] = true,
            ["arowana"] = true,
            ["ayu"] = true,
            ["bass"] = true,
            ["betta"] = true,
            ["bitterling"] = true,
            ["carp"] = true,
            ["catfish"] = true,
            ["cod"] = true,
            ["goby"] = true,
            ["goldfish"] = true,
            ["guppy"] = true,
            ["halibut"] = true,
            ["loach"] = true,
            ["lungfish"] = true,
            ["minnow"] = true,
            ["mullet"] = true,
            ["neon_tetra"] = true
        },
        price = 200
    },
    ["potato"] = {
        model = "models/foodnhouseholditems/corn.mdl",
        scale = 1,
        name = "Кукуруза",
        desc = "Привлекает рыбу, которая хочет просто перекусить",
        blacklist = {
            ["anglerfish"] = true,
            ["barracuda"] = true,
            ["frogfish"] = true,
            ["oarfish"] = true,
            ["siamese_tigerfish"] = true,
            ["tiger_fish"] = true,
            ["blobfish"] = true,
            ["stickleback"] = true,
            ["coelacanth"] = true,
            ["angelfish"] = true,
            ["blue_marlin"] = true,
            ["eel"] = true,
            ["guitarfish"] = true,
            ["humphead_wrasse"] = true,
            ["lamprey"] = true,
            ["mantaray"] = true,
            ["remora"] = true,
            ["sheephead"] = true
        },
        price = 15
    },
    ["egg"] = {
        model = "models/foodnhouseholditems/egg2.mdl",
        scale = 1,
        name = "Белок",
        desc = "Эта приманка может заинтерисовать рыб, которые ищут закуску",
        blacklist = {
            ["anchovy"] = true,
            ["angelfish"] = true,
            ["arapaima"] = true,
            ["arowana"] = true,
            ["ayu"] = true,
            ["bass"] = true,
            ["betta"] = true,
            ["bitterling"] = true,
            ["carp"] = true,
            ["catfish"] = true,
            ["cod"] = true,
            ["goby"] = true,
            ["goldfish"] = true,
            ["guppy"] = true,
            ["halibut"] = true,
            ["loach"] = true,
            ["lungfish"] = true,
            ["minnow"] = true,
            ["mullet"] = true,
            ["neon_tetra"] = true,
            ["tuna"] = true,
            ["trout"] = true,
            ["stickleback"] = true,
            ["sockeye_salmon"] = true,
            ["rockfish"] = true,
            ["parrot_fish"] = true
        },
        price = 125
    }
}   

for k,v in pairs( VALID_FISH_MODELS ) do
    --key of the table
    local fishKey = string.gsub( v, "models/tsbb/fishes/", "" )
    fishKey = string.gsub( fishKey, ".mdl", "" )
    --print name of the fish
    --populate
    FISH_TYPES[ fishKey ] = {
        model = v,
        name = "",
        rarity = ""
    }

end

FISH_TYPES[ "anchovy" ].name = "анчоус" --необычная marine and freshwater
FISH_TYPES[ "angelfish" ].name = "рыба-ангел" --freshwater amazon
FISH_TYPES[ "anglerfish" ].name = "удильщик" --deep sea
FISH_TYPES[ "arapaima" ].name = "арапайма" --largest freshwater amazon
FISH_TYPES[ "arowana" ].name = "арована" --freshwater
FISH_TYPES[ "ayu" ].name = "айю" --необычная
FISH_TYPES[ "barracuda" ].name = "барракуда" --predatory
FISH_TYPES[ "barramundi" ].name = "латес" --widely dist in eatern countries
FISH_TYPES[ "bass" ].name = "большеротый окунь" --its a bass
FISH_TYPES[ "betta" ].name = "бойцовская рыбка" --small fighting fish
FISH_TYPES[ "bitterling" ].name = "горчак" --small freshwater fish
FISH_TYPES[ "blobfish" ].name = "рыба-капля" --deep sea
FISH_TYPES[ "blue_marlin" ].name = "голубой марлин" --massive, overhunted
FISH_TYPES[ "carp" ].name = "карп" --its a carp
FISH_TYPES[ "catfish" ].name = "сом" --big boy freshwater
FISH_TYPES[ "cod" ].name = "бог-рыба" --its a cod
FISH_TYPES[ "coelacanth" ].name = "латимерия" --thought to be extinct
FISH_TYPES[ "eel" ].name = "угорь" --its an eel
FISH_TYPES[ "flying_fish" ].name = "летучая рыба" --live in all oceans
FISH_TYPES[ "frogfish" ].name = "бородавчатая рыба" --deep sea (related to angler fish)
FISH_TYPES[ "goby" ].name = "бычок" --i dont even know
FISH_TYPES[ "goldfish" ].name = "золотая рыбка" --its a goldfish dude
FISH_TYPES[ "grouper" ].name = "групер" --big boy
FISH_TYPES[ "guitarfish" ].name = "акула-банджо" --actual just a ray
FISH_TYPES[ "guppy" ].name = "гуппи" --basically a goldfish
FISH_TYPES[ "halibut" ].name = "палтус" --kinda необычная i guess
FISH_TYPES[ "humphead_wrasse" ].name = "рыба-наполеон" --coral reef fish
FISH_TYPES[ "japanese_perch" ].name = "морской черт" --необычная perch
FISH_TYPES[ "lamprey" ].name = "минога" --another eel
FISH_TYPES[ "loach" ].name = "вьюн" --pond fish
FISH_TYPES[ "lungfish" ].name = "двоякодышащий" --big boy freshwater
FISH_TYPES[ "mackerel" ].name = "скумбрия" --live along the coast
FISH_TYPES[ "mantaray" ].name = "манта" --just a ray
FISH_TYPES[ "minnow" ].name = "воблер" --dime a dozen
FISH_TYPES[ "mullet" ].name = "лучеперая рыба" --most popular bait
FISH_TYPES[ "neon_tetra" ].name = "голубой неон" --freshwater fish необычная aquarium
FISH_TYPES[ "oarfish" ].name = "сельдяной король" --can be largest fish
FISH_TYPES[ "parrot_fish" ].name = "рыба-попугай" --large species richness
FISH_TYPES[ "pike" ].name = "щука" --trophy fish
FISH_TYPES[ "piranha" ].name = "пиранья" --chomp chomp
FISH_TYPES[ "pollock" ].name = "минтай" --food fish
FISH_TYPES[ "remora" ].name = "рыба-прилипало" --suckerfish
FISH_TYPES[ "rockfish" ].name = "коричневый окунь" --food fish
FISH_TYPES[ "sardine" ].name = "сардина" --ew
FISH_TYPES[ "sculpin" ].name = "рогаткоподобная рыба" --shallow water
FISH_TYPES[ "sheephead" ].name = "рыба-картожник" --coral reef fish
FISH_TYPES[ "siamese_tigerfish" ].name = "сиамская тигровая рыба" --poison deep sea
FISH_TYPES[ "snakehead" ].name = "змееголовая" --predatory
FISH_TYPES[ "snapper" ].name = "кампечинский луциан" --food fish
FISH_TYPES[ "sockeye_salmon" ].name = "нерка" --salmon
FISH_TYPES[ "stickleback" ].name = "колюшка" --related to seahorses
FISH_TYPES[ "sunfish" ].name = "луна-рыба" --ocean
FISH_TYPES[ "surgeon_fish" ].name = "рыба-ёж" --ocean
FISH_TYPES[ "tiger_fish" ].name = "рыба-тигр" --another poison deep sesa
FISH_TYPES[ "trout" ].name = "форель" --trout
FISH_TYPES[ "tuna" ].name = "тунец" --tuna



--populate fish types with rarity
--i researched fish for garrys mod
--what am i doing with my life
FISH_TYPES[ "anchovy" ].rarity = "обычная" --необычная marine and freshwater
FISH_TYPES[ "angelfish" ].rarity = "очень редкая" --freshwater amazon
FISH_TYPES[ "anglerfish" ].rarity = "мифическая" --deep sea
FISH_TYPES[ "arapaima" ].rarity = "редкая" --largest freshwater amazon
FISH_TYPES[ "arowana" ].rarity = "редкая" --freshwater
FISH_TYPES[ "ayu" ].rarity = "необычная" --необычная
FISH_TYPES[ "barracuda" ].rarity = "мифическая" --predatory
FISH_TYPES[ "barramundi" ].rarity = "редкая" --widely dist in eatern countries
FISH_TYPES[ "bass" ].rarity = "необычная" --its a bass
FISH_TYPES[ "betta" ].rarity = "редкая" --small fighting fish
FISH_TYPES[ "bitterling" ].rarity = "обычная" --small freshwater fish
FISH_TYPES[ "blobfish" ].rarity = "легендарная" --deep sea
FISH_TYPES[ "blue_marlin" ].rarity = "очень редкая" --massive, overhunted
FISH_TYPES[ "carp" ].rarity = "необычная" --its a carp
FISH_TYPES[ "catfish" ].rarity = "редкая" --big boy freshwater
FISH_TYPES[ "cod" ].rarity = "необычная" --its a cod
FISH_TYPES[ "coelacanth" ].rarity = "легендарная" --thought to be extinct
FISH_TYPES[ "eel" ].rarity = "очень редкая" --its an eel
FISH_TYPES[ "flying_fish" ].rarity = "необычная" --live in all oceans
FISH_TYPES[ "frogfish" ].rarity = "мифическая" --deep sea (related to angler fish)
FISH_TYPES[ "goby" ].rarity = "необычная" --i dont even know
FISH_TYPES[ "goldfish" ].rarity = "обычная" --its a goldfish dude
FISH_TYPES[ "grouper" ].rarity = "необычная" --big boy
FISH_TYPES[ "guitarfish" ].rarity = "очень редкая" --actual just a ray
FISH_TYPES[ "guppy" ].rarity = "обычная" --basically a goldfish
FISH_TYPES[ "halibut" ].rarity = "необычная" --kinda необычная i guess
FISH_TYPES[ "humphead_wrasse" ].rarity = "очень редкая" --coral reef fish
FISH_TYPES[ "japanese_perch" ].rarity = "необычная" --необычная perch
FISH_TYPES[ "lamprey" ].rarity = "очень редкая" --another eel
FISH_TYPES[ "loach" ].rarity = "обычная" --pond fish
FISH_TYPES[ "lungfish" ].rarity = "редкая" --big boy freshwater
FISH_TYPES[ "mackerel" ].rarity = "необычная" --live along the coast
FISH_TYPES[ "mantaray" ].rarity = "очень редкая" --just a ray
FISH_TYPES[ "minnow" ].rarity = "обычная" --dime a dozen
FISH_TYPES[ "mullet" ].rarity = "обычная" --most popular bait
FISH_TYPES[ "neon_tetra" ].rarity = "необычная" --freshwater fish необычная aquarium
FISH_TYPES[ "oarfish" ].rarity = "мифическая" --can be largest fish
FISH_TYPES[ "parrot_fish" ].rarity = "необычная" --large species richness
FISH_TYPES[ "pike" ].rarity = "редкая" --trophy fish
FISH_TYPES[ "piranha" ].rarity = "редкая" --chomp chomp
FISH_TYPES[ "pollock" ].rarity = "обычная" --food fish
FISH_TYPES[ "remora" ].rarity = "очень редкая" --suckerfish
FISH_TYPES[ "rockfish" ].rarity = "необычная" --food fish
FISH_TYPES[ "sardine" ].rarity = "обычная" --ew
FISH_TYPES[ "sculpin" ].rarity = "необычная" --shallow water
FISH_TYPES[ "sheephead" ].rarity = "очень редкая" --coral reef fish
FISH_TYPES[ "siamese_tigerfish" ].rarity = "мифическая" --poison deep sea
FISH_TYPES[ "snakehead" ].rarity = "очень редкая" --predatory
FISH_TYPES[ "snapper" ].rarity = "обычная" --food fish
FISH_TYPES[ "sockeye_salmon" ].rarity = "необычная" --salmon
FISH_TYPES[ "stickleback" ].rarity = "легендарная" --related to seahorses
FISH_TYPES[ "sunfish" ].rarity = "редкая" --ocean
FISH_TYPES[ "surgeon_fish" ].rarity = "редкая" --ocean
FISH_TYPES[ "tiger_fish" ].rarity = "мифическая" --another poison deep sesa
FISH_TYPES[ "trout" ].rarity = "необычная" --trout
FISH_TYPES[ "tuna" ].rarity = "необычная" --tuna