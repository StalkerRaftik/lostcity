
local moonScale,sunScale = GetConVarNumber("sf_moonscale",6),30
local clamp,abs,max,min = math.Clamp,math.abs,math.max,math.min
timer.Create("SF_MoonWatcher",1,0,function()
	moonScale = GetConVarNumber("sf_moonscale",6)
	sunScale = StormFox.GetData("SunSize", 30) or 30
end)

-- render.OverrideBlendFunc is to be replaced by render.OverrideBlend .. we need to be sure both versions work (Chrome and current).
	local function render_OverrideBlend(enabled, srcBlend, destBlend, blendFunc, srcBlendAlpha, destBlendAlpha, blendFuncAlpha)
		if render.OverrideBlendFunc then
			render.OverrideBlendFunc( enabled, srcBlend, destBlend, srcBlendAlpha, destBlendAlpha )
		end
	end
	if render.OverrideBlend then
		render_OverrideBlend = render.OverrideBlend
	end

-- Moon smoothness
	local catch_p,catch_r = 0,0
	-- hook.Add("StormFox - NetDataChange","StormFox - MoonSmooth",function(var,day)
	-- 	if var ~= "Moon-offset_p" then return end
	-- 	catch_p = 0
	-- 	catch_r = 0
	-- end)

-- Sun and Moon data
	-- Calc angle and visibility 
		local moonAng,sunAng = Angle(0,0,0),Angle(0,0,0)
		local moonVisible,sunVisible,sunRayVis = 0,0,0
		local BG_Color = Vector(0,0,0) -- This is the "moon color" for the unlit moon area
		local moon_lock = GetConVar("sf_moonphase")
		function StormFox.GetMoonAngle(time)
			if not time then return moonAng	end
			local pitch = ((time / 360) - 1) * 90
			if pitch < 0 then pitch = pitch + 360 end
			return Angle(pitch,StormFox.GetSunMoonAngle(), 0)
		end
		function StormFox.GetSunAngle(time)
			if not time then return sunAng	end
			local pitch = ((time / 360) - 1) * 90 + 180
			if pitch < 0 then pitch = pitch + 360 end
			return Angle(pitch,StormFox.GetSunMoonAngle(), 0)
		end
		function StormFox.GetMoonVisibility()
			return moonVisible
		end
		local sum_a = 1
		function StormFox.GetSunVisibility()
			return sunVisible * sum_a
		end
		function StormFox.GetSunRayVisibility()
			return clamp(sunRayVis * 20,0,1) * sum_a
		end
		function StormFox.GetMoonScale()
			return moonScale or 6
		end
	-- Suninfo support
	_old_util_GetSunInfo = _old_util_GetSunInfo or util.GetSunInfo() -- Just in case
	function util.GetSunInfo()
		if not sunAng or not sunVisible or not StormFox then -- In case you mess with stuff
			return _old_util_GetSunInfo()
		end
		local tab = {}
			tab.direction = sunAng:Forward()
			tab.obstruction = sunVisible * sum_a
		return tab
	end

