COSM_SLOT_HAT = 1
COSM_SLOT_EYES = 2
COSM_SLOT_MOUTH = 3
COSM_SLOT_MASK = 4
COSM_SLOT_RHAND = 5
COSM_SLOT_LHAND = 6
COSM_SLOT_MISC = 7
COSM_SLOT_MISC2 = 8
COSM_SLOT_PET = 9
COSM_SLOT_MISC3 = 10
COSM_SLOT_MISC4 = 11

Cosmetics = Cosmetics or {}
Cosmetics.Slots = {
	"Голова",
	"Глаза",
	"Рот",
	"Маски",
	"Основное оружие",
	"Дополнительное оружие",
	"Другое",
	"Другое 2",
	"Холодное оружие",
	"Доп. Инструмент",
	"Доп. Инструмент",
}

Cosmetics.Def = {
	COSM_SLOT_HAT,
	COSM_SLOT_EYES,
	COSM_SLOT_MOUTH,
	COSM_SLOT_MASK,
	COSM_SLOT_RHAND,
	COSM_SLOT_LHAND,
	COSM_SLOT_MISC,
	COSM_SLOT_MISC2,
	COSM_SLOT_PET,
	COSM_SLOT_MISC3,
	COSM_SLOT_MISC4,
}

Cosmetics.Active = Cosmetics.Active or {}

function PLAYER:HasEquippedCosmetic(cType)

	if not self.Cosmetics then return end
	
	if not Cosmetics.Items[cType] then return end
	
	for _, v in pairs(Cosmetics.Def) do
		if self.Cosmetics[v] and self.Cosmetics[v] == cType then return true end
	end
	
	return false

end

