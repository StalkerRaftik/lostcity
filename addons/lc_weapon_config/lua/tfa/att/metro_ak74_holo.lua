if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Holo Sight"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {TFA.AttachmentColors["="], "Holo Sight"}
ATTACHMENT.Icon = "entities/ins2_si_eotech.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "Holo"

ATTACHMENT.WeaponTable = {
	
	["VElements"] = {
	["Iron"] = {
		["active"] = false
	},	
	["Holo Dot"] = {
		["active"] = true
		},
	["Holo"] = {
		["active"] = true
		},
	["Rail"] = {
		["active"] = true
		}		
	},
	["IronSightsPos"] = function(wep, val) return wep.IronSightsPos_Holo or val, true end,
	["IronSightsAng"] = function(wep, val) return wep.IronSightsAng_Holo or val, true end,
	["IronSightTime"] = function(wep, val) return val * 1 end,
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end