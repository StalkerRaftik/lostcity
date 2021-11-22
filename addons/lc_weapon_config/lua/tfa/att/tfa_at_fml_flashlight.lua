if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Flash Light"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Icon = "entities/ins2_att_ub_laser.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "FHLT"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["Flash Light"] = {
			["active"] = true
		},	
	},
	["FlashlightAttachment"] = function(wep,stat) return wep.FlashlightAttachment end
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
