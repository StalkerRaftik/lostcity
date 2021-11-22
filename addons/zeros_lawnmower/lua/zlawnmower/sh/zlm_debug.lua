zlm = zlm or {}
zlm.f = zlm.f or {}

if SERVER then
	concommand.Add("zlm_debug_grasspile_add", function(ply, cmd, args)
		if IsValid(ply) and zlm.f.IsAdmin(ply) then
			local tr = ply:GetEyeTrace()
			local trEntity = tr.Entity

			if IsValid(trEntity) then

				if trEntity:GetClass() == "zlm_unload" then

					trEntity:SetGrassCount(math.Clamp(trEntity:GetGrassCount() + 100, 0, 1000))
					print("Grass: " .. trEntity:GetGrassCount())

				elseif trEntity:GetClass() == "zlm_grasspress" then
					zlm.f.AddGrass(trEntity,100)
				end
			end
		end
	end)

	concommand.Add("zlm_debug_grasspile_remove", function(ply, cmd, args)
		if IsValid(ply) and zlm.f.IsAdmin(ply) then
			local tr = ply:GetEyeTrace()
			local trEntity = tr.Entity

			if IsValid(trEntity) and (trEntity:GetClass() == "zlm_unload" or trEntity:GetClass() == "zlm_grasspress")  then
				trEntity:SetGrassCount(math.Clamp(trEntity:GetGrassCount() - 100, 0, 1000))
				print("Grass: " .. trEntity:GetGrassCount())
			end
		end
	end)

	concommand.Add( "zlm_debug_SendGrassSpotToPlayers", function( ply, cmd, args )
	    if IsValid(ply) and zlm.f.IsAdmin(ply) then
	        zlm.f.Send_GrassSpots_ToClient(ply)
	    end
	end )

	concommand.Add( "zlm_debug_RefreshAllGrass", function( ply, cmd, args )
	    if IsValid(ply) and zlm.f.IsAdmin(ply) then
	        for k, v in pairs(zlm_GrassSpots) do
	            if v.mowed then
	                zlm.f.Refresh_GrassSpot(k)
	                v.mowed = false
	            end
	        end
	    end
	end )
end
