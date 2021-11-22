if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Flechette"
ATTACHMENT.ShortName = "Flechette" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["+"], "Metal darts with better accuracy and penetration", TFA.AttachmentColors["-"], "-30% Damage"  }
ATTACHMENT.Icon = "entities/amno_flechette_test.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
                                                ["PenetrationMultiplier"] = function( wep, stat ) return 5 * 5 end,
                                                ["Spread"] = function( wep, stat ) return math.max( stat - 0.15, stat * 0.6 ) end,
                                                ["IronAccuracy"] = function( wep, stat ) return math.max( stat - 0.02, stat * 0.5 ) end,
                                                ["Damage"] = function(wep,stat) return stat * 0.70 end,
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
