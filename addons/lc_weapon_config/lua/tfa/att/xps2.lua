if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "EoTech XPS2-2"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {TFA.AttachmentColors["="], "Holo Sight"}
ATTACHMENT.Icon = "entities/xps2.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "Xps2"

ATTACHMENT.WeaponTable = {
	
	["VElements"] = {
	["Iron Dot"] = {
		["active"] = false
	},
	["Iron"] = {
		["active"] = false
	}, 	
	["Xps2 Dot"] = {
		["active"] = true
		},
	["Xps2"] = {
		["active"] = true
		},
	["Rail"] = {
		["active"] = true
		}		
	},
	["IronSightsPos"] = function(wep, val) return wep.IronSightsPos_Xps or val, true end,
	["IronSightsAng"] = function(wep, val) return wep.IronSightsAng_Xps or val, true end,
	["IronSightTime"] = function(wep, val) return val * 1 end,
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end