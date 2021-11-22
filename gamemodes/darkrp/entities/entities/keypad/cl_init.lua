
-----------------------------------------------------
include("sh_init.lua")

--[[
	We are going to borrow offsets etc from Robbis_1's keypad here
]]

local X = -50
local Y = -100
local W = 100
local H = 200
local VEC_ZERO = Vector(0, 0, 0)

local color_black = Color(0,0,0)
local color_outline = Color(255,255,255)
local color_entry = Color(50, 75, 50, 255)

local KeyPos =	{
	{X+5, Y+100, 25, 25, -2.2, 3.45, 1.3, -0},
	{X+37.5, Y+100, 25, 25, -0.6, 1.85, 1.3, -0},
	{X+70, Y+100, 25, 25, 1.0, 0.25, 1.3, -0},

	{X+5, Y+132.5, 25, 25, -2.2, 3.45, 2.9, -1.6},
	{X+37.5, Y+132.5, 25, 25, -0.6, 1.85, 2.9, -1.6},
	{X+70, Y+132.5, 25, 25, 1.0, 0.25, 2.9, -1.6},

	{X+5, Y+165, 25, 25, -2.2, 3.45, 4.55, -3.3},
	{X+37.5, Y +165, 25, 25, -0.6, 1.85, 4.55, -3.3},
	{X+70, Y+165, 25, 25, 1.0, 0.25, 4.55, -3.3},

	{X+5, Y+67.5, 50, 25, -2.2, 4.7, -0.3, 1.6},
	{X+60, Y+67.5, 35, 25, 0.3, 1.65, -0.3, 1.6}
}

surface.CreateFont("Keypad", {font = "Trebuchet", size = 34, weight = 900})
surface.CreateFont("KeypadState", {font = "Trebuchet", size = 20, weight = 600})
surface.CreateFont("KeypadButton", {font = "roboto", size = 24, weight = 500})
surface.CreateFont("KeypadSButton", {font = "Trebuchet", size = 16, weight = 900})

