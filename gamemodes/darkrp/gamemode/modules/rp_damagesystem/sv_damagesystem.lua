local function updateplayer(ply)
  ply.hide_head = false
  for k,v in pairs( ply.Cosmetics ) do
    local itemdata = Cosmetics.Items[v]
    if itemdata and itemdata.hide_head then
      ply.hide_head = true
    end
  end
  local b = ply:LookupBone("ValveBiped.Bip01_Head1")
  if not b then return end
  if ply.hide_head then
    ply:ManipulateBoneScale( b, Vector(0.1, 0.1, 0.1) )
  else
    ply:ManipulateBoneScale( b, Vector(1, 1, 1) )
  end
end
  
local function getNearestPhysicsBonePos(ent, target)
  local near, neardist = ent:GetPos(), math.huge 
  for i = 0, ent:GetPhysicsObjectCount() - 1 do 
    local phys = ent:GetPhysicsObjectNum(i)
    if phys:IsValid() then
      local pos = phys:GetPos()
      local dist = (target - pos):LengthSqr()
      if dist < neardist then
        near, neardist = pos, dist
      end
    end
  end
  return near
end

function PLAYER:RemoveCosmetic(cType)
    if not Cosmetics.Items[cType] then return end

    local data = Cosmetics.Items[cType]

    if self.Cosmetics[data.slot] and self.Cosmetics[data.slot] == cType then -- if exists

        self.Cosmetics[data.slot] = nil
        updateplayer(self)

        self:RemovePData("Cosmetics_" .. data.slot)

        if data.equipsound then
            self:EmitSound( data.equipsound )
        end

        self:NetVars("Cosmetics", self.Cosmetics, true)

        hook.Call("CosmeticsChanged", nil, self)

    else
        return false
    end
end

function PLAYER:StartBleeding()
    self.bloodLosing = 0
    self:SetNVar("Bleeding", true)
end

function PLAYER:StopBleeding()
    self:SetNVar("Bleeding", false)
end

hook.Add("EntityTakeDamage", "rp.DamageSystem.DamageSystem", function(ent, dmg)
    if not ent:IsPlayer() then return end
    if not dmg:IsBulletDamage() then return end
    if rp.Zones:InsideSafeZone(ent:GetPos()) then return end
    local dmgpos = dmg:GetDamagePosition()

    local tr = util.TraceLine({
    start = dmgpos,
    endpos = dmgpos
    })


    ent:SetNVar("Bleeding", true, NETWORK_PROTOCOL_PUBLIC)
    if tr.PhysicsBone == 12 then
        if ent:HasHelmet() then
            dmg:ScaleDamage(0.1)
            ent:RemoveCosmetic(ent.Cosmetics[COSM_SLOT_HAT])
        else
            dmg:ScaleDamage(7)
        end
    else
        if ent:HasVest() then
            dmg:ScaleDamage(0.5)
            if ent:GetNVar("VestDamage") >= 5 then
                ent:RemoveCosmetic(ent.Cosmetics[COSM_SLOT_MISC])
                ent:SetNVar("VestDamage", 0, NETWORK_PROTOCOL_PUBLIC)
            end
            ent:SetNVar("VestDamage", ent:GetNVar("VestDamage") + 1, NETWORK_PROTOCOL_PUBLIC)
        end
    end
end)

hook.Add("EntityTakeDamage", "rp.DamageSystem.BleedChanceByZombies", function(ent, dmg)
  if not ent:IsPlayer() then return end
  if dmg:IsBulletDamage() then return end
  if rp.Zones:InsideSafeZone(ent:GetPos()) then return end

  local attacker = dmg:GetAttacker()
  if not attacker:IsNPC() then return end
  
  local bleedchance = math.random(1,100)
  if bleedchance > 80 then
    ent:StartBleeding()
  end
end)


