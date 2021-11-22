function CSGOSmokeBlind()
	local ply = LocalPlayer()

	local IsInSmoke = false

	local SmokeAmount = 0

	for k,v in pairs(ents.FindByClass("tfa_csgo_thrownsmoke")) do
		local Distance = ply:GetPos():Distance(v:GetPos())
		if Distance <= 144 and v:GetNWBool("IsDetonated",false) then
			IsInSmoke = true
			SmokeAmount = SmokeAmount + (144 - Distance)*2
		end
	end

	if IsInSmoke then

		local ModAmount = math.Clamp(SmokeAmount / 100,0,1)
		local smokeMat = Material( "tfa_csgo/particle/particle_smokegrenade_view" )

		surface.SetDrawColor( Color(99, 99, 99,ModAmount*255) )
		surface.SetMaterial( smokeMat )
		--surface.DrawTexturedRect( 0, 0, ScrW(), ScrH() )
		--render.SetMaterial( IMaterial mat )
		--render.DrawScreenQuad()
		surface.DrawRect( 0, 0, ScrW(), ScrH() )

	end
end
hook.Add("RenderScreenspaceEffects","CSGOSmokeBlind",CSGOSmokeBlind)