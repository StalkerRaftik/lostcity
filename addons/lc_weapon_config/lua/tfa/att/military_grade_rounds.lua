if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Military Grade Rounds"
ATTACHMENT.ShortName = "MGR" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["+"], "In Soviet Russia, Military Uses Incendiary Rounds"}
ATTACHMENT.Icon = "entities/tfa_ammo_match.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["DamageType"] = function(wep,stat) return bit.bor( stat or 0, DMG_BURN ) end
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
