if (not SERVER) then return end

zlm = zlm or {}
zlm.f = zlm.f or {}

function zlm.f.CatchClosestNPC(ply)
    local npc

    for k, v in pairs(zlm_BuyerNPCs) do
        if IsValid(v) and zlm.f.InDistance(ply:GetPos(), v:GetPos(), zlm.config.NPC.SellDistance) then
            npc = v
            break
        end
    end

    return npc
end

function zlm.f.SellGrassRolls(ply,trailer)

    local grassRolls = trailer:GetGrassRolls()

    if grassRolls <= 0 then
        zlm.f.Notify(ply, zlm.language.General["TrailerEmpty"], 1)
        return
    end

    local dist = ply:GetPos():DistToSqr(Vector(-12011.410156, 9853.731445, 34.792995))
    local npc = zlm.f.CatchClosestNPC(ply)

    -- if IsValid(npc) then
    if dist < 300*300 then

        // This calculates the earning amount according to the player rank
        local earning = zlm.config.NPC.SellPrice[ply:GetUserGroup()]
        if earning == nil then
            earning = zlm.config.NPC.SellPrice["Default"]
        end
        earning = earning * grassRolls

        // Here we add the price multiplier
        --earning = earning * ((1 / 100) * npc:GetPriceModifier())
        earning = earning * ((1 / 100) * zlm.config.lostEarnings)
        //Custom Hook
        hook.Run("zlm_OnGrassRollSold", ply, grassRolls,earning,npc)

        // Here we give the player the money
        zlm.f.GiveMoney(ply, earning)
        ply:AddExperience(rp.Exp_Cfg["Lawnmovering"] * grassRolls)
        
        if IsValid(zlm.config.oatContainer.ent) then
            zlm.config.oatContainer.ent:AddItem(INV_ENTITY, "oat", 6*grassRolls)
        end

        // Creates the Sell Effect
        --zlm.f.CreateEffectAtPos("zlm_sell", trailer:GetPos())

        --local soundData = zlm.f.CatchSound("zlm_selling")
        --trailer:EmitSound(soundData.sound, soundData.lvl, soundData.pitch, soundData.volume, CHAN_STATIC)

        trailer:SetGrassRolls(0)

        zlm.f.Notify(ply, "+" .. earning .. zlm.config.Currency, 0)
    else
        zlm.f.Notify(ply, zlm.language.General["NoBuyerNPCFound"], 1)
    end
end
