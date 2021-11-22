if not CLIENT then return end
local Created = false

CreateConVar("zlm_cl_vfx_updateinterval", "0.1", {FCVAR_ARCHIVE})
CreateConVar("zlm_cl_vfx_updatedistance", "750", {FCVAR_ARCHIVE})
CreateConVar("zlm_cl_vfx_modelcount", "200", {FCVAR_ARCHIVE})
CreateConVar("zlm_cl_sfx_volume", "0.5", {FCVAR_ARCHIVE})

local function zlawnmower_settings(CPanel)
	Created = true
	CPanel:AddControl("Header", {
		Text = "Client Settings",
		Description = "Here you can change SFX and VFX Settings."
	})

	CPanel:AddControl("label", {
		Text = "__________________________________"
	})


	CPanel:AddControl("label", {
		Text = "The refresh rate for the Grass."
	})

	local GrassUpdateInterval = CPanel:NumSlider("Grass Update Interval", "zlm_cl_vfx_updateinterval", 0.1, 2, 2)

	GrassUpdateInterval.OnChange = function(panel, bVal)
		if (not Created) then
			RunConsoleCommand("zlm_cl_vfx_updateinterval", tostring(bVal))
		end
	end

	CPanel:AddControl("label", {
		Text = "__________________________________"
	})


	CPanel:AddControl("label", {
		Text = "This is the Distance for Rendering the Grass."
	})

	local GrassUpdateDistance = CPanel:NumSlider("Grass Render Distance", "zlm_cl_vfx_updatedistance", 500, 3000, 0)

	GrassUpdateDistance.OnChange = function(panel, bVal)
		if (not Created) then
			RunConsoleCommand("zlm_cl_vfx_updatedistance", tostring(bVal))
		end
	end

	CPanel:AddControl("label", {
		Text = "__________________________________"
	})


	CPanel:AddControl("label", {
		Text = "The amount of Grass Drawn."
	})

	local GrassCount = CPanel:NumSlider("Grass Model Count", "zlm_cl_vfx_modelcount", 15, 500, 0)

	GrassCount.OnChange = function(panel, bVal)
		if (not Created) then
			RunConsoleCommand("zlm_cl_vfx_modelcount", tostring(bVal))
		end
	end

	CPanel:AddControl("label", {
		Text = "__________________________________"
	})

	CPanel:AddControl("label", {
		Text = "The Volume of sound effects."
	})

	local SFXVolume = CPanel:NumSlider("Volume", "zlm_cl_sfx_volume", 0, 1, 2)

	SFXVolume.OnChange = function(panel, bVal)
		if (not Created) then
			RunConsoleCommand("zlm_cl_sfx_volume", tostring(bVal))
		end
	end

	timer.Simple(0.1, function()
		if (GrassUpdateInterval) then
			GrassUpdateInterval:SetValue(GetConVar("zlm_cl_vfx_updateinterval"):GetFloat())
		end

		if (GrassUpdateDistance) then
			GrassUpdateDistance:SetValue(GetConVar("zlm_cl_vfx_updatedistance"):GetFloat())
		end

		if (GrassCount) then
			GrassCount:SetValue(GetConVar("zlm_cl_vfx_modelcount"):GetInt())
		end

		if (SFXVolume) then
			SFXVolume:SetValue(GetConVar("zlm_cl_sfx_volume"):GetFloat())
		end

		Created = false
	end)
end

local function zlawnmower_admin_settings(CPanel)

	CPanel:AddControl("label", {
		Text = "Saves all the Lawnmower/Trailer Entities on the Map."
	})
	CPanel:Button("Save Lawnmower", "zlm_save_lawnmower")

	CPanel:AddControl("label", {
		Text = "Removes all the Lawnmower/Trailer Entities on the Map."
	})
	CPanel:Button("Remove Lawnmower", "zlm_remove_lawnmower")

	CPanel:AddControl("label", {
		Text = "__________________________________"
	})

	CPanel:AddControl("label", {
		Text = "Saves all the GrassPress Entities on the Map."
	})
	CPanel:Button("Save GrassPress", "zlm_save_grasspress")

	CPanel:AddControl("label", {
		Text = "Removes all the GrassPress Entities on the Map."
	})
	CPanel:Button("Remove GrassPress", "zlm_remove_grasspress")

	CPanel:AddControl("label", {
		Text = "__________________________________"
	})


	CPanel:AddControl("label", {
		Text = "Saves all the Buyer NPC´s on the Map."
	})
	CPanel:Button("Save GrassBuyer", "zlm_save_buyernpc")

	CPanel:AddControl("label", {
		Text = "Removes all the Buyer NPC´s on the Map."
	})
	CPanel:Button("Remove GrassBuyer", "zlm_remove_buyernpc")


	CPanel:AddControl("label", {
		Text = "__________________________________"
	})


	CPanel:AddControl("label", {
		Text = "Saves all the Grass Spots that are currently on the Map"
	})
	CPanel:Button("Save Grass Spots", "zlm_save_grassspots")

	CPanel:AddControl("label", {
		Text = "Removes all the Grass Spots that are currently on the Map"
	})
	CPanel:Button("Remove all Grass Spots", "zlm_remove_grassspots")



	CPanel:AddControl("label", {
		Text = "__________________________________"
	})


	CPanel:AddControl("label", {
		Text = "Saves all the Vehicle Spawns that are currently on the Map"
	})
	CPanel:Button("Save Vehicle Spawns", "zlm_save_vehiclespawn")

	CPanel:AddControl("label", {
		Text = "Removes all the Vehicle Spawns that are currently on the Map"
	})
	CPanel:Button("Remove all Vehicle Spawns", "zlm_remove_vehiclespawn")
end


hook.Add( "PopulateToolMenu", "PopulatezlmMenus", function()
	spawnmenu.AddToolMenuOption( "Options", "LawnMower", "zlm_Settings", "Client Settings", "", "", zlawnmower_settings )
	spawnmenu.AddToolMenuOption("Options", "LawnMower", "zlm_Admin_Settings", "Admin Settings", "", "", zlawnmower_admin_settings)
end )

hook.Add( "AddToolMenuCategories", "CreatezlmCategories", function()
	spawnmenu.AddToolCategory( "Options", "LawnMower", "LawnMower" );
end )
