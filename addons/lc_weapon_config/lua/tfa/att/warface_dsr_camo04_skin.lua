if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name        = "Snow Camo Skin" -- skin name
ATTACHMENT.ShortName   = "Snow"           -- short name that displayed inside the icon

ATTACHMENT.Icon        = "entities/warface_dsr_camo04_skin.png" 

ATTACHMENT.Description = {                -- skin description
	TFA.AttachmentColors["+"], "Ugly slut snow camo skin.",
--	TFA.AttachmentColors["="], "uses vgui/black for a texture",
}

ATTACHMENT.WeaponTable = {

	MaterialTable = { -- materials that are present on both view- and worldmodel
	    [1] = "models/weapons/v_models/dsr1/camo04/fx_shell_col",
	    [2] = "models/weapons/v_models/dsr1/camo04/sr17_camo04_b_diff",
	    [3] = "models/weapons/v_models/dsr1/camo04/sr17_camo04_a_diff",
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
