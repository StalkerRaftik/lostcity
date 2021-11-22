if SERVER then return end
local wMod = ScrW() / 1920
local hMod = ScrH() / 1080
zlm = zlm or {}
zlm.f = zlm.f or {}

function PLAYER:GetTool( mode )

    local wep = self:GetWeapon( "gmod_tool" )
    if ( !IsValid( wep ) ) then return nil end

    local tool = wep:GetToolObject( mode )
    if ( !tool ) then return nil end

    return tool

end

function zlm.f.ToolGun_HasToolActive()
    local ply = LocalPlayer()

    if IsValid(ply) and ply:Alive() and IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() == "gmod_tool" then
        local tool = LocalPlayer():GetTool()

        if tool and table.Count(tool) > 0 and IsValid(tool.SWEP) and tool.Mode == "zlm_grassspawner" and tool.Name == "#GrassSpawner" then
            return true
        else
            return false
        end
    else
        return false
    end
end

local iconSize = 10


function zlm.f.ToolGun_GrassIndicator2d()
    if zlm.f.ToolGun_HasToolActive() then
        local plyPos = LocalPlayer():GetPos()

        for k, v in pairs(zlm_GrassSpots) do
            local pos = v.pos:ToScreen()

            if zlm.f.InDistance(plyPos, v.pos, 100) then return end

            local size = iconSize

            surface.SetDrawColor(zlm.default_colors["green04"])
            surface.DrawRect(pos.x - (size * wMod) / 2, pos.y - (size * hMod) / 2, size * wMod, size * hMod)
        end
    end
end

hook.Add("HUDPaint", "zlm_HUDPaint_ToolGun", zlm.f.ToolGun_GrassIndicator2d)
