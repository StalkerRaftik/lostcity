util.AddNetworkString("R_CraftSystem.OpenMenu")
util.AddNetworkString("R_CraftSystem.Craft")
util.AddNetworkString("R_CraftSystem.Disassembly")

local function CanCraftRecipe(ply, recipe)
	local can_craft = true
	for k,v in pairs(recipe) do
		local plamount = ply:GetItemCount("entity", k)
		if plamount < v then
			can_craft = false
		end
	end
	return can_craft
end

net.Receive("R_CraftSystem.Craft", function(_, ply)
	local r_name = net.ReadString()
	if not r_name then return end
	local recipe = R_CraftSystem.Recipes[r_name]
	if not recipe then return end

	if recipe.ent ~= nil then r_name = recipe.ent end

	local category

	for k, v in pairs(R_CraftSystem.Categories) do
		if v.name == recipe.category then 
			category = v.category
		end
	end

	if not category then return false end

	local item = Inventory.GetItem( category, r_name )
	if not item then DarkRP.notify(ply, 1, 4, "Кажется что-то пошло не так, сообщите администрации об этом.") return false end

	if ply.craft_used and ply.craft_used > CurTime() then 
		DarkRP.notify(ply, 1, 4, "Вы должны подождать "..math.Round(ply.craft_used - CurTime()).."с!")
		return false
	end

	local craftCost = GetCraftPrice(r_name)
	local expForCraft = math.floor(craftCost / 1.5)

	ply:StartProgressBar(5, function()
		ply.craft_used = CurTime() + R_CraftSystem.UsageCooldown
		if not ply:CanAfford(craftCost) then
			DarkRP.notify(ply, 0, 4, "У вас недостаточно монет для оплаты владельцам базы.")
			return
		end
		if CanCraftRecipe(ply, recipe.recipe) then
			for k,v in pairs(recipe.recipe) do
				ply:RemoveItem( "entity", k, v )
			end
			ply:TakeMoney(craftCost)
			ply:AddExperience(expForCraft, LVL_MSG_ENUM.CRAFT)
			ply:AddItem( category, r_name, recipe.count or 1 )

			DarkRP.notify(ply, 0, 4, "Создание прошло успешно")
		end
	end, "Создаю...")
end)


net.Receive("R_CraftSystem.Disassembly", function(_, ply)
	local r_name = net.ReadString()
	if not r_name then return end
	local item = R_CraftSystem.Disassembly[r_name]
	if not item then return end

	local has_item = ply:HaveItem("entity", r_name)
	if not has_item then 
		DarkRP.notify(ply, 1, 4, "У тебя нет этого предмета!")
		return false
	end
	
	ply:RemoveItem("entity", r_name, 1 )

	for k,v in pairs(item.player_get) do
		local item2 = Inventory.GetItem( "entity", k )
		if not item2 then DarkRP.notify(ply, 1, 4, "Кажется что-то пошло не так, сообщите администрации об этом.") return false end
		if istable(v) then
			local rand = math.random(v[1], v[2])

			if rand > 0 then 
				ply:AddItem("entity", k, rand)
				DarkRP.notify(ply, 1, 4, "Вы получили " .. rand .." ".. Inventory.GetItem("entity", k).name )
			end
		else
			ply:AddItem("entity", k, v)
			DarkRP.notify(ply, 1, 4, "Вы получили " .. v .." ".. Inventory.GetItem("entity", k).name )
		end
	end

	local itemname = Inventory.GetItem( "entity", r_name )
	if not itemname then DarkRP.notify(ply, 1, 4, "Кажется что-то пошло не так, сообщите администрации об этом.") return false end

	DarkRP.notify(ply, 0, 4, "Вы разобрали "..itemname.name..".")
end)