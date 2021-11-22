if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Ammo Counter"
ATTACHMENT.Description = {TFA.AttachmentColors["="], "Ammo Counter"}
ATTACHMENT.Icon = "entities/ammo_counter.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "AC"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["Counter"] = {
			["active"] = true
		},
		["Ammo Counter"] = {
			["active"] = true
		},
	},
	}
		
if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end