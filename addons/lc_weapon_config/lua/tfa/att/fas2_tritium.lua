if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Tritium Sights"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["+"], "Brighter sights" }
ATTACHMENT.Icon = "entities/fas2_tritium.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "TRTM"

ATTACHMENT.WeaponTable = {
	["Bodygroups_V"] = {
		[2] = 1
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end