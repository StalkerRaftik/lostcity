if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "10 Round Magazine"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["+"], "Faster mobility.",  TFA.AttachmentColors["-"], "Less magazine capacity.", }
ATTACHMENT.Icon = "entities/inss_asval_10_rnd.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "10RND"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["mag"] = {
			["active"] = false
		},
		["mag_10"] = {
			["active"] = true
		}
	},
	["WElements"] = {
		["mag"] = {
			["active"] = false
		},
		["mag_10"] = {
			["active"] = true
		}
	},
	["Primary"] = {
		["ClipSize"] = 10,
	},
	["MoveSpeed"] = function(wep,stat) return stat * 1.08 end,
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