local suffix = "fml_mw_hamr_camo"
local Replacements = {
	["ins2_si_c79"] = {
		["name"] = "HAMR Ghillied",
		["modelReplacement"] = {"models/weapons/tfa_ins2/upgrades/a_optic_elcan","models/weapons/upgrades/fml/a_optic_mw_hamr_camo"},
		["icon"] = "entities/mw_hamr_meme.png",
		["element"] = "scope_c79"
	},
}

local HSR = function() return nil end

if TFA.INS2 then
	if TFA.INS2.AddHoloSightType then
		local good = render.SupportsPixelShaders_1_4() and render.SupportsPixelShaders_2_0() and render.SupportsVertexShaders_2_0()

		TFA.INS2.AddHoloSightType("sight_rds_" .. suffix, "models/weapons/tfa_ins2/fml_hamr/elcan_reticule", good and 5 or 0, good and .05 or .025, "A_RenderReticle")
		-- TFA.INS2.AddHoloSightType("sight_rds_" .. suffix, "models/weapons/tfa_ins2/optics/aimpoint_reticule_holo", good and 5 or 0, good and .05 or .025, "A_RenderReticle")
	end

	if TFA.INS2.GetHoloSightReticle then
		HSR = function(sighttype, rel)
			local sightdata = TFA.INS2.GetHoloSightReticle(sighttype .. "_" .. suffix, rel) or TFA.INS2.GetHoloSightReticle(sighttype, rel)

			if sightdata then
				local data = table.Copy(sightdata)
				data.rel = rel or sighttype
				data.frompatch = true
				return data
			end

			return nil
		end
	end
end

local function PatchAttachment(wep,attTable,attName,attIndex)
	local r = Replacements[attName]

	if not table.HasValue(attTable, attName .. "_" .. suffix) then
		table.insert( attTable, attIndex, attName .. "_" .. suffix)
	end

	for k,v in pairs(wep.VElements) do
		if string.find(v.model or "",r.modelReplacement[1]) then
			local t = table.Copy(v)
			t.model = string.Replace(t.model, r.modelReplacement[1], r.modelReplacement[2])
			wep.VElements[k .. "_" .. suffix] = t
		end
	end

	if wep.VElements[r.element .. "_lens"] then
		local reticule = r.element .. "_" .. suffix .. "_lens"
		wep.VElements[reticule] = HSR(r.element,r.element .. "_" .. suffix) or nil
	end
end

local function PatchWeapon(wep)
	for k,v in pairs(wep.Attachments or {}) do
		local selN

		if v.sel then
			if isnumber(v.sel) and v.sel >= 0 then
				selN = v.atts[v.sel]
			elseif isstring(v.sel) then
				selN = v.sel
			end
		end

		for l,b in pairs(v.atts or {}) do
			if Replacements[b] then
				PatchAttachment(wep,v.atts,b,l)
			end
		end

		if selN then
			for n,m in pairs(v.atts) do
				if m == selN then
					v.sel = n
				end
			end
		end
	end
end

hook.Add("TFAAttachmentsLoaded", "att_patch_" .. suffix, function()
	for k,v in pairs(Replacements) do
		if TFA.Attachments.Atts[k] then
			local t = table.Copy(TFA.Attachments.Atts[k])
			t.ID = t.ID .. "_" .. suffix
			t.Name = v.name or ( t.Name .. " " .. suffix)
			t.Icon = v.icon or t.Icon

			if t.WeaponTable then
				if t.WeaponTable.VElements then
					local vEl = t.WeaponTable.VElements
					if vEl[v.element] then
						vEl[v.element .. "_" .. suffix] = table.Copy( vEl[v.element] )
						vEl[v.element .. "_" .. suffix .. "_lens"] = { ["active"] = true }
						vEl[v.element] = nil
						vEl[v.element .. "_lens"] = nil
					end

					if t.WeaponTable.INS2_SightVElement then
						t.WeaponTable.INS2_SightVElement = v.element .. "_" .. suffix
					end
				end

				if t.WeaponTable.WElements then
					local wEl = t.WeaponTable.WElements
					if wEl[v.element] then
						wEl[v.element .. "_" .. suffix] = table.Copy( wEl[v.element] )
						wEl[v.element] = nil
					end
				end
			end

			TFARegisterAttachment(t)
		end
	end
end)

hook.Add("TFA_PreInitAttachments", "att_patch_weapon_" .. suffix, function(wep)
	PatchWeapon(wep)
end)