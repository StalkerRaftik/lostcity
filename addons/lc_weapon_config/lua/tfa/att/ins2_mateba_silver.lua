if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Chrome Finish"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["+"], "Chrome", "Shiny", TFA.AttachmentColors["-"], "good job you found a silver one" }
ATTACHMENT.Icon = "entities/tfa_ins2_mateba_silver.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "CHROME"

ATTACHMENT.WeaponTable = {
	["Skin"] = 1
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
