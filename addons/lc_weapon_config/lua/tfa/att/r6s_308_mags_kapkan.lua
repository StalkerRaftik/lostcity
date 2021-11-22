if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = ".308 Mags"
ATTACHMENT.Description = {TFA.AttachmentColors["="], ".308 Magazines", TFA.AttachmentColors["+"],"50% More Damage", TFA.AttachmentColors["-"],"50% Less Ammo", TFA.AttachmentColors["+"], "Less Horizontal Spread", TFA.AttachmentColors["-"], "More Vertical Spread" }
ATTACHMENT.Icon = "entities/r6s dmr round.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = ".308"

ATTACHMENT.WeaponTable = {
		["Primary"] = {
		        ["RPM"] = function( wep, stat) return wep.Primary.RPM_308 or stat end,
                ["ClipSize"] = function( wep, stat) return wep.Primary.ClipSize_308 or stat end,
				["Damage"] = function( wep, stat ) return stat * 1.5 end,
				["KickUp"] = function( wep, stat ) return stat * 1.2 end,
				["KickHorizontal"] = function( wep, stat ) return stat * 0.5 end,				
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