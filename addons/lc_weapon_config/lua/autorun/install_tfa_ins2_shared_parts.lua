local function checkForSharedParts()
	if TFA and TFA.INS2 then return end -- we're 100% good

	if CLIENT then
		Derma_Query(
			"The weapon(s) you have installed requires TFA INS2 Shared Parts. Use the button below to install it.",
			"Install TFA INS2 Shared Parts !!!",
			"Workshop",
			function() gui.OpenURL("http://steamcommunity.com/workshop/filedetails/?id=866368346") end
		)
	else
		print("#################### WARNING!!! ####################")
		print("The weapon(s) you have installed requires TFA INS2 Shared Parts.")
		print("http://steamcommunity.com/workshop/filedetails/?id=866368346")
		print("####################################################")
	end
end

hook.Add("InitPostEntity", "INSTALL TFA INS2 SHARED PARTS", checkForSharedParts)