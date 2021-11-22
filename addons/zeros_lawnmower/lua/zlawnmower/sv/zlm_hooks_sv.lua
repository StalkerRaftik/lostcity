if not SERVER then return end
zlm = zlm or {}
zlm.f = zlm.f or {}


hook.Add("InitPostEntity", "zlm_lostcity_placeOatContainer", function()
    local oatContainer = ents.Create("loot_container")
    oatContainer:SetPos(zlm.config.oatContainer.pos)
    oatContainer:SetAngles(zlm.config.oatContainer.ang)
    oatContainer:SetModel(zlm.config.oatContainer.mdl)
    oatContainer:Spawn()
    local phys = oatContainer:GetPhysicsObject()
    if IsValid(phys) then
        phys:EnableMotion(false)
    end
    zlm.config.oatContainer.ent = oatContainer
    oatContainer.CustomUseCheck = function(ply)
        return ply:Team() == TEAM_POM3
    end
end)

hook.Add("PlayerCharLoaded", "zlm_SendGrassToClient", function(ply)
    zlm.f.Send_GrassSpots_ToClient(ply)
end)

hook.Add("OnPlayerChangedTeam", "RemoveEntitiesOnChangingJob", function(ply, prevTeam)
    if prevTeam == TEAM_POM2 then
        if IsValid(ply.zlm_Tractor) then
            ply.zlm_Tractor:Remove()
        end
        if IsValid(ply.zlm_Tractor_Trailer) then
            ply.zlm_Tractor_Trailer:Remove()
        end
    end
end)
