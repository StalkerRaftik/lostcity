if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Extended Magazine"
ATTACHMENT.Description = {
	TFA.AttachmentColors["+"], "Увеличивает размер магазина до 50.",
	TFA.AttachmentColors["-"], "Скорость передвижения уменьшается на 6%."
}
ATTACHMENT.Icon = "entities/ins2_att_mag_ext_carbine_30rd.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "MAG+"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["mag"] = {
			["active"] = false,
		},
		["mag_ext"] = {
			["active"] = true,
		}
	},
	["WElements"] = {
		["mag"] = {
			["active"] = false,
		},
		["mag_ext"] = {
			["active"] = true,
		}
	},

	["Primary"] = {
		["ClipSize"] = function(wep, val)
			return wep.Primary.ClipSize_Drum or 50
		end,
	},
	["MoveSpeed"] = function(wep,stat) return stat * 0.94 end,
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
