if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Extended Mags"
ATTACHMENT.Description = {TFA.AttachmentColors["="], "Extended Magazines", TFA.AttachmentColors["+"],"10 More Bullets", TFA.AttachmentColors["+"],"Auto Fire", TFA.AttachmentColors["-"], "More Horizontal Spread", TFA.AttachmentColors["-"], "More Vertical Spread", TFA.AttachmentColors["-"], "Lower Movement Speed" }
ATTACHMENT.Icon = "entities/r6s dmr round.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "Ext"

ATTACHMENT.WeaponTable = {
	["VElements"] = {	
		["Mag 2"] = {
			["active"] = true
		},	
		["Mag 2+"] = {
			["active"] = true
		},			
	},
		["Primary"] = {
		        ["RPM"] = function( wep, stat) return 650 end,		
				["ClipSize"] = function( wep, stat ) return stat + 20 end,	
				["KickUp"] = function( wep, stat ) return stat * 1.35 end,
				["KickHorizontal"] = function( wep, stat ) return stat * 1.35 end,	
				["Spread"] = function( wep, stat ) return 0.085 end,	
				["IronAccuracy"] = function( wep, stat ) return 0.0085 end,					
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