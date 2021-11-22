AddCSLuaFile 'cl_init.lua'
AddCSLuaFile 'sh_init.lua'
include 'sh_init.lua'

local t = {
		robot = 	ACT_GMOD_GESTURE_TAUNT_ZOMBIE,
		salute = 	ACT_GMOD_TAUNT_SALUTE,
		agree = 	ACT_GMOD_GESTURE_AGREE,
		becon = 	ACT_GMOD_GESTURE_BECON,
		bow = 	 	ACT_GMOD_GESTURE_BOW,
		cheer = 	ACT_GMOD_TAUNT_CHEER,
		dance = 	ACT_GMOD_TAUNT_DANCE,
		disagree = 	ACT_GMOD_GESTURE_DISAGREE,
		forward = 	ACT_SIGNAL_FORWARD,
		group = 	ACT_SIGNAL_GROUP,
		halt = 	 	ACT_SIGNAL_HALT,
		laugh = 	ACT_GMOD_TAUNT_LAUGH,
		muscle = 	ACT_GMOD_TAUNT_MUSCLE,
		pers = 	 	ACT_GMOD_TAUNT_PERSISTENCE,
		wave = 	 	ACT_GMOD_GESTURE_WAVE,
		zombie = 	ACT_GMOD_GESTURE_TAUNT_ZOMBIE,
		throw = 	ACT_GMOD_GESTURE_ITEM_THROW,
		place = 	ACT_GMOD_GESTURE_ITEM_PLACE,
		give = 	 	ACT_GMOD_GESTURE_ITEM_GIVE,
		drop = 	 	ACT_GMOD_GESTURE_ITEM_DROP,
		frenzy = 	ACT_GMOD_GESTURE_RANGE_FRENZY,
		attack = 	ACT_GMOD_GESTURE_RANGE_ZOMBIE_SPECIAL,
		melee = 	ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE,
		melee2 = 	ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2,
		poke = 		ACT_HL2MP_GESTURE_RANGE_ATTACK_SLAM,
}

concommand.Add('act2', function(pl, cmd, args)
	if t[args[1]] then
		pl:DoAnimationEvent(t[args[1]])
	end
end)
