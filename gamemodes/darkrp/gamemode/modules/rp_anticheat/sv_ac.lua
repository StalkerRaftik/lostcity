local nextlog = 0

function net.Incoming( len, client )
	--print(len .. " " .. client:GetName())
	local i = net.ReadHeader()
	local strName = util.NetworkIDToString( i )
	
	if ( !strName ) then return end
	
	local func = net.Receivers[ strName:lower() ]
	if ( !func ) then return end

	--
	-- new code
	--
	len = len - 16
	
	if IsValid(client) then
		client.netcache = (client.netcache or 0) + 1
		timer.Simple(5, function()
			if IsValid(client) then
				client.netcache = (client.netcache or 0) - 1
			end
		end)

		if client.netcache > 200 then
			if CurTime() > nextlog then
				local Timestamp = os.time()
				local TimeString = os.date( "%H:%M:%S - %d/%m/%Y" , Timestamp )

				if not file.Exists("lognetfucker.txt","DATA") then	
					file.Write("lognetfucker.txt",client:Name().." ("..client:SteamID()..") - "..TimeString.."  NET: "..strName or ''.."\n")
				else
					file.Append("lognetfucker.txt",client:Name().." ("..client:SteamID()..") - "..TimeString.."  NET: "..strName or ''.."\n")
				end
				nextlog = CurTime() + 15
			end
      
      ba.bans.Ban(client, "[AntiCheat] Net exploit detected", 0)
		end
	end

	func( len, client )
end