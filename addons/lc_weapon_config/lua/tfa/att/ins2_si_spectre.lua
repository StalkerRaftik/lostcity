if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Spectre"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["="], "4x zoom", TFA.AttachmentColors["-"], "25% higher zoom time",  TFA.AttachmentColors["-"], "5% slower aimed walking" }
ATTACHMENT.Icon = "entities/tfa_ins_spectre_lol.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "Spectre"
ATTACHMENT.Base = "ins2_scope_base"
ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["scope_spectre"] = {
			["active"] = function(wep, val) TFA.INS2.AnimateSight(wep) return true end,
			["ins2_sightanim_idle"] = "po_idle",
			["ins2_sightanim_iron"] = "po_zoom",
		}
	},
	["WElements"] = {
		["scope_spectre"] = {
			["active"] = true
		}
	},
	["Secondary"] = {
		["ScopeZoom"] = function( wep, val ) return 4 end
	},
	["INS2_SightVElement"] = "scope_spectre",
	["INS2_SightSuffix"] = "Spectre"
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end