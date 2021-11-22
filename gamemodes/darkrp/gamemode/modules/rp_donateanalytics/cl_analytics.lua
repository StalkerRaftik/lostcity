net.Receive( "SendDAnalytics", function( len, pl )
	local tbl = net.ReadTable()

	// Количество БАБЛА
	for k,v in pairs(tbl) do
		for j,p in pairs(rp.shop.Mapping) do

			if v.Type == j then
				v.MoneyEarned = p.Price * v.Amount
			end
			if not v.MoneyEarned then v.MoneyEarned = -1 end
		end
	end
	table.sort(tbl, function(a, b) return a.MoneyEarned > b.MoneyEarned end )

	print('==========================================================')
	print('====================== СТАТИСТИКА ========================')
	print('==========================================================')
	for k,v in pairs(tbl) do 
		print(v.MoneyEarned .. " руб." .. "    " .. v.Type .. "   " .. v.Amount )

	end
	print('==========================================================')
end )


concommand.Add('donate_analytics', function(ply, cmd, args)
	if not args[1] then args[1] = 0 end
	local Days = args[1]
	net.Start('GetAnalyticsRequest')
		net.WriteFloat(Days) 
	net.SendToServer()

end)