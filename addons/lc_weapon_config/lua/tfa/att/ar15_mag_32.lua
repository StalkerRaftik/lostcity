if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "32 Mags"
ATTACHMENT.Description = {TFA.AttachmentColors["="], "32 Rounds Magazines" }
ATTACHMENT.Icon = "entities/ar15_32_mag.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "32"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
			["Mag"] = {
			["active"] = false
			},
			["Mag 32"] = {
			["active"] = true
			},			
		}	,
		["Primary"] = {
		        ["RPM"] = function( wep, stat) return stat - 50 end,		
                ["ClipSize"] = function( wep, stat) return wep.Primary.ClipSize_32 or stat end,
				["KickUp"] = function( wep, stat ) return stat * 1.25 end,
				["KickHorizontal"] = function( wep, stat ) return stat * 0.25 end,				
		}	
	}

function ATTACHMENT:Attach(wep)
	wep.VElements["Mag 1"].model = "models/kali/weapons/32rd 9mm Magazine.mdl"
	wep.VElements["Mag 2"].model = "models/kali/weapons/32rd 9mm Magazine.mdl"
	wep:Unload()	
end

function ATTACHMENT:Detach(wep)
	wep.VElements["Mag 1"].model = "models/kali/weapons/25rd 9mm Magazine.mdl"
	wep.VElements["Mag 2"].model = "models/kali/weapons/25rd 9mm Magazine.mdl"
	wep:Unload()	
end
		
if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end