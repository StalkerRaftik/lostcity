if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Proficiency"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["+"], "Enables proficiency reload" }
ATTACHMENT.Icon = "entities/fas2_proficiency.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "PRO"

ATTACHMENT.WeaponTable = {
	["Animations"] = {
		["reload"] = {
			["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
			["value"] = "base_reload_speed"
		},
		["reload_empty"] = function(wep, val)
			val.type = TFA.Enum.ANIMATION_SEQ
			val.value = "base_reload_empty_speed"

			if wep:CheckVMSequence("base_reload_empty_speed") then
				val.value = "base_reload_empty_speed"
			end

			return val, true
		end,
	},
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end