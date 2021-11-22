if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Bayonet"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {TFA.AttachmentColors["+"], "Can stab"}
ATTACHMENT.Icon = "entities/blast_m1garand_bayonet.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "Bayonet"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["bayonet"] = {
			["active"] = true
		}
		},
	["WElements"] = {
		["bayonet"] = {
			["active"] = true
		}
		},	
	["MoveSpeed"] = function( wep, val) return val * 0.98 end,
	["IronSightsMovespeed"] = function( wep, val) return val * 0.98 end,
	["Secondary"] = {
		["CanBash"] = true
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end