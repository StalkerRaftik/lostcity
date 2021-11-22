local ipairs 	= ipairs
local IsValid 	= IsValid
local string 	= string
local table 	= table

function GM:CanChangeRPName(ply, RPname)
	if string.find(RPname, "\160") or string.find(RPname, " ") == 1 then -- disallow system spaces
		return false
	end

	if table.HasValue({"ooc", "shared", "world", "n/a", "world prop", "STEAM", 'Kirill', 'Strike', 'kirussell'}, RPname) and (not pl:IsSuperAdmin()) then
		return false
	end
  return false
end

function GM:CanDemote(pl, target, reason)end
function GM:CanVote(pl, vote)end
function GM:OnPlayerChangedTeam(pl, oldTeam, newTeam)end

function GM:CanDropWeapon(pl, weapon)
	if not IsValid(weapon) then return false end
	local class = string.lower(weapon:GetClass())
	if rp.cfg.DisallowDrop[class] then return false end

	if table.HasValue(pl.Weapons, weapon) then
        return false
    end

	for k,v in pairs(rp.shipments) do
		if v.entity ~= class then continue end

		return true
	end

	return false
end

function PLAYER:CanDropWeapon(weapon)
	return GAMEMODE:CanDropWeapon(self, weapon)
end

function GM:UpdatePlayerSpeed(pl)
	self:SetPlayerSpeed(pl, rp.cfg.WalkSpeed, rp.cfg.RunSpeed)
end

function PLAYER:IsCharSelected()
	return not (isbool(self:GetNVar('CurrentChar')) or self:GetNVar('CurrentChar') == nil or self:GetNVar('CurrentChar') == -1)
end

/*---------------------------------------------------------
 Stuff we dont use
 ---------------------------------------------------------*/
timer.Simple(0.5, function()
	local GM = GAMEMODE
	GM.CalcMainActivity 		= nil
	GM.SetupMove 				= nil
	GM.FinishMove 				= nil
	GM.Move 					= nil
	GM.UpdateAnimation 			= nil
	GM.Think 					= nil
	GM.Tick 					= nil
	GM.PlayerTick 				= nil
	GM.PlayerPostThink 			= nil
	GM.KeyPress 				= nil
	GM.EntityRemoved 			= nil
	GM.EntityKeyValue 			= nil
	GM.HandlePlayerJumping 		= nil
	GM.HandlePlayerDucking 		= nil
	GM.HandlePlayerNoClipping 	= nil
	GM.HandlePlayerVaulting 	= nil
	GM.HandlePlayerSwimming 	= nil
	GM.HandlePlayerLanding 		= nil
	GM.HandlePlayerDriving 		= nil
end)

/*---------------------------------------------------------
 Gamemode functions
 ---------------------------------------------------------*/
-- function GM:PlayerUse(pl, ent)
-- 	return (not not pl:IsValid())
-- end
function GM:PlayerSpawnSENT(pl, model) return pl:HasFlag("S") end
function GM:PlayerSpawnSWEP(pl, class, model) return pl:HasFlag("S") end
function GM:PlayerGiveSWEP(pl, class, model) return pl:HasFlag("S") end
function GM:PlayerSpawnVehicle(pl, model) return pl:IsSuperAdmin() end
function GM:PlayerSpawnNPC(pl, model) return pl:HasFlag("S") end
function GM:PlayerSpawnRagdoll(pl, model) return pl:HasFlag("S") end
function GM:PlayerSpawnEffect(pl, model) return pl:HasFlag("S") end
function GM:PlayerSpray(pl) return true end
function GM:CanDrive(pl, ent) return false end
function GM:CanProperty(pl, property, ent) return false end

