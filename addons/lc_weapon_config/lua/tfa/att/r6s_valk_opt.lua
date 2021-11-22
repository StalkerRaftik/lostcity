if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Optical"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {TFA.AttachmentColors["="], "3.5x Optical"}
ATTACHMENT.Icon = "entities/Blank.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "OPT"

ATTACHMENT.WeaponTable = {
	
	["VElements"] = {	
	["Iron"] = {
		["active"] = false
	},		
	["Optical"] = {
		["active"] = true
		}
	},
	["Bodygroups_V"] = {
		[1] = 1
	},
	["IronSightsPos"] = function(wep, val) return wep.IronSightsPos_OPT or val, true end,
	["IronSightsAng"] = function(wep, val) return wep.IronSightsAng_OPT or val, true end,
	["Secondary"] = {
		["IronFOV"] = function( wep, val ) return val * 0.2 end
	},
	["IronSightsMoveSpeed"] = function(wep,stat) return stat * 0.75 end,
	["IronSightTime"] = function( wep, val ) return val * 1.5 end,
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end