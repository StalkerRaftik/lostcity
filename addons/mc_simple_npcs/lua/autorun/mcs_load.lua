--   __  __                  _            _____   _                       _            _   _   _____     _____       
--  |  \/  |                ( )          / ____| (_)                     | |          | \ | | |  __ \   / ____|      
--  | \  / |   __ _    ___  |/   ___    | (___    _   _ __ ___    _ __   | |   ___    |  \| | | |__) | | |       ___ 
--  | |\/| |  / _` |  / __|     / __|    \___ \  | | | '_ ` _ \  | '_ \  | |  / _ \   | . ` | |  ___/  | |      / __|
--  | |  | | | (_| | | (__      \__ \    ____) | | | | | | | | | | |_) | | | |  __/   | |\  | | |      | |____  \__ \
--  |_|  |_|  \__,_|  \___|     |___/   |_____/  |_| |_| |_| |_| | .__/  |_|  \___|   |_| \_| |_|       \_____| |___/
--                                                               | |                                                 
--                                                               |_|       V 1.2.0                                   

MCS = {}
MCS.Spawns = {}
MCS.Config = {}
MCS.Themes = {}

if (SERVER) then
	include("mcs_npcs/sh_addonsup.lua")
	include("mcs_npcs/sh_config.lua")
	include("mcs_npcs/sh_npcspawn.lua")
	include("mcs_npcs/sv_init.lua")
	AddCSLuaFile("mcs_npcs/sh_addonsup.lua")
	AddCSLuaFile("mcs_npcs/sh_config.lua")
	AddCSLuaFile("mcs_npcs/sh_npcspawn.lua")
	AddCSLuaFile("mcs_npcs/cl_init.lua")
	AddCSLuaFile("mcs_npcs/cl_util.lua")
	AddCSLuaFile("mcs_npcs/cl_menu.lua")
else
	include("mcs_npcs/sh_addonsup.lua")
	include("mcs_npcs/sh_config.lua")
	include("mcs_npcs/sh_npcspawn.lua")
	include("mcs_npcs/cl_init.lua")
	include("mcs_npcs/cl_util.lua")
	include("mcs_npcs/cl_menu.lua")
end

local files, folders = file.Find("mcs_npcs/themes/*", "LUA")

for k,v in pairs(files) do
	if (SERVER) then
		print("[MCS NPCs] Adding theme "..k.." "..v)
		include("mcs_npcs/themes/" .. v)
		AddCSLuaFile("mcs_npcs/themes/" .. v)
	else
		include("mcs_npcs/themes/" .. v)
	end
end