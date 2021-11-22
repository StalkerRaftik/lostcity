if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Flashlight"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["+"], "10% lower base spread", TFA.AttachmentColors["-"], "5% higher max spread" }
ATTACHMENT.Icon = "entities/flashlight2.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "Flashlight"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["Flashlight"] = {
			["active"] = true
		},	
		["Flashlight"] = {
			["active"] = true
		}
	},
	["Primary"] = {
		["Spread"] = function(wep,stat) return math.max( stat * 0.9, stat - 0.01 ) end,
		["SpreadMultiplierMax"] = function(wep,stat) return stat * ( 1 / 0.9 ) * 1.05 end
	},
	["LaserSightAttachment"] = function(wep,stat) return wep.LaserSightModAttachment end
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
