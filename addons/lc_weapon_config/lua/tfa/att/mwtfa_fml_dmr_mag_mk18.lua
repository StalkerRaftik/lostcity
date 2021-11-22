if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = ".458 SOCOM Mags"
ATTACHMENT.Description = {TFA.AttachmentColors["="], "10 Round Magazines"}
ATTACHMENT.Icon = "entities/ins2_att_mag_ext_rifle_30rd.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = ".458"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
        ["Sound"] = function( wep, stat) return wep.Primary.Sound_DMR or stat end,
		["RPM"] = function( wep, stat) return stat - 400 end,		
        ["ClipSize"] = function( wep, stat) return wep.Primary.ClipSize_20 or stat end,			
		["KickUp"] = function(wep,stat) return stat * 1.75 end,
		["KickDown"] = function(wep,stat) return stat * 0.15 end,
		["KickHorizontal"] = function(wep,stat) return stat * 0.65 end,
		["Spread"] = function(wep,stat) return stat * 0.8 end,		
		["Damage"] = function( wep, stat ) return stat * 2.8 end,		
	},	
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
