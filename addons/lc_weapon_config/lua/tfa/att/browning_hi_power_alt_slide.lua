if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Alt Slide"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["="], "10% higher zoom", TFA.AttachmentColors["-"], "10% higher zoom time" }
ATTACHMENT.Icon = "entities/ins2_att_fsi.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "Alt Slide"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["alt_slide"] = {
			["active"] = true
		},
		["standard_slide"] = {
			["active"] = false
		}
	},
	["WElements"] = {
		["alt_slide"] = {
			["active"] = true
		},
		["standard_slide"] = {
			["active"] = false
		}
	},
	["IronSightsPos"] = function( wep, val ) return wep.IronSightsPos_AltSlide or val, true end,
	["IronSightsAng"] = function( wep, val ) return wep.IronSightsAng_AltSlide or val, true end,
	["Secondary"] = {
		["IronFOV"] = function( wep, val ) return val * 0.9 end
	},
	["IronSightTime"] = function( wep, val ) return val * 1.10 end
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
