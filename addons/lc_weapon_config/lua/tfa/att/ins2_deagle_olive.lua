if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "OD Green Finish"
ATTACHMENT.Description = {
	TFA.AttachmentColors["+"], "- We're 100% GREEN.",
	Color(255, 255, 255), "- Me too.",
	TFA.AttachmentColors["-"], "Does not affect the camo index",
}
ATTACHMENT.Icon = "entities/tfa_ins2_deagle_od.png"
ATTACHMENT.ShortName = "GREEN"

ATTACHMENT.WeaponTable = {
	["MaterialTable_V"] = {
		[1] = "models/weapons/tfa_ins2/deserteagle/skins/od/deagle",
		[2] = "models/weapons/tfa_ins2/deserteagle/skins/od/grip",
	},
	["MaterialTable_W"] = {
		[1] = "models/weapons/tfa_ins2/deserteagle/skins/od/deagle",
		[2] = "models/weapons/tfa_ins2/deserteagle/skins/od/grip",
	},
	["WepSelectIcon_Override"] = "vgui/hud/tfa_ins2_deagle_od"
}

local function resetMatCache(att, wep)
	wep.MaterialCached = false
end

ATTACHMENT.Attach = resetMatCache
ATTACHMENT.Detach = resetMatCache

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
