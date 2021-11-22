TFA.INS2 = TFA.INS2 or {}

local function SightRenderOverride(wep, ent, idleseqname, zoomseqname)
	if not IsValid(wep) or not IsValid(ent) or not idleseqname or not zoomseqname then return end
	local idleseq, zoomseq = ent:LookupSequence(idleseqname), ent:LookupSequence(zoomseqname)
	if idleseq == -1 or zoomseq == -1 then return end

	local progress = wep.CLIronSightsProgress or 0
	if wep:IronSights() then
		ent:SetSequence(zoomseq)
		ent:SetCycle(progress)
	else
		ent:SetSequence(idleseq)
		ent:SetCycle(1 - progress)
	end
end

function TFA.INS2.AnimateSight(wep)
	local activeelem = wep:GetStat("INS2_SightVElement")

	if activeelem and wep.VElements[activeelem] then
		wep.StatCache_Blacklist["VElements." .. activeelem .. ".active"] = true
		wep.StatCache_Blacklist["VElements." .. activeelem .. ".curmodel"] = true -- JUST TO MAKE SURE IT FUCKING WORKS

		local ent = wep:GetStat("VElements." .. activeelem .. ".curmodel")
		local idleseqname = wep:GetStat("VElements." .. activeelem .. ".ins2_sightanim_idle")
		local zoomseqname = wep:GetStat("VElements." .. activeelem .. ".ins2_sightanim_iron")

		if ent and idleseqname and zoomseqname then -- isvalid check is in line 4 so dont worry
			SightRenderOverride(wep, ent, idleseqname, zoomseqname)
		end
	end
end

--[[
	To use these animations on your sight, you need to add "ins2_sightanim_idle" and "ins2_sightanim_iron" sequence names to your VElement and add its name to the "INS2_SightVElement" value in WeaponTable.
	
	Example WeaponTable:
	ATTACHMENT.WeaponTable = {
		["VElements"] = {
			["sight_eotech"] = {
				["active"] = function(wep, val) TFA.INS2.AnimateSight(wep) return true end, -- runs the animation think function (it has statcache blacklist, so if you want to add custom functions like this just look above for an example)
				["ins2_sightanim_idle"] = "idle", -- sight idle animation (unscoped)
				["ins2_sightanim_iron"] = "zoom", -- sight zoom animation - starts playing right when player aims down sights
			},
		},
		["INS2_SightVElement"] = "sight_eotech", -- the name of the VElement
	}
]]