if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Flashlight Mod"
ATTACHMENT.Description = {
	TFA.AttachmentColors["+"], "yes",
}
ATTACHMENT.Icon = "vgui/entities/tfa_rustalpha_att_flashlight"
ATTACHMENT.ShortName = "LIGHT"

ATTACHMENT.WeaponTable = {
	["FlashlightAttachment"] = function(wep, val) return wep:GetStat("FlashlightAttachmentEnabled") or 1 end,
}

ATTACHMENT.AttachSound = "YURIE_RUSTALPHA.AttachLight"

function ATTACHMENT:Attach(wep)
	local owner = wep:GetOwner()

	if SERVER and IsValid(owner) and owner:IsPlayer() and owner:FlashlightIsOn() then
		if not wep:GetFlashlightEnabled() then
			wep:ToggleFlashlight(true)
		end

		owner:Flashlight(false)
	end
end

function ATTACHMENT:Detach(wep)
	if wep:GetFlashlightEnabled() then
		wep:ToggleFlashlight(false)
	end
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
