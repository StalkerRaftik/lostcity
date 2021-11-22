AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_lnrhl2/humans/group02/male_01.mdl","models/vj_lnrhl2/humans/group02/male_02.mdl","models/vj_lnrhl2/humans/group02/male_03.mdl","models/vj_lnrhl2/humans/group02/male_04.mdl","models/vj_lnrhl2/humans/group02/male_05.mdl","models/vj_lnrhl2/humans/group02/male_06.mdl","models/vj_lnrhl2/humans/group02/male_07.mdl","models/vj_lnrhl2/humans/group02/male_08.mdl","models/vj_lnrhl2/humans/group02/male_09.mdl"} 
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
if GetConVarNumber("vj_LNR_CitizenSkins") == 1 then
self:SetSkin( math.random(0,3))

elseif GetConVarNumber("vj_LNR_CitizenSkins") == 0 then
self:SetSkin( math.random(0,47))
end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/