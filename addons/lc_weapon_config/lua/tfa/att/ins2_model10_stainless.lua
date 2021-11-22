if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Stainless Steel"
ATTACHMENT.Description = {TFA.AttachmentColors["+"], "Includes some small shader improvements"}
ATTACHMENT.Icon = "entities/tfa_ins2_swmodel10stainless.png"
ATTACHMENT.ShortName = "Steel"

ATTACHMENT.WeaponTable = {
	["Skin"] = 2,
}

function ATTACHMENT:Attach(wep)
	wep:SetSkin(2)
end

function ATTACHMENT:Detach(wep)
	wep:SetSkin(0)
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
