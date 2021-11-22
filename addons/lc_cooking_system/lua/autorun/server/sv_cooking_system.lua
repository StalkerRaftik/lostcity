util.AddNetworkString("CookingSystem.OpenMenu")
util.AddNetworkString("CookingSystem.Cook")
util.AddNetworkString("CookingSystem.Disassembly")
util.AddNetworkString("EmitCratfSound")

local function CancookRecipe(ply, recipe)
	local can_cook = true
	for k,v in pairs(recipe) do
		local plamount = ply:GetItemCount("entity", k)
    if plamount == 0 then plamount = ply:GetItemCount("food", k) end
		if plamount < v then
			can_cook = false
		end
	end
	return can_cook
end

sound.Add( {
  name = "cookingSound",
  channel = CHAN_STATIC,
  volume = 1,
  level = 50,
  pitch = { 95, 110 },
  sound = "ambient/machines/refrigerator.wav"
} )

net.Receive("CookingSystem.Cook", function(_, ply)
  local r_name = net.ReadString()
  local stove = net.ReadEntity()
	local recipe = CookingSystem.Recipes[r_name]
  if stove:GetCookStart() ~= 0 then
    DarkRP.notify(ply, 1, 4, "Плита уже занята!")
    return false   
  end

  -- if recipe.level and ply:GetSkill("cooking").level >= recipe.level then 

  	local item = Inventory.GetItem( "food", r_name )
    local type = INV_FOOD
    if not item then
      item = Inventory.GetItem( INV_ENTITY, r_name ) 
      type = INV_ENTITY
    end
  	if not item then DarkRP.notify(ply, 1, 4, "Кажется что-то пошло не так, сообщите администрации об этом.") return end

    local expCount = 0
  	if CancookRecipe(ply, recipe.recipe) then
  		for k,v in pairs(recipe.recipe) do
        local rtype = ply:HaveItem("food", k) and "food" or "entity"
        expCount = expCount + v
  			ply:RemoveItem( rtype, k, v )
  		end
  	end
    expCount = expCount / 1.5

    DarkRP.notify(ply, 0, 4, "Готовим "..recipe.name..".")
    stove:SetCookStart(CurTime() + recipe.time)
    stove:SetRecipe(recipe.name)

    stove:EmitSound("cookingSound")

    timer.Simple(recipe.time, function()
    	ply:AddItem( type, r_name)
      ply:AddExperience(expCount, LVL_MSG_ENUM.CRAFT)
      stove:StopSound("cookingSound")
    	DarkRP.notify(ply, 0, 4, "Вы приготовили "..recipe.name..".")
      --DarkRP.notify(ply, 0, 5, "Навык Готовка +15")
      -- ply:ProgressSkillXP( "cooking", 15 )
      stove:SetCookStart(0)
      stove:SetRecipe("")
    end)
  -- else
  --   DarkRP.notify(ply, 1, 4, "Для крафта "..tostring(recipe.name).. " нужен "..tostring(recipe.level).." уровень навыка Готовка!")
  --   return false
  -- end
end)
