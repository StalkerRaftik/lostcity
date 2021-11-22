if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Drum Mags"
ATTACHMENT.Description = {TFA.AttachmentColors["="], "Drum Magazines", TFA.AttachmentColors["+"],"75 Bullets" }
ATTACHMENT.Icon = "entities/r6s dmr round.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "EXT"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["Drum Mag"] = {
			["active"] = true
		},
		["Mag"] = {
			["active"] = false
		},
	},
		["Primary"] = {		
                ["ClipSize"] = function( wep, stat) return 75, true end,
		        ["RPM"] = function( wep, stat) return 500 end,
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