if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Drum Mags"
ATTACHMENT.Description = {TFA.AttachmentColors["="], "Drum Magazines",TFA.AttachmentColors["+"],"Infinite Ammo"}
ATTACHMENT.Icon = "entities/r6s ex mag.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "Ext"

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
		["Mag"] = {
			["active"] = false
		},
		["Mag Drum"] = {
			["active"] = true
		},
		["Patriot"] = {
			["active"] = true
		}		
	},
		["Primary"] = {
				["ClipSize"] = function( wep, stat ) return -1, true end,	
				["KickUp"] = function( wep, stat ) return stat * 1.25 end,
				["KickHorizontal"] = function( wep, stat ) return stat * 2 end,		
				},	
	["MoveSpeed"] = function(wep,stat) return stat * 0.8 end,
	["IronSightsMoveSpeed"] = function(wep,stat) return stat * 0.8 end,	
	["ViewModelBoneMods"] = function(wep,tbl)
		if wep.DrumBoneMods then
			wep.GripFactor = wep.GripFactor or 0
			local CanGrip = true
			if wep.GripBadActivities and wep.GripBadActivities[ wep:GetLastActivity() ] and wep:VMIV() then
				local cyc = wep.OwnerViewModel:GetCycle()
				if cyc > wep.GripBadActivities[ wep:GetLastActivity() ][1] and cyc < wep.GripBadActivities[ wep:GetLastActivity() ][2] then
					CanGrip = false
				end
			end
			wep.GripFactor = math.Approach( wep.GripFactor, CanGrip and 1 or 0, ( ( CanGrip and 1 or 0 ) - wep.GripFactor ) * TFA.FrameTime() * ( wep.GripLerpSpeed or 20 ) )
			return LerpBoneMods( wep.GripFactor, tbl, wep.DrumBoneMods )
		end
end		
}
	
	
function ATTACHMENT:Attach(wep)
	wep.VElements["Mag 20"].pos = Vector(-30, -30, -30)	
	wep.VElements["Mag 32"].pos = Vector(-30, -30, -30)	
	wep.VElements["Mag 30"].pos = Vector(-30, -30, -30)		
	wep:Unload()	
end

function ATTACHMENT:Detach(wep)
	wep.VElements["Mag 20"].pos = Vector(0.912, 0, -1.178)	
	wep.VElements["Mag 30"].pos = Vector(0.912, 0, -1.178)	
	wep.VElements["Mag 32"].pos = Vector(0.912, 0, -0.169)	
	wep:Unload()	
end
		
if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end