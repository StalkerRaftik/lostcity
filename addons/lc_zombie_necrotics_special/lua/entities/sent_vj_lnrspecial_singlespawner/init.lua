AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted, 
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.SingleSpawner = false
ENT.Model = {"models/props_junk/popcan01a.mdl"} 
ENT.EntitiesToSpawn = {
	{EntityName = "NPC1",SpawnPosition = {vForward=0,vRight=0,vUp=0},Entities = {
	"npc_vj_lnr_fatso",
	"npc_vj_lnr_punk",
	"npc_vj_lnr_drowner_ground",
	"npc_vj_lnr_nh2_secshield",
	"npc_vj_lnr_carrier",
	"npc_vj_lnr_hazwal",
	"npc_vj_lnr_hazinf",
	"npc_vj_lnr_brute",
	"npc_vj_lnr_flamzom",
	"npc_vj_lnr_walbomber",
	"npc_vj_lnr_infbomber",
	"npc_vj_lnr_eleczom",
	"npc_vj_lnr_ravager",
	"npc_vj_lnr_healer",
	"npc_vj_lnr_nh2_secinf",
	"npc_vj_lnr_nh2_sec",
	"npc_vj_lnr_butcher",
	"npc_vj_lnr_spitter",
	"npc_vj_lnr_shambler",
	"npc_vj_lnr_evo"
	}},
}
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted, 
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/