-- MoonPhases
	-- Setup params and vars
		local params = {}
			params[ "$basetexture" ] = ""
			params[ "$translucent" ] = 1
			params[ "$vertexalpha" ] = 1
			params[ "$vertexcolor" ] = 1
			params[ "$nofog" ] = 1
			params[ "$nolod" ] = 1
			params[ "$nomip" ] = 1
			params["$additive"] = 1
		local CurrentMoonTexture = CreateMaterial("SF_RENDER_MOONTEX","UnlitGeneric",params)
		local params = {}
			params[ "$basetexture" ] = ""
			params[ "$translucent" ] = 1
			params[ "$vertexalpha" ] = 1
			params[ "$vertexcolor" ] = 1
			params[ "$nofog" ] = 1
			params[ "$nolod" ] = 1
			params[ "$nomip" ] = 1
			params[ "$additive" ] = 0
			params[ "$color" ] = "[0 0 0]"
		local DarkMoonTexture = CreateMaterial("SF_RENDER_MOONTEX_DARK","UnlitGeneric",params)
		local lastMat = ""
		local Mask_25,Mask_0,Mask_50,Mask_75 = Material("stormfox/moon_phases/25.png"),Material("stormfox/moon_phases/0.png"),Material("stormfox/moon_phases/50.png"),Material("stormfox/moon_phases/75.png")
		local texscale = 512
		local RTMoonTexture = GetRenderTargetEx( "StormfoxMoon", texscale, texscale, 1, MATERIAL_RT_DEPTH_NONE, 2, CREATERENDERTARGETFLAGS_UNFILTERABLE_OK, IMAGE_FORMAT_RGBA8888)

	local lastRotation,lastCurrentPhase = -1,-1
	local lastMoonMat = ""
	local function RenderMoonPhase(rotation,currentPhase)
		-- Check if there is a need to re-render
			local moonMat = Material(StormFox.GetData("MoonTexture") or "stormfox/effects/moon.png")
			rotation = rotation or 0
			currentPhase = currentPhase or 1.3
			if lastRotation == rotation and lastCurrentPhase == currentPhase and lastMoonMat == moonMat then
				-- Already rendered
				return true
			end
			lastRotation = rotation 
			lastCurrentPhase = currentPhase 
			lastMoonMat = moonMat
		
		-- Set dark texture
			DarkMoonTexture:SetTexture("$basetexture",moonMat:GetTexture("$basetexture"))

		render.PushRenderTarget( RTMoonTexture )
		render.OverrideAlphaWriteEnable( true, true )

		render.ClearDepth()
		render.Clear( 0, 0, 0, 0 )
		cam.Start2D()
			-- Render moon
			surface.SetDrawColor(255,255,255)
			surface.SetMaterial(moonMat)
			surface.DrawTexturedRectUV(0,0,texscale,texscale,0,0,1,1)
			-- Mask Start
			--	render.OverrideBlendFunc( true, BLEND_ZERO, BLEND_SRC_ALPHA, BLEND_DST_ALPHA, BLEND_ZERO )
				render_OverrideBlend(true, BLEND_ZERO, BLEND_SRC_ALPHA,0,BLEND_DST_ALPHA, BLEND_ZERO,0)
			-- Render mask
				surface.SetDrawColor(Color(255,255,255,255))
				-- 0 to 50%
				if currentPhase < 2.9 then
					local s = 7 - 2.3 * currentPhase
					surface.SetMaterial(Mask_25)
					surface.DrawTexturedRectRotated(texscale / 2,texscale / 2,texscale * s,texscale,rotation)
					if currentPhase >= 2.6 then
						-- Ex step
						local x,y = math.cos(math.rad(-rotation)),math.sin(math.rad(-rotation))
						surface.SetMaterial(Mask_0)
						surface.DrawTexturedRectRotated(texscale / 2 + x * (-texscale * 0.5),texscale / 2 + y * (-texscale * 0.5),texscale * 0.9,texscale,rotation)
						
					end
				elseif currentPhase < 3.1 then -- 50%
					local s = 1
					surface.SetMaterial(Mask_50)
					surface.DrawTexturedRectRotated(texscale / 2,texscale / 2,texscale * s,texscale,rotation)
				elseif currentPhase < 4.9 then -- 50% to 100%
													-- 5.8 to 0.4
					local s = (3.176 * currentPhase) - 9.76

					surface.SetMaterial(Mask_75)
					surface.DrawTexturedRectRotated(texscale / 2,texscale / 2,texscale * s,texscale,rotation + 180)
					if s < 1 then
						local x,y = math.cos(math.rad(-rotation)),math.sin(math.rad(-rotation))
						surface.SetMaterial(Mask_0)
						surface.DrawTexturedRectRotated(texscale / 2 + x * (-texscale * 0.5),texscale / 2 + y * (-texscale * 0.5),texscale * 0.9,texscale,rotation + 180)
					end
				else
					-- FULL MOON
				end
			-- Mask End
			   	render_OverrideBlend(false)
			   	render.OverrideAlphaWriteEnable( false )
		cam.End2D()
		render.OverrideAlphaWriteEnable( false )
		render.PopRenderTarget()
		CurrentMoonTexture:SetTexture("$basetexture",RTMoonTexture)
	end

function StormFox.GetMoonPhaseRaw()
	return lastCurrentPhase
end

function StormFox.GetMoonMaterial()
	return CurrentMoonTexture,DarkMoonTexture,lastRotation
end

-- SkyGuard (Render stuff in the right order)
	hook.Add("PostDraw2DSkyBox", "StormFox - SkyBoxRender", function()
		if not StormFox.MapOBBCenter then return end
		local c_pos = StormFox.GetEyePos() or EyePos()
		local map_center = StormFox.MapOBBCenter() or Vector(0,0,0)
		hook.Run("StormFox - StarRender",		c_pos, map_center)
		hook.Run("StormFox - TopSkyRender",		c_pos, map_center) -- For moon and sun
		hook.Run("StormFox - RenderAboveSkies",	c_pos, map_center) -- Above skies
		hook.Run("StormFox - RenderClouds",		c_pos, map_center) -- Skies
		hook.Run("StormFox - RenderUnderClouds",c_pos, map_center) -- Under skies
	end)

