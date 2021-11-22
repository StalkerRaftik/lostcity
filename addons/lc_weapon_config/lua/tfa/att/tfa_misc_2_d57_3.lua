if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Suppressor"
ATTACHMENT.Description = {TFA.AttachmentColors["="], "Standard Suppressor",TFA.AttachmentColors["-"],"5% less damage",TFA.AttachmentColors["+"],"50% Less Kick Up",}
ATTACHMENT.Icon = "entities/r6_silencer.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "SUPPR"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
			["r6s_suppr"] = {
			["active"] = true
		},
			["r6s_suppr+"] = {
			["active"] = true
		}		
	},
	
	["Primary"] = {
                ["Sound"] = function( wep, stat) return wep.Primary.Sound_SIL or stat end, --Silenced sound
                ["Damage"] = function( wep, stat ) return stat * 0.95 end,
                ["KickUp"] = function( wep, stat ) return stat * 0.65 end,
                ["KickDown"] = function( wep, stat ) return stat * 0.65 end,
                ["KickHorizontal"] = function( wep, stat ) return stat * 0.65 end
        },
	["MuzzleAttachmentMod"] = 1,--Muzzle flash attachment
	["MuzzleFlashEffect"] = "tfa_muzzleflash_silenced"
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end