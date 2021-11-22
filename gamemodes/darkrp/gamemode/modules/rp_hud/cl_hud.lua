rphud = rphud or {}
rphud.Scale = 1
local NoDraw = {
  CHudHealth = true,
  CHudBattery = true,
  CHudAmmo = true,
  CHudSecondaryAmmo = true,
  CHudSuitPower = true,
  CHudCrosshair = true,
  CMapOverview = true,
  CHudZoom = true,
  CHudVoiceStatus = true,
  CHudVoiceSelfStatus = true
}

local enableHUD = 1
local x, y, w, h = ScrW(), ScrH(), ScrW(), ScrH()
local nd = 0
local nti = 360 / 15
local noi = 18

function GM:HUDShouldDraw(name)
  if NoDraw[name] or ((name == 'CHudDamageIndicator') and (not LocalPlayer():Alive())) then return false end

  return true
end

function GM:HUDDrawTargetID()
  return false
end

function GM:DrawDeathNotice(x, y)
  return false
end

local hudbg = Material("lostcity/hud/status_bg.png","noclamp smooth")
local thirstbg = Material("lostcity/hud/status_thirst_border_CA.png","noclamp smooth")
local thirst5 = Material("lostcity/hud/status_thirst_inside_4_ca.png","noclamp smooth")
local thirst4 = Material("lostcity/hud/status_thirst_inside_3_ca.png","noclamp smooth")
local thirst3 = Material("lostcity/hud/status_thirst_inside_2_ca.png","noclamp smooth")
local thirst2 = Material("lostcity/hud/status_thirst_inside_1_ca.png","noclamp smooth")
local thirst1 = Material("lostcity/hud/status_thirst_inside_0_ca.png","noclamp smooth")
local hungerbg = Material("lostcity/hud/status_food_border_CA.png","noclamp smooth")
local hunger5 = Material("lostcity/hud/status_food_inside_4_ca.png","noclamp smooth")
local hunger4 = Material("lostcity/hud/status_food_inside_3_ca.png","noclamp smooth")
local hunger3 = Material("lostcity/hud/status_food_inside_2_ca.png","noclamp smooth")
local hunger2 = Material("lostcity/hud/status_food_inside_1_ca.png","noclamp smooth")
local hunger1 = Material("lostcity/hud/status_food_inside_0_ca.png","noclamp smooth")
local healthbg = Material("lostcity/hud/status_blood_border_CA.png","noclamp smooth")
local health5 = Material("lostcity/hud/status_blood_inside_6_ca.png","noclamp smooth")
local health4 = Material("lostcity/hud/status_blood_inside_5_ca.png","noclamp smooth")
local health3 = Material("lostcity/hud/status_blood_inside_4_ca.png","noclamp smooth")
local health2 = Material("lostcity/hud/status_blood_inside_3_ca.png","noclamp smooth")
local health1 = Material("lostcity/hud/status_blood_inside_2_ca.png","noclamp smooth")
local healthbleed = Material("lostcity/hud/status_blood_border_down3_ca.png","noclamp smooth")
local healthbleedz = Material("lostcity/hud/status_blood_border_down3_sick_ca.png","noclamp smooth")
local tempbg = Material("lostcity/hud/status_temp_0_ca.png","noclamp smooth")
local temp5 = Material("lostcity/hud/status_temp_4_ca.png","noclamp smooth")
local temp4 = Material("lostcity/hud/status_temp_3_ca.png","noclamp smooth")
local temp3 = Material("lostcity/hud/status_temp_2_ca.png","noclamp smooth")
local temp2 = Material("lostcity/hud/status_temp_1_ca.png","noclamp smooth")
local temp1 = Material("lostcity/hud/status_temp_0_ca.png","noclamp smooth")
local bone = Material("lostcity/hud/status_effect_brokenleg.png","noclamp smooth")
local matVignette = Material("lostcity/hud/overlays/vignette02","noclamp smooth")
local micro = Material("lostcity/hud/val_5_ca.png", "noclamp smooth")
local radiation = Material("samprp/moreicons/toxic.png", "noclamp smooth")
local x, y = ScrW(), ScrH()

