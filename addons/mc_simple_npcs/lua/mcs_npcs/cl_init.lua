--  _______               __          _______  __                   __          _______  ______  ______        
-- |   |   |.---.-..----.|  |.-----. |     __||__|.--------..-----.|  |.-----. |    |  ||   __ \|      |.-----.
-- |       ||  _  ||  __| |_||__ --| |__     ||  ||        ||  _  ||  ||  -__| |       ||    __/|   ---||__ --|
-- |__|_|__||___._||____|    |_____| |_______||__||__|__|__||   __||__||_____| |__|____||___|   |______||_____|
--                                                          |__|                                               

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////// Warning! Edit this only if you know what are you doing ///////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
local NewFont = surface.CreateFont
NewFont( "MCS_Arial32", { font = "Arial", size = 32, antialias = true} )
NewFont( "MCS_Arial24", { font = "Arial", size = 24, antialias = true} )
NewFont( "MCS_Arial16", { font = "Arial", size = 16, antialias = true, shadow = true} )

//// Via MCS.PaintFunction function you can customize the dialogue box fast and easy
//// MCS.PaintFunction( Panel, Panel's wide, Panel's hight, Fade in animation effect (0-255))

function MCS.PaintFunction(self, w, h, fade)

	MCS.Blur( self, 2, 2, fade, fade-100 )
	MCS.Frame(0,0,w,h,15,Color(155,155,155, fade),Color(255,255,255, fade))

end

local blur = Material( "pp/blurscreen" )

function MCS.Blur( panel, inn, density, alpha, alpha2, w, h )
	
	if MCS.Config.EnableBlur then
		local x, y = panel:LocalToScreen(0, 0)
		
		surface.SetDrawColor( 255, 255, 255, alpha )
		surface.SetMaterial( blur )

		for i = 1, 3 do
			blur:SetFloat( "$blur", ( i / inn ) * density )
			blur:Recompute()

			render.UpdateScreenEffectTexture()
			if w and h then
			render.SetScissorRect(-x, -y, x+w, y+h, true)
				surface.DrawTexturedRect( -x, -y, ScrW(), ScrH() )
			render.SetScissorRect(0, 0, 0, 0, false)
			else
				surface.DrawTexturedRect( -x, -y, ScrW(), ScrH() )
			end
		end
	end
	
	draw.RoundedBox( 0, 0, 0, panel:GetWide(), panel:GetTall(), Color( 0, 0, 0, alpha2)) 
	
end

function MCS.Frame(x,y,w,h,lw,color,otcolor)

	surface.SetDrawColor(color)
	surface.DrawOutlinedRect(x,y,w,h)
	surface.SetDrawColor(otcolor)
	
	if lw then
		surface.DrawLine( x, y, x+lw, y )
		surface.DrawLine( w+x-1, y, w+x-lw-1, y )
		surface.DrawLine( x, y+h-1, x+lw, y+h-1 )
		surface.DrawLine( w+x-1, y+h-1, w+x-lw-1, y+h-1 )
		surface.DrawLine( x, y, x, y+lw )
		surface.DrawLine( w+x-1, y, w+x-1, y+lw )
		surface.DrawLine( x, y, x, y+lw )
		surface.DrawLine( w+x-1, y+h-1, w+x-1, y+h-lw-1 )
		surface.DrawLine( x, y+h-1, x, y+h-lw-1 )
	end
	
end
 
hook.Add("HUDPaint", "MCS Npc", function()
	for _, ent in pairs (ents.FindByClass("mcs_npc")) do
		if ent:GetPos():Distance(LocalPlayer():GetPos()) < 200 then
			local pos = ent:EyePos()
			local shootPos = LocalPlayer():GetShootPos()
			local hisPos = ent:GetPos()
			local tpp = hisPos:Distance(shootPos)
			local textColor = Color( 255, 255, 255, 255-tpp*2 )
			
			if MCS.Spawns[ent:GetUID()] and  MCS.Spawns[ent:GetUID()].namepos then
				pos.z = pos.z + MCS.Spawns[ent:GetUID()].namepos
			else
				pos.z = pos.z + 77
			end
			
			pos = pos:ToScreen()

			if tpp < 130 then 
				draw.SimpleTextOutlined(ent:GetNamer(), MCS.Config.AnswersFont, pos.x, pos.y, textColor, TEXT_ALIGN_CENTER, 0, 3, Color(0, 0, 0, 255-tpp*2) )
			end
		end
	end
end)

function MCSruscheck(str)
	
	local chars = {
		["й"] = true, ["ц"] = true, ["у"] = true, ["к"] = true, ["е"] = true, ["н"] = true, ["г"] = true, ["ш"] = true, ["щ"] = true, ["з"] = true, ["х"] = true, ["ъ"] = true, ["ф"] = true, ["ы"] = true,
		["в"] = true, ["а"] = true, ["п"] = true, ["р"] = true, ["о"] = true, ["л"] = true, ["д"] = true, ["ж"] = true, ["э"] = true, ["я"] = true, ["ч"] = true, ["с"] = true, ["м"] = true, ["и"] = true,
		["т"] = true, ["ь"] = true, ["б"] = true, ["ю"] = true, ["Й"] = true, ["Ц"] = true, ["У"] = true, ["К"] = true, ["Е"] = true, ["Н"] = true, ["Г"] = true, ["Ш"] = true, ["Щ"] = true, ["З"] = true, 
		["Х"] = true, ["Ъ"] = true, ["Ф"] = true, ["Ы"] = true, ["В"] = true, ["А"] = true, ["П"] = true, ["Р"] = true, ["О"] = true, ["Л"] = true, ["Д"] = true, ["Ж"] = true, ["Э"] = true, ["Я"] = true, 
		["Ч"] = true, ["С"] = true, ["М"] = true, ["И"] = true, ["Т"] = true, ["Ь"] = true, ["Б"] = true, ["Ю"] = true, ["ё"] = true, ["Ё"] = true
	}
	
	if chars[str] then
		return true
	else
		return false
	end
	
end