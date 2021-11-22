lmmprivkeyconfig = {} -- DO NOT TOUCH THIS!
lmmprivkeyconfig.DevMode = false -- DO NOT TOUCH THIS! LEAVE THIS FALSE
/*
  _____      _       _  __                                                                 
 |  __ \    (_)     | |/ /                                                                 
 | |__) | __ ___   _| ' / ___ _   _ ___                                                    
 |  ___/ '__| \ \ / /  < / _ \ | | / __|                                                   
 | |   | |  | |\ V /| . \  __/ |_| \__ \                                                   
 |_|   |_|  |_| \_/ |_|\_\___|\__, |___/                                                   
                               __/ |                                                       
  __  __           _        __|___/                                                        
 |  \/  |         | |      |  _ \       _                                                  
 | \  / | __ _  __| | ___  | |_) |_   _(_)                                                 
 | |\/| |/ _` |/ _` |/ _ \ |  _ <| | | |                                                   
 | |  | | (_| | (_| |  __/ | |_) | |_| |_                                                  
 |_|  |_|\__,_|\__,_|\___| |____/ \__, (_)                                                 
                                   __/ |                                                   
 __   __      _      __  __ __  __|___/___       __   __                     _             
 \ \ / /     | |    |  \/  |  \/  /_ |___ \      \ \ / /                    (_)            
  \ V / __  _| |    | \  / | \  / || | __) |_  __ \ V / __ _  __ _ _ __ ___  _ _ __   __ _ 
   > <  \ \/ / |    | |\/| | |\/| || ||__ <\ \/ /  > < / _` |/ _` | '_ ` _ \| | '_ \ / _` |
  / . \  >  <| |____| |  | | |  | || |___) |>  <  / . \ (_| | (_| | | | | | | | | | | (_| |
 /_/ \_\/_/\_\______|_|  |_|_|  |_||_|____//_/\_\/_/ \_\__, |\__,_|_| |_| |_|_|_| |_|\__, |
                                                        __/ |                         __/ |
                                                       |___/                         |___/ 
*/
--[[EDIT BELOW THIS LINE]]--
lmmprivkeyconfig.AllowedRanks = { "founder" } -- The user groups that can make/remove keys

lmmprivkeyconfig.RanksThatHaveKeys = { "admin", "superadmin", "vip", "10000" } -- The ranks that can be redeamed

lmmprivkeyconfig.RemoveKeyAfterUse = true -- Should the key that is made be removed after used? NOTE: IF THE KEY IS LEAKED PEOPLE CAN RE-USE IT!!! (suggested true)

lmmprivkeyconfig.ConsoleCommand = "privkey" -- What should the console command be for people?
--[[EDIT ABOVE THIS LINE]]--
