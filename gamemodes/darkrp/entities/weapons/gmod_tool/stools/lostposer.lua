
-----------------------------------------------------

TOOL.Category = "Lost Config"
TOOL.Name = "Создать координаты"
TOOL.Command = nil
TOOL.ConfigName = ""

--
-- Remove a single entity
--
function TOOL:LeftClick( trace )
	if not rp.cfg.tpos then rp.cfg.tpos = {} end

	local pos = trace.HitPos
	table.insert(rp.cfg.tpos, pos)

	return true
end

--
-- Remove this entity and everything constrained
--
function TOOL:RightClick( trace )
	if not rp.cfg.tpos then rp.cfg.tpos = {} end

	local pos = trace.HitPos

	local count = 0
	for k,v in pairs(rp.cfg.tpos) do
		if math.abs(pos[1] - v[1]) > 20 then continue end
		if math.abs(pos[2] - v[2]) > 20 then continue end
		if math.abs(pos[3] - v[3]) > 20 then continue end

		table.remove( rp.cfg.tpos, k )
		count = count + 1
	end
	if count == 0 then return false end

	local ply = self:GetOwner()
	ply:ChatPrint("Удалено " .. count .. " точек спавна")
	return true

end

--
-- Reload removes all constraints on the targetted entity
--
function TOOL:Reload( trace )
	if not rp.cfg.tpos then rp.cfg.tpos = {} end


	local ply = self:GetOwner()
	ply:SendLua("print('-----------------------------------')")
	for k,v in pairs(rp.cfg.tpos) do
		local str = "Vector(" .. v[1] .. ", " .. v[2] .. ", " .. (v[3]+20) .. "),"
		ply:SendLua("print('"..str.."')")
	end
	ply:SendLua("print('-----------------------------------')")
	rp.cfg.tpos = {}
	return true
end
