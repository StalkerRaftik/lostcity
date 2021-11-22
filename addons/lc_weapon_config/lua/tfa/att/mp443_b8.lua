if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "B-8 mount"
ATTACHMENT.Description = {TFA.AttachmentColors["="], "B-8 rail mount is installed on MP-443 for use with additional attachments"}
ATTACHMENT.Icon = "entities/b8.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = ""

ATTACHMENT.WeaponTable = {

	["Bodygroups_V"] = {
		[1] = 1
	},
	["Bodygroups_W"] = {
		[16] = 1
	},
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end