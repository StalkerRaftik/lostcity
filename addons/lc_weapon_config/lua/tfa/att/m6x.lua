if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "M6X"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["+"], "20% lower base spread", TFA.AttachmentColors["-"], "10% higher max spread" }
ATTACHMENT.Icon = "entities/m6x.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "M6x"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["M6x"] = {
			["active"] = true
		},	
		["M6x Laser"] = {
			["active"] = true
		}
	},
	["Primary"] = {
		["Spread"] = function(wep,stat) return math.max( stat * 0.8, stat - 0.01 ) end,
		["SpreadMultiplierMax"] = function(wep,stat) return stat * ( 1 / 0.8 ) * 1.1 end
	},
	["LaserSightAttachment"] = function(wep,stat) return wep.LaserSightModAttachment end
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
