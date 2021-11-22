if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Double Barrel"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {TFA.AttachmentColors["="], "Double Barrel Rifle"}
ATTACHMENT.Icon = "entities/ins2_att_br_heavy.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "DBR"

local defaultbl = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }

local function LerpBoneMods( t, b1, b2 )
	local tbl = table.Copy(b1)
	for k,v in pairs(b2) do
		if not tbl[k] then
			tbl[k] = table.Copy(defaultbl)
		end
		tbl[k].scale = LerpVector( t, tbl[k].scale, v.scale )
		tbl[k].pos = LerpVector( t, tbl[k].pos, v.pos )
		tbl[k].angle = LerpAngle( t, tbl[k].angle, v.angle )
	end
	return tbl
end

ATTACHMENT.WeaponTable = {
	
	["VElements"] = {
	["Mag D2"] = {
		["active"] = true
		},
	["Mag D1"] = {
		["active"] = true
		},		
	["Barrel Double"] = {
		["active"] = true
		},	
	["Barrel 1"] = {
		["active"] = true
		},			
	["Barrel"] = {
		["active"] = false
		},		
	},
		["Primary"] = {	
		["Damage"] = function( wep, stat ) return stat * 1.15 end,					
		["RPM"] = function( wep, stat) return stat - 200 end,			
		["Ammo"] = function( wep, stat) return wep.Primary.Ammo_Rifle or stat end,								
        ["ClipSize"] = function( wep, stat) return wep.Primary.ClipSize_60 or stat end,		
		["KickUp"] = function(wep,stat) return stat * 2 end,
		["NumShots"] = function(wep,stat) return stat * 2 end,
		["AmmoConsumption"] = function(wep,stat) return stat * 2 end,		
		["KickHorizontal"] = function(wep,stat) return stat * 2 end,
		["Spread"] = function(wep,stat) return stat * 1.25 end,
		["IronAccuracy"] = function(wep,stat) return stat * 0.75 end
	},
	["MoveSpeed"] = function(wep,stat) return stat * 0.85 end,
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
	},	

	["ViewModelBoneMods"] = function(wep,tbl)
		if wep.DBRBoneMods then
			wep.GripFactor = wep.GripFactor or 0
			local CanGrip = true
			if wep.GripBadActivities and wep.GripBadActivities[ wep:GetLastActivity() ] and wep:VMIV() then
				local cyc = wep.OwnerViewModel:GetCycle()
				if cyc > wep.GripBadActivities[ wep:GetLastActivity() ][1] and cyc < wep.GripBadActivities[ wep:GetLastActivity() ][2] then
					CanGrip = false
				end
			end
			wep.GripFactor = math.Approach( wep.GripFactor, CanGrip and 1 or 0, ( ( CanGrip and 1 or 0 ) - wep.GripFactor ) * TFA.FrameTime() * ( wep.GripLerpSpeed or 20 ) )
			return LerpBoneMods( wep.GripFactor, tbl, wep.DBRBoneMods )
		end
end		
	
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