util.AddNetworkString("CleanCosmetics")
util.AddNetworkString("Cosmetics.UpdatePlayer")
util.AddNetworkString("BroadcastCosmetics")
util.AddNetworkString("ClientInitCosmetics")

function PLAYER:HasCosmetic(cType)

    if not Cosmetics.Items[cType] then return end

    for k, i in pairs(self.Cosmetics) do
        if i == cType then return k end
    end

    return false
end

function updateplayer(ply)
    ply.hide_head = false
    for k,v in pairs( ply.Cosmetics ) do

        local class = v
        if istable(v) then
            class = v.class
        end

        local itemdata = Cosmetics.Items[class]
        if itemdata and itemdata.hide_head then
            ply.hide_head = true
        end
    end
    local b = ply:LookupBone("ValveBiped.Bip01_Head1")
    if not b then return end
    if ply.hide_head then
        ply:ManipulateBoneScale( b, Vector(0.1, 0.1, 0.1) )
    else
        ply:ManipulateBoneScale( b, Vector(1, 1, 1) )
    end
end

function PLAYER:EquipCosmetic(cType, ignoreInventory)
    if Cosmetics.Items[cType] then -- if exists
        self.Cosmetics = self.Cosmetics or {}

        local data = Cosmetics.Items[cType]

        if self.Cosmetics[data.slot] then
            DarkRP.notify(self, 1, 8, "У вас уже есть предмет в этом слоте ("..Cosmetics.Slots[data.slot].."). Сначала снимите его")
            return false
        end

        self.Cosmetics[data.slot] = cType
        -- self:SetPData("Cosmetics_" .. data.slot, cType)
 
        updateplayer(self)

        DarkRP.notify(self, 0, 6, "Вы надели " .. data.name .. ".")

        if data.equipsound then
            self:EmitSound( data.equipsound )
        end

        -- if cType == "gasmask" or cType == "m10" then
        --     self:SetNVar("GasmaskHealth", 100, NETWORK_PROTOCOL_PUBLIC)
        -- end
        
        self:NetVars("Cosmetics", self.Cosmetics, true)
        self:SavePlayerData("cosmetics", self.Cosmetics)

        hook.Call("CosmeticsChanged", nil, self)

        return true

    end

    return false

end

function PLAYER:UnequipCosmetic(cType)

    if not Cosmetics.Items[cType] then return end

    local data = Cosmetics.Items[cType]

    if self.Cosmetics[data.slot] and (self.Cosmetics[data.slot] == cType or self.Cosmetics[data.slot].class == cType) then -- if exists

        self.Cosmetics[data.slot] = nil
        updateplayer(self)

        -- self:RemovePData("Cosmetics_" .. data.slot)
        

        if data.equipsound then
            self:EmitSound( data.equipsound )
        end

        DarkRP.notify(self, 0, 6, "Вы сняли с себя " .. data.name .. ".")

        self:NetVars("Cosmetics", self.Cosmetics, true)
        self:SavePlayerData("cosmetics", self.Cosmetics)

        hook.Call("CosmeticsChanged", nil, self)

    else
        DarkRP.notify(self, 1, 6, "На вас не надета эта вещь (" .. cType .. ").")
    end

end

function PLAYER:ForceUnequipCosmetic(cType)

    if not Cosmetics.Items[cType] then return end

    local data = Cosmetics.Items[cType]

    if self.Cosmetics[data.slot] and (self.Cosmetics[data.slot] == cType or self.Cosmetics[data.slot].class == cType) then -- if exists

        self.Cosmetics[data.slot] = nil
        updateplayer(self)

        -- self:RemovePData("Cosmetics_" .. data.slot)
        

        if data.equipsound then
            self:EmitSound( data.equipsound )
        end

        DarkRP.notify(self, 0, 6, "Вы выронили " .. data.name .. ".")

        self:NetVars("Cosmetics", self.Cosmetics, true)
        self:SavePlayerData("cosmetics", self.Cosmetics)

        hook.Call("CosmeticsChanged", nil, self)

    else
        DarkRP.notify(self, 1, 6, "На вас не надета эта вещь (" .. cType .. ").")
    end

end

