util.AddNetworkString("rp.Market.Sync")
util.AddNetworkString("rp.Market.BuyItem")
util.AddNetworkString("rp.Market.SellItem")
util.AddNetworkString("rp.Market.Refresh")
util.AddNetworkString("rp.Market.RefreshSeller")
util.AddNetworkString("rp.Market.RemoveItem")
util.AddNetworkString("rp.Market.SyncFromMenu")
util.AddNetworkString("rp.Market.TakeBankMoney")

hook.Add("Initialize", "rp.Market.CreateDB", function()
	db:Query("CREATE TABLE IF NOT EXISTS rp_market(itemid INT NOT NULL AUTO_INCREMENT PRIMARY KEY, marketid INT NOT NULL, seller VARCHAR(255) NOT NULL, sellername TEXT NOT NULL, category TEXT NOT NULL, class TEXT NOT NULL, ikey INT NOT NULL, price INT NOT NULL, tbl TEXT NOT NULL, exptime INT NOT NULL)")
end)

hook.Add("Initialize", "rp.Market.CreateDB2", function()
	db:Query("CREATE TABLE IF NOT EXISTS rp_marketbank(SteamID VARCHAR(255) NOT NULL, money INT NOT NULL)")
end)

hook.Add("PlayerDataLoaded", "rp.Market.SetBankMoney", function(ply)
	db:Query('SELECT * FROM rp_marketbank WHERE SteamID=' .. ply:SteamID64() .. ';', function(_data)
		local data = _data[1] or {}

        if IsValid(ply) then
            if (#_data <= 0) then
                db:Query('INSERT INTO rp_marketbank(SteamID, money) VALUES(?, ?);', ply:SteamID64(), 0)
                ply:SetNVar('MarketMoney', 0, NETWORK_PROTOCOL_PRIVATE)
            else
                ply:SetNVar('MarketMoney', data.money, NETWORK_PROTOCOL_PRIVATE)
            end
        end
    end)
end)

net.Receive("rp.Market.TakeBankMoney", function(_, ply)
	db:Query('SELECT * FROM rp_marketbank WHERE SteamID=' .. ply:SteamID64() .. ';', function(_data)
		local data = _data[1] or {}

        if IsValid(ply) then
            if (#_data <= 0) then
                return false
            else
                if data.money <= 0 then return end
                ply:AddMoney(math.floor(data.money))
                DarkRP.notify(ply, 3, 2, "Вы сняли с баланса: "..data.money.." монет.")
                db:Query('UPDATE rp_marketbank SET money=? WHERE SteamID=' .. ply:SteamID64() .. ';', 0, function(data) end)
                ply:SetNVar('MarketMoney', 0, NETWORK_PROTOCOL_PRIVATE)
            end
        end
    end)
end)

function rp.Market.AddBankMoney(ply, num)
    if IsValid(ply) then
        db:Query('SELECT * FROM rp_marketbank WHERE SteamID=' .. ply:SteamID64() .. ';', function(_data)
            local data = _data[1] or {}
            db:Query('UPDATE rp_marketbank SET money=? WHERE SteamID=' .. ply:SteamID64() .. ';', math.floor(data.money + num), function(data2) end)
            ply:SetNVar('MarketMoney', math.floor(data.money + num), NETWORK_PROTOCOL_PRIVATE)
        end)
    end
end

net.Receive("rp.Market.SyncFromMenu", function()
    rp.Market.Sync()
end)

function rp.Market.ReturnItem(steamid64, type, class, count)
    count = count or 1

    if IsValid(rp.FindPlayer(steamid64)) then
        rp.FindPlayer(steamid64):AddItemT(type, class, count)
    else 
        db:Query('SELECT * FROM darkrp_inventory WHERE SteamID64=' .. steamid64 .. ';', function(data)
            local inv = util.JSONToTable(data[1].data)
            if inv[type][class] then
                inv[type][class] = inv[type][class] + count
            else
                inv[type][class] = count
            end

            db:Query('UPDATE darkrp_inventory SET data=? WHERE steamid64=' .. steamid64 .. ';', util.TableToJSON(inv))
        end)
    end
end

function rp.Market.Sync()
    db:Query('SELECT * FROM rp_market WHERE exptime <= ' .. os.time() ..';', function(_data)
        for k, data in pairs(_data) do
            rp.Market.ReturnItem(data.seller, data.category, data.class, data.count)
        end
        db:Query('DELETE FROM rp_market WHERE exptime <= ' .. os.time() ..';')
    end)
    


    db:Query('SELECT * FROM rp_market', function(data)
       rp.Market.Data = data
        net.Start("rp.Market.Sync")
        net.WriteTable(rp.Market.Data)
        net.Broadcast()
    end)
    
    -- Синхранизируем товары сервер-клиент
end

-- Не забыть добавить проверки для покупки/продажи (деньги и предметы + место)

function rp.Market.SellItem(seller, marketid, itemPrice, itemCategory, itemClass, itemKey, itemTbl, days)

-- Ограничения количества продаж для игроков различных групп
    db:Query("SELECT tbl FROM rp_market WHERE seller="..seller:SteamID64()..";", function(_data)
        PrintTable(_data)
        if #_data >= 100 then
            DarkRP.notify(seller, 3, 2, "Вы достигли лимита лотов для продажи!")
            return false
        end
        -- if seller:IsSponsor() then
        --     if tonumber(data.count) >= 100 then
        --         DarkRP.notify(seller, 3, 2, "Вы не можете иметь более 100 лотов одновременно, улучшите свой статус (F6)!")
        --         return false
        --     end
        -- elseif seller:IsPremium() then
        --     if tonumber(data.count) >= 60 then
        --         DarkRP.notify(seller, 3, 2, "Вы не можете иметь более 60 лотов одновременно, улучшите свой статус (F6)!")
        --         return false 
        --     end  
        -- elseif seller:IsVIP() then
        --     if tonumber(data.count) >= 30 then
        --         DarkRP.notify(seller, 3, 2, "Вы не можете иметь более 30 лотов одновременно, улучшите свой статус (F6)!")
        --         return false
        --     end
        -- elseif seller:IsIgrokPlus() then
        --     if tonumber(data.count) >= 15 then
        --         DarkRP.notify(seller, 3, 2, "Вы не можете иметь более 15 лотов одновременно, улучшите свой статус (F6)!")
        --         islimreached = true  
        --     end
        -- elseif tonumber(data.count) >= 10 then
        --     DarkRP.notify(seller, 3, 2, "Вы не можете иметь более 10 лотов одновременно, улучшите свой статус (F6)!")
        --     return false
        -- end 

        local count = itemTbl.count

        if itemPrice > 1000000 then
            DarkRP.notify(seller, 3, 2, "Слишком большая стоимость!")
            return false
        end

        local pricetbl = {math.modf(itemPrice*0.06)}
        local itemPrice = math.Round(itemPrice + (itemPrice*0.06))
        if pricetbl[2] < 0.5 then itemPrice = itemPrice + 1 end

        if count <= 0 then return end

        local itemTable = Inventory.GetItem(itemCategory, itemClass)
        if not itemTable then
            DarkRP.notify(seller, 3, 2, "Ошибка инвентаря: Предмет не найден. Обратитесь к администратору, указав ошибку.")
            return 
        end

        if seller.inv[itemCategory][itemClass][itemKey].count < count then 
            DarkRP.notify(seller, 3, 2, "У вас нет такого количества предметов.")
            return 
        end

        if seller.inv[itemCategory][itemClass][itemKey].droppable == false then
            DarkRP.notify(ply, 1, 4, "Вы не можете продать данное снаряжение!")
            return false
        end

        db:Query('INSERT INTO rp_market (marketid, seller, sellername, category, class, ikey, price, tbl, exptime) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?);', marketid, seller:SteamID64(), seller:GetNVar('Name'), itemCategory, itemClass, itemKey, itemPrice, util.TableToJSON(itemTbl), os.time()+(60*60*24*days), function(data)
            seller:RemoveItemByKey(itemCategory, itemClass, itemKey, count)
            DarkRP.notify(seller, 3, 2, "Вы выставили на продажу "..count.." шт.".. " "..itemTable.name.." на одну неделю.")

            hook.Run( "rp.Market.StartSell", seller, itemClass)

            timer.Simple(.1, function()
                rp.Market.Sync()
                net.Start("rp.Market.RefreshSeller")
                net.WriteInt(marketid, 32)
                net.WriteString(itemCategory)
                net.Send(seller)
            end)
        end)
    end)

    -- if not seller:CanAfford(math.Round(itemPrice*0.01*itemtbl.count*days)+1) then 
    --     DarkRP.notify(buyer, 1, 1, "Вы не можете позволить себе покрыть взнос!")
    --     return false
    -- end
    
   

    
end

net.Receive("rp.Market.SellItem", function(_, ply)
	if not IsValid(ply) then return end
    local itemCategory = net.ReadString()
    local itemClass = net.ReadString()
    local itemKey = net.ReadInt(31)
    local itemTbl = net.ReadTable()
    local itemPrice = net.ReadInt(32)
    local marketID = net.ReadInt(5)
    local days = net.ReadInt(8)
    rp.Market.SellItem(ply, marketID, itemPrice, itemCategory, itemClass, itemKey, itemTbl, days)
end)

function rp.Market.BuyItem(buyer, itemID, itemPrice, itemCategory, itemClass, itemCount)
    local count = itemCount or 1
    local itemPrice2 = math.floor(itemPrice - (itemPrice*0.06))

	if count <= 0 then return end

	local itemTable = Inventory.GetItem(itemCategory, itemClass)
	if not itemTable then
        DarkRP.notify(buyer, 3, 2, "Ошибка инвентаря: Предмет не найден. Обратитесь к администратору, указав ошибку.")
        return 
    end

	if not buyer:CanAfford(itemPrice*count) then 
		DarkRP.notify(buyer, 1, 1, "Вы не можете позволить себе купить это!")
		return false
	end

	local weight = count * Inventory.GetWeight(itemCategory, itemClass)

	if not buyer:HaveSpace(weight) then
		DarkRP.notify(buyer, 1, 1, "В вашем инвентаре недостаточно места!")
		return false
	end

    db:Query('SELECT * FROM rp_market WHERE itemid = '..itemID..';', function(data)

    	if istable(data) and not table.IsEmpty(data) then
            local tbl = util.JSONToTable(data[1].tbl)
            if count > tbl.count then
                DarkRP.notify(buyer, 1, 1, "Предмет не найден или его нет в таком количестве")
                return false
            end
            if tbl.count - count == 0 then
                db:Query("DELETE FROM rp_market WHERE itemid = "..itemID..";", function(data2)
                    local attr = table.Copy(tbl)
                    attr.count = count
                    buyer:AddItem(itemCategory, itemClass, attr)
                    DarkRP.notify(buyer, 3, 2, "Вы купили "..count.." шт.".. " "..itemTable.name)

                    buyer:TakeMoney(data[1].price*count)

                    if IsValid(rp.FindPlayer(data[1].seller)) then
                        rp.Market.AddBankMoney(rp.FindPlayer(data[1].seller), itemPrice2*count)
                        DarkRP.notify(rp.FindPlayer(data[1].seller), 3, 2, "У вас купили "..count.." шт.".. " "..itemTable.name)
                    else
                        -- db:Query('UPDATE rp_marketbank SET money=? WHERE SteamID=' .. data[1].seller .. ';', itemPrice2*count, function(data) end)
                        db:Query('SELECT * FROM rp_marketbank WHERE SteamID=' .. data[1].seller .. ';', function(_data)
                            local data = _data[1] or {}
                            db:Query('UPDATE rp_marketbank SET money=? WHERE SteamID=' .. data.SteamID .. ';', data.money + itemPrice2*count, function(data2) end)
                        end)
                    end
    
                    hook.Run( "rp.Market.Buyitem", buyer, itemClass)
                    timer.Simple(.1, function()
                        rp.Market.Sync()
                        net.Start("rp.Market.Refresh")
                        net.WriteInt(data[1].marketid, 32)
                        net.WriteString(itemCategory)
                        net.Send(buyer)
                    end)
                end)
            else
                local tbl2 = table.Copy(tbl)
                tbl2.count = tbl2.count - count
                db:Query("UPDATE rp_market SET tbl=? WHERE itemid = "..itemID..";", util.TableToJSON(tbl2) , function(data2)
                    local attr = table.Copy(tbl)
                    attr.count = count
                    buyer:AddItem(itemCategory, itemClass, attr)
                    DarkRP.notify(buyer, 3, 2, "Вы купили "..count.." шт.".. " "..itemTable.name)

                    buyer:TakeMoney(itemPrice*count)

                    if rp.FindPlayer(data[1].seller) then
                        rp.Market.AddBankMoney(rp.FindPlayer(data[1].seller), itemPrice2*count)
                        DarkRP.notify(rp.FindPlayer(data[1].seller), 3, 2, "У вас купили "..count.." шт.".. " "..itemTable.name)
                    else
                        -- db:Query('UPDATE rp_marketbank SET money=? WHERE SteamID=' .. data[1].seller .. ';', itemPrice2*count, function(data) end)
                        db:Query('SELECT * FROM rp_marketbank WHERE SteamID=' .. data[1].seller .. ';', function(_data)
                            local data = _data[1] or {}
                            db:Query('UPDATE rp_marketbank SET money=? WHERE SteamID=' .. data.SteamID .. ';', data.money + itemPrice2*count, function(data2) end)
                        end)
                    end
         
                    hook.Run( "rp.Market.Buyitem", buyer, itemClass)
                    timer.Simple(.1, function()
                        rp.Market.Sync()
                        net.Start("rp.Market.Refresh")
                        net.WriteInt(data[1].marketid, 32)
                        net.WriteString(itemCategory)
                        net.Send(buyer)
                    end)
                end)
            end
    	else
            DarkRP.notify(buyer, 1, 1, "Предмет не найден или его нет в таком количестве")
            return false
        end
    end)
end

net.Receive("rp.Market.RemoveItem", function(_, ply)
    local itemID = net.ReadInt(32)
    local itemCount = net.ReadInt(31)
    local marketid = net.ReadInt(5)
    local itemCategory = net.ReadString()

    rp.Market.RemoveItem(ply, itemID, itemCount)
end)

function rp.Market.RemoveItem(itemOwner, itemID, itemCount)

	if itemCount <= 0 then return end

    db:Query("SELECT * FROM rp_market WHERE itemid = "..itemID.." and seller = ".. itemOwner:SteamID64() ..";", function(data)
        if (#data <= 0) then 
            DarkRP.notify(itemOwner, 1, 1, "Предмет не найден")
            return false
        end
        data[1].tbl = util.JSONToTable(data[1].tbl)
        PrintTable(data[1])
        local itemTable = Inventory.GetItem(data[1].category, data[1].class)
        if not itemTable then
            DarkRP.notify(itemOwner, 3, 2, "Ошибка инвентаря: Предмет не найден. Обратитесь к администратору, указав ошибку.")
            return 
        end

	    local weight = itemCount * Inventory.GetWeight(data[1].category, data[1].class)

        if not itemOwner:HaveSpace(weight) then
            DarkRP.notify(itemOwner, 1, 1, "В вашем инвентаре недостаточно места!")
            return false
        end

        if itemCount > data[1].tbl.count then
            DarkRP.notify(itemOwner, 3, 2, "На рынке нет такого количества предметов!")
            return 
        end

        local itemTbl = table.Copy(data[1].tbl)
        itemTbl.count = itemCount
        itemOwner:AddItem(data[1].category, data[1].class, itemTbl)

        if itemCount == data[1].tbl.count then
            db:Query("DELETE FROM rp_market WHERE itemid = "..itemID.." and seller = ".. itemOwner:SteamID64() ..";", function(data) end)
        elseif itemCount < data[1].tbl.count then
            data[1].tbl.count = data[1].tbl.count - itemCount
            db:Query('UPDATE rp_market SET tbl=? WHERE itemid=' .. itemID .. ';', util.TableToJSON(data[1].tbl))
        end
        
        DarkRP.notify(itemOwner, 3, 2, "Вы сняли с продажи "..itemTable.name.." ("..itemCount.." шт.)")
        timer.Simple(.1, function()
            rp.Market.Sync()
            net.Start("rp.Market.RefreshSeller")
            net.WriteInt(data[1].marketid, 32)
            net.WriteString(data[1].category)
            net.Send(itemOwner)
        end)

        
    end)
end

net.Receive("rp.Market.BuyItem", function(_, ply)
	if not IsValid(ply) then return end
    local itemID = net.ReadInt(32)
    local itemCount = net.ReadInt(31)
    for k, data in pairs(rp.Market.Data) do
        if data.itemid == itemID then
            rp.Market.BuyItem(ply, itemID, data.price, data.category, data.class, itemCount)
            return
        end
    end
    DarkRP.notify(ply, 1, 1, "Предмет не найден или его нет в таком количестве")
end)
