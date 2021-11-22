-- I moved everything  to one file.
-- Use 'fs_information' in console to get more information in game(config print).
-- I balanced all plants, so there are no point to farm only 1 type to get more money.
-- If you want to edit harvest time or change prices, you better change FS_Harvest_Time_Modifier and FS_Price_Modifier.
-- You can add salesman by typing 'fs_salesman_spawn <name>' in console. Salesman will spawn in your target position. To remove salesman type 'fs_salesman_remove <name>'.

-- Drawing 3D2D things distance.
FS_DrawDistance = 100;
-- Use distance.
FS_Use_Distance = 96;
-- Just a time limit, keep it above 3600, it shouldn't affect if it's too high.
FS_Time_Limit = 3600;
-- Punch power. To shake tree or plant.
FS_Punch_Power = 256;
-- Enable salesman? You can pick up fruits by pressing Shift+E if it's enabled.
FS_Salesman_Enabled = true;
-- Can food restore hunger?
FS_Hunger_Enabled = true;
-- Price modifier.
FS_Price_Modifier = 1;
-- Seed time modifier.
FS_Seed_Time_Modifier = 1;
-- Harvest time modifier.
FS_Harvest_Time_Modifier = 1;
-- Draws salesman names over his head.
FS_Salesman_NameOverhead = true;
-- Salesman name goes here.
FS_Salesman_Name = "Greenhouse Man";
-- Color of salesman name.
FS_Salesman_Name_Color = Color(213, 213, 25, 255);
-- Fruits will rot and disappear within time.
FS_Rot_System = false;
-- Time for fruits to disappear.
FS_Rot_Timer = 300;
-- Maximum amount of seeds for Farmer.
FS_Max_Plants = 4;
-- An attempt to make VIP groups.
FS_Vip_Groups = 
{
	VIP = 
		{
			name = "VIP";
			max_plants = 4;
		},
	donator = 
		{
			name = "donator";
			max_plants = 8;
		}
}

-- Melon config.
FS_Melon_Hunger = 75;
FS_Melon_Health = 25;
FS_Melon_Color = Color(213, 213, 25, 255);
FS_Melon_Seed_Time = math.Round(300*FS_Seed_Time_Modifier);
FS_Melon_Harvest_Time = math.Round(180*FS_Harvest_Time_Modifier);
FS_Melon_Harvest_Amount = 1;
FS_Melon_Price = math.Round(600*FS_Price_Modifier);
FS_Melon_MaxHold = 2;

-- Money tree config.
FS_Money_Amount = 50;
FS_Money_Color = Color(96, 230, 47, 255);
FS_Money_Seed_Time = math.Round(300*FS_Seed_Time_Modifier);
FS_Money_Harvest_Time = math.Round(150*FS_Harvest_Time_Modifier);
FS_Money_Harvest_Amount = 10;

-- Baby plant config.
FS_Baby_StartHealth = 25;
FS_Baby_StartSpeed = 25;
FS_Baby_StartHunger = 100; -- It's also maximum hunger value of baby.
FS_Baby_HungerCooldown = 5; -- Time between hunger points consumption.
FS_Baby_HungerConsumptionPerSec = 1;
FS_Baby_StartRadius = 50;
FS_Baby_MaxHealth = 500;
FS_Baby_MaxSpeed = 250;
FS_Baby_MaxRadius = 500;
FS_Baby_Apple_HungerIncome = 10;
FS_Baby_Lemon_SpeedIncome = 10;
FS_Baby_Tomato_RadiusIncome = 10;
FS_Baby_Potato_HealthIncome = 10;


FS_BabyPlant_Color = Color(154, 0, 0, 255);
FS_BabyPlant_Seed_Time = math.Round(300*FS_Seed_Time_Modifier);
FS_BabyPlant_Harvest_Time = math.Round(180*FS_Harvest_Time_Modifier);
FS_BabyPlant_Harvest_Amount = 1;

-- Cabbage config.
FS_Cabbage_Hunger = 75;
FS_Cabbage_Health = 25;
FS_Cabbage_Color = Color(177, 222, 160, 255);
FS_Cabbage_Seed_Time = math.Round(500*FS_Seed_Time_Modifier);
FS_Cabbage_Harvest_Time = math.Round(140*FS_Harvest_Time_Modifier);
FS_Cabbage_Harvest_Amount = 1;
FS_Cabbage_Price = math.Round(475*FS_Price_Modifier);
FS_Cabbage_MaxHold = 2;

-- Watermelon config.
FS_Watermelon_Hunger = 75;
FS_Watermelon_Health = 50;
FS_Watermelon_Color = Color(119, 214, 25, 255);
FS_Watermelon_Seed_Time = math.Round(300*FS_Seed_Time_Modifier);
FS_Watermelon_Harvest_Time = math.Round(240*FS_Harvest_Time_Modifier);
FS_Watermelon_Harvest_Amount = 1;
FS_Watermelon_Price = math.Round(800*FS_Price_Modifier);
FS_Watermelon_MaxHold = 2;

