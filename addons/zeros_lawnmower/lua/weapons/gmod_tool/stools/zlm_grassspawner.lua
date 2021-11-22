AddCSLuaFile()
include("zlawnmower/sh/zlm_config.lua")
AddCSLuaFile("zlawnmower/sh/zlm_config.lua")

TOOL.Category = "Zeros LawnMower"
TOOL.Name = "#GrassSpawner"
TOOL.Command = nil
TOOL.ClientConVar["amount"] = 25
TOOL.ClientConVar["radius"] = 200
TOOL.ClientConVar["model"] = "models/zerochain/props_lawnmower/zlm_grasscluster01.mdl"
TOOL.ClientConVar["random"] = 1

if (CLIENT) then
	language.Add("tool.zlm_grassspawner.name", "Zeros LawnMower - Grass Spawner")
	language.Add("tool.zlm_grassspawner.desc", "Creates a Grass Spot.")
	language.Add("tool.zlm_grassspawner.0", "LeftClick: Creates a Grass Spot.")
end

// Creates the Prop list for selection
local zero = { grass_rx = 0, grass_ry = 0, grass_rz = 0 }
for k, v in pairs(zlm.Grass) do
	list.Set( "GrassModels", v.model, zero )
end


function TOOL:CalculateGrassPositions(HitPos)

	local GrassPositions = {}

	local g_rad = math.Clamp(self:GetClientNumber("radius", 100),10,500)
	local grassCount = self:GetClientNumber("amount", 100)

	local function pointInCircle(r)
		r = math.sqrt(math.random()) * r
		local theta = math.random() * 2 * math.pi
		local x = HitPos.x + r * math.cos(theta)
		local y = HitPos.y + r * math.sin(theta)
		local aPos = Vector(1, 0, 0) * x + Vector(0, 1, 0) * y
		local fPos = Vector(aPos.x,aPos.y,HitPos.z)

		table.insert(GrassPositions, fPos)
	end

	for i = 1, grassCount do
		pointInCircle(g_rad)
	end

	return GrassPositions
end

function TOOL:LeftClick(trace)
	local trEnt = trace.Entity
	if (trEnt:IsPlayer()) then return false end
	if (CLIENT) then return end

	if (trEnt:GetClass() == "worldspawn") then

		local GrassPositions = self:CalculateGrassPositions(trace.HitPos)

		//Get the grass id from the selected model and send it with the Add_GrassSpot function
		local random = tonumber(self:GetClientInfo( "random" ))
		local id
		local model = "models/zerochain/props_lawnmower/zlm_grasscluster01.mdl"

		if self:GetClientInfo( "model" ) then
			model = self:GetClientInfo( "model" )
		end

		if random == 0 then

			for k, v in pairs(zlm.Grass) do
				if v.model == model then
					id = v.id
					break
				end
			end

			if id == nil then
				return true
			end

			zlm.f.debug("Selected ID: " .. id)
		end

		local g_rad = math.Clamp(self:GetClientNumber("radius", 100),10,500)

		for k, v in pairs(GrassPositions) do
			//debugoverlay.Sphere( v + Vector(0,0,g_rad), 5, 1, Color( 255, 0, 0 ),true )
			//debugoverlay.Sphere( v - Vector(0,0,g_rad), 5, 1, Color( 0, 255, 0 ),true )
			local tr = util.TraceLine( {
				start = v + Vector(0,0,g_rad),
				endpos = v - Vector(0,0,g_rad),
				filter = function( ent ) if ( ent:GetClass() == "worldspawn" ) then return true end end
			} )

			if random == 1 then
				id = zlm.Grass[math.random(#zlm.Grass)].id
			end
			zlm.f.Add_GrassSpot(tr.HitPos,id)
		end

		zlm.f.Send_GrassSpots_ToClient(self:GetOwner())

		return true
	else
		return false
	end
end

function TOOL:RightClick(trace)
	if (trace.Entity:IsPlayer()) then return false end
	if (CLIENT) then return end

	zlm.f.Remove_GrassSpot(trace.HitPos,self:GetClientNumber("radius", 100))

	zlm.f.Send_GrassSpots_ToClient(self:GetOwner())
end

function TOOL:Deploy()
end

function TOOL:Holster()
end

function TOOL.BuildCPanel(CPanel)
	CPanel:AddControl("Header", {
		Text = "#tool.zlm_grassspawner.name",
		Description = "#tool.zlm_grassspawner.desc"
	})

	CPanel:AddControl("label", {
		Text = "-------------------------------------------------------------------"
	})

	CPanel:NumSlider("Grass Amount", "zlm_grassspawner_amount", 3, 150, 0)

	CPanel:AddControl("label", {
		Text = "-------------------------------------------------------------------"
	})

	CPanel:NumSlider("Grass Radius", "zlm_grassspawner_radius", 20, 500, 0)

	CPanel:AddControl("label", {
		Text = "-------------------------------------------------------------------"
	})
	CPanel:AddControl("label", {
		Text = "Saves all the Grass Spots that are currently on the Map"
	})

	CPanel:Button("Save Grass Spots", "zlm_save_grassspots")

	CPanel:AddControl("label", {
		Text = "-------------------------------------------------------------------"
	})
	CPanel:AddControl("label", {
		Text = "Removes all the Grass Spots that are currently on the Map"
	})

	CPanel:Button("Remove all Grass Spots", "zlm_remove_grassspots")

	CPanel:AddControl("label", {
		Text = "-------------------------------------------------------------------"
	})

	CPanel:CheckBox("Random", "zlm_grassspawner_random")

	CPanel:AddControl( "PropSelect", { Label = "Grass Types", ConVar = "zlm_grassspawner_model", Height = 0, Models = list.Get( "GrassModels" ) } )

end



if CLIENT then
	hook.Add( "PostDrawTranslucentRenderables", "zlm_PostDrawTranslucentRenderables_grassspawner", function()

		if zlm.f.ToolGun_HasToolActive() then

			local tr = LocalPlayer():GetEyeTrace()
			local tool = LocalPlayer():GetTool()

			render.SetColorMaterial()
			render.DrawWireframeSphere( tr.HitPos, tool:GetClientNumber("radius", 100), 12,12, zlm.default_colors["white01"], false )

		end

	end )
end
