function PLAYER:GetLevel()
  return self:GetNVar('Level') or 0
end

function PLAYER:GetExperience()
  return self:GetNVar('Experience') or 0
end

function PLAYER:LevelToExperience(intLevel)
  return ((intLevel^1.4)*30+104)
end

function PLAYER:GetNeedExperience()
  return self:LevelToExperience(self:GetLevel()+1)
end

function PLAYER:HasLevel(num)
  return (self:GetLevel() >= num)
end

LVL_MSG_ENUM = {
  NONE = 1,
  PLAYING = 2,
  NPC = 3,
  PLAYER = 4,
  CRAFT = 5,
  SPECIALNPC = 6,
}

lvlEnumsDef = {
	[LVL_MSG_ENUM.NONE] = "",
	[LVL_MSG_ENUM.PLAYING] = " за игру на сервере",
	[LVL_MSG_ENUM.NPC] = " за убийство зомби",
  [LVL_MSG_ENUM.SPECIALNPC] = " за убийство особого зомби",
	[LVL_MSG_ENUM.PLAYER] = " за убийство игрока",
  [LVL_MSG_ENUM.CRAFT] = " за ремесленничество",
}