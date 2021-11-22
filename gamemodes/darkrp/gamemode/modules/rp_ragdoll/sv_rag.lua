util.AddNetworkString("KnockoutTimer")

local function MakeInvisible(player, invisible)
	player:SetNoDraw(invisible);
	player:SetNotSolid(invisible);
	
	player:DrawViewModel(!invisible);
	player:DrawWorldModel(!invisible);

	if (invisible) then
		player:GodEnable();
	else
		player:GodDisable();
	end;
end;

local function PlayerSpawn(pPlayer)
	pPlayer:SetNWBool("Ragdolled", false)

	MakeInvisible(pPlayer, false);
	pPlayer:SetNWBool("Ragdolled", false)  

	-- PlayerUnKnockout(pPlayer)

	-- net.Start("KnockoutTimer")
	-- 	net.WriteBool(false)
	-- net.Send(pPlayer)		
	-- pPlayer:SetNVar("PlayerRagdoll", nil, NETWORK_PROTOCOL_PUBLIC)

end
hook.Add("PlayerLoadout", "PlayerSpawnSF", PlayerSpawn)

timer.Create("DeleteRagdolls", 300, 0, function()
	for k, v in pairs(ents.GetAll()) do
		if v:GetClass() == "prop_ragdoll" and v.lifetime and v.lifetime < CurTime() then
			v:Remove()
		end
	end
end)

function CreatePlayerRagdoll(pPlayer)
	pPlayer:SetNWBool("Ragdolled", true)

	pPlayer.eRagdoll = ents.Create("prop_ragdoll");
	pPlayer.eRagdoll:SetPos(pPlayer:GetPos());
	pPlayer.eRagdoll:SetModel(pPlayer:GetModel());
	pPlayer.eRagdoll:SetAngles(pPlayer:GetAngles());
	pPlayer.eRagdoll:SetSkin(pPlayer:GetSkin());
	pPlayer.eRagdoll:SetMaterial(pPlayer:GetMaterial());
	pPlayer.eRagdoll:Spawn();
	pPlayer.eRagdoll.lifetime = CurTime() + 900
	pPlayer.eRagdoll.player = pPlayer
  -- pPlayer.eRagdoll.Cosmetics = pPlayer.Cosmetics
	pPlayer.eRagdoll:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER);
	pPlayer:SetNVar("PlayerRagdoll", pPlayer.eRagdoll, NETWORK_PROTOCOL_PUBLIC)

	timer.Simple(400, function()
		if pPlayer.eRagdoll and IsValid(pPlayer.eRagdoll) then
			pPlayer.eRagdoll:Remove()
		end
	end)
	
	local velocity = pPlayer:GetVelocity();
	local physObjects = pPlayer.eRagdoll:GetPhysicsObjectCount() - 1;
	
	for i = 0, physObjects do
		local bone = pPlayer.eRagdoll:GetPhysicsObjectNum(i);
		
		if (IsValid(bone)) then
			local position, angle = pPlayer:GetBonePosition(pPlayer.eRagdoll:TranslatePhysBoneToBone(i));
			
			if (position and angle) then
				bone:SetPos(position);
				bone:SetAngles(angle);
			end;
			
			bone:AddVelocity(velocity);
		end;
	end;

	-- timer.Simple(0.5,function()
	--    netstream.Start(player.GetAll(), "UpdateRagdollClothes", {tblClothes = pPlayer.eRagdoll.Cosmetics, eRagdoll = pPlayer.eRagdoll, pPlayer = pPlayer})
	--  end)


	pPlayer:RemoveNotDroppableItems()
	pPlayer.eRagdoll.inv = pPlayer.inv
	pPlayer.eRagdoll.IsStorage = true

	if pPlayer.Cosmetics ~= nil then
	 	for k, v in pairs(pPlayer.Cosmetics) do
	 		local class = v.class or v
			if Cosmetics.Items[class].type == "weapon" then
				local attr = {}
				attr.health = v.health
				attr.ammo = v.ammo
				attr.count = 1
	 			pPlayer.eRagdoll:AddItem(INV_WEAPON, class, attr)
			else
				pPlayer.eRagdoll:AddItem(INV_HATS, class, {count = 1})
			end
	 	end
	end

	pPlayer.Cosmetics = {}
	pPlayer.CosmeticsData = {}

	-- for k,v in pairs( Cosmetics.Def ) do
	-- 	pPlayer:RemovePData("Cosmetics_" .. v)
	-- end

	pPlayer:SavePlayerData("cosmetics", pPlayer.Cosmetics)

	pPlayer:NetVars("Cosmetics", pPlayer.Cosmetics, true)
	
	pPlayer.inv = {}
	pPlayer.inv[INV_WEAPON] = {}
	pPlayer.inv[INV_ENTITY] = {}
	pPlayer.inv[INV_FOOD] = {}
	pPlayer.inv[INV_PROP] = {}
	pPlayer.inv[INV_HATS] = {}
	pPlayer.inv[INV_CLOTHES] = {}
	pPlayer:UpdateInventory()

	MakeInvisible(pPlayer, true);
