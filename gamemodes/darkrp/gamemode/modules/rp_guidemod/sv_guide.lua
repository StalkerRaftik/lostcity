util.AddNetworkString("SendGuideToClient")

hook.Add("PlayerEnteredVehicle", "VehicleGuide", function(ply) 
	ply:ShowGuide("VehicleGuide")
end)

hook.Add("PlayerEnteredVehicle", "VehicleGuide", function(ply) 
	ply:ShowGuide("VehicleGuide")
end)

hook.Add("PlayerCharLoaded", "StartGuide", function(ply)
	ply:ShowGuide("StartGuide_1")
end)

hook.Add("PlayerUseInventory", "GasmaskGuide", function(ply, type, class)
	if class == "m10" then
		ply:ShowGuide("Gasmask")
	end
end)

function PLAYER:ShowGuide(name)
	net.Start("SendGuideToClient")
		net.WriteString(name)
	net.Send(self)
end