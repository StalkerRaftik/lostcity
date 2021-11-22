local interritory = false
local nearflag = false
local text = ""
local tname


rp = rp or {}
rp.Conquest = rp.Conquest or {}
timer.Create( "IfIInTerritoryAndNearFlag", 2, 0, function()
	if !IsValid(LocalPlayer()) then return end

	for name,ttable in pairs(rp.Conquest.Config) do 
		local pos1 = ttable.coords[1]
	    local pos2 = ttable.coords[2]

	    local plypos = LocalPlayer():GetPos()

	    local b
	    if pos1[1] > pos2[1] then 
	        b = pos1[1]
	        pos1[1] = pos2[1]
	        pos2[1] = b
	    end
	    if pos1[2] > pos2[2] then 
	        b = pos1[2]
	        pos1[2] = pos2[2]
	        pos2[2] = b
	    end
	    if pos1[3] > pos2[3] then 
	        b = pos1[3]
	        pos1[3] = pos2[3]
	        pos2[3] = b
	    end

	    if plypos[1] > pos1[1] and plypos[2] > pos1[2] and plypos[3] > pos1[3] then
            if plypos[1] < pos2[1] and plypos[2] < pos2[2] and plypos[3] < pos2[3] then
               interritory = true
               tname = name
               text = ttable.comment
               break
            else interritory = false text = "" end
        else interritory = false end 
	end

	if interritory then
		for k,v in pairs(ents.GetAll()) do -- Проверка на наличие людей на территории флага
	        if v:GetClass() == "flag" and LocalPlayer():GetPos():Distance(v:GetPos()) < 150 then
	        	nearflag = true
	        	break
	        else
	        	nearflag = false
	        end
	    end
	else
		nearflag = false
	end
end)

local conhud = 0
local headerh = 0

hook.Add("HUDPaint", "ConquestUI", function()
	-- Отображение возможных наград за удержание
	if nearflag ~= true then headerh = Lerp( FrameTime()*10, headerh, 0 ) 
	else
		headerh = Lerp( FrameTime()*10, headerh, 1 )
	end

	if headerh ~= 0 or flag ~= nil then
		draw.ShadowSimpleText( 'За удержание этой территории в склад будут поступать:', "rp.ui.22", ScrW()/2, ScrH()*0.08, Color(230,230,230,255*headerh), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		draw.ShadowSimpleText( text, "rp.ui.22", ScrW()/2, ScrH()*0.11, Color(230,230,230,255*headerh), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	end
	---- Отображение территории
	if interritory ~= true then conhud = Lerp( FrameTime()*10, conhud, 0 ) 
	else
		conhud = Lerp( FrameTime()*10, conhud, 1 )
	end

	if conhud == 0 then return end

	draw.ShadowSimpleText( tname, "rp.ui.26", 5, ScrH()*0.01, Color(230,230,230,255*conhud), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

end)

function draw.ConquestOverlayText(posx, posy, text, alpha)
	alpha = alpha and alpha or 255
	local markup_obj = markup.Parse("<font=font_base_18>"..text.."</font>")
	-- local markup_obj_outline = markup.Parse("<font=font_base_18><color=0,0,0>"..text.."</color></font>")
	local w, h = markup_obj:GetWidth(), markup_obj:GetHeight()
	local x, y = posx, posy

	draw.SimpleText("◀","font_base_18", x-2, h/2, Color(40,40,40, alpha* 0.7), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	draw.SimpleText("◀","font_base_18", x-2, h/2, Color(32,36,40, alpha* 0.7), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)	

	draw.RoundedBox( 1, x, y, w + 20, h + 20, Color(40,40,40, alpha * 0.7) )
	draw.RoundedBox( 1, x+1, y+1, w+18, h+18, Color(0,0,0, alpha * 0.7) )

	--   if icon then
	--     surface.SetDrawColor( 255, 255, 255, alpha )
	--     surface.SetMaterial(icon)
	--     surface.DrawTexturedRect( x+8, y+7, 20, 20 )
	--   end

	-- markup_obj_outline:Draw( x+9, y+9, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, alpha )
	markup_obj:Draw( x+10, y+10, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, alpha )
end