end



local function DoPlayerDeath( pPlayer)
	CreatePlayerRagdoll(pPlayer)
	return false
end
hook.Add("DoPlayerDeath", "GetRagdoll", DoPlayerDeath)


-- function PlayerKnockout(pPlayer)
-- 	pPlayer:SetNWBool("Ragdolled", true)
-- 	pPlayer:SetNWBool("Knockedout", true)

-- 	pPlayer.eRagdoll = ents.Create("prop_ragdoll");
-- 	pPlayer.eRagdoll:SetPos(pPlayer:GetPos());
-- 	pPlayer.eRagdoll:SetModel(pPlayer:GetModel());
-- 	pPlayer.eRagdoll:SetAngles(pPlayer:GetAngles());
-- 	pPlayer.eRagdoll:SetSkin(pPlayer:GetSkin());
-- 	pPlayer.eRagdoll:SetMaterial(pPlayer:GetMaterial());
-- 	pPlayer.eRagdoll:Spawn();
-- 	pPlayer.eRagdoll.lifetime = CurTime() + 900
-- 	pPlayer.eRagdoll.player = pPlayer

-- 	pPlayer.eRagdoll:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER);
-- 	pPlayer:SetNVar("PlayerRagdoll", pPlayer.eRagdoll, NETWORK_PROTOCOL_PUBLIC)
-- 	pPlayer:SetNetworkedEntity("RagdollPlayer", pPlayer.eRagdoll)

-- 	local weapon = pPlayer:GetActiveWeapon()
--     local weps = {}
--     for u, l in pairs(pPlayer:GetWeapons()) do
--         table.insert(weps,l:GetClass())
--     end
	
-- 	pPlayer.KnockoutWeapons = weps
	
-- 	if weapon:IsValid() then
-- 	    pPlayer.LastWeap = weapon:GetClass()
-- 	end

-- 	pPlayer:StripWeapons(pPlayer.KnockoutWeapons)


-- 	pPlayer.knockouttime = RealTime()

-- 	rp.DamageSystem.HurtSound(pPlayer.eRagdoll, "knockout")

-- 	timer.Create("KnockoutMoan"..pPlayer:UserID(), 3, 0, function()
-- 		rp.DamageSystem.HurtSound(pPlayer.eRagdoll, "knockout")
-- 	end)

-- 	net.Start("KnockoutTimer")
-- 		net.WriteBool(true)
-- 	net.Send(pPlayer)	
	
-- 	local velocity = pPlayer:GetVelocity();
-- 	local physObjects = pPlayer.eRagdoll:GetPhysicsObjectCount() - 1;
	
-- 	for i = 0, physObjects do
-- 		local bone = pPlayer.eRagdoll:GetPhysicsObjectNum(i);
		
