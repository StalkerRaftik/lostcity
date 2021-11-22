if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Point Shooting"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["+"], "Tilt weapon to side to aim." }
ATTACHMENT.Icon = "entities/inss_si_slanted.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "SLN"

ATTACHMENT.WeaponTable = {
	["IronSightsPos"] = function( wep, val ) return wep.IronSightsPos_Slanted or val end,
	["IronSightsAng"] = function( wep, val ) return wep.IronSightsAng_Slanted or val end,
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
