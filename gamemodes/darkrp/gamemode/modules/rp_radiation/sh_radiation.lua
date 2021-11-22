local gasmasks = {"m10", "gasmask"}

function PLAYER:HasGasmask()
	if self.Cosmetics and table.HasValue(gasmasks, self.Cosmetics[COSM_SLOT_MASK]) then
		return true
	end
	return false
end

function PLAYER:GetRadiation()
	local rad = self:GetNVar('Radiation')
	return rad and not isbool(rad) and rad or 0
end