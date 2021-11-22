rp.DamageSystem = rp.DamageSystem or {}

rp.DamageSystem.PlayerModels =  {}
rp.DamageSystem.PlayerModels["female"] = {
"models/player/group01/female_01.mdl",
"models/player/group01/female_02.mdl",
"models/player/group01/female_03.mdl",
"models/player/group01/female_04.mdl",
"models/player/group01/female_05.mdl",
"models/player/group01/female_06.mdl",
"models/player/group01/female_07.mdl",
"models/player/group03/female_01.mdl",
"models/player/group03/female_02.mdl",
"models/player/group03/female_03.mdl",
"models/player/group03/female_04.mdl",
"models/player/group03/female_05.mdl",
"models/player/group03/female_06.mdl",
"models/player/group03/female_07.mdl",
"models/player/alyx.mdl",
"models/player/mossman.mdl",
"models/Humans/alyx.mdl",
"models/Humans/mossman.mdl",
"models/mossman.mdl",
"models/alyx.mdl",
"models/Humans/Group01/Female_01.mdl",
"models/Humans/Group01/Female_02.mdl",
"models/Humans/Group01/Female_03.mdl",
"models/Humans/Group01/Female_04.mdl",
"models/Humans/Group01/Female_06.mdl",
"models/Humans/Group01/Female_07.mdl",

"models/Humans/Group02/Female_01.mdl",
"models/Humans/Group02/Female_02.mdl",
"models/Humans/Group02/Female_03.mdl",
"models/Humans/Group02/Female_04.mdl",
"models/Humans/Group02/Female_06.mdl",
"models/Humans/Group02/Female_07.mdl",

"models/Humans/Group03/Female_01.mdl",
"models/Humans/Group03/Female_02.mdl",
"models/Humans/Group03/Female_03.mdl",
"models/Humans/Group03/Female_04.mdl",
"models/Humans/Group03/Female_06.mdl",
"models/Humans/Group03/Female_07.mdl",

"models/Humans/Group03m/Female_01.mdl",
"models/Humans/Group03m/Female_02.mdl",
"models/Humans/Group03m/Female_03.mdl",
"models/Humans/Group03m/Female_04.mdl",
"models/Humans/Group03m/Female_06.mdl",
"models/Humans/Group03m/Female_07.mdl",
 }

rp.DamageSystem.PlayerModels["male"] = {
"models/player/classic.mdl",
"models/player/Charple01.mdl",
"models/player/corpse1.mdl",
"models/Barney.mdl",
"models/breen.mdl",
"models/Eli.mdl",
"models/Kleiner.mdl",
"models/monk.mdl",
"models/odessa.mdl",
"models/Humans/Group01/Male_01.mdl",
"models/Humans/Group01/male_02.mdl",
"models/Humans/Group01/male_03.mdl",
"models/Humans/Group01/Male_04.mdl",
"models/Humans/Group01/Male_05.mdl",
"models/Humans/Group01/male_06.mdl",
"models/Humans/Group01/male_07.mdl",
"models/Humans/Group01/male_08.mdl",
"models/Humans/Group01/male_09.mdl",

"models/Humans/Group02/Male_01.mdl",
"models/Humans/Group02/male_02.mdl",
"models/Humans/Group02/male_03.mdl",
"models/Humans/Group02/Male_04.mdl",
"models/Humans/Group02/Male_05.mdl",
"models/Humans/Group02/male_06.mdl",
"models/Humans/Group02/male_07.mdl",
"models/Humans/Group02/male_08.mdl",
"models/Humans/Group02/male_09.mdl",

"models/Humans/Group03/Male_01.mdl",
"models/Humans/Group03/male_02.mdl",
"models/Humans/Group03/male_03.mdl",
"models/Humans/Group03/Male_04.mdl",
"models/Humans/Group03/Male_05.mdl",
"models/Humans/Group03/male_06.mdl",
"models/Humans/Group03/male_07.mdl",
"models/Humans/Group03/male_08.mdl",
"models/Humans/Group03/male_09.mdl",

"models/Humans/Group03m/Male_01.mdl",
"models/Humans/Group03m/male_02.mdl",
"models/Humans/Group03m/male_03.mdl",
"models/Humans/Group03m/Male_04.mdl",
"models/Humans/Group03m/Male_05.mdl",
"models/Humans/Group03m/male_06.mdl",
"models/Humans/Group03m/male_07.mdl",
"models/Humans/Group03m/male_08.mdl",
"models/Humans/Group03m/male_09.mdl"
}

