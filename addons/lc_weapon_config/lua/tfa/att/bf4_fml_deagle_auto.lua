if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Extended Mags"
ATTACHMENT.Description = {TFA.AttachmentColors["="], "Extended Magazines", TFA.AttachmentColors["+"],"13 More Bullets", TFA.AttachmentColors["+"],"Auto Fire", TFA.AttachmentColors["-"], "More Horizontal Spread", TFA.AttachmentColors["-"], "More Vertical Spread", TFA.AttachmentColors["-"], "Lower Movement Speed" }
ATTACHMENT.Icon = "entities/r6s dmr round.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "Ext"

ATTACHMENT.WeaponTable = {
	["VElements"] = {	
		["Mag Auto"] = {
			["active"] = true
		},	
	},
		["Primary"] = {
		        ["RPM"] = function( wep, stat) return stat + 150 end,		
				["ClipSize"] = function( wep, stat ) return stat + 13 end,	
				["KickUp"] = function( wep, stat ) return stat * 0.75 end,
				["Damage"] = function( wep, stat ) return stat * 0.75 end,				
				["KickHorizontal"] = function( wep, stat ) return stat * 1.25 end,	
				["Spread"] = function( wep, stat ) return stat * 1.25 end,				
				["IronAccuracy"] = function( wep, stat ) return stat * 1.15 end,						
				},		
			["FireModes"] = {"Automatic"},				
	}

function ATTACHMENT:Attach(wep)
	wep:Unload()
	wep.Primary.Automatic = true
end

function ATTACHMENT:Detach(wep)
	wep:Unload()
	wep.Primary.Automatic = false
end
	
if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end