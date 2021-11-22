if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Chrome" -- skin name
ATTACHMENT.Description = { -- skin description
	TFA.AttachmentColors["="], "chrome skin",
}
ATTACHMENT.Icon = "entities/tfa_att_1911_manhatten_chrome.png" -- icon
ATTACHMENT.ShortName = "CHRM" -- short name that displayed inside the icon

ATTACHMENT.WeaponTable = {
	MaterialTable = { -- materials that are present on both view- and worldmodel
		[4] = "models/weapons/ins2/duke_m1911_manhatten_skins/slide_chrome",
	},
	-- MaterialTable_V = {}, -- separate table for viewmodel materials, overrides main table
	-- MaterialTable_W = {}, -- separate table for worldmodel materials, overrides main table
	["WepSelectIcon_Override"] = "vgui/hud/tfa_ins2_m1911_manhatten_chrome"
}

local function resetMatCache(att, wep)
	wep:ClearMaterialCache()
end

ATTACHMENT.Attach = resetMatCache
ATTACHMENT.Detach = resetMatCache

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
