if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Holo Sight"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {TFA.AttachmentColors["="], "Holo"}
ATTACHMENT.Icon = "entities/r6_holo.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "ACOG"

ATTACHMENT.WeaponTable = {
	
	["VElements"] = {
	["Red dot"] = {
		["active"] = false
	},	
	["Dot"] = {
		["active"] = false
	},	
	["r6s_holo_sprite"] = {
		["active"] = true
		},
	["r6s_holo"] = {
		["active"] = true
		}
	},
	["Bodygroups_V"] = {
		[1] = 1
	},
	["IronSightsPos"] = function(wep, val) return wep.IronSightsPos_Holo or val, true end,
	["IronSightsAng"] = function(wep, val) return wep.IronSightsAng_Holo or val, true end,
	["IronSightTime"] = function(wep, val) return val * 1 end,
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end