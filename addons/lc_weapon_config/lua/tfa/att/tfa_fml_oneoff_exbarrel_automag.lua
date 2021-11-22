if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Extended Barrel"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {TFA.AttachmentColors["="], "Extended Barrel", TFA.AttachmentColors["+"], "20% more damage", TFA.AttachmentColors["-"], "50% more vertical recoil", "25% more horizontal recoil", TFA.AttachmentColors["-"], "Lower Movement Speed" }
ATTACHMENT.Icon = "entities/ins2_att_br_heavy.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "EStock"

ATTACHMENT.WeaponTable = {
	
	["VElements"] = {
	["Barrel 2"] = {
		["active"] = true
		},
	["Barrel"] = {
		["active"] = false
		},		
	},
		["Primary"] = {
		["Damage"] = function( wep, stat ) return stat * 1.20 end,		
		["KickUp"] = function(wep,stat) return stat * 1.5 end,
		["KickHorizontal"] = function(wep,stat) return stat * 1.25 end,
		["Spread"] = function(wep,stat) return stat * 1.2 end,
		["IronAccuracy"] = function(wep,stat) return stat * 0.75 end
	},
	["MoveSpeed"] = function(wep,stat) return stat * 0.95 end,
}

function ATTACHMENT:Attach(wep)
	wep.VElements["r6s_suppr"].pos = Vector(30, -1, 5.574)
end

function ATTACHMENT:Detach(wep)
	wep.VElements["r6s_suppr"].pos = Vector(26.704, -1, 5.574)
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end