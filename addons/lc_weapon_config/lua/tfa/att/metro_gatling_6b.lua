if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "6 Barrel"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {TFA.AttachmentColors["="], "6 Barrel", TFA.AttachmentColors["+"], "Higher Fire Rate", TFA.AttachmentColors["-"], "10% Higher Spread" }
ATTACHMENT.Icon = "entities/ins2_att_br_heavy.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "HBRRL"

ATTACHMENT.WeaponTable = {
	["VElements"] = {	
		["Barrle+"] = {
			["active"] = true
		},
		["Barrle"] = {
			["active"] = false
		}		
	},
	["Primary"] = {
		["RPM"] = function( wep, stat) return wep.Primary.RPM_6B or stat end,	
		["Spread"] = function( wep, stat ) return stat * 1.25 end
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
