local string 	= string
local IsValid 	= IsValid
local util 		= util

util.AddNetworkString('rp.toolEditor')

rp.pp = rp.pp or {
	ModelCache = {},
	Whitelist = {},
	BlockedTools = {},
}

local toolFuncs = {
	[0] = function(pl)
		return true
	end,
	[1] = PLAYER.IsVIP,
	[2] = PLAYER.IsAdmin,
	[3] = PLAYER.IsSuperAdmin
}

local db = rp._Stats

function rp.pp.IsBlockedModel(mdl)
	mdl = string.lower(mdl or "")
	mdl = string.Replace(mdl, "\\", "/")
	mdl = string.gsub(mdl, "[\\/]+", "/")
	if table.HasValue(Props_1, mdl) or table.HasValue(Props_2, mdl) or table.HasValue(Props_3, mdl) then 
		return false 
	end
	return not (rp.pp.Whitelist[mdl] == true)
end

function rp.pp.PlayerCanManipulate(pl, ent)
	if not pl:IsValid() then
		return false
	end

	if IsValid(ent:CPPIGetOwner()) and ent:CPPIGetOwner().propBuddies and ent:CPPIGetOwner().propBuddies[pl] and (not ent.ItemOwner == pl) or (IsValid(ent:CPPIGetOwner()) and pl:IsAdmin()) or (ent.ItemOwner and pl:IsAdmin()) then
		return true
	end

	return (ent:CPPIGetOwner() == pl) or (IsValid(ent:CPPIGetOwner()) and pl:IsAdmin())
end


local can_dupe = {
	['prop_physics'] = true,
	['gmod_button'] = true,
	['gmod_lamp'] = true,
	['gmod_light'] = true,
	['gmod_emitter'] = true,
	['prop_effect'] = true,
	['keypad']		= true
}


function rp.pp.PlayerCanTool(pl, ent, tool)
	if not pl:GetNVar("BuildingMode") == true then DarkRP.notify(pl, 1, 4, "Вы не в режиме строительства!") return false end
	if not pl:IsValid() then
		return false
	end

  
	local tool = tool:lower()

	if rp.pp.BlockedTools[tool] then
		local canTool = toolFuncs[rp.pp.BlockedTools[tool]](pl)
		if not canTool then
			rp.Notify(pl, NOTIFY_ERROR, rp.Term('CannotTool'), tool)
			return canTool
		end
	end

	local EntTable =
		(tool == "adv_duplicator" and pl:GetActiveWeapon():GetToolObject().Entities) or
		(tool == "advdupe2" and pl.AdvDupe2 and pl.AdvDupe2.Entities) or
		(tool == "duplicator" and pl.CurrentDupe and pl.CurrentDupe.Entities)

	if EntTable then
		for k, v in pairs(EntTable) do
			if not can_dupe[string.lower(v.Class)] then
				rp.Notify(pl, NOTIFY_ERROR, rp.Term('DupeRestrictedEnts'))
				return false
			end
		end
	end

  if ent:GetClass() == "modulus_skateboard" then return false end

	if ent:IsWorld() then 
		return true
	elseif not IsValid(ent) then
		return false
	end

	local cantool = rp.pp.PlayerCanManipulate(pl, ent)

	if (cantool == true) then
		hook.Call('PlayerToolEntity', GAMEMODE, pl, ent, tool)
	end

	return cantool
end


--
-- Data
--
function rp.pp.WhitelistModel(mdl)
	db:Query('REPLACE INTO pp_whitelist VALUES(?);', mdl, function()
		rp.pp.Whitelist[mdl] = true
	end)
end

function rp.pp.BlacklistModel(mdl)
	db:Query('DELETE FROM pp_whitelist WHERE Model=?;', mdl, function()
		rp.pp.Whitelist[mdl] = nil
	end)
end

function rp.pp.AddBlockedTool(tool, rank)
	db:Query('REPLACE INTO pp_blockedtools VALUES(?, ?);', tool, rank, function()
		rp.pp.BlockedTools[tool] = rank
	end)
end

--
-- Load data
--
hook('InitPostEntity', 'pp.InitPostEntity', function()
	-- -- Load whitelist
	-- db:Query('SELECT * FROM pp_whitelist;', function(data)
	-- 	for k, v in ipairs(data) do
	-- 		rp.pp.Whitelist[v.Model] = true
    --   		rp.pp.WhitelistModel(v.Model)
	-- 	end
	-- end)

	-- -- Load blocked tools
	db:Query('SELECT * FROM pp_blockedtools;', function(data)
		for k, v in ipairs(data) do
			rp.pp.BlockedTools[v.Tool] = v.Rank
		end
	end)

	-- for k, v in ipairs(Props_1) do
	-- 	rp.pp.Whitelist[v] = true
	-- end
	-- for k, v in ipairs(Props_3) do
	-- 	rp.pp.Whitelist[v] = true
	-- end
	-- for k, v in ipairs(Props_4) do
	-- 	rp.pp.Whitelist[v] = true
	-- end
end)

