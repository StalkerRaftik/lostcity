local oktools = {
	["#Tool.advdupe2.name"] = true,
	["#Tool.stacker.name"] 	= true
}

hook('PlayerSpawnProp', 'pp.PlayerSpawnProp', function(pl, mdl)
	if not pl:GetNVar("BuildingMode") == true then DarkRP.notify(pl, 1, 4, "Вы не в режиме строительства!") return false end

	local tool = pl:GetTool()
	if pl.lastPropSpawn and (pl.lastPropSpawn > CurTime() - .25) and ((tool == nil) or not oktools[tool.Name]) then
		rp.Notify(pl, NOTIFY_ERROR, rp.Term('SpawnPropsSoFast'))
		
		pl.lastPropSpawn = CurTime()
		pl.failedPropAttempts = (pl.failedPropAttempts or 0) + 1

		return false
	end

	-- pl.toldStaff 			= nil
	-- pl.failedPropAttempts 	= nil
	-- pl.lastPropSpawn 		= CurTime()

	if rp.pp.IsBlockedModel(mdl) then
		local issuper = pl:IsSuperAdmin() or pl:HasFlag("S")
		
		if not issuper then
			rp.Notify(pl, NOTIFY_ERROR, rp.Term('PropNotWhitelisted'), mdl)
		end
		
		return issuper
	end
end)

hook.Add("PlayerSwitchWeapon", "rp.BuilidingMode", function(ply, oldWeapon, newWeapon)
	if ply:GetNVar("BuildingMode") == true then
		if newWeapon:GetClass() == "weapon_physgun" or newWeapon:GetClass() == "gmod_tool" then return false else return true end
	end
end)

hook('PlayerSpawnedProp', 'pp.PlayerSpawnedProp', function(pl, mdl, ent)
	ent:CPPISetOwner(pl)
end)

hook('PlayerSpawnedVehicle', 'pp.PlayerSpawnedVehicle', function(pl, ent)
	ent:CPPISetOwner(pl)
end)

hook('PlayerSpawnedSENT', 'pp.PlayerSpawnedSENT', function(pl, ent)
	ent:CPPISetOwner(pl)
end)

function GM:CanTool(pl, trace, tool)
	return rp.pp.PlayerCanTool(pl, trace.Entity, tool)
end

hook('PhysgunPickup', 'pp.PhysgunPickup', function(pl, ent)
	if not pl:GetNVar("BuildingMode") then return false end
	if IsValid(ent) then
		local canphys = rp.pp.PlayerCanManipulate(pl, ent)

		if (not canphys) and ent.PhysgunPickup then
			canphys = ent:PhysgunPickup(pl)
		elseif ent.LazyFreeze then
			canphys = ((ent.ItemOwner == pl) or (ent.AllLazyFreeze == true)) and (not ent.BeingPhysed)
		end

		if (canphys == true) then
			ent.BeingPhysed = true
			hook.Call('PlayerPhysgunEntity', GAMEMODE, pl, ent)
        	ent:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		end

		return canphys
	end
	return false
end)

local vec = Vector(0,0,0)
function GM:PhysgunDrop(pl, ent)
	ent.BeingPhysed = false
	if IsValid(ent) and (not ent:IsPlayer()) then
		local phys = ent:GetPhysicsObject()
		if IsValid(phys) then
			phys:AddAngleVelocity(phys:GetAngleVelocity() * -1)
			phys:SetVelocityInstantaneous(vec)
		end
	end
end

hook('OnPhysgunFreeze', 'pp.OnPhysgunFreeze', function(weapon, physobj, ent, pl)
	ent.BeingPhysed = false
  for k, v in pairs(ents.FindInSphere(ent:GetPos(),30)) do
    if v:IsPlayer() then
      DarkRP.notify(pl, 1, 4, "Вы блокируете игрока вашим пропом!")
      ent:SetCollisionGroup(COLLISION_GROUP_WEAPON)
      physobj:Sleep()
      return false
    else
      ent:SetCollisionGroup(COLLISION_GROUP_NONE)
      ent:SetRenderMode(RENDERMODE_TRANSCOLOR)
      ent:SetKeyValue( "renderfx", 0 )
      ent:SetColor(Color(255,255,255,255))
      physobj:Sleep()
    end
  end
	-- if IsValid(physobj) and (ent.ItemOwner == pl or ent.AllLazyFreeze) and ent.LazyFreeze then
	-- 	physobj:Sleep()
	-- 	return false
	-- end
end)

function GM:GravGunOnPickedUp(pl, ent)
	if ent:IsConstrained() then
		DropEntityIfHeld(ent)
	end
end

function GM:GravGunPunt(pl, ent)

	DropEntityIfHeld(ent)
	return false
end

function GM:OnPhysgunReload(wep, pl)
	return false
end

function GM:GravGunPickupAllowed(pl, ent)
	if (ent:IsValid() and ent.GravGunPickupAllowed) then
		return ent:GravGunPickupAllowed(pl)
	end

	return true
end
