if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Long Barrel"
ATTACHMENT.Description = {
	TFA.AttachmentColors["+"], "5% less vertical recoil", "20% less horizontal recoil", "25% less spread", "25% longer effective firing range"
}
ATTACHMENT.Icon = "entities/tfa_ins2_deagle_br_ext.png"
ATTACHMENT.ShortName = "LONG"

ATTACHMENT.WeaponTable = {
	["Bodygroups_V"] = {
		["Barrel"] = 1
	},
	["Bodygroups_W"] = {
		["Barrel"] = 1
	},
	["Primary"] = {
		["KickUp"] = function(wep, stat) return stat * 0.95 end,
		["KickDown"] = function(wep, stat) return stat * 0.95 end,
		["KickHorizontal"] = function(wep, stat) return stat * 0.8 end,

		["Spread"] = function(wep, stat) return stat * 0.75 end,
		["IronAccuracy"] = function(wep, stat) return stat * 0.75 end,

		["RangeFalloff"] = function(wep, stat) return stat * 1.25 end,
	},
	["MuzzleAttachmentMod"] = function(wep, stat) return wep.MuzzleAttachmentExt or stat end,
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
