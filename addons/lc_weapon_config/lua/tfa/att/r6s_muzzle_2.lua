if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Muzzle Brake"
ATTACHMENT.Description = {TFA.AttachmentColors["="], "Muzzle Break",TFA.AttachmentColors["+"],"25% Less Vertical Recoil" ,TFA.AttachmentColors["-"],"25% More Spread",TFA.AttachmentColors["+"],"50% Less Max Spread"}
ATTACHMENT.Icon = "entities/r6s_muzzlebreak.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "MUBREAK"

ATTACHMENT.WeaponTable = {
			["Primary"] = {
                ["KickUp"] = function( wep, stat ) return stat * 0.75 end,
                ["KickDown"] = function( wep, stat ) return stat * 0.75 end,
				["Spread"] = function( wep, stat ) return stat * 1.25 end,	
                ["SpreadMultiplierMax"] = function( wep, stat ) return stat * 0.5 end
        }
	}
	
if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end