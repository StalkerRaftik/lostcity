if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Flash Hider"
ATTACHMENT.Description = {TFA.AttachmentColors["="], "Flash Hider"}
ATTACHMENT.Icon = "entities/flashhider.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "Flashhider"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
			["Flashhider"] = {
			["active"] = true
		}
	},
	
	["Bodygroups_V"] = {
		[2] = 1
	},
	["MuzzleAttachmentMod"] = 1,--Muzzle flash attachment
	["MuzzleFlashEffect"] = "tfa_muzzleflash_silenced"
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end