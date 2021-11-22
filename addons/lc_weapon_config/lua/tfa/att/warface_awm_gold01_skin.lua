if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name        = "Gold Skin"      -- skin name
ATTACHMENT.ShortName   = "Gold"           -- short name that displayed inside the icon

ATTACHMENT.Icon        = "entities/warface_awm_gold01_skin.png" 

ATTACHMENT.Description = {             
	TFA.AttachmentColors["+"], "Golden Skin.",
--	TFA.AttachmentColors["="], "uses vgui/black for a texture",
}

ATTACHMENT.WeaponTable = {

	MaterialTable = { -- materials that are present on both view- and worldmodel
	    [1] = "models/weapons/v_models/awm/gold01/sr14_a_gold01_diff",
	    [2] = "models/weapons/v_models/awm/gold01/sr14_b_gold01_diff",
        [3] = "models/weapons/v_models/awm/gold01/sr14_b_gold01_diff_m",
        [5] = "models/weapons/v_models/awm/gold01/sr14_a_gold01_diff_m",
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