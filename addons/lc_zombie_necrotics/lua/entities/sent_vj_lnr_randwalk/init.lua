AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted, 
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.SingleSpawner = true
ENT.Model = {"models/props_junk/popcan01a.mdl"} 
ENT.EntitiesToSpawn = {
	{EntityName = "NPC1",SpawnPosition = {vForward=0,vRight=0,vUp=0},Entities = {"npc_vj_lnr_hevwal","npc_vj_lnr_cheaplewal","npc_vj_lnr_combwalweapon","npc_vj_lnr_femalewalweapon","npc_vj_lnr_femalewallimbless","npc_vj_lnr_malewallimbless","npc_vj_lnr_malewalweapon","npc_vj_lnr_corpsewal","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lncb","npc_vj_lnr_lnhl2mm","npc_vj_lnr_lnhl2mf","npc_vj_lnr_lnmr","npc_vj_lnr_lnfr","npc_vj_lnr_lnmm","npc_vj_lnr_lnfm"}},
}
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted, 
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/