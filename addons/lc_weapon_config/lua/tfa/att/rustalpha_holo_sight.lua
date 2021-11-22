if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Holo Sight"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {
	TFA.AttachmentColors["="], "5% higher zoom",
}
ATTACHMENT.Icon = "vgui/entities/tfa_rustalpha_att_holo_sight" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "HOLO"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["holo_sight"] = {
			["active"] = true,
		}
	},
	["WElements"] = {
		["holo_sight"] = {
			["active"] = true
		}
	},
	["Primary"] = {
		["IronAccuracy"] = function(wep,stat) return stat * 0.6 end,
	},
	["IronSightsPos"] = function( wep, val ) return wep.IronSightsPos_Holosight or val end,
	["IronSightsAng"] = function( wep, val ) return wep.IronSightsAng_Holosight or val end,
	["Secondary"] = {
		["IronFOV"] = function( wep, val ) return wep.Secondary.IronFOV_Holosight or val * 0.8 end
	},
}

ATTACHMENT.AttachSound = "YURIE_RUSTALPHA.AttachSight"

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
