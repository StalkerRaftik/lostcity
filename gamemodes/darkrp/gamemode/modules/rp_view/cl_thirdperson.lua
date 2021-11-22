vgui.GetWorldPanel():SetWorldClicker( false ) 

rp.TPCamera = {}
rp.TPCamera.m_conThirdPerson = LocalPlayer():GetNVar("PlayerTPV") or false
rp.TPCamera.m_conSideMove = CreateClientConVar( "rp_cam_side", 20, true, false )
rp.TPCamera.m_conBackMove = CreateClientConVar( "rp_cam_back", 30, true, false )

--Table of weapon classes that will force the camera to first person when active
rp.TPCamera.m_tblFirstPersonWeps = {
  ["weapon_phone"] = true,
}

local keyStateC, keyStateAlt
local lastViewAngle
local freeLookData = {}
local MAX_FREELOOK_UP = -45
local MAX_FREELOOK_DOWN = 45

local MIN_DIST_BACK = 30
local MIN_DIST_SIDE = 20
local MAX_DIST_BACK = 30
local MAX_DIST_SIDE = 20

local MovieMode_Pos = Vector(0,0,0)
local MovieMode_Ang = Vector(0,0,0)
function ToggleMovieMode() 
  MAIN_MOVIEMODE = !MAIN_MOVIEMODE 
  
  local lp = LocalPlayer()
  
  MovieMode_Pos = lp:GetShootPos()
  MovieMode_Ang = lp:GetAimVector()
end

function rp.TPCamera:LimitPos( vecPos, pPlayer, tblFilter )
  local vehicle = pPlayer:GetVehicle()

  local trData = {
    --     fpos =  LerpVector( FrameTime() * 10, fpos, vt.HitPos + ( ply:GetVelocity() / 10 ) + vt.HitNormal:Angle():Forward() * 6 )

    start = pPlayer:EyePos(),
    endpos = vecPos,
    mins = pPlayer:OBBMins() /2,
    maxs = pPlayer:OBBMaxs() /2,
    filter = tblFilter or { pPlayer },
  }

  local trForward = util.TraceHull( trData )
  if IsValid( trForward.Entity ) and trForward.Entity:IsPlayer() then
    table.insert( trData.filter, trForward.Entity )
    return self:LimitPos( vecPos, pPlayer, trData.filter )
  end

  if trForward.Hit and trForward.Entity ~= pPlayer and not trForward.Entity:IsPlayer() then
    return trForward.HitPos +trForward.HitNormal *1
  end
  
  return vecPos
end

function rp.TPCamera:LimitFreeLookAngles( angOld, angCur )
  angCur.p = math.Clamp( angCur.p, MAX_FREELOOK_DOWN, MAX_FREELOOK_UP )
  return angCur
end

hook.Add( "CalcView", "TPCalcSRP", function( pPlayer, vecOrigin, ... )
  local viewData = rp.TPCamera:CalcView( pPlayer, vecOrigin, ... )

  if viewData then
    if viewData.origin then g_CamPos = viewData.origin end
    return viewData
  end
end)

function rp.TPCamera:CalcView( pPlayer, vecOrigin, angAngs, intFOV )
  if LocalPlayer():GetNVar("PlayerTPV") == false then return end
  --Toggle Freelook
  local IN_FREELOOK = LocalPlayer():KeyDown( IN_WALK ) and not LocalPlayer():InVehicle()
  if not keyStateAlt and IN_FREELOOK then
    keyStateAlt = true
    --freeLookData.vm_origin = LocalPlayer():WorldToLocal( vm_origin )
    --freeLookData.vm_angles = vm_angles
  elseif keyStateAlt and not IN_FREELOOK then
    keyStateAlt = false
    freeLookData = {}
  end

  if pPlayer:InVehicle() then
    local VC = pPlayer:GetVehicle()
    if IsValid( VC ) and VC:GetThirdPersonMode() then
      local Or = VC:GetPos()
      Or.z = vecOrigin.z

      local dist = VC:OBBMins():Distance( VC:OBBCenter() )
      dist = dist +((VC:GetCameraDistance() +1) *50)

      local tr = util.TraceLine{
        start = Or,
        endpos = Or -angAngs:Forward() *(dist *1.5),
        filter = { VC, pPlayer },
        mask = MASK_SOLID_BRUSHONLY,
      }
      
      local view = {}
      view.origin = tr.HitPos
      view.zfar = 65536
      return view
    end
  elseif LocalPlayer():GetNVar("PlayerTPV") == true and (IsValid(LocalPlayer():GetActiveWeapon()) and not self.m_tblFirstPersonWeps[LocalPlayer():GetActiveWeapon():GetClass()]) then
    local backDistance = math.Clamp( self.m_conBackMove:GetInt(), MIN_DIST_BACK, MAX_DIST_BACK ) *-1
    local sideDistance = math.Clamp( self.m_conSideMove:GetInt(), MIN_DIST_SIDE, MAX_DIST_SIDE ) *1

    local view = {}
    view.origin = pPlayer:EyePos() +(pPlayer:EyeAngles():Forward() *backDistance) +(pPlayer:EyeAngles():Right() *sideDistance)
    view.origin = self:LimitPos( view.origin, pPlayer )
    view.angles = angAngs
    view.fov = intFOV
    view.zfar = 65536

    if keyStateAlt and not freeLookData.angles then
      freeLookData.angles = angAngs
    end

    if keyStateAlt then
      view.angles = angAngs --self:LimitFreeLookAngles( freeLookData.angles, angAngs )
      self.m_angCurFeelook = view.angles
      --return view
    end

    lastViewAngle = view.angles

    return view
  else
    if MAIN_MOVIEMODE then
      MovieMode_Pos = MovieMode_Pos +(vecOrigin -MovieMode_Pos) /32
      MovieMode_Ang = MovieMode_Ang +(angAngs:Forward() -MovieMode_Ang) /32
      
      local view = {}
      view.origin = MovieMode_Pos
      view.angles = MovieMode_Ang:Angle()
      view.zfar = 65536
      return view
    else
      return { zfar = 65536 }
    end
  end
end

hook.Add("ShouldDrawLocalPlayer", "TVP.ShouldDrawLocalPlayer", function()
  if LocalPlayer():GetNVar("PlayerTPV") == true then
    return true
  end
end)

hook.Add( "PrePlayerDraw", "FixPlayerModel", function( pPlayer )
    if not freeLookData.angles then return end
    if pPlayer ~= LocalPlayer() then return end

    pPlayer:SetRenderAngles( Angle(0, freeLookData.angles.y, 0) )
end )

hook.Add( "CreateMove", "FreeLook_MoveFix", function( CUserCmd )
    if not freeLookData.angles then return end
    local moveVec = Vector( CUserCmd:GetForwardMove(), CUserCmd:GetSideMove(), 0 )
    local moveNormal = moveVec:GetNormal()
    local newMoveVec = (moveNormal:Angle() +(LocalPlayer():EyeAngles() -freeLookData.angles)):Forward() *moveVec:Length()

    CUserCmd:SetForwardMove( newMoveVec.x )
    CUserCmd:SetSideMove( newMoveVec.y )
end )
