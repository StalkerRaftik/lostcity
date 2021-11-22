if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Sleight Of Hand"
ATTACHMENT.Description = { TFA.AttachmentColors["+"], "Faster Reload" }
ATTACHMENT.Icon = "entities/mw_sog_fml.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "SOH"

ATTACHMENT.WeaponTable = {
	["Animations"] = {
		["reload"] = {
			["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
			["value"] = "reload_soh"
		},
		["reload_empty"] = function(wep, val)
			val.type = TFA.Enum.ANIMATION_SEQ
			val.value = "reload_empty_soh"

			if wep:CheckVMSequence("dry_soh") then
				val.value = "reload_empty_soh"
			end

			return val, true
		end,
	},
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end