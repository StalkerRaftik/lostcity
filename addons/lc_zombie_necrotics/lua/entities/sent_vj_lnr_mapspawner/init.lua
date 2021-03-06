AddCSLuaFile("shared.lua")
include('shared.lua') 
/*-----------------------------------------------
	*** Copyright (c) 2012-2015 by DrVj, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------	
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------	
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------	

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------	

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------	

======================================================================================================================================

  Knight: 

  This is the spawner that I have thought about for a few days. Although not as good as it is ideal, but it is enough. 
  After all, I spend most of my time designing other works. I think you can test this first. 
  To make sure it works, by the way tell ZAKAL and ask him to help me look at the new design, 
  I need more inspiration.

	
=======================================================================================================================================	
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------		
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------	
	
-----------------------------------------------*/
ENT.Model = {"models/Gibs/HGIBS.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 1
ENT.SightDistance = 99999999
ENT.MovementType = VJ_MOVETYPE_STATIONARY
ENT.HullType = HULL_HUMAN
ENT.GodMode = true
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE"}
ENT.BloodColor = ""
ENT.LNRControl = true
ENT.RunAwayOnUnknownDamage = false
ENT.HasMeleeAttack = false
ENT.SAngle2 = 55
ENT.FindEnemy_UseSphere = false 
ENT.FindEnemy_CanSeeThroughWalls = false
ENT.NUM = 0
ENT.DisableMakingSelfEnemyToNPCs = true
ENT.NUM2 = 0
ENT.NUM3 = 0
ENT.CREA = true
ENT.CREA2 = true
ENT.CREAd = true
ENT.CREA2d = true
ENT.CREAda = true
ENT.CREA2da = true

ENT.CREA3 = true
ENT.Decrease = false
ENT.HasDeathAnimation = false
ENT.HasBloodPool = false -- Does it have a blood pool?
ENT.HasDeathRagdoll = false
ENT.MaxZombie = 0 
ENT.cout = true
ENT.cout2 = false
ENT.cout3 = true
ENT.time = 0.65
ENT.time2 = 0.65
ENT.time3 = 0.65
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_SoundTrack = {"vj_lnrhl2/mapspawner/ascending_despair__desperation.mp3","vj_lnrhl2/mapspawner/ascending_despair.mp3"}
ENT.HasSoundTrack = true
ENT.SoundTrackLevel = 0.8
-------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
if GetConVarNumber("vj_LNR_MapSpawner_HL2") == 1 then
self.LNR = {"npc_vj_lnr_lnhl2mm","npc_vj_lnr_lnhl2mf","npc_vj_lnr_hl2mminf","npc_vj_lnr_hl2mfinf","npc_vj_lnr_lncb","npc_vj_lnr_cbinf","npc_vj_lnr_combcrawl","npc_vj_lnr_cheapleinf","npc_vj_lnr_cheaplewal","npc_vj_lnr_femaleheadlesswal","npc_vj_lnr_maleheadlesswal","npc_vj_lnr_femaleinfweapon","npc_vj_lnr_maleinfweapon","npc_vj_lnr_combinfweapon","npc_vj_lnr_femalewalweapon","npc_vj_lnr_malewalweapon","npc_vj_lnr_combwalweapon","npc_vj_lnr_femalewallimbless","npc_vj_lnr_malewallimbless","npc_vj_lnr_malecrawl","npc_vj_lnr_femalecrawl","npc_vj_lnr_corpsewal","npc_vj_lnr_hevwal","npc_vj_lnr_zombi","npc_vj_lnr_zombi_corpse","npc_vj_lnr_tarman","npc_vj_lnr_fminf","npc_vj_lnr_mminf","npc_vj_lnr_frinf","npc_vj_lnr_mrinf","npc_vj_lnr_lnfm","npc_vj_lnr_lnmm","npc_vj_lnr_lnfr","npc_vj_lnr_lnmr","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc"}
self.LNR2 = {"npc_vj_lnr_lnhl2mm","npc_vj_lnr_lnhl2mf","npc_vj_lnr_hl2mminf","npc_vj_lnr_hl2mfinf","npc_vj_lnr_lncb","npc_vj_lnr_cbinf","npc_vj_lnr_combcrawl","npc_vj_lnr_cheapleinf","npc_vj_lnr_cheaplewal","npc_vj_lnr_femaleheadlesswal","npc_vj_lnr_maleheadlesswal","npc_vj_lnr_femaleinfweapon","npc_vj_lnr_maleinfweapon","npc_vj_lnr_combinfweapon","npc_vj_lnr_femalewalweapon","npc_vj_lnr_malewalweapon","npc_vj_lnr_combwalweapon","npc_vj_lnr_femalewallimbless","npc_vj_lnr_malewallimbless","npc_vj_lnr_malecrawl","npc_vj_lnr_femalecrawl","npc_vj_lnr_corpsewal","npc_vj_lnr_hevwal","npc_vj_lnr_zombi","npc_vj_lnr_zombi_corpse","npc_vj_lnr_tarman","npc_vj_lnr_fminf","npc_vj_lnr_mminf","npc_vj_lnr_frinf","npc_vj_lnr_mrinf","npc_vj_lnr_lnfm","npc_vj_lnr_lnmm","npc_vj_lnr_lnfr","npc_vj_lnr_lnmr","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc"}
self.LNR3 = {"npc_vj_lnr_lnhl2mm","npc_vj_lnr_lnhl2mf","npc_vj_lnr_hl2mminf","npc_vj_lnr_hl2mfinf","npc_vj_lnr_lncb","npc_vj_lnr_cbinf","npc_vj_lnr_combcrawl","npc_vj_lnr_cheapleinf","npc_vj_lnr_cheaplewal","npc_vj_lnr_femaleheadlesswal","npc_vj_lnr_maleheadlesswal","npc_vj_lnr_femaleinfweapon","npc_vj_lnr_maleinfweapon","npc_vj_lnr_combinfweapon","npc_vj_lnr_femalewalweapon","npc_vj_lnr_malewalweapon","npc_vj_lnr_combwalweapon","npc_vj_lnr_femalewallimbless","npc_vj_lnr_malewallimbless","npc_vj_lnr_malecrawl","npc_vj_lnr_femalecrawl","npc_vj_lnr_corpsewal","npc_vj_lnr_hevwal","npc_vj_lnr_zombi","npc_vj_lnr_zombi_corpse","npc_vj_lnr_tarman","npc_vj_lnr_fminf","npc_vj_lnr_mminf","npc_vj_lnr_frinf","npc_vj_lnr_mrinf","npc_vj_lnr_lnfm","npc_vj_lnr_lnmm","npc_vj_lnr_lnfr","npc_vj_lnr_lnmr","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc"}
--self.LNR4 = {"npc_vj_lnr_lnhl2mm","npc_vj_lnr_lnhl2mf","npc_vj_lnr_hl2mminf","npc_vj_lnr_hl2mfinf","npc_vj_lnr_lncb","npc_vj_lnr_cbinf","npc_vj_lnr_combcrawl","npc_vj_lnr_cheapleinf","npc_vj_lnr_cheaplewal","npc_vj_lnr_femaleheadlesswal","npc_vj_lnr_maleheadlesswal","npc_vj_lnr_femaleinfweapon","npc_vj_lnr_maleinfweapon","npc_vj_lnr_combinfweapon","npc_vj_lnr_femalewalweapon","npc_vj_lnr_malewalweapon","npc_vj_lnr_combwalweapon","npc_vj_lnr_femalewallimbless","npc_vj_lnr_malewallimbless","npc_vj_lnr_malecrawl","npc_vj_lnr_femalecrawl","npc_vj_lnr_corpsewal","npc_vj_lnr_hevwal","npc_vj_lnr_zombi","npc_vj_lnr_zombi_corpse","npc_vj_lnr_tarman","npc_vj_lnr_fminf","npc_vj_lnr_mminf","npc_vj_lnr_frinf","npc_vj_lnr_mrinf","npc_vj_lnr_lnfm","npc_vj_lnr_lnmm","npc_vj_lnr_lnfr","npc_vj_lnr_lnmr","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc"}
end

if GetConVarNumber("vj_LNR_MapSpawner_Specials") == 1 && file.Exists("lua/autorun/vj_lnrspecials_autorun.lua","GAME") then
self.LNR = {"npc_vj_lnr_fatso","npc_vj_lnr_punk","npc_vj_lnr_drowner_ground","npc_vj_lnr_tankinf","npc_vj_lnr_titan_mini","npc_vj_lnr_titan","npc_vj_lnr_tyrant","npc_vj_lnr_carrier","npc_vj_lnr_butcher_chainsaw","npc_vj_lnr_hazinf","npc_vj_lnr_hazwal","npc_vj_lnr_eleczom","npc_vj_lnr_flamzom","npc_vj_lnr_spitter","npc_vj_lnr_ravager","npc_vj_lnr_healer","npc_vj_lnr_butcher","npc_vj_lnr_nh2_secshield","npc_vj_lnr_infbomber","npc_vj_lnr_walbomber","npc_vj_lnr_brute","npc_vj_lnr_shambler","npc_vj_lnr_evo","npc_vj_lnr_nh2_sec","npc_vj_lnr_nh2_secinf","npc_vj_lnr_carrier","npc_vj_lnr_carrier","npc_vj_lnr_butcher_chainsaw","npc_vj_lnr_hazinf","npc_vj_lnr_hazwal","npc_vj_lnr_eleczom","npc_vj_lnr_flamzom","npc_vj_lnr_spitter","npc_vj_lnr_spitter","npc_vj_lnr_ravager","npc_vj_lnr_healer","npc_vj_lnr_healer","npc_vj_lnr_butcher","npc_vj_lnr_nh2_secshield","npc_vj_lnr_infbomber","npc_vj_lnr_walbomber","npc_vj_lnr_brute","npc_vj_lnr_shambler","npc_vj_lnr_evo","npc_vj_lnr_nh2_sec","npc_vj_lnr_nh2_secinf"}
self.LNR2 = {"npc_vj_lnr_fatso","npc_vj_lnr_punk","npc_vj_lnr_drowner_ground","npc_vj_lnr_tankinf","npc_vj_lnr_titan_mini","npc_vj_lnr_titan","npc_vj_lnr_tyrant","npc_vj_lnr_carrier","npc_vj_lnr_butcher_chainsaw","npc_vj_lnr_hazinf","npc_vj_lnr_hazwal","npc_vj_lnr_eleczom","npc_vj_lnr_flamzom","npc_vj_lnr_spitter","npc_vj_lnr_ravager","npc_vj_lnr_healer","npc_vj_lnr_butcher","npc_vj_lnr_nh2_secshield","npc_vj_lnr_infbomber","npc_vj_lnr_walbomber","npc_vj_lnr_brute","npc_vj_lnr_shambler","npc_vj_lnr_evo","npc_vj_lnr_nh2_sec","npc_vj_lnr_nh2_secinf","npc_vj_lnr_carrier","npc_vj_lnr_carrier","npc_vj_lnr_butcher_chainsaw","npc_vj_lnr_hazinf","npc_vj_lnr_hazwal","npc_vj_lnr_eleczom","npc_vj_lnr_flamzom","npc_vj_lnr_spitter","npc_vj_lnr_spitter","npc_vj_lnr_ravager","npc_vj_lnr_healer","npc_vj_lnr_healer","npc_vj_lnr_butcher","npc_vj_lnr_nh2_secshield","npc_vj_lnr_infbomber","npc_vj_lnr_walbomber","npc_vj_lnr_brute","npc_vj_lnr_shambler","npc_vj_lnr_evo","npc_vj_lnr_nh2_sec","npc_vj_lnr_nh2_secinf"}
self.LNR3 = {"npc_vj_lnr_fatso","npc_vj_lnr_punk","npc_vj_lnr_drowner_ground","npc_vj_lnr_tankinf","npc_vj_lnr_titan_mini","npc_vj_lnr_titan","npc_vj_lnr_tyrant","npc_vj_lnr_carrier","npc_vj_lnr_butcher_chainsaw","npc_vj_lnr_hazinf","npc_vj_lnr_hazwal","npc_vj_lnr_eleczom","npc_vj_lnr_flamzom","npc_vj_lnr_spitter","npc_vj_lnr_ravager","npc_vj_lnr_healer","npc_vj_lnr_butcher","npc_vj_lnr_nh2_secshield","npc_vj_lnr_infbomber","npc_vj_lnr_walbomber","npc_vj_lnr_brute","npc_vj_lnr_shambler","npc_vj_lnr_evo","npc_vj_lnr_nh2_sec","npc_vj_lnr_nh2_secinf","npc_vj_lnr_carrier","npc_vj_lnr_carrier","npc_vj_lnr_butcher_chainsaw","npc_vj_lnr_hazinf","npc_vj_lnr_hazwal","npc_vj_lnr_eleczom","npc_vj_lnr_flamzom","npc_vj_lnr_spitter","npc_vj_lnr_spitter","npc_vj_lnr_ravager","npc_vj_lnr_healer","npc_vj_lnr_healer","npc_vj_lnr_butcher","npc_vj_lnr_nh2_secshield","npc_vj_lnr_infbomber","npc_vj_lnr_walbomber","npc_vj_lnr_brute","npc_vj_lnr_shambler","npc_vj_lnr_evo","npc_vj_lnr_nh2_sec","npc_vj_lnr_nh2_secinf"}
--self.LNR4 = {"npc_vj_lnr_punk","npc_vj_lnr_drowner_ground","npc_vj_lnr_tankinf","npc_vj_lnr_titan_mini","npc_vj_lnr_titan","npc_vj_lnr_tyrant","npc_vj_lnr_carrier","npc_vj_lnr_butcher_chainsaw","npc_vj_lnr_hazinf","npc_vj_lnr_hazwal","npc_vj_lnr_eleczom","npc_vj_lnr_flamzom","npc_vj_lnr_spitter","npc_vj_lnr_ravager","npc_vj_lnr_healer","npc_vj_lnr_butcher","npc_vj_lnr_nh2_secshield","npc_vj_lnr_infbomber","npc_vj_lnr_walbomber","npc_vj_lnr_brute","npc_vj_lnr_shambler","npc_vj_lnr_evo","npc_vj_lnr_nh2_sec","npc_vj_lnr_nh2_secinf","npc_vj_lnr_carrier","npc_vj_lnr_carrier","npc_vj_lnr_butcher_chainsaw","npc_vj_lnr_hazinf","npc_vj_lnr_hazwal","npc_vj_lnr_eleczom","npc_vj_lnr_flamzom","npc_vj_lnr_spitter","npc_vj_lnr_spitter","npc_vj_lnr_ravager","npc_vj_lnr_healer","npc_vj_lnr_healer","npc_vj_lnr_butcher","npc_vj_lnr_nh2_secshield","npc_vj_lnr_infbomber","npc_vj_lnr_walbomber","npc_vj_lnr_brute","npc_vj_lnr_shambler","npc_vj_lnr_evo","npc_vj_lnr_nh2_sec","npc_vj_lnr_nh2_secinf"}
end

if GetConVarNumber("vj_LNR_MapSpawner_CSS") == 1 && file.Exists("lua/autorun/vj_lnrcss_autorun.lua","GAME") then
self.LNR = {"npc_vj_lnr_ct_wal","npc_vj_lnr_t_wal","npc_vj_lnr_ct_inf","npc_vj_lnr_t_inf"}
self.LNR2 = {"npc_vj_lnr_ct_wal","npc_vj_lnr_t_wal","npc_vj_lnr_ct_inf","npc_vj_lnr_t_inf"}
self.LNR3 = {"npc_vj_lnr_ct_wal","npc_vj_lnr_t_wal","npc_vj_lnr_ct_inf","npc_vj_lnr_t_inf"}
--self.LNR4 = {"npc_vj_lnr_ct_wal","npc_vj_lnr_t_wal","npc_vj_lnr_ct_inf","npc_vj_lnr_t_inf"}
end

if GetConVarNumber("vj_LNR_MapSpawner_HLS") == 1 && file.Exists("lua/autorun/vj_lnrhls_autorun.lua","GAME") then
self.LNR = {"npc_vj_lnr_gordon","npc_vj_lnr_gman","npc_vj_lnr_gina","npc_vj_lnr_skeleton","npc_vj_lnr_gordoninf","npc_vj_lnr_gmaninf","npc_vj_lnr_ginainf","npc_vj_lnr_skeletoninf","npc_vj_lnr_barney","npc_vj_lnr_barneyinf","npc_vj_lnr_barney","npc_vj_lnr_barneyinf","npc_vj_lnr_hev","npc_vj_lnr_hevinf","npc_vj_lnr_grunt","npc_vj_lnr_gruntinf","npc_vj_lnr_assassin","npc_vj_lnr_assassininf","npc_vj_lnr_blackops","npc_vj_lnr_blackopsinf","npc_vj_lnr_scientist","npc_vj_lnr_scientist","npc_vj_lnr_scientistinf","npc_vj_lnr_scientistinf"}
self.LNR2 = {"npc_vj_lnr_gordon","npc_vj_lnr_gman","npc_vj_lnr_gina","npc_vj_lnr_skeleton","npc_vj_lnr_gordoninf","npc_vj_lnr_gmaninf","npc_vj_lnr_ginainf","npc_vj_lnr_skeletoninf","npc_vj_lnr_barney","npc_vj_lnr_barneyinf","npc_vj_lnr_barney","npc_vj_lnr_barneyinf","npc_vj_lnr_hev","npc_vj_lnr_hevinf","npc_vj_lnr_grunt","npc_vj_lnr_gruntinf","npc_vj_lnr_assassin","npc_vj_lnr_assassininf","npc_vj_lnr_blackops","npc_vj_lnr_blackopsinf","npc_vj_lnr_scientist","npc_vj_lnr_scientist","npc_vj_lnr_scientistinf","npc_vj_lnr_scientistinf"}
self.LNR3 = {"npc_vj_lnr_gordon","npc_vj_lnr_gman","npc_vj_lnr_gina","npc_vj_lnr_skeleton","npc_vj_lnr_gordoninf","npc_vj_lnr_gmaninf","npc_vj_lnr_ginainf","npc_vj_lnr_skeletoninf","npc_vj_lnr_barney","npc_vj_lnr_barneyinf","npc_vj_lnr_barney","npc_vj_lnr_barneyinf","npc_vj_lnr_hev","npc_vj_lnr_hevinf","npc_vj_lnr_grunt","npc_vj_lnr_gruntinf","npc_vj_lnr_assassin","npc_vj_lnr_assassininf","npc_vj_lnr_blackops","npc_vj_lnr_blackopsinf","npc_vj_lnr_scientist","npc_vj_lnr_scientist","npc_vj_lnr_scientistinf","npc_vj_lnr_scientistinf"}
--self.LNR4 = {"npc_vj_lnr_gordon","npc_vj_lnr_gman","npc_vj_lnr_gina","npc_vj_lnr_skeleton","npc_vj_lnr_gordoninf","npc_vj_lnr_gmaninf","npc_vj_lnr_ginainf","npc_vj_lnr_skeletoninf","npc_vj_lnr_barney","npc_vj_lnr_barneyinf","npc_vj_lnr_barney","npc_vj_lnr_barneyinf","npc_vj_lnr_hev","npc_vj_lnr_hevinf","npc_vj_lnr_grunt","npc_vj_lnr_gruntinf","npc_vj_lnr_assassin","npc_vj_lnr_assassininf","npc_vj_lnr_blackops","npc_vj_lnr_blackopsinf","npc_vj_lnr_scientist","npc_vj_lnr_scientist","npc_vj_lnr_scientistinf","npc_vj_lnr_scientistinf"}
end

if GetConVarNumber("vj_LNR_MapSpawner_TF2") == 1 && file.Exists("lua/autorun/vj_lnrtf2_autorun.lua","GAME") then
self.LNR = {"npc_vj_lnr_bluwal","npc_vj_lnr_bluinf","npc_vj_lnr_redwal","npc_vj_lnr_redinf"}
self.LNR2 = {"npc_vj_lnr_bluwal","npc_vj_lnr_bluinf","npc_vj_lnr_redwal","npc_vj_lnr_redinf"}
self.LNR3 = {"npc_vj_lnr_bluwal","npc_vj_lnr_bluinf","npc_vj_lnr_redwal","npc_vj_lnr_redinf"}
--self.LNR4 = {"npc_vj_lnr_bluwal","npc_vj_lnr_bluinf","npc_vj_lnr_redwal","npc_vj_lnr_redinf"}
end

if GetConVarNumber("vj_LNR_MapSpawner_L4D") == 1 && file.Exists("lua/autorun/vj_lnrl4d_autorun.lua","GAME") then
self.LNR = {"npc_vj_lnr_msurwal","npc_vj_lnr_fsurwal","npc_vj_lnr_msurinf","npc_vj_lnr_fsurinf"}
self.LNR2 = {"npc_vj_lnr_msurwal","npc_vj_lnr_fsurwal","npc_vj_lnr_msurinf","npc_vj_lnr_fsurinf"}
self.LNR3 = {"npc_vj_lnr_msurwal","npc_vj_lnr_fsurwal","npc_vj_lnr_msurinf","npc_vj_lnr_fsurinf"}
--self.LNR4 = {"npc_vj_lnr_msurwal","npc_vj_lnr_fsurwal","npc_vj_lnr_msurinf","npc_vj_lnr_fsurinf"}
end

if GetConVarNumber("vj_LNR_MapSpawner_Extras") == 1 && file.Exists("lua/autorun/vj_lnrextras_autorun.lua","GAME") then
self.LNR = {"npc_vj_lnr_nmrihminf_surv","npc_vj_lnr_nmrihm_surv","npc_vj_lnr_nmrihm_nginf_extra","npc_vj_lnr_nmrihm_ng_extra","npc_vj_lnr_nmrihfinf_surv","npc_vj_lnr_nmrihf_surv","npc_vj_lnr_cncm_operator","npc_vj_lnr_cncm_operatorinf","npc_vj_lnr_swatinf","npc_vj_lnr_swatwal","npc_vj_lnr_rangerinf","npc_vj_lnr_rangerwal","npc_vj_lnr_nmrihm_nginf","npc_vj_lnr_nmrihm_ng","npc_vj_lnr_fcorpseinf","npc_vj_lnr_fcorpsewal","npc_vj_lnr_mcorpseinf","npc_vj_lnr_mcorpsewal","npc_vj_lnr_nh2mt","npc_vj_lnr_nh2minft","npc_vj_lnr_nh2m_surinf","npc_vj_lnr_nh2minf","npc_vj_lnr_nh2finf","npc_vj_lnr_nh2m_sur","npc_vj_lnr_nh2m","npc_vj_lnr_nh2f","npc_vj_lnr_nh2f","npc_vj_lnr_nmrihfinf","npc_vj_lnr_nmrihminf","npc_vj_lnr_nmrihf","npc_vj_lnr_nmrihm","npc_vj_lnr_zpsfinf","npc_vj_lnr_zpsminf","npc_vj_lnr_zpsf","npc_vj_lnr_zpsm","npc_vj_lnr_zm2finf","npc_vj_lnr_zm2minf","npc_vj_lnr_smominf","npc_vj_lnr_galfinf","npc_vj_lnr_galminf","npc_vj_lnr_zm2f","npc_vj_lnr_zm2m","npc_vj_lnr_smom","npc_vj_lnr_galf","npc_vj_lnr_galm","npc_vj_lnr_fcorpseinf","npc_vj_lnr_fcorpsewal","npc_vj_lnr_mcorpseinf","npc_vj_lnr_mcorpsewal","npc_vj_lnr_nh2mt","npc_vj_lnr_nh2minft","npc_vj_lnr_nh2m_surinf","npc_vj_lnr_nh2minf","npc_vj_lnr_nh2finf","npc_vj_lnr_nh2m_sur","npc_vj_lnr_nh2m","npc_vj_lnr_nh2f","npc_vj_lnr_nh2f","npc_vj_lnr_nmrihfinf","npc_vj_lnr_nmrihminf","npc_vj_lnr_nmrihf","npc_vj_lnr_nmrihm","npc_vj_lnr_zpsfinf","npc_vj_lnr_zpsminf","npc_vj_lnr_zpsf","npc_vj_lnr_zpsm","npc_vj_lnr_zm2finf","npc_vj_lnr_zm2minf","npc_vj_lnr_smominf","npc_vj_lnr_galfinf","npc_vj_lnr_galminf","npc_vj_lnr_zm2f","npc_vj_lnr_zm2m","npc_vj_lnr_smom","npc_vj_lnr_galf","npc_vj_lnr_galm"}
self.LNR2 = {"npc_vj_lnr_nmrihminf_surv","npc_vj_lnr_nmrihm_surv","npc_vj_lnr_nmrihm_nginf_extra","npc_vj_lnr_nmrihm_ng_extra","npc_vj_lnr_nmrihfinf_surv","npc_vj_lnr_nmrihf_surv","npc_vj_lnr_cncm_operator","npc_vj_lnr_cncm_operatorinf","npc_vj_lnr_swatinf","npc_vj_lnr_swatwal","npc_vj_lnr_rangerinf","npc_vj_lnr_rangerwal","npc_vj_lnr_nmrihm_nginf","npc_vj_lnr_nmrihm_ng","npc_vj_lnr_fcorpseinf","npc_vj_lnr_fcorpsewal","npc_vj_lnr_mcorpseinf","npc_vj_lnr_mcorpsewal","npc_vj_lnr_nh2mt","npc_vj_lnr_nh2minft","npc_vj_lnr_nh2m_surinf","npc_vj_lnr_nh2minf","npc_vj_lnr_nh2finf","npc_vj_lnr_nh2m_sur","npc_vj_lnr_nh2m","npc_vj_lnr_nh2f","npc_vj_lnr_nh2f","npc_vj_lnr_nmrihfinf","npc_vj_lnr_nmrihminf","npc_vj_lnr_nmrihf","npc_vj_lnr_nmrihm","npc_vj_lnr_zpsfinf","npc_vj_lnr_zpsminf","npc_vj_lnr_zpsf","npc_vj_lnr_zpsm","npc_vj_lnr_zm2finf","npc_vj_lnr_zm2minf","npc_vj_lnr_smominf","npc_vj_lnr_galfinf","npc_vj_lnr_galminf","npc_vj_lnr_zm2f","npc_vj_lnr_zm2m","npc_vj_lnr_smom","npc_vj_lnr_galf","npc_vj_lnr_galm","npc_vj_lnr_fcorpseinf","npc_vj_lnr_fcorpsewal","npc_vj_lnr_mcorpseinf","npc_vj_lnr_mcorpsewal","npc_vj_lnr_nh2mt","npc_vj_lnr_nh2minft","npc_vj_lnr_nh2m_surinf","npc_vj_lnr_nh2minf","npc_vj_lnr_nh2finf","npc_vj_lnr_nh2m_sur","npc_vj_lnr_nh2m","npc_vj_lnr_nh2f","npc_vj_lnr_nh2f","npc_vj_lnr_nmrihfinf","npc_vj_lnr_nmrihminf","npc_vj_lnr_nmrihf","npc_vj_lnr_nmrihm","npc_vj_lnr_zpsfinf","npc_vj_lnr_zpsminf","npc_vj_lnr_zpsf","npc_vj_lnr_zpsm","npc_vj_lnr_zm2finf","npc_vj_lnr_zm2minf","npc_vj_lnr_smominf","npc_vj_lnr_galfinf","npc_vj_lnr_galminf","npc_vj_lnr_zm2f","npc_vj_lnr_zm2m","npc_vj_lnr_smom","npc_vj_lnr_galf","npc_vj_lnr_galm"}
self.LNR3 = {"npc_vj_lnr_nmrihminf_surv","npc_vj_lnr_nmrihm_surv","npc_vj_lnr_nmrihm_nginf_extra","npc_vj_lnr_nmrihm_ng_extra","npc_vj_lnr_nmrihfinf_surv","npc_vj_lnr_nmrihf_surv","npc_vj_lnr_cncm_operator","npc_vj_lnr_cncm_operatorinf","npc_vj_lnr_swatinf","npc_vj_lnr_swatwal","npc_vj_lnr_rangerinf","npc_vj_lnr_rangerwal","npc_vj_lnr_nmrihm_nginf","npc_vj_lnr_nmrihm_ng","npc_vj_lnr_fcorpseinf","npc_vj_lnr_fcorpsewal","npc_vj_lnr_mcorpseinf","npc_vj_lnr_mcorpsewal","npc_vj_lnr_nh2mt","npc_vj_lnr_nh2minft","npc_vj_lnr_nh2m_surinf","npc_vj_lnr_nh2minf","npc_vj_lnr_nh2finf","npc_vj_lnr_nh2m_sur","npc_vj_lnr_nh2m","npc_vj_lnr_nh2f","npc_vj_lnr_nh2f","npc_vj_lnr_nmrihfinf","npc_vj_lnr_nmrihminf","npc_vj_lnr_nmrihf","npc_vj_lnr_nmrihm","npc_vj_lnr_zpsfinf","npc_vj_lnr_zpsminf","npc_vj_lnr_zpsf","npc_vj_lnr_zpsm","npc_vj_lnr_zm2finf","npc_vj_lnr_zm2minf","npc_vj_lnr_smominf","npc_vj_lnr_galfinf","npc_vj_lnr_galminf","npc_vj_lnr_zm2f","npc_vj_lnr_zm2m","npc_vj_lnr_smom","npc_vj_lnr_galf","npc_vj_lnr_galm","npc_vj_lnr_fcorpseinf","npc_vj_lnr_fcorpsewal","npc_vj_lnr_mcorpseinf","npc_vj_lnr_mcorpsewal","npc_vj_lnr_nh2mt","npc_vj_lnr_nh2minft","npc_vj_lnr_nh2m_surinf","npc_vj_lnr_nh2minf","npc_vj_lnr_nh2finf","npc_vj_lnr_nh2m_sur","npc_vj_lnr_nh2m","npc_vj_lnr_nh2f","npc_vj_lnr_nh2f","npc_vj_lnr_nmrihfinf","npc_vj_lnr_nmrihminf","npc_vj_lnr_nmrihf","npc_vj_lnr_nmrihm","npc_vj_lnr_zpsfinf","npc_vj_lnr_zpsminf","npc_vj_lnr_zpsf","npc_vj_lnr_zpsm","npc_vj_lnr_zm2finf","npc_vj_lnr_zm2minf","npc_vj_lnr_smominf","npc_vj_lnr_galfinf","npc_vj_lnr_galminf","npc_vj_lnr_zm2f","npc_vj_lnr_zm2m","npc_vj_lnr_smom","npc_vj_lnr_galf","npc_vj_lnr_galm"}
--self.LNR4 = {"npc_vj_lnr_nmrihminf_surv","npc_vj_lnr_nmrihm_surv","npc_vj_lnr_nmrihm_nginf_extra","npc_vj_lnr_nmrihm_ng_extra","npc_vj_lnr_nmrihfinf_surv","npc_vj_lnr_nmrihf_surv","npc_vj_lnr_cncm_operator","npc_vj_lnr_cncm_operatorinf","npc_vj_lnr_swatinf","npc_vj_lnr_swatwal","npc_vj_lnr_rangerinf","npc_vj_lnr_rangerwal","npc_vj_lnr_nmrihm_nginf","npc_vj_lnr_nmrihm_ng","npc_vj_lnr_fcorpseinf","npc_vj_lnr_fcorpsewal","npc_vj_lnr_mcorpseinf","npc_vj_lnr_mcorpsewal","npc_vj_lnr_nh2mt","npc_vj_lnr_nh2minft","npc_vj_lnr_nh2m_surinf","npc_vj_lnr_nh2minf","npc_vj_lnr_nh2finf","npc_vj_lnr_nh2m_sur","npc_vj_lnr_nh2m","npc_vj_lnr_nh2f","npc_vj_lnr_nh2f","npc_vj_lnr_nmrihfinf","npc_vj_lnr_nmrihminf","npc_vj_lnr_nmrihf","npc_vj_lnr_nmrihm","npc_vj_lnr_zpsfinf","npc_vj_lnr_zpsminf","npc_vj_lnr_zpsf","npc_vj_lnr_zpsm","npc_vj_lnr_zm2finf","npc_vj_lnr_zm2minf","npc_vj_lnr_smominf","npc_vj_lnr_galfinf","npc_vj_lnr_galminf","npc_vj_lnr_zm2f","npc_vj_lnr_zm2m","npc_vj_lnr_smom","npc_vj_lnr_galf","npc_vj_lnr_galm","npc_vj_lnr_fcorpseinf","npc_vj_lnr_fcorpsewal","npc_vj_lnr_mcorpseinf","npc_vj_lnr_mcorpsewal","npc_vj_lnr_nh2mt","npc_vj_lnr_nh2minft","npc_vj_lnr_nh2m_surinf","npc_vj_lnr_nh2minf","npc_vj_lnr_nh2finf","npc_vj_lnr_nh2m_sur","npc_vj_lnr_nh2m","npc_vj_lnr_nh2f","npc_vj_lnr_nh2f","npc_vj_lnr_nmrihfinf","npc_vj_lnr_nmrihminf","npc_vj_lnr_nmrihf","npc_vj_lnr_nmrihm","npc_vj_lnr_zpsfinf","npc_vj_lnr_zpsminf","npc_vj_lnr_zpsf","npc_vj_lnr_zpsm","npc_vj_lnr_zm2finf","npc_vj_lnr_zm2minf","npc_vj_lnr_smominf","npc_vj_lnr_galfinf","npc_vj_lnr_galminf","npc_vj_lnr_zm2f","npc_vj_lnr_zm2m","npc_vj_lnr_smom","npc_vj_lnr_galf","npc_vj_lnr_galm"}
end

if GetConVarNumber("vj_LNR_MapSpawner_HL2") == 1 && GetConVarNumber("vj_LNR_MapSpawner_CSS") == 1 && file.Exists("lua/autorun/vj_lnrcss_autorun.lua","GAME") then
self.LNR = {"npc_vj_lnr_lnhl2mm","npc_vj_lnr_lnhl2mf","npc_vj_lnr_hl2mminf","npc_vj_lnr_hl2mfinf","npc_vj_lnr_lncb","npc_vj_lnr_cbinf","npc_vj_lnr_combcrawl","npc_vj_lnr_cheapleinf","npc_vj_lnr_cheaplewal","npc_vj_lnr_femaleheadlesswal","npc_vj_lnr_maleheadlesswal","npc_vj_lnr_femaleinfweapon","npc_vj_lnr_maleinfweapon","npc_vj_lnr_combinfweapon","npc_vj_lnr_femalewalweapon","npc_vj_lnr_malewalweapon","npc_vj_lnr_combwalweapon","npc_vj_lnr_femalewallimbless","npc_vj_lnr_malewallimbless","npc_vj_lnr_malecrawl","npc_vj_lnr_femalecrawl","npc_vj_lnr_corpsewal","npc_vj_lnr_hevwal","npc_vj_lnr_zombi","npc_vj_lnr_zombi_corpse","npc_vj_lnr_tarman","npc_vj_lnr_fminf","npc_vj_lnr_mminf","npc_vj_lnr_frinf","npc_vj_lnr_mrinf","npc_vj_lnr_lnfm","npc_vj_lnr_lnmm","npc_vj_lnr_lnfr","npc_vj_lnr_lnmr","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc"}
self.LNR2 = {"npc_vj_lnr_lnhl2mm","npc_vj_lnr_lnhl2mf","npc_vj_lnr_hl2mminf","npc_vj_lnr_hl2mfinf","npc_vj_lnr_lncb","npc_vj_lnr_cbinf","npc_vj_lnr_combcrawl","npc_vj_lnr_cheapleinf","npc_vj_lnr_cheaplewal","npc_vj_lnr_femaleheadlesswal","npc_vj_lnr_maleheadlesswal","npc_vj_lnr_femaleinfweapon","npc_vj_lnr_maleinfweapon","npc_vj_lnr_combinfweapon","npc_vj_lnr_femalewalweapon","npc_vj_lnr_malewalweapon","npc_vj_lnr_combwalweapon","npc_vj_lnr_femalewallimbless","npc_vj_lnr_malewallimbless","npc_vj_lnr_malecrawl","npc_vj_lnr_femalecrawl","npc_vj_lnr_corpsewal","npc_vj_lnr_hevwal","npc_vj_lnr_zombi","npc_vj_lnr_zombi_corpse","npc_vj_lnr_tarman","npc_vj_lnr_fminf","npc_vj_lnr_mminf","npc_vj_lnr_frinf","npc_vj_lnr_mrinf","npc_vj_lnr_lnfm","npc_vj_lnr_lnmm","npc_vj_lnr_lnfr","npc_vj_lnr_lnmr","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc"}
self.LNR3 = {"npc_vj_lnr_ct_wal","npc_vj_lnr_t_wal","npc_vj_lnr_ct_inf","npc_vj_lnr_t_inf"}
--self.LNR4 = {"npc_vj_lnr_ct_wal","npc_vj_lnr_t_wal","npc_vj_lnr_ct_inf","npc_vj_lnr_t_inf"}
end

if GetConVarNumber("vj_LNR_MapSpawner_HL2") == 1 && GetConVarNumber("vj_LNR_MapSpawner_HLS") == 1 && file.Exists("lua/autorun/vj_lnrhls_autorun.lua","GAME") then
self.LNR = {"npc_vj_lnr_lnhl2mm","npc_vj_lnr_lnhl2mf","npc_vj_lnr_hl2mminf","npc_vj_lnr_hl2mfinf","npc_vj_lnr_lncb","npc_vj_lnr_cbinf","npc_vj_lnr_combcrawl","npc_vj_lnr_cheapleinf","npc_vj_lnr_cheaplewal","npc_vj_lnr_femaleheadlesswal","npc_vj_lnr_maleheadlesswal","npc_vj_lnr_femaleinfweapon","npc_vj_lnr_maleinfweapon","npc_vj_lnr_combinfweapon","npc_vj_lnr_femalewalweapon","npc_vj_lnr_malewalweapon","npc_vj_lnr_combwalweapon","npc_vj_lnr_femalewallimbless","npc_vj_lnr_malewallimbless","npc_vj_lnr_malecrawl","npc_vj_lnr_femalecrawl","npc_vj_lnr_corpsewal","npc_vj_lnr_hevwal","npc_vj_lnr_zombi","npc_vj_lnr_zombi_corpse","npc_vj_lnr_tarman","npc_vj_lnr_fminf","npc_vj_lnr_mminf","npc_vj_lnr_frinf","npc_vj_lnr_mrinf","npc_vj_lnr_lnfm","npc_vj_lnr_lnmm","npc_vj_lnr_lnfr","npc_vj_lnr_lnmr","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc"}
self.LNR2 = {"npc_vj_lnr_lnhl2mm","npc_vj_lnr_lnhl2mf","npc_vj_lnr_hl2mminf","npc_vj_lnr_hl2mfinf","npc_vj_lnr_lncb","npc_vj_lnr_cbinf","npc_vj_lnr_combcrawl","npc_vj_lnr_cheapleinf","npc_vj_lnr_cheaplewal","npc_vj_lnr_femaleheadlesswal","npc_vj_lnr_maleheadlesswal","npc_vj_lnr_femaleinfweapon","npc_vj_lnr_maleinfweapon","npc_vj_lnr_combinfweapon","npc_vj_lnr_femalewalweapon","npc_vj_lnr_malewalweapon","npc_vj_lnr_combwalweapon","npc_vj_lnr_femalewallimbless","npc_vj_lnr_malewallimbless","npc_vj_lnr_malecrawl","npc_vj_lnr_femalecrawl","npc_vj_lnr_corpsewal","npc_vj_lnr_hevwal","npc_vj_lnr_zombi","npc_vj_lnr_zombi_corpse","npc_vj_lnr_tarman","npc_vj_lnr_fminf","npc_vj_lnr_mminf","npc_vj_lnr_frinf","npc_vj_lnr_mrinf","npc_vj_lnr_lnfm","npc_vj_lnr_lnmm","npc_vj_lnr_lnfr","npc_vj_lnr_lnmr","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc"}
self.LNR3 = {"npc_vj_lnr_gordon","npc_vj_lnr_gman","npc_vj_lnr_gina","npc_vj_lnr_skeleton","npc_vj_lnr_gordoninf","npc_vj_lnr_gmaninf","npc_vj_lnr_ginainf","npc_vj_lnr_skeletoninf","npc_vj_lnr_barney","npc_vj_lnr_barneyinf","npc_vj_lnr_barney","npc_vj_lnr_barneyinf","npc_vj_lnr_hev","npc_vj_lnr_hevinf","npc_vj_lnr_grunt","npc_vj_lnr_gruntinf","npc_vj_lnr_assassin","npc_vj_lnr_assassininf","npc_vj_lnr_blackops","npc_vj_lnr_blackopsinf","npc_vj_lnr_scientist","npc_vj_lnr_scientist","npc_vj_lnr_scientistinf","npc_vj_lnr_scientistinf"}
--self.LNR4 = {"npc_vj_lnr_gordon","npc_vj_lnr_gman","npc_vj_lnr_gina","npc_vj_lnr_skeleton","npc_vj_lnr_gordoninf","npc_vj_lnr_gmaninf","npc_vj_lnr_ginainf","npc_vj_lnr_skeletoninf","npc_vj_lnr_barney","npc_vj_lnr_barneyinf","npc_vj_lnr_barney","npc_vj_lnr_barneyinf","npc_vj_lnr_hev","npc_vj_lnr_hevinf","npc_vj_lnr_grunt","npc_vj_lnr_gruntinf","npc_vj_lnr_assassin","npc_vj_lnr_assassininf","npc_vj_lnr_blackops","npc_vj_lnr_blackopsinf","npc_vj_lnr_scientist","npc_vj_lnr_scientist","npc_vj_lnr_scientistinf","npc_vj_lnr_scientistinf"}
end

if GetConVarNumber("vj_LNR_MapSpawner_HL2") == 1 && GetConVarNumber("vj_LNR_MapSpawner_TF2") == 1 && file.Exists("lua/autorun/vj_lnrtf2_autorun.lua","GAME") then
self.LNR = {"npc_vj_lnr_lnhl2mm","npc_vj_lnr_lnhl2mf","npc_vj_lnr_hl2mminf","npc_vj_lnr_hl2mfinf","npc_vj_lnr_lncb","npc_vj_lnr_cbinf","npc_vj_lnr_combcrawl","npc_vj_lnr_cheapleinf","npc_vj_lnr_cheaplewal","npc_vj_lnr_femaleheadlesswal","npc_vj_lnr_maleheadlesswal","npc_vj_lnr_femaleinfweapon","npc_vj_lnr_maleinfweapon","npc_vj_lnr_combinfweapon","npc_vj_lnr_femalewalweapon","npc_vj_lnr_malewalweapon","npc_vj_lnr_combwalweapon","npc_vj_lnr_femalewallimbless","npc_vj_lnr_malewallimbless","npc_vj_lnr_malecrawl","npc_vj_lnr_femalecrawl","npc_vj_lnr_corpsewal","npc_vj_lnr_hevwal","npc_vj_lnr_zombi","npc_vj_lnr_zombi_corpse","npc_vj_lnr_tarman","npc_vj_lnr_fminf","npc_vj_lnr_mminf","npc_vj_lnr_frinf","npc_vj_lnr_mrinf","npc_vj_lnr_lnfm","npc_vj_lnr_lnmm","npc_vj_lnr_lnfr","npc_vj_lnr_lnmr","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc"}
self.LNR2 = {"npc_vj_lnr_lnhl2mm","npc_vj_lnr_lnhl2mf","npc_vj_lnr_hl2mminf","npc_vj_lnr_hl2mfinf","npc_vj_lnr_lncb","npc_vj_lnr_cbinf","npc_vj_lnr_combcrawl","npc_vj_lnr_cheapleinf","npc_vj_lnr_cheaplewal","npc_vj_lnr_femaleheadlesswal","npc_vj_lnr_maleheadlesswal","npc_vj_lnr_femaleinfweapon","npc_vj_lnr_maleinfweapon","npc_vj_lnr_combinfweapon","npc_vj_lnr_femalewalweapon","npc_vj_lnr_malewalweapon","npc_vj_lnr_combwalweapon","npc_vj_lnr_femalewallimbless","npc_vj_lnr_malewallimbless","npc_vj_lnr_malecrawl","npc_vj_lnr_femalecrawl","npc_vj_lnr_corpsewal","npc_vj_lnr_hevwal","npc_vj_lnr_zombi","npc_vj_lnr_zombi_corpse","npc_vj_lnr_tarman","npc_vj_lnr_fminf","npc_vj_lnr_mminf","npc_vj_lnr_frinf","npc_vj_lnr_mrinf","npc_vj_lnr_lnfm","npc_vj_lnr_lnmm","npc_vj_lnr_lnfr","npc_vj_lnr_lnmr","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc"}
self.LNR3 = {"npc_vj_lnr_bluwal","npc_vj_lnr_bluinf","npc_vj_lnr_redwal","npc_vj_lnr_redinf"}
--self.LNR4 = {"npc_vj_lnr_bluwal","npc_vj_lnr_bluinf","npc_vj_lnr_redwal","npc_vj_lnr_redinf"}
end

if GetConVarNumber("vj_LNR_MapSpawner_HL2") == 1 && GetConVarNumber("vj_LNR_MapSpawner_Extras") == 1 && file.Exists("lua/autorun/vj_lnrtf2_autorun.lua","GAME") then
self.LNR = {"npc_vj_lnr_lnhl2mm","npc_vj_lnr_lnhl2mf","npc_vj_lnr_hl2mminf","npc_vj_lnr_hl2mfinf","npc_vj_lnr_lncb","npc_vj_lnr_cbinf","npc_vj_lnr_combcrawl","npc_vj_lnr_cheapleinf","npc_vj_lnr_cheaplewal","npc_vj_lnr_femaleheadlesswal","npc_vj_lnr_maleheadlesswal","npc_vj_lnr_femaleinfweapon","npc_vj_lnr_maleinfweapon","npc_vj_lnr_combinfweapon","npc_vj_lnr_femalewalweapon","npc_vj_lnr_malewalweapon","npc_vj_lnr_combwalweapon","npc_vj_lnr_femalewallimbless","npc_vj_lnr_malewallimbless","npc_vj_lnr_malecrawl","npc_vj_lnr_femalecrawl","npc_vj_lnr_corpsewal","npc_vj_lnr_hevwal","npc_vj_lnr_zombi","npc_vj_lnr_zombi_corpse","npc_vj_lnr_tarman","npc_vj_lnr_fminf","npc_vj_lnr_mminf","npc_vj_lnr_frinf","npc_vj_lnr_mrinf","npc_vj_lnr_lnfm","npc_vj_lnr_lnmm","npc_vj_lnr_lnfr","npc_vj_lnr_lnmr","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc"}
self.LNR2 = {"npc_vj_lnr_lnhl2mm","npc_vj_lnr_lnhl2mf","npc_vj_lnr_hl2mminf","npc_vj_lnr_hl2mfinf","npc_vj_lnr_lncb","npc_vj_lnr_cbinf","npc_vj_lnr_combcrawl","npc_vj_lnr_cheapleinf","npc_vj_lnr_cheaplewal","npc_vj_lnr_femaleheadlesswal","npc_vj_lnr_maleheadlesswal","npc_vj_lnr_femaleinfweapon","npc_vj_lnr_maleinfweapon","npc_vj_lnr_combinfweapon","npc_vj_lnr_femalewalweapon","npc_vj_lnr_malewalweapon","npc_vj_lnr_combwalweapon","npc_vj_lnr_femalewallimbless","npc_vj_lnr_malewallimbless","npc_vj_lnr_malecrawl","npc_vj_lnr_femalecrawl","npc_vj_lnr_corpsewal","npc_vj_lnr_hevwal","npc_vj_lnr_zombi","npc_vj_lnr_zombi_corpse","npc_vj_lnr_tarman","npc_vj_lnr_fminf","npc_vj_lnr_mminf","npc_vj_lnr_frinf","npc_vj_lnr_mrinf","npc_vj_lnr_lnfm","npc_vj_lnr_lnmm","npc_vj_lnr_lnfr","npc_vj_lnr_lnmr","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc"}
self.LNR3 = {"npc_vj_lnr_nmrihminf_surv","npc_vj_lnr_nmrihm_surv","npc_vj_lnr_nmrihm_nginf_extra","npc_vj_lnr_nmrihm_ng_extra","npc_vj_lnr_nmrihfinf_surv","npc_vj_lnr_nmrihf_surv","npc_vj_lnr_cncm_operator","npc_vj_lnr_cncm_operatorinf","npc_vj_lnr_swatinf","npc_vj_lnr_swatwal","npc_vj_lnr_rangerinf","npc_vj_lnr_rangerwal","npc_vj_lnr_nmrihm_nginf","npc_vj_lnr_nmrihm_ng","npc_vj_lnr_fcorpseinf","npc_vj_lnr_fcorpsewal","npc_vj_lnr_mcorpseinf","npc_vj_lnr_mcorpsewal","npc_vj_lnr_nh2mt","npc_vj_lnr_nh2minft","npc_vj_lnr_nh2m_surinf","npc_vj_lnr_nh2minf","npc_vj_lnr_nh2finf","npc_vj_lnr_nh2m_sur","npc_vj_lnr_nh2m","npc_vj_lnr_nh2f","npc_vj_lnr_nh2f","npc_vj_lnr_nmrihfinf","npc_vj_lnr_nmrihminf","npc_vj_lnr_nmrihf","npc_vj_lnr_nmrihm","npc_vj_lnr_zpsfinf","npc_vj_lnr_zpsminf","npc_vj_lnr_zpsf","npc_vj_lnr_zpsm","npc_vj_lnr_zm2finf","npc_vj_lnr_zm2minf","npc_vj_lnr_smominf","npc_vj_lnr_galfinf","npc_vj_lnr_galminf","npc_vj_lnr_zm2f","npc_vj_lnr_zm2m","npc_vj_lnr_smom","npc_vj_lnr_galf","npc_vj_lnr_galm","npc_vj_lnr_fcorpseinf","npc_vj_lnr_fcorpsewal","npc_vj_lnr_mcorpseinf","npc_vj_lnr_mcorpsewal","npc_vj_lnr_nh2mt","npc_vj_lnr_nh2minft","npc_vj_lnr_nh2m_surinf","npc_vj_lnr_nh2minf","npc_vj_lnr_nh2finf","npc_vj_lnr_nh2m_sur","npc_vj_lnr_nh2m","npc_vj_lnr_nh2f","npc_vj_lnr_nh2f","npc_vj_lnr_nmrihfinf","npc_vj_lnr_nmrihminf","npc_vj_lnr_nmrihf","npc_vj_lnr_nmrihm","npc_vj_lnr_zpsfinf","npc_vj_lnr_zpsminf","npc_vj_lnr_zpsf","npc_vj_lnr_zpsm","npc_vj_lnr_zm2finf","npc_vj_lnr_zm2minf","npc_vj_lnr_smominf","npc_vj_lnr_galfinf","npc_vj_lnr_galminf","npc_vj_lnr_zm2f","npc_vj_lnr_zm2m","npc_vj_lnr_smom","npc_vj_lnr_galf","npc_vj_lnr_galm"}
--self.LNR4 = {"npc_vj_lnr_nmrihminf_surv","npc_vj_lnr_nmrihm_surv","npc_vj_lnr_nmrihm_nginf_extra","npc_vj_lnr_nmrihm_ng_extra","npc_vj_lnr_nmrihfinf_surv","npc_vj_lnr_nmrihf_surv","npc_vj_lnr_cncm_operator","npc_vj_lnr_cncm_operatorinf","npc_vj_lnr_swatinf","npc_vj_lnr_swatwal","npc_vj_lnr_rangerinf","npc_vj_lnr_rangerwal","npc_vj_lnr_nmrihm_nginf","npc_vj_lnr_nmrihm_ng","npc_vj_lnr_fcorpseinf","npc_vj_lnr_fcorpsewal","npc_vj_lnr_mcorpseinf","npc_vj_lnr_mcorpsewal","npc_vj_lnr_nh2mt","npc_vj_lnr_nh2minft","npc_vj_lnr_nh2m_surinf","npc_vj_lnr_nh2minf","npc_vj_lnr_nh2finf","npc_vj_lnr_nh2m_sur","npc_vj_lnr_nh2m","npc_vj_lnr_nh2f","npc_vj_lnr_nh2f","npc_vj_lnr_nmrihfinf","npc_vj_lnr_nmrihminf","npc_vj_lnr_nmrihf","npc_vj_lnr_nmrihm","npc_vj_lnr_zpsfinf","npc_vj_lnr_zpsminf","npc_vj_lnr_zpsf","npc_vj_lnr_zpsm","npc_vj_lnr_zm2finf","npc_vj_lnr_zm2minf","npc_vj_lnr_smominf","npc_vj_lnr_galfinf","npc_vj_lnr_galminf","npc_vj_lnr_zm2f","npc_vj_lnr_zm2m","npc_vj_lnr_smom","npc_vj_lnr_galf","npc_vj_lnr_galm","npc_vj_lnr_fcorpseinf","npc_vj_lnr_fcorpsewal","npc_vj_lnr_mcorpseinf","npc_vj_lnr_mcorpsewal","npc_vj_lnr_nh2mt","npc_vj_lnr_nh2minft","npc_vj_lnr_nh2m_surinf","npc_vj_lnr_nh2minf","npc_vj_lnr_nh2finf","npc_vj_lnr_nh2m_sur","npc_vj_lnr_nh2m","npc_vj_lnr_nh2f","npc_vj_lnr_nh2f","npc_vj_lnr_nmrihfinf","npc_vj_lnr_nmrihminf","npc_vj_lnr_nmrihf","npc_vj_lnr_nmrihm","npc_vj_lnr_zpsfinf","npc_vj_lnr_zpsminf","npc_vj_lnr_zpsf","npc_vj_lnr_zpsm","npc_vj_lnr_zm2finf","npc_vj_lnr_zm2minf","npc_vj_lnr_smominf","npc_vj_lnr_galfinf","npc_vj_lnr_galminf","npc_vj_lnr_zm2f","npc_vj_lnr_zm2m","npc_vj_lnr_smom","npc_vj_lnr_galf","npc_vj_lnr_galm"}
end

if GetConVarNumber("vj_LNR_MapSpawner_HL2") == 1 && GetConVarNumber("vj_LNR_MapSpawner_CSS") == 1 && GetConVarNumber("vj_LNR_MapSpawner_HLS") == 1 && file.Exists("lua/autorun/vj_lnrhls_autorun.lua","GAME") && file.Exists("lua/autorun/vj_lnrcss_autorun.lua","GAME") then
self.LNR = {"npc_vj_lnr_lnhl2mm","npc_vj_lnr_lnhl2mf","npc_vj_lnr_hl2mminf","npc_vj_lnr_hl2mfinf","npc_vj_lnr_lncb","npc_vj_lnr_cbinf","npc_vj_lnr_combcrawl","npc_vj_lnr_cheapleinf","npc_vj_lnr_cheaplewal","npc_vj_lnr_femaleheadlesswal","npc_vj_lnr_maleheadlesswal","npc_vj_lnr_femaleinfweapon","npc_vj_lnr_maleinfweapon","npc_vj_lnr_combinfweapon","npc_vj_lnr_femalewalweapon","npc_vj_lnr_malewalweapon","npc_vj_lnr_combwalweapon","npc_vj_lnr_femalewallimbless","npc_vj_lnr_malewallimbless","npc_vj_lnr_malecrawl","npc_vj_lnr_femalecrawl","npc_vj_lnr_corpsewal","npc_vj_lnr_hevwal","npc_vj_lnr_zombi","npc_vj_lnr_zombi_corpse","npc_vj_lnr_tarman","npc_vj_lnr_fminf","npc_vj_lnr_mminf","npc_vj_lnr_frinf","npc_vj_lnr_mrinf","npc_vj_lnr_lnfm","npc_vj_lnr_lnmm","npc_vj_lnr_lnfr","npc_vj_lnr_lnmr","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc"}
self.LNR2 = {"npc_vj_lnr_lnhl2mm","npc_vj_lnr_lnhl2mf","npc_vj_lnr_hl2mminf","npc_vj_lnr_hl2mfinf","npc_vj_lnr_lncb","npc_vj_lnr_cbinf","npc_vj_lnr_combcrawl","npc_vj_lnr_cheapleinf","npc_vj_lnr_cheaplewal","npc_vj_lnr_femaleheadlesswal","npc_vj_lnr_maleheadlesswal","npc_vj_lnr_femaleinfweapon","npc_vj_lnr_maleinfweapon","npc_vj_lnr_combinfweapon","npc_vj_lnr_femalewalweapon","npc_vj_lnr_malewalweapon","npc_vj_lnr_combwalweapon","npc_vj_lnr_femalewallimbless","npc_vj_lnr_malewallimbless","npc_vj_lnr_malecrawl","npc_vj_lnr_femalecrawl","npc_vj_lnr_corpsewal","npc_vj_lnr_hevwal","npc_vj_lnr_zombi","npc_vj_lnr_zombi_corpse","npc_vj_lnr_tarman","npc_vj_lnr_fminf","npc_vj_lnr_mminf","npc_vj_lnr_frinf","npc_vj_lnr_mrinf","npc_vj_lnr_lnfm","npc_vj_lnr_lnmm","npc_vj_lnr_lnfr","npc_vj_lnr_lnmr","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc"}
self.LNR3 = {"npc_vj_lnr_ct_wal","npc_vj_lnr_t_wal","npc_vj_lnr_ct_inf","npc_vj_lnr_t_inf","npc_vj_lnr_gordon","npc_vj_lnr_gman","npc_vj_lnr_gina","npc_vj_lnr_skeleton","npc_vj_lnr_gordoninf","npc_vj_lnr_gmaninf","npc_vj_lnr_ginainf","npc_vj_lnr_skeletoninf","npc_vj_lnr_barney","npc_vj_lnr_barneyinf","npc_vj_lnr_barney","npc_vj_lnr_barneyinf","npc_vj_lnr_hev","npc_vj_lnr_hevinf","npc_vj_lnr_grunt","npc_vj_lnr_gruntinf","npc_vj_lnr_assassin","npc_vj_lnr_assassininf","npc_vj_lnr_blackops","npc_vj_lnr_blackopsinf","npc_vj_lnr_scientist","npc_vj_lnr_scientist","npc_vj_lnr_scientistinf","npc_vj_lnr_scientistinf"}
--self.LNR4 = {"npc_vj_lnr_ct_wal","npc_vj_lnr_t_wal","npc_vj_lnr_ct_inf","npc_vj_lnr_t_inf","npc_vj_lnr_gordon","npc_vj_lnr_gman","npc_vj_lnr_gina","npc_vj_lnr_skeleton","npc_vj_lnr_gordoninf","npc_vj_lnr_gmaninf","npc_vj_lnr_ginainf","npc_vj_lnr_skeletoninf","npc_vj_lnr_barney","npc_vj_lnr_barneyinf","npc_vj_lnr_barney","npc_vj_lnr_barneyinf","npc_vj_lnr_hev","npc_vj_lnr_hevinf","npc_vj_lnr_grunt","npc_vj_lnr_gruntinf","npc_vj_lnr_assassin","npc_vj_lnr_assassininf","npc_vj_lnr_blackops","npc_vj_lnr_blackopsinf","npc_vj_lnr_scientist","npc_vj_lnr_scientist","npc_vj_lnr_scientistinf","npc_vj_lnr_scientistinf"}
end

if GetConVarNumber("vj_LNR_MapSpawner_HL2") == 1 && GetConVarNumber("vj_LNR_MapSpawner_CSS") == 1 && GetConVarNumber("vj_LNR_MapSpawner_HLS") == 1 && GetConVarNumber("vj_LNR_MapSpawner_TF2") == 1 && GetConVarNumber("vj_LNR_MapSpawner_L4D") == 1 && GetConVarNumber("vj_LNR_MapSpawner_Extras") == 1 && file.Exists("lua/autorun/vj_lnrextras_autorun.lua","GAME") && file.Exists("lua/autorun/vj_lnrl4d_autorun.lua","GAME")  && file.Exists("lua/autorun/vj_lnrtf2_autorun.lua","GAME") && file.Exists("lua/autorun/vj_lnrhls_autorun.lua","GAME") && file.Exists("lua/autorun/vj_lnrcss_autorun.lua","GAME") then
self.LNR = {"npc_vj_lnr_lnhl2mm","npc_vj_lnr_lnhl2mf","npc_vj_lnr_hl2mminf","npc_vj_lnr_hl2mfinf","npc_vj_lnr_lncb","npc_vj_lnr_cbinf","npc_vj_lnr_combcrawl","npc_vj_lnr_cheapleinf","npc_vj_lnr_cheaplewal","npc_vj_lnr_femaleheadlesswal","npc_vj_lnr_maleheadlesswal","npc_vj_lnr_femaleinfweapon","npc_vj_lnr_maleinfweapon","npc_vj_lnr_combinfweapon","npc_vj_lnr_femalewalweapon","npc_vj_lnr_malewalweapon","npc_vj_lnr_combwalweapon","npc_vj_lnr_femalewallimbless","npc_vj_lnr_malewallimbless","npc_vj_lnr_malecrawl","npc_vj_lnr_femalecrawl","npc_vj_lnr_corpsewal","npc_vj_lnr_hevwal","npc_vj_lnr_zombi","npc_vj_lnr_zombi_corpse","npc_vj_lnr_tarman","npc_vj_lnr_fminf","npc_vj_lnr_mminf","npc_vj_lnr_frinf","npc_vj_lnr_mrinf","npc_vj_lnr_lnfm","npc_vj_lnr_lnmm","npc_vj_lnr_lnfr","npc_vj_lnr_lnmr","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc"}
self.LNR2 = {"npc_vj_lnr_lnhl2mm","npc_vj_lnr_lnhl2mf","npc_vj_lnr_hl2mminf","npc_vj_lnr_hl2mfinf","npc_vj_lnr_lncb","npc_vj_lnr_cbinf","npc_vj_lnr_combcrawl","npc_vj_lnr_cheapleinf","npc_vj_lnr_cheaplewal","npc_vj_lnr_femaleheadlesswal","npc_vj_lnr_maleheadlesswal","npc_vj_lnr_femaleinfweapon","npc_vj_lnr_maleinfweapon","npc_vj_lnr_combinfweapon","npc_vj_lnr_femalewalweapon","npc_vj_lnr_malewalweapon","npc_vj_lnr_combwalweapon","npc_vj_lnr_femalewallimbless","npc_vj_lnr_malewallimbless","npc_vj_lnr_malecrawl","npc_vj_lnr_femalecrawl","npc_vj_lnr_corpsewal","npc_vj_lnr_hevwal","npc_vj_lnr_zombi","npc_vj_lnr_zombi_corpse","npc_vj_lnr_tarman","npc_vj_lnr_fminf","npc_vj_lnr_mminf","npc_vj_lnr_frinf","npc_vj_lnr_mrinf","npc_vj_lnr_lnfm","npc_vj_lnr_lnmm","npc_vj_lnr_lnfr","npc_vj_lnr_lnmr","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc"}
self.LNR3 = {"npc_vj_lnr_ct_wal","npc_vj_lnr_t_wal","npc_vj_lnr_ct_inf","npc_vj_lnr_t_inf","npc_vj_lnr_gordon","npc_vj_lnr_gman","npc_vj_lnr_gina","npc_vj_lnr_skeleton","npc_vj_lnr_gordoninf","npc_vj_lnr_gmaninf","npc_vj_lnr_ginainf","npc_vj_lnr_skeletoninf","npc_vj_lnr_barney","npc_vj_lnr_barneyinf","npc_vj_lnr_barney","npc_vj_lnr_barneyinf","npc_vj_lnr_hev","npc_vj_lnr_hevinf","npc_vj_lnr_grunt","npc_vj_lnr_gruntinf","npc_vj_lnr_assassin","npc_vj_lnr_assassininf","npc_vj_lnr_blackops","npc_vj_lnr_blackopsinf","npc_vj_lnr_scientist","npc_vj_lnr_scientist","npc_vj_lnr_scientistinf","npc_vj_lnr_scientistinf","npc_vj_lnr_bluwal","npc_vj_lnr_bluinf","npc_vj_lnr_redwal","npc_vj_lnr_redinf","npc_vj_lnr_cncm_operator","npc_vj_lnr_cncm_operatorinf","npc_vj_lnr_swatinf","npc_vj_lnr_swatwal","npc_vj_lnr_rangerinf","npc_vj_lnr_rangerwal","npc_vj_lnr_nmrihm_nginf","npc_vj_lnr_nmrihm_ng","npc_vj_lnr_fcorpseinf","npc_vj_lnr_fcorpsewal","npc_vj_lnr_mcorpseinf","npc_vj_lnr_mcorpsewal","npc_vj_lnr_nh2mt","npc_vj_lnr_nh2minft","npc_vj_lnr_nh2m_surinf","npc_vj_lnr_nh2minf","npc_vj_lnr_nh2finf","npc_vj_lnr_nh2m_sur","npc_vj_lnr_nh2m","npc_vj_lnr_nh2f","npc_vj_lnr_nh2f","npc_vj_lnr_nmrihfinf","npc_vj_lnr_nmrihminf","npc_vj_lnr_nmrihf","npc_vj_lnr_nmrihm","npc_vj_lnr_zpsfinf","npc_vj_lnr_zpsminf","npc_vj_lnr_zpsf","npc_vj_lnr_zpsm","npc_vj_lnr_zm2finf","npc_vj_lnr_zm2minf","npc_vj_lnr_smominf","npc_vj_lnr_galfinf","npc_vj_lnr_galminf","npc_vj_lnr_zm2f","npc_vj_lnr_zm2m","npc_vj_lnr_smom","npc_vj_lnr_galf","npc_vj_lnr_galm","npc_vj_lnr_fcorpseinf","npc_vj_lnr_fcorpsewal","npc_vj_lnr_mcorpseinf","npc_vj_lnr_mcorpsewal","npc_vj_lnr_nh2mt","npc_vj_lnr_nh2minft","npc_vj_lnr_nh2m_surinf","npc_vj_lnr_nh2minf","npc_vj_lnr_nh2finf","npc_vj_lnr_nh2m_sur","npc_vj_lnr_nh2m","npc_vj_lnr_nh2f","npc_vj_lnr_nh2f","npc_vj_lnr_nmrihfinf","npc_vj_lnr_nmrihminf","npc_vj_lnr_nmrihf","npc_vj_lnr_nmrihm","npc_vj_lnr_zpsfinf","npc_vj_lnr_zpsminf","npc_vj_lnr_zpsf","npc_vj_lnr_zpsm","npc_vj_lnr_zm2finf","npc_vj_lnr_zm2minf","npc_vj_lnr_smominf","npc_vj_lnr_galfinf","npc_vj_lnr_galminf","npc_vj_lnr_zm2f","npc_vj_lnr_zm2m","npc_vj_lnr_smom","npc_vj_lnr_galf","npc_vj_lnr_galm"}
--self.LNR4 = {"npc_vj_lnr_ct_wal","npc_vj_lnr_t_wal","npc_vj_lnr_ct_inf","npc_vj_lnr_t_inf","npc_vj_lnr_gordon","npc_vj_lnr_gman","npc_vj_lnr_gina","npc_vj_lnr_skeleton","npc_vj_lnr_gordoninf","npc_vj_lnr_gmaninf","npc_vj_lnr_ginainf","npc_vj_lnr_skeletoninf","npc_vj_lnr_barney","npc_vj_lnr_barneyinf","npc_vj_lnr_barney","npc_vj_lnr_barneyinf","npc_vj_lnr_hev","npc_vj_lnr_hevinf","npc_vj_lnr_grunt","npc_vj_lnr_gruntinf","npc_vj_lnr_assassin","npc_vj_lnr_assassininf","npc_vj_lnr_blackops","npc_vj_lnr_blackopsinf","npc_vj_lnr_scientist","npc_vj_lnr_scientist","npc_vj_lnr_scientistinf","npc_vj_lnr_scientistinf","npc_vj_lnr_bluwal","npc_vj_lnr_bluinf","npc_vj_lnr_redwal","npc_vj_lnr_redinf","npc_vj_lnr_cncm_operator","npc_vj_lnr_cncm_operatorinf","npc_vj_lnr_swatinf","npc_vj_lnr_swatwal","npc_vj_lnr_rangerinf","npc_vj_lnr_rangerwal","npc_vj_lnr_nmrihm_nginf","npc_vj_lnr_nmrihm_ng","npc_vj_lnr_fcorpseinf","npc_vj_lnr_fcorpsewal","npc_vj_lnr_mcorpseinf","npc_vj_lnr_mcorpsewal","npc_vj_lnr_nh2mt","npc_vj_lnr_nh2minft","npc_vj_lnr_nh2m_surinf","npc_vj_lnr_nh2minf","npc_vj_lnr_nh2finf","npc_vj_lnr_nh2m_sur","npc_vj_lnr_nh2m","npc_vj_lnr_nh2f","npc_vj_lnr_nh2f","npc_vj_lnr_nmrihfinf","npc_vj_lnr_nmrihminf","npc_vj_lnr_nmrihf","npc_vj_lnr_nmrihm","npc_vj_lnr_zpsfinf","npc_vj_lnr_zpsminf","npc_vj_lnr_zpsf","npc_vj_lnr_zpsm","npc_vj_lnr_zm2finf","npc_vj_lnr_zm2minf","npc_vj_lnr_smominf","npc_vj_lnr_galfinf","npc_vj_lnr_galminf","npc_vj_lnr_zm2f","npc_vj_lnr_zm2m","npc_vj_lnr_smom","npc_vj_lnr_galf","npc_vj_lnr_galm","npc_vj_lnr_fcorpseinf","npc_vj_lnr_fcorpsewal","npc_vj_lnr_mcorpseinf","npc_vj_lnr_mcorpsewal","npc_vj_lnr_nh2mt","npc_vj_lnr_nh2minft","npc_vj_lnr_nh2m_surinf","npc_vj_lnr_nh2minf","npc_vj_lnr_nh2finf","npc_vj_lnr_nh2m_sur","npc_vj_lnr_nh2m","npc_vj_lnr_nh2f","npc_vj_lnr_nh2f","npc_vj_lnr_nmrihfinf","npc_vj_lnr_nmrihminf","npc_vj_lnr_nmrihf","npc_vj_lnr_nmrihm","npc_vj_lnr_zpsfinf","npc_vj_lnr_zpsminf","npc_vj_lnr_zpsf","npc_vj_lnr_zpsm","npc_vj_lnr_zm2finf","npc_vj_lnr_zm2minf","npc_vj_lnr_smominf","npc_vj_lnr_galfinf","npc_vj_lnr_galminf","npc_vj_lnr_zm2f","npc_vj_lnr_zm2m","npc_vj_lnr_smom","npc_vj_lnr_galf","npc_vj_lnr_galm"}
end

if GetConVarNumber("vj_LNR_MapSpawner_Specials") == 1 && GetConVarNumber("vj_LNR_MapSpawner_HL2") == 1 && file.Exists("lua/autorun/vj_lnrspecials_autorun.lua","GAME") then
self.LNR = {"npc_vj_lnr_fatso","npc_vj_lnr_punk","npc_vj_lnr_drowner_ground","npc_vj_lnr_tankinf","npc_vj_lnr_titan_mini","npc_vj_lnr_titan","npc_vj_lnr_tyrant","npc_vj_lnr_carrier","npc_vj_lnr_butcher_chainsaw","npc_vj_lnr_hazinf","npc_vj_lnr_hazwal","npc_vj_lnr_eleczom","npc_vj_lnr_flamzom","npc_vj_lnr_spitter","npc_vj_lnr_spitter","npc_vj_lnr_ravager","npc_vj_lnr_healer","npc_vj_lnr_healer","npc_vj_lnr_butcher","npc_vj_lnr_nh2_secshield","npc_vj_lnr_infbomber","npc_vj_lnr_walbomber","npc_vj_lnr_brute","npc_vj_lnr_shambler","npc_vj_lnr_evo","npc_vj_lnr_nh2_sec","npc_vj_lnr_nh2_secinf","npc_vj_lnr_carrier","npc_vj_lnr_carrier","npc_vj_lnr_butcher_chainsaw","npc_vj_lnr_hazinf","npc_vj_lnr_hazwal","npc_vj_lnr_eleczom","npc_vj_lnr_flamzom","npc_vj_lnr_spitter","npc_vj_lnr_spitter","npc_vj_lnr_ravager","npc_vj_lnr_healer","npc_vj_lnr_healer","npc_vj_lnr_butcher","npc_vj_lnr_nh2_secshield","npc_vj_lnr_infbomber","npc_vj_lnr_walbomber","npc_vj_lnr_brute","npc_vj_lnr_shambler","npc_vj_lnr_evo","npc_vj_lnr_nh2_sec","npc_vj_lnr_nh2_secinf"}
self.LNR2 = {"npc_vj_lnr_lnhl2mm","npc_vj_lnr_lnhl2mf","npc_vj_lnr_hl2mminf","npc_vj_lnr_hl2mfinf","npc_vj_lnr_lncb","npc_vj_lnr_cbinf","npc_vj_lnr_combcrawl","npc_vj_lnr_cheapleinf","npc_vj_lnr_cheaplewal","npc_vj_lnr_femaleheadlesswal","npc_vj_lnr_maleheadlesswal","npc_vj_lnr_femaleinfweapon","npc_vj_lnr_maleinfweapon","npc_vj_lnr_combinfweapon","npc_vj_lnr_femalewalweapon","npc_vj_lnr_malewalweapon","npc_vj_lnr_combwalweapon","npc_vj_lnr_femalewallimbless","npc_vj_lnr_malewallimbless","npc_vj_lnr_malecrawl","npc_vj_lnr_femalecrawl","npc_vj_lnr_corpsewal","npc_vj_lnr_hevwal","npc_vj_lnr_zombi","npc_vj_lnr_zombi_corpse","npc_vj_lnr_tarman","npc_vj_lnr_fminf","npc_vj_lnr_mminf","npc_vj_lnr_frinf","npc_vj_lnr_mrinf","npc_vj_lnr_lnfm","npc_vj_lnr_lnmm","npc_vj_lnr_lnfr","npc_vj_lnr_lnmr","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc"}
self.LNR3 = {"npc_vj_lnr_lnhl2mm","npc_vj_lnr_lnhl2mf","npc_vj_lnr_hl2mminf","npc_vj_lnr_hl2mfinf","npc_vj_lnr_lncb","npc_vj_lnr_cbinf","npc_vj_lnr_combcrawl","npc_vj_lnr_cheapleinf","npc_vj_lnr_cheaplewal","npc_vj_lnr_femaleheadlesswal","npc_vj_lnr_maleheadlesswal","npc_vj_lnr_femaleinfweapon","npc_vj_lnr_maleinfweapon","npc_vj_lnr_combinfweapon","npc_vj_lnr_femalewalweapon","npc_vj_lnr_malewalweapon","npc_vj_lnr_combwalweapon","npc_vj_lnr_femalewallimbless","npc_vj_lnr_malewallimbless","npc_vj_lnr_malecrawl","npc_vj_lnr_femalecrawl","npc_vj_lnr_corpsewal","npc_vj_lnr_hevwal","npc_vj_lnr_zombi","npc_vj_lnr_zombi_corpse","npc_vj_lnr_tarman","npc_vj_lnr_fminf","npc_vj_lnr_mminf","npc_vj_lnr_frinf","npc_vj_lnr_mrinf","npc_vj_lnr_lnfm","npc_vj_lnr_lnmm","npc_vj_lnr_lnfr","npc_vj_lnr_lnmr","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc"}
--self.LNR4 = {"npc_vj_lnr_lnhl2mm","npc_vj_lnr_lnhl2mf","npc_vj_lnr_hl2mminf","npc_vj_lnr_hl2mfinf","npc_vj_lnr_lncb","npc_vj_lnr_cbinf","npc_vj_lnr_combcrawl","npc_vj_lnr_cheapleinf","npc_vj_lnr_cheaplewal","npc_vj_lnr_femaleheadlesswal","npc_vj_lnr_maleheadlesswal","npc_vj_lnr_femaleinfweapon","npc_vj_lnr_maleinfweapon","npc_vj_lnr_combinfweapon","npc_vj_lnr_femalewalweapon","npc_vj_lnr_malewalweapon","npc_vj_lnr_combwalweapon","npc_vj_lnr_femalewallimbless","npc_vj_lnr_malewallimbless","npc_vj_lnr_malecrawl","npc_vj_lnr_femalecrawl","npc_vj_lnr_corpsewal","npc_vj_lnr_hevwal","npc_vj_lnr_zombi","npc_vj_lnr_zombi_corpse","npc_vj_lnr_tarman","npc_vj_lnr_fminf","npc_vj_lnr_mminf","npc_vj_lnr_frinf","npc_vj_lnr_mrinf","npc_vj_lnr_lnfm","npc_vj_lnr_lnmm","npc_vj_lnr_lnfr","npc_vj_lnr_lnmr","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc"}
end

if GetConVarNumber("vj_LNR_MapSpawner_Specials") == 1 && GetConVarNumber("vj_LNR_MapSpawner_HL2") == 1 && GetConVarNumber("vj_LNR_MapSpawner_Extras") == 1 && file.Exists("lua/autorun/vj_lnrextras_autorun.lua","GAME") && file.Exists("lua/autorun/vj_lnrspecials_autorun.lua","GAME") then
self.LNR = {"npc_vj_lnr_fatso","npc_vj_lnr_punk","npc_vj_lnr_drowner_ground","npc_vj_lnr_tankinf","npc_vj_lnr_titan_mini","npc_vj_lnr_titan","npc_vj_lnr_tyrant","npc_vj_lnr_carrier","npc_vj_lnr_butcher_chainsaw","npc_vj_lnr_hazinf","npc_vj_lnr_hazwal","npc_vj_lnr_eleczom","npc_vj_lnr_flamzom","npc_vj_lnr_spitter","npc_vj_lnr_spitter","npc_vj_lnr_ravager","npc_vj_lnr_healer","npc_vj_lnr_healer","npc_vj_lnr_butcher","npc_vj_lnr_nh2_secshield","npc_vj_lnr_infbomber","npc_vj_lnr_walbomber","npc_vj_lnr_brute","npc_vj_lnr_shambler","npc_vj_lnr_evo","npc_vj_lnr_nh2_sec","npc_vj_lnr_nh2_secinf","npc_vj_lnr_carrier","npc_vj_lnr_carrier","npc_vj_lnr_butcher_chainsaw","npc_vj_lnr_hazinf","npc_vj_lnr_hazwal","npc_vj_lnr_eleczom","npc_vj_lnr_flamzom","npc_vj_lnr_spitter","npc_vj_lnr_spitter","npc_vj_lnr_ravager","npc_vj_lnr_healer","npc_vj_lnr_healer","npc_vj_lnr_butcher","npc_vj_lnr_nh2_secshield","npc_vj_lnr_infbomber","npc_vj_lnr_walbomber","npc_vj_lnr_brute","npc_vj_lnr_shambler","npc_vj_lnr_evo","npc_vj_lnr_nh2_sec","npc_vj_lnr_nh2_secinf"}
self.LNR2 = {"npc_vj_lnr_lnhl2mm","npc_vj_lnr_lnhl2mf","npc_vj_lnr_hl2mminf","npc_vj_lnr_hl2mfinf","npc_vj_lnr_lncb","npc_vj_lnr_cbinf","npc_vj_lnr_combcrawl","npc_vj_lnr_cheapleinf","npc_vj_lnr_cheaplewal","npc_vj_lnr_femaleheadlesswal","npc_vj_lnr_maleheadlesswal","npc_vj_lnr_femaleinfweapon","npc_vj_lnr_maleinfweapon","npc_vj_lnr_combinfweapon","npc_vj_lnr_femalewalweapon","npc_vj_lnr_malewalweapon","npc_vj_lnr_combwalweapon","npc_vj_lnr_femalewallimbless","npc_vj_lnr_malewallimbless","npc_vj_lnr_malecrawl","npc_vj_lnr_femalecrawl","npc_vj_lnr_corpsewal","npc_vj_lnr_hevwal","npc_vj_lnr_zombi","npc_vj_lnr_zombi_corpse","npc_vj_lnr_tarman","npc_vj_lnr_fminf","npc_vj_lnr_mminf","npc_vj_lnr_frinf","npc_vj_lnr_mrinf","npc_vj_lnr_lnfm","npc_vj_lnr_lnmm","npc_vj_lnr_lnfr","npc_vj_lnr_lnmr","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_cncm_operator","npc_vj_lnr_cncm_operatorinf","npc_vj_lnr_swatinf","npc_vj_lnr_swatwal","npc_vj_lnr_rangerinf","npc_vj_lnr_rangerwal","npc_vj_lnr_nmrihm_nginf","npc_vj_lnr_nmrihm_ng","npc_vj_lnr_fcorpseinf","npc_vj_lnr_fcorpsewal","npc_vj_lnr_mcorpseinf","npc_vj_lnr_mcorpsewal","npc_vj_lnr_nh2mt","npc_vj_lnr_nh2minft","npc_vj_lnr_nh2m_surinf","npc_vj_lnr_nh2minf","npc_vj_lnr_nh2finf","npc_vj_lnr_nh2m_sur","npc_vj_lnr_nh2m","npc_vj_lnr_nh2f","npc_vj_lnr_nh2f","npc_vj_lnr_nmrihfinf","npc_vj_lnr_nmrihminf","npc_vj_lnr_nmrihf","npc_vj_lnr_nmrihm","npc_vj_lnr_zpsfinf","npc_vj_lnr_zpsminf","npc_vj_lnr_zpsf","npc_vj_lnr_zpsm","npc_vj_lnr_zm2finf","npc_vj_lnr_zm2minf","npc_vj_lnr_smominf","npc_vj_lnr_galfinf","npc_vj_lnr_galminf","npc_vj_lnr_zm2f","npc_vj_lnr_zm2m","npc_vj_lnr_smom","npc_vj_lnr_galf","npc_vj_lnr_galm","npc_vj_lnr_fcorpseinf","npc_vj_lnr_fcorpsewal","npc_vj_lnr_mcorpseinf","npc_vj_lnr_mcorpsewal","npc_vj_lnr_nh2mt","npc_vj_lnr_nh2minft","npc_vj_lnr_nh2m_surinf","npc_vj_lnr_nh2minf","npc_vj_lnr_nh2finf","npc_vj_lnr_nh2m_sur","npc_vj_lnr_nh2m","npc_vj_lnr_nh2f","npc_vj_lnr_nh2f","npc_vj_lnr_nmrihfinf","npc_vj_lnr_nmrihminf","npc_vj_lnr_nmrihf","npc_vj_lnr_nmrihm","npc_vj_lnr_zpsfinf","npc_vj_lnr_zpsminf","npc_vj_lnr_zpsf","npc_vj_lnr_zpsm","npc_vj_lnr_zm2finf","npc_vj_lnr_zm2minf","npc_vj_lnr_smominf","npc_vj_lnr_galfinf","npc_vj_lnr_galminf","npc_vj_lnr_zm2f","npc_vj_lnr_zm2m","npc_vj_lnr_smom","npc_vj_lnr_galf","npc_vj_lnr_galm"}
self.LNR3 = {"npc_vj_lnr_lnhl2mm","npc_vj_lnr_lnhl2mf","npc_vj_lnr_hl2mminf","npc_vj_lnr_hl2mfinf","npc_vj_lnr_lncb","npc_vj_lnr_cbinf","npc_vj_lnr_combcrawl","npc_vj_lnr_cheapleinf","npc_vj_lnr_cheaplewal","npc_vj_lnr_femaleheadlesswal","npc_vj_lnr_maleheadlesswal","npc_vj_lnr_femaleinfweapon","npc_vj_lnr_maleinfweapon","npc_vj_lnr_combinfweapon","npc_vj_lnr_femalewalweapon","npc_vj_lnr_malewalweapon","npc_vj_lnr_combwalweapon","npc_vj_lnr_femalewallimbless","npc_vj_lnr_malewallimbless","npc_vj_lnr_malecrawl","npc_vj_lnr_femalecrawl","npc_vj_lnr_corpsewal","npc_vj_lnr_hevwal","npc_vj_lnr_zombi","npc_vj_lnr_zombi_corpse","npc_vj_lnr_tarman","npc_vj_lnr_fminf","npc_vj_lnr_mminf","npc_vj_lnr_frinf","npc_vj_lnr_mrinf","npc_vj_lnr_lnfm","npc_vj_lnr_lnmm","npc_vj_lnr_lnfr","npc_vj_lnr_lnmr","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_cncm_operator","npc_vj_lnr_cncm_operatorinf","npc_vj_lnr_swatinf","npc_vj_lnr_swatwal","npc_vj_lnr_rangerinf","npc_vj_lnr_rangerwal","npc_vj_lnr_nmrihm_nginf","npc_vj_lnr_nmrihm_ng","npc_vj_lnr_fcorpseinf","npc_vj_lnr_fcorpsewal","npc_vj_lnr_mcorpseinf","npc_vj_lnr_mcorpsewal","npc_vj_lnr_nh2mt","npc_vj_lnr_nh2minft","npc_vj_lnr_nh2m_surinf","npc_vj_lnr_nh2minf","npc_vj_lnr_nh2finf","npc_vj_lnr_nh2m_sur","npc_vj_lnr_nh2m","npc_vj_lnr_nh2f","npc_vj_lnr_nh2f","npc_vj_lnr_nmrihfinf","npc_vj_lnr_nmrihminf","npc_vj_lnr_nmrihf","npc_vj_lnr_nmrihm","npc_vj_lnr_zpsfinf","npc_vj_lnr_zpsminf","npc_vj_lnr_zpsf","npc_vj_lnr_zpsm","npc_vj_lnr_zm2finf","npc_vj_lnr_zm2minf","npc_vj_lnr_smominf","npc_vj_lnr_galfinf","npc_vj_lnr_galminf","npc_vj_lnr_zm2f","npc_vj_lnr_zm2m","npc_vj_lnr_smom","npc_vj_lnr_galf","npc_vj_lnr_galm","npc_vj_lnr_fcorpseinf","npc_vj_lnr_fcorpsewal","npc_vj_lnr_mcorpseinf","npc_vj_lnr_mcorpsewal","npc_vj_lnr_nh2mt","npc_vj_lnr_nh2minft","npc_vj_lnr_nh2m_surinf","npc_vj_lnr_nh2minf","npc_vj_lnr_nh2finf","npc_vj_lnr_nh2m_sur","npc_vj_lnr_nh2m","npc_vj_lnr_nh2f","npc_vj_lnr_nh2f","npc_vj_lnr_nmrihfinf","npc_vj_lnr_nmrihminf","npc_vj_lnr_nmrihf","npc_vj_lnr_nmrihm","npc_vj_lnr_zpsfinf","npc_vj_lnr_zpsminf","npc_vj_lnr_zpsf","npc_vj_lnr_zpsm","npc_vj_lnr_zm2finf","npc_vj_lnr_zm2minf","npc_vj_lnr_smominf","npc_vj_lnr_galfinf","npc_vj_lnr_galminf","npc_vj_lnr_zm2f","npc_vj_lnr_zm2m","npc_vj_lnr_smom","npc_vj_lnr_galf","npc_vj_lnr_galm"}
--self.LNR4 = {"npc_vj_lnr_lnhl2mm","npc_vj_lnr_lnhl2mf","npc_vj_lnr_hl2mminf","npc_vj_lnr_hl2mfinf","npc_vj_lnr_lncb","npc_vj_lnr_cbinf","npc_vj_lnr_combcrawl","npc_vj_lnr_cheapleinf","npc_vj_lnr_cheaplewal","npc_vj_lnr_femaleheadlesswal","npc_vj_lnr_maleheadlesswal","npc_vj_lnr_femaleinfweapon","npc_vj_lnr_maleinfweapon","npc_vj_lnr_combinfweapon","npc_vj_lnr_femalewalweapon","npc_vj_lnr_malewalweapon","npc_vj_lnr_combwalweapon","npc_vj_lnr_femalewallimbless","npc_vj_lnr_malewallimbless","npc_vj_lnr_malecrawl","npc_vj_lnr_femalecrawl","npc_vj_lnr_corpsewal","npc_vj_lnr_hevwal","npc_vj_lnr_zombi","npc_vj_lnr_zombi_corpse","npc_vj_lnr_tarman","npc_vj_lnr_fminf","npc_vj_lnr_mminf","npc_vj_lnr_frinf","npc_vj_lnr_mrinf","npc_vj_lnr_lnfm","npc_vj_lnr_lnmm","npc_vj_lnr_lnfr","npc_vj_lnr_lnmr","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_cncm_operator","npc_vj_lnr_cncm_operatorinf","npc_vj_lnr_swatinf","npc_vj_lnr_swatwal","npc_vj_lnr_rangerinf","npc_vj_lnr_rangerwal","npc_vj_lnr_nmrihm_nginf","npc_vj_lnr_nmrihm_ng","npc_vj_lnr_fcorpseinf","npc_vj_lnr_fcorpsewal","npc_vj_lnr_mcorpseinf","npc_vj_lnr_mcorpsewal","npc_vj_lnr_nh2mt","npc_vj_lnr_nh2minft","npc_vj_lnr_nh2m_surinf","npc_vj_lnr_nh2minf","npc_vj_lnr_nh2finf","npc_vj_lnr_nh2m_sur","npc_vj_lnr_nh2m","npc_vj_lnr_nh2f","npc_vj_lnr_nh2f","npc_vj_lnr_nmrihfinf","npc_vj_lnr_nmrihminf","npc_vj_lnr_nmrihf","npc_vj_lnr_nmrihm","npc_vj_lnr_zpsfinf","npc_vj_lnr_zpsminf","npc_vj_lnr_zpsf","npc_vj_lnr_zpsm","npc_vj_lnr_zm2finf","npc_vj_lnr_zm2minf","npc_vj_lnr_smominf","npc_vj_lnr_galfinf","npc_vj_lnr_galminf","npc_vj_lnr_zm2f","npc_vj_lnr_zm2m","npc_vj_lnr_smom","npc_vj_lnr_galf","npc_vj_lnr_galm","npc_vj_lnr_fcorpseinf","npc_vj_lnr_fcorpsewal","npc_vj_lnr_mcorpseinf","npc_vj_lnr_mcorpsewal","npc_vj_lnr_nh2mt","npc_vj_lnr_nh2minft","npc_vj_lnr_nh2m_surinf","npc_vj_lnr_nh2minf","npc_vj_lnr_nh2finf","npc_vj_lnr_nh2m_sur","npc_vj_lnr_nh2m","npc_vj_lnr_nh2f","npc_vj_lnr_nh2f","npc_vj_lnr_nmrihfinf","npc_vj_lnr_nmrihminf","npc_vj_lnr_nmrihf","npc_vj_lnr_nmrihm","npc_vj_lnr_zpsfinf","npc_vj_lnr_zpsminf","npc_vj_lnr_zpsf","npc_vj_lnr_zpsm","npc_vj_lnr_zm2finf","npc_vj_lnr_zm2minf","npc_vj_lnr_smominf","npc_vj_lnr_galfinf","npc_vj_lnr_galminf","npc_vj_lnr_zm2f","npc_vj_lnr_zm2m","npc_vj_lnr_smom","npc_vj_lnr_galf","npc_vj_lnr_galm"}
end

if GetConVarNumber("vj_LNR_MapSpawner_Specials") == 1 && GetConVarNumber("vj_LNR_MapSpawner_Extras") == 1 && file.Exists("lua/autorun/vj_lnrextras_autorun.lua","GAME") && file.Exists("lua/autorun/vj_lnrspecials_autorun.lua","GAME") then
self.LNR = {"npc_vj_lnr_fatso","npc_vj_lnr_punk","npc_vj_lnr_drowner_ground","npc_vj_lnr_tankinf","npc_vj_lnr_titan_mini","npc_vj_lnr_titan","npc_vj_lnr_tyrant","npc_vj_lnr_carrier","npc_vj_lnr_butcher_chainsaw","npc_vj_lnr_hazinf","npc_vj_lnr_hazwal","npc_vj_lnr_eleczom","npc_vj_lnr_flamzom","npc_vj_lnr_spitter","npc_vj_lnr_spitter","npc_vj_lnr_ravager","npc_vj_lnr_healer","npc_vj_lnr_healer","npc_vj_lnr_butcher","npc_vj_lnr_nh2_secshield","npc_vj_lnr_infbomber","npc_vj_lnr_walbomber","npc_vj_lnr_brute","npc_vj_lnr_shambler","npc_vj_lnr_evo","npc_vj_lnr_nh2_sec","npc_vj_lnr_nh2_secinf","npc_vj_lnr_carrier","npc_vj_lnr_carrier","npc_vj_lnr_butcher_chainsaw","npc_vj_lnr_hazinf","npc_vj_lnr_hazwal","npc_vj_lnr_eleczom","npc_vj_lnr_flamzom","npc_vj_lnr_spitter","npc_vj_lnr_spitter","npc_vj_lnr_ravager","npc_vj_lnr_healer","npc_vj_lnr_healer","npc_vj_lnr_butcher","npc_vj_lnr_nh2_secshield","npc_vj_lnr_infbomber","npc_vj_lnr_walbomber","npc_vj_lnr_brute","npc_vj_lnr_shambler","npc_vj_lnr_evo","npc_vj_lnr_nh2_sec","npc_vj_lnr_nh2_secinf"}
self.LNR2 = {"npc_vj_lnr_nmrihminf_surv","npc_vj_lnr_nmrihm_surv","npc_vj_lnr_nmrihm_nginf_extra","npc_vj_lnr_nmrihm_ng_extra","npc_vj_lnr_nmrihfinf_surv","npc_vj_lnr_nmrihf_surv","npc_vj_lnr_cncm_operator","npc_vj_lnr_cncm_operatorinf","npc_vj_lnr_swatinf","npc_vj_lnr_swatwal","npc_vj_lnr_rangerinf","npc_vj_lnr_rangerwal","npc_vj_lnr_nmrihm_nginf","npc_vj_lnr_nmrihm_ng","npc_vj_lnr_fcorpseinf","npc_vj_lnr_fcorpsewal","npc_vj_lnr_mcorpseinf","npc_vj_lnr_mcorpsewal","npc_vj_lnr_nh2mt","npc_vj_lnr_nh2minft","npc_vj_lnr_nh2m_surinf","npc_vj_lnr_nh2minf","npc_vj_lnr_nh2finf","npc_vj_lnr_nh2m_sur","npc_vj_lnr_nh2m","npc_vj_lnr_nh2f","npc_vj_lnr_nh2f","npc_vj_lnr_nmrihfinf","npc_vj_lnr_nmrihminf","npc_vj_lnr_nmrihf","npc_vj_lnr_nmrihm","npc_vj_lnr_zpsfinf","npc_vj_lnr_zpsminf","npc_vj_lnr_zpsf","npc_vj_lnr_zpsm","npc_vj_lnr_zm2finf","npc_vj_lnr_zm2minf","npc_vj_lnr_smominf","npc_vj_lnr_galfinf","npc_vj_lnr_galminf","npc_vj_lnr_zm2f","npc_vj_lnr_zm2m","npc_vj_lnr_smom","npc_vj_lnr_galf","npc_vj_lnr_galm","npc_vj_lnr_fcorpseinf","npc_vj_lnr_fcorpsewal","npc_vj_lnr_mcorpseinf","npc_vj_lnr_mcorpsewal","npc_vj_lnr_nh2mt","npc_vj_lnr_nh2minft","npc_vj_lnr_nh2m_surinf","npc_vj_lnr_nh2minf","npc_vj_lnr_nh2finf","npc_vj_lnr_nh2m_sur","npc_vj_lnr_nh2m","npc_vj_lnr_nh2f","npc_vj_lnr_nh2f","npc_vj_lnr_nmrihfinf","npc_vj_lnr_nmrihminf","npc_vj_lnr_nmrihf","npc_vj_lnr_nmrihm","npc_vj_lnr_zpsfinf","npc_vj_lnr_zpsminf","npc_vj_lnr_zpsf","npc_vj_lnr_zpsm","npc_vj_lnr_zm2finf","npc_vj_lnr_zm2minf","npc_vj_lnr_smominf","npc_vj_lnr_galfinf","npc_vj_lnr_galminf","npc_vj_lnr_zm2f","npc_vj_lnr_zm2m","npc_vj_lnr_smom","npc_vj_lnr_galf","npc_vj_lnr_galm"}
self.LNR3 = {"npc_vj_lnr_nmrihminf_surv","npc_vj_lnr_nmrihm_surv","npc_vj_lnr_nmrihm_nginf_extra","npc_vj_lnr_nmrihm_ng_extra","npc_vj_lnr_nmrihfinf_surv","npc_vj_lnr_nmrihf_surv","npc_vj_lnr_cncm_operator","npc_vj_lnr_cncm_operatorinf","npc_vj_lnr_swatinf","npc_vj_lnr_swatwal","npc_vj_lnr_rangerinf","npc_vj_lnr_rangerwal","npc_vj_lnr_nmrihm_nginf","npc_vj_lnr_nmrihm_ng","npc_vj_lnr_fcorpseinf","npc_vj_lnr_fcorpsewal","npc_vj_lnr_mcorpseinf","npc_vj_lnr_mcorpsewal","npc_vj_lnr_nh2mt","npc_vj_lnr_nh2minft","npc_vj_lnr_nh2m_surinf","npc_vj_lnr_nh2minf","npc_vj_lnr_nh2finf","npc_vj_lnr_nh2m_sur","npc_vj_lnr_nh2m","npc_vj_lnr_nh2f","npc_vj_lnr_nh2f","npc_vj_lnr_nmrihfinf","npc_vj_lnr_nmrihminf","npc_vj_lnr_nmrihf","npc_vj_lnr_nmrihm","npc_vj_lnr_zpsfinf","npc_vj_lnr_zpsminf","npc_vj_lnr_zpsf","npc_vj_lnr_zpsm","npc_vj_lnr_zm2finf","npc_vj_lnr_zm2minf","npc_vj_lnr_smominf","npc_vj_lnr_galfinf","npc_vj_lnr_galminf","npc_vj_lnr_zm2f","npc_vj_lnr_zm2m","npc_vj_lnr_smom","npc_vj_lnr_galf","npc_vj_lnr_galm","npc_vj_lnr_fcorpseinf","npc_vj_lnr_fcorpsewal","npc_vj_lnr_mcorpseinf","npc_vj_lnr_mcorpsewal","npc_vj_lnr_nh2mt","npc_vj_lnr_nh2minft","npc_vj_lnr_nh2m_surinf","npc_vj_lnr_nh2minf","npc_vj_lnr_nh2finf","npc_vj_lnr_nh2m_sur","npc_vj_lnr_nh2m","npc_vj_lnr_nh2f","npc_vj_lnr_nh2f","npc_vj_lnr_nmrihfinf","npc_vj_lnr_nmrihminf","npc_vj_lnr_nmrihf","npc_vj_lnr_nmrihm","npc_vj_lnr_zpsfinf","npc_vj_lnr_zpsminf","npc_vj_lnr_zpsf","npc_vj_lnr_zpsm","npc_vj_lnr_zm2finf","npc_vj_lnr_zm2minf","npc_vj_lnr_smominf","npc_vj_lnr_galfinf","npc_vj_lnr_galminf","npc_vj_lnr_zm2f","npc_vj_lnr_zm2m","npc_vj_lnr_smom","npc_vj_lnr_galf","npc_vj_lnr_galm"}
--self.LNR4 = {"npc_vj_lnr_nmrihminf_surv","npc_vj_lnr_nmrihm_surv","npc_vj_lnr_nmrihm_nginf_extra","npc_vj_lnr_nmrihm_ng_extra","npc_vj_lnr_nmrihfinf_surv","npc_vj_lnr_nmrihf_surv","npc_vj_lnr_cncm_operator","npc_vj_lnr_cncm_operatorinf","npc_vj_lnr_swatinf","npc_vj_lnr_swatwal","npc_vj_lnr_rangerinf","npc_vj_lnr_rangerwal","npc_vj_lnr_nmrihm_nginf","npc_vj_lnr_nmrihm_ng","npc_vj_lnr_fcorpseinf","npc_vj_lnr_fcorpsewal","npc_vj_lnr_mcorpseinf","npc_vj_lnr_mcorpsewal","npc_vj_lnr_nh2mt","npc_vj_lnr_nh2minft","npc_vj_lnr_nh2m_surinf","npc_vj_lnr_nh2minf","npc_vj_lnr_nh2finf","npc_vj_lnr_nh2m_sur","npc_vj_lnr_nh2m","npc_vj_lnr_nh2f","npc_vj_lnr_nh2f","npc_vj_lnr_nmrihfinf","npc_vj_lnr_nmrihminf","npc_vj_lnr_nmrihf","npc_vj_lnr_nmrihm","npc_vj_lnr_zpsfinf","npc_vj_lnr_zpsminf","npc_vj_lnr_zpsf","npc_vj_lnr_zpsm","npc_vj_lnr_zm2finf","npc_vj_lnr_zm2minf","npc_vj_lnr_smominf","npc_vj_lnr_galfinf","npc_vj_lnr_galminf","npc_vj_lnr_zm2f","npc_vj_lnr_zm2m","npc_vj_lnr_smom","npc_vj_lnr_galf","npc_vj_lnr_galm","npc_vj_lnr_fcorpseinf","npc_vj_lnr_fcorpsewal","npc_vj_lnr_mcorpseinf","npc_vj_lnr_mcorpsewal","npc_vj_lnr_nh2mt","npc_vj_lnr_nh2minft","npc_vj_lnr_nh2m_surinf","npc_vj_lnr_nh2minf","npc_vj_lnr_nh2finf","npc_vj_lnr_nh2m_sur","npc_vj_lnr_nh2m","npc_vj_lnr_nh2f","npc_vj_lnr_nh2f","npc_vj_lnr_nmrihfinf","npc_vj_lnr_nmrihminf","npc_vj_lnr_nmrihf","npc_vj_lnr_nmrihm","npc_vj_lnr_zpsfinf","npc_vj_lnr_zpsminf","npc_vj_lnr_zpsf","npc_vj_lnr_zpsm","npc_vj_lnr_zm2finf","npc_vj_lnr_zm2minf","npc_vj_lnr_smominf","npc_vj_lnr_galfinf","npc_vj_lnr_galminf","npc_vj_lnr_zm2f","npc_vj_lnr_zm2m","npc_vj_lnr_smom","npc_vj_lnr_galf","npc_vj_lnr_galm"}
end

if GetConVarNumber("vj_LNR_MapSpawner_HL2") == 1 && GetConVarNumber("vj_LNR_MapSpawner_Specials") == 1 && GetConVarNumber("vj_LNR_MapSpawner_CSS") == 1 && GetConVarNumber("vj_LNR_MapSpawner_HLS") == 1 && GetConVarNumber("vj_LNR_MapSpawner_TF2") == 1 && GetConVarNumber("vj_LNR_MapSpawner_L4D") == 1 && GetConVarNumber("vj_LNR_MapSpawner_Extras") == 1 && file.Exists("lua/autorun/vj_lnrcss_autorun.lua","GAME") && file.Exists("lua/autorun/vj_lnrhls_autorun.lua","GAME") && file.Exists("lua/autorun/vj_lnrtf2_autorun.lua","GAME") && file.Exists("lua/autorun/vj_lnrl4d_autorun.lua","GAME") && file.Exists("lua/autorun/vj_lnrextras_autorun.lua","GAME") && file.Exists("lua/autorun/vj_lnrspecials_autorun.lua","GAME") then
self.LNR = {"npc_vj_lnr_fatso","npc_vj_lnr_punk","npc_vj_lnr_drowner_ground","npc_vj_lnr_tankinf","npc_vj_lnr_titan_mini","npc_vj_lnr_titan","npc_vj_lnr_tyrant","npc_vj_lnr_carrier","npc_vj_lnr_butcher_chainsaw","npc_vj_lnr_hazinf","npc_vj_lnr_hazwal","npc_vj_lnr_eleczom","npc_vj_lnr_flamzom","npc_vj_lnr_spitter","npc_vj_lnr_spitter","npc_vj_lnr_ravager","npc_vj_lnr_healer","npc_vj_lnr_healer","npc_vj_lnr_butcher","npc_vj_lnr_nh2_secshield","npc_vj_lnr_infbomber","npc_vj_lnr_walbomber","npc_vj_lnr_brute","npc_vj_lnr_shambler","npc_vj_lnr_evo","npc_vj_lnr_nh2_sec","npc_vj_lnr_nh2_secinf","npc_vj_lnr_carrier","npc_vj_lnr_carrier","npc_vj_lnr_butcher_chainsaw","npc_vj_lnr_hazinf","npc_vj_lnr_hazwal","npc_vj_lnr_eleczom","npc_vj_lnr_flamzom","npc_vj_lnr_spitter","npc_vj_lnr_spitter","npc_vj_lnr_ravager","npc_vj_lnr_healer","npc_vj_lnr_healer","npc_vj_lnr_butcher","npc_vj_lnr_nh2_secshield","npc_vj_lnr_infbomber","npc_vj_lnr_walbomber","npc_vj_lnr_brute","npc_vj_lnr_shambler","npc_vj_lnr_evo","npc_vj_lnr_nh2_sec","npc_vj_lnr_nh2_secinf"}
self.LNR2 = {"npc_vj_lnr_nmrihminf_surv","npc_vj_lnr_nmrihm_surv","npc_vj_lnr_nmrihm_nginf_extra","npc_vj_lnr_nmrihm_ng_extra","npc_vj_lnr_nmrihfinf_surv","npc_vj_lnr_nmrihf_surv","npc_vj_lnr_cncm_operator","npc_vj_lnr_cncm_operatorinf","npc_vj_lnr_swatinf","npc_vj_lnr_swatwal","npc_vj_lnr_rangerinf","npc_vj_lnr_rangerwal","npc_vj_lnr_nmrihm_nginf","npc_vj_lnr_nmrihm_ng","npc_vj_lnr_fcorpseinf","npc_vj_lnr_fcorpsewal","npc_vj_lnr_mcorpseinf","npc_vj_lnr_mcorpsewal","npc_vj_lnr_nh2mt","npc_vj_lnr_nh2minft","npc_vj_lnr_nh2m_surinf","npc_vj_lnr_nh2minf","npc_vj_lnr_nh2finf","npc_vj_lnr_nh2m_sur","npc_vj_lnr_nh2m","npc_vj_lnr_nh2f","npc_vj_lnr_nh2f","npc_vj_lnr_nmrihfinf","npc_vj_lnr_nmrihminf","npc_vj_lnr_nmrihf","npc_vj_lnr_nmrihm","npc_vj_lnr_zpsfinf","npc_vj_lnr_zpsminf","npc_vj_lnr_zpsf","npc_vj_lnr_zpsm","npc_vj_lnr_zm2finf","npc_vj_lnr_zm2minf","npc_vj_lnr_smominf","npc_vj_lnr_galfinf","npc_vj_lnr_galminf","npc_vj_lnr_zm2f","npc_vj_lnr_zm2m","npc_vj_lnr_smom","npc_vj_lnr_galf","npc_vj_lnr_galm","npc_vj_lnr_fcorpseinf","npc_vj_lnr_fcorpsewal","npc_vj_lnr_mcorpseinf","npc_vj_lnr_mcorpsewal","npc_vj_lnr_nh2mt","npc_vj_lnr_nh2minft","npc_vj_lnr_nh2m_surinf","npc_vj_lnr_nh2minf","npc_vj_lnr_nh2finf","npc_vj_lnr_nh2m_sur","npc_vj_lnr_nh2m","npc_vj_lnr_nh2f","npc_vj_lnr_nh2f","npc_vj_lnr_nmrihfinf","npc_vj_lnr_nmrihminf","npc_vj_lnr_nmrihf","npc_vj_lnr_nmrihm","npc_vj_lnr_zpsfinf","npc_vj_lnr_zpsminf","npc_vj_lnr_zpsf","npc_vj_lnr_zpsm","npc_vj_lnr_zm2finf","npc_vj_lnr_zm2minf","npc_vj_lnr_smominf","npc_vj_lnr_galfinf","npc_vj_lnr_galminf","npc_vj_lnr_zm2f","npc_vj_lnr_zm2m","npc_vj_lnr_smom","npc_vj_lnr_galf","npc_vj_lnr_galm","npc_vj_lnr_msurwal","npc_vj_lnr_fsurwal","npc_vj_lnr_msurinf","npc_vj_lnr_fsurinf","npc_vj_lnr_bluwal","npc_vj_lnr_bluinf","npc_vj_lnr_redwal","npc_vj_lnr_redinf","npc_vj_lnr_gordon","npc_vj_lnr_gman","npc_vj_lnr_gina","npc_vj_lnr_skeleton","npc_vj_lnr_gordoninf","npc_vj_lnr_gmaninf","npc_vj_lnr_ginainf","npc_vj_lnr_skeletoninf","npc_vj_lnr_barney","npc_vj_lnr_barneyinf","npc_vj_lnr_barney","npc_vj_lnr_barneyinf","npc_vj_lnr_hev","npc_vj_lnr_hevinf","npc_vj_lnr_grunt","npc_vj_lnr_gruntinf","npc_vj_lnr_assassin","npc_vj_lnr_assassininf","npc_vj_lnr_blackops","npc_vj_lnr_blackopsinf","npc_vj_lnr_scientist","npc_vj_lnr_scientist","npc_vj_lnr_scientistinf","npc_vj_lnr_scientistinf","npc_vj_lnr_ct_wal","npc_vj_lnr_t_wal","npc_vj_lnr_ct_inf","npc_vj_lnr_t_inf","npc_vj_lnr_lnhl2mm","npc_vj_lnr_lnhl2mf","npc_vj_lnr_hl2mminf","npc_vj_lnr_hl2mfinf","npc_vj_lnr_lncb","npc_vj_lnr_cbinf","npc_vj_lnr_combcrawl","npc_vj_lnr_cheapleinf","npc_vj_lnr_cheaplewal","npc_vj_lnr_femaleheadlesswal","npc_vj_lnr_maleheadlesswal","npc_vj_lnr_femaleinfweapon","npc_vj_lnr_maleinfweapon","npc_vj_lnr_combinfweapon","npc_vj_lnr_femalewalweapon","npc_vj_lnr_malewalweapon","npc_vj_lnr_combwalweapon","npc_vj_lnr_femalewallimbless","npc_vj_lnr_malewallimbless","npc_vj_lnr_malecrawl","npc_vj_lnr_femalecrawl","npc_vj_lnr_corpsewal","npc_vj_lnr_hevwal","npc_vj_lnr_zombi","npc_vj_lnr_zombi_corpse","npc_vj_lnr_tarman","npc_vj_lnr_fminf","npc_vj_lnr_mminf","npc_vj_lnr_frinf","npc_vj_lnr_mrinf","npc_vj_lnr_lnfm","npc_vj_lnr_lnmm","npc_vj_lnr_lnfr","npc_vj_lnr_lnmr","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc"}
self.LNR3 = {"npc_vj_lnr_nmrihminf_surv","npc_vj_lnr_nmrihm_surv","npc_vj_lnr_nmrihm_nginf_extra","npc_vj_lnr_nmrihm_ng_extra","npc_vj_lnr_nmrihfinf_surv","npc_vj_lnr_nmrihf_surv","npc_vj_lnr_cncm_operator","npc_vj_lnr_cncm_operatorinf","npc_vj_lnr_swatinf","npc_vj_lnr_swatwal","npc_vj_lnr_rangerinf","npc_vj_lnr_rangerwal","npc_vj_lnr_nmrihm_nginf","npc_vj_lnr_nmrihm_ng","npc_vj_lnr_fcorpseinf","npc_vj_lnr_fcorpsewal","npc_vj_lnr_mcorpseinf","npc_vj_lnr_mcorpsewal","npc_vj_lnr_nh2mt","npc_vj_lnr_nh2minft","npc_vj_lnr_nh2m_surinf","npc_vj_lnr_nh2minf","npc_vj_lnr_nh2finf","npc_vj_lnr_nh2m_sur","npc_vj_lnr_nh2m","npc_vj_lnr_nh2f","npc_vj_lnr_nh2f","npc_vj_lnr_nmrihfinf","npc_vj_lnr_nmrihminf","npc_vj_lnr_nmrihf","npc_vj_lnr_nmrihm","npc_vj_lnr_zpsfinf","npc_vj_lnr_zpsminf","npc_vj_lnr_zpsf","npc_vj_lnr_zpsm","npc_vj_lnr_zm2finf","npc_vj_lnr_zm2minf","npc_vj_lnr_smominf","npc_vj_lnr_galfinf","npc_vj_lnr_galminf","npc_vj_lnr_zm2f","npc_vj_lnr_zm2m","npc_vj_lnr_smom","npc_vj_lnr_galf","npc_vj_lnr_galm","npc_vj_lnr_fcorpseinf","npc_vj_lnr_fcorpsewal","npc_vj_lnr_mcorpseinf","npc_vj_lnr_mcorpsewal","npc_vj_lnr_nh2mt","npc_vj_lnr_nh2minft","npc_vj_lnr_nh2m_surinf","npc_vj_lnr_nh2minf","npc_vj_lnr_nh2finf","npc_vj_lnr_nh2m_sur","npc_vj_lnr_nh2m","npc_vj_lnr_nh2f","npc_vj_lnr_nh2f","npc_vj_lnr_nmrihfinf","npc_vj_lnr_nmrihminf","npc_vj_lnr_nmrihf","npc_vj_lnr_nmrihm","npc_vj_lnr_zpsfinf","npc_vj_lnr_zpsminf","npc_vj_lnr_zpsf","npc_vj_lnr_zpsm","npc_vj_lnr_zm2finf","npc_vj_lnr_zm2minf","npc_vj_lnr_smominf","npc_vj_lnr_galfinf","npc_vj_lnr_galminf","npc_vj_lnr_zm2f","npc_vj_lnr_zm2m","npc_vj_lnr_smom","npc_vj_lnr_galf","npc_vj_lnr_galm","npc_vj_lnr_msurwal","npc_vj_lnr_fsurwal","npc_vj_lnr_msurinf","npc_vj_lnr_fsurinf","npc_vj_lnr_bluwal","npc_vj_lnr_bluinf","npc_vj_lnr_redwal","npc_vj_lnr_redinf","npc_vj_lnr_gordon","npc_vj_lnr_gman","npc_vj_lnr_gina","npc_vj_lnr_skeleton","npc_vj_lnr_gordoninf","npc_vj_lnr_gmaninf","npc_vj_lnr_ginainf","npc_vj_lnr_skeletoninf","npc_vj_lnr_barney","npc_vj_lnr_barneyinf","npc_vj_lnr_barney","npc_vj_lnr_barneyinf","npc_vj_lnr_hev","npc_vj_lnr_hevinf","npc_vj_lnr_grunt","npc_vj_lnr_gruntinf","npc_vj_lnr_assassin","npc_vj_lnr_assassininf","npc_vj_lnr_blackops","npc_vj_lnr_blackopsinf","npc_vj_lnr_scientist","npc_vj_lnr_scientist","npc_vj_lnr_scientistinf","npc_vj_lnr_scientistinf","npc_vj_lnr_ct_wal","npc_vj_lnr_t_wal","npc_vj_lnr_ct_inf","npc_vj_lnr_t_inf","npc_vj_lnr_lnhl2mm","npc_vj_lnr_lnhl2mf","npc_vj_lnr_hl2mminf","npc_vj_lnr_hl2mfinf","npc_vj_lnr_lncb","npc_vj_lnr_cbinf","npc_vj_lnr_combcrawl","npc_vj_lnr_cheapleinf","npc_vj_lnr_cheaplewal","npc_vj_lnr_femaleheadlesswal","npc_vj_lnr_maleheadlesswal","npc_vj_lnr_femaleinfweapon","npc_vj_lnr_maleinfweapon","npc_vj_lnr_combinfweapon","npc_vj_lnr_femalewalweapon","npc_vj_lnr_malewalweapon","npc_vj_lnr_combwalweapon","npc_vj_lnr_femalewallimbless","npc_vj_lnr_malewallimbless","npc_vj_lnr_malecrawl","npc_vj_lnr_femalecrawl","npc_vj_lnr_corpsewal","npc_vj_lnr_hevwal","npc_vj_lnr_zombi","npc_vj_lnr_zombi_corpse","npc_vj_lnr_tarman","npc_vj_lnr_fminf","npc_vj_lnr_mminf","npc_vj_lnr_frinf","npc_vj_lnr_mrinf","npc_vj_lnr_lnfm","npc_vj_lnr_lnmm","npc_vj_lnr_lnfr","npc_vj_lnr_lnmr","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc"}
--self.LNR4 = {"npc_vj_lnr_nmrihminf_surv","npc_vj_lnr_nmrihm_surv","npc_vj_lnr_nmrihm_nginf_extra","npc_vj_lnr_nmrihm_ng_extra","npc_vj_lnr_nmrihfinf_surv","npc_vj_lnr_nmrihf_surv","npc_vj_lnr_cncm_operator","npc_vj_lnr_cncm_operatorinf","npc_vj_lnr_swatinf","npc_vj_lnr_swatwal","npc_vj_lnr_rangerinf","npc_vj_lnr_rangerwal","npc_vj_lnr_nmrihm_nginf","npc_vj_lnr_nmrihm_ng","npc_vj_lnr_fcorpseinf","npc_vj_lnr_fcorpsewal","npc_vj_lnr_mcorpseinf","npc_vj_lnr_mcorpsewal","npc_vj_lnr_nh2mt","npc_vj_lnr_nh2minft","npc_vj_lnr_nh2m_surinf","npc_vj_lnr_nh2minf","npc_vj_lnr_nh2finf","npc_vj_lnr_nh2m_sur","npc_vj_lnr_nh2m","npc_vj_lnr_nh2f","npc_vj_lnr_nh2f","npc_vj_lnr_nmrihfinf","npc_vj_lnr_nmrihminf","npc_vj_lnr_nmrihf","npc_vj_lnr_nmrihm","npc_vj_lnr_zpsfinf","npc_vj_lnr_zpsminf","npc_vj_lnr_zpsf","npc_vj_lnr_zpsm","npc_vj_lnr_zm2finf","npc_vj_lnr_zm2minf","npc_vj_lnr_smominf","npc_vj_lnr_galfinf","npc_vj_lnr_galminf","npc_vj_lnr_zm2f","npc_vj_lnr_zm2m","npc_vj_lnr_smom","npc_vj_lnr_galf","npc_vj_lnr_galm","npc_vj_lnr_fcorpseinf","npc_vj_lnr_fcorpsewal","npc_vj_lnr_mcorpseinf","npc_vj_lnr_mcorpsewal","npc_vj_lnr_nh2mt","npc_vj_lnr_nh2minft","npc_vj_lnr_nh2m_surinf","npc_vj_lnr_nh2minf","npc_vj_lnr_nh2finf","npc_vj_lnr_nh2m_sur","npc_vj_lnr_nh2m","npc_vj_lnr_nh2f","npc_vj_lnr_nh2f","npc_vj_lnr_nmrihfinf","npc_vj_lnr_nmrihminf","npc_vj_lnr_nmrihf","npc_vj_lnr_nmrihm","npc_vj_lnr_zpsfinf","npc_vj_lnr_zpsminf","npc_vj_lnr_zpsf","npc_vj_lnr_zpsm","npc_vj_lnr_zm2finf","npc_vj_lnr_zm2minf","npc_vj_lnr_smominf","npc_vj_lnr_galfinf","npc_vj_lnr_galminf","npc_vj_lnr_zm2f","npc_vj_lnr_zm2m","npc_vj_lnr_smom","npc_vj_lnr_galf","npc_vj_lnr_galm","npc_vj_lnr_msurwal","npc_vj_lnr_fsurwal","npc_vj_lnr_msurinf","npc_vj_lnr_fsurinf","npc_vj_lnr_bluwal","npc_vj_lnr_bluinf","npc_vj_lnr_redwal","npc_vj_lnr_redinf","npc_vj_lnr_gordon","npc_vj_lnr_gman","npc_vj_lnr_gina","npc_vj_lnr_skeleton","npc_vj_lnr_gordoninf","npc_vj_lnr_gmaninf","npc_vj_lnr_ginainf","npc_vj_lnr_skeletoninf","npc_vj_lnr_barney","npc_vj_lnr_barneyinf","npc_vj_lnr_barney","npc_vj_lnr_barneyinf","npc_vj_lnr_hev","npc_vj_lnr_hevinf","npc_vj_lnr_grunt","npc_vj_lnr_gruntinf","npc_vj_lnr_assassin","npc_vj_lnr_assassininf","npc_vj_lnr_blackops","npc_vj_lnr_blackopsinf","npc_vj_lnr_scientist","npc_vj_lnr_scientist","npc_vj_lnr_scientistinf","npc_vj_lnr_scientistinf","npc_vj_lnr_ct_wal","npc_vj_lnr_t_wal","npc_vj_lnr_ct_inf","npc_vj_lnr_t_inf","npc_vj_lnr_lnhl2mm","npc_vj_lnr_lnhl2mf","npc_vj_lnr_hl2mminf","npc_vj_lnr_hl2mfinf","npc_vj_lnr_lncb","npc_vj_lnr_cbinf","npc_vj_lnr_combcrawl","npc_vj_lnr_cheapleinf","npc_vj_lnr_cheaplewal","npc_vj_lnr_femaleheadlesswal","npc_vj_lnr_maleheadlesswal","npc_vj_lnr_femaleinfweapon","npc_vj_lnr_maleinfweapon","npc_vj_lnr_combinfweapon","npc_vj_lnr_femalewalweapon","npc_vj_lnr_malewalweapon","npc_vj_lnr_combwalweapon","npc_vj_lnr_femalewallimbless","npc_vj_lnr_malewallimbless","npc_vj_lnr_malecrawl","npc_vj_lnr_femalecrawl","npc_vj_lnr_corpsewal","npc_vj_lnr_hevwal","npc_vj_lnr_zombi","npc_vj_lnr_zombi_corpse","npc_vj_lnr_tarman","npc_vj_lnr_fminf","npc_vj_lnr_mminf","npc_vj_lnr_frinf","npc_vj_lnr_mrinf","npc_vj_lnr_lnfm","npc_vj_lnr_lnmm","npc_vj_lnr_lnfr","npc_vj_lnr_lnmr","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_mcinf","npc_vj_lnr_fcinf","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc","npc_vj_lnr_lnmc","npc_vj_lnr_lnfc"}
end

if GetConVarNumber("vj_LNR_MapSpawner_HL2") == 0 && GetConVarNumber("vj_LNR_MapSpawner_Specials") == 0 && GetConVarNumber("vj_LNR_MapSpawner_CSS") == 0 && GetConVarNumber("vj_LNR_MapSpawner_HLS") == 0 && GetConVarNumber("vj_LNR_MapSpawner_TF2") == 0 && GetConVarNumber("vj_LNR_MapSpawner_L4D") == 0 && GetConVarNumber("vj_LNR_MapSpawner_Extras") == 0 then
self:Remove()
PrintMessage(HUD_PRINTTALK, "Spawner removed because there were no options checked.")
end

for k,v in pairs(ents.GetAll()) do  
if v:IsValid() && v != self && v.LNRControl == true then 
PrintMessage(HUD_PRINTTALK, "Only one Map Spawner is allowed.")
self:Remove()
end

 --PrintMessage( HUD_PRINTTALK, "===============================================")
 --PrintMessage( HUD_PRINTTALK, "The Horde comes.....")
 -- PrintMessage( HUD_PRINTTALK, "===============================================")
self:SetMaterial("hud/killicons/default")
self:SetNoDraw(true)
self.VJ_NoTarget = true
self:SetCollisionBounds(Vector(0, 0, 0), -Vector(0, 0, 0))
end 
end			
----------------------------------------
function ENT:CustomOnThink_AIEnabled() 
local max = math.max(60)
if self.CREA == true && self.CREA2 == true then
for k,v in pairs(player.GetAll()) do  
if v:IsValid() && v != self && v:IsPlayer() && v:GetClass() != self:GetClass() && self.CREA == true && self.CREA2 == true && self.CREA3 == true && v:Health() > 0 &&  self.MaxZombie < max  then 
local at = player.GetAll()
local chce = at[math.random(1,#at)]
local pos2 = chce:LocalToWorld(Vector(math.random(-1800,1800),math.random(-1800,1800),17))
self.CREA = false	
self.zombied = ents.Create(VJ_PICK(self.LNR))
self.zombied:SetPos(pos2) 
self.zombied:SetAngles(self:GetAngles()) 
self.zombied:Spawn()
self.zombied.IdleAlwaysWander = false 
self.zombied.DisableWandering = true
self.zombied:SetNoDraw(false)
self.zombied.HasAlertSounds = false
 
self.zombied:Activate() 
self.zombied:SetOwner(self) 
self.zombied.HasSounds = false
self.zombied.FindEnemy_UseSphere = true 
self.zombied.FindEnemy_CanSeeThroughWalls = true
self.zombied.SightDistance = 9900000
self:DeleteOnRemove(self.zombied)
timer.Simple(0.55,function() if IsValid(self.zombied) then 
self.zombied.HasSounds = true
self.zombied.IdleAlwaysWander = true
self.zombied.DisableWandering = false
self.zombied:SetNoDraw(false)
self.zombied.HasAlertSounds = true end end)	
timer.Simple(self.time,function() if IsValid(self) then 
self.CREA = true end end)
local tr1 = {
						start = self.zombied:GetPos(),
						endpos = self.zombied:GetPos() + self.zombied:GetForward()*30 + self.zombied:GetUp()*30,
						mins = self.zombied:OBBMins(),
						maxs = self.zombied:OBBMaxs(),
						filter = {self.zombied}
					}
					local tr = util.TraceHull(tr1)
local tr12 = {
						start = self.zombied:GetPos(),
						endpos = self.zombied:GetPos() + self.zombied:GetForward()*-30 + self.zombied:GetUp()*30,
						mins = self.zombied:OBBMins(),
						maxs = self.zombied:OBBMaxs(),
						filter = {self.zombied}
					}
					local tr2 = util.TraceHull(tr12)		

		local tr13 = {
						start = self.zombied:GetPos(),
						endpos = self.zombied:GetPos() + self.zombied:GetRight()*30 + self.zombied:GetUp()*30,
						mins = self.zombied:OBBMins(),
						maxs = self.zombied:OBBMaxs(),
						filter = {self.zombied}
					}
					local tr3 = util.TraceHull(tr13)	

		local tr14 = {
						start = self.zombied:GetPos(),
						endpos = self.zombied:GetPos() + self.zombied:GetRight()*-30 + self.zombied:GetUp()*30,
						mins = self.zombied:OBBMins(),
						maxs = self.zombied:OBBMaxs(),
						filter = {self.zombied}
					}
					local tr4 = util.TraceHull(tr14)

			local tr15 = {
						start = self.zombied:GetPos(),
						endpos = self.zombied:GetPos() + self.zombied:GetUp()*80,
						mins = self.zombied:OBBMins(),
						maxs = self.zombied:OBBMaxs(),
						filter = {self.zombied}
					}
					local tr5 = util.TraceHull(tr15)		
					
					
if tr.Hit && tr.HitWorld && tr2.HitWorld && tr3.HitWorld && tr4.HitWorld && tr5.HitWorld then

self.zombied:Remove()

end
for k,n in ipairs(ents.GetAll()) do
if IsValid(self.zombied) && n.IsVJBaseSNPC == true && n:GetClass() == self.zombied:GetClass() && n != self && n != self.zombied && self.zombied:GetPos():Distance(n:GetPos()) <= 90 && (!v:Visible(self.zombied) or (!IsValid(seen.Entity))) and  ((chce:GetForward():Dot((self.zombied:GetPos() -chce:GetPos()):GetNormalized()) >= math.cos(math.rad(self.SAngle2))) or (v:GetForward():Dot((self.zombied:GetPos() -v:GetPos()):GetNormalized()) >= math.cos(math.rad(self.SAngle2)))) then
n:Remove()
end
end
if IsValid(self.zombied) && self.zombied:GetPos():Distance(v:GetPos()) <= 300 then
self.zombied:Remove()
end
if self.zombied:WaterLevel() == 3 && IsValid(self.zombied) then
self.zombied:Remove()
end
if !self.zombied:IsInWorld() && IsValid(self.zombied) then
self.zombied:Remove()
end 
timer.Simple(0.55,function() if !IsValid(self.zombied) then 
self.time = 0.65
end end)
if IsValid(self.zombied) then
timer.Simple(0.56,function() if IsValid(self.zombied) then 
self.time = math.random(7,20)
self.MaxZombie = (self.MaxZombie + 1)
self.NUM = (self.NUM + 2)
end end)
end 

if IsValid(self.zombied) then
timer.Simple(0.55,function() if IsValid(self.zombied)  && !self.zombied:IsOnGround() then 
self.zombied:Remove()
end end)
end 

if IsValid(self.zombied) then
timer.Simple(0.55,function() if IsValid(self.zombied)  && !self.zombied:IsMoving() then 
self.zombied:Remove()
end end)
end  
local seen = util.TraceLine({start = self.zombied:NearestPoint(self.zombied:GetPos() + self.zombied:OBBCenter()),endpos = v:EyePos()})
if IsValid(self.zombied) && (IsValid(seen.Entity) == v:GetEyeTrace().Entity or v:Visible(self.zombied)) and  ((chce:GetForward():Dot((self.zombied:GetPos() -chce:GetPos()):GetNormalized()) >= math.cos(math.rad(self.SAngle2))) or (v:GetForward():Dot((self.zombied:GetPos() -v:GetPos()):GetNormalized()) >= math.cos(math.rad(self.SAngle2)))) then
self.zombied:Remove()
end
end
end
end
if self.MaxZombie >= max then
self.Decrease = true
self.CREA2 = false
end 
if self.NUM >= 250  then
self.CREA3 = false
self.cout2 = true
end
if self.cout2 == true && self.cout3 == true then
self.cout3 = false
self.NUM = (self.NUM - 6)
timer.Simple(math.random(1,3),function() if IsValid(self) then 
self.cout3 = true end end)
end

if self.NUM <= 0 then
self.cout2 = false
self.CREA3 = true

end

if self.Decrease == true && self.cout == true then
self.MaxZombie = (self.MaxZombie - 3)
self.cout = false
timer.Simple(math.random(1,3),function() if IsValid(self) then 
self.cout = true end end)
end
if self.MaxZombie <= 0 then
self.CREA2 = true
self.Decrease = false
end

local max = math.max(60)
if self.CREAd == true && self.CREA2d == true then
for k,v in pairs(player.GetAll()) do  
if v:IsValid() && v != self && v:IsPlayer() && v:GetClass() != self:GetClass() && self.CREAd == true && self.CREA2d == true && self.CREA3 == true && v:Health() > 0 &&  self.MaxZombie < max  then 
local at = player.GetAll()
local chce = at[math.random(1,#at)]
local pos3 = chce:LocalToWorld(Vector(math.random(-1800,1800),math.random(-1800,1800),17))
self.CREAd = false	
self.zombied1 = ents.Create(VJ_PICK(self.LNR2))
self.zombied1:SetPos(pos3) 
self.zombied1:SetAngles(self:GetAngles()) 
self.zombied1:Spawn()
self.zombied1.IdleAlwaysWander = false 
self.zombied1.DisableWandering = true
self.zombied1:SetNoDraw(false)
self.zombied1.HasAlertSounds = false
 
self.zombied1:Activate() 
self.zombied1:SetOwner(self) 
self.zombied1.HasSounds = false
self.zombied1.FindEnemy_UseSphere = true 
self.zombied1.FindEnemy_CanSeeThroughWalls = true
self.zombied1.SightDistance = 9900000
self:DeleteOnRemove(self.zombied1)
timer.Simple(0.55,function() if IsValid(self.zombied1) then 
self.zombied1.HasSounds = true
self.zombied1.IdleAlwaysWander = true
self.zombied1.DisableWandering = false
self.zombied1:SetNoDraw(false)
self.zombied1.HasAlertSounds = true end end)	
timer.Simple(self.time2,function() if IsValid(self) then 
self.CREAd = true end end)
local tr1 = {
						start = self.zombied1:GetPos(),
						endpos = self.zombied1:GetPos() + self.zombied1:GetForward()*30 + self.zombied1:GetUp()*30,
						mins = self.zombied1:OBBMins(),
						maxs = self.zombied1:OBBMaxs(),
						filter = {self.zombied1}
					}
					local tr = util.TraceHull(tr1)
local tr12 = {
						start = self.zombied1:GetPos(),
						endpos = self.zombied1:GetPos() + self.zombied1:GetForward()*-30 + self.zombied1:GetUp()*30,
						mins = self.zombied1:OBBMins(),
						maxs = self.zombied1:OBBMaxs(),
						filter = {self.zombied1}
					}
					local tr2 = util.TraceHull(tr12)		

		local tr13 = {
						start = self.zombied1:GetPos(),
						endpos = self.zombied1:GetPos() + self.zombied1:GetRight()*30 + self.zombied1:GetUp()*30,
						mins = self.zombied1:OBBMins(),
						maxs = self.zombied1:OBBMaxs(),
						filter = {self.zombied1}
					}
					local tr3 = util.TraceHull(tr13)	

		local tr14 = {
						start = self.zombied1:GetPos(),
						endpos = self.zombied1:GetPos() + self.zombied1:GetRight()*-30 + self.zombied1:GetUp()*30,
						mins = self.zombied1:OBBMins(),
						maxs = self.zombied1:OBBMaxs(),
						filter = {self.zombied1}
					}
					local tr4 = util.TraceHull(tr14)

			local tr15 = {
						start = self.zombied1:GetPos(),
						endpos = self.zombied1:GetPos() + self.zombied1:GetUp()*80,
						mins = self.zombied1:OBBMins(),
						maxs = self.zombied1:OBBMaxs(),
						filter = {self.zombied1}
					}
					local tr5 = util.TraceHull(tr15)		
					
					
if tr.Hit && tr.HitWorld && tr2.HitWorld && tr3.HitWorld && tr4.HitWorld && tr5.HitWorld then

self.zombied1:Remove()

end
for k,n in ipairs(ents.GetAll()) do
if IsValid(self.zombied1) && n.IsVJBaseSNPC == true && n:GetClass() == self.zombied1:GetClass() && n != self && n != self.zombied1 && self.zombied1:GetPos():Distance(n:GetPos()) <= 90 && (!v:Visible(self.zombied1) or (!IsValid(seen.Entity))) and  ((chce:GetForward():Dot((self.zombied1:GetPos() -chce:GetPos()):GetNormalized()) >= math.cos(math.rad(self.SAngle2))) or (v:GetForward():Dot((self.zombied1:GetPos() -v:GetPos()):GetNormalized()) >= math.cos(math.rad(self.SAngle2)))) then
n:Remove()
end
end
if IsValid(self.zombied1) && self.zombied1:GetPos():Distance(v:GetPos()) <= 300 then
self.zombied1:Remove()
end
if self.zombied1:WaterLevel() == 3 && IsValid(self.zombied1) then
self.zombied1:Remove() 
end
if !self.zombied1:IsInWorld() && IsValid(self.zombied1) then
self.zombied1:Remove()
end 
timer.Simple(0.55,function() if !IsValid(self.zombied1) then 
self.time2 = 0.65
end end)

if IsValid(self.zombied1) then
timer.Simple(0.56,function() if IsValid(self.zombied1) then 
self.time2 = math.random(7,20)
self.MaxZombie = (self.MaxZombie + 1)
self.NUM = (self.NUM + 2)
end end)
end 

if IsValid(self.zombied1) then
timer.Simple(0.55,function() if IsValid(self.zombied1)  && !self.zombied1:IsOnGround() then 
self.zombied1:Remove()
end end)
end 

if IsValid(self.zombied1) then
timer.Simple(0.55,function() if IsValid(self.zombied1)  && !self.zombied1:IsMoving() then 
self.zombied1:Remove()
end end)
end  
local seen = util.TraceLine({start = self.zombied1:NearestPoint(self.zombied1:GetPos() + self.zombied1:OBBCenter()),endpos = v:EyePos()})
if IsValid(self.zombied1) && (IsValid(seen.Entity) == v:GetEyeTrace().Entity or v:Visible(self.zombied1)) and  ((chce:GetForward():Dot((self.zombied1:GetPos() -chce:GetPos()):GetNormalized()) >= math.cos(math.rad(self.SAngle2))) or (v:GetForward():Dot((self.zombied1:GetPos() -v:GetPos()):GetNormalized()) >= math.cos(math.rad(self.SAngle2)))) then
self.zombied1:Remove()
end
end
end
end
if self.MaxZombie >= max then
self.Decrease = true
self.CREA2d = false
end 
if self.NUM >= 250  then
self.CREA3 = false
self.cout2 = true
end
if self.cout2 == true && self.cout3 == true then
self.cout3 = false
self.NUM = (self.NUM - 4)
timer.Simple(math.random(1.3,3),function() if IsValid(self) then 
self.cout3 = true end end)
end

if self.NUM <= 0 then
self.cout2 = false
self.CREA3 = true

end

if self.Decrease == true && self.cout == true then
self.MaxZombie = (self.MaxZombie - 3)
self.cout = false
timer.Simple(math.random(1,3),function() if IsValid(self) then 
self.cout = true end end)
end
if self.MaxZombie <= 0 then
self.CREA2d = true
self.Decrease = false
end

local max = math.max(60)
if self.CREAda == true && self.CREA2da == true then
for k,v in pairs(player.GetAll()) do  
if v:IsValid() && v != self && v:IsPlayer() && v:GetClass() != self:GetClass() && self.CREAda == true && self.CREA2da == true && self.CREA3 == true && v:Health() > 0 &&  self.MaxZombie < max  then 
local at = player.GetAll()
local chce = at[math.random(1,#at)]
local pos4 = chce:LocalToWorld(Vector(math.random(-1800,1800),math.random(-1800,1800),17))
self.CREAda = false	
self.zombied1a = ents.Create(VJ_PICK(self.LNR3))
self.zombied1a:SetPos(pos4) 
self.zombied1a:SetAngles(self:GetAngles()) 
self.zombied1a:Spawn()
self.zombied1a.IdleAlwaysWander = false 
self.zombied1a.DisableWandering = true
self.zombied1a:SetNoDraw(false)
self.zombied1a.HasAlertSounds = false
 
self.zombied1a:Activate() 
self.zombied1a:SetOwner(self) 
self.zombied1a.HasSounds = false
self.zombied1a.FindEnemy_UseSphere = true 
self.zombied1a.FindEnemy_CanSeeThroughWalls = true
self.zombied1a.SightDistance = 9900000
self:DeleteOnRemove(self.zombied1a)
timer.Simple(0.55,function() if IsValid(self.zombied1a) then 
self.zombied1a.HasSounds = true
self.zombied1a.IdleAlwaysWander = true
self.zombied1a.DisableWandering = false
self.zombied1a:SetNoDraw(false)
self.zombied1a.HasAlertSounds = true end end)	
timer.Simple(self.time3,function() if IsValid(self) then 
self.CREAda = true end end)
local tr1 = {
						start = self.zombied1a:GetPos(),
						endpos = self.zombied1a:GetPos() + self.zombied1a:GetForward()*30 + self.zombied1a:GetUp()*30,
						mins = self.zombied1a:OBBMins(),
						maxs = self.zombied1a:OBBMaxs(),
						filter = {self.zombied1a}
					}
					local tr = util.TraceHull(tr1)
local tr12 = {
						start = self.zombied1a:GetPos(),
						endpos = self.zombied1a:GetPos() + self.zombied1a:GetForward()*-30 + self.zombied1a:GetUp()*30,
						mins = self.zombied1a:OBBMins(),
						maxs = self.zombied1a:OBBMaxs(),
						filter = {self.zombied1a}
					}
					local tr2 = util.TraceHull(tr12)		

		local tr13 = {
						start = self.zombied1a:GetPos(),
						endpos = self.zombied1a:GetPos() + self.zombied1a:GetRight()*30 + self.zombied1a:GetUp()*30,
						mins = self.zombied1a:OBBMins(),
						maxs = self.zombied1a:OBBMaxs(),
						filter = {self.zombied1a}
					}
					local tr3 = util.TraceHull(tr13)	

		local tr14 = {
						start = self.zombied1a:GetPos(),
						endpos = self.zombied1a:GetPos() + self.zombied1a:GetRight()*-30 + self.zombied1a:GetUp()*30,
						mins = self.zombied1a:OBBMins(),
						maxs = self.zombied1a:OBBMaxs(),
						filter = {self.zombied1a}
					}
					local tr4 = util.TraceHull(tr14)

			local tr15 = {
						start = self.zombied1a:GetPos(),
						endpos = self.zombied1a:GetPos() + self.zombied1a:GetUp()*80,
						mins = self.zombied1a:OBBMins(),
						maxs = self.zombied1a:OBBMaxs(),
						filter = {self.zombied1a}
					}
					local tr5 = util.TraceHull(tr15)		
					
					
if tr.Hit && tr.HitWorld && tr2.HitWorld && tr3.HitWorld && tr4.HitWorld && tr5.HitWorld then

self.zombied1a:Remove()

end
for k,n in ipairs(ents.GetAll()) do
if IsValid(self.zombied1a) && n.IsVJBaseSNPC == true && n:GetClass() == self.zombied1a:GetClass() && n != self && n != self.zombied1a && self.zombied1a:GetPos():Distance(n:GetPos()) <= 90 && (!v:Visible(self.zombied1a) or (!IsValid(seen.Entity))) and  ((chce:GetForward():Dot((self.zombied1a:GetPos() -chce:GetPos()):GetNormalized()) >= math.cos(math.rad(self.SAngle2))) or (v:GetForward():Dot((self.zombied1a:GetPos() -v:GetPos()):GetNormalized()) >= math.cos(math.rad(self.SAngle2)))) then
n:Remove()
end
end
if IsValid(self.zombied1a) && self.zombied1a:GetPos():Distance(v:GetPos()) <= 300 then
self.zombied1a:Remove()
end
if self.zombied1a:WaterLevel() == 3  && IsValid(self.zombied1a) then
self.zombied1a:Remove() 
end
if !self.zombied1a:IsInWorld() && IsValid(self.zombied1a) then
self.zombied1a:Remove()
end 

timer.Simple(0.55,function() if !IsValid(self.zombied1a) then 
self.time3 = 0.65
end end)

if IsValid(self.zombied1a) then
timer.Simple(0.56,function() if IsValid(self.zombied1a) then 
self.time3 = math.random(7,20)
self.MaxZombie = (self.MaxZombie + 1)
self.NUM = (self.NUM + 2)
end end)
end 

if IsValid(self.zombied1a) then
timer.Simple(0.55,function() if IsValid(self.zombied1a)  && !self.zombied1a:IsOnGround() then 
self.zombied1a:Remove()
end end)
end 

if IsValid(self.zombied1a) then
timer.Simple(0.55,function() if IsValid(self.zombied1a)  && !self.zombied1a:IsMoving() then 
self.zombied1a:Remove()
end end)
end  
local seen = util.TraceLine({start = self.zombied1a:NearestPoint(self.zombied1a:GetPos() + self.zombied1a:OBBCenter()),endpos = v:EyePos()})
if IsValid(self.zombied1a) && (IsValid(seen.Entity) == v:GetEyeTrace().Entity or v:Visible(self.zombied1a)) and  ((chce:GetForward():Dot((self.zombied1a:GetPos() -chce:GetPos()):GetNormalized()) >= math.cos(math.rad(self.SAngle2))) or (v:GetForward():Dot((self.zombied1a:GetPos() -v:GetPos()):GetNormalized()) >= math.cos(math.rad(self.SAngle2)))) then
self.zombied1a:Remove()
end
end
end
end
if self.MaxZombie >= max then
self.Decrease = true
self.CREA2da = false
end 
if self.NUM >= 250  then
self.CREA3 = false
self.cout2 = true
end
if self.cout2 == true && self.cout3 == true then
self.cout3 = false
self.NUM = (self.NUM - 4)
timer.Simple(math.random(1.3,3),function() if IsValid(self) then 
self.cout3 = true end end)
end

if self.NUM <= 0 then
self.cout2 = false
self.CREA3 = true

end

if self.Decrease == true && self.cout == true then
self.MaxZombie = (self.MaxZombie - 3)
self.cout = false
timer.Simple(math.random(1,3),function() if IsValid(self) then 
self.cout = true end end)
end
if self.MaxZombie <= 0 then
self.CREA2da = true
self.Decrease = false
end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2015 by DrVj, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/