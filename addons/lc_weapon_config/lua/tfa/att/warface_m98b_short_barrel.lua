if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Short Barrel"
ATTACHMENT.ShortName = "Short"

ATTACHMENT.Icon = "entities/warface_m98b_short_barrel.png" 

ATTACHMENT.Description = { 
TFA.AttachmentColors["+"], "+5% Move Speed", "+10% Aim Move Speed", "Increases Fire Rate", "Decreases Aim Time", "Increases Spread Recovery",  
TFA.AttachmentColors["-"], "-15% Damage", "-15% Range", "+5% Spread", "+5% Aim Spread",
}

ATTACHMENT.WeaponTable = {

	["Bodygroups_V"] = {
		[2] = 1
	},
	
	["Bodygroups_W"] = {
		[1] = 1
	},
	
	["ViewModelBoneMods"] = {
		["A_Muzzle"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, -9), angle = Angle(0, 0, 0) },
		["A_Suppressor"] = { scale = Vector(1.07, 1.07, 1.07), pos = Vector(0, 0, -9), angle = Angle(0, 0, 0) },
    },
	
    ["WorldModelBoneMods"] = {
		["ATTACH_Muzzle"] = { scale = Vector(1, 1, 1), pos = Vector(-10, 0.1, -0.3), angle = Angle(0, 0, 0) },
	},
	
	["Primary"] = {
		["IronAccuracy"] = function(wep,stat) return stat * 1.05 end,
		["Spread"] = function(wep,stat) return stat * 1.1 end,
		["SpreadRecovery"] = function(wep,stat) return stat * 1.15 end,
		
		["Damage"] = function(wep,stat) return stat * 0.85 end,
		["Range"] = function(wep,stat) return stat * 0.85 end,
	   ["RPM"] = function(wep,stat) return stat + 7 end,
	},
	
	["MoveSpeed"] = function(wep,stat) return stat * 1.05 end,
	["IronSightsMoveSpeed"] = function(wep,stat) return stat * 1.1 end,
	["IronSightTime"] = function(wep, val) return val * 0.9 end,
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