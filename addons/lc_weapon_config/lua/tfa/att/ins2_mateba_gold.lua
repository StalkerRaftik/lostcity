if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Gold Plating"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["+"], "Gold", "Shiny" }
ATTACHMENT.Icon = "entities/tfa_ins2_mateba_gold.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "GOLD"

ATTACHMENT.WeaponTable = {
	["Skin"] = 2
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
