if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name        = "Gold Skin"      -- skin name
ATTACHMENT.ShortName   = "Gold"           -- short name that displayed inside the icon

ATTACHMENT.Icon        = "entities/warface_mcmillan_cs5_gold_skin.png" 

ATTACHMENT.Description = {                -- skin description
	TFA.AttachmentColors["+"], "Golden Skin.",
--	TFA.AttachmentColors["="], "uses vgui/black for a texture",
}

ATTACHMENT.WeaponTable = {

	MaterialTable = { -- materials that are present on both view- and worldmodel
	    [1] = "models/weapons/v_models/cs5/gold01/sr09_a_diff_gold_m",
	    [2] = "models/weapons/v_models/cs5/gold01/sr09_b_diff_gold_m",
	    [3] = "models/weapons/v_models/cs5/gold01/cs5_gold01",
	    [5] = "models/weapons/v_models/cs5/gold01/sr09_b_diff_gold",
	    [6] = "models/weapons/v_models/cs5/gold01/sr09_a_diff_gold",
	},
	
	-- MaterialTable_V = {}, -- separate table for viewmodel materials, overrides main table
	-- MaterialTable_W = {}, -- separate table for worldmodel materials, overrides main table
}

local function resetMatCache(att, wep)
	wep.MaterialCached = false
end

ATTACHMENT.Attach = resetMatCache
ATTACHMENT.Detach = resetMatCache

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end