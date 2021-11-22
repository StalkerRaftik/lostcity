
if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Side Scope"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["+"], "E+Click to use Side Scope" }
ATTACHMENT.Icon = "entities/ins2_att_gp25.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "GL"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["Side Scope"] = {
			["active"] = true
		},
		["Side Scope Dot"] = {
			["active"] = true
		}		
	},
	["Primary"] = {
	["IronSightsPos"] = function(wep, val) return wep.IronSightsPos_FLIP or val, true end,
	["IronSightsAng"] = function(wep, val) return wep.IronSightsAng_FLIP or val, true end,
	["IronSightsMoveSpeed"] = function(wep,stat) return stat * 0.8 end,
		}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end