local elements = {
	{ x = -450, letter = "", color = Color(29,161,242) },
	{ x = -360, letter = "Север", color = Color(29,161,30) },
	{ x = -315, letter = "СЗ", color = Color(29,161,242) },
	{ x = -270, letter = "Запад", color = Color(29,161,242) },
	{ x = -225, letter = "ЮЗ", color = Color(29,161,242) },
	{ x = -180, letter = "Юг", color = Color(29,161,242) },
	{ x = -135, letter = "ЮЗ", color = Color(29,161,242) },
	{ x = -90, letter = "Запад", color = Color(29,161,242) },
	{ x = -45, letter = "СЗ", color = Color(29,161,242) },

	{ x = 0, letter = "Север", color = Color(252,175,23) },

	{ x = 45, letter = "СВ", color = Color(29,161,242) },
	{ x = 90, letter = "", color = Color(29,161,242) },
	{ x = 135, letter = "ЮВ", color = Color(29,161,242) },
	{ x = 180, letter = "Юг", color = Color(29,161,242) },
	{ x = 225, letter = "ЮЗ", color = Color(29,161,242) },
	{ x = 270, letter = "Запад", color = Color(29,161,50) },
	{ x = 315, letter = "СЗ", color = Color(29,161,242) },
	{ x = 360, letter = "Север", color = Color(29,161,30) },
	{ x = 450, letter = "Запад", color = Color(29,161,242) },

	{ x = 15 },
	{ x = 30 },
	{ x = 60 },
	{ x = 75 },
    { x = 90 },
	{ x = 105 },
	{ x = 120 },
	{ x = 150 },
	{ x = 165 },
	{ x = 195 },
	{ x = 210 },
	{ x = 240 },
	{ x = 255 },
	{ x = 285 },
	{ x = 300 },
	{ x = 330 },
	{ x = 345 },

	{ x = -15 },
	{ x = -30 },
	{ x = -60 },
	{ x = -75 },
	{ x = -105 },
	{ x = -120 },
	{ x = -150 },
	{ x = -165 },
	{ x = -195 },
	{ x = -210 },
	{ x = -240 },
	{ x = -255 },
	{ x = -285 },
	{ x = -300 },
	{ x = -330 },
	{ x = -345 },
}
local line_wide = 400
local compass_x = 15