hook.Add("PlayerSpawn", "rp.DamageSystem.SetUPVars", function(ply)
    ply:SetNVar("VestDamage", 0, NETWORK_PROTOCOL_PUBLIC)
    ply:SetNVar("Bleeding", false, NETWORK_PROTOCOL_PUBLIC)
    ply:SetNVar("Infected", false, NETWORK_PROTOCOL_PUBLIC)
    ply:SetNVar("Legbroken", false, NETWORK_PROTOCOL_PUBLIC)
    ply:SetNVar("SprintBoost", 0, NETWORK_PROTOCOL_PUBLIC)
    ply.bloodLosing = 0
end)

function rp.DamageSystem.HurtSound(ply,zone,level)
   local voicetype = rp.DamageSystem.GetVoiceType(ply)
   local location = nil
   local level = level or 75
   if !ply.hurttimer then
      location = rp.DamageSystem.PainSounds[rp.DamageSystem.GetVoiceType(ply)][zone]

      if !(location) then
         location = rp.DamageSystem.PainSounds[rp.DamageSystem.GetVoiceType(ply)]["generic"]
      end
      if zone == "head" then
         location = rp.DamageSystem.PainSounds["headshotsounds"]
      end
      local sound = table.Random(location)
      ply:EmitSound(sound, level)
   end
   ply.hurttimer = true
   timer.Simple(1, function() ply.hurttimer = false end)
end

function rp.DamageSystem.BreakLeg(ply, duration)
   if ply:GetNVar("Legbroken") ~= true then
      rp.DamageSystem.HurtSound(ply, "leg")
      ply.legshot = true
      ply:SetNVar("Legbroken", true, NETWORK_PROTOCOL_PUBLIC)
      ply:SprintDisable()
      timer.Simple(duration or 120,function()
          if IsValid(ply) then
            ply:SetNVar("Legbroken", false, NETWORK_PROTOCOL_PUBLIC)
          end
      end)
   end
end

hook.Add("EntityTakeDamage", "rp.DamageSystem.MeleeBlockDamage", function(ent, dmg)
    if not ent:IsPlayer() then return end
    if dmg:IsBulletDamage() then return end
    if rp.Zones:InsideSafeZone(ent:GetPos()) then return end


    local wep = ent:GetActiveWeapon()

    if wep and wep.OnBlock and wep.OnBlock == true then
        dmg:ScaleDamage(0)
    end
end)


local DSThinkCD = 0
hook.Add( "Think", "rp.DamageSystem.Think", function()
    if DSThinkCD < CurTime() then return end
    DSThinkCD = CurTime() + 3

    for k, pPlayer in pairs( player.GetAll() ) do
        if not IsValid( pPlayer ) or not pPlayer:Alive() then continue end

        if pPlayer:GetNVar("Bleeding") == true then
          if pPlayer.bloodLosing && pPlayer.bloodLosing ~= 20 then
            pPlayer.bloodLosing = pPlayer.bloodLosing + 1
            timer.Simple(math.Rand(0.1, 2), function()
              location = rp.DamageSystem.PainSounds[rp.DamageSystem.GetVoiceType(pPlayer)]["generic"]
              local sound = table.Random(location)
              pPlayer:EmitSound(sound, 75)
              pPlayer:SetHealth(pPlayer:Health() - 1)
              if pPlayer:Health() <= 0 then 
                  pPlayer:Kill()
              end
            end)
          else 
            pPlayer.bloodLosing = 0
            pPlayer:SetNVar("Bleeding", false)
          end
        end
    end
end)

hook.Add("GetFallDamage","rp.DamageSystem.FallDamage", function(ply, speed)
  local damage = speed / 10
  if (damage > ply:Health() / 2 and damage < ply:Health()) then
    rp.DamageSystem.BreakLeg(ply)
  end
  if (damage >ply:Health()) then
    ply:Kill()
  end
  return damage
end)

hook.Add("PlayerFootstep", "rp.DamageSystem.PlayerFootstep", function(ply)
    if ply:HasVest() or ply:HasBackpack() then
        ply:EmitSound("combataegis/suit_ct_" .. math.random(1, 5) .. ".wav")
        return true
    end
end)