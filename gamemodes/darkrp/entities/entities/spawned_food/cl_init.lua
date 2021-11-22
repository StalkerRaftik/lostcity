include("shared.lua")

local MovementTable = {
	"left",
	"right",
	"forward",
	"back"
}

net.Receive("DoAlcholEffect", function()
	hook.Add("RenderScreenspaceEffects", "DrawAlcEffect", function()
	    DrawBloom( 2, 1.1, 9, 9, 1, 1, 1.1, 1, 1 )
	    DrawSharpen( 1.2, 10.2 )
	    DrawToyTown( 4, ScrH())
	    local ToMove = math.random(0,2000)
	    if ToMove > 1990 then
	    	local CurrentMove = ToMove
	    	LocalPlayer():ConCommand("+"..table.Random(MovementTable))
	    	timer.Simple(0.2, function() for k, v in pairs(MovementTable) do LocalPlayer():ConCommand("-"..v) end end)
	    end
	end)
	timer.Simple(120, function()
		hook.Remove("RenderScreenspaceEffects", "DrawAlcEffect")
	end)
end)

function ENT:Draw()
	self:DrawModel()
end