local atan2 = math.atan2
-- Render Sun and moon
	local MoonGlow = Material("stormfox/moon_glow")
	local MoonMat = Material( "stormfox/moon_fix" );
	local sunMat = Material("stormfox/moon_glow")
	local sunC = Color(255,255,255)
	hook.Add("StormFox - TopSkyRender","StormFox - SunAndMoon",function()
		-- moonScale,sunScale
		local eyeang = EyeAngles()
		-- Angle
			local SunN = -sunAng:Forward()
			local N = moonAng:Forward()
			local NN = -N
			local sa = moonAng.y
		cam.Start3D( Vector( 0, 0, 0 ), eyeang ) -- 2d maps fix
			
			render.OverrideDepthEnable( true, false )
			render.SuppressEngineLighting(true)

			render.SetLightingMode( 2 )
			-- Render sun first
				local c_c = StormFox.GetData("SunColor", Color(255,255,255))
				local c = Color(c_c.r,c_c.g,c_c.b,c_c.a)
				local a = clamp(sunScale / 20,0,1) * 255 * StormFox.CalculateMapLight(StormFox.GetTime()) / 255
					c.a = a
					sum_a = a / 255
				render.SetMaterial(sunMat)
				render.DrawQuadEasy( SunN * -200, SunN, 30, 30, c, 0 )
				if IsValid(g_SkyPaint) then
					g_SkyPaint:SetSunNormal( -SunN)
				end
			-- Render moon
				-- Render texture
					-- Calc moonphase from pos
					local A = sunAng:Forward() * 14975
					local B = moonAng:Forward() * 39
					local moonTowardSun = (A - B):Angle()
					local C = moonAng
						C.r = 0
					local dot = C:Forward():Dot(moonTowardSun:Forward())
					-- currentYaw
						
						-- 	PITCH, YAW sunoffset
						local p,y = math.AngleDifference(moonTowardSun.p,C.p),math.AngleDifference(moonTowardSun.y,C.y)
						local v,ang = WorldToLocal(moonTowardSun:Forward(),Angle(0,0,0),Vector(0,0,0),C)
							ang = v:AngleEx(C:Forward()):Forward()
						local roll = math.deg(math.atan2(ang.z,ang.y))

						local currentPhase = 2.5 - (5.5 * dot) / 2
					StormFox.SetNetworkData("MoonPhase",clamp( currentPhase * 1.00,0,5) * 20) -- Override server data
					RenderMoonPhase( -sa - roll + 0   ,clamp( currentPhase * 1.00,0,5))
				local c = StormFox.GetData("MoonColor",Color(205,205,205))
				local a = StormFox.GetData("MoonVisibility",100)
				local gda = 0 -- Calc invisibility at colors (180 = 18:00, 0 = 6:00)
				if moonAng.p > 190 then
					gda = clamp((moonAng.p - 190) / 10,0,1)
				elseif moonAng.p < 350 then
					gda = 1 - clamp((moonAng.p - 350) / 10,0,1)
				end
				-- Dark moonarea
					BG_Color = BG_Color * (a / 100)

					DarkMoonTexture:SetVector("$color",BG_Color)

				local moonAlpha = clamp((StormFox.GetData("StarFade",0) - 0.5) * 2,0.01,1) * 255
				render.SetMaterial( DarkMoonTexture )
			--	local lum = 0.2126 * BG_Color.r + 0.7152 * BG_Color.g + 0.0722 * BG_Color.b
			--	print(lum) -- 120 = 5
							--
				render.DrawQuadEasy( N * 200, NN, moonScale * 5, moonScale * 5, Color(0,0,0, 0 ), sa )
				render.SetMaterial( CurrentMoonTexture )
				local aa = max(0,(3.125 * a) - 57.5)
				render.DrawQuadEasy( N * 200, NN, moonScale * 5, moonScale * 5, Color(c.r,c.g,c.b, aa  ), sa )

				render.SuppressEngineLighting(false)
				render.SetLightingMode( 0 )
				render.OverrideDepthEnable( false, false )
				render.SetColorMaterial()
		cam.End3D()
	end)

-- Sunbeam
	--sf_allow_sunbeams
	local matSunbeams = Material( "pp/sunbeams" )
		matSunbeams:SetTexture( "$fbtexture", render.GetScreenEffectTexture() )
	hook.Add( "RenderScreenspaceEffects", "StormFox - Sunbeams", function()
		if ( not render.SupportsPixelShaders_2_0() ) then return end
		local con = GetConVar("sf_allow_sunbeams")
		if not con or not con:GetBool() then return end
		local lam = StormFox.CalculateMapLight() / 100 - 0.5

		local direciton = sunAng:Forward()
		local beampos = StormFox.GetEyePos() + direciton * 4096

		local scrpos = beampos:ToScreen()

		if ( sunRayVis == 0 ) then return end

		local dot = ( direciton:Dot( EyeVector() ) - 0.8 ) * 5
		if ( dot <= 0 ) then return end

		local suna = 255
		local slam = max((suna - 155) / 100,0)

		if slam >= 0 then
			render.UpdateScreenEffectTexture()

				matSunbeams:SetFloat( "$darken", .95 )
				matSunbeams:SetFloat( "$multiply", abs(lam) * dot * sunRayVis * slam * 1.2)
				matSunbeams:SetFloat( "$sunx", scrpos.x / ScrW() )
				matSunbeams:SetFloat( "$suny", scrpos.y / ScrH() )
				matSunbeams:SetFloat( "$sunsize", .20 )

				render.SetMaterial( matSunbeams )
			render.DrawScreenQuad()
		end
	end )
