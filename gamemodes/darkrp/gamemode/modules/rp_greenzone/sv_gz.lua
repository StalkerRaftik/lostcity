hook.Add( "EntityTakeDamage", "rp.Zones.stopDamage", function( targ, dmg )
	local isInsideZone = rp.Zones:InsideSafeZone(targ:GetPos())

	if not isInsideZone then return end

	if ( targ:IsPlayer() and dmg:GetAttacker():IsNPC()) then
		dmg:ScaleDamage(0.5)
	end
	if ( targ:IsNPC() ) then
		dmg:ScaleDamage( 2 )
	end
end )