if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Trijicon RMR"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {TFA.AttachmentColors["="], "Holo Sight"}
ATTACHMENT.Icon = "entities/rmr.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "Rmr"

ATTACHMENT.WeaponTable = {
	
	["VElements"] = {
	["Iron Dot"] = {
		["active"] = false
	},
	["Iron"] = {
		["active"] = false
	}, 	
	["Rmr Dot"] = {
		["active"] = true
		},
	["Rmr"] = {
		["active"] = true
		},
	["Rail"] = {
		["active"] = false
		}		
	},
	["IronSightsPos"] = function(wep, val) return wep.IronSightsPos_Rmr or val, true end,
	["IronSightsAng"] = function(wep, val) return wep.IronSightsAng_Rmr or val, true end,
	["IronSightTime"] = function(wep, val) return val * 1 end,
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end