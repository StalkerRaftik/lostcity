if SERVER then return end
zlm = zlm or {}
zlm.f = zlm.f or {}

if zlm_GrassSpots == nil then
	zlm_GrassSpots = {}
end

if zlm_GrassModels == nil then
	zlm_GrassModels = {}
end

if zlm_GrassModelCount == nil then
	zlm_GrassModelCount = 0
end

local zlm_LastThink = -1


net.Receive("zlm_GrassSpots_load", function(len)

	local dataLength = net.ReadUInt(16)
	local d_Decompressed = util.Decompress(net.ReadData(dataLength))

	if d_Decompressed == nil then return end

	local newGrassSpots = util.JSONToTable(d_Decompressed)

	if (zlm_GrassModels and table.Count(zlm_GrassModels) > 0) then
		for s, w in pairs(zlm_GrassModels) do
			if IsValid(w) then
				w:Remove()
			end
		end
	end

	zlm_GrassSpots = {}
	zlm_GrassModels = {}
	zlm_GrassModelCount = 0

	if newGrassSpots then
		table.CopyFromTo( newGrassSpots, zlm_GrassSpots )
	end
	zlm.f.debug("Grass Data Size: " .. len)
	zlm.f.debug("Grass Data Loaded!")
end)

net.Receive("zlm_GrassSpots_mowed", function(len)
	local mowedID = net.ReadInt(21)
	local grassData = zlm_GrassSpots[mowedID]

	if grassData and grassData.pos and grassData.mowed ~= nil then
		if zlm.f.InDistance(grassData.pos, LocalPlayer():GetPos(), GetConVar("zlm_cl_vfx_updatedistance"):GetFloat()) and grassData.mowed == false then
			grassData.mowed = true
			ParticleEffect("zlm_mowe", grassData.pos, Angle(0, 0, 0), NULL)
		end
	else
		print("[    Zeros LawnMower    ] " .. "Mowed Grass doesent exist in Client Table!")
	end
end)

net.Receive("zlm_GrassSpots_refresh", function(len)
	local grass_ID = net.ReadInt(21)

	if zlm_GrassSpots[grass_ID] then
		zlm_GrassSpots[grass_ID].mowed = false
	end
end)

hook.Add("Think", "zlm_Think_GrassUpdate", function()
	if zlm_LastThink < CurTime() then

		if zlm_GrassSpots and table.Count(zlm_GrassSpots) > 0 then

			if table.Count(zlm.config.Grass.RenderForJob) > 0 then

				if zlm.config.Grass.RenderForJob[team.GetName(LocalPlayer():Team())] then

					zlm.f.Update_GrassSpots()
				else

					for i = 1, table.Count(zlm_GrassSpots) do
						local val = zlm_GrassSpots[i]

						if val and IsValid(val.ClientProp) then
							zlm.f.DeleteGrass(val)
						end
					end
				end
			else
				zlm.f.Update_GrassSpots()
			end
		end

		zlm_LastThink = CurTime() + GetConVar("zlm_cl_vfx_updateinterval"):GetFloat()
	end
end)

function zlm.f.Update_GrassSpots()

	for i = 1, table.Count(zlm_GrassSpots) do
		local key = math.random(#zlm_GrassSpots)
		local val = zlm_GrassSpots[key]

		if val and val.pos and val.mowed ~= nil then

			if IsValid(val.ClientProp) and zlm_GrassModelCount > GetConVar("zlm_cl_vfx_modelcount"):GetInt() then
				zlm.f.DeleteGrass(val)
			end

			-- If we are close enough and the grass spot is not mowed then we populate the position with grass
			if zlm.f.InDistance(val.pos, LocalPlayer():GetPos(), GetConVar("zlm_cl_vfx_updatedistance"):GetFloat()) and val.mowed == false then

				if not IsValid(val.ClientProp) and zlm_GrassModelCount < GetConVar("zlm_cl_vfx_modelcount"):GetInt() then

					zlm.f.PopulatedGrass(val)
				end
			else

				if IsValid(val.ClientProp) then

					-- If we are to far away from this grass spot then we remove all of its client props
					zlm.f.DeleteGrass(val)
				end
			end
		end
	end
end

function zlm.f.PopulatedGrass(GrassSpot)
	-- Create the Grass Model
	local grass = zlm.f.SpawnClientModel_Grass(GrassSpot)
	if IsValid(grass) then
		table.insert(zlm_GrassModels, grass)
		GrassSpot.ClientProp = grass
		--zlm.f.debug("zlm.f.PopulatedGrass")
		zlm_GrassModelCount = math.Clamp(zlm_GrassModelCount + 1,0,1000)
	end
end

function zlm.f.SpawnClientModel_Grass(GrassSpot)
	--local grassData = zlm.Grass[math.random(#zlm.Grass)]
	local grassData

	for k, v in pairs(zlm.Grass) do
		if v.id == GrassSpot.id then
			grassData = v
			break
		end
	end
	if grassData == nil then
		return nil
	end
	local grass = ents.CreateClientProp(grassData.model)

	grass:SetPos(GrassSpot.pos)

	local ang = Angle(0, 0, 0)
	ang:RotateAroundAxis(Vector(0,0,1), math.random(0, 360))
	grass:SetAngles(ang)

	grass:Spawn()
	grass:Activate()
	grass:SetModelScale(math.Rand(grassData.s_min, grassData.s_max))

	return grass
end

function zlm.f.DeleteGrass(GrassSpot)
	if IsValid(GrassSpot.ClientProp) then
		GrassSpot.ClientProp:Remove()
		GrassSpot.ClientProp = nil
		--zlm.f.debug("zlm.f.DeleteGrass")
		zlm_GrassModelCount = math.Clamp(zlm_GrassModelCount - 1,0,1000)
	end
end
