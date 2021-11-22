AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/cpthazama/l4d1/common/common_military_male01.mdl" -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = GetConVarNumber("vj_l4d_com_h_soldier")

ENT.SoundTbl_FootStep = {"vj_l4d_com/footstep/concrete1.wav","vj_l4d_com/footstep/concrete2.wav","vj_l4d_com/footstep/concrete3.wav","vj_l4d_com/footstep/concrete4.wav"}

ENT.FootStepSoundLevel = 80
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Zombie_CustomOnInitialize()
	self:SetBodygroup(0,math.random(0,3))
	self:SetSkin(math.random(0,15))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Zombie_Gibs(gType)
	if gType == "h" then
		self:SetBodygroup(0,4)
		self:SetBodygroup(1,1)
	elseif gType == "la" then
		self:SetBodygroup(1,3)
	elseif gType == "ra" then
		self:SetBodygroup(1,2)
	elseif gType == "ll" then
		self:SetBodygroup(2,2)
	elseif gType == "rl" then
		self:SetBodygroup(2,1)
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/