local radVisGrowth = true
local radVis = 0
function DRAWHUDMain()
	if not IsValid(LocalPlayer()) then return end
	if not LocalPlayer():Alive() then return end
	if LocalPlayer():GetNVar('PlayerDataLoaded') ~= true then return end
	if LocalPlayer():GetNVar('CharSelected') ~= true then return end

    -- do -- Compass 
	-- 	local offLimit = ScrW() / 6

	-- 	local offset = LocalPlayer():GetAngles().y
	-- 	for i, el in ipairs(elements) do
	-- 		local x = (el.x + offset) * 4
	-- 		if x < -offLimit then continue end
	-- 		if x > offLimit then continue end

	-- 		local alpha = (offLimit - math.abs(x)) / offLimit * 255
	-- 		local draw_x = ScrW() / 2 + x

	-- 		surface.SetDrawColor(Color(255,255,255,alpha))
	-- 		local color = el.color and Color(el.color.r,el.color.g,el.color.b,alpha*6) or Color(255,255,255,alpha)
	-- 		if el.letter then
	-- 			surface.DrawLine(draw_x-2, compass_x-10, draw_x-2, compass_x)
	-- 			draw.ShadowSimpleText( el.letter, "font_base_24", draw_x-2, compass_x, color, 1, 0, 1, Color(0,0,0,alpha/2))
	-- 		else
	-- 			surface.DrawLine(draw_x-1, compass_x-10, draw_x-1, compass_x)

	-- 			local x_ = el.x > 0 and el.x or 360 + el.x
	-- 			draw.ShadowSimpleText( x_, "font_base_18", draw_x, compass_x, color, 1, 0, 1, Color(0,0,0,alpha/2))
	-- 		end
	-- 	end
	-- 	draw.SimpleText("▼", "font_base_18", ScrW()/2, compass_x-22, color_white, 1, 0)
	-- end


	do--THIRST
		local thirst = LocalPlayer():GetThirst()
		local col = color_white
		draw.Icon( x/1.05, y/1.08, 60, 60, thirstbg, color_white )
		draw.Icon( x/1.05, y/1.08, 60, 60, hudbg, color_white )
		if thirst >= 70 then
			col = Color(60,100,30)
			draw.Icon( x/1.05, y/1.08, 60, 60, thirst5, col )
		elseif thirst >= 50 then
			col = Color(80,100,30)
			draw.Icon( x/1.05, y/1.08, 60, 60, thirst4, col )
		elseif thirst >= 40 then
			col = Color(120,100,30)
			draw.Icon( x/1.05, y/1.08, 60, 60, thirst3, col )
		elseif thirst >= 30 then
			col = Color(170,100,30)
			draw.Icon( x/1.05, y/1.08, 60, 60, thirst2, col )
		elseif thirst >= 15 then
			col = Color(200,0,30)
			draw.Icon( x/1.05, y/1.08, 60, 60, thirst1, col )
		end
	end
	do--Temp
		local thirst = LocalPlayer():GetTemp() or 100
		local col = color_white
		draw.Icon( x/1.19, y/1.08, 60, 60, hudbg, color_white )
		draw.Icon( x/1.19, y/1.087, 60, 60, tempbg, color_white )		
		if thirst >= 70 then
			col = Color(150,0,30)
			draw.Icon( x/1.1945, y/1.09, 70, 70, temp5, col )
		elseif thirst >= 50 then
			col = Color(100,0,30)
			draw.Icon( x/1.1945, y/1.09, 70, 70, temp4, col )
		elseif thirst >= 40 then
			col = Color(100,0,50)
			draw.Icon( x/1.1945, y/1.09, 70, 70, temp3, col )
		elseif thirst >= 30 then
			col = Color(100,0,90)
			draw.Icon( x/1.1945, y/1.09, 70, 70, temp2, col )
		else
			col = Color(50,100,200)
			draw.Icon( x/1.1945, y/1.09, 70, 70, temp2, col )
		end
	end
	do--HUNGER
		local hunger = LocalPlayer():GetHunger()
		local col = color_white
		draw.Icon( x/1.09, y/1.08, 60, 60, hungerbg, color_white )
		draw.Icon( x/1.09, y/1.08, 60, 60, hudbg, color_white )
		if hunger >= 70 then
			col = Color(60,100,30)
			draw.Icon( x/1.09, y/1.08, 60, 60, hunger5, col )
		elseif hunger >= 50 then
			col = Color(80,100,30)
			draw.Icon( x/1.09, y/1.08, 60, 60, hunger4, col )
		elseif hunger >= 40 then
			col = Color(120,100,30)
			draw.Icon( x/1.09, y/1.08, 60, 60, hunger3, col )
		elseif hunger >= 30 then
			col = Color(170,100,30)
			draw.Icon( x/1.09, y/1.08, 60, 60, hunger2, col )
		elseif hunger >= 15 then
			col = Color(200,0,30)
			draw.Icon( x/1.09, y/1.08, 60, 60, hunger1, col )
		end
	end
	do--HEALTH
		local health = LocalPlayer():Health()
		local col = color_white
		if LocalPlayer():GetNVar("Bleeding") == true then
			draw.Icon( x/1.14, y/1.08, 60, 60, healthbleed, Color(200,0,0) )
		elseif LocalPlayer():GetNVar("Infected") == true then
			draw.Icon( x/1.14, y/1.08, 60, 60, healthbleedz, Color(200,0,0) )
		else
			draw.Icon( x/1.14, y/1.08, 60, 60, healthbg, color_white )
		end
		draw.Icon( x/1.14, y/1.08, 60, 60, hudbg, color_white )
		if health >= 70 then
			col = Color(60,100,30)
			draw.Icon( x/1.14, y/1.08, 60, 60, health5, col )	
		elseif health >= 50 then
			col = Color(80,100,30)
			draw.Icon( x/1.14, y/1.08, 60, 60, health4, col )
		elseif health >= 40 then
			col = Color(120,100,30)
			draw.Icon( x/1.14, y/1.08, 60, 60, health3, col )
		elseif health >= 30 then
			col = Color(170,100,30)
			draw.Icon( x/1.14, y/1.08, 60, 60, health2, col )
		elseif health >= 15 then
			col = Color(200,0,30)
			draw.Icon( x/1.14, y/1.08, 60, 60, health1, col )
		end
	end
	do
		if LocalPlayer():GetNVar("Legbroken") == true then
			draw.Icon( x/1.26, y/1.08, 60, 60, bone, color_white )
		end
	end
	do -- Radiation
		local PlyRad = LocalPlayer():GetNVar('Radiation')
		if PlyRad and not isbool(PlyRad) and PlyRad > 1000 then
			local radVisibilityLimit = math.Clamp( (PlyRad-900) / 5000 * 255, 0, 255 )


			if radVis < 0.01 then
				radVisGrowth = true
			elseif radVis > radVisibilityLimit - 0.01 then
				radVisGrowth = false
			end
			
			if radVisGrowth == true then
				radVis = Lerp( FrameTime()*4, radVis, radVisibilityLimit )
			else
				radVis = Lerp( FrameTime()*4, radVis, 0 )
			end
			draw.Icon( x/1.045, y/1.15, 50, 50, radiation, Color(255,255,255, radVis) )
		end
	end


	do  --Crosshair
		if LocalPlayer():Alive() then 
			local ent = LocalPlayer():GetEyeTrace().Entity
			local wep = LocalPlayer():GetActiveWeapon()
			if IsValid(wep) then
			local class = wep:GetClass() 
				if class == "weapon_rphands" or class == "weapon_physgun" or class == "gmod_tool" then -- weapons.IsBasedOn( class, "tfa_shotty_base" ) or weapons.IsBasedOn( class, "tfa_gun_base" ) or
					if class == "weapon_rphands" or class == "weapon_physgun" or class == "gmod_tool" then
						local drawPos = util.TraceLine{
							start = LocalPlayer():GetShootPos(),
							endpos = LocalPlayer():GetShootPos() +(LocalPlayer():GetAimVector() *9e9),
							filter = LocalPlayer(),
							mask = MASK_SHOT,
						}.HitPos:ToScreen()
						draw.Circle( drawPos, 2, 360, Color(100,100,100) )
						draw.Circle( drawPos, 1.7, 360, Color(150,150,150) )
					elseif wep:GetIronSightsRaw() == false or LocalPlayer():GetNVar("PlayerTPV") == true then 
						local drawPos = util.TraceLine{
							start = LocalPlayer():GetShootPos(),
							endpos = LocalPlayer():GetShootPos() +(LocalPlayer():GetAimVector() *9e9),
							filter = LocalPlayer(),
							mask = MASK_SHOT,
						}.HitPos:ToScreen()
						draw.Circle( drawPos, 2, 360, Color(100,100,100) )
						draw.Circle( drawPos, 1.7, 360, Color(150,150,150) )
					end
				end
			end
		end
	end


	--// Стамина

	local staminaInPercent = LocalPlayer():GetStamina() / 100

	surface.SetDrawColor(0,0,0,160)
    surface.DrawRect(x - 10, y - 190, 7, 180)
    surface.SetDrawColor(200,200,200,200)
    surface.DrawRect(x - 8, y - 188 + (176 - (176 * staminaInPercent)), 3, 176 * staminaInPercent)

	-- Виньетка. С ней беда какая-то. Стоит найти новую виньетку в интернете
	-- if not matVignette:IsError() then
	-- 	draw.Icon( 0, 0, ScrW(), ScrH(), matVignette, Color(255,255,255) )
	-- end
