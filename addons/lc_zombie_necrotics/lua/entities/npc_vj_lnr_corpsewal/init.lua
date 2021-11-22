AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_lnrhl2/corpse_walker.mdl"} 
ENT.LN_Run = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()	
if GetConVarNumber("vj_LNR_CitizenSkins") == 1 && self:GetModel() == "models/vj_lnrhl2/corpse_walker.mdl" then
self:SetSkin(math.random(0,2))
	   
elseif GetConVarNumber("vj_LNR_CitizenSkins") == 0 && self:GetModel() == "models/vj_lnrhl2/corpse_walker.mdl" then
self:SetSkin(math.random(0,8))	   
end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetUpGibesOnDeath(dmginfo,hitgroup)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo,hitgroup,GetCorpse)
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/