if CLIENT then
	CreateClientConVar("cl_tfa_csgo_arms_enabled", 0, true, false)
	local cv_armnum = CreateClientConVar("cl_tfa_csgo_arms_id", 0, true, false)
	CreateClientConVar("cl_tfa_csgo_reticule_r", 0, true, false)
	CreateClientConVar("cl_tfa_csgo_reticule_g", 255, true, false)
	CreateClientConVar("cl_tfa_csgo_reticule_b", 0, true, false)
	CreateClientConVar("cl_tfa_csgo_reticule_a", 192, true, false)

	language.Add("csgo_old.CT.Default", "CS:GO Legacy CT - Default ")
	language.Add("csgo_old.CT.FBI", "CS:GO Legacy CT - FBI ")
	language.Add("csgo_old.CT.GIGN", "CS:GO Legacy CT - GIGN ")
	language.Add("csgo_old.CT.GSG9", "CS:GO Legacy CT - GSG9 ")
	language.Add("csgo_old.CT.IDF", "CS:GO Legacy CT - IDF ")
	language.Add("csgo_old.CT.SAS", "CS:GO Legacy CT - SAS ")
	language.Add("csgo_old.CT.ST6", "CS:GO Legacy CT - ST6 ")
	language.Add("csgo_old.CT.SWAT", "CS:GO Legacy CT - SWAT ")
	language.Add("csgo_old.T.Default", "CS:GO Legacy T - Default ")
	language.Add("csgo_old.T.Anarchist", "CS:GO Legacy T - Anarchist ")
	language.Add("csgo_old.T.Balkan", "CS:GO Legacy T - Balkan ")
	language.Add("csgo_old.T.Leet", "CS:GO Legacy T - Leet ")
	language.Add("csgo_old.T.Phoenix", "CS:GO Legacy T - Phoenix ")
	language.Add("csgo_old.T.Pirate", "CS:GO Legacy T - Pirate ")
	language.Add("csgo_old.T.Professional", "CS:GO Legacy T - Professional ")
	language.Add("csgo_old.T.Separatist", "CS:GO Legacy T - Separatist ")
	language.Add("csgo.CT.Default", "CS:GO CT - Default ")
	language.Add("csgo.CT.FBI", "CS:GO CT - FBI ")
	language.Add("csgo.CT.GIGN", "CS:GO CT - GIGN ")
	language.Add("csgo.CT.GSG9", "CS:GO CT - GSG9 ")
	language.Add("csgo.CT.IDF", "CS:GO CT - IDF ")
	language.Add("csgo.CT.SAS", "CS:GO CT - SAS ")
	language.Add("csgo.CT.ST6", "CS:GO CT - ST6 ")
	language.Add("csgo.CT.SWAT", "CS:GO CT - SWAT ")
	language.Add("csgo.T.Default", "CS:GO T - Default ")
	language.Add("csgo.T.Anarchist", "CS:GO T - Anarchist ")
	language.Add("csgo.T.Balkan", "CS:GO T - Balkan ")
	language.Add("csgo.T.Leet", "CS:GO T - Leet ")
	language.Add("csgo.T.Phoenix", "CS:GO T - Phoenix ")
	language.Add("csgo.T.Pirate", "CS:GO T - Pirate ")
	language.Add("csgo.T.Professional", "CS:GO T - Professional ")
	language.Add("csgo.T.Separatist", "CS:GO T - Separatist ")
	language.Add("css.defaulthands", "CS:S T - Default Hands")

	local function tfaOptionClientGO(panel)
		--Here are whatever default categories you want.
		local tfaOptionCL = {
			Options = {},
			CVars = {},
			Label = "#Presets",
			MenuButton = "1",
			Folder = "TFA SWEP Settings Client"
		}

		tfaOptionCL.Options["#Default"] = {
			cl_tfa_csgo_stattrack = 1,
			cl_tfa_csgo_nametag = 1,
			cl_tfa_csgo_magdrop = 1,
			cl_tfa_3dscope = 1,
			cl_tfa_csgo_arms_enabled = 0,
			cl_tfa_csgo_arms_id = 0
		}

		panel:AddControl("Color", {
			Label = "Scope Reticule Color",
			Red = "cl_tfa_csgo_reticule_r",
			Green = "cl_tfa_csgo_reticule_g",
			Blue = "cl_tfa_csgo_reticule_b",
			Alpha = "cl_tfa_csgo_reticule_a",
			ShowHSV = 1,
			ShowRGB = 1,
			Multiplier = 255
		})

		panel:AddControl("ComboBox", tfaOptionCL)

		panel:AddControl("CheckBox", {
			Label = "3D Scopes (Re-Draw Gun After Changing)",
			Command = "cl_tfa_3dscope"
		})

		panel:AddControl("CheckBox", {
			Label = "Show Stattrack",
			Command = "cl_tfa_csgo_stattrack"
		})

		panel:AddControl("CheckBox", {
			Label = "Show NameTag",
			Command = "cl_tfa_csgo_nametag"
		})

		panel:AddControl("CheckBox", {
			Label = "Drop magazine on reload",
			Command = "cl_tfa_csgo_magdrop"
		})

		local b = vgui.Create("DButton")
		b:SizeToContents()

		b.DoClick = function()
			local f = file.Find("tfa_csgo/tfa_csgo_*_kills.txt", "DATA", "nameasc")

			if f then
				for k, v in pairs(f) do
					file.Delete("tfa_csgo/" .. v)
				end
			end

			local weps = LocalPlayer():GetWeapons()

			if weps then
				for k, v in pairs(weps) do
					v.Kills = 0
				end
			end
		end

		b:SetText("Reset Stattrack")
		panel:AddItem(b)
		local b2 = vgui.Create("DButton")
		b2:SizeToContents()

		b2.DoClick = function()
			local f = file.Find("tfa_csgo/tfa_csgo_*.txt", "DATA", "nameasc")

			if f then
				for k, v in pairs(f) do
					file.Delete("tfa_csgo/" .. v)
				end
			end

			local weps = LocalPlayer():GetWeapons()

			if weps then
				for k, v in pairs(weps) do
					v.Skin = ""
					v:SetNWString("skin", "")

					if v.UpdateSkin then
						v:UpdateSkin()
					end

					v.MaterialTable = {}
					v.MaterialCache = nil
					v.MaterialCached = nil
					v.MaterialsCache = nil
					v.MaterialsCached = nil
				end
			end
		end

		b2:SetText("Reset Skin Selection")
		panel:AddItem(b2)

		local b3 = vgui.Create("DButton")
		b3:SizeToContents()

		b3.DoClick = function()
			if TFA.CSGO and TFA.CSGO.ResetNameTags then TFA.CSGO.ResetNameTags() end -- make sure that gmod wouldnt went full retard on this
		end

		b3:SetText("Reset Nametags")
		panel:AddItem(b3)

		panel:AddControl("CheckBox", {
			Label = "Use Custom Arms",
			Command = "cl_tfa_csgo_arms_enabled"
		})

		--panel:AddControl("ComboBox", tfaHandsCL)
		local tfaHandsCL = {
			[1] = "#csgo.CT.Default",
			[2] = "#csgo.CT.FBI",
			[3] = "#csgo.CT.GIGN",
			[4] = "#csgo.CT.GSG9",
			[5] = "#csgo.CT.IDF",
			[6] = "#csgo.CT.SAS",
			[7] = "#csgo.CT.ST6",
			[8] = "#csgo.CT.SWAT",
			[9] = "#csgo.T.Default",
			[10] = "#csgo.T.Anarchist",
			[11] = "#csgo.T.Balkan",
			[12] = "#csgo.T.Leet",
			[13] = "#csgo.T.Phoenix",
			[14] = "#csgo.T.Pirate",
			[15] = "#csgo.T.Professional",
			[16] = "#csgo.T.Separatist",
			[17] = "#csgo_old.CT.Default",
			[18] = "#csgo_old.CT.FBI",
			[19] = "#csgo_old.CT.GIGN",
			[20] = "#csgo_old.CT.GSG9",
			[21] = "#csgo_old.CT.IDF",
			[22] = "#csgo_old.CT.SAS",
			[23] = "#csgo_old.CT.ST6",
			[24] = "#csgo_old.CT.SWAT",
			[25] = "#csgo_old.T.Default",
			[26] = "#csgo_old.T.Anarchist",
			[27] = "#csgo_old.T.Balkan",
			[28] = "#csgo_old.T.Leet",
			[29] = "#csgo_old.T.Phoenix",
			[30] = "#csgo_old.T.Pirate",
			[31] = "#csgo_old.T.Professional",
			[32] = "#csgo_old.T.Separatist",
			[33] = "#css.defaulthands"
		}

		local cb = vgui.Create("DComboBox", panel)
		cb:Dock(TOP)
		local sx = panel:GetSize()
		cb:SetSize(sx, 24)
		cb:SetValue(tfaHandsCL[cv_armnum:GetInt() + 1] or "Hands")

		for k, v in ipairs(tfaHandsCL) do
			cb:AddChoice(v, k)
		end

		function cb:OnSelect(index, value, data)
			local ply = LocalPlayer()

			if IsValid(ply) then
				ply:ConCommand("cl_tfa_csgo_arms_id " .. index - 1)
			end
		end

		panel:AddControl("Label", {
			Text = "By TheForgottenArchitect"
		})
	end

	local function tfaCSGOAddOption()
		spawnmenu.AddToolMenuOption("Options", "TFA SWEP Base Settings", "tfaOptionCSGO_Cl", "CSGO Clientside", "", "", tfaOptionClientGO)
	end

	hook.Add("PopulateToolMenu", "tfaCSGOAddOption", tfaCSGOAddOption)
end