end

local brightness = 0
local colour = 1
local ColorEffect = 1
local function LowHealthColor()
		local time = StormFox.GetTime()
		if time > 1150 then
			ColorEffect = (time-1150)/(1440-1150)
			
		elseif time >= 0 and time <= 240 then
			ColorEffect = 1
		elseif time > 240 and time <= 420 then
			ColorEffect = 1 - ((time-240)/180)
		else
			ColorEffect = 0
		end
		
		if LocalPlayer().NightvisionEnabled then
			ColorEffect = 0
		end

		ColorEffect = math.Clamp(ColorEffect, 0, 1)
		-- print(ColorEffect)
		-- print(StormFox.GetTime()/60)
		-- print("-----------")
	-- if LocalPlayer():Alive() then
		local modify = {}
		local color = 1
		
		if ( LocalPlayer():Health() < 60 ) then
			if ( LocalPlayer():Alive() ) then
				color = math.Clamp( color - ( ( 50 - LocalPlayer():Health() ) * 0.025 ), 0, color )
				
			else
				color = 0
			end
			
		end
		
		NightContrastModifier(color)	
end
hook.Add( "RenderScreenspaceEffects", "RenderColorModifyPOO", LowHealthColor )


function NightContrastModifier(additionalClr)
	local addColor = 0.2
	local colortbl = {
		["$pp_colour_addg"] = addColor * ColorEffect,
		["$pp_colour_addr"] = addColor * ColorEffect,
		["$pp_colour_addb"] = addColor * ColorEffect,
		[ "$pp_colour_brightness" ] = -0.25 * ColorEffect,
		[ "$pp_colour_contrast" ] = 0.93 + (0.07 * (1 - ColorEffect)),
		[ "$pp_colour_colour" ] = math.Clamp(0.55 + (0.45 * (1 - ColorEffect)) - (1 - additionalClr)/2, 0, 1), 
	}


	DrawColorModify( colortbl )
	if ColorEffect > 0.1 then
		DrawBloom(0.11, 0.73*ColorEffect, 5.97, 2.88, 1, 2.74, 1, 1, 1)
	end
