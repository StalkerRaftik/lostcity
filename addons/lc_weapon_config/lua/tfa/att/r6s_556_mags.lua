if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = ".556 Mags"
ATTACHMENT.Description = {TFA.AttachmentColors["="], ".556 Magazines", TFA.AttachmentColors["-"],"5% Less Damage", TFA.AttachmentColors["-"],"75% Less Ammo", TFA.AttachmentColors["+"], "Less Horizontal Spread", TFA.AttachmentColors["+"], "Less Vertical Spread" }
ATTACHMENT.Icon = "entities/r6s dmr round.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = ".556"

ATTACHMENT.WeaponTable = {
		["Primary"] = {
		        ["RPM"] = function( wep, stat) return wep.Primary.RPM_556 or stat end,
                ["ClipSize"] = function( wep, stat) return wep.Primary.ClipSize_556 or stat end,
				["Damage"] = function( wep, stat ) return stat * 0.95 end,
				["KickUp"] = function( wep, stat ) return stat * 0.75 end,
				["KickHorizontal"] = function( wep, stat ) return stat * 0.75 end,				
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