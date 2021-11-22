/*--------------------------------------------------
	=============== Autorun File ===============
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
------------------ Addon Information ------------------
local PublicAddonName = "Lethal Necrotics Reanimated: Specials"
local AddonName = "Lethal Necrotics Reanimated: Specials"
local AddonType = "SNPC"
local AutorunFile = "autorun/vj_lnrspecials_autorun.lua"
-------------------------------------------------------
local VJExists = file.Exists("lua/autorun/vj_base_autorun.lua","GAME")
if VJExists == true then
	include('autorun/vj_controls.lua')

    local vCat = "LNR: Specials" 
		
	VJ.AddNPC("Shambler","npc_vj_lnr_shambler",vCat) 
	VJ.AddNPC("Evo","npc_vj_lnr_evo",vCat)
	VJ.AddNPC("Tank","npc_vj_lnr_tankinf",vCat)
	VJ.AddNPC("Napalm Zombie","npc_vj_lnr_flamzom",vCat)
	VJ.AddNPC("Tesla Zombie","npc_vj_lnr_eleczom",vCat)
	VJ.AddNPC("Riot/Security (Walker)","npc_vj_lnr_nh2_sec",vCat)
	VJ.AddNPC("Riot/Security (Infected)","npc_vj_lnr_nh2_secinf",vCat)
	VJ.AddNPC("Riot/Security (Shield)","npc_vj_lnr_nh2_secshield",vCat)
	VJ.AddNPC("Butcher","npc_vj_lnr_butcher",vCat)
	VJ.AddNPC("Butcher (Sawyer)","npc_vj_lnr_butcher_chainsaw",vCat)
	VJ.AddNPC("Spitter","npc_vj_lnr_spitter",vCat)
	VJ.AddNPC("Healer","npc_vj_lnr_healer",vCat)
	VJ.AddNPC("Healer (Friendly)","npc_vj_lnr_frihealer",vCat)
	VJ.AddNPC("Ravager","npc_vj_lnr_ravager",vCat)
	VJ.AddNPC("Bomber (Infected)","npc_vj_lnr_infbomber",vCat)
	VJ.AddNPC("Bomber (Walker)","npc_vj_lnr_walbomber",vCat)
	VJ.AddNPC("Brute","npc_vj_lnr_brute",vCat)
	VJ.AddNPC("Titan","npc_vj_lnr_titan",vCat)
	VJ.AddNPC("Titan (Mini)","npc_vj_lnr_titan_mini",vCat)
	VJ.AddNPC("Drowner","npc_vj_lnr_drowner",vCat)
	VJ.AddNPC("Drowner (Ground)","npc_vj_lnr_drowner_ground",vCat)
	VJ.AddNPC("Hazmat (Walker)","npc_vj_lnr_hazwal",vCat)
	VJ.AddNPC("Hazmat (Infected)","npc_vj_lnr_hazinf",vCat)
	VJ.AddNPC("Carrier","npc_vj_lnr_carrier",vCat)
	VJ.AddNPC("Tyrant","npc_vj_lnr_tyrant",vCat)
	VJ.AddNPC("Starved","npc_vj_lnr_starved",vCat)
	VJ.AddNPC("Sentry","npc_vj_lnr_sentry",vCat)
	VJ.AddNPC("Dancing Zombie","npc_vj_lnr_dancezom",vCat)
	VJ.AddNPC("Dancing Zombie (Backup)","npc_vj_lnr_dancer_backup",vCat)
	VJ.AddNPC("Punk Zombie","npc_vj_lnr_punk",vCat)
	VJ.AddNPC("Fat Zombie","npc_vj_lnr_fatso",vCat)
	--VJ.AddNPC("Half-Infected","npc_vj_lnr_halfinfected",vCat)
	
	VJ.AddNPC("Random Special","sent_vj_lnrspecial_random",vCat)	
	VJ.AddNPC("Random Boss Special","sent_vj_lnrspecial_bossrandom",vCat)
	VJ.AddNPC("Random Special Spawner","sent_vj_lnrspecial_spawner",vCat)	
	VJ.AddNPC("Single Special Spawner","sent_vj_lnrspecial_singlespawner",vCat)	
	VJ.AddNPC("Single Boss Special Spawner","sent_vj_lnrspecial_bosssinglespawner",vCat)
	
	--Misc--
    VJ.AddNPC("Drowner","npc_vj_lnr_drownerbase","VJ Base")
	
	-- Precache Models --
	util.PrecacheModel("models/vj_lnrspecials/bomber.mdl")
	util.PrecacheModel("models/vj_lnrspecials/bomber_inf.mdl")
	util.PrecacheModel("models/vj_lnrspecials/brute.mdl")
	util.PrecacheModel("models/vj_lnrspecials/butcher.mdl")
	util.PrecacheModel("models/vj_lnrspecials/butcher_chainsaw.mdl")
	util.PrecacheModel("models/vj_lnrspecials/butcher2.mdl")
	util.PrecacheModel("models/vj_lnrspecials/carrier.mdl")
	util.PrecacheModel("models/vj_lnrspecials/drowner.mdl")
	util.PrecacheModel("models/vj_lnrspecials/electric_zombie.mdl")
	util.PrecacheModel("models/vj_lnrspecials/evo.mdl")
	util.PrecacheModel("models/vj_lnrspecials/fire_zombie.mdl")	
	util.PrecacheModel("models/vj_lnrspecials/hazmat_zombie.mdl")
	util.PrecacheModel("models/vj_lnrspecials/healer.mdl")
	util.PrecacheModel("models/vj_lnrspecials/healer_fri.mdl")
	util.PrecacheModel("models/vj_lnrspecials/spitter.mdl")
	util.PrecacheModel("models/vj_lnrspecials/necromancer.mdl")
	util.PrecacheModel("models/vj_lnrspecials/ravager.mdl")
	util.PrecacheModel("models/vj_lnrspecials/shambler.mdl")
	util.PrecacheModel("models/vj_lnrspecials/titan.mdl")
	util.PrecacheModel("models/vj_lnrspecials/tyrant.mdl")	
	util.PrecacheModel("models/vj_lnrspecials/zombie_tank.mdl")
	util.PrecacheModel("models/vj_lnrspecials/infectedhazmat/hazmat_infected.mdl")
	util.PrecacheModel("models/vj_lnrspecials/nh2/security01.mdl")
	util.PrecacheModel("models/vj_lnrspecials/nh2/security01_inf.mdl")
	util.PrecacheModel("models/vj_lnrspecials/nh2/security01_shield.mdl")
	util.PrecacheModel("models/vj_lnrspecials/tank_walker/zombie_tank.mdl")
	util.PrecacheModel("models/weapons/hl2meleepack/w_axe.mdl")	 
	util.PrecacheModel("models/vj_lnrspecials/screamer.mdl") 	
	util.PrecacheModel("models/vj_lnrspecials/punker.mdl")
	util.PrecacheModel("models/weapons/lnr/w_electric_guitar.mdl")
	util.PrecacheModel("models/weapons/riotshield/shield.mdl")
	util.PrecacheModel("models/weapons/hl2meleepack/w_axe.mdl")
	util.PrecacheModel("models/weapons/lnr/w_machete.mdl")	
	
-- !!!!!! DON'T TOUCH ANYTHING BELOW THIS !!!!!! -------------------------------------------------------------------------------------------------------------------------
	AddCSLuaFile(AutorunFile)
	VJ.AddAddonProperty(AddonName,AddonType)
else
	if (CLIENT) then
		chat.AddText(Color(0,200,200),PublicAddonName,
		Color(0,255,0)," was unable to install, you are missing ",
		Color(255,100,0),"VJ Base!")
	end
	timer.Simple(1,function()
		if not VJF then
			if (CLIENT) then
				VJF = vgui.Create("DFrame")
				VJF:SetTitle("ERROR!")
				VJF:SetSize(790,560)
				VJF:SetPos((ScrW()-VJF:GetWide())/2,(ScrH()-VJF:GetTall())/2)
				VJF:MakePopup()
				VJF.Paint = function()
					draw.RoundedBox(8,0,0,VJF:GetWide(),VJF:GetTall(),Color(200,0,0,150))
				end
				
				local VJURL = vgui.Create("DHTML",VJF)
				VJURL:SetPos(VJF:GetWide()*0.005, VJF:GetTall()*0.03)
				VJURL:Dock(FILL)
				VJURL:SetAllowLua(true)
				VJURL:OpenURL("https://sites.google.com/site/vrejgaming/vjbasemissing")
			elseif (SERVER) then
				timer.Create("VJBASEMissing",5,0,function() print("VJ Base is Missing! Download it from the workshop!") end)
			end
		end
	end)
end