local meta = FindMetaTable("Player")

util.AddNetworkString("InitSpin")
util.AddNetworkString("OpenCrate")
util.AddNetworkString("FinishedUnbox")
util.AddNetworkString("GetSpawnUpdateUnbox")
util.AddNetworkString("OpenUnboxMenu")
util.AddNetworkString("UnboxUpdate")

net.Receive("FinishedUnbox" , function(len , ply)

	local index = net.ReadInt(16)
	if ply.unboxing.currentlyWaiting == true then
	
		item = ply.unboxing.items[index]

		if item.Type == "MONEY" then
            ply:addMoney(item.moneyAmount)
            ply.unboxing.currentlyWaiting = false
		end

		if item.Type == "DONATEMONEY" then
            ply:AddCredits(item.itemAmount)
            ply.unboxing.currentlyWaiting = false
		end

		if item.Type == "LEVEL" then
            ply:AddLevel(item.itemAmount)
            ply.unboxing.currentlyWaiting = false
		end

		if item.Type == "PRIVEL" then
            rp.data.AddUpgradeUID(ply, item.itemPrivel)
            ply.unboxing.currentlyWaiting = false
		end

		if item.Type == INV_HATS then
			ply:AddItem(INV_HATS, item.itemClass)
			ply.unboxing.currentlyWaiting = false
		end

		if item.Type == "entity" then
			ply:AddItem("entity", item.itemClass)
			ply.unboxing.currentlyWaiting = false
		end

        if item.Type == "weapon" then
			ply:AddItem("weapon", item.itemClass)
			ply.unboxing.currentlyWaiting = false
		end
	end
end)

function meta:OpenCrate(isGift)

	if self.unboxing.crates > 0 then

		self:RemoveCrates(1)

		self.unboxing.currentlyWaiting = true

		self:SendSpin()

	end

end

net.Receive("OpenCrate" , function(len , ply)

	ply:OpenCrate(false)


end)

function meta:SaveCrates()

	self:SetPData("CRATES" , self.unboxing.crates)

end


function meta:LoadCrates()

	local data = tonumber(self:GetPData("CRATES" , -1))

	return data

end

function meta:AddCrates(amount)

	self.unboxing.crates = self.unboxing.crates + amount

	self:SaveCrates()

	self:SendUnboxUpdate()

end

function meta:RemoveCrates(amount)

	if self.unboxing.crates - amount >= 0 then
		self.unboxing.crates = self.unboxing.crates - amount
	else
		return false
	end

	self:SaveCrates()

	self:SendUnboxUpdate()

	return true

end

function meta:SendUnboxUpdate()
	net.Start("UnboxUpdate")
		net.WriteInt(self.unboxing.crates , 16)
	net.Send(self)
end


function meta:box_initPlayer()

	self.unboxing = {}

	local crates = self:LoadCrates()

	if crates == -1 then
		
		self.unboxing.crates = 0

	else

		self.unboxing.crates = crates

	end
	self:SaveCrates()
end

net.Receive("GetSpawnUpdateUnbox" , function(len , ply)
	ply:SendUnboxUpdate()
end)

function meta:GenerateSpinList()
	local totalChance = 0

	for k , v in pairs(rp.Spin.Items) do
		totalChance = totalChance + v.itemChance
	end

	local itemList = {}

	for i = 0  , 99 do
		
		local num = math.random(1 , totalChance)
		local prevCheck = 0
		local curCheck = 0

		local item

		for k ,v in pairs(rp.Spin.Items) do
			if num >= prevCheck and num <= prevCheck + v.itemChance then
				item = v
			end

			prevCheck = prevCheck + v.itemChance
		end

		itemList[i] = item

	end

	return itemList

end

function meta:SendSpin()
	local items = self:GenerateSpinList()

	self.unboxing.items = items

	net.Start("InitSpin")
		net.WriteTable(items)
	net.Send(self)
end

hook.Add("PlayerInitialSpawn" , "SetUpKeysAndCrates" , function(ply)
 	ply:box_initPlayer()
end)