--
-- Meta functions
--
function ENTITY:IsProp()
	return (self:GetClass() == 'prop_physics')
end

function ENTITY:CPPISetOwner(pl)
	self.pp_owner = pl
	self:SetNetVar('PropIsOwned', true)
	self:SetNetVar('PropOwner', pl)
end

function ENTITY:CPPIGetOwner()
	return self.pp_owner
end

-- hook.Add("PlayerSpawnedProp", "SetPropOwnerForClient", function(ply, model, ent)
--   ent:SetNVar('PropOwner', ply, NETWORK_PROTOCOL_PUBLIC)
-- end)

--
-- Workarounds
--
PLAYER._AddCount = PLAYER._AddCount or PLAYER.AddCount
function PLAYER:AddCount(t, ent)
	if IsValid(ent) then
		ent:CPPISetOwner(self)
	end
	return self:_AddCount(t, ent)
end

ENTITY._SetPos = ENTITY._SetPos or ENTITY.SetPos
function ENTITY.SetPos(self, pos)
	if IsValid(self) and (not util.IsInWorld(pos)) and (not self:IsPlayer()) and (self:GetClass() ~= 'gmod_hands') then
		self:Remove()
		return
	end
	return self:_SetPos(pos)
end

local PHYS = FindMetaTable('PhysObj')
PHYS._SetPos = PHYS._SetPos or PHYS.SetPos
function PHYS.SetPos(self, pos)
	if IsValid(self) and (not util.IsInWorld(pos)) then
		--self:Remove()
		return
	end
	return self:_SetPos(pos)
end

ENTITY._SetAngles = ENTITY._SetAngles or ENTITY.SetAngles
function ENTITY:SetAngles(ang)
	if not ang then return self:_SetAngles(ang) end
	ang.p = ang.p % 360
	ang.y = ang.y % 360
	ang.r = ang.r % 360
	return self:_SetAngles(ang)
end

if undo then
	local AddEntity, SetPlayer, Finish =  undo.AddEntity, undo.SetPlayer, undo.Finish
	local Undo = {}
	local UndoPlayer
	function undo.AddEntity(ent, ...)
		if type(ent) ~= "boolean" and IsValid(ent) then table.insert(Undo, ent) end
		AddEntity(ent, ...)
	end

	function undo.SetPlayer(ply, ...)
		UndoPlayer = ply
		SetPlayer(ply, ...)
	end

	function undo.Finish(...)
		if IsValid(UndoPlayer) then
			for k,v in pairs(Undo) do
				v:CPPISetOwner(UndoPlayer)
			end
		end
		Undo = {}
		UndoPlayer = nil

		Finish(...)
	end
end

duplicator.BoneModifiers = {}
duplicator.EntityModifiers['VehicleMemDupe'] = nil
for k, v in pairs(duplicator.ConstraintType) do
	if (k ~= 'Weld') and (k ~= 'NoCollide') then
		duplicator.ConstraintType[k] = nil
	end
end

--
-- Commands
--
rp.AddCommand('/whitelist', function(pl, text, args)
	if pl:IsSuperAdmin() then
		local model = args[1]
		if (not model) then return end

		model = string.lower(model or "")
		model = string.Replace(model, "\\", "/")
		model = string.gsub(model, "[\\/]+", "/")

		if rp.pp.IsBlockedModel(model) then
			local pc_count =table.Count(rp.pp.ModelCache)
			if (pc_count >= 100) then
				pl:Notify(NOTIFY_ERROR, rp.Term('CacheFull'), pc_count)
				return
			end

			local wl_count = table.Count(rp.pp.Whitelist) 
			if (wl_count >= 750) then
				pl:Notify(NOTIFY_ERROR, rp.Term('WhitelistFull'), wl_count)
				return
			end

			rp.pp.WhitelistModel(model)
			rp.NotifyAll(NOTIFY_GENERIC, rp.Term('PropWhitelisted'), model, pl)
		else
			rp.pp.BlacklistModel(model)
			rp.NotifyAll(NOTIFY_GENERIC, rp.Term('PropBlacklisted'), model, pl)
		end
	end
end)

rp.AddCommand('/shareprops', function(pl, text, args)
	local targ = rp.FindPlayer(args[1])
	if not IsValid(targ) then
		rp.Notify(pl, NOTIFY_ERROR, rp.Term('PPTargNotFound'))
		return
	end

	pl.propBuddies = pl.propBuddies or {}

	if pl.propBuddies[targ] then
		rp.Notify(pl, NOTIFY_GREEN, rp.Term('UnsharedPropsYou'), targ)
		rp.Notify(targ, NOTIFY_GREEN, rp.Term('UnsharedProps'), pl)
		pl.propBuddies[targ] = false
	else
		rp.Notify(pl, NOTIFY_GREEN, rp.Term('SharedPropsYou'), targ)
		rp.Notify(targ, NOTIFY_GREEN, rp.Term('SharedProps'), pl)
		pl.propBuddies[targ] = true
	end

	pl:SetNetVar('ShareProps', pl.propBuddies)
end)

