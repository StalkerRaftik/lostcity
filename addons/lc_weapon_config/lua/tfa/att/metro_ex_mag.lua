if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Extended Mags"
ATTACHMENT.Description = {TFA.AttachmentColors["="], "Extended Magazines", TFA.AttachmentColors["+"],"20 More Bullets", TFA.AttachmentColors["-"], "More Horizontal Spread", TFA.AttachmentColors["-"], "More Vertical Spread", TFA.AttachmentColors["-"], "Lower Movement Speed" }
ATTACHMENT.Icon = "entities/r6s ex mag.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "Ext"

ATTACHMENT.WeaponTable = {
	["VElements"] = {	
		["Ex Mag"] = {
			["active"] = true
		},
		["Mag"] = {
			["active"] = true
		}		
	},
		["Primary"] = {
				["ClipSize"] = function( wep, stat ) return stat + 20 end,	
				["KickUp"] = function( wep, stat ) return stat * 1.25 end,
				["KickHorizontal"] = function( wep, stat ) return stat * 1.25 end,		
				},	
	["MoveSpeed"] = function(wep,stat) return stat * 0.8 end,
	["IronSightsMoveSpeed"] = function(wep,stat) return stat * 0.8 end,		
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