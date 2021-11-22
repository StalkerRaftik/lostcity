if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "M604 Conversion"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {TFA.AttachmentColors["="], "M604 Conversion"}
ATTACHMENT.Icon = "entities/ar15_m604.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "M604"

ATTACHMENT.WeaponTable = {
	
	["VElements"] = {
	["Barrel 640"] = {
		["active"] = true
		},
	["Barrel"] = {
		["active"] = false
		},		
	},
		["Primary"] = {
		["Damage"] = function( wep, stat ) return stat * 1.15 end,		
		["KickUp"] = function(wep,stat) return stat * 1.5 end,
		["KickHorizontal"] = function(wep,stat) return stat * 1.25 end,
		["Spread"] = function(wep,stat) return stat * 0.85 end,
		["IronAccuracy"] = function(wep,stat) return stat * 0.75 end
	},
	["MoveSpeed"] = function(wep,stat) return stat * 0.95 end,
}

function ATTACHMENT:Attach(wep)
	wep.VElements["r6s_suppr"].pos = Vector(0, -28.236, 1.187)
end

function ATTACHMENT:Detach(wep)
	wep.VElements["r6s_suppr"].pos = Vector(0, -20.63, 1.187)
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end