if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Laser Sight"
ATTACHMENT.Description = {
	TFA.AttachmentColors["+"], "yes",
}
ATTACHMENT.Icon = "vgui/entities/tfa_rustalpha_att_laser_sight"
ATTACHMENT.ShortName = "LASER"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["laser_sight"] = {
			["active"] = true
		},
		["laser_beam"] = {
			["active"] = true
		}
	},
	["WElements"] = {
		["laser_sight"] = {
			["active"] = true
		},
		["laser_beam"] = {
			["active"] = true
		}
	},
	["LaserSightAttachment"] = function(wep,stat) return wep.LaserSightModAttachment or 1 end,
	["LaserSightAttachmentWorld"] = function(wep,stat) return wep.LaserSightModAttachmentWorld or wep.LaserSightModAttachment or 1 end
}

ATTACHMENT.AttachSound = "YURIE_RUSTALPHA.AttachSight"

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
