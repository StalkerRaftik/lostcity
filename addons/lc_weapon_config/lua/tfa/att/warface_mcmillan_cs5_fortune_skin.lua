if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name        = "Lake Bird Skin" -- skin name
ATTACHMENT.ShortName   = "Fortune"        -- short name that displayed inside the icon

ATTACHMENT.Icon        = "entities/warface_mcmillan_cs5_fortune_skin.png" 

ATTACHMENT.Description = {                -- skin description
	TFA.AttachmentColors["+"], "Gives luck to your self.",
--	TFA.AttachmentColors["="], "uses vgui/black for a texture",
}

ATTACHMENT.WeaponTable = {

	MaterialTable = { -- materials that are present on both view- and worldmodel
	    [1] = "models/weapons/v_models/cs5/viet01/sr09_a_fortune_m",
	    [2] = "models/weapons/v_models/cs5/viet01/sr09_b_fortune_m",
	    [3] = "models/weapons/v_models/cs5/gold01/cs5_gold01",
	    [5] = "models/weapons/v_models/cs5/viet01/sr09_b_fortune",
	    [6] = "models/weapons/v_models/cs5/viet01/sr09_a_fortune",
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