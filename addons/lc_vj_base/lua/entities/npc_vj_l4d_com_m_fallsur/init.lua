AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/l4d2/common/common_male_fallen_survivor.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = GetConVarNumber("vj_l4d_com_h_fallsur")
ENT.AllowedToGib = false -- Is it allowed to gib in general? This can be on death or when shot in a certain place
ENT.ItemDropsOnDeathChance = 1 -- If set to 1, it will always drop it
ENT.ItemDropsOnDeath_EntityList = {
    "tfa_ammo_357",
    "tfa_ammo_ar2",
    "tfa_ammo_pistol",
    "tfa_ammo_smg",
	"tfa_ammo_buckshot",
	"tfa_ammo_winchester",
	"ent_bandage",
	"ent_medkit",
	"ent_shina",
	"ent_smallmedkit",
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Zombie_CustomOnInitialize()
	self:SetBodygroup(1,math.random(0,2))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo,hitgroup)
	if hitgroup == HITGROUP_HEAD then
		dmginfo:ScaleDamage(0.75)
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/