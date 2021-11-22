AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
	self:PhysWake()
end

	local function updateplayer(ply)
		ply.hide_head = false
		for k,v in pairs( ply.Cosmetics ) do
			local itemdata = Cosmetics.Items[v]
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

function ENT:Use(activator, caller)
	if type(self.PlayerUse) == "function" then
		local val = self:PlayerUse(activator, caller)
		if val ~= nil then return val end
	elseif self.PlayerUse ~= nil then
		return self.PlayerUse
	end

	local class = self.weaponclass
	local weapon = ents.Create(class)

	if not weapon:IsValid() then return false end

	if not weapon:IsWeapon() then
		weapon:SetPos(self:GetPos())
		weapon:SetAngles(self:GetAngles())
		weapon:Spawn()
		weapon:Activate()
		self:Remove()
		return
	end

	local weapontab
	for k, v in pairs(rp.shipments) do
		if v.entity == class then
			weapontab = v 
		end
	end
	if weapontab and weapontab.type == "main" then
		if activator.Cosmetics[COSM_SLOT_RHAND] then
			DarkRP.notify(activator, 1, 8, "У вас уже есть основное оружие.")
			return false
		else
			for k, v in pairs(rp.shipments) do
				if v.entity == class then
					for k2, v2 in pairs(Cosmetics.Items) do
						if v2.id and v2.id == v.entity then
							local item = v2.id
							if Cosmetics.Items[k2] then -- if exists
								activator.Cosmetics = activator.Cosmetics or {}

								local data = Cosmetics.Items[k2]

								if activator.Cosmetics[data.slot] then
									DarkRP.notify(activator, 1, 8, "У вас уже есть предмет в этом слоте ("..Cosmetics.Slots[data.slot].."). Сначала снимите его")
									return false
								end


								activator.Cosmetics[data.slot] = k2
								activator:SetPData("Cosmetics_" .. data.slot, k2)
								updateplayer(activator)

								DarkRP.notify(activator, 0, 6, "Вы экипировали " .. data.name .. ".")
								self:Remove()
								activator:Give(class)

								activator:EmitSound("items/ammo_pickup.wav")

								if data.equipsound then
									activator:EmitSound( data.equipsound )
								end

								activator:NetVars("Cosmetics", activator.Cosmetics, true)

								hook.Call("CosmeticsChanged", nil, activator)

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
		if activator.Cosmetics[COSM_SLOT_LHAND] then
			DarkRP.notify(activator, 1, 8, "У вас уже есть дополнительное оружие.")
			return false
		else
			for k, v in pairs(rp.shipments) do
				if v.entity == class then
					for k2, v2 in pairs(Cosmetics.Items) do
						if v2.id and v2.id == v.entity then
							local item = v2.id
							if Cosmetics.Items[k2] then -- if exists
								activator.Cosmetics = activator.Cosmetics or {}

								local data = Cosmetics.Items[k2]

								if activator.Cosmetics[data.slot] then
									DarkRP.notify(activator, 1, 8, "У вас уже есть предмет в этом слоте ("..Cosmetics.Slots[data.slot].."). Сначала снимите его")
									return false
								end


								activator.Cosmetics[data.slot] = k2
								activator:SetPData("Cosmetics_" .. data.slot, k2)
								updateplayer(activator)

								DarkRP.notify(activator, 0, 6, "Вы экипировали " .. data.name .. ".")
								self:Remove()
								activator:Give(class)

								activator:EmitSound("items/ammo_pickup.wav")

								if data.equipsound then
									activator:EmitSound( data.equipsound )
								end

								activator:NetVars("Cosmetics", activator.Cosmetics, true)

								hook.Call("CosmeticsChanged", nil, activator)

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
		if activator.Cosmetics[COSM_SLOT_PET] then
			DarkRP.notify(activator, 1, 8, "У вас уже есть холодное оружие.")
			return false
		else
			for k, v in pairs(rp.shipments) do
				if v.entity == class then
					for k2, v2 in pairs(Cosmetics.Items) do
						if v2.id and v2.id == v.entity then
							local item = v2.id
							if Cosmetics.Items[k2] then -- if exists
								activator.Cosmetics = activator.Cosmetics or {}

								local data = Cosmetics.Items[k2]

								if activator.Cosmetics[data.slot] then
									DarkRP.notify(activator, 1, 8, "У вас уже есть предмет в этом слоте ("..Cosmetics.Slots[data.slot].."). Сначала снимите его")
									return false
								end


								activator.Cosmetics[data.slot] = k2
								activator:SetPData("Cosmetics_" .. data.slot, k2)
								updateplayer(activator)

								DarkRP.notify(activator, 0, 6, "Вы экипировали " .. data.name .. ".")
								self:Remove()
								activator:Give(class)

								activator:EmitSound("items/ammo_pickup.wav")

								if data.equipsound then
									activator:EmitSound( data.equipsound )
								end

								activator:NetVars("Cosmetics", activator.Cosmetics, true)

								hook.Call("CosmeticsChanged", nil, activator)

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


	self:Remove()
end
