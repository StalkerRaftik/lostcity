if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Kobra Sight"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {TFA.AttachmentColors["="], "Kobra Sight"}
ATTACHMENT.Icon = "entities/ins2_si_kobra.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "Kobra"

ATTACHMENT.WeaponTable = {
	
	["VElements"] = {
	["Iron Dot"] = {
		["active"] = false
	},
	["Iron"] = {
		["active"] = false
	}, 	
	["Kobra Dot"] = {
		["active"] = true
		},
	["Kobra"] = {
		["active"] = true
		},
	["Rail"] = {
		["active"] = true
		}		
	},
	["IronSightsPos"] = function(wep, val) return wep.IronSightsPos_Kob or val, true end,
	["IronSightsAng"] = function(wep, val) return wep.IronSightsAng_Kob or val, true end,
	["IronSightTime"] = function(wep, val) return val * 1 end,
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end