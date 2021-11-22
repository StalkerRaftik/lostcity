if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "30 Mags"
ATTACHMENT.Description = {TFA.AttachmentColors["="], "30 Rounds Magazines" }
ATTACHMENT.Icon = "entities/ar15_30_mag.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "30"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
			["Mag"] = {
			["active"] = false
			},
			["Mag 30"] = {
			["active"] = true
			},			
		}	,
		["Primary"] = {
		        ["RPM"] = function( wep, stat) return stat - 200 end,	
		        ["Ammo"] = function( wep, stat) return wep.Primary.Ammo_Rifle or stat end,						
                ["ClipSize"] = function( wep, stat) return wep.Primary.ClipSize_30 or stat end,
				["KickUp"] = function( wep, stat ) return stat * 1.25 end,
				["Damage"] = function( wep, stat ) return stat * 1.15 end,					
				["KickHorizontal"] = function( wep, stat ) return stat * 0.25 end,				
		}	
	}

function ATTACHMENT:Attach(wep)
	wep.VElements["Mag 1"].model = "models/kali/weapons/30rd STANAG Magazine.mdl"
	wep.VElements["Mag 2"].model = "models/kali/weapons/30rd STANAG Magazine.mdl"
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