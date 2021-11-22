if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "PK122"

ATTACHMENT.Description = { TFA.AttachmentColors["="], "5% higher zoom", TFA.AttachmentColors["-"], "5% higher zoom time" }
ATTACHMENT.Icon = "entities/tfa_ins2_si_pk122.png"
ATTACHMENT.ShortName = "1P87"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["rail_sights"] = {
			["active"] = true
		},
		["sight_pk122"] = {
			["active"] = function(wep, val) TFA.INS2.AnimateSight(wep) return true end,
			["ins2_sightanim_idle"] = "idle",
			["ins2_sightanim_iron"] = "zoom",
		},
		["sights_folded"] = {
			["active"] = false
		},
		["sight_pk122_lens"] = {
			["active"] = true
		}
	},
	["WElements"] = {
		["rail_sights"] = {
			["active"] = true
		},
		["sight_pk122"] = {
			["active"] = true
		},
		["sights_folded"] = {
			["active"] = false
		},
		["sight_pk122_lens"] = {
			["active"] = true
		}
	},
	["IronSightsPos"] = function( wep, val ) return wep.IronSightsPos_pk122 or val end,
	["IronSightsAng"] = function( wep, val ) return wep.IronSightsAng_pk122 or val end,
	["Secondary"] = {
		["IronFOV"] = function( wep, val ) return wep.Secondary.IronFOV_pk122 or val * 0.95 end
	},
	["IronSightTime"] = function( wep, val ) return val * 1.05 end,
	["INS2_SightVElement"] = "sight_pk122",
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
