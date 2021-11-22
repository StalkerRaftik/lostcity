if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Extended Mags"
ATTACHMENT.Description = {TFA.AttachmentColors["="], "Extended Magazines", TFA.AttachmentColors["+"],"100% More Ammo", TFA.AttachmentColors["-"],"15% Less Damage", TFA.AttachmentColors["+"], "Less Horizontal Spread", TFA.AttachmentColors["-"], "More Vertical Spread" }
ATTACHMENT.Icon = "entities/r6s dmr round.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "9mm"

ATTACHMENT.WeaponTable = {
	["VElements"] = {	
		["Ext mag"] = {
			["active"] = true
		}
	},
		["Primary"] = {
                ["ClipSize"] = function( wep, stat) return wep.Primary.ClipSize_EXT or stat end,
				["Damage"] = function( wep, stat ) return stat * 0.85 end,
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