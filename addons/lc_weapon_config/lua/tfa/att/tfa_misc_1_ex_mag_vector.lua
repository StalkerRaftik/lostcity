if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Extended Mags"
ATTACHMENT.Description = {TFA.AttachmentColors["="], "Extended Magazines", TFA.AttachmentColors["+"],"30 Bullets" }
ATTACHMENT.Icon = "entities/r6s dmr round.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "EXT"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["Ex Mag"] = {
			["active"] = true
		},
		["Mag"] = {
			["active"] = false
		},
	},
		["Primary"] = {		
                ["ClipSize"] = function( wep, stat) return 30, true end,
		        ["RPM"] = function( wep, stat) return 800, true end,
				["KickUp"] = function( wep, stat ) return stat * 1.2 end,
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