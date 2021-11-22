if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "AP Round"
ATTACHMENT.ShortName = "AP" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.Attachments.Colors["-"], "10% less damage", TFA.Attachments.Colors["+"], "20% lower spread kick", "10% lower recoil", TFA.AttachmentColors["+"], "3 Times More Penetration" }
ATTACHMENT.Icon = "entities/tfa_ammo_match.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function( wep, stat ) return stat * 0.90 end,
		["SpreadIncrement"] = function( wep, stat ) return stat * 1.2 end,
		["SpreadRecovery"] = function( wep, stat ) return stat * 0.8 end,
		["KickUp"] = function( wep, stat ) return stat * 0.9 end,
		["PenetrationMultiplier"] = function(wep, val) return val * 3 end
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
