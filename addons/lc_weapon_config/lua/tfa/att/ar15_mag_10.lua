if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "50.Cal Mags"
ATTACHMENT.Description = {TFA.AttachmentColors["="], "50.Cal Magazines" }
ATTACHMENT.Icon = "entities/ar15_50_mag.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "50.Cal"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
			["Mag"] = {
			["active"] = false
			},
			["Mag 20"] = {
			["active"] = true
			},			
		}	,
		["Primary"] = {
		        ["RPM"] = function( wep, stat) return stat - 450 end,	
		        ["Ammo"] = function( wep, stat) return wep.Primary.Ammo_50cal or stat end,						
                ["ClipSize"] = function( wep, stat) return wep.Primary.ClipSize_50 or stat end,
				["Damage"] = function( wep, stat ) return stat * 3 end,
				["KickUp"] = function( wep, stat ) return stat * 1.5 end,
				["KickHorizontal"] = function( wep, stat ) return stat * 0.25 end,				
		}	
	}

function ATTACHMENT:Attach(wep)
	wep.VElements["Mag 1"].model = "models/kali/weapons/20rd STANAG Magazine.mdl"
	wep.VElements["Mag 2"].model = "models/kali/weapons/20rd STANAG Magazine.mdl"
	wep.VElements["Mag 1"].pos = Vector(0.912, 0, -0.908)
	wep.VElements["Mag 2"].pos = Vector(-0.9, 0, -4.091)
	wep:Unload()	
end

function ATTACHMENT:Detach(wep)
	wep.VElements["Mag 1"].model = "models/kali/weapons/25rd 9mm Magazine.mdl"
	wep.VElements["Mag 2"].model = "models/kali/weapons/25rd 9mm Magazine.mdl"
	wep.VElements["Mag 1"].pos = Vector(0.912, 0, -0.169)
	wep.VElements["Mag 2"].pos = Vector(-0.9, 0, -7.427)		
	wep:Unload()	
end
		
if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end