if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Gold Finish"
ATTACHMENT.Description = {
	TFA.AttachmentColors["+"], "Reflective golden metallic finish", "Engravings (with no tactical advantages whatsoever)",
	TFA.AttachmentColors["="], "Better than silver"
}
ATTACHMENT.Icon = "entities/tfa_ins2_deagle_gold.png"
ATTACHMENT.ShortName = "GOLD"

ATTACHMENT.WeaponTable = {
	["MaterialTable_V"] = {
		[1] = "models/weapons/tfa_ins2/deserteagle/skins/gold/deagle",
		[2] = "models/weapons/tfa_ins2/deserteagle/skins/gold/grip",
	},
	["MaterialTable_W"] = {
		[1] = "models/weapons/tfa_ins2/deserteagle/skins/gold/deagle",
		[2] = "models/weapons/tfa_ins2/deserteagle/skins/gold/grip",
	},
	["WepSelectIcon_Override"] = "vgui/hud/tfa_ins2_deagle_gold"
}

local function resetMatCache(att, wep)
	wep.MaterialCached = false
end

ATTACHMENT.Attach = resetMatCache
ATTACHMENT.Detach = resetMatCache

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
