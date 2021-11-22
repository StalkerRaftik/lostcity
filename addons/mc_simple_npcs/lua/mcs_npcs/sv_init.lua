--  _______               __          _______  __                   __          _______  ______  ______        
-- |   |   |.---.-..----.|  |.-----. |     __||__|.--------..-----.|  |.-----. |    |  ||   __ \|      |.-----.
-- |       ||  _  ||  __| |_||__ --| |__     ||  ||        ||  _  ||  ||  -__| |       ||    __/|   ---||__ --|
-- |__|_|__||___._||____|    |_____| |_______||__||__|__|__||   __||__||_____| |__|____||___|   |______||_____|
--                                                          |__|      
--

util.AddNetworkString("OpenMCSMenu")
util.AddNetworkString("OpenMCSSetupMenu")
util.AddNetworkString("CloseMCSMenu")
util.AddNetworkString("StartMCSSvFunc")
util.AddNetworkString("StartMCSAnimation")
	
local function SpawnMCS_NPCs()
	for uid,npc in pairs(MCS.Spawns) do
		
		local spawnpos = npc.pos[string.lower(game.GetMap())] or npc.pos["all"]
		
		if !spawnpos then continue end
		
		npc.uselimit = npc.uselimit or false
		
		local ent = ents.Create("mcs_npc")
		ent:SetModel( npc.model )
		ent:SetPos( spawnpos[1] )
		ent:SetAngles( spawnpos[2] )
		ent:SetNamer( npc.name )
		ent:SetUID( uid )
		ent:SetInputLimit( npc.uselimit )
		ent:SetUseType(SIMPLE_USE)
		ent:SetSolid(SOLID_BBOX) 
		ent:PhysicsInit(SOLID_BBOX)
		ent:SetMoveType(MOVETYPE_NONE)
		if npc.sequence then
			local sequence = npc.sequence
			if istable(sequence) then
				sequence = table.Random(sequence)
			end
			ent.AutomaticFrameAdvance = true 
			ent:ResetSequence(sequence)
			ent:SetDefAnimation(sequence)
		end
		if npc.bgr then
			for k,v in pairs(npc.bgr) do
				ent:SetBodygroup( k, v )
			end 
		end
		if npc.skin then
			ent:SetSkin( npc.skin )
		end
		ent:SetCollisionGroup(COLLISION_GROUP_PLAYER)
		
		ent:Spawn()
		
		npc.Entity = ent
	end
	hook.Run("mcs_npcSpawned")
end

concommand.Add("mcs_npcrespawn", function(ply) 
	
	if !ply:IsSuperAdmin() then return end
	
	for _, ent in pairs (ents.FindByClass("mcs_npc")) do
		if IsValid(ent) then ent:Remove() end
	end
	
	SpawnMCS_NPCs() 

end)

timer.Simple(2, function() SpawnMCS_NPCs() end)

concommand.Add("mcs_setup", function(ply) 
	
	if !ply:IsSuperAdmin() then return end
	
	net.Start("OpenMCSSetupMenu")
	net.Send(ply)

end)

net.Receive("StartMCSSvFunc", function(l, ply)
	
	local aid = net.ReadString()
	
	if !aid then return end
	
	if MCS.AddonList[aid] and MCS.AddonList[aid]["enabled"] then
		if MCS.AddonList[aid]["function_sv"] then
			MCS.AddonList[aid]["function_sv"](ply) 
		end
	end
	
end)

net.Receive("CloseMCSMenu", function(l, ply)
	
	local npc = net.ReadEntity()
	
	if !npc or !IsValid(npc) then return end
	
	npc.UsingPlayer = false
	npc:ResetSequence(npc:GetDefAnimation())
	
end)

net.Receive("StartMCSAnimation", function(l, ply)
	
	local npc = net.ReadEntity()
	local anim = net.ReadString()
	
	if !npc or !IsValid(npc) or !anim then return end
	
	--npc:ResetSequence(anim)
	
end)