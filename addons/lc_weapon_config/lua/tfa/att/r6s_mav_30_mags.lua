if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "30 Mags"
ATTACHMENT.Description = {TFA.AttachmentColors["="], "30 Rounds Magazines" }
ATTACHMENT.Icon = "entities/r6s dmr round.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "3RM"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["Mag 30"] = {
			["active"] = true
		},
		["Mag"] = {
			["active"] = false
		},
	},
		["Primary"] = {
				["RPM"] = function( wep, stat) return 750, true end,		
				["Damage"] = function( wep, stat ) return stat * 0.70 end,		
                ["ClipSize"] = function( wep, stat) return 30, true end,
				["KickUp"] = function( wep, stat ) return stat * 0.5 end,
				["KickHorizontal"] = function( wep, stat ) return stat * 0.25 end,				
		},
			["FireModes"] = {"Automatic"},
	}

function ATTACHMENT:Attach(wep)
	wep:Unload()
	wep.Primary.Automatic = true
end

function ATTACHMENT:Detach(wep)
	wep:Unload()
	wep.Primary.Automatic = false
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end