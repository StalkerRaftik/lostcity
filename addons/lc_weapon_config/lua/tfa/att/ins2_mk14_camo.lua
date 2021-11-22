if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Digital Camo"
ATTACHMENT.Description = {
	TFA.AttachmentColors["="], "An adaptive digital camoflauge for use in forest-type areas",
	TFA.AttachmentColors["+"], "Includes green fiber optic sights for low-light aim assistance",
}
ATTACHMENT.Icon = "entities/weapon_mk14_camo.png"
ATTACHMENT.ShortName = "CAMO"

ATTACHMENT.WeaponTable = {
	["Skin"] = 1,
}

function ATTACHMENT:Attach(wep)
	wep:SetSkin(1)
end

function ATTACHMENT:Detach(wep)
	wep:SetSkin(0)
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
