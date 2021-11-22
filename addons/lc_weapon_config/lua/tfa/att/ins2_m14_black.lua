if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Black Tactical"
ATTACHMENT.Description = {
	TFA.AttachmentColors["+"], "75% more blacc",
	TFA.AttachmentColors["+"], "250% more tacc",
}
ATTACHMENT.Icon = "entities/weapon_mk14_black.png"
ATTACHMENT.ShortName = "BLACK"

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
