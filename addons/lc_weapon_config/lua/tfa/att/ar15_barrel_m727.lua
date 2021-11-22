if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "M727 Conversion"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {TFA.AttachmentColors["="], "M727 Conversion"}
ATTACHMENT.Icon = "entities/ar15_m727.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "M604"

ATTACHMENT.WeaponTable = {
	
	["VElements"] = {
	["Barrel M727"] = {
		["active"] = true
		},
	["Barrel"] = {
		["active"] = false
		},		
	},
		["Primary"] = {
		["Damage"] = function( wep, stat ) return stat * 1.05 end,		
		["KickUp"] = function(wep,stat) return stat * 1.15 end,
		["KickHorizontal"] = function(wep,stat) return stat * 1.75 end,
		["Spread"] = function(wep,stat) return stat * 0.95 end,
		["IronAccuracy"] = function(wep,stat) return stat * 1.15 end
	},
	["MoveSpeed"] = function(wep,stat) return stat * 0.925 end,
}

function ATTACHMENT:Attach(wep)
	wep.VElements["r6s_suppr"].pos = Vector(0, -20.593, 1.187)
end

function ATTACHMENT:Detach(wep)
	wep.VElements["r6s_suppr"].pos = Vector(0, -20.63, 1.187)
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end