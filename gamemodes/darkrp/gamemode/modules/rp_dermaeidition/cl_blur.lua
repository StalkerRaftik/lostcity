
rp.Interface = rp.Interface or {}
local blur = Material( "pp/blurscreen" )
local useBlur = true

hook.Add( "rp._Kernel.PostModuleLoad", "rp.UI", function()
    useBlur = rp.ClientSettings:GetValue( "bDrawBlur", true )

    rp.ClientSettings:AddCallback( "bDrawBlur", function( bOld, bNew, sVar )
        useBlur = bNew
    end )
end )

-- Draws a blurred material over the screen, to blur things.
function rp.Interface.DrawBlur(panel, amount, passes)
    -- Intensity of the blur.
    amount = amount or 5

    if not useBlur then
        surface.SetDrawColor(50, 50, 50, amount * 20)
        surface.DrawRect(0, 0, panel:GetWide(), panel:GetTall())
    else
        surface.SetMaterial(blur)
        surface.SetDrawColor(255, 255, 255)

        local x, y = panel:LocalToScreen(0, 0)

        for i = -(passes or 0.2), 1, 0.2 do
            -- Do things to the blur material to make it blurry.
            blur:SetFloat("$blur", i * amount)
            blur:Recompute()

            -- Draw the blur material over the screen.
            render.UpdateScreenEffectTexture()
            surface.DrawTexturedRect(x * -1, y * -1, ScrW(), ScrH())
        end
    end
end

function rp.Interface.DrawBlurAt(x, y, w, h, amount, passes)
    -- Intensity of the blur
    amount = amount or 5

    if not useBlur then
        surface.SetDrawColor(30, 30, 30, amount * 20)
        surface.DrawRect(x, y, w, h)
    else
        surface.SetMaterial(blur)
        surface.SetDrawColor(255, 255, 255)

        local scrW, scrH = ScrW(), ScrH()
        local x2, y2 = x / scrW, y / scrH
        local w2, h2 = (x + w) / scrW, (y + h) / scrH

        for i = -(passes or 0.2), 1, 0.2 do
            blur:SetFloat("$blur", i * amount)
            blur:Recompute()

            render.UpdateScreenEffectTexture()
            surface.DrawTexturedRectUV(x, y, w, h, x2, y2, w2, h2)
        end
    end
end
