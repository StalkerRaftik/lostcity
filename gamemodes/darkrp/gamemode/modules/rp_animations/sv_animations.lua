util.AddNetworkString('SurrenderAnim')
util.AddNetworkString('StopSurrenderAnim')


rp.Animations = rp.Animations or {}
rp.Animations.Surrender = rp.Animations.Surrender or {}
rp.Animations.HandCuffs = rp.Animations.HandCuffs or {}



local pelvis = "ValveBiped.Bip01_Pelvis"
local r_calf = "ValveBiped.Bip01_R_Calf"
local l_calf = "ValveBiped.Bip01_L_Calf"
local r_thigh = "ValveBiped.Bip01_R_Thigh"
local l_thigh = "ValveBiped.Bip01_L_Thigh"
local r_foot = "ValveBiped.Bip01_R_Foot"
local l_foot = "ValveBiped.Bip01_L_Foot"
local r_upperarm = "ValveBiped.Bip01_R_UpperArm"
local l_upperarm = "ValveBiped.Bip01_L_UpperArm"
local r_forearm = "ValveBiped.Bip01_R_ForeArm"
local l_forearm = "ValveBiped.Bip01_L_ForeArm"
local r_hand = "ValveBiped.Bip01_R_Hand"
local l_hand = "ValveBiped.Bip01_L_Hand"
local head = "ValveBiped.Bip01_Head1"

rp.Animations.Surrender.Bones = {
  [r_upperarm] = Angle( 90, 0, 90 ),
  [l_upperarm] =  Angle( -90, 0, -90 ),
  [r_forearm] = Angle( 0, -85, 0 ),
  [l_forearm] = Angle( 0, -75, 20 )
}


rp.Animations.HandCuffs.Bones = {
	["ValveBiped.Bip01_L_UpperArm"] = Angle(20, 8.8, 0),
	["ValveBiped.Bip01_L_Forearm"] = Angle(15, 0, 0),
	["ValveBiped.Bip01_L_Hand"] = Angle(0, 0, 75),
	["ValveBiped.Bip01_R_Forearm"] = Angle(-15, 0, 0),
	["ValveBiped.Bip01_R_Hand"] = Angle(0, 0, -75),
	["ValveBiped.Bip01_R_UpperArm"] = Angle(-20, 16.6, 0)
}
function rp.Animations.HandCuffs:SetupBones(eEnt)
	for k, v in pairs(self.Bones) do
		eEnt:ManipulateBoneAngles(eEnt:LookupBone(k), v)
	end
end

function rp.Animations.HandCuffs:ResetBones(eEnt)
	for k, v in pairs(self.Bones) do
		eEnt:ManipulateBoneAngles(eEnt:LookupBone(k), Angle(0, 0, 0))
	end
end

function rp.Animations:ResetAnims(eEnt)
  if not IsValid( eEnt ) then return end

  if eEnt:GetBoneCount() then
    for i = 1, eEnt:GetBoneCount() -1 do
      local bone = eEnt:LookupBone( eEnt:GetBoneName(i) )
      if bone then
        eEnt:ManipulateBoneAngles( bone, Angle(0, 0, 0) )
      end
    end
  end

end

function rp.Animations.Surrender:SetupBones(eEnt)
  for k,v in pairs(self.Bones) do
    local boneid = eEnt:LookupBone(k)
    if boneid then
      eEnt:ManipulateBonePosition(boneid,Vector(0,0,0))
      eEnt:ManipulateBoneAngles(boneid,v)
    end
  end
end

function rp.Animations.Surrender:ResetBones(eEnt)
  for k, v in pairs(self.Bones) do
    eEnt:ManipulateBoneAngles(eEnt:LookupBone(k), Angle(0, 0, 0))
  end
end

hook.Add("ShowHelp", "ShowHelp.Surrender", function(ply)
  if IsValid(ply) and ply:Alive() then
    if ply:GetNVar('PlayerSurrender') == 1 then
      ply:SetNVar('PlayerSurrender',0,NETWORK_PROTOCOL_PRIVATE)
      ply:SelectWeapon("weapon_rphands")
      rp.Animations.Surrender:ResetBones(ply)
      ply:SetWalkSpeed(rp.cfg.WalkSpeed)
      ply:SetRunSpeed(rp.cfg.RunSpeed)
    else
      ply:SetNVar('PlayerSurrender',1,NETWORK_PROTOCOL_PRIVATE)
      ply:SelectWeapon("weapon_rphands")
      rp.Animations.Surrender:SetupBones(ply)
      ply:SetWalkSpeed(rp.cfg.WalkSpeed/2.5)
      ply:SetRunSpeed(rp.cfg.RunSpeed/2.5)  
    end
  end
end)

hook.Add("PlayerSwitchWeapon", "rp.SurrenderWeaponSwitch", function(ply, oldWeapon, newWeapon)
  if ply:GetNVar('PlayerSurrender') == 1 then
    if newWeapon:GetClass() == "weapon_rphands" or newWeapon:GetClass() == "weapon_rphands" then return false else return true end
  end
end)

hook.Add( "PlayerSpawn", "rp.ResetAnimsOnSpawn", function(ply)
  if IsValid(ply) then
    ply:SetNVar('PlayerSurrender',0,NETWORK_PROTOCOL_PRIVATE)
    ply:SetWalkSpeed(rp.cfg.WalkSpeed)
    ply:SetRunSpeed(rp.cfg.RunSpeed)
  end
end)

hook.Add( "PlayerInitialSpawn", "FullLoadSetup", function( ply )
    ply:SetNVar('PlayerSurrender',0,NETWORK_PROTOCOL_PRIVATE)
    ply:SetWalkSpeed(rp.cfg.WalkSpeed)
    ply:SetRunSpeed(rp.cfg.RunSpeed)
end )

hook.Add( "PlayerDeath", "rp.ResetAnimsOnSpawndeath", function(ply)
  if IsValid(ply) then
    ply:SetNVar('PlayerSurrender',0,NETWORK_PROTOCOL_PRIVATE)
    rp.Animations:ResetAnims(ply)
    ply:SetWalkSpeed(rp.cfg.WalkSpeed)
    ply:SetRunSpeed(rp.cfg.RunSpeed)
  end
end)

