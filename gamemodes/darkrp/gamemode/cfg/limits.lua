rp.cfg.Limits = {
	['dynamite']	= 0,
	['hoverballs']	= 0,
	['turrets']		= 0,
	['spawners']	= 0,
	['emitters']	= 4,
	['effects']		= 0,
	['buttons']		= 4,
	['ragdolls']	= 0,
	['npcs']		= 0,
	['lamps']		= 1,
	['balloons']	= 1,
	['lights']		= 4,
	['props']		= 15,
	['vehicles']	= 0,
	['sents']		= 25,
	['keypads']		= 5,
	['textscreens'] = 3
}

function rp.GetLimit(name)
	return rp.cfg.Limits[name] or 0
end

function rp.SetLimit(name, limit)
	rp.cfg.Limits[name] = limit
end