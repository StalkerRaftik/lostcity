if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "9mm Mags"
ATTACHMENT.Description = {TFA.AttachmentColors["="], "9mm Magazines", TFA.AttachmentColors["+"],"50% More Ammo", TFA.AttachmentColors["-"],"25% Less Damage", TFA.AttachmentColors["+"], "Less Horizontal Spread", TFA.AttachmentColors["-"], "More Vertical Spread" }
ATTACHMENT.Icon = "entities/r6s dmr round.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "9mm"

ATTACHMENT.WeaponTable = {
		["Primary"] = {
                ["ClipSize"] = function( wep, stat) return stat * 1.5 end,
				["Damage"] = function( wep, stat ) return stat * 0.75 end,
				["KickUp"] = function( wep, stat ) return stat * 1.25 end,
				["KickHorizontal"] = function( wep, stat ) return stat * 0.25 end,				
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