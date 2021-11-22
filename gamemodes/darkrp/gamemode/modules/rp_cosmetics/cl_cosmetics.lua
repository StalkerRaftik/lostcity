function PLAYER:BuildCosmetics(ent)
	local toApply = IsValid(ent) and ent or self

	if (istable(toApply._cModels)) then
		for k, v in pairs(toApply._cModels or {}) do
			if (isentity(v)) then
				v:Remove()
			end
		end

		toApply._cModels = nil
	end

	toApply._cModels = {}

	for k, v in pairs(self.Cosmetics or {}) do
		local data = nil
		data = Cosmetics.Items[v]
		if data then
			data.index = k
		end
		

		if not data then continue end
		local c = ClientsideModel(data.model, RENDERGROUP_TRANSLUCENT)
		c:SetParent(toApply)
		c.BindData = data

		if (data.scale) then
			c:SetModelScale(data.scale, 0)
		end

		if (data.skin) then
			c:SetSkin(data.skin)
		end

		c.id = k
		c:SetNoDraw(true)
		table.insert(toApply._cModels, c)
	end
end

-- function PLAYER:BuildCharCosmetics(datacosm)
-- 	local toApply = IsValid(ent) and ent or self
-- 	if (istable(toApply._cModels)) then
-- 		for k, v in pairs(toApply._cModels or {}) do
-- 			if (isentity(v)) then
-- 				v:Remove()
-- 			end
-- 		end

-- 		toApply._cModels = nil
-- 	end

-- 	toApply._cModels = {}

-- 	for k, v in pairs(datacosm or {}) do
-- 		local data = nil
-- 		data = Cosmetics.Items[v]
-- 		data.index = k
		

-- 		if not data then continue end
-- 		local c = ClientsideModel(data.model, RENDERGROUP_TRANSLUCENT)
-- 		c:SetParent(toApply)
-- 		c.BindData = data

-- 		if (data.scale) then
-- 			c:SetModelScale(data.scale, 0)
-- 		end

-- 		if (data.skin) then
-- 			c:SetSkin(data.skin)
-- 		end

-- 		c.id = k
-- 		c:SetNoDraw(true)
-- 		table.insert(toApply._cModels, c)
-- 	end
-- end

local function drawCosmetics(ply, ent)	
    if (IsValid(ply) and ply._cModels) then
		if istable(ply._cModels) then
			for k, v in pairs(ply._cModels) do
				
				local bone = (IsValid(ent) and ent or ply):LookupBone(v.BindData.bone or "ValveBiped.Bip01_Head1")
				
                if v.BindData.slot and (v.BindData.slot == COSM_SLOT_RHAND) or (v.BindData.slot == COSM_SLOT_LHAND) or (v.BindData.slot == COSM_SLOT_PET) then
                    if IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() == v.BindData.id then
                        continue
                    end                
                end
				--if v.BindData.slot and (rp.TPCamera.m_conThirdPerson == false) and (v.BindData.slot == COSM_SLOT_HAT or v.BindData.slot == COSM_SLOT_MASK) then continue end 
				
				if (bone ~= nil) then
					local pos, ang = (IsValid(ent) and ent or ply):GetBonePosition(bone)

                    local forward, right, up = ang:Forward(), ang:Right(), ang:Up()

                    local pos_offset = v.BindData.pos * ply:GetModelScale()
                    local ang_offset = v.BindData.ang

                    local pos_off = (up*(pos_offset.z or 0)) + (right*(pos_offset.y or 0)) + (forward*(pos_offset.x or 0))

                    ang:RotateAroundAxis( right, 	ang_offset.p or 0 )
                    ang:RotateAroundAxis( forward, 	ang_offset.y or 0 )
                    ang:RotateAroundAxis( up, 		ang_offset.r or 0 )

					local nPos = pos + pos_off

					if (v.BindData.pet) then
						nPos = nPos + Vector(0, 0, math.cos(RealTime() * 5) * 5)
					end

					v:SetPos(nPos)
					v:SetAngles(ang)
					v:DrawModel()
				end
			end
		end
	end
end

hook.Add("PostPlayerDraw", "PerformCosmeticsDraw", function(ply)
    if not ply or (not IsValid(ply) and not ply:IsPlayer() and not ply:Alive()) then 
        return 
    end
	hook.Run("DrawCosmetics",ply)
end)

hook.Add("DrawCosmetics", "MainCosmeticsDraw", drawCosmetics)



net.Receive("Cosmetics.UpdatePlayer", function(len, ply)
    if IsValid(ply) then
        ply:BuildCosmetics()
    end
end)

hook.Add("NetVars", "UpdateCosmetics", function(ply, str)
    if str ~= "Cosmetics" then return end
    if IsValid(ply) then
        ply:BuildCosmetics()
    end
end)

net.Receive("BroadcastCosmetics", function()
	local ent = net.ReadEntity()
	local tbl = net.ReadTable()
	ent.Cosmetics = tbl
	ent.CosmeticsReady = true

	timer.Simple(1, function()
		if (IsValid(ent) and ent:IsPlayer()) then
			ent:BuildCosmetics()
		end
	end)
end)

