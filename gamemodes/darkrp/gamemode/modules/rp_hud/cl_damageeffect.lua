local prevhealth = 100
local delay = 0
local maxalpha = 250
local maxtime = 0.05
hook.Add("Think","rp.damageeffect", function()
    local p = LocalPlayer()

    if prevhealth > p:Health() then
        local dmg = prevhealth - p:Health()
        if p.fadeTime == nil then
            p.fadeTime = dmg
        else
            p.fadeTime = p.fadeTime + dmg
        end
        p:ScreenFade(SCREENFADE.IN, Color(155,0,0,math.min(dmg * 5 + p.fadeTime * 5,maxalpha)), 0.2 + math.min(p.fadeTime / 20, maxtime), 0)
    end

    if CurTime() > delay and p.fadeTime ~= 0 then
        if p.fadeTime == nil then
            p.fadeTime = 0
        elseif p.fadeTime > 0 then
            p.fadeTime = p.fadeTime - 1
        else
            p.fadeTime = 0
        end
        delay = CurTime() + .001
    end

    prevhealth = p:Health()

    if p:Health() <= 0 then
        p.fadeTime = 0
    end
end)

hook.Add("HUDShouldDraw", "DisableDefauldGmodDamageIndicator", function(name)
    if name == "CHudDamageIndicator" then return false end
end)