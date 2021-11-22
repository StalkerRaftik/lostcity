zlm = zlm or {}
zlm.f = zlm.f or {}


-- List of all the zlm Entities on the server
if zlm.EntList == nil then
	zlm.EntList = {}
end

function zlm.f.EntList_Add(ent)
	table.insert(zlm.EntList, ent)
end

if SERVER then


	concommand.Add("zlm_debug_EntList", function(ply, cmd, args)
		if IsValid(ply) and zlm.f.IsAdmin(ply) then
			PrintTable(zlm.EntList)
		end
	end)
end
