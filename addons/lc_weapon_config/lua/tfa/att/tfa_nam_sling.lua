if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Sling"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["+"], "+ 5 % Draw Speed" }
ATTACHMENT.Icon = "entities/tfa_sling.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "Sling"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["sling"] = {
			["active"] = true
		}
	},
	["WElements"] = {
		["sling"] = {
			["active"] = true
		}
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
