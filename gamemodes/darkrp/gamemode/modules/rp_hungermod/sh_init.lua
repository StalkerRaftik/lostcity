local math_round 	= math.Round
local math_max 	= math.max
local CurTime 		= CurTime

rp.Foods = {}
rp.FoodsIcons = {}
function rp.AddFoodItem(name, mdl, amount, weight, class, thirst, icon, customFunc)
	rp.Foods[#rp.Foods + 1] = {name = name, model = mdl, amount = amount or 0, weight = weight or 1, class = class, thirst = thirst or 0, icon = icon or "samprp/moreicons/food_meal2.png", customFunc = customFunc or function() end}
 	rp.FoodsIcons[mdl] = {icon = icon or "samprp/moreicons/food_meal2.png"}
end

function PLAYER:GetHunger()
	return self:Alive() and self:GetNVar('Energy') or 100
end

function PLAYER:GetThirst()
	return self:Alive() and self:GetNVar('Thirst') or 100
end

nw.Register('Energy', {
	Read 	= function()
		return net.ReadUInt(32)
	end,
	Write 	= function(v)
		return net.WriteUInt(v, 32)
	end,
	LocalVar = true
})

function RegisterFood()
	for class,tab in pairs(rp.Foods) do
		local ENT = {}
		ENT.Base = "spawned_food"
		ENT.Type = "anim"
		ENT.PrintName = tab.name
		ENT.WorldModel = tab.model
		ENT.Model = tab.model

		ENT.Category = "Еда"
		ENT.Spawnable = true
		ENT.id = class

		if SERVER then
			function ENT:Initialize()
				self:SetModel( self.WorldModel )
				self:PhysicsInit(SOLID_VPHYSICS)
				self:SetMoveType(MOVETYPE_VPHYSICS)
				self:SetSolid(SOLID_VPHYSICS)
				self:SetUseType(SIMPLE_USE)
				local phys = self:GetPhysicsObject()
				if phys then phys:Wake() end
				self:SetFoodName(tab.model)
			end
		end

		rp.AddEntity(tab.name, {
		    ent = "food_"..class,
		    model = tab.model,
		    price = 0,
		    max = 1,
		    cmd = "",
		    weight = tab.weight,
		})

		scripted_ents.Register( ENT, "food_"..class )
	end
	
end