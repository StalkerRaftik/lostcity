AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted, 
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.SingleSpawner = true -- If set to true, it will spawn the entities once then remove itself
ENT.Model = {"models/props_junk/popcan01a.mdl"} -- The models it should spawn with | Picks a random one from the table
ENT.EntitiesToSpawn = {
	{EntityName = "NPC1",SpawnPosition = {vForward=0,vRight=0,vUp=0},Entities = {"npc_vj_l4d_com_male","npc_vj_l4d_com_male","npc_vj_l4d_com_male","npc_vj_l4d_com_male","npc_vj_l4d_com_male","npc_vj_l4d_com_male","npc_vj_l4d_com_male","npc_vj_l4d_com_male","npc_vj_l4d_com_male","npc_vj_l4d_com_male","npc_vj_l4d_com_male","npc_vj_l4d_com_male","npc_vj_l4d_com_male","npc_vj_l4d_com_male","npc_vj_l4d_com_male","npc_vj_l4d_com_female","npc_vj_l4d_com_female","npc_vj_l4d_com_female","npc_vj_l4d_com_female","npc_vj_l4d_com_female","npc_vj_l4d_com_female","npc_vj_l4d_com_female","npc_vj_l4d_com_female","npc_vj_l4d_com_female","npc_vj_l4d_com_female","npc_vj_l4d_com_female","npc_vj_l4d_com_female","npc_vj_l4d_com_female","npc_vj_l4d_com_female","npc_vj_l4d_com_female","npc_vj_l4d_com_fem_nurse","npc_vj_l4d_com_fem_nurse","npc_vj_l4d_com_fem_nurse","npc_vj_l4d_com_fem_nurse","npc_vj_l4d_com_m_hospital","npc_vj_l4d_com_m_hospital","npc_vj_l4d_com_m_hospital","npc_vj_l4d_com_m_hospital","npc_vj_l4d_com_m_airport","npc_vj_l4d_com_m_airport","npc_vj_l4d_com_m_airport","npc_vj_l4d_com_m_airport","npc_vj_l4d_com_m_police","npc_vj_l4d_com_m_police","npc_vj_l4d_com_m_police","npc_vj_l4d_com_m_police","npc_vj_l4d_com_m_soldier","npc_vj_l4d_com_m_soldier","npc_vj_l4d_com_m_soldier","npc_vj_l4d_com_m_soldier","npc_vj_l4d_com_m_ceda","npc_vj_l4d_com_m_ceda","npc_vj_l4d_com_m_ceda","npc_vj_l4d_com_m_fallsur","npc_vj_l4d_com_m_fallsur","npc_vj_l4d_com_m_fallsur","npc_vj_l4d_com_m_clown","npc_vj_l4d_com_m_clown","npc_vj_l4d_com_m_clown","npc_vj_l4d_com_m_clown","npc_vj_l4d_com_m_mudmen","npc_vj_l4d_com_m_mudmen","npc_vj_l4d_com_m_mudmen","npc_vj_l4d_com_m_worker","npc_vj_l4d_com_m_worker","npc_vj_l4d_com_m_worker","npc_vj_l4d_com_m_riot","npc_vj_l4d_com_m_riot","npc_vj_l4d_com_m_riot","npc_vj_l4d_com_m_jimmy"}},
}
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted, 
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/