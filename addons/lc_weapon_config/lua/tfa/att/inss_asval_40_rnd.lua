if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "40 Round Magazine"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["+"], "More magazine capacity.",  TFA.AttachmentColors["-"], "Slower mobility.", }
ATTACHMENT.Icon = "entities/inss_asval_40_rnd.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "40RND"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["mag"] = {
			["active"] = false
		},
		["mag_40"] = {
			["active"] = true
		}
	},
	["WElements"] = {
		["mag"] = {
			["active"] = false
		},
		["mag_40"] = {
			["active"] = true
		}
	},
	["Primary"] = {
		["ClipSize"] = 40,
	},
	["MoveSpeed"] = function(wep,stat) return stat * 0.95 end,
}

function ATTACHMENT:Attach(wep)
	wep:Unload()
end

function ATTACHMENT:Detach(wep)
	wep:Unload()
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end