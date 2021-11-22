AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted, 
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.SingleSpawner = true
ENT.Model = {"models/props_junk/popcan01a.mdl"} -- The models it should spawn with | Picks a random one from the table
local targetents = {
	"npc_vj_lnr_cbinf",
	"npc_vj_lnr_combinfweapon",
	"npc_vj_lnr_fcinf",
	"npc_vj_lnr_femaleinfweapon",
	"npc_vj_lnr_fminf",
	"npc_vj_lnr_frinf",
	"npc_vj_lnr_hl2mfinf",
	"npc_vj_lnr_hl2mminf",
	"npc_vj_lnr_mcinf",
	"npc_vj_lnr_mminf",
	"npc_vj_lnr_mrinf", 
	"npc_vj_lnr_cheapleinf",

}
ENT.EntitiesToSpawn = {
	{EntityName = "NPC1",SpawnPosition = {vForward=70,vRight=0,vUp=5},Entities = targetents},
	{EntityName = "NPC2",SpawnPosition = {vForward=70,vRight=120,vUp=5},Entities = targetents},
	{EntityName = "NPC3",SpawnPosition = {vForward=120,vRight=120,vUp=5},Entities = targetents},
	{EntityName = "NPC4",SpawnPosition = {vForward=120,vRight=-120,vUp=5},Entities = targetents},

	{EntityName = "NPC5",SpawnPosition = {vForward=170,vRight=0,vUp=5},Entities = targetents},
	{EntityName = "NPC6",SpawnPosition = {vForward=0,vRight=170,vUp=5},Entities = targetents},
	{EntityName = "NPC7",SpawnPosition = {vForward=170,vRight=170,vUp=5},Entities = targetents},
	{EntityName = "NPC8",SpawnPosition = {vForward=170,vRight=-170,vUp=5},Entities = targetents},

	{EntityName = "NPC9",SpawnPosition = {vForward=220,vRight=0,vUp=5},Entities = targetents},
	{EntityName = "NPC10",SpawnPosition = {vForward=0,vRight=220,vUp=5},Entities = targetents},
	{EntityName = "NPC11",SpawnPosition = {vForward=220,vRight=220,vUp=5},Entities = targetents},
	{EntityName = "NPC12",SpawnPosition = {vForward=220,vRight=-220,vUp=5},Entities = targetents},

	{EntityName = "NPC13",SpawnPosition = {vForward=270,vRight=0,vUp=5},Entities = targetents},
	{EntityName = "NPC14",SpawnPosition = {vForward=0,vRight=270,vUp=5},Entities = targetents},
	{EntityName = "NPC15",SpawnPosition = {vForward=250,vRight=270,vUp=5},Entities = targetents},
	{EntityName = "NPC16",SpawnPosition = {vForward=270,vRight=-270,vUp=5},Entities = targetents},

	{EntityName = "NPC17",SpawnPosition = {vForward=320,vRight=0,vUp=5},Entities = targetents},
	{EntityName = "NPC18",SpawnPosition = {vForward=0,vRight=320,vUp=5},Entities = targetents},
	{EntityName = "NPC19",SpawnPosition = {vForward=320,vRight=320,vUp=5},Entities = targetents},
	{EntityName = "NPC20",SpawnPosition = {vForward=320,vRight=-320,vUp=5},Entities = targetents}
}
/*-----------------------------------------------
	*** Copyright (c) 2012-2018 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted, 
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
}