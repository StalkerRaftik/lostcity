-- rp.Quests = rp.Quest or {}

-- rp.Quests.List = {
--     ["tutorial"] = {
--         name = "Путь к выживанию",
--         description = "",
--         reward = {
--             [1] = {ent = "tfa_colt1911", class = "weapon", name = "M1911",},
--             [2] = {ent = "tfa_ammo_pistol", class = "entity", name = "Патроны",},
--         },
--         states = {
--             [1] = {
--                 title = "Мне нужно найти безопасное место. Говорят, где-то на холме находится убежище. Так или иначе, стоит поспрашивать местных.",
--                 reward = {
--                     money = 100,
--                 },
--                 action = function(QuestName, QuestStage) 
--                     if SERVER then 
--                         timer.Create( "rp.Quests.CheckPlayerGZ", 5, 0, function()
--                         	for _,ply in pairs(player.GetAll()) do
-- 	                            if ( !IsValid( ply ) or !ply.GetPos ) then return end
-- 	                            if not ply.QuestsProgress then return end 
--                                 if ply.QuestsProgress[QuestName] ~= QuestStage then return end 
	                            
-- 	                            if rp.Zones:InsideSafeZone( ply:GetPos() ) then
-- 	                                ply:QuestProgress("tutorial")
-- 	                            end
-- 	                        end
--                         end)
--                     end
--                 end
--             },
--             [2] = {
--                 title = "Поговорите c Джо, главой местной охраны",
--                 action = function(QuestName, QuestStage) 
--                     if SERVER then
--                         hook.Add("PlayerUse", "rp.Quests.DialogueWithJoe", function(ply, ent)
--                         	if not ply.QuestsProgress then return end 
--                             if ply.QuestsProgress[QuestName] ~= QuestStage then return end 

--                             if ent:GetClass() == "mcs_npc" and ent:GetUID() == "ubejjob" then
--                                 ply:QuestProgress("tutorial")
--                             end
--                         end)
--                     else

--                     end
--                 end
--             },         
--             [3] = {
--                 title = "Купите что-нибудь у Джо",
--                 action = function(QuestName, QuestStage) 
--                     if SERVER then
--                         hook.Add( "rp.inv.BuyItem", "rp.Quests.BuySomething", function(ply, type, class, count )
--                             if not ply.QuestsProgress then return end 
--                             if ply.QuestsProgress[QuestName] ~= QuestStage then return end 

--                             ply:QuestProgress("tutorial")
--                         end)
--                     else

--                     end
--                 end
--             },       
--             [4] = {
--                 title = "Откройте рюкзак и используйте предмет (Клавиши F4 или TAB)",
--                 action = function(QuestName, QuestStage) 
--                     if SERVER then
--                         hook.Add( "PlayerUseInventory", "rp.Quests.PlayerUseInventory", function(ply, type, class )
--                             if not ply.QuestsProgress then return end 
--                             if ply.QuestsProgress[QuestName] ~= QuestStage then return end 

--                             ply:QuestProgress("tutorial")
--                         end)
--                     else

--                     end
--                 end
--             },  
--             [5] = {
--                 title = "Найдите в убежище верстак",
--                 reward = {
--                     money = 200,
--                 },                
--                 action = function(QuestName, QuestStage) 
--                     if SERVER then
--                         hook.Add("PlayerUse", "rp.Quests.OpenCraftTable", function(ply, ent)
--                         	if not ply.QuestsProgress then return end 
--                             if ply.QuestsProgress[QuestName] ~= QuestStage then return end 

--                             if ent:GetClass() == "ent_craft_table" then
--                                 ply:QuestProgress("tutorial")
--                             end
--                         end)                        
--                     else

--                     end
--                 end
--             },    
--             [6] = {
--                 title = "Пора выдвигаться наружу. Добудьте пару вещей за пределами убежища.",
--                 action = function(QuestName, QuestStage) 
--                     if SERVER then           
--                         hook.Add( "rp.inv.AddItem", "rp.Quests.GetSomeLoot", function( ply, type, class, count )
--                             if not ply.QuestsProgress then return end 
--                             if ply.QuestsProgress[QuestName] ~= QuestStage then return end 

--                             ply:QuestProgress("tutorial")
--                         end)
--                     else

--                     end
--                 end
--             },       
--             [7] = {
--                 title = "Отлично, теперь я обзавёлся вещами. Надо попробовать продать что-нибудь Джо. Можно пойти прямо сейчас продать ему вещи, либо поискать еще что-нибудь. Главное быть осторожным.",
--                 reward = {
--                     items = {
--                         ["entity"] = {"ent_medkit", "ent_medkit", "ent_bandage", "ent_bandage", "ent_smallmedkit", "ent_smallmedkit", "ent_smallmedkit"},
--                         ["weapon"] = {"wep_jack_job_drpradio", "tfa_breadnope_axe"},
--                     },
--                 },                
--                 action = function(QuestName, QuestStage) 
--                     if SERVER then
--                         hook.Add( "rp.inv.SellItem", "rp.Quests.SellSomeLoot", function( ply, type, class, count )
--                             if not ply.QuestsProgress then return end 
--                             if ply.QuestsProgress[QuestName] ~= QuestStage then return end 

--                             ply:QuestProgress("tutorial")
--                         end)
--                     else

--                     end
--                 end
--             },          
--             [8] = {
--                 title = "Одному в этих краях не выжить, нужно найти себе напарников. Джо может взять меня охранником на работу, если я стану достаточно опытным и научусь выживать вне убежища(вступите в любую группировку).",
--                 action = function(QuestName, QuestStage) 
--                     if SERVER then
--                         hook.Add("OnPlayerChangedTeam", "rp.Quests.ChangeTeam", function(ply, prevTeam, t)
--                             if not ply.QuestsProgress then return end 
--                             if ply.QuestsProgress[QuestName] ~= QuestStage then return end 

--                             ply:QuestProgress("tutorial")
--                         end)
--                     else

--                     end
--                 end
--             },                           
--         },
--     },
--     ["test"] = {
--         name = "Ебаный рот этого казино БЛЯТЬ",
--         description = "антон",
--         reward = {
--             [1] = {ent = "tfa_colt1911", class = "weapon", name = "M1911",},
--             [2] = {ent = "tfa_ammo_pistol", class = "entity", name = "Вы проебали деньги",},
--         },
--         states = {
--             [1] = {
--                 title = "ЁБАНЫЙ ТВОЙ РОТ! КАКОГО ХУЯ ОНИ В ДРУГОМ ПОРЯДКЕ РАЗЛОЖЕНЫ? Ты распечатала колоду на моих глазах, БЛЯДЬ! Как они могут быть там разложены в другом порядке?!",
--                 reward = {
--                     money = 228,
--                 },
--                 action = function(QuestName, QuestStage) 
--                     if SERVER then 
--                        function usermessage.IncomingMessage( name, msg )
--                             if not ply.QuestsProgress then return end 
--                             if ply.QuestsProgress[QuestName] ~= QuestStage then return end 
                            
--                             if msg == "Хуй" then
--                                 print('Ура')
--                                 ply:QuestProgress("tutorial")
--                             end

--                        end
--                     end
--                 end
--             },                         
--         },
--     },
--     ["test2"] = {
--         name = "Ебаный рот этого казино БЛЯТЬ",
--         description = "антон",
--         reward = {
--             [1] = {ent = "tfa_colt1911", class = "weapon", name = "M1911",},
--             [2] = {ent = "tfa_ammo_pistol", class = "entity", name = "Вы проебали деньги",},
--         },
--         states = {
--             [1] = {
--                 title = "ДЕГЕНЕРАТ ЕБУЧИЙ! Вот пока ты это делал, дебил, ебаная сука, БЛЯДЬ, так все и происходило!",
--                 reward = {
--                     money = 228,
--                 },
--                 action = function(QuestName, QuestStage) 
--                     if SERVER then 
--                        function usermessage.IncomingMessage( name, msg )
--                             if not ply.QuestsProgress then return end 
--                             if ply.QuestsProgress[QuestName] ~= QuestStage then return end 
                            
--                             if msg == "Хуй" then
--                                 print('Ура')
--                                 ply:QuestProgress("tutorial")
--                             end

--                        end
--                     end
--                 end
--             },                         
--         },
--     },
-- }

-- function PLAYER:GetActiveQuest()
-- 	return self:GetNVar("PlayerQuest") or nil
-- end

-- function rp.Quests.GetQuestName(id)
-- 	return rp.Quests.List[id].name
-- end

-- function PLAYER:GetQuestState(id)
-- 	return (self:GetNVar("PlayerQuestState")[id]) or 0
-- end

-- function GetQuestStatesCount(id)
-- 	return table.Count(rp.Quests.List[id].states)
-- end

-- function PLAYER:GetQuestDone(id)
-- 	return table.HasValue(self:GetNVar("PlayerQuestDone"), id) or false
-- end

-- function PLAYER:GetQuestStateName()
-- 	return rp.Quests.List[self:GetNVar("PlayerQuest")].states[self:GetQuestState(self:GetNVar("PlayerQuest"))].title
-- end
