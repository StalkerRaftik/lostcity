if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name        = "Folded Stock"
ATTACHMENT.ShortName   = "Fold"

ATTACHMENT.Icon        = "entities/warface_bt_mp9_folded_stock.png" 

ATTACHMENT.Description = { 
    TFA.AttachmentColors["+"], "5% higher move speed", 
    TFA.AttachmentColors["+"], "5% higher aiming move speed", 
    TFA.AttachmentColors["+"], "15% lower aiming time", 
    TFA.AttachmentColors["-"], "10% higher recoil", 
    TFA.AttachmentColors["-"], "10% higher spread", 
    TFA.AttachmentColors["-"], "10% higher max spread", 
}

ATTACHMENT.WeaponTable = {

	["Bodygroups_V"] = {
		[1] = 1
	},
	
	["Primary"] = {
		["Spread"] = function(wep,stat) return math.max( stat * 1.1, stat - 0.01 ) end,
		["SpreadMultiplierMax"] = function(wep,stat) return stat * ( 1 / 0.8 ) * 1.1 end,
		["KickUp"] = function(wep,stat) return stat * 1.1 end,
		["KickDown"] = function(wep,stat) return stat * 1.1 end,
		["KickHorizontal"] = function(wep,stat) return stat * 1.1 end,
	},
	
	["MoveSpeed"] = function(wep,stat) return stat * 1.05 end,
	["IronSightsMoveSpeed"] = function(wep,stat) return stat * 1.05 end,
	["IronSightTime"] = function(wep, val) return val * 0.85 end,
}

function ATTACHMENT:Detach(wep)
	if wep.ViewModelKitOld then
		wep.ViewModel = wep.ViewModelKitOld
		if IsValid(wep.OwnerViewModel) then
			wep.OwnerViewModel:SetModel(wep.ViewModel)
			timer.Simple(0, function()
				wep:SendViewModelAnim(ACT_VM_IDLE)
			end)
		end
		wep.ViewModelKitOld = nil
	end
	if wep.WorldModelKitOld then
		wep.WorldModel = wep.WorldModelKitOld
		wep:SetModel(wep.WorldModel)
		wep.ViewModelKitOld = nil
	end
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
