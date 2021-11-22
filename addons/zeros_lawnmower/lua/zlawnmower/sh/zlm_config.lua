zlm = zlm or {}
zlm.f = zlm.f or {}
zlm.config = zlm.config or {}

/////////////////////////////////////////////////////////////////////////////

// Bought by 76561197983213040
// Version 1.0.9


/////////////////////////// Zeros LawnMower /////////////////////////////

// Developed by ZeroChain:
// http://steamcommunity.com/id/zerochain/
// https://www.gmodstore.com/users/view/76561198013322242

// If you wish to contact me:
// clemensproduction@gmail.com

/////////////////////////////////////////////////////////////////////////////

zlm.config.lostEarnings = 1 // 10 * это число == заработок за 1 сено

zlm.config.oatContainer = {
    mdl = 'models/props_junk/wood_crate002a.mdl',
    pos = Vector(-11768.897461, 9744.890625, -21.932796),
    ang = Angle(-0.879, -177.194, -2.760),
}

// This enables the Debug Mode
zlm.config.Debug = false

// Switches between FastDl and Workshop
zlm.config.EnableResourceAddfile = false

// Currency
zlm.config.Currency = "м."

// The language , en , de, fr , es , pl , ru , cn
zlm.config.SelectedLanguage = "ru"

// unit of weight
zlm.config.UoW = "кг."

// These Ranks are allowed to use the debug commands and save GrassSpots with !savezlm
// If xAdmin is installed this table will be ignored
zlm.config.AdminRanks = {"superadmin","sudoroot"}

// This will add the Player as the Owner of the entities for Falcos Prop Protection System
zlm.config.CPPI = true

// Do we have VCMod installed?
zlm.config.VCMod = false

zlm.config.SimpleGrassMode = {

    // If set to true then no client grass will be Spawned and the LawnMower will be using Brush Textures / Displacment to determine if he is currently on Grass
    Enabled = false,

    // The Brush Textures that count as Grass (This does only check Brush Faces not Displacments)
    Textures = {},

    // Are we allowing Displacments to count as Grass?
    Displacement = false,
}


// Creating the Types of grass
//zlm.f.Create_Grass(ID, _Model, Scale_min, Scale_max)
zlm.f.Create_Grass(4431, "models/zerochain/props_lawnmower/zlm_grasscluster01.mdl", 0.5, 0.8)
zlm.f.Create_Grass(3441, "models/zerochain/props_lawnmower/zlm_grasscluster02.mdl", 0.5, 0.8)
zlm.f.Create_Grass(6431, "models/zerochain/props_lawnmower/zlm_grasscluster03.mdl", 0.5, 0.8)
zlm.f.Create_Grass(2135, "models/zerochain/props_lawnmower/zlm_grasscluster04.mdl", 0.5, 0.8)

// Needs HL2
//zlm.f.Create_Grass(4628, "models/props_foliage/cattails.mdl", 0.5, 0.8)

// Needs CSS
/*
zlm.f.Create_Grass(6385, "models/props/de_inferno/bushgreenbig.mdl", 0.3, 0.5)
zlm.f.Create_Grass(7134, "models/props/de_inferno/bushgreensmall.mdl", 1, 2)
zlm.f.Create_Grass(5479, "models/props/de_inferno/largebush01.mdl", 0.8, 1.2)
zlm.f.Create_Grass(9752, "models/props/de_inferno/largebush02.mdl", 0.8, 1.2)
zlm.f.Create_Grass(2463, "models/props/de_inferno/largebush03.mdl", 0.6, 0.9)
zlm.f.Create_Grass(5374, "models/props/de_inferno/largebush04.mdl", 0.5, 0.8)
zlm.f.Create_Grass(5573, "models/props/de_inferno/largebush05.mdl", 0.3, 0.6)
zlm.f.Create_Grass(9963, "models/props/de_inferno/largebush06.mdl", 0.3, 0.6)
zlm.f.Create_Grass(5185, "models/props/de_train/bush.mdl", 0.3, 0.6)
zlm.f.Create_Grass(3536, "models/props/de_train/bush2.mdl", 1,2)
*/

zlm.config.LawnMower = {
    StorageCapacity = 500, // How much grass can it collect before its full
    MoweInterval = 0.1, // This is only used if SimpleGrassMode is enabled
    NoCollide = true, // Do we want the LawnMower to be NoCollide for the Players

    //http://wiki.garrysmod.com/page/Enums/BUTTON_CODE
    Keys = {
        StartBlades = KEY_T, // This Key toggles the blades
        Unload = KEY_F, // This Key unloads the grass basket to a grass press or sells the grass rolls to a npc if the player has the trailer connected and is near the npc
        Connect = KEY_C, // This Key connects the trailer or the grass basket
    },

    // If VCMod is installed then these values are used for fuel consumption when the blades are used for mowing
    // This dont defines the fuel usage for the vehicle itself but is more of a extra fuel consumption when the machines blades are enabled.
    Fuel = {
        fc_amount = 0.25, // The amount of fuel that gets used
        fc_time = 10, // The rate at which fuel gets used in seconds
    }
}

zlm.config.GrassPress = {
    // How much grass can the machine hold
    Capacity = 1000,

    // How much grass is needed to produce one Grass roll
    Production_Amount = 100,

    // How long does it take to press a grass roll
    Production_Time = 60,

    // The minimal production time that will be set after the player bought all the upgrades
    Production_TimeLimit = 40,

    // How many valid grassrolls are allowed to exist at the same time per grasspress. This Limit makes sure the player cant spamm the world with grassrolls
    GrassRoll_Limit = 10,

    // The upgrades gonna decrease the production time of the GrassPress
    Upgrades = {
        Enabled = true,
        Count = 5, // How many upgrades can the player buy
        Ranks = {}, // What ranks are allowed to buy upgrades, Leave Empty to disable the rank check
        Price = 5000, // How much does one upgrade cost
        Cooldown = 120, // How long until the player can buy another upgrade
    }
}

zlm.config.Grass = {
    // How long till the grass re grows in seconds?
    RefreshTime = 600,

    // Only these job can see the grass, leave empty to allow everyone to see the grass
    RenderForJob = {
        ["Фермер 'Блэйк'"] = true,
    }
}

zlm.config.NPC = {
    Model = "models/Humans/Group03/Male_04.mdl" , // The model of the npc
    Capabilities = true, // Setting this to false will improve network performance but disables the npc reactions for the player

    // The values below define the minimum and maximum buy rate of the npc in percentage.
    // The base money the player will recieve is still defined in the SellPrice var above but this modifies it to be diffrent from npc to npc.
    // If you dont want this then just set both to 100
    MaxBuyRate = 115,
    MinBuyRate = 75,

    SellDistance = 300, // The Distance and what the player can sell to the npc

    RefreshRate = 600, // The interval at which the buy rate changes in seconds, set to -1 to disable the refreshing of the price modifier

    // These jobs are allowed to interact with the npc, Leave empty to allow everyone
    Interaction = {
        ["Фермер 'Блэйк'"] = true
    },

    // The Shop prices
    Shop = {
        ["lawnmower"] = 50,
        ["trailer"] = 30,
    },

    // The sell price per GrassRoll
    SellPrice = {
        ["Default"] = 1000,
        ["vip"] = 2500,
        ["superadmin"] = 5000
    }
}



// Do we have VrondakisLevelSystem installed?
zlm.config.VrondakisLevelSystem = false
zlm.config.Vrondakis = {}
zlm.config.Vrondakis["Mowing"] = {XP = 1} // XP per cut down grass
zlm.config.Vrondakis["Selling"] = {XP = 1}	// XP per sold grassroll
