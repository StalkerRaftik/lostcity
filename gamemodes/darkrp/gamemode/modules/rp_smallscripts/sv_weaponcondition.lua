rp.cfg.ConditionSpend = rp.cfg.ConditionSpend or {}

hook.Add( "TFA_PostPrimaryAttack", "ChangeWeapCondition", function(wep)
	local ply = wep:GetOwner()
	local class = wep:GetClass()
	local key
	if ply.Cosmetics[5] and ply.Cosmetics[5].class == class then key = 5
	elseif ply.Cosmetics[6] and ply.Cosmetics[6].class == class then key = 6 end
	local conidionwaste
	if key then
		conditionwaste = rp.cfg.ConditionSpend[wep:GetClass()] or math.sqrt(wep:GetPrimaryClipSizeForReload(true))/wep:GetPrimaryClipSizeForReload(true)
		if not ply.Cosmetics[key].health then ply.Cosmetics[key].health = 100 end
		ply.Cosmetics[key].health = ply.Cosmetics[key].health - conditionwaste
		if ply.Cosmetics[key].health <= 0 then
			ply:StripWeapon(ply.Cosmetics[key].class)
			ply.Cosmetics[key] = nil
			DarkRP.notify(ply, 1, 4, "Ваше оружие пришло в негодность")
		end

		ply.Cosmetics = ply.CosmeticsData
	    ply:NetVars("Cosmetics", ply.Cosmetics, true)
	    ply:SavePlayerData("cosmetics", ply.Cosmetics)
	end
	
end )