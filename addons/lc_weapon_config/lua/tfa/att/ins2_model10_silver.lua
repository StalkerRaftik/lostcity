if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Polished Silver"
ATTACHMENT.Description = {
	TFA.AttachmentColors["+"], "Includes green fiber optic sights for low-light aim assistance",
}
ATTACHMENT.Icon = "entities/tfa_ins2_swmodel10silver.png"
ATTACHMENT.ShortName = "SILV"

ATTACHMENT.WeaponTable = {
	["Skin"] = 3,
}

function ATTACHMENT:Attach(wep)
	wep:SetSkin(3)
end

function ATTACHMENT:Detach(wep)
	wep:SetSkin(0)
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
