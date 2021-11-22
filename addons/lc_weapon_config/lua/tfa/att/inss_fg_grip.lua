if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Foregrip"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["+"], "60% less vertical recoil", "20% less horizontal recoil", TFA.AttachmentColors["-"], "10% lower base accuracy", "5% lower scoped accuracy", "Marginally slower movespeed" }
ATTACHMENT.Icon = "entities/ins2_att_grp.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "GRIP"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["basegrip"] = {
			["active"] = false
		},
		["foregrip_rail"] = {
			["active"] = true
		},
		["foregrip"] = {
			["active"] = true
		}
	},
	["WElements"] = {
		["basegrip"] = {
			["active"] = false
		},
		["foregrip_rail"] = {
			["active"] = true
		},
		["foregrip"] = {
			["active"] = true
		}
	},
	["Animations"] = {
		["draw"] = {
			["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
			["value"] = "foregrip_draw"
		},
		["draw_first"] = {
			["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
			["value"] = "foregrip_ready"
		},
		["draw_empty"] = {
			["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
			["value"] = "foregrip_draw_empty"
		},
		["bash"] = {
			["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
			["value"] = "foregrip_bash"
		},
		["shoot1"] = {
			["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
			["value"] = "foregrip_fire"
		},
		["shoot1_last"] = {
			["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
			["value"] = "foregrip_fire_last"
		},
		["shoot1_empty"] = {
			["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
			["value"] = "foregrip_dryfire"
		},
		["reload"] = {
			["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
			["value"] = "foregrip_reload"
		},
		["reload_empty"] = function(wep, val)
			val.type = TFA.Enum.ANIMATION_SEQ
			val.value = "foregrip_reload_empty"

			if wep:CheckVMSequence("foregrip_reloadempty") then
				val.value = "foregrip_reloadempty"
			end

			return val, true
		end,
		["reload_shotgun_start"] = {
			["type"] = TFA.Enum.ANIMATION_SEQ,
			["value"] = "foregrip_reload_start"
		},
		["reload_shotgun_finish"] = {
			["type"] = TFA.Enum.ANIMATION_SEQ,
			["value"] = "foregrip_reload_end"
		},
		["idle"] = {
			["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
			["value"] = "foregrip_idle"
		},
		["inspect"] = {
			["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
			["value"] = "foregrip_fidget"
		},
		["idle_empty"] = {
			["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
			["value"] = "foregrip_empty_idle"
		},
		["holster"] = {
			["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
			["value"] = "foregrip_holster"
		},
		["holster_empty"] = {
			["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
			["value"] = "foregrip_holster_empty"
		},
		["rof"] = {
			["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
			["value"] = "foregrip_fireselect"
		},
		["rof_is"] = {
			["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
			["value"] = "foregrip_iron_fireselect"
		},
	},
	["Primary"] = {
		["KickUp"] = function(wep,stat) return stat * 0.4 end,
		["KickDown"] = function(wep,stat) return stat * 0.4 end,
		["KickHorizontal"] = function(wep,stat) return stat * 0.8 end,
		["Spread"] = function(wep,stat) return stat * 1.1 end,
		["IronAccuracy"] = function(wep,stat) return stat * 1.05 end
	},
	["MoveSpeed"] = function(wep,stat) return stat * 0.975 end,
	["IronSightsMoveSpeed"] = function(wep,stat) return stat * 0.975 end,
	["HoldType"] = function(wep,stat)
		return "smg", true
	end,
	["SprintAnimation"] = {
		["in"] = {
			["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
			["value"] = "foregrip_sprint_in", --Number for act, String/Number for sequence
		},
		["loop"] = {
			["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
			["value"] = "foregrip_sprint_loop", --Number for act, String/Number for sequence
			["is_idle"] = true
		},
		["out"] = {
			["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
			["value"] = "foregrip_sprint_out", --Number for act, String/Number for sequence
		}
	},
	["IronAnimation"] = {
		["shoot"] = {
			["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
			["value"] = "foregrip_iron_fire", --Number for act, String/Number for sequence
			["value_empty"] = "foregrip_iron_dryfire",
		}, --What do you think
		["in"] = {
			["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
			["value"] = "foregrip_iron_in"
		},
		["loop"] = {
			["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
			["value"] = "foregrip_iron_idle", --Number for act, String/Number for sequence
			["is_idle"] = true
		}, --Looping Animation
		["out"] = {
			["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
			["value"] = "foregrip_iron_out"
		},
	},
	["PumpAction"] = function(wep,val)
		val = table.Copy(val) or {}
		val["type"] = TFA.Enum.ANIMATION_ACT --Sequence or act
		if val.value then
			val["value"] = ACT_VM_PULLBACK_LOW
		end
		if val.value_is then
			val["value_is"] = ACT_VM_PULLBACK_HIGH
		end
		return val, true, false
	end
}

function ATTACHMENT:Attach( wep )
	if TFA.Enum.ReadyStatus[wep:GetStatus()] then
		wep:ChooseIdleAnim()
		if game.SinglePlayer() then
			wep:CallOnClient("ChooseIdleAnim","")
		end
	end
end

function ATTACHMENT:Detach( wep )
	if TFA.Enum.ReadyStatus[wep:GetStatus()] then
		wep:ChooseIdleAnim()
		if game.SinglePlayer() then
			wep:CallOnClient("ChooseIdleAnim","")
		end
	end
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end