if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "DMR Mags"
ATTACHMENT.Description = {TFA.AttachmentColors["="], "DMR Magazines", TFA.AttachmentColors["+"],"50% More More Damage",TFA.AttachmentColors["-"],"50% Less Ammo" }
ATTACHMENT.Icon = "entities/r6s dmr round.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "DMR"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
	["Mag"] = {
		["active"] = false
	},	
	["r6s_dmr_mag"] = {
		["active"] = true
		},
			},
		["Primary"] = {
		        ["RPM"] = function( wep, stat) return wep.Primary.RPM_DMR or stat end,
                ["ClipSize"] = function( wep, stat) return wep.Primary.ClipSize_DMR or stat end,
				["Damage"] = function( wep, stat ) return stat * 1.5 end,
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