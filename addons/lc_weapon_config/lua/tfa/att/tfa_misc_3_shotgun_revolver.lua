if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "DMR Mags"
ATTACHMENT.Description = {TFA.AttachmentColors["="], "DMR Magazines", TFA.AttachmentColors["+"],"100% More Damage", TFA.AttachmentColors["-"],"10 Bullets", TFA.AttachmentColors["+"], "Less Horizontal Spread", TFA.AttachmentColors["-"], "More Vertical Spread" }
ATTACHMENT.Icon = "entities/r6s dmr round.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "DMR"

ATTACHMENT.WeaponTable = {
		["Primary"] = {		
		        ["RPM"] = function( wep, stat) return 200, true end,
                ["ClipSize"] = function( wep, stat) return 10, true end,
				["Damage"] = function( wep, stat ) return stat * 2 end,
				["KickUp"] = function( wep, stat ) return stat * 10 end,
				["KickHorizontal"] = function( wep, stat ) return stat * 0.5 end,	
				["Spread"] = function( wep, stat ) return 0.085 end,	
				["IronAccuracy"] = function( wep, stat ) return 0.0025 end,									
		},
		
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