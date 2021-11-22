if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name        = "Sweet Vengance"
ATTACHMENT.ShortName   = "Pink"
ATTACHMENT.Icon        = "entities/warface_m98b_pinky_skin.png"

ATTACHMENT.Description = { TFA.AttachmentColors["+"], "How shad says hes cute but very very gay." }

ATTACHMENT.WeaponTable = {}

ATTACHMENT.MaterialTable = {
	[2] = "models/weapons/v_models/sr16/pink/sr16_pink02_b_diff",
	[3] = "models/weapons/v_models/sr16/pink/sr16_pink02_a_diff",
	[5] = "models/weapons/v_models/sr16/pink/sr16_pink02_sp_d_diff",
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