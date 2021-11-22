hook.Add("HUDPaint", "SurrenderButtonHud", function()
	if LocalPlayer():GetNVar('PlayerSurrender') == 1 then
		draw.ShadowSimpleText("Вы подняли руки, нажмите F1, чтобы опустить их", "font_base_normal", ScrW()/2, ScrH()*0.1, color_white, 1, 1)	
	end
end)	