function GM:OnPhysgunFreeze(weapon, phys, ent, pl)
	if ent.PhysgunFreeze and (ent:PhysgunFreeze(pl) == false) then
		return false
	end

	if ( ent:GetPersistent() ) then return false end

	-- Object is already frozen (!?)
	if ( !phys:IsMoveable() ) then return false end
	if ( ent:GetUnFreezable() ) then return false end

	phys:EnableMotion( false )

	-- With the jeep we need to pause all of its physics objects
	-- to stop it spazzing out and killing the server.
	if ( ent:GetClass() == "prop_vehicle_jeep" ) then

		local objects = ent:GetPhysicsObjectCount()

		for i = 0, objects - 1 do

			local physobject = ent:GetPhysicsObjectNum( i )
			physobject:EnableMotion( false )

		end

	end

	-- Add it to the player's frozen props
	pl:AddFrozenPhysicsObject( ent, phys )

	return true
end

function GM:PlayerShouldTaunt(pl, actid) return true end
function GM:CanTool(pl, trace, mode) return (not not pl:IsValid()) end

function GM:CanPlayerSuicide(pl)
	return false
end

function GM:PlayerSpawnProp(ply, model)
--   if not ply:IsValid() or ply:IsFrozen() then return false end

--   model = string.gsub(tostring(model), "\\", "/")
--   model = string.gsub(tostring(model), "//", "/")

--   local l = rp.cfg.PropLimit

--   if ply:IsAdmin() then
--    l = l + 100
--   end

--   local upgradeCount = ply:GetUpgradeCount('prop_limit_15')
--   if (upgradeCount ~= 0) then
--    l = l + (15 * upgradeCount)
--   end

--   if (ply:GetCount('props') >= l) then
--    rp.Notify(ply, NOTIFY_ERROR, rp.Term('SboxPropLimit'))
--    return false
--   end
	return true

end


function GM:ShowSpare1(ply)
	if rp.teams[ply:Team()] and rp.teams[ply:Team()].ShowSpare1 then
		return rp.teams[ply:Team()].ShowSpare1(ply)
	end
end

function GM:ShowSpare2(ply)
	if rp.teams[ply:Team()] and rp.teams[ply:Team()].ShowSpare2 then
		return rp.teams[ply:Team()].ShowSpare2(ply)
	end
end

function string.StripPort(ip)
	local p =string.find(ip, ':')
	if (not p) then return ip end
	return string.sub(ip, 1, p - 1)
end

function GM:DoPlayerDeath(pl, attacker, dmginfo)
	pl:CreateRagdoll()

	pl.LastRagdoll = (CurTime() + rp.cfg.RagdollDelete)
end

timer.Create('RemoveRagdolls', 30, 0, function()
	local pls = player.GetAll()
	for i = 1, #pls do
		if pls[i].LastRagdoll and (pls[i].LastRagdoll <= CurTime()) then
			local rag = pls[i]:GetRagdollEntity()
			if IsValid(rag) then
				rag:Remove()
			end
		end
	end
end)

function GM:PlayerDeathThink(pl)
	if (not pl.NextReSpawn or pl.NextReSpawn < CurTime()) and (pl:KeyPressed(IN_ATTACK) or pl:KeyPressed(IN_ATTACK2) or pl:KeyPressed(IN_JUMP) or pl:KeyPressed(IN_FORWARD) or pl:KeyPressed(IN_BACK) or pl:KeyPressed(IN_MOVELEFT) or pl:KeyPressed(IN_MOVERIGHT) or pl:KeyPressed(IN_JUMP)) then
		pl:Spawn()
	end
end

function GM:PlayerDeath(ply, weapon, killer)
	if rp.teams[ply:Team()] and rp.teams[ply:Team()].PlayerDeath then
		rp.teams[ply:Team()].PlayerDeath(ply, weapon, killer)
	end

	ply:Extinguish()

	if ply:GetNetVar('HasGunlicense') then ply:SetNetVar('HasGunlicense', nil) end

	if ply:InVehicle() then ply:ExitVehicle() end

	ply.NextReSpawn = CurTime() + 1
  -- if !ply:IsVIP() then
  --   if ply:IsAdmin() then return false end
  --   local dropmoney = ply:GetMoney() * 0.2
  --   rp.SpawnMoney(ply:GetPos(), dropmoney)
  --   ply:AddMoney(-dropmoney)
  -- end
