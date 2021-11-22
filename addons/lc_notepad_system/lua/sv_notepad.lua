-- можно было бы в одну папку сместить cl_notepad и этот файл, но я не лох.
 Notepad.Spam = {}
 Notepad.KickSpam = {"чо дохуя умный?","шо дрочешь","харе дрочить"}

util.AddNetworkString("net_notepad_send")
util.AddNetworkString("net_notepad_sending")

util.AddNetworkString("net_notepad_baked")
util.AddNetworkString("net_notepad_close")
util.AddNetworkString("net_notepad_sound")


function Notepad.CheckSpam()
 for steamid,info in pairs(Notepad.Spam) do
  local Ply = player.GetBySteamID(steamid)

   if Ply and info.Count > GetConVar("sv_nt_netlimitspam"):GetInt() then
    Ply:Kick(Notepad.KickSpam[math.random(1,#Notepad.KickSpam)] .. "\n:NET_SPAM_LIMIT_NOTEPAD:") -- у пафас
   end -- Kick

   timer.Simple(info.Time,function()
    if not Notepad.Spam[steamid] then return end
     Notepad.Spam[steamid] = 0
   end)

 end -- For

end

net.Receive("net_notepad_sending",function(len,ply)
if GetConVar("sv_nt_netlimitspam"):GetInt() > 0 then
 if not Notepad.Spam[ply:SteamID()] then Notepad.Spam[ply:SteamID()] = {Time = CurTime() + 1,Count = 1} return end 
  Notepad.Spam[ply:SteamID()].Count = Notepad.Spam[ply:SteamID()].Count + 1
  Notepad.CheckSpam()
end -- Enable

 local Ent = net.ReadEntity()
 local Page = net.ReadInt(5)
 local Info = net.ReadTable()
 
 if not Ent:IsValid() or Ent:GetClass() != "ent_notepad" or Ent:GetWriter() != ply or Page > Ent.LimitPages or not Ent.Pages.Pages[Page] or Ent.Baked then return end
 
 local Access = true
 for name,key in pairs(Info) do
  if name != "Content" and name != "Title" and name != "Paint" then Access = false break end
  --
  if name == "Title" and type(key) != "string" then Access = false break end
  if name == "Content" and type(key) != "string" then Access = false break end
  if name == "Paint" and type(key) != "table" then Access = false break end

 end

 if not Access then return end -- sasi xexexexexe

 local Table = Ent:GetTable()
 Table.Pages.Pages[Page] = Info
 Ent:SetTable(Table)

end)

net.Receive("net_notepad_sound",function(len,ply)
 local Ent = net.ReadEntity()
 local SoundName = net.ReadString()

 if not Ent:IsValid() or Ent:GetClass() != "ent_notepad" or (Ent:GetWriter() != ply and SoundName ~= "leaf") then return end
 if not Notepad.Sounds[SoundName] then return end
 local Table = Ent:GetTable()
 if tonumber(Table.NextSound) > CurTime() then return end -- чо
 
  Table.NextSound = CurTime() + 0.1
  Ent:SetTable(Table)

 sound.Play(Sound(Notepad.Sounds[SoundName][math.random(1,#Notepad.Sounds[SoundName])]),Ent:GetPos())
end)

net.Receive("net_notepad_close",function(len,ply)
 local Ent = net.ReadEntity()

 if not Ent:IsValid() or Ent:GetClass() != "ent_notepad" or Ent:GetWriter() != ply then return end

 Ent:SetWriter(nil)
end)

net.Receive("net_notepad_baked",function(len,ply)
 local Ent = net.ReadEntity()

 if not Ent:IsValid() or Ent:GetClass() != "ent_notepad" or Ent:GetWriter() != ply then return end

 local Table = Ent:GetTable()
  Table.Pages.Baked = true
  Ent:SetTable(Table)
  Ent:SetWriter(nil)
end)