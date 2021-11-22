if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Surface GGX Enhancement"
ATTACHMENT.Description = { TFA.AttachmentColors["+"], "Improves shading quality, a must have for every ultra hardcore gamer!", TFA.AttachmentColors["-"], "good job you found an ugly one"  }
ATTACHMENT.Icon = "entities/tfa_ins2_p90_surfaceggx.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "SURFACEGGX"

ATTACHMENT.WeaponTable = {}

ATTACHMENT.MaterialTable = {
    [1] = "models/weapons/tfa_ins2/p90/skins/surfaceggx/grip",
    [2] = "models/weapons/tfa_ins2/p90/skins/surfaceggx/magazine",
	[3] = "models/weapons/tfa_ins2/p90/skins/surfaceggx/receiver",
	[4] = "models/weapons/tfa_ins2/p90/skins/surfaceggx/sight",
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