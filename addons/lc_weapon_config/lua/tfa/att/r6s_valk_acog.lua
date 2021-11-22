if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "ACOG"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {TFA.AttachmentColors["="], "2.5x ACOG"}
ATTACHMENT.Icon = "entities/Blank.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "ACOG"

ATTACHMENT.WeaponTable = {
	
	["VElements"] = {	
	["Iron"] = {
		["active"] = false
	},		
	["Acog"] = {
		["active"] = true
		}
	},
	["Bodygroups_V"] = {
		[1] = 1
	},
	["IronSightsPos"] = function(wep, val) return wep.IronSightsPos_ACOG or val, true end,
	["IronSightsAng"] = function(wep, val) return wep.IronSightsAng_ACOG or val, true end,
	["IronSightTime"] = function(wep, val) return val * 1 end,
	["Secondary"] = {
		["IronFOV"] = function( wep, val ) return val * 0.4 end
	},
	["IronSightsMoveSpeed"] = function(wep,stat) return stat * 0.8 end,
	["IronSightTime"] = function( wep, val ) return val * 1.2 end,
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end