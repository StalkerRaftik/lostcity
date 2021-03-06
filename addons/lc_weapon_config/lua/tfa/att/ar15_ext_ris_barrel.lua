if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "RIS Extended Handguard"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["+"], "Activates Laser Sight and GL", "5% lower recoil", TFA.AttachmentColors["-"], "25% lower base accuracy", "Somewhat slower movespeed" }
ATTACHMENT.Icon = "entities/ar15_att_ris_e.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "RISE"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["basebarrel"] = {
			["active"] = false
		},
		["risextbarrel"] = {
			["active"] = true
		}
	},
	["Bodygroups_W"] = {
		[2] = 4
	},
	["ViewModelBoneMods"] = {
		["A_Suppressor"] = { scale = Vector(1.1, 1.1, 1.1), pos = Vector(0, -13, -0.1), angle = Angle(0, 180, 0) },
	},
	["WorldModelBoneMods"] = {
		["ATTACH_Muzzle"] = { scale = Vector(0.7, 0.7, 0.7), pos = Vector(14, -1.4, 0.75), angle = Angle(0, 180, 0) },
	},
	["Primary"] = {
		["KickUp"] = function(wep,stat) return stat * 0.9 end,
		["KickDown"] = function(wep,stat) return stat * 0.9 end,
		["KickHorizontal"] = function(wep,stat) return stat * 0.9 end,
		["Spread"] = function(wep,stat) return stat * 1.5 end,
	},
	["MoveSpeed"] = function(wep,stat) return stat * 0.95 end,
	["IronSightsMoveSpeed"] = function(wep,stat) return stat * 0.95 end,
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