if CLIENT then
	selectorindex =selectorindex or 1
	selectordeltaIndex = selectordeltaIndex or selectorindex
	selectorinfoAlpha = selectorinfoAlpha or 0
	selectoralpha = selectoralpha or 0
	selectoralphaDelta = selectoralphaDelta or selectoralpha
	selectorfadeTime = selectorfadeTime or 0
	local weaponInfo = {
		"Author",
		"Contact",
		"Purpose",
		"Instructions"
	}

	function selectoronIndexChanged()
		selectoralpha = 1
		selectorfadeTime = CurTime() + 5

		local weapon = LocalPlayer():GetWeapons()[selectorindex]

		selectormarkup = nil

		if (IsValid(weapon)) then
			local text = ""

			-- for k, v in ipairs(weaponInfo) do
			-- 	if (weapon[v] and weapon[v]:find("%S")) then
			-- 		local color = color_white

			-- 		text = text.."<font=font_base_24><color=255,255,255"..v.."</font></color>\n"..weapon[v].."\n"
			-- 	end
			-- end

			if (text != "") then
				selectormarkup = markup.Parse("<font=font_base_24>"..text, ScrW() * 0.3)
				selectorinfoAlpha = 0
			end

			local source, pitch = hook.Run("WeaponCycleSound") or "common/talk.wav"

			LocalPlayer():EmitSound(source or "common/talk.wav", 50, pitch or 180)
		end
	end

	hook.Add('PlayerBindPress', function(client, bind, pressed)
		local weapon = client:GetActiveWeapon()

		if (!client:InVehicle() and (!IsValid(weapon) or weapon:GetClass() != "weapon_physgun" or !client:KeyDown(IN_ATTACK))) then
			bind = bind:lower()

			if (bind:find("invprev") and pressed) then
				selectorindex = selectorindex + 1

				if (selectorindex < 1) then
					selectorindex = #client:GetWeapons()
				end

				selectoronIndexChanged()

				return true
			elseif (bind:find("invnext") and pressed) then
				selectorindex = selectorindex - 1

				if (selectorindex < 1) then
					selectorindex = 1
				end

				selectoronIndexChanged()

				return true
			elseif (bind:find("slot")) then
				selectorindex = math.Clamp(tonumber(bind:match("slot(%d)")) or 1, 1, #LocalPlayer():GetWeapons())
				selectoronIndexChanged()

				return true
			elseif (bind:find("attack") and pressed and selectoralpha > 0) then
				LocalPlayer():EmitSound(hook.Run("WeaponSelectSound", LocalPlayer():GetWeapons()[selectorindex]) or "buttons/button16.wav")

				RunConsoleCommand("kiry_selectweapon", selectorindex)
				selectoralpha = 0

				return true
			end
		end
	end)

	hook.Add('HUDPaint', function()
		local frameTime = FrameTime()

		selectoralphaDelta = Lerp(frameTime * 10, selectoralphaDelta, selectoralpha)

		local fraction = selectoralphaDelta

		if (fraction > 0) then
			local weapons = LocalPlayer():GetWeapons()
			local total = #weapons
			local x, y = ScrW() * 0.5, ScrH() * 0.5
			local spacing = math.pi * 0.85
			local radius = 240 * selectoralphaDelta

			selectordeltaIndex = Lerp(frameTime * 12, selectordeltaIndex, selectorindex) --math.Approach(selectordeltaIndex, selectorindex, fTime() * 12)

			local index = selectordeltaIndex
			
			for k, v in ipairs(weapons) do
				if (!weapons[selectorindex]) then
					selectorindex = total
				end

				local theta = (k - index) * 0.1
				local color = ColorAlpha(k == selectorindex and color_white or color_white, (255 - math.abs(theta * 3) * 255) * fraction)
				local lastY = 0
				local shiftX = ScrW()*.02

				if (selectormarkup and k < selectorindex) then
					local w, h = selectormarkup:Size()

					lastY = (h * fraction)

					if (k == selectorindex - 1) then
						selectorinfoAlpha = Lerp(frameTime * 3, selectorinfoAlpha, 255)

						selectormarkup:Draw(x + 5 + shiftX, y + 30, 0, 0, selectorinfoAlpha * fraction)
					end
				end

				surface.SetFont("font_base_24")
				local tx, ty = surface.GetTextSize(v:GetPrintName():upper())
				local scale = (1 - math.abs(theta*2))

				local matrix = Matrix()
				matrix:Translate(Vector(
					shiftX + x + math.cos(theta * spacing + math.pi) * radius + radius,
					y + lastY + math.sin(theta * spacing + math.pi) * radius - ty/2 ,
					1))
				matrix:Rotate(angle or Angle(0, 0, 0))
				matrix:Scale(Vector(1, 1, 0) * scale)

				cam.PushModelMatrix(matrix)
					draw.SimpleText(v:GetPrintName():upper(),"font_base_24",2,ty/2-1,Color(0,0,0,255*fraction),0,1)
					draw.SimpleText(v:GetPrintName():upper(),"font_base_24",2,ty/2,color,0,1)
				cam.PopModelMatrix()
			end

			if (selectorfadeTime < CurTime() and selectoralpha > 0) then
				selectoralpha = 0
			end
		end
	end)
else
	concommand.Add("kiry_selectweapon", function(client, command, arguments)
		local index = tonumber(arguments[1]) or 1
		local weapon = client:GetWeapons()[index]

		if (IsValid(weapon)) then
			client:SelectWeapon(weapon:GetClass())
		end
	end)


	util.AddNetworkString("PlayerStartChatting")
	util.AddNetworkString("PlayerFinishChatting")

	net.Receive("PlayerStartChatting", function(len, ply)
		ply:SetNVar('Typing', true, NETWORK_PROTOCOL_PUBLIC)
	end)
	net.Receive("PlayerFinishChatting", function(len, ply)
		ply:SetNVar('Typing', nil, NETWORK_PROTOCOL_PUBLIC)
	end)

end