if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Alternative Iron Sights"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["="], "Tacticool futuristic sights that makes it easier to look through the iron sights", TFA.AttachmentColors["-"], "5% higher zoom time" }
ATTACHMENT.Icon = "entities/ins2_att_fsi.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "ALT"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["alt_sights"] = {
			["active"] = true
		},
		["sights_folded"] = {
			["active"] = false
		}
		
	},
	["WElements"] = {
		["alt_sights"] = {
			["active"] = true
		},
		["sights_folded"] = {
			["active"] = true
		}
	},
	
	["IronSightsPos"] = function( wep, val ) return wep.IronSightsPos_Alt or val end,
	["IronSightsAng"] = function( wep, val ) return wep.IronSightsAng_Alt or val end,
	["IronSightTime"] = function( wep, val ) return val * 1.05 end
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