concommand.Add("cosmetics_give", function(ply,com,arg)
    if IsValid(ply) and not ply:IsSuperAdmin() then return end
    local ply2 = rp.FindPlayer(arg[1])
    ply2:AddItem(INV_HATS, arg[2])
    DarkRP.notify(ply2, NOTIFY_GENERIC, 5, 'Администратор ' ..ply:Nick().. ' выдал вам '..arg[2]..', проверьте инвентарь')
end)

hook.Add("PlayerDisconnected", "RemoveHats", function(ply)

    timer.Simple(1, function()
        net.Start("CleanCosmetics")
        net.WriteEntity(ply)
        net.Broadcast()
    end)

end)

hook.Add("OnPlayerChangedTeam", "GiveWeaponsBack", function(ply, prevt, t)
    for _, v in pairs(ply.CosmeticsData) do
        local class
        if istable(v) then class = v.class else class = v end
        if not Cosmetics.Items[class] then ErrorNoHalt("Invalid cosmetic '" .. class .. "' on " .. ply:Name() .. "\n") continue end
        if Cosmetics.Items[class].type == "weapon" then
            ply:Give(Cosmetics.Items[class].id)
        end
    end
    ply.Cosmetics = ply.CosmeticsData
    ply:NetVars("Cosmetics", ply.Cosmetics, true)
    ply:SavePlayerData("cosmetics", ply.Cosmetics)

    net.Start("Cosmetics.UpdatePlayer")
    net.Send(ply)    
end)

hook.Add("PlayerSpawn", "GiveWeaponsBackPlayerSpawn", function(ply)
    if ply:GetVar('CharSelected') ~= true then return false end
    
    ply:SetWeaponsGivingWithoutInventoryFlag()
    for i = 5, 6 do
        if ply.CosmeticsData[i] == nil then continue end
        
        local item = istable(ply.CosmeticsData[i]) and ply.CosmeticsData[i].class or ply.CosmeticsData[i]
        ply:Give(item)
    end
    for i = 9, 11 do
        if ply.CosmeticsData[i] == nil then continue end

        local item = istable(ply.CosmeticsData[i]) and ply.CosmeticsData[i].class or ply.CosmeticsData[i]
        ply:Give(item)
    end
    ply:RemoveWeaponsGivingWithoutInventoryFlag()
    -- for _, v in pairs(ply.CosmeticsData) do
    --     local class = v
    --     if istable(v) then class = v.class end 
    --     if not Cosmetics.Items[class] then ErrorNoHalt("Invalid cosmetic '" .. class .. "' on " .. ply:Name() .. "\n") continue end
    --     if Cosmetics.Items[class].type == "weapon" then
    --         ply:Give(class)
    --     end
    -- end
    ply.Cosmetics = ply.CosmeticsData
    ply:NetVars("Cosmetics", ply.Cosmetics, true)
    ply:SavePlayerData("cosmetics", ply.Cosmetics)

    net.Start("Cosmetics.UpdatePlayer")
    net.Send(ply)  
end)

hook.Add("PlayerDeath", "Cosmetics.PlayerDeath", function(ply)
    timer.Simple(1, function()
        net.Start("CleanCosmetics")
        net.WriteEntity(ply)
        net.Broadcast()
    end)
end)

function PLAYER:CosmeticsInitialLoad()

	-- Отправляем все свою косметику
	self:ApplyCosmetics()

	-- Получаем косметику каждого игрока
	local players_cosmetic_table = {}
	for _, pl in pairs(player.GetAll()) do
        if (istable(pl.Cosmetics)) then
            table.insert(players_cosmetic_table, {
                ent = pl,
                cosmetics = pl.Cosmetics
            })
        end
	end

	-- Обновляем
	net.Start("ClientInitCosmetics")
		net.WriteTable(players_cosmetic_table)
	net.Send(self)
end

hook.Add("PlayerDataLoaded", "CosmeticsLoader", function(ply)
    ply:CosmeticsInitialLoad()
end)

function PLAYER:ApplyCosmetics()
	self.CosmeticsReady = true

	if (istable(self.Cosmetics)) then
		net.Start("BroadcastCosmetics")
		net.WriteEntity(self)
		net.WriteTable(self.Cosmetics)
		net.Broadcast()
	end
end