AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted, 
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/props_junk/popcan01a.mdl"} -- The models it should spawn with | Picks a random one from the table
ENT.EntitiesToSpawn = {
	{EntityName = "NPC1",SpawnPosition = {vForward=50,vRight=0,vUp=0},Entities = {"npc_vj_lnr_cheapleinf","npc_vj_lnr_combinfweapon","npc_vj_lnr_maleinfweapon","npc_vj_lnr_femaleinfweapon","npc_vj_lnr_cbinf","npc_vj_lnr_fcinf","npc_vj_lnr_fminf","npc_vj_lnr_frinf","npc_vj_lnr_hl2mfinf","npc_vj_lnr_hl2mminf","npc_vj_lnr_mcinf","npc_vj_lnr_mminf","npc_vj_lnr_mrinf"}},

}
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted, 
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/