rp.Zones = rp.Zones or { Data = {} }
function rp.Zones:AddNewZone( map, tab )
	if ( string.lower( map ) != game.GetMap():lower() ) then return end
	
	tab.SizeForwards.x = math.abs( tab.SizeForwards.x )
	tab.SizeForwards.y = math.abs( tab.SizeForwards.y )
	tab.SizeForwards.z = math.abs( tab.SizeForwards.z )
	
	for k,v in pairs( { "x", "y", "z" } ) do
		tab.SizeForwards[ v ] = math.abs( tab.SizeForwards[ v ] )
		
		if ( tab.SizeBackwards[ v ] > 0 ) then
			tab.SizeBackwards[ v ] = tab.SizeBackwards[ v ] * -1
		end
	end
	
	table.insert( self.Data, tab )
end

function rp.Zones:InsideSafeZone( pos )
	for k,v in pairs( self.Data ) do
		if ( pos:WithinAABox( v.Center + v.SizeBackwards, v.Center + v.SizeForwards ) ) then
			return true
		end
	end
	
	return false
end

-- Убеж
rp.Zones:AddNewZone( "rp_asheville", {
	Center = Vector( -10670.003906, 9078.45507, 260.508423 ),
	SizeBackwards = Vector( 1000, 945, 500 ),
	SizeForwards = Vector( 1075, 1200, 500 )
} )

-- ПУ
rp.Zones:AddNewZone( "rp_asheville", {
	Center = Vector( -12201.536133, -883.335938, 154.292389 ),
	SizeBackwards = Vector( 1000, 945, 500 ),
	SizeForwards = Vector( 1075, 1200, 500 )
} )

-- бандиты
rp.Zones:AddNewZone( "rp_asheville", {
	Center = Vector( -5850.548340, -12869.197266, 63.525414 ),
	SizeBackwards = Vector( 1000, 945, 500 ),
	SizeForwards = Vector( 1075, 1200, 500 )
} )

