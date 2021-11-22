if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "9x19 mm Luger CCI"
ATTACHMENT.ShortName = "" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { 
TFA.Attachments.Colors["="], "9x19 mm Luger CCI special heavy bullets.", 
TFA.Attachments.Colors["+"], "10% more damage",
TFA.Attachments.Colors["-"], "20% more recoil", "10% more spread", "5% range fall off" 
}
ATTACHMENT.Icon = "entities/9x19cgi.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function( wep, stat ) return stat * 1.10 end,
		["Spread"] = function( wep, stat ) return stat * 1.1 end,
		["IronAccuracy"] = function( wep, stat ) return stat * 1.1 end,
		["KickUp"] = function( wep, stat ) return stat * 1.20 end,
		["KickDown"] = function( wep, stat ) return stat * 1.20 end,
		["RangeFalloff"] = function( wep, stat ) return stat * 0.95 end
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
