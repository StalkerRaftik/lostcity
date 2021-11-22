if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Red Dot Sight"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {TFA.AttachmentColors["="], "Red Dot Sight"}
ATTACHMENT.Icon = "entities/ins2_si_rds.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "RDS"

ATTACHMENT.WeaponTable = {
	
	["VElements"] = {
	["Iron"] = {
		["active"] = false
	},	
	["Iron Dot"] = {
		["active"] = false
	},	
	["Dot"] = {
		["active"] = true
		},
	["Red Dot"] = {
		["active"] = true
		},
	["Rail"] = {
		["active"] = true
		}		
	},
	["IronSightsPos"] = function(wep, val) return wep.IronSightsPos_RDS or val, true end,
	["IronSightsAng"] = function(wep, val) return wep.IronSightsAng_RDS or val, true end,
	["IronSightTime"] = function(wep, val) return val * 1 end,
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end