rp.DamageSystem.PlayerModels["combine"] = {
"models/player/police.mdl",
"models/player/combine_soldier.mdl",
"models/combine_super_soldier.mdl",
"models/player/combine_soldier_prisonguard.mdl",
"models/combine_soldier.mdl",
"models/combine_soldier_prisonguard.mdl",
"models/Police.mdl"
}

rp.DamageSystem.PlayerModels["zombie"] = {
"models/zombie/classic.mdl",
"models/zombie/fast.mdl",
"models/zombie/fast_torso.mdl",
"models/zombie/poison.mdl",
"models/zombie/zombie_poison.mdl",
"models/player/classic.mdl",
"models/player/zombiefast.mdl",
"models/player/zombie_soldier.mdl",
"models/player/Charple01.mdl",
"models/player/corpse1.mdl",
}

rp.DamageSystem.PainSounds = {}
rp.DamageSystem.PainSounds['headshotsounds'] = {
  Sound("physics/flesh/flesh_squishy_impact_hard1.wav"),
  Sound("physics/flesh/flesh_squishy_impact_hard2.wav"),
  Sound("physics/flesh/flesh_squishy_impact_hard3.wav"),
  Sound("physics/flesh/flesh_squishy_impact_hard4.wav")}

rp.DamageSystem.PainSounds['male'] = {
  ['generic'] = {Sound("vo/npc/male01/pain01.wav"),
      Sound("vo/npc/male01/pain02.wav"),
      Sound("vo/npc/male01/pain03.wav"),
      Sound("vo/npc/male01/pain04.wav"),
      Sound("vo/npc/male01/pain05.wav"),
      Sound("vo/npc/male01/pain06.wav"),
      Sound("vo/npc/male01/pain07.wav"),
      Sound("vo/npc/male01/pain08.wav"),
      Sound("vo/npc/male01/pain09.wav"),
      Sound("vo/ravenholm/monk_pain01"),
      Sound("vo/ravenholm/monk_pain02"),
      Sound("vo/ravenholm/monk_pain03"),
      Sound("vo/ravenholm/monk_pain04"),
      Sound("vo/ravenholm/monk_pain05"),
      Sound("vo/ravenholm/monk_pain06"),
      Sound("vo/ravenholm/monk_pain07"),
      Sound("vo/ravenholm/monk_pain08"),
      Sound("vo/ravenholm/monk_pain09"),
      Sound("vo/ravenholm/monk_pain10"),
      Sound("vo/ravenholm/monk_pain12"),
      Sound("vo/npc/male01/moan01.wav"),
      Sound("vo/npc/male01/moan02.wav"),
      Sound("vo/npc/male01/moan03.wav"),
      Sound("vo/npc/male01/moan04.wav"),
      Sound("vo/npc/male01/moan05.wav"),},
  ['knockout'] ={
    -- Sound("vo/npc/male01/no02.wav"),
    -- Sound("vo/npc/male01/no01.wav"),
    -- Sound("vo/npc/male01/no02.wav"),
    Sound("vo/npc/male01/moan03.wav"),
    Sound("vo/npc/male01/moan04.wav"),
    Sound("vo/npc/male01/moan05.wav")},        
    -- Sound("vo/npc/male01/help01.wav")},    
  ['burn'] ={
    Sound("player/pl_burnpain1.wav"),
    Sound("player/pl_burnpain2.wav"),
    Sound("player/pl_burnpain3.wav")},
  ['arm'] = {Sound("vo/npc/male01/myarm01.wav"),
             Sound("vo/npc/male01/myarm02.wav")},
  ['leg'] = {Sound("vo/npc/male01/myleg01.wav"),
             Sound("vo/npc/male01/myleg02.wav")},
  ['gut'] = {Sound("vo/npc/male01/mygut02.wav"),
             Sound("vo/npc/male01/hitingut01.wav"),
             Sound("vo/npc/male01/hitingut02.wav")}
  }
