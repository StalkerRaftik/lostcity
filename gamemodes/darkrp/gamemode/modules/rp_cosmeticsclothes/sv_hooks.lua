Cosmetics.Textures = Cosmetics.Textures or {}
Cosmetics.ShopTextures = Cosmetics.ShopTextures or {}

hook.Add("PlayerSpawn", "Cosmetics:PlayerSpawn", function( ply )
		
	timer.Simple(0.1, function()
		ply:CM_ApplyModel()
	end)
	
end)

hook.Add("OnPlayerChangedTeam", "Cosmetics:OnPlayerChangedTeam", function( ply, oldteam, newteam )
	
	timer.Simple(0.1, function()
		ply:CM_ApplyModel()
	end)
	
end)

hook.Add( "PlayerDisconnected", "Cosmetics:OnPlayerDisconnected", function(ply)
    ply:SetNVar('CurrentChar', -1, NETWORK_PROTOCOL_PRIVATE)
end )