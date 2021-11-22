AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_lnrhl2/humans/group03min/female_01.mdl","models/vj_lnrhl2/humans/group03min/female_02.mdl","models/vj_lnrhl2/humans/group03min/female_03.mdl","models/vj_lnrhl2/humans/group03min/female_04.mdl","models/vj_lnrhl2/humans/group03min/female_06.mdl","models/vj_lnrhl2/humans/group03min/female_07.mdl"} 
ENT.StartHealth = 100 
ENT.HasItemDropsOnDeath = true 
ENT.ItemDropsOnDeathChance = 4
ENT.ItemDropsOnDeath_EntityList = {"item_healthvial","item_healthkit"}
-------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/