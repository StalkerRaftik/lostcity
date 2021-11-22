--  _______               __          _______  __                   __          _______  ______  ______        
-- |   |   |.---.-..----.|  |.-----. |     __||__|.--------..-----.|  |.-----. |    |  ||   __ \|      |.-----.
-- |       ||  _  ||  __| |_||__ --| |__     ||  ||        ||  _  ||  ||  -__| |       ||    __/|   ---||__ --|
-- |__|_|__||___._||____|    |_____| |_______||__||__|__|__||   __||__||_____| |__|____||___|   |______||_____|
--   
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////// Warning! Nothing to edit here, you can break the system //////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////

MCS.AddonList = {}

MCS.AddonList["CH FireSystem"] = {
	["path"] = "entities/npc_firetruck/init.lua",
	["function"] = nil,
	["function_sv"] = function(ply)
		if IsValid( ply ) and table.HasValue( CH_FireSystem.Config.AllowedTeams, team.GetName(ply:Team()) ) then
			net.Start( "FIRE_FiretruckMenu" )
			net.Send( ply )
		else
			DarkRP.notify(ply, 2, 5,  "Only firefighters can access this NPC!")
		end
	end,
	["enabled"] = false,
}

MCS.AddonList["CH TowTruck"] = {
	["path"] = "entities/npc_towtruck/init.lua",
	["function"] = nil,
	["function_sv"] = function(ply)
		if IsValid( ply ) and ply:Team() == TEAM_TOWER then
			net.Start("TOW_TowTruck_Menu", ply)
			net.Send( ply )
		else
			DarkRP.notify(ply, 1, 5,  "Only tow truck drivers can access this NPC!")
		end
	end,
	["enabled"] = false,
}

MCS.AddonList["CH ShopNPC"] = {
	["path"] = "entities/npc_shop_npc/init.lua",
	["function"] = function() NPC_ShopMenu() end,
	["function_sv"] = nil,
	["enabled"] = false,
}

MCS.AddonList["CH GovStation"] = {
	["path"] = "autorun/client/govstation_client.lua",
	["function"] = function() GovStation_Menu() end,
	["function_sv"] = nil,
	["enabled"] = false,
}

MCS.AddonList["SH Accessories"] = {
	["path"] = "accessory/sv_accessory.lua",
	["function"] = nil,
	["function_sv"] = function(ply) SH_ACC:Show(ply) end,
	["enabled"] = false,
}


local function AddonListCheck()

	for id, addon in pairs(MCS.AddonList) do
		if addon["path"] and file.Exists(addon["path"], "LUA") then
			addon["enabled"] = true
			print(id.." enabled!")
		end
	end

end	

timer.Simple(2, function() AddonListCheck() end)