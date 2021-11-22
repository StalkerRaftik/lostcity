/*--------------------------------------------------
	=============== Autorun File ===============
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
------------------ Addon Information ------------------
local PublicAddonName = "Left 4 Dead Common Infected SNPCs"
local AddonName = "Left 4 Dead Common Infected"
local AddonType = "SNPC"
local AutorunFile = "autorun/vj_l4dci_autorun.lua"
-------------------------------------------------------
local VJExists = file.Exists("lua/autorun/vj_base_autorun.lua","GAME")
if VJExists == true then
	include('autorun/vj_controls.lua')

	local vCat = "Left 4 Dead"
	
	-- Male
	VJ.AddNPC("Common Infected (Male)","npc_vj_l4d_com_male",vCat)
	VJ.AddNPC("Common Infected (Soldier)","npc_vj_l4d_com_m_soldier",vCat)
	VJ.AddNPC("Common Infected (Police)","npc_vj_l4d_com_m_police",vCat)
	VJ.AddNPC("Common Infected (Hospital)","npc_vj_l4d_com_m_hospital",vCat)
	VJ.AddNPC("Common Infected (Airport)","npc_vj_l4d_com_m_airport",vCat)
		-- Uncommon
		VJ.AddNPC("Uncommon Infected (CEDA)","npc_vj_l4d_com_m_ceda",vCat)
		VJ.AddNPC("Uncommon Infected (Jimmy)","npc_vj_l4d_com_m_jimmy",vCat)
		VJ.AddNPC("Uncommon Infected (Fallen Survivor)","npc_vj_l4d_com_m_fallsur",vCat)
		VJ.AddNPC("Uncommon Infected (Clown)","npc_vj_l4d_com_m_clown",vCat)
		VJ.AddNPC("Uncommon Infected (Mud Men)","npc_vj_l4d_com_m_mudmen",vCat)
		VJ.AddNPC("Uncommon Infected (Worker)","npc_vj_l4d_com_m_worker",vCat)
		VJ.AddNPC("Uncommon Infected (Riot)","npc_vj_l4d_com_m_riot",vCat)
	
	-- Female
	VJ.AddNPC("Common Infected (Female)","npc_vj_l4d_com_female",vCat)
	VJ.AddNPC("Common Infected (Nurse)","npc_vj_l4d_com_fem_nurse",vCat)
	
	-- Spawners
	VJ.AddNPC("Random Common Infected","sent_vj_l4d_cominf",vCat)
	VJ.AddNPC("Random Common Infected Spawner","sent_vj_l4d_cominf_sp",vCat)
	VJ.AddNPC("AI Director","sent_vj_l4d_director",vCat,true)
	
	-- Weapons
	VJ.AddNPCWeapon("VJ_L4D_Pipe_Bomb","weapon_vj_l4d_pipebomb")
	VJ.AddWeapon("Pipe Bomb","weapon_vj_l4d_pipebomb",true,vCat)
	
	game.AddAmmoType({name="pipebomb",dmgtype=DMG_BLAST})
	
	-- Particles --
	VJ.AddParticle("particles/vj_l4d_com.pcf",{
		"vj_l4d_com_puke",
	})
	
	-- Precache Models --
	util.PrecacheModel("models/cpthazama/l4d1/anim_common.mdl")
	util.PrecacheModel("models/cpthazama/l4d1/common/common_male_pilot.mdl")
	util.PrecacheModel("models/cpthazama/l4d1/common/common_male_rural01.mdl")
	util.PrecacheModel("models/cpthazama/l4d1/common/common_male_suit.mdl")
	util.PrecacheModel("models/cpthazama/l4d1/common/common_military_male01.mdl")
	util.PrecacheModel("models/cpthazama/l4d1/common/common_patient_male01.mdl")
	util.PrecacheModel("models/cpthazama/l4d1/common/common_police_male01.mdl")
	util.PrecacheModel("models/cpthazama/l4d1/common/common_surgeon_male01.mdl")
	util.PrecacheModel("models/cpthazama/l4d1/common/common_tsaagent_male01.mdl")
	util.PrecacheModel("models/cpthazama/l4d1/common/common_female01.mdl")
	util.PrecacheModel("models/cpthazama/l4d1/common/common_female_nurse01.mdl")
	util.PrecacheModel("models/cpthazama/l4d2/common/cim_faceplate.mdl")
	util.PrecacheModel("models/cpthazama/l4d2/common/cim_riot_faceplate.mdl")
	util.PrecacheModel("models/cpthazama/l4d2/common/common_male_ceda.mdl")
	util.PrecacheModel("models/cpthazama/l4d2/common/common_male_clown.mdl")
	util.PrecacheModel("models/cpthazama/l4d2/common/common_male_fallen_survivor.mdl")
	util.PrecacheModel("models/cpthazama/l4d2/common/common_male_jimmy.mdl")
	util.PrecacheModel("models/cpthazama/l4d2/common/common_male_mud.mdl")
	util.PrecacheModel("models/cpthazama/l4d2/common/common_male_riot.mdl")
	util.PrecacheModel("models/cpthazama/l4d2/common/common_male_roadcrew.mdl")
	util.PrecacheModel("models/cpthazama/l4d2/common/common_male_roadcrew_rain.mdl")
	
	-- ConVars --
	VJ.AddConVar("vj_l4d_com_h",50)
	VJ.AddConVar("vj_l4d_com_h_police",60)
	VJ.AddConVar("vj_l4d_com_h_soldier",90)
	VJ.AddConVar("vj_l4d_com_h_fallsur",100)
	VJ.AddConVar("vj_l4d_com_h_riot",50)
	VJ.AddConVar("vj_l4d_com_h_jimmy",100)
	VJ.AddConVar("vj_l4d_com_d",10)
	
	-- Menu --
	VJ.AddConVar("vj_l4d_alllowclimbing",0,{FCVAR_ARCHIVE})
	
	
	
	VJ_L4D_NODEPOS = {}
	hook.Add("EntityRemoved","VJ_AddNodes_L4D",function(ent)
		if ent:GetClass() == "info_node" then
			table.insert(VJ_L4D_NODEPOS,ent:GetPos())
		end
	end)
	
-- !!!!!! DON'T TOUCH ANYTHING BELOW THIS !!!!!! -------------------------------------------------------------------------------------------------------------------------
	AddCSLuaFile(AutorunFile)
	VJ.AddAddonProperty(AddonName,AddonType)
else
	-- if (CLIENT) then
	-- 	chat.AddText(Color(0,200,200),PublicAddonName,
	-- 	Color(0,255,0)," was unable to install, you are missing ",
	-- 	Color(255,100,0),"VJ Base!")
	-- end
	-- timer.Simple(1,function()
	-- 	if not VJF then
	-- 		if (CLIENT) then
	-- 			VJF = vgui.Create("DFrame")
	-- 			VJF:SetTitle("ERROR!")
	-- 			VJF:SetSize(790,560)
	-- 			VJF:SetPos((ScrW()-VJF:GetWide())/2,(ScrH()-VJF:GetTall())/2)
	-- 			VJF:MakePopup()
	-- 			VJF.Paint = function()
	-- 				draw.RoundedBox(8,0,0,VJF:GetWide(),VJF:GetTall(),Color(200,0,0,150))
	-- 			end
				
	-- 			local VJURL = vgui.Create("DHTML",VJF)
	-- 			VJURL:SetPos(VJF:GetWide()*0.005, VJF:GetTall()*0.03)
	-- 			VJURL:Dock(FILL)
	-- 			VJURL:SetAllowLua(true)
	-- 			VJURL:OpenURL("https://sites.google.com/site/vrejgaming/vjbasemissing")
	-- 		elseif (SERVER) then
	-- 			timer.Create("VJBASEMissing",5,0,function() print("VJ Base is Missing! Download it from the workshop!") end)
	-- 		end
	-- 	end
	-- end)
end