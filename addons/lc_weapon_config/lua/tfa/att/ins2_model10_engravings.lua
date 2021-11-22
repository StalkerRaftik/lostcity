if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Engraved Gold"
ATTACHMENT.Description = {
TFA.AttachmentColors["+"], "Engravings... give you 200% increased tactical advantage",
TFA.AttachmentColors["="], "Wait, what?",}
ATTACHMENT.Icon = "entities/tfa_ins2_swmodel10engrave.png"
ATTACHMENT.ShortName = "ENGRV"

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
