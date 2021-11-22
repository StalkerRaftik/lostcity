ANIMS = {
  {ACT_GMOD_GESTURE_AGREE, 'Одобрить'},
  {ACT_GMOD_GESTURE_BECON, 'Подозвать'},
  {ACT_GMOD_GESTURE_BOW, 'Поклониться'},
  {ACT_GMOD_GESTURE_DISAGREE, 'Пригрозить пальцем'},
  {ACT_GMOD_TAUNT_SALUTE, 'Воинское приветствие'},
  {ACT_GMOD_GESTURE_WAVE, 'Помахать рукой'},
  {-1},
  {ACT_SIGNAL_FORWARD, 'Сигнал: вперед'},
  {ACT_SIGNAL_GROUP, 'Сигнал: группировка'},
  {ACT_SIGNAL_HALT, 'Сигнал: стоп'},
  {ACT_HL2MP_GESTURE_RANGE_ATTACK_FIST, 'Замахнуться рукой'},
  {ACT_GMOD_GESTURE_MELEE_SHOVE_1HAND, 'Махнуть перед собой'},
  {-1},
  {ACT_GMOD_TAUNT_LAUGH, 'Насмехаться', 6},
  {ACT_GMOD_TAUNT_CHEER, 'Радоваться', 2},
  {ACT_GMOD_TAUNT_PERSISTENCE, 'Устрашить', 3},
  {ACT_GMOD_TAUNT_DANCE, 'Танцевать', 8},
  {ACT_GMOD_TAUNT_ROBOT, 'Танец робота', 12},
  {ACT_GMOD_TAUNT_MUSCLE, 'Мускулы', 13},
}

if SERVER then 
  util.AddNetworkString("StartPlayerAnimation")
  util.AddNetworkString("DoAnimation")
  util.AddNetworkString("StartPlayerAnimFromServer")
end

local meta = FindMetaTable("Player")
function meta:DoAnimation(animID)
  self:AnimResetGestureSlot( GESTURE_SLOT_CUSTOM ) 
  self:DoCustomAnimEvent( PLAYERANIMEVENT_CUSTOM_GESTURE, animID )
  for k,v in pairs(ANIMS) do
    if ANIMS[k][1] == animID and ANIMS[k][3] ~= nil then
      self:Freeze(true)
      timer.Simple( ANIMS[k][3], function() self:Freeze(false) end )
    end
  end
end

net.Receive("StartPlayerAnimation", function(_,ply)

  local an = net.ReadFloat()

  if IsValid(ply) then
    ply:DoAnimation(an)
  end
end)

net.Receive("DoAnimation", function()
  local ply = net.ReadEntity()
  local an = net.ReadFloat()
  if IsValid(ply) then 
    ply:DoAnimation(an)
  end
end)

function PLAYER:IsSurrender() 
	return self:GetNVar('PlayerSurrender')
end