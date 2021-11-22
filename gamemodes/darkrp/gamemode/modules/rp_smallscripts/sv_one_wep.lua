function PLAYER:SetWeaponsGivingWithoutInventoryFlag()
	self.givingbaseweapons = true
end

function PLAYER:RemoveWeaponsGivingWithoutInventoryFlag()
	self.givingbaseweapons = nil
end

hook.Add( "PlayerCanPickupWeapon", "rp.Inventory.OneWep", function( ply, wep )
	local class = wep:GetClass()
	local weapontab
	for k, v in pairs(rp.shipments) do
		if v.entity == class then
			weapontab = v 
		end
	end
	if ply.givingbaseweapons then return true end
	if weapontab and weapontab.type == "main" then
		if ply.Cosmetics[COSM_SLOT_RHAND] then
			--DarkRP.notify(ply, 1, 8, "У вас уже есть основное оружие.")
			return false
		else
			for k, v in pairs(rp.shipments) do
				if v.entity == class then
					for k2, v2 in pairs(Cosmetics.Items) do
						if v2.id and v2.id == v.entity then
							local item = v2.id
							if Cosmetics.Items[k2] then -- if exists
								if ply.givingbaseweapons then return true end

								ply.Cosmetics = ply.Cosmetics or {}

								local data = Cosmetics.Items[k2]

								if ply.Cosmetics[data.slot] then
									DarkRP.notify(ply, 1, 8, "У вас уже есть предмет в этом слоте ("..Cosmetics.Slots[data.slot].."). Сначала снимите его")
									return false
								end

								ply.Cosmetics[data.slot] = {
									class = k2,
									ammo = 0,
									health = 100,
								}
								ply:SetPData("Cosmetics_" .. data.slot, k2)
								updateplayer(ply)

								DarkRP.notify(ply, 0, 6, "Вы экипировали " .. data.name .. ".")
								-- ply:RemoveItem(type, class)
								ply:EmitSound("items/ammo_pickup.wav")

								if data.equipsound then
									ply:EmitSound( data.equipsound )
								end

								ply:NetVars("Cosmetics", ply.Cosmetics, true)
								ply:SavePlayerData("cosmetics", ply.Cosmetics)

								hook.Call("CosmeticsChanged", nil, ply)

								return true

							end

							
							return true
						end
					end
					return true
				end
			end
			return true
		end
	elseif weapontab and weapontab.type == "pistol" then
		if ply.Cosmetics[COSM_SLOT_LHAND] then
			--DarkRP.notify(ply, 1, 8, "У вас уже есть дополнительное оружие.")
			return false
		else
			for k, v in pairs(rp.shipments) do
				if v.entity == class then
					for k2, v2 in pairs(Cosmetics.Items) do
						if v2.id and v2.id == v.entity then
							local item = v2.id
							if Cosmetics.Items[k2] then -- if exists
								if ply.givingbaseweapons then return true end
								ply.Cosmetics = ply.Cosmetics or {}

								local data = Cosmetics.Items[k2]

								if ply.Cosmetics[data.slot] then
									DarkRP.notify(ply, 1, 8, "У вас уже есть предмет в этом слоте ("..Cosmetics.Slots[data.slot].."). Сначала снимите его")
									return false
								end


								ply.Cosmetics[data.slot] = {
									class = k2,
									ammo = 0,
									health = 100,
								}
								ply:SetPData("Cosmetics_" .. data.slot, k2)
								updateplayer(ply)

								DarkRP.notify(ply, 0, 6, "Вы экипировали " .. data.name .. ".")
								-- self:Remove()
								ply:Give(class)

								ply:EmitSound("items/ammo_pickup.wav")

								if data.equipsound then
									ply:EmitSound( data.equipsound )
								end

								ply:NetVars("Cosmetics", ply.Cosmetics, true)
								ply:SavePlayerData("cosmetics", ply.Cosmetics)

								hook.Call("CosmeticsChanged", nil, ply)

								return true

							end

							
							return true
						end
					end
					return true
				end
			end
			return true
		end
	elseif weapontab and weapontab.type == "knife" then
		if ply.Cosmetics[COSM_SLOT_PET] then
			--DarkRP.notify(ply, 1, 8, "У вас уже есть холодное оружие.")
			return false
		else
			for k, v in pairs(rp.shipments) do
				if v.entity == class then
					for k2, v2 in pairs(Cosmetics.Items) do
						if v2.id and v2.id == v.entity then
							local item = v2.id
							if Cosmetics.Items[k2] then -- if exists
								if ply.givingbaseweapons then return true end
								
								ply.Cosmetics = ply.Cosmetics or {}

								local data = Cosmetics.Items[k2]

								if ply.Cosmetics[data.slot] then
									DarkRP.notify(ply, 1, 8, "У вас уже есть предмет в этом слоте ("..Cosmetics.Slots[data.slot].."). Сначала снимите его")
									return false
								end


								ply.Cosmetics[data.slot] = k2
								ply:SetPData("Cosmetics_" .. data.slot, k2)
								updateplayer(ply)

								DarkRP.notify(ply, 0, 6, "Вы экипировали " .. data.name .. ".")
								-- self:Remove()
								ply:Give(class)

								ply:EmitSound("items/ammo_pickup.wav")

								if data.equipsound then
									ply:EmitSound( data.equipsound )
								end

								ply:NetVars("Cosmetics", ply.Cosmetics, true)
								ply:SavePlayerData("cosmetics", ply.Cosmetics)

								hook.Call("CosmeticsChanged", nil, ply)

								return true

							end

							
							return true
						end
					end
					return true
				end
			end
			return true
		end
	end

end )