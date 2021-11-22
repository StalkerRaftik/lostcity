local function RestartIncoming()

	if RestartIncomingTimer then
		draw.ShadowSimpleText( "Внимание!", "rp.ui.40", ScrW()/2, 100, Color(255,0,0,255), 1, 0)
		draw.ShadowSimpleText( "Через "..rplib.FormatTime(RestartIncomingTimer).." секунд будет рестарт!", "rp.ui.40", ScrW()/2, 150, Color(255,255,255,255), 1, 0)
		-- draw.ShadowSimpleText( "Пожалуйста, сохраните все ваши вещи в недвижимости/инвентаре/сейфе.", "rp.ui.40", ScrW()/2, 200, Color(255,255,255,255), 1, 0)
	end
	
	
end

hook.Add("HUDPaint", "RestartManage", RestartIncoming)


net.Receive('RestartIncoming', function(len,ply)
	RestartIncomingTimer = net.ReadDouble()
	surface.PlaySound( "ambient/alarms/siren.wav" )
	
	local RandomSoundsTable = {
		"vo/canals/arrest_helpme.wav",
		"vo/coast/bugbait/sandy_help.wav",
		"vo/npc/female01/help01.wav",
		"vo/npc/male01/help01.wav",
		"vo/npc/Alyx/ohno_startle01.wav",
		"vo/npc/Alyx/ohno_startle03.wav",
		"vo/npc/female01/ohno.wav",
		"vo/npc/fale01/ohno.wav",
	}
	
	timer.Create("RestartTimer", 1, 0, function()
		RestartIncomingTimer = RestartIncomingTimer - 1
	end)
	
	local tab = {
		["$pp_colour_addr"] = 0,
		["$pp_colour_addg"] = 0,
		["$pp_colour_addb"] = 0,
		["$pp_colour_brightness"] = 0.05,
		["$pp_colour_contrast"] = 0.5,
		["$pp_colour_colour"] = 0.5,
		["$pp_colour_mulr"] = 0,
		["$pp_colour_mulg"] = 0,
		["$pp_colour_mulb"] = 0
	}
	hook.Add("RenderScreenspaceEffects", "RestartIncoming_Color", function()
		DrawColorModify( tab )
	end)

end)
