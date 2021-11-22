if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Black Finish"
ATTACHMENT.Description = {
	Color(80, 160, 153), "- We're 100% BLACK.",
	Color(255, 255, 255), "- Me too."
}
ATTACHMENT.Icon = "entities/tfa_ins2_deagle_black.png"
ATTACHMENT.ShortName = "BLACK"

ATTACHMENT.WeaponTable = {
	["MaterialTable_V"] = {
		[1] = "models/weapons/tfa_ins2/deserteagle/skins/black/deagle",
		[2] = "models/weapons/tfa_ins2/deserteagle/skins/black/grip",
	},
	["MaterialTable_W"] = {
		[1] = "models/weapons/tfa_ins2/deserteagle/skins/black/deagle",
		[2] = "models/weapons/tfa_ins2/deserteagle/skins/black/grip",
	},
	["WepSelectIcon_Override"] = "vgui/hud/tfa_ins2_deagle_black"
}

local function resetMatCache(att, wep)
	wep.MaterialCached = false
end

ATTACHMENT.Attach = resetMatCache
ATTACHMENT.Detach = resetMatCache

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
