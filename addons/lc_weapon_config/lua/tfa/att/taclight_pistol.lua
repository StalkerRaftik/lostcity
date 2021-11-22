if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Tactical Pistol Flashlight"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["+"], "5% lower base spread" }
ATTACHMENT.Icon = "entities/pistolflash.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "Pflash"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["Pflash"] = {
			["active"] = true
		},	
		["Laser"] = {
			["active"] = false
		}
	},
	["Primary"] = {
		["Spread"] = function(wep,stat) return math.max( stat * 0.95, stat - 0.01 ) end,
	},
	["LaserSightAttachment"] = function(wep,stat) return wep.LaserSightModAttachment end
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