-- 		if (IsValid(bone)) then
-- 			local position, angle = pPlayer:GetBonePosition(pPlayer.eRagdoll:TranslatePhysBoneToBone(i));
			
-- 			if (position and angle) then
-- 				bone:SetPos(position);
-- 				bone:SetAngles(angle);
-- 			end;
			
-- 			bone:AddVelocity(velocity);
-- 		end;
-- 	end;

-- end

-- function PlayerUnKnockout(pPlayer)
-- 	local Body = pPlayer:GetNetworkedEntity("RagdollPlayer")
-- 	if Body and IsValid(Body) then 

-- 		local trace = {}
-- 		trace.start = Body:GetPos()
-- 		trace.endpos = trace.start + Vector(0,0,-30)
-- 		trace.filter = Body
-- 		local tr = util.TraceLine( trace )

-- 		pPlayer:SetNWBool("Ragdolled", false)
-- 		pPlayer:SetNWBool("Knockedout", false)
-- 		-- pPlayer:Spectate(0)
-- 		-- pPlayer:SpectateEntity()
-- 		-- pPlayer:SetParent()	
-- 		-- pPlayer:Spawn()

-- 		local wep = pPlayer.KnockoutWeapons
-- 		for i=1, #wep do
-- 			pPlayer:Give(wep[i])
-- 		end
-- 		pPlayer:SelectWeapon(pPlayer.LastWeap)		

-- 		timer.Destroy("KnockoutMoan"..pPlayer:UserID())

-- 		net.Start("KnockoutTimer")
-- 			net.WriteBool(false)
-- 		net.Send(pPlayer)		

-- 		if Body:WaterLevel() > 0 then
-- 			pPlayer:SetPos(Body:GetPos())
-- 		else
-- 			pPlayer:SetPos(tr.HitPos)
-- 		end

-- 		if Body and IsValid(Body) then
-- 			Body:Remove()
-- 		end

-- 		pPlayer:SetNWBool("PlayerRagdoll", false)
-- 		pPlayer:SetNVar("PlayerRagdoll", nil, NETWORK_PROTOCOL_PUBLIC)

-- 		if pPlayer.eRagdoll and IsValid(pPlayer.eRagdoll) then
-- 			pPlayer.eRagdoll:Remove()
-- 		end
-- 	end
-- end

-- hook.Add("Think", "UnKnockoutThink", function()
-- 	for k, pPlayer in pairs(player.GetAll()) do
-- 		if not IsValid( pPlayer ) then continue end
-- 		-- print(pPlayer)
-- 		if pPlayer.knockouttime and (RealTime() - pPlayer.knockouttime) > 60 then
-- 			PlayerUnKnockout(pPlayer)
-- 			-- return false
-- 		end
-- 	end
-- end)

-- hook.Add("EntityTakeDamage", "rp.DamageSystem.Knockout", function(ent, dmg)
--     if not ent:IsPlayer() then return end
--     local damage = dmg:GetDamage()
-- 	if (damage > ent:Health() / 2.5 and damage < ent:Health()) then
-- 		PlayerKnockout(ent)
-- 	end
-- 	if (damage > ent:Health()) then
-- 		ent:Kill()
-- 	end
-- end)


function RagdollSearch(ply,key)
	if key == IN_USE and IsValid(ply) then
	
	local tr = util.TraceLine({ start  = ply:GetShootPos(), endpos = ply:GetShootPos() + ply:GetAimVector() * 84, filter = ply, mask = MASK_SHOT });
	
		if (ply.lastPickup or 0) < CurTime() and IsValid(tr.Entity) and tr.Entity:GetClass() == "prop_ragdoll" and tr.Entity.IsStorage then
			ply.lastPickup = CurTime() + 0.3
			if tr.Entity.inv then
				net.Start("Inventory.StorageLookup")
					net.WriteEntity(tr.Entity)
					net.WriteTable(tr.Entity.inv)
				net.Send(ply)
			end
		end
		
	end
end
hook.Add("KeyRelease","RagdollSearch", RagdollSearch)