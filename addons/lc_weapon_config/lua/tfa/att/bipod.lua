if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Bipod"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["+"], "15% less kick up" }
ATTACHMENT.Icon = "entities/bipod.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "Bipod"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["Bipod"] = {
			["active"] = true
		},	
		["Bipod"] = {
			["active"] = true
		}
	},
	["Primary"] = {
		["KickUp"] = function(wep,stat) return math.max( stat * 0.85, stat - 0.01 ) end,
                ["KickDown"] = function( wep, stat ) return stat * 0.85 end,
                ["KickHorizontal"] = function( wep, stat ) return stat * 0.85 end
	},
	["LaserSightAttachment"] = function(wep,stat) return wep.LaserSightModAttachment end
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