rp.AddCommand('/tooleditor', function(pl, text, args)
	if pl:IsSuperAdmin() then
		net.Start('rp.toolEditor')
			net.WriteTable(rp.pp.BlockedTools)
		net.Send(pl)
	end
end)

local ranks = {
	[0] = 'user',
	[1] = 'VIP',
	[2] = 'Admin',
	[3] = 'Founder'
}
rp.AddCommand('/settoolgroup', function(pl, text, args)
	if pl:IsSuperAdmin() then
		if not args[1] or not args[2] then return end
		rp.NotifyAll(NOTIFY_GENERIC, rp.Term('PPGroupSet'), args[1], ranks[tonumber(args[2])], pl)
		rp.pp.AddBlockedTool(args[1], tonumber(args[2]))
	end
end)


-- Overwrite 
concommand.Add('gmod_admin_cleanup', function(pl, cmd, args)
	if (not pl:IsSuperAdmin())  then 
		pl:Notify(NOTIFY_ERROR, rp.Term('CantAdminCleanup'))
		return
	end
	for k, v in ipairs(ents.GetAll()) do 
		if (v:CPPIGetOwner()) then
			v:Remove()
		end
	end
end)

local defaultblocked = {
"models/cranes/crane_frame.mdl",
"models/items/item_item_crate.mdl",
"models/props/cs_militia/silo_01.mdl",
"models/props/cs_office/microwave.mdl",
"models/props/de_train/biohazardtank.mdl",
"models/props_buildings/building_002a.mdl",
"models/props_buildings/collapsedbuilding01a.mdl",
"models/props_buildings/project_building01.mdl",
"models/props_buildings/row_church_fullscale.mdl",
"models/props_c17/consolebox01a.mdl",
"models/props_c17/oildrum001_explosive.mdl",
"models/props_c17/paper01.mdl",
"models/props_c17/trappropeller_engine.mdl",
"models/props_canal/canal_bridge01.mdl",
"models/props_canal/canal_bridge02.mdl",
"models/props_canal/canal_bridge03a.mdl",
"models/props_canal/canal_bridge03b.mdl",
"models/props_combine/combine_citadel001.mdl",
"models/props_combine/combine_mine01.mdl",
"models/props_combine/combinetrain01.mdl",
"models/props_combine/combinetrain02a.mdl",
"models/props_combine/combinetrain02b.mdl",
"models/props_combine/prison01.mdl",
"models/props_combine/prison01c.mdl",
"models/props_industrial/bridge.mdl",
"models/props_junk/gascan001a.mdl",
"models/props_junk/glassjug01.mdl",
"models/props_junk/trashdumpster02.mdl",
"models/props_phx/amraam.mdl",
"models/props_phx/ball.mdl",
"models/props_phx/cannonball.mdl",
"models/props_phx/huge/evildisc_corp.mdl",
"models/props_phx/misc/flakshell_big.mdl",
"models/props_phx/misc/potato_launcher_explosive.mdl",
"models/props_phx/mk-82.mdl",
"models/props_phx/oildrum001_explosive.mdl",
"models/props_phx/torpedo.mdl",
"models/props_phx/ww2bomb.mdl",
"models/props_wasteland/cargo_container01.mdl",
"models/props_wasteland/cargo_container01.mdl",
"models/props_wasteland/cargo_container01b.mdl",
"models/props_wasteland/cargo_container01c.mdl",
"models/props_wasteland/depot.mdl",
"models/xqm/coastertrack/special_full_corkscrew_left_4.mdl",
"models/props_foliage/tree_springers_card_01.mdl",
}

local blocked = {}

for k,v in ipairs( defaultblocked ) do
  blocked[v] = true
end

/*---------------------------------------------------------------------------
Prevents spawning a prop or effect when its model is blocked
---------------------------------------------------------------------------*/
local function propSpawn(ply, model)
    if blocked[model] then
        DarkRP.notify(ply, 1, 4, "Модель этого пропа заблокирована!")
        return false
    end
end
hook.Add("PlayerSpawnObject", "FPP_SpawnEffect", propSpawn) -- prevents precaching
hook.Add("PlayerSpawnProp", "FPP_SpawnProp", propSpawn) -- PlayerSpawnObject isn't always called
hook.Add("PlayerSpawnEffect", "FPP_SpawnEffect", propSpawn)
hook.Add("PlayerSpawnRagdoll", "FPP_SpawnEffect", propSpawn)
