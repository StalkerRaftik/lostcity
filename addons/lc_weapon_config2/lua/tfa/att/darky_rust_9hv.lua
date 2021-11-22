if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "HV Pistol Ammo"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {
	TFA.AttachmentColors["="], "This ammunition travels faster, resulting in less drop and slightly higher damage when fired over long distances.",
	TFA.AttachmentColors["+"], "33% more velocity",
}

ATTACHMENT.Icon = "entities/ammo.pistol.hv.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "HV"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Range"] = function(wep,stat) return stat*1.333 end,
		["RangeFalloff"] = function(wep,stat) return stat*1.333 end,
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
