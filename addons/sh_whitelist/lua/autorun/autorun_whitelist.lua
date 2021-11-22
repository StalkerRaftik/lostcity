SH_WHITELIST = {}

include("whitelist/lib_easynet.lua")
include("whitelist/lib_panelhook.lua")
include("whitelist/sh_whitelist.lua")
include("whitelist/sh_networking.lua")
include("whitelist_config.lua")
include("whitelist_factions.lua")

SH_WHITELIST.Language = include("whitelist/language/" .. (SH_WHITELIST.LanguageName or "english") .. ".lua")

if (SERVER) then
	AddCSLuaFile("whitelist_config.lua")
	AddCSLuaFile("whitelist_factions.lua")
	AddCSLuaFile("whitelist/language/" .. (SH_WHITELIST.LanguageName or "english") .. ".lua")
	AddCSLuaFile("whitelist/lib_easynet.lua")
	AddCSLuaFile("whitelist/lib_loungeui.lua")
	AddCSLuaFile("whitelist/lib_panelhook.lua")
	AddCSLuaFile("whitelist/sh_whitelist.lua")
	AddCSLuaFile("whitelist/sh_networking.lua")
	AddCSLuaFile("whitelist/cl_context.lua")
	AddCSLuaFile("whitelist/cl_menu.lua")
	AddCSLuaFile("whitelist/cl_factions.lua")

	include("whitelist_database.lua")
	include("whitelist/lib_database.lua")
	include("whitelist/sv_whitelist.lua")
	include("whitelist/sv_factions.lua")
else
	include("whitelist/lib_loungeui.lua")
	include("whitelist/cl_context.lua")
	include("whitelist/cl_menu.lua")
	include("whitelist/cl_factions.lua")
end

if (SH_WHITELIST.UseLibGModStore) then
	if (SERVER) then
		AddCSLuaFile("whitelist/libgmodstore.lua")
	end
	include("whitelist/libgmodstore.lua")

	local SHORT_SCRIPT_NAME = "SH Whitelist"
	local SCRIPT_ID = 4904
	local SCRIPT_VERSION = "1.1.3"
	local LICENSEE = "76561198059738127"
	hook.Add("libgmodstore_init",SHORT_SCRIPT_NAME .. "_libgmodstore",function()
		libgmodstore:InitScript(SCRIPT_ID,SHORT_SCRIPT_NAME,{
			version = SCRIPT_VERSION,
			licensee = LICENSEE
		})
	end)
end