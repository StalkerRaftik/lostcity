zlm = zlm or {}
zlm.f = zlm.f or {}

zlm.Grass = {}

function zlm.f.Create_Grass(ID, _Model, Scale_min, Scale_max)
	local atable = {
		id = ID,
		model = _Model,
		s_min = Scale_min,
		s_max = Scale_max
	}

	util.PrecacheModel(_Model)
	table.insert(zlm.Grass, atable)
end
