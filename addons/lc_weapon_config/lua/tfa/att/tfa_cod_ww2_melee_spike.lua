if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Spike"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {TFA.AttachmentColors["="], "Spike"}
ATTACHMENT.Icon = "entities/blank.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "SPK"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
			["Spike"] = {
			["active"] = true
		}
	},
	["WElements"] = {
			["Spike"] = {
			["active"] = true
		}
	},	
	["Primary"] = {
                ["Damage"] = function( wep, stat ) return stat * 1.25 end,

        },
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end