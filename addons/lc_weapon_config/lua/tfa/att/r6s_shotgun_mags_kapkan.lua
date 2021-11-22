if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Shotgun Mags"
ATTACHMENT.Description = {TFA.AttachmentColors["="], "Shotgun Magazines", TFA.AttachmentColors["+"],"Shoot Shotgun Shells",TFA.AttachmentColors["+"], "Less Horizontal Spread",TFA.AttachmentColors["-"],"Less Ammo", TFA.AttachmentColors["-"],"More Vertical Spread"}
ATTACHMENT.Icon = "entities/r6s dmr round.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "SG"

ATTACHMENT.WeaponTable = {
		["Primary"] = {
		        ["RPM"] = function( wep, stat) return wep.Primary.RPM_SG or stat end,
                ["ClipSize"] = function( wep, stat) return wep.Primary.ClipSize_SG or stat end,
				["Damage"] = function( wep, stat ) return wep.Primary.Damage_SG or stat end,
				["NumShots"] = function( wep, stat ) return stat * 10 end,				
				["KickUp"] = function( wep, stat ) return stat * 2.5 end,
				["KickHorizontal"] = function( wep, stat ) return stat * 0.75 end,	
				["Spread"] = function( wep, stat ) return stat * 2 end,	
				["IronAccuracy"] = function( wep, stat ) return wep.Primary.IronAccuracy_SG end,						
		}	
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