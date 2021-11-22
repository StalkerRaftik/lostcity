if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Golden Finish" -- skin name
ATTACHMENT.Description = { -- skin description
	TFA.AttachmentColors["="], "EDIT: Thanks for the gold, kind stranger!"
}
ATTACHMENT.Icon = "entities/tfa_ins2_vector_gold.png" -- icon
ATTACHMENT.ShortName = "GOLD" -- short name that displayed inside the icon

ATTACHMENT.WeaponTable = {
	Skin = 1
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
