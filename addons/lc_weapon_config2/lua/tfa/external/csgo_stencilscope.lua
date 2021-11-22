TFA.CSGO = TFA.CSGO or {}

if SERVER then
	AddCSLuaFile()
	TFA.CSGO.DrawScopeReticle = function( ... ) end
	return
end

local cv_color_r = GetConVar("cl_tfa_csgo_reticule_r")
local cv_color_g = GetConVar("cl_tfa_csgo_reticule_g")
local cv_color_b = GetConVar("cl_tfa_csgo_reticule_b")
local cv_color_a = GetConVar("cl_tfa_csgo_reticule_a")

local function defineCanvas(ref)
	render.UpdateScreenEffectTexture()
	render.ClearStencil()
	render.SetStencilEnable(true)
	render.SetStencilCompareFunction(STENCIL_ALWAYS)
	render.SetStencilPassOperation(STENCIL_REPLACE)
	render.SetStencilFailOperation(STENCIL_KEEP)
	render.SetStencilZFailOperation(STENCIL_REPLACE)
	render.SetStencilWriteMask(2)
	render.SetStencilTestMask(2)
	render.SetStencilReferenceValue(ref or 54)
end

local function drawReadyDepth()
	render.SetStencilCompareFunction(STENCIL_EQUAL)
	render.SetStencilPassOperation(STENCIL_REPLACE)
	render.SetStencilFailOperation(STENCIL_KEEP)
	render.SetStencilZFailOperation(STENCIL_KEEP)
	render.SetStencilWriteMask(4)
	render.SetStencilTestMask(2)
end

local function drawOn()
	render.SetStencilCompareFunction(STENCIL_EQUAL)
	render.SetStencilPassOperation(STENCIL_REPLACE)
	render.SetStencilFailOperation(STENCIL_KEEP)
	render.SetStencilZFailOperation(STENCIL_REPLACE)
	render.SetStencilWriteMask(4)
	render.SetStencilTestMask(4)
end

local function stopCanvas()
	render.SetStencilEnable(false)
	render.ClearDepth()
end

local reticleMat = Material("scope/csgo_dot.png", "noclamp nocull smooth")

function TFA.CSGO.DrawScopeReticle(wep, p, a, s, parent)
	if wep.VMRedraw then return end
	wep.VMRedraw = true

	local model = NULL
	if isstring(parent) and wep.VElements[parent] and wep.VElements[parent].curmodel then
		model = wep.VElements[parent].curmodel
	end

	if model:IsValid() then
		local dist = model:GetPos():Distance(EyePos()) + 2

		defineCanvas()

		render.SetBlend(0)
			model:DrawModel()
		render.SetBlend(1)

		drawReadyDepth()

		render.SetColorMaterial()
		render.DrawQuadEasy( EyePos() + EyeAngles():Forward()*dist, -EyeAngles():Forward(), 1024, 1024, ColorAlpha(color_black,0), 0)

		drawOn()
	end

	cam.IgnoreZ(true)
	cam.Start3D2D(p, a, s)
	render.PushFilterMin(TEXFILTER.ANISOTROPIC)
	render.PushFilterMag(TEXFILTER.ANISOTROPIC)
	
	surface.SetMaterial(reticleMat)
	surface.SetDrawColor(cv_color_r:GetInt(), cv_color_g:GetInt(), cv_color_b:GetInt(), cv_color_a:GetInt())
	surface.DrawTexturedRect(-1, -1, 2, 2)
	render.PopFilterMin()
	render.PopFilterMag()
	
	cam.End3D2D()
	cam.IgnoreZ(false)

	if model:IsValid() then
		stopCanvas()
	end

	wep.VMRedraw = false
end