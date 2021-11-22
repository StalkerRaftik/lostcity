if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "PGO-7"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["="], "2x zoom", TFA.AttachmentColors["-"], "10% higher zoom time",  TFA.AttachmentColors["-"], "5% slower aimed walking" }
ATTACHMENT.Icon = "entities/tfa_pgo7_scope.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "P7"
ATTACHMENT.Base = "ins2_scope_base"
ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["scope_pgo7"] = {
			["active"] = function(wep, val) TFA.INS2.AnimateSight(wep) return true end,
			["ins2_sightanim_idle"] = "4x_idle",
			["ins2_sightanim_iron"] = "4x_zoom",
		}
	},
	["WElements"] = {
		["scope_pgo7"] = {
			["active"] = true
		}
	},
	["Secondary"] = {
		["ScopeZoom"] = function( wep, val ) return 2 end
	},
	["INS2_SightVElement"] = "pgo7",
	["INS2_SightSuffix"] = "Pgo7",
	["SWEP.IronSightTime"]		= function( wep, val ) return 1.22 end
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end