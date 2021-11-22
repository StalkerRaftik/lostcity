if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Tritium Sights Color"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["+"], "Colorable sights" }
ATTACHMENT.Icon = "entities/fas2_tritium_color.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "CLR"

ATTACHMENT.WeaponTable = {
	["Bodygroups_V"] = {
		[2] = 2
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end