if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Snubnose"
ATTACHMENT.Description = {
	TFA.AttachmentColors["+"], "Compact variant with light triggerpull",
	TFA.AttachmentColors["+"], "+50% RPM increase", "+5% movement speed",
	TFA.AttachmentColors["-"], "+15% vertical recoil"
}
ATTACHMENT.Icon = "entities/tfa_ins2_swmodel10snub.png"
ATTACHMENT.ShortName = "SNUB"

ATTACHMENT.WeaponTable = {
["ViewModelBoneMods"] = {
	["A_Muzzle"] = { scale = Vector(1, 1, 1), pos = Vector(0, 2.15, 0), angle = Angle(90, 90, 0)  },
	["A_Muzzle_Ironsight"] = { scale = Vector(1, 1, 1), pos = Vector(0, 2.15, 0), angle = Angle(0, 0, 0)  },
	},
["Bodygroups_V"] = {[1] = 1},
["Bodygroups_W"] = {[0] = 1},
	["Primary"] = {
		["RPM"] = function( wep, stat ) return stat * 1.5 end,
		["KickUp"] = function( wep, stat ) return stat * 1.25 end,
		["KickDown"] = function( wep, stat ) return stat * 1.25 end,
	},
	["MoveSpeed"] = function( wep, stat ) return stat * 1.05 end,
	["IronSightsMoveSpeed"] = function( wep, stat ) return stat * 1.15 end,
}

function ATTACHMENT:Attach(wep)
end

function ATTACHMENT:Detach(wep)
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
