if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "VSS Kit"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["+"], "Converts gun into a VSS Vintorez build.", "Mild improvement to recoil control.", "Drastic improvement to spread.", TFA.AttachmentColors["-"], "Drastic slower mobility.", "Drastic slower aiming mobility." }
ATTACHMENT.Icon = "entities/inss_vss_kit.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "VSS"

ATTACHMENT.WeaponTable = {
	["Bodygroups_V"] = {
		[1] = 1
	},
	["Bodygroups_W"] = {
		[1] = 1
	},
	["Primary"] = {
		["KickUp"] = function(wep,stat) return stat * 0.82 end,
		["KickDown"] = function(wep,stat) return stat * 0.82 end,
		["KickHorizontal"] = function(wep,stat) return stat * 0.82 end,
		["Spread"] = function(wep,stat) return stat * 0.75 end,
		["IronAccuracy"] = function(wep,stat) return stat * 0.75 end
	},
	["MoveSpeed"] = function(wep,stat) return stat * 0.88 end,
	["IronSightsMoveSpeed"] = function(wep,stat) return stat * 0.88 end,
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end