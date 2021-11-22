if CLIENT then
local s=CreateClientConVar('rp_viewdist',4000,true)

local function OptimizMeMrKrabs( ply )
	local interp = engine.TickInterval()
	local interp_min = interp
	local interp_max = interp * 3

	ply:ConCommand( "cl_cmdrate " .. 1 / interp )
	ply:ConCommand( "cl_updaterate " .. 1 / interp )
    ply:ConCommand ("rp_viewdist 4000" )

	hook.Add( "Tick", "SOMEOPTIMIZ", function()
		interp = Lerp( .01, interp, math.Clamp( engine.ServerFrameTime(), interp_min, interp_max ) + 0.001 )
		ply:ConCommand( "cl_interp " .. interp )
	end )
end

hook.Add( "Think", "AREYOULOADINGNOW", function()
	if IsValid( LocalPlayer() ) then
		timer.Simple( 25, function()
			if IsValid( LocalPlayer() ) then
				OptimizMeMrKrabs( LocalPlayer() )
			end
		end)
		hook.Remove( "Think", "AREYOULOADINGNOW" )
	end
end )

end

hook.Add("InitPostEntity","NoWidgets",function()
 timer.Simple(60, function()
 
    hook.Remove("PlayerTick", "TickWidgets")
 
    if SERVER then
        if timer.Exists("CheckHookTimes") then
            timer.Remove("CheckHookTimes")
        end
 
        for k, v in pairs(ents.FindByClass("env_fire")) do v:Remove() end
        for k, v in pairs(ents.FindByClass("trigger_hurt")) do v:Remove() end
        for k, v in pairs(ents.FindByClass("beam")) do v:Remove() end
        for k, v in pairs(ents.FindByClass("point_spotlight")) do v:Remove() end
        for k, v in pairs(ents.FindByClass("env_sprite")) do v:Remove() end
        for k, v in pairs(ents.FindByClass("func_tracktrain")) do v:Remove() end
        for k, v in pairs(ents.FindByClass("env_soundscape")) do v:Remove() end  
    end
   
    hook.Remove("PlayerTick","TickWidgets")
    hook.Remove( "Think", "CheckSchedules")
    timer.Destroy("HostnameThink")
    hook.Remove("LoadGModSave", "LoadGModSave")

 end)
end)

 
if CLIENT then

	 
	function CanSeeEnt(ent)
	    -- local min, max = ent:WorldSpaceAABB()
	 
	    -- local wide = min.x + max.x
	 
	    -- local tall = min.y + max.y
	 
	    -- if LocalPlayer():IsLineOfSightClear(ent) then
	    --     return true
	    -- end
	 
	    -- if LocalPlayer():IsLineOfSightClear(min) then
	    --     return true
	    -- end
	 
	    -- if LocalPlayer():IsLineOfSightClear(max) then
	    --     return true
	    -- end
	   
	    -- return false
        return true
	end


     timer.Simple(1,function()
    RunConsoleCommand("gmod_mcore_test", 1) -- CUSTOM TIMER
    hook.Remove("RenderScreenspaceEffects", "RenderColorModify")
    hook.Remove("RenderScreenspaceEffects", "RenderBloom")
    hook.Remove("RenderScreenspaceEffects", "RenderToyTown")
    hook.Remove("RenderScreenspaceEffects", "RenderTexturize")
 end)
 
 timer.Simple(2,function()
    RunConsoleCommand("net_graphshowlatency", 1)
    RunConsoleCommand("net_graphsolid", 1)
    RunConsoleCommand("net_graphtext", 1)
    RunConsoleCommand('r_fastzreject', -1)
    hook.Remove("RenderScreenspaceEffects", "RenderSunbeams")
    hook.Remove("RenderScreenspaceEffects", "RenderSobel")
    hook.Remove("RenderScreenspaceEffects", "RenderSharpen")
    hook.Remove("RenderScreenspaceEffects", "RenderMaterialOverlay")
    hook.Remove("RenderScreenspaceEffects", "RenderMotionBlur")
 end)
 
 timer.Simple(2.5,function()
    RunConsoleCommand('Cl_ejectbrass', 0)
    RunConsoleCommand('Muzzleflash_light', 0)
    RunConsoleCommand('cl_wpn_sway_interp', 0)
    RunConsoleCommand('in_usekeyboardsampletime', 0)
    hook.Remove("RenderScene", "RenderStereoscopy")
    hook.Remove("RenderScene", "RenderSuperDoF")
    hook.Remove("GUIMousePressed", "SuperDOFMouseDown")
    hook.Remove("GUIMouseReleased", "SuperDOFMouseUp")
    hook.Remove("PreventScreenClicks", "SuperDOFPreventClicks")
    hook.Remove("PostRender", "RenderFrameBlend")
    hook.Remove("PreRender", "PreRenderFrameBlend")
    hook.Remove("Think", "DOFThink")
    hook.Remove("RenderScreenspaceEffects", "RenderBokeh")
    hook.Remove("NeedsDepthPass", "NeedsDepthPass_Bokeh")
    hook.Remove("PostDrawEffects", "RenderWidgets")
    hook.Remove("PostDrawEffects", "RenderHalos")
    hook.Remove("RenderScreenspaceEffects", "RenderColorModify")
    hook.Remove("RenderScreenspaceEffects", "RenderBloom")
 end)
 
 timer.Simple(3,function()
    RunConsoleCommand("rope_wind_dist", 0)
    RunConsoleCommand( "cl_interp", 0.116700 )
    RunConsoleCommand( "cl_interp_ratio", 0 )
    RunConsoleCommand( "rate", 1280000 )
    RunConsoleCommand( "cl_playerspraydisable", 1 )
 end)
 
 timer.Simple(3.5,function()
    RunConsoleCommand( "r_decals", 30 )
    RunConsoleCommand("rope_shake", 0)
    RunConsoleCommand("net_graphheight", 60)
    RunConsoleCommand("net_graphmsecs", 400)
 end)
 
 timer.Simple(4,function()
    RunConsoleCommand( "r_dynamic", 1 )
    RunConsoleCommand( "r_decal_cullsize", 0 )
    RunConsoleCommand( "cl_smooth", 0 )
    RunConsoleCommand( "studio_queue_mode", 1 )
 end)
 
 timer.Simple(4.5,function()
    --RunConsoleCommand("rate", 2097152)
    RunConsoleCommand( "cl_show_splashes", 0 )
    RunConsoleCommand("net_graphproportionalfont", 0)
    RunConsoleCommand("net_graphshowinterp", 1)
 end)
 
