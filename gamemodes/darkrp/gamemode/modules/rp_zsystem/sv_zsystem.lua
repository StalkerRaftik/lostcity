function rp.ZombieSystem.SpawnZombies()
	local function BuildChances(tblWithRawChances)
        -- Если нет шансов - создаем их
        local chanceSummary = 0
        for zid, _ in pairs(tblWithRawChances) do
            if not istable(tblWithRawChances[zid]) then
				local rawchance = tblWithRawChances[zid]
				tblWithRawChances[zid] = {}
				tblWithRawChances[zid].chance = rawchance
                tblWithRawChances[zid].chance1 = chanceSummary
                tblWithRawChances[zid].chance2 = chanceSummary + tblWithRawChances[zid].chance
			elseif not istable(tblWithRawChances[zid].Chance) and not tblWithRawChances[zid].chance1 then
				local rawchance = tblWithRawChances[zid].Chance
				tblWithRawChances[zid].Chance = {}
				tblWithRawChances[zid].Chance.chance = rawchance
                tblWithRawChances[zid].Chance.chance1 = chanceSummary
                tblWithRawChances[zid].Chance.chance2 = chanceSummary + tblWithRawChances[zid].Chance.chance
			end
			
			if tblWithRawChances[zid].Chance then
            	chanceSummary = chanceSummary + tblWithRawChances[zid].Chance.chance
			else
				chanceSummary = chanceSummary + tblWithRawChances[zid].chance
			end
        end
        return chanceSummary
    end

	for id, ztbl in pairs(rp.ZombieSystem.Config) do
		if not rp.ZombieSystem.Config[id].zcount or rp.ZombieSystem.Config[id].zcount < 0 then 
			rp.ZombieSystem.Config[id].zcount = 0 
		end
		
		for i=1, ztbl.amount[1] do // кол-во зомби за 1 спавн
			if rp.ZombieSystem.Config[id].zcount >= rp.ZombieSystem.Config[id].amount[2] then break end // Если зомби уже много

			local pos
			if ztbl.usesRawVectors == true then
				pos = ztbl.coords[math.random(1, #ztbl.coords)]
				local tries = 0
				while util.IsInWorld(pos) != true or canSpawnHere(pos) != true or tries < 4 do
					pos = ztbl.coords[math.random(1, #ztbl.coords)]
					tries = tries + 1
				end
				if tries >= 4 then continue end // Если места нет, то переходим к след. циклу
			else
				pos = rp.ZombieSystem.SpawnVector(id)
			end
			
			if pos ~= nil then
				
				local ifplynear = false
				local ifplytoofar = true

				for k, v in pairs(player.GetAll()) do
					local plpos = v:GetPos()
					if pos:DistToSqr(plpos) < 600*600 then 
						ifplynear = true 
					end
					local lim = rp.ZombieSystem.Config[id].farspawn or 6000
					if pos:DistToSqr(plpos) < lim*lim then 
						if ztbl.plyZLowerThan then
							if plpos.z < ztbl.plyZLowerThan then
								ifplytoofar = false
							end
						else
							ifplytoofar = false
						end
					end
				end

				if ifplytoofar == true or ifplynear == true then continue end

					-- SetGlobalFloat("ZombieSpawnCD"..id, CurTime()+300)

				local zclass
				local summaryChance = BuildChances(rp.ZombieSystem.ZombieTypes[ztbl.zombies])
				local itemRoll = math.Rand(0, summaryChance)
				for class, chance in pairs(rp.ZombieSystem.ZombieTypes[ztbl.zombies]) do
					if (chance.chance1 and chance.chance1 < itemRoll and chance.chance2 >= itemRoll)
					or (chance.Chance and chance.Chance.chance1 and chance.Chance.chance1 < itemRoll and chance.Chance.chance2 >= itemRoll) then
						if chance.Chance then 
							zclass = chance.Zombies[math.random(1, #chance.Zombies)]
						else
							zclass = class
						end
					end
				end
				
				timer.Simple(math.Rand(0.1, 4), function()
					local z = ents.Create(zclass)
					z:SetPos(pos)
					z:Spawn()
					z:Activate()
					z:DropToFloor()
					z.zombie = true
					z.zid = id

					if not IsValid(z) then
						rp.ZombieSystem.Config[id].zcount = rp.ZombieSystem.Config[id].zcount - 1
					end
				end)
				rp.ZombieSystem.Config[id].zcount = rp.ZombieSystem.Config[id].zcount + 1
			else
				print("[ZOMBIE SPAWN SYSTEM] Зомби не нашел место для спавна")
			end
		end
	end
end

function ZombieCount(id)
	return rp.ZombieSystem.Config[id].zcount
end

function KillAllZombie()
	for k, v in pairs(ents.GetAll()) do
		if v.zombie then
			v:Remove()
		end
	end
end


concommand.Add("GenerateZombieSpawns", function( ply, cmd, args )
	if not ply:IsSuperAdmin() then return end

	if args[1] > args[4] then args[1], args[4] = args[4], args[1] end
	if args[2] > args[5] then args[2], args[5] = args[5], args[2] end
	if args[3] > args[6] then args[3], args[6] = args[6], args[3] end

    local vec1 = Vector(args[1], args[2], args[3])
	local vec2 = Vector(args[4], args[5], args[6])

	local vectorsNum = tonumber(args[7])
	local successVecs = {}
	while #successVecs < vectorsNum do
		local vec = Vector(math.random(vec1.x, vec2.x), math.random(vec1.y, vec2.y), math.random(vec1.z, vec2.z))

		if util.IsInWorld(vec) and canSpawnHere(vec) then 
			table.insert(successVecs, vec)
			print("Vector("..vec.x..", "..vec.y..", "..vec.z.."),")
		end
	end
end)

timer.Create( "RemoveDesertedZombies", 10, 0, function()
	for k, v in pairs(ents.GetAll()) do
		if IsValid(v) and v.zombie then
			CheckIfDesertedArea( v )
		end
	end
end)

function CheckIfDesertedArea( ent )
	if ent and !ent:IsValid() then return end

	local deserted = true
	for k, v in pairs(player:GetAll()) do
		local lim = rp.ZombieSystem.Config[ent.zid].farspawn or 6000
		if ent:GetPos():DistToSqr(v:GetPos()) < (lim+500)*(lim+500) then 
			if rp.ZombieSystem.Config[ent.zid].plyZLowerThan then
				if v:GetPos().z < rp.ZombieSystem.Config[ent.zid].plyZLowerThan then
					deserted = false
					break
				end
			else
				deserted = false 
				break
			end
		end
		
	end

	// Костыль для старой
	if ent:GetPos().z < -800 then
		deserted = true
	end

	if deserted == true then 
		ent:Remove() 	
	end
end

hook.Add( "EntityRemoved", "DecreaseZombieAmount", function(ent)
	if not ent.zombie then return end
	if not rp.ZombieSystem.Config[ent.zid].zcount then rp.ZombieSystem.Config[ent.zid].zcount = 0 end
	
	rp.ZombieSystem.Config[ent.zid].zcount = rp.ZombieSystem.Config[ent.zid].zcount - 1
end )

timer.Create("RespawnZombiesTimer", rp.ZombieSystem.RespawnTimer, 0, rp.ZombieSystem.SpawnZombies)

