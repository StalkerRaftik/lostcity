if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Double Barrel"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {TFA.AttachmentColors["="], "Double Barrel"}
ATTACHMENT.Icon = "entities/ins2_att_br_heavy.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "DB"

ATTACHMENT.WeaponTable = {
		["Primary"] = {				
		["RPM"] = function( wep, stat) return stat - 100 end,										
        ["ClipSize"] = function( wep, stat) return (stat + 1 ) * 2 end,		
		["KickUp"] = function(wep,stat) return stat * 2 end,
		["NumShots"] = function(wep,stat) return stat * 2 end,
		["AmmoConsumption"] = function(wep,stat) return stat * 2 end,		
		["KickHorizontal"] = function(wep,stat) return stat * 2 end,
		["Spread"] = function(wep,stat) return stat * 1.25 end,
		["IronAccuracy"] = function(wep,stat) return stat * 0.75 end
	},
	["MoveSpeed"] = function(wep,stat) return stat * 0.85 end,
	
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