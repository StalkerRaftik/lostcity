 -- ########################################
-- ## 		   	  Oxygen System 		  ##
-- ## 			Created by Jackie 		  ##
-- ##			STEAM_0:0:19997930		  ##
-- ##									  ##
-- ## 	   Hope you'll enjoy this addon   ##
-- ########################################
-- Спасибо джеки

local SecondsToDrown = 20
InWater = {}

timer.Create("OxygenHandler",1,0, function()

	for k,v in pairs ( player.GetAll() ) do
		if v:IsValid() then

			if v:WaterLevel( ) > 2 and v:Alive() then
				if InWater[v:SteamID()] == nil then InWater[v:SteamID()] = CurTime() + SecondsToDrown end
			else
			
				InWater[v:SteamID()] = nil
			
			end

			if InWater[v:SteamID()] ~= nil and InWater[v:SteamID()] < CurTime() and v:Alive() then
				if math.random(1,5) == 5 then v:EmitSound("player/pl_drown" .. math.random(2,3) .. ".wav", 100, math.random(100,120) ) end
			end
			
			if InWater[v:SteamID()] ~= nil and InWater[v:SteamID()] < CurTime() and v:Alive() then 
				v:SetHealth( v:Health() - math.random(4,6) )
				if InWater[v:SteamID()] == CurTime() then v:EmitSound("player/pl_drown1.wav") end
				if math.random(1,3) == 3 then v:EmitSound("player/pl_drown" .. math.random(1,2) .. ".wav",100, math.Clamp( v:Health() * 1.2, 70, 100 ) ) end
				if v:Health() <= 0 then
					v:SetHealth(0)
					v:Kill() 
					v:EmitSound("player/pl_drown3.wav")
				end
			end
			
		end
	end
end)