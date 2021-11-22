if SERVER then return end
zlm = zlm or {}
zlm.f = zlm.f or {}

local icon_enabled = false
local icon_pos = Vector(0,0,0)

local zlm_LastThink = -1

-- hook.Add("Think", "zlm_Think_Indicator", function()
-- 	if zlm_LastThink < CurTime() then

-- 		if LocalPlayer():GetNWBool("zlm_InTractor") then

-- 			if LocalPlayer():GetNWBool("zlm_HasTrailer") then

-- 				for k, v in pairs(ents.FindInSphere(LocalPlayer():GetPos(), zlm.config.NPC.SellDistance)) do
-- 					if IsValid(v) and v:GetClass() == "zlm_buyer_npc" then
-- 						icon_enabled = true
-- 						icon_pos = v:GetPos() + v:GetUp() * 55
-- 						break
-- 					end
-- 				end
-- 			else
-- 				icon_enabled = false
-- 			end
-- 		else
-- 			icon_enabled = false
-- 		end

-- 		zlm_LastThink = CurTime() + 1
-- 	end
-- end)

-- function zlm.f.SellIndicator()
-- 	local ply = LocalPlayer()

-- 	if IsValid(ply) and ply:Alive() and icon_enabled and zlm.f.InDistance(icon_pos, LocalPlayer():GetPos(), zlm.config.NPC.SellDistance) then
-- 		local pos = icon_pos:ToScreen()
-- 		draw.DrawText(zlm.language.General["SellGrass"] .. ": [ " .. string.upper(language.GetPhrase(input.GetKeyName(zlm.config.LawnMower.Keys.Unload))) .. " ]", "zlm_font01", pos.x, pos.y + 5, zlm.default_colors["white01"], TEXT_ALIGN_CENTER)
-- 	end
-- end


-- hook.Add("HUDPaint", "zlm_HUDPaint_SellIndicator", zlm.f.SellIndicator)
