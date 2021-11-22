if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name        = "AK-74M Barrel"
ATTACHMENT.ShortName   = "Barrel"

ATTACHMENT.Icon        = "entities/rpk74m_assault_barrel.png" 

ATTACHMENT.Description = { 
TFA.AttachmentColors["+"], "+15% Accuracy", "+10% Fire Rate", "+5% Move Speed", "Increases Spread Recovery",  
TFA.AttachmentColors["-"], "-10% Damage", "-10% Range", "Increases Recoil", }

ATTACHMENT.WeaponTable = {

	["Bodygroups_V"] = {
		[1] = 1
	},
	
	["ViewModelBoneMods"] = {
		["A_Suppressor"] = { scale = Vector(0.9, 1, 0.9), pos = Vector(0.1, 3.35, 0), angle = Angle(0, 0, 0) },
	},

	["Primary"] = {
		["IronAccuracy"] = function(wep,stat) return stat * 0.85 end,
		["Spread"] = function(wep,stat) return stat * 0.85 end,
		["SpreadRecovery"] = function(wep,stat) return stat * 1.15 end,
		["RPM"] = function(wep,stat) return stat + 70 end,
		
		["Damage"] = function(wep,stat) return stat * 0.9 end,
		["Range"] = function(wep,stat) return stat * 0.9 end,
		["KickUp"] = function(wep,stat) return stat * 1.15 end,
		["KickDown"] = function(wep,stat) return stat * 1.15 end,
		["KickHorizontal"] = function(wep,stat) return stat * 1.015 end,
	},
	["MoveSpeed"] = function(wep,stat) return stat * 1.05 end,
	["IronSightsMoveSpeed"] = function(wep,stat) return stat * 1.05 end,
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end