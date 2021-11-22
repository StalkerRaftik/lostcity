local canseezombies = false
local interval = 0
local infected = {}

hook.Add( "PreDrawHalos", "ZombieHolos", function()
	if canseezombies then
		if interval <= CurTime() then
			table.Empty(infected)
			local entities = ents.FindByClass("zombification_entity") or {}
			for k,v in pairs(entities) do
				table.insert(infected, v:GetNWEntity("Infected"))
		    end
			interval = CurTime() + 1
		end
	    halo.Add( infected, Color( 255, 0, 0 ), 2, 2, 2 )
	end
end )

local function SetStatus(ply)
	if ply:IsAdmin() then
		canseezombies = !canseezombies
	end
end

concommand.Add( "CanSeeZombies", SetStatus)