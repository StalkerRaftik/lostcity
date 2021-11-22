/*--------------------------------------------------
	=============== Autorun File ===============
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
------------------ Addon Information ------------------
local PublicAddonName = "Lethal Necrotics Reanimated: Half-Life 2"
local AddonName = "Lethal Necrotics Reanimated: Half-Life 2"
local AddonType = "SNPC"
local AutorunFile = "autorun/vj_lnrhl2_autorun.lua"
-------------------------------------------------------
local VJExists = file.Exists("lua/autorun/vj_base_autorun.lua","GAME")
if VJExists == true then
	include('autorun/vj_controls.lua')

 --    VJ.AddCategoryInfo("LNR: HL2", {Icon = "lnr/icons/lnr.png"})
	-- VJ.AddCategoryInfo("LNR: Misc", {Icon = "lnr/icons/lnr.png"})
	-- VJ.AddCategoryInfo("LNR: Entities", {Icon = "lnr/icons/lnr.png"})
	-- VJ.AddCategoryInfo("LNR: Specials", {Icon = "lnr/icons/lnr.png"})
 --    VJ.AddCategoryInfo("LNR: CSS", {Icon = "lnr/icons/lnr.png"})
	-- VJ.AddCategoryInfo("LNR: HLS", {Icon = "lnr/icons/lnr.png"})
	-- VJ.AddCategoryInfo("LNR: TF2", {Icon = "lnr/icons/lnr.png"})
 --    VJ.AddCategoryInfo("LNR: Extras", {Icon = "lnr/icons/lnr.png"})	
	-- VJ.AddCategoryInfo("LNR: Halloween", {Icon = "lnr/icons/lnrhalloween.png"})

	local vCat = "LNR: HL2"
	
	VJ.AddNPC("Main Walker (Male)","npc_vj_lnr_lnhl2mm",vCat) 
	VJ.AddNPC("Main Walker (Female)","npc_vj_lnr_lnhl2mf",vCat) 
	VJ.AddNPC("Citizen Walker (Male)","npc_vj_lnr_lnmc",vCat) 
	VJ.AddNPC("Citizen Walker (Female)","npc_vj_lnr_lnfc",vCat) 
	VJ.AddNPC("Rebel Walker (Male)","npc_vj_lnr_lnmr",vCat) 
	VJ.AddNPC("Rebel Walker (Female)","npc_vj_lnr_lnfr",vCat) 
	VJ.AddNPC("Medic Walker (Male)","npc_vj_lnr_lnmm",vCat) 
	VJ.AddNPC("Medic Walker (Female)","npc_vj_lnr_lnfm",vCat) 
	VJ.AddNPC("Combine Walker","npc_vj_lnr_lncb",vCat) 
	VJ.AddNPC("Citizen Infected (Male)","npc_vj_lnr_mcinf",vCat) 
	VJ.AddNPC("Citizen Infected (Female)","npc_vj_lnr_fcinf",vCat) 
	VJ.AddNPC("Combine Infected","npc_vj_lnr_cbinf",vCat) 
	VJ.AddNPC("Main Infected (Male)","npc_vj_lnr_hl2mminf",vCat) 
	VJ.AddNPC("Main Infected (Female)","npc_vj_lnr_hl2mfinf",vCat) 
	VJ.AddNPC("Rebel Infected (Male)","npc_vj_lnr_mrinf",vCat)  
	VJ.AddNPC("Rebel Infected (Female)","npc_vj_lnr_frinf",vCat) 
	VJ.AddNPC("Medic Infected (Male)","npc_vj_lnr_mminf",vCat) 
    VJ.AddNPC("Medic Infected (Female)","npc_vj_lnr_fminf",vCat) 
    VJ.AddNPC("Cheaple Walker","npc_vj_lnr_cheaplewal",vCat) 
    VJ.AddNPC("Cheaple Infected","npc_vj_lnr_cheapleinf",vCat)
    VJ.AddNPC("Crawler (Male)","npc_vj_lnr_malecrawl",vCat) 
	VJ.AddNPC("Crawler (Female)","npc_vj_lnr_femalecrawl",vCat)
	VJ.AddNPC("Combine Crawler","npc_vj_lnr_combcrawl",vCat)
	VJ.AddNPC("Corpse Walker","npc_vj_lnr_corpsewal",vCat)
	VJ.AddNPC("HEV Walker","npc_vj_lnr_hevwal",vCat)
	VJ.AddNPC("Zombie","npc_vj_lnr_zombi","LNR: Misc")
	VJ.AddNPC("Zombie Corpse","npc_vj_lnr_zombi_corpse","LNR: Misc")
	VJ.AddNPC("Tarman","npc_vj_lnr_tarman","LNR: Misc")
	VJ.AddNPC("Limbless Walker (Male)","npc_vj_lnr_malewallimbless",vCat) 
	VJ.AddNPC("Limbless Walker (Female)","npc_vj_lnr_femalewallimbless",vCat)
	VJ.AddNPC("Combine Walker (Weapon)","npc_vj_lnr_combwalweapon",vCat)
	VJ.AddNPC("Weapon Walker (Male)","npc_vj_lnr_malewalweapon",vCat) 
	VJ.AddNPC("Weapon Walker (Female)","npc_vj_lnr_femalewalweapon",vCat)
	VJ.AddNPC("Combine Infected (Weapon)","npc_vj_lnr_combinfweapon",vCat)
	VJ.AddNPC("Weapon Infected (Male)","npc_vj_lnr_maleinfweapon",vCat) 
	VJ.AddNPC("Weapon Infected (Female)","npc_vj_lnr_femaleinfweapon",vCat)
	VJ.AddNPC("Headless Walker (Male)","npc_vj_lnr_maleheadlesswal",vCat)
	VJ.AddNPC("Headless Walker (Female)","npc_vj_lnr_femaleheadlesswal",vCat)
		
    -- Random and Spawners --	
	VJ.AddNPC("Random Infected","sent_vj_lnr_randinf",vCat)
	VJ.AddNPC("Random Infected Spawner","sent_vj_lnr_randinfspawner",vCat)
	VJ.AddNPC("Random Walker","sent_vj_lnr_randwalk",vCat)
	VJ.AddNPC("Random Walker Spawner","sent_vj_lnr_randwalkspawner",vCat)
	VJ.AddNPC("Random Crawler","sent_vj_lnr_randcrawl",vCat)
	VJ.AddNPC("Random Crawler Spawner","sent_vj_lnr_randcrawlspawner",vCat)
	VJ.AddNPC("Random Walker Spawner (Single)","sent_vj_lnr_singlewalkspawner",vCat)
	VJ.AddNPC("Random Infected Spawner (Single)","sent_vj_lnr_singleinfspawner",vCat)
	VJ.AddNPC("Random Crawler Spawner (Single)","sent_vj_lnr_singlecrawlspawner",vCat)
	VJ.AddNPC("Zombie Map Spawner","sent_vj_lnr_mapspawner",vCat)
	VJ.AddNPC("Random Infected Horde","sent_vj_lnr_infhorde",vCat)
	VJ.AddNPC("Random Walker Horde","sent_vj_lnr_walhorde",vCat)
	VJ.AddNPC("Zombie Spawner","sent_vj_lnr_zombispawner",vCat)
	VJ.AddNPC("Random Zombie","sent_vj_lnr_randzombie",vCat)
	VJ.AddNPC("Random Zombie Spawner","sent_vj_lnr_randzombiespawner",vCat)
	VJ.AddNPC("Random Zombie Spawner (Single)","sent_vj_lnr_singlezombiespawner",vCat)
	VJ.AddNPC("Random Walker Spawner (Citizens)","sent_vj_lnr_randwalkspawner_citizen",vCat)
	VJ.AddNPC("Random Walker Spawner (Rebels/Medics)","sent_vj_lnr_randwalkspawner_rebmed",vCat)
	VJ.AddNPC("Random Walker Spawner (Main Characters)","sent_vj_lnr_randwalkspawner_mainchar",vCat)
	VJ.AddNPC("Random Walker Spawner (Combines)","sent_vj_lnr_randwalkspawner_combine",vCat)
	VJ.AddNPC("Random Infected Spawner (Citizens)","sent_vj_lnr_randinfspawner_citizen",vCat)
	VJ.AddNPC("Random Infected Spawner (Rebels/Medics)","sent_vj_lnr_randinfspawner_rebmed",vCat)
	VJ.AddNPC("Random Infected Spawner (Main Characters)","sent_vj_lnr_randinfspawner_mainchar",vCat)
	VJ.AddNPC("Random Infected Spawner (Combines)","sent_vj_lnr_randinfspawner_combine",vCat)
	
	-- Misc -- For testing etc
    VJ.AddNPC("Infected","npc_vj_lnr_baseinf","VJ Base")
    VJ.AddNPC("Walker","npc_vj_lnr_basewalker","VJ Base") 
	VJ.AddNPC("Zombie","npc_vj_lnr_zombi_rising","VJ Base")
	VJ.AddNPC("Zombie Corpse","npc_vj_lnr_zombi_rising_corpse","VJ Base")

    -- Infection Entities 
    VJ.AddEntity("Infected Sample","sent_vj_lnr_infectioninf","Darkborn",true,0,true,"LNR: Entities") 
    VJ.AddEntity("Walker Sample","sent_vj_lnr_infectionwal","Darkborn",true,0,true,"LNR: Entities")
    VJ.AddEntity("Infected Barrel","sent_vj_lnr_barrelinf","Darkborn",true,0,true,"LNR: Entities")
    VJ.AddEntity("Walker Barrel","sent_vj_lnr_barrelwal","Darkborn",true,0,true,"LNR: Entities")

	-- Precache Models: Main Characters etc --
	util.PrecacheModel("models/vj_lnrhl2/corpse_walker.mdl")
	util.PrecacheModel("models/vj_lnrhl2/elitepolice.mdl")
	util.PrecacheModel("models/vj_lnrhl2/male_cheaple.mdl")
	util.PrecacheModel("models/vj_lnrhl2/hl2infected/elitepolice.mdl")
	util.PrecacheModel("models/vj_lnrhl2/zombi.mdl")
	util.PrecacheModel("models/vj_lnrhl2/alyx.mdl")
	util.PrecacheModel("models/vj_lnrhl2/barney.mdl")
	util.PrecacheModel("models/vj_lnrhl2/breen.mdl")
	util.PrecacheModel("models/vj_lnrhl2/combine_soldier.mdl")
	util.PrecacheModel("models/vj_lnrhl2/combine_soldier_prisonguard.mdl")
	util.PrecacheModel("models/vj_lnrhl2/combine_super_soldier.mdl")
	util.PrecacheModel("models/vj_lnrhl2/eli.mdl")
	util.PrecacheModel("models/vj_lnrhl2/fisherman.mdl")
	util.PrecacheModel("models/vj_lnrhl2/gman.mdl")
	util.PrecacheModel("models/vj_lnrhl2/kleiner.mdl")
	util.PrecacheModel("models/vj_lnrhl2/magnusson.mdl")
	util.PrecacheModel("models/vj_lnrhl2/monk.mdl")
	util.PrecacheModel("models/vj_lnrhl2/mossman.mdl")
	util.PrecacheModel("models/vj_lnrhl2/odessa.mdl")
	util.PrecacheModel("models/vj_lnrhl2/police.mdl")
-- Citizens --	
	util.PrecacheModel("models/vj_lnrhl2/humans/group01/female_01.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group01/female_02.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group01/female_03.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group01/female_04.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group01/female_06.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group01/female_07.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group01/male_01.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group01/male_02.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group01/male_03.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group01/male_04.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group01/male_05.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group01/male_06.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group01/male_07.mdl") 
	util.PrecacheModel("models/vj_lnrhl2/humans/group01/male_08.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group01/male_09.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group02/female_01.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group02/female_02.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group02/female_03.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group02/female_04.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group02/female_06.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group02/female_07.mdl") 
	util.PrecacheModel("models/vj_lnrhl2/humans/group02/male_01.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group02/male_02.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group02/male_03.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group02/male_04.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group02/male_05.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group02/male_06.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group02/male_07.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group02/male_08.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group02/male_09.mdl")	
-- Rebels --	
	util.PrecacheModel("models/vj_lnrhl2/humans/group03/female_01.mdl") 
	util.PrecacheModel("models/vj_lnrhl2/humans/group03/female_02.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03/female_03.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03/female_04.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03/female_06.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03/female_07.mdl") 
	util.PrecacheModel("models/vj_lnrhl2/humans/group03/male_01.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03/male_02.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03/male_03.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03/male_04.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03/male_05.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03/male_06.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03/male_07.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03/male_08.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03/male_09.mdl")	
	util.PrecacheModel("models/vj_lnrhl2/humans/group03in/female_01.mdl") 
	util.PrecacheModel("models/vj_lnrhl2/humans/group03in/female_02.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03in/female_03.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03in/female_04.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03in/female_06.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03in/female_07.mdl") 
	util.PrecacheModel("models/vj_lnrhl2/humans/group03in/male_01.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03in/male_02.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03in/male_03.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03in/male_04.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03in/male_05.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03in/male_06.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03in/male_07.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03in/male_08.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03in/male_09.mdl")	
-- Medics --	
	util.PrecacheModel("models/vj_lnrhl2/humans/group03m/female_01.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03m/female_02.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03m/female_03.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03m/female_04.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03m/female_06.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03m/female_07.mdl") 
	util.PrecacheModel("models/vj_lnrhl2/humans/group03m/male_01.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03m/male_02.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03m/male_03.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03m/male_04.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03m/male_05.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03m/male_06.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03m/male_07.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03m/male_08.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03m/male_09.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03min/female_01.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03min/female_02.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03min/female_03.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03min/female_04.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03min/female_06.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03min/female_07.mdl") 
	util.PrecacheModel("models/vj_lnrhl2/humans/group03min/male_01.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03min/male_02.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03min/male_03.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03min/male_04.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03min/male_05.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03min/male_06.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03min/male_07.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03min/male_08.mdl")
	util.PrecacheModel("models/vj_lnrhl2/humans/group03min/male_09.mdl")
-- Etc --	
	util.PrecacheModel("models/vj_lnrhl2/infectedhl2/alyx.mdl")
	util.PrecacheModel("models/vj_lnrhl2/infectedhl2/barney.mdl")
	util.PrecacheModel("models/vj_lnrhl2/infectedhl2/breen.mdl")
	util.PrecacheModel("models/vj_lnrhl2/infectedhl2/combine_soldier.mdl")
	util.PrecacheModel("models/vj_lnrhl2/infectedhl2/combine_soldier_prisonguard.mdl")
	util.PrecacheModel("models/vj_lnrhl2/infectedhl2/combine_super_soldier.mdl")
	util.PrecacheModel("models/vj_lnrhl2/infectedhl2/eli.mdl")
	util.PrecacheModel("models/vj_lnrhl2/infectedhl2/fisherman.mdl")
	util.PrecacheModel("models/vj_lnrhl2/infectedhl2/gman.mdl")
	util.PrecacheModel("models/vj_lnrhl2/infectedhl2/kleiner.mdl")
	util.PrecacheModel("models/vj_lnrhl2/infectedhl2/magnusson.mdl")
	util.PrecacheModel("models/vj_lnrhl2/infectedhl2/monk.mdl")
	util.PrecacheModel("models/vj_lnrhl2/infectedhl2/mossman.mdl")
	util.PrecacheModel("models/vj_lnrhl2/infectedhl2/odessa.mdl")
	util.PrecacheModel("models/vj_lnrhl2/infectedhl2/police.mdl") 
	util.PrecacheModel("models/vj_lnrhl2/tarman.mdl")
	util.PrecacheModel("models/vj_lnrhl2/lnr_hev_corpse.mdl")
	util.PrecacheModel("models/props/de_train/barrel.mdl")	
	util.PrecacheModel("models/props_lab/jar01b.mdl")
	
	-- ConVars --
	local AddConvars = {}
	AddConvars["vj_LNR_Walker_DamageModifier"] = 1
	AddConvars["vj_LNR_Walker_HealthModifier"] = 1
	AddConvars["vj_LNR_Infected_DamageModifier"] = 1
	AddConvars["vj_LNR_Infected_HealthModifier"] = 1
	AddConvars["vj_LNR_Infection"] = 1
	AddConvars["vj_LNR_InfectionDamage"] = 1
	AddConvars["vj_LNR_Leap"] = 1
	AddConvars["vj_LNR_InfectionTime"] = 10
	AddConvars["vj_LNR_BleedDamage"] = 1
	AddConvars["vj_LNR_BleedChance"] = 2
	AddConvars["vj_LNR_BleedTime"] = 2
	AddConvars["vj_LNR_BleedReps"] = 5
	AddConvars["vj_LNR_SlowTime"] = 1
	AddConvars["vj_LNR_LeapDamage"] = 1
	AddConvars["vj_LNR_Gib"] = 1
	AddConvars["vj_LNR_DeathAnimations"] = 1
	AddConvars["vj_LNR_CitizenSkins"] = 0
	AddConvars["vj_LNR_Run"] = 1
	AddConvars["vj_LNR_Alert"] = 1
	AddConvars["vj_LNR_Eyes"] = 1
	AddConvars["vj_LNR_WalkerRun"] = 0
	AddConvars["vj_LNR_Headshot"] = 0
	--AddConvars["vj_LNR_InfectedPlayer"] = 0
	
-- Map Spawner ConVars
    AddConvars["vj_LNR_MapSpawner_HL2"] = 1
	AddConvars["vj_LNR_MapSpawner_Specials"] = 0
	AddConvars["vj_LNR_MapSpawner_CSS"] = 0
	AddConvars["vj_LNR_MapSpawner_HLS"] = 0
	AddConvars["vj_LNR_MapSpawner_TF2"] = 0
	AddConvars["vj_LNR_MapSpawner_L4D"] = 0
	AddConvars["vj_LNR_MapSpawner_Extras"] = 0	
	--AddConvars["vj_LNR_MapSpawner_Portal"] = 0
	--AddConvars["vj_LNR_MapSpawner_BM"] = 0
	--AddConvars["vj_LNR_MapSpawner_DODS"] = 0		
	
		for k, v in pairs(AddConvars) do
		if !ConVarExists( k ) then CreateConVar( k, v, {FCVAR_ARCHIVE} ) end
	end
	
if (CLIENT) then
local function VJ_LNR_MAIN(Panel)
			if !game.SinglePlayer() then
			if !LocalPlayer():IsAdmin() or !LocalPlayer():IsSuperAdmin() then
				Panel:AddControl( "Label", {Text = "You are not an admin!"})
				Panel:ControlHelp("Note: Only admins can change these settings!")
return
	end
end
			Panel:AddControl( "Label", {Text = "Note: Only admins can change these settings!"})
			local vj_lnrreset = {Options = {}, CVars = {}, Label = "Reset Everything:", MenuButton = "0"}
			vj_lnrreset.Options["#vjbase.menugeneral.default"] = { 
				vj_LNR_Walker_DamageModifier = "1",
				vj_LNR_Walker_HealthModifier = "1",
				vj_LNR_Infected_DamageModifier = "1",
				vj_LNR_Infected_HealthModifier = "1",
				vj_LNR_Infection = "1",
				vj_LNR_InfectionDamage = "1",
				vj_LNR_Leap = "1",
				vj_LNR_InfectionTime = "10",
				vj_LNR_BleedChance = "2",					
				vj_LNR_BleedTime = "2",				
				vj_LNR_BleedReps = "1",				
				vj_LNR_SlowTime = "1",
				vj_LNR_BleedDamage = "1",
				vj_LNR_LeapDamage = "1",
				vj_LNR_Gib = "1",
				vj_LNR_DeathAnimations = "1",
				vj_LNR_CitizenSkins = "0",
				vj_LNR_Run = "1",
				vj_LNR_Alert = "1",
				vj_LNR_Eyes = "1",
				vj_LNR_WalkerRun = "0",
				vj_LNR_Headshot = "0",
				--vj_LNR_InfectedPlayer = "0",
}
Panel:AddControl("ComboBox", vj_lnrreset)
Panel:ControlHelp("NOTE: Only Future Spawned SNPCs will be affected!")
Panel:AddControl("Checkbox", {Label ="Zombies can infect Players/(S)NPCs?", Command ="vj_LNR_Infection"})
Panel:ControlHelp("Note: Only ValveBiped skeleton models will be affected by the infection system.")
Panel:AddControl("Checkbox", {Label ="Zombies can inflict infection damage?", Command ="vj_LNR_InfectionDamage"})
Panel:ControlHelp("Bleed damage and Slow effect.")
Panel:AddControl("Checkbox", {Label ="Walkers can Leap attack?", Command ="vj_LNR_Leap"})
Panel:AddControl("Checkbox", {Label ="Zombies can gib?", Command ="vj_LNR_Gib"})
Panel:ControlHelp("Note: Only some Zombies can gib.")
Panel:AddControl("Checkbox", {Label ="Zombies have death animations?", Command ="vj_LNR_DeathAnimations"})
Panel:AddControl("Checkbox", {Label ="Zombies have a chance to activate Rage Mode?", Command ="vj_LNR_Run"})
Panel:AddControl("Checkbox", {Label ="Citizen Zombies only have HL2 skins?", Command ="vj_LNR_CitizenSkins"})
Panel:AddControl("Checkbox", {Label ="Zombies can alert other zombies?", Command ="vj_LNR_Alert"})
Panel:ControlHelp("Note: Can be helpful on performance when disabled.")
Panel:AddControl("Checkbox", {Label ="Walkers can run?", Command ="vj_LNR_WalkerRun"})
Panel:AddControl("Checkbox", {Label ="Infected Players/(S)NPCs have eye effects?", Command ="vj_LNR_Eyes"})
Panel:AddControl("Checkbox", {Label ="Zombies die from a single headshot?", Command ="vj_LNR_Headshot"})
--Panel:AddControl("Checkbox", {Label ="Players play as Infected upon death?", Command ="vj_LNR_InfectedPlayer"})
Panel:AddControl("Slider", {Label ="Walker Health",Command ="vj_LNR_Walker_HealthModifier",Min = "1",Max = "100"})
Panel:AddControl("Slider", {Label ="Walker Damage",Command ="vj_LNR_Walker_DamageModifier",Min = "1",Max = "100"})
Panel:AddControl("Slider", {Label ="Infected Health",Command ="vj_LNR_Infected_HealthModifier",Min = "1",Max = "100"})
Panel:AddControl("Slider", {Label ="Infected Damage",Command ="vj_LNR_Infected_DamageModifier",Min = "1",Max = "100"})
Panel:AddControl("Slider", {Label ="Bleed Damage",Command ="vj_LNR_BleedDamage",Min = "1",Max = "200"})
Panel:AddControl("Slider", {Label ="Bleed Damage Chance",Command ="vj_LNR_BleedChance",Min = "1",Max = "5"})
Panel:AddControl("Slider", {Label ="Bleed Damage Reps",Command ="vj_LNR_BleedReps",Min = "1",Max = "15"})
Panel:AddControl("Slider", {Label ="Bleed Damage Time",Command ="vj_LNR_BleedTime",Min = "1",Max = "60"})
Panel:AddControl("Slider", {Label ="Slow Effect Time",Command ="vj_LNR_SlowTime",Min = "1",Max = "100"})
Panel:AddControl("Slider", {Label ="Leap Damage",Command ="vj_LNR_LeapDamage",Min = "1",Max = "100"})
Panel:ControlHelp("Health and Damage will be Doubled the amount they have if changed.")
Panel:AddControl("Slider", {Label ="Infection Time",Command ="vj_LNR_InfectionTime",Min = "5",Max = "60"})
Panel:ControlHelp("Amount of time until the Infected Players/(S)NPCs turn.")
Panel:AddPanel(typebox)

end
	function VJ_ADDTOMENU_LNR(Panel)
		spawnmenu.AddToolMenuOption("DrVrej","SNPC Configures","LNR","LNR","","", VJ_LNR_MAIN, {} )
end
		hook.Add("PopulateToolMenu","VJ_ADDTOMENU_LNR", VJ_ADDTOMENU_LNR )
end

if (CLIENT) then
local function VJ_LNR_MAPSPAWNER(Panel)
			if !game.SinglePlayer() then
			if !LocalPlayer():IsAdmin() or !LocalPlayer():IsSuperAdmin() then
				Panel:AddControl( "Label", {Text = "You are not an admin!"})
				Panel:ControlHelp("Note: Only admins can change these settings!")
return
	end
end
			Panel:AddControl( "Label", {Text = "Note: Only admins can change these settings!"})
			local vj_lnrreset_mapspawner = {Options = {}, CVars = {}, Label = "Reset Everything:", MenuButton = "0"}
			vj_lnrreset_mapspawner.Options["#vjbase.menugeneral.default"] = { 
			    vj_LNR_MapSpawner_HL2 = "1",
				vj_LNR_MapSpawner_Specials = "0",
				vj_LNR_MapSpawner_CSS = "0",
				vj_LNR_MapSpawner_HLS = "0",
				vj_LNR_MapSpawner_TF2 = "0",
				vj_LNR_MapSpawner_L4D = "0",
				vj_LNR_MapSpawner_Extras = "0",
				--vj_LNR_MapSpawner_Portal = "0",
				--vj_LNR_MapSpawner_BM = "0",
				--vj_LNR_MapSpawner_DODS = "0",				

}
Panel:AddControl("ComboBox", vj_lnrreset_mapspawner)
Panel:ControlHelp("NOTE: Only enable if you have the specific addon installed!")
Panel:AddControl("Checkbox", {Label ="LNR: HL2", Command ="vj_LNR_MapSpawner_HL2"})
Panel:AddControl("Checkbox", {Label ="LNR: Specials", Command ="vj_LNR_MapSpawner_Specials"})
Panel:AddControl("Checkbox", {Label ="LNR: CSS", Command ="vj_LNR_MapSpawner_CSS"})
Panel:AddControl("Checkbox", {Label ="LNR: HLS", Command ="vj_LNR_MapSpawner_HLS"})
Panel:AddControl("Checkbox", {Label ="LNR: TF2", Command ="vj_LNR_MapSpawner_TF2"})
Panel:AddControl("Checkbox", {Label ="LNR: L4D", Command ="vj_LNR_MapSpawner_L4D"})
Panel:AddControl("Checkbox", {Label ="LNR: Extras", Command ="vj_LNR_MapSpawner_Extras"})
--Panel:AddControl("Checkbox", {Label ="LNR: Portal", Command ="vj_LNR_MapSpawner_Portal"})
--Panel:AddControl("Checkbox", {Label ="LNR: BM", Command ="vj_LNR_MapSpawner_BM"})
--Panel:AddControl("Checkbox", {Label ="LNR: DODS", Command ="vj_LNR_MapSpawner_DODS"})
Panel:AddPanel(typebox)

end
	function VJ_ADDTOMENU_LNR_MAPSPAWNER(Panel)
		spawnmenu.AddToolMenuOption("DrVrej","SNPC Configures","LNR Map Spawner","LNR Map Spawner","","", VJ_LNR_MAPSPAWNER, {} )
end
		hook.Add("PopulateToolMenu","VJ_ADDTOMENU_LNR_MAPSPAWNER", VJ_ADDTOMENU_LNR_MAPSPAWNER )
end

hook.Add("OnNPCKilled","LNR_Infection_NPC",function(victim,inflictor,attacker)
if attacker.LN_VirusInfection == true && victim:LookupBone("ValveBiped.Bip01_Pelvis") then

      local npc = ents.Create("npc_vj_lnr_baseinf")
	  local bonemerge = ents.Create("lnr_infection")

        if attacker.LN_IsWalker == true then
                    npc = ents.Create("npc_vj_lnr_basewalker")
end
		
		if attacker.LN_IsDrowner == true then
                    npc = ents.Create("npc_vj_lnr_drownerbase")
end

			npc:SetMaterial("nodraw")
            npc:SetPos(victim:GetPos())
            npc:SetAngles(victim:GetAngles())
            npc:Spawn()
            bonemerge:SetColor(victim:GetColor())
            bonemerge:SetSkin(victim:GetSkin())
			bonemerge:SetMaterial(victim:GetMaterial())
            bonemerge:SetModel(victim:GetModel())
			for i = 0, victim:GetNumBodyGroups() -1 do
            bonemerge:SetBodygroup(i,victim:GetBodygroup(i))
end
		    bonemerge:SetPos(npc:GetPos())
            bonemerge:SetParent(npc)
            bonemerge:Spawn()
		    npc.mergedmodel_model = bonemerge:GetModel()	

			
if victim.IsVJBaseSNPC == true then
                victim.HasDeathRagdoll = false
				
            end
			
if victim:IsNPC() then
				victim:Remove()
									
            end			

   victim:Remove()

end	
end)

hook.Add("PlayerDeath","LNR_Infection_Player",function(victim,inflictor,attacker)
if attacker.LN_VirusInfection == true && victim:LookupBone("ValveBiped.Bip01_Pelvis") then
    --print("You've been turned lol")
 
      local npc = ents.Create("npc_vj_lnr_baseinf")
	  local bonemerge = ents.Create("lnr_infection")

        if attacker.LN_IsWalker == true then
                    npc = ents.Create("npc_vj_lnr_basewalker")
end
		
        if attacker.LN_IsDrowner == true then
                    npc = ents.Create("npc_vj_lnr_drownerbase")
end
			npc:SetMaterial("nodraw")
            npc:SetPos(victim:GetPos())
            npc:SetAngles(victim:GetAngles())
            npc:Spawn()
			bonemerge:SetPlayerColor(victim:GetPlayerColor())
            bonemerge:SetColor(victim:GetColor())
            bonemerge:SetSkin(victim:GetSkin())
			bonemerge:SetMaterial(victim:GetMaterial())
            bonemerge:SetModel(victim:GetModel())
		    for i = 0, victim:GetNumBodyGroups() -1 do
            bonemerge:SetBodygroup(i,victim:GetBodygroup(i))
end
            bonemerge:SetPos(npc:GetPos())
            bonemerge:SetParent(npc)
            bonemerge:Spawn()
			npc.mergedmodel_model = bonemerge:GetModel()			 
			
				
if victim:IsPlayer() then
				if IsValid(victim:GetRagdollEntity()) then
					victim:GetRagdollEntity():Remove()
				end				
            end

   victim:Remove()
   
end	
end)

-- !!!!!! DON'T TOUCH ANYTHING BELOW THIS !!!!!! -------------------------------------------------------------------------------------------------------------------------
	AddCSLuaFile(AutorunFile)
	VJ.AddAddonProperty(AddonName,AddonType)
else
	if (CLIENT) then
		chat.AddText(Color(0,200,200),PublicAddonName,
		Color(0,255,0)," was unable to install, you are missing ",
		Color(255,100,0),"VJ Base!")
	end
	timer.Simple(1,function()
		if not VJF then
			if (CLIENT) then
				VJF = vgui.Create("DFrame")
				VJF:SetTitle("ERROR!")
				VJF:SetSize(790,560)
				VJF:SetPos((ScrW()-VJF:GetWide())/2,(ScrH()-VJF:GetTall())/2)
				VJF:MakePopup()
				VJF.Paint = function()
					draw.RoundedBox(8,0,0,VJF:GetWide(),VJF:GetTall(),Color(200,0,0,150))
				end
				
				local VJURL = vgui.Create("DHTML",VJF)
				VJURL:SetPos(VJF:GetWide()*0.005, VJF:GetTall()*0.03)
				VJURL:Dock(FILL)
				VJURL:SetAllowLua(true)
				VJURL:OpenURL("https://sites.google.com/site/vrejgaming/vjbasemissing")
			elseif (SERVER) then
				timer.Create("VJBASEMissing",5,0,function() print("VJ Base is Missing! Download it from the workshop!") end)
			end
		end
	end)
end