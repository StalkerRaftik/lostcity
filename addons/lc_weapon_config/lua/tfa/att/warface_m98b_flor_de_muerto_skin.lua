if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name        = "Flor De Muerto"
ATTACHMENT.ShortName   = "Gold"
ATTACHMENT.Icon        = "entities/warface_m98b_flor_de_muerto_skin.png"

ATTACHMENT.Description = { TFA.AttachmentColors["+"], "A combination of blue and gold." }

ATTACHMENT.WeaponTable = {}

ATTACHMENT.MaterialTable = {
	[2] = "models/weapons/v_models/sr16/gold/sr16_b_set05_diff",
	[3] = "models/weapons/v_models/sr16/gold/sr16_a_set05_diff",
	[5] = "models/weapons/v_models/sr16/gold/sr16_set05_sp_d_diff",
}

function ATTACHMENT:Attach(wep)
	wep.MaterialTable = wep.MaterialTable or {}
	for k, v in pairs(self.MaterialTable or {}) do
		wep.MaterialTable[k] = self.MaterialTable[k]
	end
	wep.MaterialCached = false
end

function ATTACHMENT:Detach(wep)
	wep.MaterialTable = wep.MaterialTable or {}
	for k, v in pairs(self.MaterialTable or {}) do
		wep.MaterialTable[k] = nil
	end
	wep.MaterialCached = false
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end