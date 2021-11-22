if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Anti-Tank Rocket"
ATTACHMENT.Description = {TFA.AttachmentColors["+"], "Stronger Rocket Explosion", TFA.AttachmentColors["-"], "Lower Explosion Radius"}
ATTACHMENT.Icon = "entities/tfa_anti_tank_rocket.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "Anti-Tank UwU"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Projectile"] = "tfa_anti_tank",
	},
        ["Skin"] = 1,
}

function ATTACHMENT:Attach(wep)
        wep:SetSkin(1)
end

function ATTACHMENT:Detach(wep)
        wep:SetSkin(0)
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end