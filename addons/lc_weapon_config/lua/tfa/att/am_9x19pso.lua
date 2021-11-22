if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "	9x19 mm PSO gzh"
ATTACHMENT.ShortName = "" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { 
TFA.Attachments.Colors["="], "9x19 mm PSO gzh sport hunting cartdridge.", 
TFA.Attachments.Colors["+"], "5% more damage",
TFA.Attachments.Colors["-"], "10% more recoil",  "5% more spread", "10% range fall off",
}
ATTACHMENT.Icon = "entities/9x19pso.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function( wep, stat ) return stat * 1.05 end,
		["Spread"] = function( wep, stat ) return stat * 1.05 end,
		["IronAccuracy"] = function( wep, stat ) return stat * 1.05 end,
		["KickUp"] = function( wep, stat ) return stat * 1.10 end,
		["KickDown"] = function( wep, stat ) return stat * 1.10 end,
		["RangeFalloff"] = function( wep, stat ) return stat * 0.9 end
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
