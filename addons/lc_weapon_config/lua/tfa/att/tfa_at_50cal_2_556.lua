if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "556 Mags"
ATTACHMENT.Description = {TFA.AttachmentColors["="], "556 Magazines"}
ATTACHMENT.Icon = "entities/r6s dmr round.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "556"

ATTACHMENT.WeaponTable = {
		["Primary"] = {
				["RPM"] = function( wep, stat) return 750, true end,
				["Damage"] = function( wep, stat ) return stat * 0.5 end,		
                ["ClipSize"] = function( wep, stat) return 40, true end,
				["KickUp"] = function( wep, stat ) return stat * 0.6 end,
				["KickHorizontal"] = function( wep, stat ) return stat * 0.5 end,				
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