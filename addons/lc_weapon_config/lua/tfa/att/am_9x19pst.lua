if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "9x19 mm Pst gzh"
ATTACHMENT.ShortName = "" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { 
TFA.Attachments.Colors["="], "9x19 mm Pst gzh steel core bullet.",
TFA.Attachments.Colors["+"], "20% lower spread kick", "10% lower recoil", "5% range fall gain", 
TFA.Attachments.Colors["-"], "20% lower spread recovery" 
}
ATTACHMENT.Icon = "entities/9x19pst.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["SpreadIncrement"] = function( wep, stat ) return stat * 0.9 end,
		["SpreadRecovery"] = function( wep, stat ) return stat * 0.8 end,
		["KickUp"] = function( wep, stat ) return stat * 0.9 end,
		["KickDown"] = function( wep, stat ) return stat * 0.9 end,
		["RangeFalloff"] = function( wep, stat ) return stat * 1.05 end
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
