if not SERVER then return end
zlm = zlm or {}
zlm.f = zlm.f or {}


if zlm_BuyerNPCs == nil then
	zlm_BuyerNPCs = {}
end

function zlm.f.Add_BuyerNPC(npc)
	table.insert(zlm_BuyerNPCs, npc)
end


function zlm.f.Check_BuyerMarkt_TimerExist()
	if timer.Exists("zlm_buyermarkt_id") == false and zlm.config.NPC.RefreshRate ~= -1 then
		timer.Create("zlm_buyermarkt_id", zlm.config.NPC.RefreshRate, 0, zlm.f.ChangeMarkt)
	end
end

hook.Add("InitPostEntity", "zlm_buyermarkt_OnMapLoad", zlm.f.Check_BuyerMarkt_TimerExist)

function zlm.f.ChangeMarkt()
	for k, v in pairs(zlm_BuyerNPCs) do
		if (IsValid(v)) then
			v:RefreshBuyRate()
		end
	end

	zlm.f.debug("NPCs Updated!")
end


// The SAVE / LOAD Functions
concommand.Add("zlm_save_buyernpc", function(ply, cmd, args)
	if IsValid(ply) and zlm.f.IsAdmin(ply) then
		zlm.f.Save_BuyerNPC()
		zlm.f.Notify(ply, "Grass Buyer NPC´s have been saved for the map " .. game.GetMap() .. "!", 0)
	end
end)

concommand.Add("zlm_remove_buyernpc", function(ply, cmd, args)
	if IsValid(ply) and zlm.f.IsAdmin(ply) then
		zlm.f.Remove_BuyerNPC()
		zlm.f.Notify(ply, "Grass Buyer NPC´s have been removed for the map " .. game.GetMap() .. "!", 0)
	end
end)

function zlm.f.Save_BuyerNPC()
	local data = {}

	for u, j in pairs(ents.FindByClass("zlm_buyer_npc")) do
		table.insert(data, {
			pos = j:GetPos(),
			ang = j:GetAngles()
		})
	end

	if not file.Exists("zlm", "DATA") then
		file.CreateDir("zlm")
	end

	file.Write("zlm/" .. string.lower(game.GetMap()) .. "_buyernpcs" .. ".txt", util.TableToJSON(data))
end

function zlm.f.Load_BuyerNPC()
	if file.Exists("zlm/" .. string.lower(game.GetMap()) .. "_buyernpcs" .. ".txt", "DATA") then
		local data = file.Read("zlm/" .. string.lower(game.GetMap()) .. "_buyernpcs" .. ".txt", "DATA")
		data = util.JSONToTable(data)

		if data and table.Count(data) > 0 then
			for k, v in pairs(data) do
				local npc = ents.Create("zlm_buyer_npc")
				npc:SetPos(v.pos)
				npc:SetAngles(v.ang)
				npc:Spawn()
				npc:Activate()
			end

			print("[Zeros LawnMower] Finished loading Buyer NPCs.")
		end
	else
		print("[Zeros LawnMower] No map data found for BuyerNPCs entities. Please place some and do !savezlm to create the data.")
	end
end

function zlm.f.Remove_BuyerNPC()
	if file.Exists("zlm/" .. string.lower(game.GetMap()) .. "_buyernpcs" .. ".txt", "DATA") then
		file.Delete("zlm/" .. string.lower(game.GetMap()) .. "_buyernpcs" .. ".txt")
	end

	for k, v in pairs(ents.FindByClass("zlm_buyer_npc")) do
		if IsValid(v) then
			v:Remove()
		end
	end
end

hook.Add("InitPostEntity", "zlm_SpawnBuyerNPC", zlm.f.Load_BuyerNPC)
hook.Add("PostCleanupMap", "zlm_SpawnBuyerNPCPostCleanUp", zlm.f.Load_BuyerNPC)
