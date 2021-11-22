util.AddNetworkString("Inventory.OpenMenuTrader")
util.AddNetworkString("rp.Traders.BuyItem")
util.AddNetworkString("rp.Traders.SellItem")
util.AddNetworkString("Inventory.UpdateTraderMenu")

net.Receive("rp.Traders.BuyItem", function(_, ply)
	if not IsValid(ply) then return end
	local class = net.ReadString()
	local type = net.ReadString()
	local count = net.ReadInt(32)
	local id = net.ReadString()
	rp.Traders.BuyItem(class, type, count, id, ply)
end)

function rp.Traders.BuyItem(class, type, count, id, ply)
	if count <= 0 then return end

	local price = rp.Traders.Config[id].items[class].price
	if not price then return end

	if not ply:CanAfford(price*count) then 
		DarkRP.notify(ply, 1, 1, "Вы не можете позволить себе купить это!")
		return false
	end

	local weight = count * Inventory.GetWeight(type, class)

	if not ply:HaveSpace(weight) then
		DarkRP.notify(ply, 1, 1, "В вашем инвентаре недостаточно места!")
		return false
	end

	local itemTable = Inventory.GetItem(type, class)
	if not itemTable then return end

	ply:TakeMoney(-price*count)
	ply:AddItem(type, class, count)

	net.Start("Inventory.UpdateTraderMenu")
	net.WriteEntity(ply)
	net.WriteString(id)
	net.Send(ply)

	DarkRP.notify(ply, 3, 2, "Вы купили "..count.." шт.".. " "..itemTable.name)
	hook.Run( "rp.inv.BuyItem", ply, type, class, count )	
end

net.Receive("rp.Traders.SellItem", function(_, ply)
	if not IsValid(ply) then return end
	local class = net.ReadString()
	local type = net.ReadString()
	local key = net.ReadInt(32)
	local count = net.ReadInt(32)
	local id = net.ReadString()
	rp.Traders.SellItem(class, type, key, count, id, ply)
end)

function rp.Traders.SellItem(class, type, key, count, id, ply)

	if count <= 0 then return end

	local price = rp.Traders.Config[id].itemsforbuy[class]
	if not price then return end
	

	local itemTable = Inventory.GetItem(type, class)
	if not itemTable then return end


	if ply.inv[type][class][key].count < count then 
		DarkRP.notify(ply, 1, 1, "В вашем инвентаре нет "..count.. " шт. "..itemTable.name )
		return false
	end

	ply:AddMoney(price*count)
	ply:RemoveItemByKey(type, class, key, count)

	net.Start("Inventory.UpdateTraderMenu")
	net.WriteEntity(ply)
	net.WriteString(id)
	net.Send(ply)

	DarkRP.notify(ply, 3, 1, "Вы продали "..count.." шт.".. " "..itemTable.name)
	hook.Run( "rp.inv.SellItem", ply, type, class, count )	
end