end

function GM:PlayerCanPickupWeapon(ply, weapon)
	if not ply:IsValid() then return false end
	if weapon and weapon.PlayerUse == false then return false end

	if rp.teams[ply:Team()] and rp.teams[ply:Team()].PlayerCanPickupWeapon then
		rp.teams[ply:Team()].PlayerCanPickupWeapon(ply, weapon)
	end
	return true
end

local function HasValue(t, val)
	for k, v in ipairs(t) do
		if (string.lower(v) == string.lower(val)) then
			return true
		end
	end
end

function GM:PlayerSetModel(pl)
  if not IsValid(pl) then return end

  if istable(rp.teams[pl:Team()].model) then
    pl:SetModel(table.Random(rp.teams[pl:Team()].model))
  else
    pl:SetModel(rp.teams[pl:Team()].model)
  end

  	if rp.teams[pl:Team()].PlayerSpawn then rp.teams[pl:Team()].PlayerSpawn(pl) end

	pl:SetupHands()
end

function GM:PlayerInitialSpawn(ply)
  	ply:SetTeam(1)
	for k, v in ipairs(ents.GetAll()) do
		if IsValid(v) and (v.deleteSteamID == ply:SteamID()) then
			ply:_AddCount(v:GetClass(), v)
			v.ItemOwner = ply
			if v.Setowning_ent then
				v:Setowning_ent(ply)
			end
			v.deleteSteamID = nil
			timer.Destroy("Remove"..v:EntIndex())
		end
	end
end

local map = game.GetMap()
local lastpos
local TeamSpawns 	= rp.cfg.TeamSpawns[map]
local JailSpawns 	= rp.cfg.JailPos[map]
local NormalSpawns 	= rp.cfg.SpawnPos[map]

