if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Heavy Barrel"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {TFA.AttachmentColors["="], "Heavy Barrel", TFA.AttachmentColors["+"], "20% More Damage", TFA.AttachmentColors["-"], "10% Higher Spread" }
ATTACHMENT.Icon = "entities/ins2_att_br_heavy.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "HBRRL"

ATTACHMENT.WeaponTable = {
	["VElements"] = {	
		["Heavy Barrel"] = {
			["active"] = true
		}
	},
	["Primary"] = {
		["Damage"] = function( wep, stat ) return stat * 1.2 end,
		["Spread"] = function( wep, stat ) return stat * 1.1 end
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
