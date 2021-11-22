util.AddNetworkString( "SendDAnalytics" )
util.AddNetworkString( "GetAnalyticsRequest" )

net.Receive( "GetAnalyticsRequest", function( len, ply )
	if not IsValid(ply) then return end
	if not ply:IsSuperAdmin() then return end

	local Days = net.ReadFloat()
	local time = os.time() - 60*60*24*Days // Секунды в дне
	
	db:Query('SELECT DISTINCT Upgrade FROM `kshop_purchases` ', function(Data)
		db:Query('SELECT * FROM `kshop_purchases`', function(SecondData)
			DataAnalytics = {}
			for k,type in pairs(Data) do
				local CurAmount = 0
				for k,pdata in pairs(SecondData) do
					if pdata.Upgrade == type.Upgrade then
						if Days > 0 and time < tonumber(pdata.Time) then
							CurAmount = CurAmount + 1
						elseif Days <= 0 then
							CurAmount = CurAmount + 1
						end
					end
				end
				local tbl = {}
				tbl.Type = type.Upgrade
				tbl.Amount = CurAmount
				DataAnalytics[#DataAnalytics+1] = tbl
			end




			net.Start("SendDAnalytics")
				net.WriteTable(DataAnalytics)
			net.Send(ply)
		end)
	end)
end)


