-- function sendLogsToDis(s_text)
--   http.Post( "https://gmod-octopus.ru/discordlogs.php", { content = s_text}, function( result )
--   end, function( failed )
--     print( failed )
--   end )
-- end
-- function sendBansToDis(s_text)
--   http.Post( "https://gmod-octopus.ru/discordlogs.php", { bans = s_text}, function( result )
--   end, function( failed )
--     print( failed )
--   end )
-- end
-- DiscordLoggerHooks = {
--   -- {
--   --   hook = "CheckPassword", func = function(communityID, ip, serverPassword, enteredPassword, name)
--   --     local steamID = util.SteamIDFrom64(communityID)

--   --     sendLogsToDis("Player ".. "**"..name.."**(``"..steamID.."``) is attempting to connect.")
--   --   end
--   -- },
--   -- {
--   --   hook = "PlayerInitialSpawn", func = function(player)
--   --     local name = player:Nick()
--   --     local steamID = player:SteamID()

--   --     sendLogsToDis("Player ".. "**"..name.."**(``"..steamID.."``) has spawned in the server")
--   --   end
--   -- },
--   -- {
--   --   hook = "PlayerDisconnected", func = function(player)
--   --     local name = player:Nick()
--   --     local steamID = player:SteamID()

--   --     sendLogsToDis("Player ".. "**"..name.."**(``"..steamID.."``) has left the server")
--   --   end
--   -- },
--   -- {
--   --   hook = "PlayerSay", func = function(player, text, m_bToAll, m_bDead)
--   --     local strMsg = string.Explode(" ",text)

--   --     local name = player:Nick()
--   --     local steamID = player:SteamID()

--   --     -- print(strMsg[1][1] ~= '/')
--   --     if strMsg[1][1] ~= '/' then
--   --       sendLogsToDis( "**"..name.."**(``"..steamID.."``): "..text )
--   --     end
--   --   end
--   -- },
--   -- {
--   --   hook = "CanDrive", func = function(player, entity)
--   --     local name = player:Nick()
--   --     local steamID = player:SteamID()

--   --     sendLogsToDis("**"..name.."**(``"..steamID.."``) attempted to drive entity \""..tostring(entity).."\"")
--   --   end
--   -- },
--   -- {
--   --   hook = "CanTool", func = function(player, trace, toolMode)
--   --     local name = player:Nick()
--   --     local steamID = player:SteamID()

--   --     sendLogsToDis("**"..name.."**(``"..steamID.."``) used tool \""..toolMode.."\"")
--   --   end
--   -- },
--   -- {
--   --   hook = "OnPhysgunReload", func = function(weapon, player)
--   --     local name = player:Nick()
--   --     local steamID = player:SteamID()

--   --     sendLogsToDis("**"..name.."**(``"..steamID.."``) un-froze (reloaded) using the physgun")
--   --   end
--   -- },
--   -- {
--   --   hook = "PlayerSpawnedProp", func = function(player, model, entity)
--   --     local name = player:Nick()
--   --     local steamID = player:SteamID()

--   --     sendLogsToDis("**"..name.."**(``"..steamID.."``) spawned prop \"``"..tostring(entity).."`` ``("..model..")``\"")
--   --   end
--   -- },
--   -- {
--   --   hook = "PlayerSpawnedRagdoll", func = function(player, model, entity)
--   --     local name = player:Nick()
--   --     local steamID = player:SteamID()

--   --     sendLogsToDis("**"..name.."**(``"..steamID.."``) spawned ragdoll \""..tostring(entity).." ("..model..")\"")
--   --   end
--   -- },
--   -- {
--   --   hook = "PlayerSpawnedVehicle", func = function(player, entity)
--   --     local name = player:Nick()
--   --     local steamID = player:SteamID()

--   --     sendLogsToDis("**"..name.."**(``"..steamID.."``) spawned vehicle \""..tostring(entity).."\"")
--   --   end
--   -- },
--   -- {
--   --   hook = "PlayerSpawnedEffect", func = function(player, model, entity)
--   --     local name = player:Nick()
--   --     local steamID = player:SteamID()

--   --     sendLogsToDis("**"..name.."**(``"..steamID.."``) spawned effect \""..tostring(entity).." ("..model..")\"")
--   --   end
--   -- },
--   -- {
--   --   hook = "PlayerSpawnedNPC", func = function(player, entity)
--   --     local name = player:Nick()
--   --     local steamID = player:SteamID()

--   --     sendLogsToDis("**"..name.."**(``"..steamID.."``) spawned npc \""..tostring(entity).."\"")
--   --   end
--   -- },
--   -- {
--   --   hook = "PlayerSpawnedSENT", func = function(player, entity)
--   --     local name = player:Nick()
--   --     local steamID = player:SteamID()

--   --     sendLogsToDis("**"..name.."**(``"..steamID.."``) spawned SENT \""..tostring(entity).."\"")
--   --   end
--   -- },
--   -- {
--   --   hook = "PlayerSpawnedSWEP", func = function(player, entity)
--   --     local name = player:Nick()
--   --     local steamID = player:SteamID()

--   --     sendLogsToDis("**"..name.."**(``"..steamID.."``) spawned SWEP \""..tostring(entity).."\"")
--   --   end
--   -- },
--   -- {
--   --   hook = "PlayerGiveSWEP", func = function(player, class, swep )
--   --     local name = player:Nick()
--   --     local steamID = player:SteamID()

--   --     sendLogsToDis("**"..name.."**(``"..steamID.."``) give SWEP \""..class.."\" for **yourself**")
--   --   end
--   -- },
--   -- {
--   --   hook = "PlayerDeath", func = function(player, inflictor, attacker)
--   --     if (attacker:IsPlayer()) then
--   --       sendLogsToDis("**"..attacker:Nick().."**(``"..attacker:SteamID().."``) has killed **"..player:Nick().."**(``"..player:SteamID().."``).");
--   --     else
--   --       sendLogsToDis("``"..attacker:GetClass().."`` has killed **"..player:Nick().."**(``"..player:SteamID().."``).");
--   --     end;
--   --   end
--   -- },
--   -- {
--   --   hook = "serverguard.RanCommand", func = function(player, commandTable, bSilent, arguments)
--   --     if (util.IsConsole(player)) then
--   --       sendLogsToDis(string.format(
--   --         "Console ran command \"%s %s\"", commandTable.command, table.concat(arguments, " ")
--   --       )); return;
--   --     end;

--   --     local steamID = player:SteamID()
--   --     local playerNick = player:Nick();

--   --     if (arguments and table.concat(arguments, " ") != "") then
--   --       sendLogsToDis(string.format(
--   --         "**%s**(``%s``) ran command \"``%s`` ``%s``\"", playerNick, steamID, commandTable.command, table.concat(arguments, " ")
--   --       ));
--   --     else
--   --       sendLogsToDis(string.format(
--   --         "**%s**(``%s``) ran command \"``%s``\"", playerNick, steamID, commandTable.command
--   --       ));
--   --     end;
--   --   end
--   -- }
-- }

-- function DiscordLoggerDetectHook(strHook,callback)
--   hook.Add(strHook,strHook..'_DiscordLogger',callback)
-- end

-- for _, v in pairs(DiscordLoggerHooks) do
--   DiscordLoggerDetectHook(v.hook,v.func)
-- end



