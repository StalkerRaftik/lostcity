-- Stolen from TFA CSO2

if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Lewd Handling"
ATTACHMENT.Description = {
	TFA.AttachmentColors["+"], "Using the gun will now give you an erection",
	TFA.AttachmentColors["-"], "It's hard to play one handed",
	TFA.AttachmentColors["="], "", "A reminiscent of something from the older times..."
}
ATTACHMENT.Icon = "entities/tfa_cso2_lewd.png"
ATTACHMENT.ShortName = "LEWD"

ATTACHMENT.WeaponTable = {
	["Animations"] = {
		["reload"] = {
			["type"] = TFA.Enum.ANIMATION_ACT,
			["value"] = ACT_DOD_RELOAD_BOLT
		},
		["reload_empty"] = {
			["type"] = TFA.Enum.ANIMATION_ACT,
			["value"] = ACT_DOD_RELOAD_CROUCH_BOLT
		}
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
