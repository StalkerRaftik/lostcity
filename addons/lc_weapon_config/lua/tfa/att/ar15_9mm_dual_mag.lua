if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Dual Mags"
ATTACHMENT.Description = {TFA.AttachmentColors["="], "Two Magazines Together",TFA.AttachmentColors["+"],"Faster Alternate Reloads"}
ATTACHMENT.Icon = "entities/ar15_dual_mag.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "DUALMAGS"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
			["Mag"] = {
			["active"] = false
			},
			["Mag 20"] = {
			["active"] = false
			},			
			["Mag 32"] = {
			["active"] = false
			},	
			["Mag 30"] = {
			["active"] = false
			},			
			["Mag 1"] = {
			["active"] = true
			},
			["Mag 2"] = {
			["active"] = true
			}				
		}	,
	["Animations"] = {
		--[[
		["reload_silenced"] = {
			["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
			["value"] = "reload_dm_quick"
		},
		]]--
		["reload"] = {
			["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
			["value"] = "reload_dm_tac"
		},
		["reload_empty"] = {
			["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
			["value"] = "reload_dm_empty"
		},
		["reload_quick"] = {
			["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
			["value"] = "reload_dm_quick"
		},
		["reload_quick_empty"] = {
			["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
			["value"] = "reload_dm_quick_empty"
		}
	}
}

function ATTACHMENT:Attach(wep)
	--Reload func override
	if IsValid(wep) then
		wep:SetNW2Bool("DMLongReload", false )
	end
	wep.ReloadOldDM = wep.ReloadOldDM or wep.Reload
	wep.Reload = function( myself, ... )
		if not myself.ReloadOldDM then return end
		local israel = myself:GetStatus() == TFA.GetStatus("reloading")
		local v1, v2, v3 = myself.ReloadOldDM( myself, ... )
		if myself:GetStatus() == TFA.GetStatus("reloading") and not israel then
			--Toggle our dual mag thingy
			myself:SetNW2Bool("DMLongReload", not myself:GetNW2Bool("DMLongReload") )
		end
		return v1, v2, v3
	end
	--Reload anim func override
	wep.ChooseReloadAnimOldDM = wep.ChooseReloadAnimOldDM or wep.ChooseReloadAnim
	wep.ChooseReloadAnim = function(myself, ... )
		if not myself:GetNW2Bool("DMLongReload") then
			if myself:Clip1() == 0 then
				typev, tanim = myself:ChooseAnimation( "reload_quick_empty" )
			else
				typev, tanim = myself:ChooseAnimation( "reload_quick" )
			end

			myself.AnimCycle = 0

			if typev ~= TFA.Enum.ANIMATION_SEQ then
				return myself:SendViewModelAnim(tanim)
			else
				return myself:SendViewModelSeq(tanim)
			end
		end
		if myself.ChooseReloadAnimOldDM then
			return myself.ChooseReloadAnimOldDM( myself, ... )
		end
	end
	wep.VElements["Mag 20"].pos = Vector(-30, -30, -30)	
	wep.VElements["Mag 32"].pos = Vector(-30, -30, -30)	
	wep.VElements["Mag 30"].pos = Vector(-30, -30, -30)		
end

function ATTACHMENT:Detach(wep)
	--Restore reload func override
	wep.Reload = wep.ReloadOldDM or wep.Reload
	wep.ReloadOldDM = nil
	--Restore reload animation selection code override
	wep.ChooseReloadAnim = wep.ChooseReloadAnimOldDM or wep.ChooseReloadAnim
	wep.ChooseReloadAnimOldDM = nil	
	wep.VElements["Mag 20"].pos = Vector(0.912, 0, -1.178)	
	wep.VElements["Mag 30"].pos = Vector(0.912, 0, -1.178)	
	wep.VElements["Mag 32"].pos = Vector(0.912, 0, -0.169)		
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end