rp.DamageSystem.PainSounds['female'] = {
  ['generic'] =
    {Sound("vo/npc/female01/pain01.wav"),
    Sound("vo/npc/female01/pain02.wav"),
    Sound("vo/npc/female01/pain03.wav"),
    Sound("vo/npc/female01/pain04.wav"),
    Sound("vo/npc/female01/pain05.wav"),
    Sound("vo/npc/female01/pain06.wav"),
    Sound("vo/npc/female01/pain07.wav"),
    Sound("vo/npc/female01/pain08.wav"),
    Sound("vo/npc/female01/pain09.wav"),
    Sound("vo/npc/female01/moan01.wav"),
    Sound("vo/npc/female01/moan02.wav"),
    Sound("vo/npc/female01/moan03.wav"),
    Sound("vo/npc/female01/moan04.wav"),
    Sound("vo/npc/female01/moan05.wav")},
  ['knockout'] ={
    -- Sound("vo/npc/female01/no02.wav"),
    -- Sound("vo/npc/female01/no01.wav"),
    -- Sound("vo/npc/female01/help01.wav"),
    Sound("vo/npc/female01/moan04.wav"),
    Sound("vo/npc/female01/uhoh.wav"),
    Sound("vo/npc/female01/ohno.wav"),        
    Sound("vo/npc/female01/moan03.wav")},      
  ['arm'] = {Sound("vo/npc/female01/myarm01.wav"),
             Sound("vo/npc/female01/myarm02.wav")},
  ['leg'] = {Sound("vo/npc/female01/myleg01.wav"),
             Sound("vo/npc/female01/myleg02.wav")},
  ['gut'] = {Sound("vo/npc/female01/mygut02.wav"),
             Sound("vo/npc/female01/hitingut01.wav"),
             Sound("vo/npc/female01/hitingut02.wav")}
}


rp.DamageSystem.PainSounds['zombie'] = {}
rp.DamageSystem.PainSounds['zombie']['generic'] = {Sound("npc/zombie/pain1"),
  Sound("npc/zombie/pain2"),
  Sound("npc/zombie/pain3"),
  Sound("npc/zombie/pain4"),
  Sound("npc/zombie/pain5"),
  Sound("npc/zombie/pain6"),
  Sound("npc/zombie/die1"),
  Sound("npc/zombie/die2"),
  Sound("npc/zombie/die3"),
  Sound("npc/zombie_poison/pz_pain1"),
  Sound("npc/zombie_poison/pz_pain2"),
  Sound("npc/zombie_poison/pz_pain3"),
  Sound("npc/zombie_poison/pz_die3")
}

rp.DamageSystem.PainSounds['combine'] = {}
rp.DamageSystem.PainSounds['combine']['generic'] =
{
  Sound("npc/combine_soldier/pain1.wav"),
  Sound("npc/combine_soldier/pain2.wav"),
  Sound("npc/combine_soldier/pain3.wav"),
  Sound("npc/metropolice/pain1.wav"),
  Sound("npc/metropolice/pain2.wav"),
  Sound("npc/metropolice/pain3.wav"),
  Sound("npc/metropolice/pain4.wav")
}




function rp.DamageSystem.GetVoiceType(ply)
  --  for k, v in pairs(rp.DamageSystem.PlayerModels) do
  --     if table.HasValue(v, string.lower(ply:GetModel()) ) then
  --        --Return the name of the player group if it's found in any of the tables
  --        return k
  --     end
  --  end
    if (ply:GetNVar('Gender') == 1) then
      return "male"
    else
      return "female"
    end
    return "male"
end

function rp.DamageSystem.Get_Bodygroup(ply)
   for i = 0, 10 do --Is there a better way to do this?
      if ply:GetBodygroup(i) == 1 then
         return i
      end
   end
end

local Helmets = {"firehelmet", "helmetmich", "assaulthelmet", "motohelmet", "michhelmet", "ssh68" }
local Vests = {"policevest", "tacticalvest", "ballisticvest", "smershvest", "pressvest", "armourvest"}
local Backpacks = {}

function PLAYER:HasHelmet()
	if self.Cosmetics and table.HasValue(Helmets, self.Cosmetics[COSM_SLOT_HAT]) then
		return true
	end
	return false
end

function PLAYER:HasVest()
	if self.Cosmetics and table.HasValue(Vests, self.Cosmetics[COSM_SLOT_MISC]) then
		return true
	end
	return false
end

function PLAYER:HasBackpack()
  if self.Cosmetics and table.HasValue(Backpacks, self.Cosmetics[COSM_SLOT_MISC2]) then
    return true
  end
  return false
end

if CLIENT then
	-- function KnockedoutPlayerView( ply, origin, angles, fov )
  --       local ragdoll = ply:GetNetworkedEntity("RagdollPlayer")
  --       if( !ragdoll || ragdoll == NULL || !ragdoll:IsValid() || !ply:GetNWBool("Knockedout") || GetViewEntity() != ply ) then return end
       
  --       local eyes = ragdoll:GetAttachment( ragdoll:LookupAttachment( "eyes" ) )
        
  --       local view = {
  --           origin = eyes.Pos,
  --           angles = eyes.Ang,
	-- 		fov = 90, 
  --       }
        
  --       return view
     
	-- end
	-- hook.Add( "CalcView", "KnockedoutPlayerView", KnockedoutPlayerView )
end