function ENT:Draw()
	self:DrawModel()

	local ply = LocalPlayer()

	if (IsValid(ply)) then
		local distance = ply:EyePos():Distance(self:GetPos())

		if (distance <= 750) then
			local ang = self:GetPos() - ply:EyePos()
			local tr = util.TraceLine(util.GetPlayerTrace(ply, ang))

			if (tr.Entity == self) then
				local pos = self:GetPos() + self:GetForward() * 1.1
				local ang = self:GetAngles()
				local rot = Vector(-90, 90, 0)

				ang:RotateAroundAxis(ang:Right(), rot.x)
				ang:RotateAroundAxis(ang:Up(), rot.y)
				ang:RotateAroundAxis(ang:Forward(), rot.z)

				surface.SetFont("Keypad")

				cam.Start3D2D(pos, ang, 0.05)

					local tr = util.TraceLine({
						start = ply:EyePos(),
						endpos = ply:GetAimVector() * 32 + ply:EyePos(),
						filter = ply,
					})

					local pos = self:WorldToLocal(tr.HitPos)
					local status = self:GetStatus()
					local value = self:GetDisplayText() or ""

					surface.SetDrawColor(color_black)
					surface.DrawRect(X-5, Y-5, W+10, H+10)

					draw.OutlinedBox(X+5, Y+5, 90, 50, color_entry, color_outline)

					for k = 1, #KeyPos do
						local color
						local v = KeyPos[k]

						local text = k
						local textx = v[1] + 9
						local texty = v[2] + 4
						local x = (pos.y - v[5]) / (v[5] + v[6])
						local y = 1 - (pos.z + v[7]) / (v[7] + v[8])

						if (k == 10) then
							text = "ABORT"
							textx = v[1] + 2
							texty = v[2] + 4
							color =  Color(150, 25, 25, 255)
						elseif (k == 11) then
							text = "OK"
							textx = v[1] + 12
							texty = v[2] + 5
							color = Color(25, 150, 25, 255)
						else
							color = Color(150, 150, 150, 255)
						end

						if(tr.Entity == self and x >= 0 and y >= 0 and x <= 1 and y <= 1) then
							if (k <= 9) then
								color = Color(200, 200, 200, 255)
							elseif (k == 10) then
								color = Color(200, 50, 50, 255)
							elseif (k == 11) then
								color = Color(50, 200, 50, 255)
							end

							if(ply:KeyDown(IN_USE) and not ply.KeyPadCool) then
								if (k <= 9) then
									net.Start("keypad_command")
										net.WriteEntity(self)
										net.WriteUInt(self.Command_Enter, 3)
										net.WriteUInt(k, 4)
									net.SendToServer()
								elseif (k == 10) then
									net.Start("keypad_command")
										net.WriteEntity(self)
										net.WriteUInt(self.Command_Reset, 3)
									net.SendToServer()
								elseif (k == 11) then
									net.Start("keypad_command")
										net.WriteEntity(self)
										net.WriteUInt(self.Command_Accept, 3)
									net.SendToServer()
								end

								ply.KeyPadCool = true
							end
						end

						draw.OutlinedBox(v[1], v[2], v[3], v[4], color, color_outline)

						if (k == 10) then
							draw.SimpleText(text, "KeypadSButton", v[1] + v[3] / 2, v[2] + v[4] / 2, Color(20, 20, 20, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
						else
							draw.SimpleText(text, "KeypadButton", v[1] + v[3] / 2, v[2] + v[4] / 2, Color(20, 20, 20, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
						end
					end

					surface.SetFont("Keypad")

					if (status == self.Status_None) then
						draw.SimpleText(value, "Keypad", X + 50, Y + 30, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
						color_outline = Color(255,255,255)
					elseif (status == self.Status_Granted) then
						draw.SimpleText("ACCESS", "KeypadState", X + 50, Y + 18, Color(0, 255, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
						draw.SimpleText("GRANTED", "KeypadState", X + 50, Y + 40, Color(0, 255, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
						color_outline = Color(0,255,0)
					elseif (status == self.Status_Denied) then
						draw.SimpleText("ACCESS", "KeypadState", X + 50, Y + 18, Color(255, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
						draw.SimpleText("DENIED", "KeypadState", X + 50, Y + 40, Color(255, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
						color_outline = Color(255,0,0)
					end

				cam.End3D2D()
			end
		end
	end
end

local keypad_buttons = {}
keypad_buttons[KEY_PAD_1] = 1
keypad_buttons[KEY_PAD_2] = 2
keypad_buttons[KEY_PAD_3] = 3
keypad_buttons[KEY_PAD_4] = 4
keypad_buttons[KEY_PAD_5] = 5
keypad_buttons[KEY_PAD_6] = 6
keypad_buttons[KEY_PAD_7] = 7
keypad_buttons[KEY_PAD_8] = 8
keypad_buttons[KEY_PAD_9] = 9
--keypad_buttons[KEY_K] = 2
keypad_buttons[KEY_ENTER] = true
keypad_buttons[KEY_PAD_ENTER] = true
keypad_buttons[KEY_PAD_MINUS] = true
keypad_buttons[KEY_PAD_PLUS] = true

local down = {}

hook.Add("Think", "Keypad_Keypad", function()
	if (IsValid(LocalPlayer()) and not LocalPlayer().KeyPadCool) then
		for k, v in pairs(keypad_buttons) do
			if (keypad_buttons[k]) then
				if (input.IsKeyDown(k) and not down[k]) then
					down[k] = true
					local ply = LocalPlayer()

					local tr = util.TraceLine({
						start = ply:EyePos(),
						endpos = ply:GetAimVector() * 32 + ply:EyePos(),
						filter = ply,
					})

					if (IsValid(tr.Entity) and tr.Entity:GetClass() == "keypad") then
						ply.KeyPadCool = true

						timer.Simple(0.1, function()
							if (IsValid(ply)) then
								if (k == IN_USE or keypad_buttons[k]) then
									ply.KeyPadCool = false
								end
							end
						end)

						if (k == KEY_PAD_ENTER or k == KEY_ENTER) then
							net.Start("keypad_command")
								net.WriteEntity(tr.Entity)
								net.WriteUInt(tr.Entity.Command_Accept, 3)
							net.SendToServer()
						elseif (k == KEY_PAD_MINUS or k == KEY_PAD_PLUS) then
							net.Start("keypad_command")
								net.WriteEntity(tr.Entity)
								net.WriteUInt(tr.Entity.Command_Reset, 3)
							net.SendToServer()
						else
							net.Start("keypad_command")
								net.WriteEntity(tr.Entity)
								net.WriteUInt(tr.Entity.Command_Enter, 3)
								net.WriteUInt(keypad_buttons[k], 4)
							net.SendToServer()
						end
					end
				end

				if (not input.IsKeyDown(k)) then
					down[k] = false
				end
			end
		end
	end
end)

hook.Add("KeyRelease", "Keypad_ReleaseCheck", function(ply, k)
	timer.Simple(0.1, function()
		if (IsValid(ply)) then
			if (k == IN_USE or keypad_buttons[k]) then
				ply.KeyPadCool = false
			end
		end
	end)
end)