-- Tomato config.
FS_Tomato_Hunger = 25;
FS_Tomato_Health = 25;
FS_Tomato_Color = Color(175, 0, 0, 255);
FS_Tomato_Seed_Time = math.Round(300*FS_Seed_Time_Modifier);
FS_Tomato_Harvest_Time = math.Round(120*FS_Harvest_Time_Modifier);
FS_Tomato_Harvest_Amount = 8;
FS_Tomato_Price = math.Round(50*FS_Price_Modifier);
FS_Tomato_MaxHold = 15;

-- Orange config.
FS_Orange_Hunger = 25;
FS_Orange_Health = 25;
FS_Orange_Color = Color(246, 165, 42, 255);
FS_Orange_Seed_Time = math.Round(300*FS_Seed_Time_Modifier);
FS_Orange_Harvest_Time = math.Round(145*FS_Harvest_Time_Modifier);
FS_Orange_Harvest_Amount = 6;
FS_Orange_Price = math.Round(80*FS_Price_Modifier);
FS_Orange_MaxHold = 15;

-- Apple config.
FS_Apple_Hunger = 25;
FS_Apple_Health = 25;
FS_Apple_Color = Color(138, 239, 95, 255);
FS_Apple_Seed_Time = math.Round(450*FS_Seed_Time_Modifier);
FS_Apple_Harvest_Time = math.Round(160*FS_Harvest_Time_Modifier);
FS_Apple_Harvest_Amount = 5;
FS_Apple_Price = math.Round(25*FS_Price_Modifier);
FS_Apple_MaxHold = 15;

-- Lemon config.
FS_Lemon_Hunger = 25;
FS_Lemon_Health = 25;
FS_Lemon_Color = Color(147, 0, 191, 255);
FS_Lemon_Seed_Time = math.Round(600*FS_Seed_Time_Modifier);
FS_Lemon_Harvest_Time = math.Round(180*FS_Harvest_Time_Modifier);
FS_Lemon_Harvest_Amount = 6;
FS_Lemon_Price = math.Round(95*FS_Price_Modifier);
FS_Lemon_MaxHold = 15;

-- Potato config.
FS_Potato_Hunger = 25;
FS_Potato_Health = 25;
FS_Potato_Color = Color(125, 82, 17, 255);
FS_Potato_Seed_Time = math.Round(600*FS_Seed_Time_Modifier);
FS_Potato_Harvest_Time = math.Round(170*FS_Harvest_Time_Modifier);
FS_Potato_Harvest_Amount = 8;
FS_Potato_Price = math.Round(25*FS_Price_Modifier);
FS_Potato_MaxHold = 20;

-- Box config.
FS_Box_CanBeDestroyed = true;
FS_Box_Health = 500;
FS_Box_ContentScaleOnDestroyed = 0.25; -- If box had 100 tomatoes inside, it gonna drop 50 if got destroyed, scale to 0 if you don't want box to drop content when destroyed.
FS_Box_MaxHold_Modifier = 5; -- For example space for melons it's a user's default space*5.
FS_Box_Text_Color = Color(240, 228, 55, 255);
FS_Box_MaxHold_Melon = math.Round(FS_Melon_MaxHold*FS_Box_MaxHold_Modifier);
FS_Box_MaxHold_Cabbage = math.Round(FS_Cabbage_MaxHold*FS_Box_MaxHold_Modifier);
FS_Box_MaxHold_Watermelon = math.Round(FS_Watermelon_MaxHold*FS_Box_MaxHold_Modifier);
FS_Box_MaxHold_Tomato = math.Round(FS_Tomato_MaxHold*FS_Box_MaxHold_Modifier);
FS_Box_MaxHold_Orange = math.Round(FS_Orange_MaxHold*FS_Box_MaxHold_Modifier);
FS_Box_MaxHold_Apple = math.Round(FS_Apple_MaxHold*FS_Box_MaxHold_Modifier);
FS_Box_MaxHold_Lemon = math.Round(FS_Lemon_MaxHold*FS_Box_MaxHold_Modifier);
FS_Box_MaxHold_Potato = math.Round(FS_Potato_MaxHold*FS_Box_MaxHold_Modifier);


--[[
-- There are no good model for palm :(
-- Banana config.
FS_Banana_Hunger = 25;
FS_Banana_Health = 25;
FS_Banana_Color = Color(255, 232, 30, 255);
FS_Banana_Seed_Time = 10;
FS_Banana_Harvest_Time = 60;
FS_Banana_Harvest_Amount = 3;
]]--