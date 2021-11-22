if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Range Finder"
ATTACHMENT.Description = {TFA.AttachmentColors["="], "Range Finder"}
ATTACHMENT.Icon = "entities/range_finder.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "RFD"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["Range Finder"] = {
			["active"] = true
		},
		["Range"] = {
			["active"] = true
		},
	},
	}
		
if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end