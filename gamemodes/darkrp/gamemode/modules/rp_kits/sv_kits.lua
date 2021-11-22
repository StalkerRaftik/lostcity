util.AddNetworkString('GiveKit')

net.Receive('GiveKit', function(_, ply)
  local kitid = net.ReadString()
  local kit
  local kitgroup 
  for group, tab in pairs(rp.Kits.Config) do
      for id, data in pairs(tab) do
          if data.Name == kitid then
              if not rp.Kits.Config[group][id] then return end
              kit = rp.Kits.Config[group][id]
              kitgroup = group
          end
      end 
  end

  local cd = rp.Kits.NiceNames[kitgroup].cooldown

  if not rp.Kits.NiceNames[kitgroup] then return false end
  if kit.Level and ply:GetLevel() < kit.Level then DarkRP.notify(ply, 1, 4, "Ваш уровень слишком мал!") return false end
  if ply:GetNWInt("AllowedToUse"..kitgroup.."KitsTime") >= os.time() then DarkRP.notify(ply, 1, 4, "Набор на перезарядке!") return false end
  if kit.Rank and not ply:AllowedToUseKit(kit) then DarkRP.notify(ply, 1, 4, "Вы не можете использовать этот набор!") return false end

  for class, info in pairs(kit.Items) do
      local itemTable = Inventory.GetItem(info[1], class)
      local amount = info[2] or 1
      print(class)
      if itemTable then 
          for i = 1,amount do 
            ply:AddItem(info[1], class)
          end
      end
  end

  DarkRP.notify(ply, 1, 4, "Вы получили набор "..kitid..". Проверяйте инвентарь!")
  file.Write( "kitsdata/" .. ( ply:SteamID64() or "0" ) .. "_"..kitgroup..".txt", os.time() + cd)

end)

if not file.IsDir( "kitsdata", "DATA" ) then file.CreateDir( "kitsdata" ) end

function CheckForKitsData(ply)
  for index, kits in pairs(rp.Kits.Config) do
    local datafile = file.Read( "kitsdata/" .. ( ply:SteamID64() or "0" ) .. "_"..index..".txt", "DATA" )
    if not datafile then
      file.Write( "kitsdata/" .. ( ply:SteamID64() or "0" ) .. "_"..index..".txt", nil )
    else
      local time = tonumber(datafile)
      if time and time ~= nil then
        ply:SetNWInt("AllowedToUse"..index.."KitsTime", time)
      else
        ply:SetNWInt("AllowedToUse"..index.."KitsTime", nil)
      end
    end
  end
end

hook.Add( "PlayerCharLoaded", "SetupDataForKits", function(ply)
  CheckForKitsData(ply)
end)

timer.Create("CheckForDataTimerKits", 5, 0, function()
  for k, v in pairs(player.GetAll()) do
    CheckForKitsData(v)
  end
end)

hook.Add("PlayerSwitchWeapon", "BanUnsuableWeapons", function(ply, oldw, neww)
    ply:StripWeapon('weapon_rpg')
end)