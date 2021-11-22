if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Kemper XL"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {TFA.AttachmentColors["="], "Machinegun Sight"}
ATTACHMENT.Icon = "entities/kemper_xl.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "Kemper"

ATTACHMENT.WeaponTable = {
	
	["VElements"] = {
	["Iron"] = {
		["active"] = false
	},	
	["Iron Dot"] = {
		["active"] = false
	},	
	["Kemper_Dot"] = {
		["active"] = true
		},
	["Kemper"] = {
		["active"] = true
		},
	["Rail"] = {
		["active"] = true
		}		
	},
	["IronSightsPos"] = function(wep, val) return wep.IronSightsPos_Kem or val, true end,
	["IronSightsAng"] = function(wep, val) return wep.IronSightsAng_Kem or val, true end,
	["IronSightTime"] = function(wep, val) return val * 1 end,
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end