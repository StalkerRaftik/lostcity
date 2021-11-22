if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = ".45 Mags"
ATTACHMENT.Description = {TFA.AttachmentColors["="], ".45 Magazines", TFA.AttachmentColors["+"],"15% More Damage", TFA.AttachmentColors["-"],"15% Less Ammo", TFA.AttachmentColors["-"], "More Horizontal Spread", TFA.AttachmentColors["-"], "More Vertical Spread" }
ATTACHMENT.Icon = "entities/r6s dmr round.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = ".45"

ATTACHMENT.WeaponTable = {
		["Primary"] = {
                ["ClipSize"] = function( wep, stat) return wep.Primary.ClipSize_45 or stat * 0.85 end,
				["Damage"] = function( wep, stat ) return stat * 1.15 end,
				["KickUp"] = function( wep, stat ) return stat * 1.2 end,
				["KickHorizontal"] = function( wep, stat ) return stat * 1.2 end,				
		}	
	}

function ATTACHMENT:Attach(wep)
	wep:Unload()
end

function ATTACHMENT:Detach(wep)
	wep:Unload()
end
		
if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end