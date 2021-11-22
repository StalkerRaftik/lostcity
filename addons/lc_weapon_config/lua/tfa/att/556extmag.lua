if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "5.56 Externed Magazine"
ATTACHMENT.Description = {TFA.AttachmentColors["="], "Externed Magazine" }
ATTACHMENT.Icon = "entities/cmag.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "ext"

ATTACHMENT.WeaponTable = {
	
	["VElements"] = {
	        ["ext"] = {
		     ["active"] = true
                }
        
	},	
		["Primary"] = {
                ["ClipSize"] = function( wep, stat) return wep.Primary.ClipSize_ext or stat end,
		["MoveSpeed"] = function(wep,stat) return stat * 0.85 end				
        },
        ["MoveSpeed"] = function(wep,stat) return stat * 0.85 end	
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