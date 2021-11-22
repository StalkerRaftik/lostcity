if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "12.7 Mags"
ATTACHMENT.Description = {TFA.AttachmentColors["="], "12.7 Magazines", TFA.AttachmentColors["+"],"175% More Damage", TFA.AttachmentColors["-"],"10 Bullets", TFA.AttachmentColors["-"], "More Horizontal Spread", TFA.AttachmentColors["-"], "More Vertical Spread" }
ATTACHMENT.Icon = "entities/r6s dmr round.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "12.7"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["Mag_127"] = {
			["active"] = true
		},
		["Mag"] = {
			["active"] = false
		},
	},
		["Primary"] = {		
		        ["RPM"] = function( wep, stat) return stat * 0.5 end,
                ["ClipSize"] = function( wep, stat) return 10, true end,
				["Damage"] = function( wep, stat ) return stat * 2.75 end,
				["KickUp"] = function( wep, stat ) return stat * 2.75 end,
				["KickHorizontal"] = function( wep, stat ) return stat * 1.75 end,				
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