-- util.AddNetworkString("rp.Quests.DoAction")
-- util.AddNetworkString("rp.Quests.Finish")

-- hook.Add("Initialize", "rp.Quests.CreateDB", function()
-- 	db:Query("CREATE TABLE IF NOT EXISTS rp_quests(SteamID64 VARCHAR(255) NOT NULL PRIMARY KEY, data TEXT NOT NULL, dataprogress TEXT NOT NULL)")

-- end)

-- hook.Add('PlayerDataLoaded', "rp.Quests.LoadQuestsData",function(ply)
--     ply:SetNVar("PlayerQuest", nil, NETWORK_PROTOCOL_PRIVATE)
--     ply:SetNVar("PlayerQuestDone", {}, NETWORK_PROTOCOL_PRIVATE)
--     ply:SetNVar("PlayerQuestState", {}, NETWORK_PROTOCOL_PRIVATE)
--     ply.PlayerQuestState = {}

-- 	db:Query('SELECT * FROM rp_quests WHERE steamid64=' .. ply:SteamID64() .. ';', function(data)
--         if data[1] then
--             if (data[1].data ~= nil) and data[1].data ~= "[]" then
--                 ply.QuestsDone = util.JSONToTable(data[1].data)
--                 ply:SetNVar("PlayerQuestDone", ply.QuestsDone, NETWORK_PROTOCOL_PRIVATE)
--             else
--                 ply.QuestsDone = {}
--             end
--             if (data[1].dataprogress ~= nil) and data[1].dataprogress ~= "[]"  then
--                 ply.QuestsProgress = util.JSONToTable(data[1].dataprogress)
--             else
--                 ply.QuestsProgress = {}
--             end
--         else
--             ply.QuestsDone = {}
--             ply.QuestsProgress = {}
--             db:Query('INSERT INTO rp_quests (steamid64, data, dataprogress) VALUES(?, ?, ?);', ply:SteamID64(), util.TableToJSON(ply.QuestsDone), util.TableToJSON(ply.QuestsProgress))
--         end
--     end)

-- end)

-- function PLAYER:SelectQuest(id, doaction)   
-- 	if (rp.Quests.List[id] and not table.HasValue(self.QuestsDone, id)) then
        
--         -- if doaction then
--             self.QuestsProgress = {}
--             self.QuestsProgress[id] = 1
--             db:Query( "UPDATE `rp_quests` SET dataprogress = '" .. util.TableToJSON(self.QuestsProgress, false) .. "' WHERE steamid64 = '" .. self:SteamID64() .. "'" )
--         -- end

--         self.PlayerQuestState[id] = 1
--         self:SetNVar("PlayerQuest", id, NETWORK_PROTOCOL_PRIVATE)
--         self:SetNVar("PlayerQuestState", self.PlayerQuestState, NETWORK_PROTOCOL_PRIVATE)

--         if rp.Quests.List[id].states[1].action and doaction then
--             local action = rp.Quests.List[id].states[1].action
--             action(self)
--             net.Start("rp.Quests.DoAction")
--             net.Send(self)
--         end
-- 	end
-- end


-- function PLAYER:QuestProgress(id)
-- 	if self:GetActiveQuest() == id then

--         if (rp.Quests.List[id].states[self:GetQuestState(id)].reward) then
--             for type, reward in pairs(rp.Quests.List[id].states[self:GetQuestState(id)].reward) do
--                 if type == "money" then 
--                     self:AddMoney(reward)
--                     DarkRP.notify(self, 3, 10, "Вы получили "..reward.." монет за выполнение этапа задания: "..rp.Quests.GetQuestName(id))
--                 elseif type == "items" then
--                     if reward.entity then
--                         for _, ent in pairs(reward.entity) do
--                             self:AddItem("entity", ent)
--                         end
--                     end
--                     if reward.weapon then
--                         for _, wep in pairs(reward.weapon) do
--                             self:AddItem("weapon", wep)
--                         end
--                     end                    
--                     DarkRP.notify(self, 3, 10, "Вы получили награду за выполнение этапа задания: "..rp.Quests.GetQuestName(id)..", загляните в инвентарь")
--                 end
--             end
-- 		end

--         if self:GetQuestState(id) + 1 > table.Count(rp.Quests.List[id].states) then self:FinishQuest() return end
    
--         self.PlayerQuestState[id] = self.PlayerQuestState[id] + 1
    
--         self:SetNVar("PlayerQuestState", self.PlayerQuestState, NETWORK_PROTOCOL_PRIVATE)
--         self.QuestsProgress[id] = self:GetQuestState(idid)
--         db:Query( "UPDATE `rp_quests` SET dataprogress = '" .. util.TableToJSON(self.QuestsProgress, false) .. "' WHERE steamid64 = '" .. self:SteamID64() .. "'" )

--         if rp.Quests.List[id].states[self:GetQuestState(id)].action then
--             local action = rp.Quests.List[id].states[self:GetQuestState(id)].action
--             action(self)
--             net.Start("rp.Quests.DoAction")
--             net.Send(self)
--         end
--     end
-- end


-- function PLAYER:SetQuestStage(id, stage)
-- 	if self:GetActiveQuest() == id then
--         self.PlayerQuestState[id] = stage

--         self:SetNVar("PlayerQuestState", self.PlayerQuestState, NETWORK_PROTOCOL_PRIVATE)
--         self.QuestsProgress[id] = stage
--         db:Query( "UPDATE `rp_quests` SET dataprogress = '" .. util.TableToJSON(self.QuestsProgress, false) .. "' WHERE steamid64 = '" .. self:SteamID64() .. "'" )

--         if rp.Quests.List[id].states[stage].action then
--             local action = rp.Quests.List[id].states[stage].action
--             action(self)
--             net.Start("rp.Quests.DoAction")
--             net.Send(self)
--         end
--     end
-- end


-- function PLAYER:ClearQuests()
--     self:SetNVar("PlayerQuest", nil, NETWORK_PROTOCOL_PRIVATE)
-- end

-- function PLAYER:FinishQuest()
-- 	local quest = self:GetActiveQuest()

-- 	if (rp.Quests.List[quest]) then
--         table.insert(self.QuestsDone, quest)
--         db:Query( "UPDATE `rp_quests` SET data = '" .. util.TableToJSON(self.QuestsDone, false) .. "' WHERE steamid64 = '" .. self:SteamID64() .. "'" )
--         self:SetNVar("PlayerQuestDone", self.QuestsDone, NETWORK_PROTOCOL_PRIVATE)

--         net.Start("rp.Quests.Finish")
--         net.Send(self)
		
--         if (rp.Quests.List[quest].reward) then
--             for k, v in pairs(rp.Quests.List[quest].reward) do
--                 self:AddItem(v.class, v.ent)
--             end
--             -- if rp.Quests.List[quest].reward.money then
--             --     self:AddMoney(rp.Quests.List[quest].reward.money)
--             -- end
--             -- if rp.Quests.List[quest].reward.xp then
--             --     self:AddExperience(rp.Quests.List[quest].reward.xp)
--             -- end
--             DarkRP.notify(self, 3, 10, "Вы получили награду за выполнение задания: "..rp.Quests.GetQuestName(quest)..", загляните в инвентарь")
-- 		end

--         self:SetNVar("PlayerQuest", nil, NETWORK_PROTOCOL_PRIVATE)

-- 	end
-- end

-- rp.AddCommand("/selectquest", function(pl, text, args)
--     if not args[1] then return end
--     local id = args[1]
--     pl:SelectQuest(id, true)   
-- end)