function GM:PlayerSelectSpawn(pl)
	local pos
	if rp.teams[pl:Team()] and rp.teams[pl:Team()].category then
		for k,v in pairs(DarkRP.getCategories().jobs) do
			if v.name == rp.teams[pl:Team()].category then
				if v.spawnPoint then
					pos = v.spawnPoint[math.random(1, #v.spawnPoint)]
					break
				end
			end
		end
		if pos then
			return self.SpawnPoint, util.FindEmptyPos(pos)
		end
	end
	pos = util.FindEmptyPos(NormalSpawns[math.random(1, #NormalSpawns)])
	-- if (TeamSpawns[pl:Team()] ~= nil) then
	-- 	pos = TeamSpawns[pl:Team()][math.random(1, #TeamSpawns[pl:Team()])]
	-- elseif pl:GetNVar('CurrentChar') == false or pl:GetNVar('CurrentChar') == -1 then
	-- 	lastpos = pos
	-- 	return
	-- else
	pl:SetPos(pos)
	pl:SetNoDraw(false)
	pl:SetMoveType(MOVETYPE_WALK)
	pl:Freeze(false)
 -- 		return
	-- end
	return self.SpawnPoint, util.FindEmptyPos(pos)
end

function GM:PlayerSpawn(ply)
  player_manager.SetPlayerClass(ply, 'rp_player')

  ply:AllowFlashlight(true)
  ply:SetNoCollideWithTeammates(false)
  ply:UnSpectate()
  ply:SetHealth(100)
  ply:SetJumpPower(200)
  ply:SetNoDraw(false)
  ply:SetMoveType(MOVETYPE_WALK)
  ply:Freeze(false)
  ply:SetNVar("BuildingMode", false, NETWORK_PROTOCOL_PRIVATE)

  GAMEMODE:SetPlayerSpeed(ply, rp.cfg.WalkSpeed, rp.cfg.RunSpeed)

  ply:Extinguish()
  if IsValid(ply:GetActiveWeapon()) then
    ply:GetActiveWeapon():Extinguish()
  end

  if ply.demotedWhileDead then
    ply.demotedWhileDead = nil
    ply:ChangeTeam(rp.DefaultTeam)
  end

  ply:GetTable().StartHealth = ply:Health()
  gamemode.Call("PlayerLoadout", ply)


  local _, pos = self:PlayerSelectSpawn(ply)
  if pos ~= nil then
	ply:SetPos(pos)
  end

  local view1, view2 = ply:GetViewModel(1), ply:GetViewModel(2)
  if IsValid(view1) then
    view1:Remove()
  end
  if IsValid(view2) then
    view2:Remove()
  end

  if rp.teams[ply:Team()] and rp.teams[ply:Team()].PlayerSpawn then
    rp.teams[ply:Team()].PlayerSpawn(ply)
  end

  gamemode.Call("PlayerSetModel", ply)
end

function GM:PlayerLoadout(ply)
	if not ply:IsValid() then return end

	player_manager.RunClass(ply, "Spawn")

	local Team = ply:Team() or 1

	if not rp.teams[Team] then return end

	if rp.teams[ply:Team()].PlayerLoadout then
		ply.JobLoadoutTimer = ply.JobLoadoutTimer or 0
        if ply.JobLoadoutTimer > CurTime() then
            rp.Notify(ply, NOTIFY_ERROR, "Вы недавно уже получали патроны. Следующая партия придет через " .. math.floor((ply.JobLoadoutTimer-CurTime())/60) .. " минут.")
        else
        	ply.JobLoadoutTimer = CurTime() + 600

			rp.teams[ply:Team()].PlayerLoadout(ply)
        end
	end

	ply:SetWeaponsGivingWithoutInventoryFlag()
	for k, v in ipairs(rp.teams[Team].weapons or {}) do
		ply:Give(v)
	end

	for k, v in ipairs(rp.cfg.DefaultWeapons) do
		ply:Give(v)
	end
	ply:RemoveWeaponsGivingWithoutInventoryFlag()
	-- if ply:IsAdmin() then
	-- 	ply:Give("weapon_keypadchecker")
	-- end

	ply:SelectWeapon('weapon_rphands')

	ply.Weapons = ply:GetWeapons()
end

local function removeDelayed(ent, ply)
	ent.deleteSteamID = ply:SteamID()
	timer.Create("Remove" .. ent:EntIndex(), (ent.RemoveDelay or math.random(180, 900)), 1, function()
		SafeRemoveEntity(ent)
	end)
end

-- Remove shit on disconnect
function GM:PlayerDisconnected(ply)

	for k, v in ipairs(ents.GetAll()) do
		-- Remove right away or delayed
		if (v.ItemOwner == ply) and not v.RemoveDelay or v.Getrecipient and (v:Getrecipient() == ply) then
			v:Remove()
		elseif (v.RemoveDelayed or v.RemoveDelay) and (v.ItemOwner == ply) then
			removeDelayed(v, ply)
		end
		-- Remove all props
		if IsValid(v) and ((v:CPPIGetOwner() ~= nil) and not IsValid(v:CPPIGetOwner())) or (v:CPPIGetOwner() == ply) then
			v:Remove()
		end
	end

	GAMEMODE.vote.DestroyVotesWithEnt(ply)


	if rp.teams[ply:Team()] and rp.teams[ply:Team()].PlayerDisconnected then
		rp.teams[ply:Team()].PlayerDisconnected(ply)
	end
end

function GM:GetFallDamage(pl, speed)
	local dmg = (speed / 15)
	local ground = pl:GetGroundEntity()
	if ground:IsPlayer() and (not not pl:IsValid()) then
		ground:TakeDamage(dmg * 1.3, pl, pl)
	end
	return dmg
end


local function IsInRoom(listener, talker)
    local tracedata = {}
    tracedata.start = talker:GetShootPos()
    tracedata.endpos = listener:GetShootPos()
    local trace = util.TraceLine(tracedata)

    return not trace.HitWorld

    -- return true
end

local threed = true
local vrad = true
local dynv = true

local function calcPlyCanHearPlayerVoice(listener)
    if not IsValid(listener) then return end
    listener.DrpCanHear = listener.DrpCanHear or {}
    for _, talker in pairs(player.GetAll()) do
        listener.DrpCanHear[talker] = not vrad or -- Voiceradius is off, everyone can hear everyone
            (listener:GetShootPos():DistToSqr(talker:GetShootPos()) < 450000 and -- voiceradius is on and the two are within hearing distance
                (not dynv or IsInRoom(listener, talker))) -- Dynamic voice is on and players are in the same room
    end
end

-- hook.Add("PlayerInitialSpawn", "DarkRPCanHearVoice", function(ply)
--     timer.Create(ply:UserID() .. "DarkRPCanHearPlayersVoice", 1, 0, fn.Curry(calcPlyCanHearPlayerVoice, 2)(ply))
-- end)

-- hook.Add("PlayerDisconnected", "DarkRPCanHearVoice", function(ply)
--     if not ply.DrpCanHear then return end
--     for k,v in pairs(player.GetAll()) do
--         if not v.DrpCanHear then continue end
--         v.DrpCanHear[ply] = nil
--     end
--     timer.Remove(ply:UserID() .. "DarkRPCanHearPlayersVoice")
-- end)

function GM:PlayerCanHearPlayersVoice(listener, talker)
    if not talker:Alive() then return false end
    calcPlyCanHearPlayerVoice(listener)

    local canHear = listener.DrpCanHear and listener.DrpCanHear[talker]
    return canHear, threed
end

local remove = {
	/*['env_fire'] = true,
	['trigger_hurt'] = true,
	['prop_dynamic'] = true,
	['prop_door_rotating'] = true,
	['light'] = true,
	['spotlight_end'] = true,
	['beam'] = true,
	['env_sprite'] = true,
	['light_spot'] = true,
	['point_template'] = true,*/

	-- ['prop_physics'] = true,
	-- ['prop_physics_multiplayer'] = true,
	-- ['prop_ragdoll'] = true,
	-- ['ambient_generic'] = true,
	-- ['func_tracktrain'] = true,
	-- ['func_reflective_glass'] = true,
	-- ['info_player_terrorist'] = true,
	-- ['info_player_counterterrorist'] = true,
	-- ['env_soundscape'] 	= true,
	-- ['point_spotlight'] = true,
	-- ['ai_network'] 		= true,

	-- map shit
	-- ['lua_run'] 			= true,
	-- ['logic_timer'] 		= true,
	-- ['env_sprites'] 		= true,
	-- ['trigger_multiple']	= true
}

function GM:InitPostEntity()
	local physData 								= physenv.GetPerformanceSettings()
	physData.MaxVelocity 						= 3000
	physData.MaxCollisionChecksPerTimestep		= 10000
	physData.MaxCollisionsPerObjectPerTimestep 	= 2
	physData.MaxAngularVelocity					= 3636

	physenv.SetPerformanceSettings(physData)

	game.ConsoleCommand("sv_allowcslua 0\n")
	game.ConsoleCommand("physgun_DampingFactor 0.9\n")
	game.ConsoleCommand("sv_sticktoground 0\n")
	game.ConsoleCommand("sv_airaccelerate 100\n")

	-- for _, ent in ipairs(ents.GetAll()) do
	-- 	if remove[ent:GetClass()] then
	-- 		ent:Remove()
	-- 	end
    -- end

    for k, v in ipairs(ents.FindByClass('info_player_start')) do
		if util.IsInWorld(v:GetPos()) and (not self.SpawnPoint) then
			self.SpawnPoint = v
		else
			v:Remove()
		end
	end

	-- for k, v in pairs(rp.cfg.RemoveMapProps) do
	-- 	local ent = ents.GetMapCreatedEntity(v)
	-- 	if IsValid(ent) then
	-- 		ent:Remove()
	-- 	end
	-- end

end
