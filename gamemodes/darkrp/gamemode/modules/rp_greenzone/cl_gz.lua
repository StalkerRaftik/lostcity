concommand.Add( "rp.Zones_view_all", function()
	hook.Add( "PostDrawOpaqueRenderables", "rp.ZonesRenderZones", function()
		for k,v in pairs( rp.Zones.Data ) do
			render.DrawWireframeBox( v.Center, Angle( 0, 0, 0 ), v.SizeBackwards, v.SizeForwards, color_white, true )
		end
	end )
end )

timer.Create( "rp.Zones_manage", 1, 0, function()
	if ( !IsValid( LocalPlayer() ) or !LocalPlayer().GetPos ) then return end
	
	rp.Zones.DrawHUD = rp.Zones:InsideSafeZone( LocalPlayer():GetPos() )
end )

hook.Add( "HUDPaint", "rp.Zones_draw_safezone", function()
	if ( !rp.Zones.DrawHUD ) then return end
	
	local w = ScrW()
	local h = ScrH()
	
	draw.ShadowSimpleText( "Оплот человечества", "rp.ui.22", w/2, 20, Color( 200, 200, 200, 200 ), 1, 1)
	draw.ShadowSimpleText( "Урон по зомби увеличен, урон по вам уменьшен", "rp.ui.18", w/2, 50, Color( 220, 220, 220, 200 ), 1, 1)
end )