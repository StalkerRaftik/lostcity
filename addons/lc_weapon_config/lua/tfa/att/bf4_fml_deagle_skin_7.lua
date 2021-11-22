if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Urban [Skin]"
ATTACHMENT.ShortName = "" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.Attachments.Colors["="], "" }
ATTACHMENT.Icon = "entities/blank.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.WeaponTable = {
}

function ATTACHMENT:Attach(wep)
	wep.VElements["Mag Auto"].skin = 7
	wep.VElements["Mag"].skin = 7
	wep.VElements["Gun"].skin = 7
	wep.VElements["Slide"].skin = 7
end

function ATTACHMENT:Detach(wep)
	wep.VElements["Mag Auto"].skin = 0
	wep.VElements["Mag"].skin = 0
	wep.VElements["Gun"].skin = 0
	wep.VElements["Slide"].skin = 0	
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
