if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Makeshift Stock"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {TFA.AttachmentColors["="], "Makeshift Stock", TFA.AttachmentColors["+"], "25% less vertical recoil", "25% less horizontal recoil", TFA.AttachmentColors["-"], "Lower Movement Speed " }
ATTACHMENT.Icon = "entities/r6_ex_stock.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "MSStock"

ATTACHMENT.WeaponTable = {
	
	["VElements"] = {
	["Stock MS"] = {
		["active"] = true
		}
	},
		["Primary"] = {
		["KickUp"] = function(wep,stat) return stat * 0.75 end,
		["KickDown"] = function(wep,stat) return stat * 0.75 end,
		["KickHorizontal"] = function(wep,stat) return stat * 0.75 end,
		["Spread"] = function(wep,stat) return stat * 0.9 end,
		["IronAccuracy"] = function(wep,stat) return stat * 1.025 end
	},
	["MoveSpeed"] = function(wep,stat) return stat * 0.9 end,
	["IronSightsMoveSpeed"] = function(wep,stat) return stat * 0.9 end,
		["IronSightTime"] = function( wep, val ) return val * 1 end
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end