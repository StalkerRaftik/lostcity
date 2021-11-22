BatteryRate = 0.33


if not SERVER then return end


local FlashlightTimer = 0
hook.Add("Think", "FlashlightUpdate", function()
	if FlashlightTimer > CurTime() then return end
	FlashlightTimer = CurTime() + 2

	for k,ply in pairs(player.GetAll()) do
		if !ply.inv then continue end

		if rp.cfg.devmode then 
			if not ply:CanUseFlashlight() then
				ply:AllowFlashlight(true)
			end
			return
		end

		if not (ply:GetNVar('CharSelected') == true) then continue end
		if ply.inv and ply.inv[INV_ENTITY] and ply.inv[INV_ENTITY]["flashlight"] == nil then
			if ply:CanUseFlashlight() then
				ply:Flashlight(false)
				ply:AllowFlashlight(false)
			end
			continue 
		end

		local flashlight
		if ply.inv[INV_ENTITY] and ply.inv[INV_ENTITY]["flashlight"] then
			for k,v in pairs(ply.inv[INV_ENTITY]["flashlight"]) do
				if not v.power then
					v.power = 0
				end
				if v.power > 0 then
					flashlight = v
					break 
				end
			end
		end

		if ply:CanUseFlashlight() and not flashlight then
			ply:Flashlight(false)
			ply:AllowFlashlight(false)
		elseif not ply:CanUseFlashlight() and flashlight and flashlight.power > 0 then
			ply:AllowFlashlight(true)
		end

		if ply:FlashlightIsOn() then
			flashlight.power = math.Clamp(flashlight.power - BatteryRate, 0, 100)
			ply:UpdateInventory()
		end
	end
end)