timer.Simple(5.5,function()
RunConsoleCommand( "mp_decals", 20 )
RunConsoleCommand( "mat_forceaniso", 0 )
RunConsoleCommand( "cl_phys_props_enable" , 0 )
end)
timer.Simple(6,function()
RunConsoleCommand( "cl_phys_props_max" , 0 )
RunConsoleCommand( "props_break_max_pieces" , 0 )
RunConsoleCommand( "r_propsmaxdist" , 0 )
RunConsoleCommand("r_renderoverlayfragment", 0)
end)
timer.Simple(6.5,function()
RunConsoleCommand( "violence_agibs" , 0 )
RunConsoleCommand( "violence_hgibs" , 0 )
RunConsoleCommand("r_WaterDrawReflection", 0)
RunConsoleCommand("cl_threaded_client_leaf_system", 1)
end)
timer.Simple(7,function()
RunConsoleCommand("r_threaded_client_shadow_manager", 1)
RunConsoleCommand("r_threaded_particles", 1)
RunConsoleCommand("r_threaded_renderables", 1)
RunConsoleCommand("r_queued_ropes", 1)
end)
timer.Simple(7.5,function()
--RunConsoleCommand("mat_specular", 0) -- Надо больше фпс? Ставь
RunConsoleCommand("joystick", 0)
RunConsoleCommand("violence_ablood", 0)
RunConsoleCommand("violence_hblood", 0)
end)
timer.Simple(8,function()
RunConsoleCommand("r_cheapwaterstart", 1)
RunConsoleCommand("r_cheapwaterend", 1)
RunConsoleCommand("r_waterforceexpensive", 0)
RunConsoleCommand("r_WaterDrawRefraction", 0)
end)
timer.Simple(8.5,function()
RunConsoleCommand("mat_wateroverlaysize", 4)
RunConsoleCommand( "r_lod", 0 )
--RunConsoleCommand( "r_shadowrendertotexture", 0 )
--RunConsoleCommand( "r_shadowmaxrendered", 0 )
end)
timer.Simple(9,function()
--RunConsoleCommand( "mat_shadowstate", 0 )
RunConsoleCommand("cl_threaded_bone_setup", 1)
RunConsoleCommand("rope_smooth", 0)
end)
timer.Simple(9,function()
RunConsoleCommand("r_3dsky", 1)  -- CUSTOM TIMER
end)
timer.Simple(9.5,function()
RunConsoleCommand("mat_bloomscale", 0)
RunConsoleCommand("mat_antialias", 0)
RunConsoleCommand("mat_hdr_enabled", 0)
RunConsoleCommand("mat_hdr_level", 0)
end)
timer.Simple(10,function()
RunConsoleCommand("mat_disable_lightwarp", 1)
RunConsoleCommand("r_drawmodeldecals", 0)
RunConsoleCommand("r_teeth", 0)
end)
timer.Simple(12, function()
	RunConsoleCommand('rp_viewdist', 4000)
end)
end

hook.Add("NetworkEntityCreated", "minimal_ent_opt", function(ent)
    timer.Simple(1, function()
        if not IsValid(ent) then return false end
        if ent:IsWeapon() then return false end
        if ent == LocalPlayer() then return false end
        if ent.Owner and ent.Owner == LocalPlayer() then return end
 
 
        if ent:GetClass() == "prop_physics" then
            ent.RenderOverride = function()
                local prorisovka = GetConVarNumber("rp_viewdist") or 4000
                local ent_pos = ent:GetPos():ToScreen()
 
                if LocalPlayer():GetPos():DistToSqr(ent:GetPos()) < prorisovka * prorisovka then
 
                    if ent_pos.visible then
                        ent:DrawModel()
                        ent:DrawShadow(true)
                    else
                        ent:DrawShadow(false)
                    end
                else
                    ent:DrawShadow(false)
                end
            end
        else
            ent.RenderOverride = function()
                local prorisovka = GetConVarNumber("rp_viewdist")
                local ent_pos = ent:GetPos():ToScreen()
 
                if LocalPlayer():GetPos():DistToSqr(ent:GetPos()) < prorisovka * prorisovka and CanSeeEnt(ent) then
                    ent:DrawModel()
                    ent:DrawShadow(true)
                else
                    ent:DrawShadow(false)
                end
            end
        end
    end)
end)