net.Receive("ClientInitCosmetics", function()
	local player_cosmetic_table = net.ReadTable()

	for k, cdata in pairs(player_cosmetic_table) do
		if IsValid(cdata.ent) then
			local pl = cdata.ent
			pl.Cosmetics = cdata.cosmetics
			pl.CosmeticsReady = true
			timer.Simple(k*0.5, function()
				if IsValid(pl) then
					pl:BuildCosmetics()
				end
			end)
		end
	end
end)


-- net.Receive("CleanCosmetics", function()
--     local ply = net.ReadEntity()
--     Cosmetics.Active[ply] = {}
-- end)

-- function Cosmetics.Render(ply)
--     if not ply or (not IsValid(ply) and not ply:IsPlayer() and not ply:Alive()) then 
--         return false 
--     end

--     if not ply.Cosmetics then
--         return false
--     end

--     if not Cosmetics.Active[ply] then
--         Cosmetics.UpdatePlayer(ply)
--         return
--     end

--     if Cosmetics.Active[ply] and #Cosmetics.Active[ply] > 0 then
--         for _, cos in pairs(Cosmetics.Active[ply]) do
--             local cType = cos.type

--             local itemdata = Cosmetics.Items[cType]

--             if not itemdata then continue end

--             local cEnt = cos.csent or ClientsideModel(itemdata.model, RENDERGROUP_BOTH)

--             if (itemdata.slot == COSM_SLOT_HAT or itemdata.slot == COSM_SLOT_EYES or itemdata.slot == COSM_SLOT_MASK) and not LocalPlayer():GetNVar("PlayerTPV") == true and ply == LocalPlayer() then
--                 continue
--             elseif (itemdata.slot == COSM_SLOT_RHAND) or (itemdata.slot == COSM_SLOT_LHAND) or (itemdata.slot == COSM_SLOT_PET) then
--                 if IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() == itemdata.id then
--                     continue
--                 end
--             end

--             local pos
--             local ang

--             if not itemdata.bone then
--                 local id = ply:LookupAttachment(itemdata.attach or "eyes")
--                 local aPos = ply:GetAttachment(id)
                
--                 if not aPos then return end
                
--                 pos = aPos.Pos
--                 ang = aPos.Ang
                
--             else
--                 local BoneIndx = ply:LookupBone(itemdata.bone or "ValveBiped.Bip01_Head1")
--                 if not BoneIndx then print("invalid bone: " .. itemdata.bone) return end
--                 local BonePos , BoneAng = ply:GetBonePosition( BoneIndx )
                
--                 pos = BonePos
--                 ang = BoneAng
                
--             end

--             local forward, right, up = ang:Forward(), ang:Right(), ang:Up()

--             local pos_offset = itemdata.pos * ply:GetModelScale()
--             local ang_offset = itemdata.ang

--             local mod = Cosmetics.Mod[ ply:GetModel() ]

--             if mod and mod[ cType ] then
--                 pos_offset = pos_offset + mod[ cType ].pos
--                 ang_offset = ang_offset + mod[ cType ].ang
--             end

--             local pos_off = (up*(pos_offset.z or 0)) + (right*(pos_offset.y or 0)) + (forward*(pos_offset.x or 0))

--             ang:RotateAroundAxis( right, 	ang_offset.p or 0 )
--             ang:RotateAroundAxis( forward, 	ang_offset.y or 0 )
--             ang:RotateAroundAxis( up, 		ang_offset.r or 0 )

--             cEnt:SetRenderOrigin(pos + pos_off)
--             cEnt:SetRenderAngles(ang)
--             cEnt:DrawModel()


--         end
--     end

-- end

-- hook.Add("PostPlayerDraw", "CosmeticsDraw", function(ply)
--     -- if (ply == LocalPlayer()) then return end
--     -- local insight = ply:InSight() and ply:InTrace()
--     -- if not insight then return end
--     if (not IsValid(ply) or not ply:Alive() or ply:GetNoDraw() == true) then return end

--     if (not ply == LocalPlayer()) and LocalPlayer():GetNVar("PlayerTPV") == true then return 
--         elseif ply == LocalPlayer() and LocalPlayer():GetNVar("PlayerTPV") ~= true then return
--         elseif ply == LocalPlayer() and not LocalPlayer():GetNVar("PlayerTPV") then return
--     end
--     Cosmetics.Render(ply)
-- end)

-- hook.Add( "PlayerIsLoaded", "Cosmetics.PlayerIsLoaded", function()
--     Cosmetics.UpdatePlayer(LocalPlayer(), true)
-- end)
-- hook.Add('Think', 'Cosmetics.Think', function()
-- 	for k, v in pairs(Cosmetics.Active) do
-- 	--	PrintTable(v)
-- 		for id, tab in pairs(v) do
-- 			if IsValid(k) and k:IsPlayer() and not k:Alive() then 
-- 	            if tab.csent then tab.csent:Remove() end    
-- 	            if Cosmetics.Active[k] then
-- 	                Cosmetics.ResetPlayer(k)
-- 	            else
-- 	                Cosmetics.Active[k] = {}
-- 	            end				
-- 			end
-- 			--print(tab.csent)
-- 		end
-- 	--	print(v.type)
-- 	end
-- end)