include("shared.lua")


local owner = "Ничей"
local tcool = 0
local fade = 0
local timer = -1
capturecolor = Color(0,0,0)


function ENT:Draw()
	local distance = LocalPlayer():GetPos():Distance(self:GetPos()) or 2500

	if distance < 4000 then

		self:DrawModel()

		if tcool < CurTime() then
			owner = self:GetNVar("FlagOwner") or "Ничей"
			timer = self:GetNVar("ConquestTimer") and self:GetNVar("ConquestTimer") or -1
			tcool = CurTime() + 0.5
		end

		if not isnumber(timer) then return end

		if distance > 400 then 
			fade = Lerp( FrameTime()*10, fade, 0 ) 
		else 
			fade = Lerp( FrameTime()*10, fade, 1 ) 
		end

		local color = self:GetColor() or Color(100,100,100, 255 * fade)

		if (timer > 0) and (timer < 10) then 
			capturecolor = Color(180, 0, 0)
		else
			capturecolor = Color(0, 158, 194)
		end

		local pleng = LocalPlayer():GetAngles()[2]

		if fade > 0.001 then
			cam.Start3D2D(self:GetPos() + Vector(0,0,60), Angle(0, pleng, 0) + Angle(0,-90,90), 0.2  )	
				if timer > 0 then
					draw.ConquestOverlayText(50, 0, "<color=255,255,255,255 * fade>Идет захват! Не покидайте территорию!</color>\nОсталось <color="..capturecolor['r']..","..capturecolor['g']..","..capturecolor['b']..",255 * fade>"..math.Round(timer - CurTime()).."</color> секунд!", 255 * fade)
				elseif owner == "Ничей" then
					-- draw.RoundedBox( 5, 30, 0, 500, 60, Color(30,30,30,200 * fade) )
					-- draw.ShadowSimpleText( "Эта территория", "ui.30", 35, 0, Color(200,200,200,255 * fade), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
					-- draw.ShadowSimpleText( "никому не пренадлежит", "ui.30", 235, 0, Color(100,100,100,255 * fade), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
					draw.ConquestOverlayText(50, 0, "Эта территория <color=100,100,100,255 * fade>никому не пренадлежит</color>\nНажмите <color=0, 158, 194,255 * fade>E</color>, чтобы начать захват", 255 * fade)
				else
					-- draw.RoundedBox( 5, 30, 0, 500, 60, Color(30,30,30,200 * fade) )
					-- draw.ShadowSimpleText( "Эта территория пренадлежит ", "ui.30", 35, 0, Color(200,200,200,255 * fade), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
					-- draw.ShadowSimpleText("'" ..owner.."'", "ui.30", 395, 0, Color(color['r'],color['g'],color['b'],255 * fade), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
					draw.ConquestOverlayText(50, 0, "Эта территория пренадлежит <color="..color['r']..","..color['g']..","..color['b']..", 255 * fade>"..owner.."</color>\nНажмите <color=0, 158, 194,255 * fade>E</color>, чтобы начать захват", 255 * fade)
				end
				-- draw.ShadowSimpleText( "Нажмите     , чтобы начать захват.", "ui.30", 35, 30, Color(200,200,200,255 * fade), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
				-- draw.ShadowSimpleText( "'Е'", "ui.30", 148, 30, Color(0, 158, 194,255 * fade), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
			cam.End3D2D()
		end

	end

end