-- local limit = 65535

-- hook.Add("PreProcessMessages", "FixNetBuffer", function(netchan, read, write, localchan)
--   local totalbits = read:GetNumBitsLeft() + read:GetNumBitsRead()
--   if totalbits > limit then
--     local ply = FindPlayerByNetChannel(netchan)
--     if IsValid(ply) then
--       ply:Ban(0, true)
--     end
--   end
-- end)

--   // Exploit fix
--   if (totalbits > SourceNet.ExploitMaxPacketLenght) then
--     local ply = FindPlayerByNetChannel(netchan)
--     if IsValid(ply) then
--       ply:Ban(0, true)
--     end
--     return
--   end