end


if IsValid(LocalPlayer()) then
	local heartBeat = CreateSound(LocalPlayer(), "player/heartbeat1.wav")
	heartBeat:ChangeVolume(0, 0.1)
	heartBeat:Play()
	
	hook.Add("Think", "HeartBeat", function()
		if LocalPlayer():Alive() then
			if LocalPlayer():Health() > 40 then
				LocalPlayer():SetDSP(0, false)
				LocalPlayer():SetDSP(0, false)
			end
			if LocalPlayer():Health() < 40 then 
				LocalPlayer():SetDSP(47, false)
				LocalPlayer():SetDSP(31, false)
				volume = 1 - LocalPlayer():Health()*0.01
				heartBeat:ChangeVolume(volume, 0.1)
			else
				heartBeat:ChangeVolume(0, 0.1)
			end
		end
	end)
end

local GoodBoy, BadBoy = Material("samprp/moreicons/comedy.png", "noclamp smooth"), Material("samprp/moreicons/robber.png", "noclamp smooth")

local dotcd = 0
local dotcounter = 0
local text = "Говорит"

function PLAYER:drawPlayerInfo() 
	if not IsValid(self) then return end
	if not self:Alive() then return end
	if self:GetNVar('PlayerDataLoaded') ~= true then return end

	local shouldDraw, players = hook.Call("HUDShouldDraw", GAMEMODE, "DarkRP_EntityDisplay")
	if shouldDraw == false then return end

	local pos = self:EyePos()
	local bone = self:LookupBone("ValveBiped.Bip01_Head1")
	if bone then
		pos = self:GetBonePosition( bone )
	end

    pos = (pos + Vector(0,0,8)):ToScreen()

	local width, height = surface.GetTextSize( self:RPName() )
	local dist = LocalPlayer():GetPos():Distance(self:GetPos())
	local admul = math.cos( (dist / 150) * (math.pi / 2) )^2

	pos.x, pos.y = math.floor(pos.x), math.floor(pos.y)

	if input.IsKeyDown( KEY_T ) and not chatopened then
		if self:GetNVar('Typing') then
			draw.ShadowSimpleText(self:GetJobName(),'rp.ui.20',pos.x-5,pos.y-60,color_black,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			draw.ShadowSimpleText(self:GetJobName(),'rp.ui.20',pos.x-4,pos.y-60,team.GetColor(self:Team()),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		else
			draw.ShadowSimpleText(self:GetJobName(),'rp.ui.20',pos.x-5,pos.y-40,color_black,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			draw.ShadowSimpleText(self:GetJobName(),'rp.ui.20',pos.x-4,pos.y-40,team.GetColor(self:Team()),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		end
	end
	

	if self:GetNVar('Typing') then
		if CurTime() > dotcd then
			dotcd = CurTime() + 0.5
			if dotcounter < 3 then
				text = text .. "."
				dotcounter = dotcounter + 1
			else
				text = "Говорит"
				dotcounter = 0
			end
		end

		draw.SimpleText(text,'rp.ui.20',pos.x,pos.y-40,Color(0,0,0,255 * admul),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		draw.SimpleText(text,'rp.ui.20',pos.x+1,pos.y-39,Color(200,200,200, 255 * admul),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
	end


	draw.SimpleTextOutlined(self:RPName(),'rp.ui.20',pos.x,pos.y-20, Color(200,200,200, 160 * admul), TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER, 1, Color(0,0,0,190*admul))

	if self.isTalking then
		col = Color(120,100,30)
		draw.Icon( pos.x-5, pos.y-70, 30, 30, micro, col )
	end

end

local function DrawEntityDisplay()
    local shouldDraw, players = hook.Call("HUDShouldDraw", GAMEMODE, "DarkRP_EntityDisplay")
    if shouldDraw == false then return end

    local shootPos = LocalPlayer():GetShootPos()
    local aimVec = LocalPlayer():GetAimVector()

    for k, ply in pairs(players or player.GetAll()) do
        if ply == LocalPlayer() or not ply:Alive() or ply:GetNoDraw() or ply:IsDormant() then continue end
        local hisPos = ply:GetShootPos()

        if hisPos:DistToSqr(shootPos) < 20000 then
            local pos = hisPos - shootPos
            local unitPos = pos:GetNormalized()
            if unitPos:Dot(aimVec) > 0.95 then
                local trace = util.QuickTrace(shootPos, pos, LocalPlayer())
                if trace.Hit and trace.Entity ~= ply then break end
                ply:drawPlayerInfo()
            end
        end
    end
end

hook.Add('HUDPaint', 'DrawLostCityHUD', function()
    if not IsValid(LocalPlayer()) then return end
    if enableHUD ~= 1 then return end
	DRAWHUDMain()
	DrawEntityDisplay()
end)

hook.Add('InitPostEntity', 'RemoveDefVoiceVis', function()
	timer.Simple(0, function()
		if IsValid(g_VoicePanelList) then g_VoicePanelList:Remove() end
		local voice = Material( "voice/icntlk_pl" )
		voice:SetInt( "$alpha", 0 )
	end)
end)

local scr_w, scr_h = ScrW(), ScrH()

hook.Add('PostRenderVGUI','PostRenderVGUI_LowHealth',function()
	if not LocalPlayer():GetHunger() then return false end 
	if not LocalPlayer():GetThirst() then return false end
  local cin = (math.sin(CurTime() * 3) + 4) / 5

  if LocalPlayer():GetHunger() <= 0 or LocalPlayer():GetThirst() <= 0 and LocalPlayer():Alive() then
    local col = Color(cin * 150, 0, 0, cin * 200)
    draw.TexturedQuad
    {
      texture = surface.GetTextureID "gui/gradient",
      color = col,
      x = 0,
      y = 0,
      w = scr_w*.1,
      h = scr_h
    }
    surface.DrawTexturedRectRotated( scr_w/2, 0 + (scr_w*.1)/2,scr_w*.1,scr_w, -90 )
    surface.DrawTexturedRectRotated( scr_w - (scr_w*.1)/2, scr_w*.1,scr_w*.1,scr_w, -180 )
    surface.DrawTexturedRectRotated( scr_w/2, scr_h - (scr_w*.1)/2,scr_w*.1,scr_w, 90 )
  end


end)


hook.Add('PostRenderVGUI','PostRenderVGUI_LowTemperature',function()
	if not LocalPlayer():GetTemp() then return false end

	local cin = (math.sin(CurTime() * 1) + 4) / 8

	if LocalPlayer():GetTemp() <= 30 and LocalPlayer():Alive() then
		local col = Color(35 * cin, 212 * cin, 247 * cin, cin * 200)
		draw.TexturedQuad
		{
		  texture = surface.GetTextureID "gui/gradient",
		  color = col,
		  x = 0,
		  y = 0,
		  w = scr_w*.1,
		  h = scr_h
		}
		surface.DrawTexturedRectRotated( scr_w/2, 0 + (scr_w*.1)/2,scr_w*.1,scr_w, -90 )
		surface.DrawTexturedRectRotated( scr_w - (scr_w*.1)/2, scr_w*.1,scr_w*.1,scr_w, -180 )
		surface.DrawTexturedRectRotated( scr_w/2, scr_h - (scr_w*.1)/2,scr_w*.1,scr_w, 90 )
	end

end)


hook.Add("PlayerStartVoice", "ImageOnVoice", function(ply)
	ply.isTalking = true
	if ply == LocalPlayer() then
		hook.Add("HUDPaint", "ImageOnVoice", function()
			col = Color(120,100,30)
			draw.Icon( x*0.96, y*0.8, 40, 40, micro, col )
		end)
	end
end)

hook.Add("PlayerEndVoice", "ImageOnVoice", function(ply)
	ply.isTalking = false
	if ply == LocalPlayer() then
		hook.Remove("HUDPaint", "ImageOnVoice")
	end
end)

-- hook.Add( "StartChat", "HasStartedTyping", function( isTeamChat )
-- 	net.Start("PlyStartChatting")
-- 	net.WriteBool( true )
-- 	net.SendToServer()
-- end


hook.Add( "StartChat", "PlayerStartChatting", function( isTeamChat )
	chatopened = true
	net.Start("PlayerStartChatting")
	net.SendToServer()
end )

hook.Add( "FinishChat", "PlayerFinishChatting", function( isTeamChat )
	chatopened = false
	net.Start("PlayerFinishChatting")
	net.SendToServer()
end )


concommand.Add("lc_hud_enable", function( ply, cmd, args )
	enableHUD = tonumber(args[1])
end)