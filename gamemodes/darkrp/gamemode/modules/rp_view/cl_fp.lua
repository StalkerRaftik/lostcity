-- hook.Add( "PlayerIsLoaded", "ThirdPersonBind", function()
--   rp.Keybinds.RegisterBind("ThirdPersonBind", "Вид от 3го лица", KEY_F1,
--     function()
--       if GetConVar("rp_cam_third"):GetInt() >= 1 then 
--         RunConsoleCommand("rp_cam_third",0)
--         LocalPlayer().TVP = false
--       else
--         RunConsoleCommand("rp_cam_third",1)
--         LocalPlayer().TVP = true
--       end
--     end,
--     function() end
--   )
-- end)

vgui.GetWorldPanel():SetWorldClicker( false ) 

rp.TPCamera = {}
rp.TPCamera.m_conThirdPerson = CreateClientConVar( "rp_cam_third", 0, true, false )
rp.TPCamera.m_conSideMove = CreateClientConVar( "rp_cam_side", 24, true, false )
rp.TPCamera.m_conBackMove = CreateClientConVar( "rp_cam_back", 72, true, false )

--Table of weapon classes that will force the camera to first person when active
rp.TPCamera.m_tblFirstPersonWeps = {
  ["weapon_phone"] = true,
}

local keyStateC, keyStateAlt
local lastViewAngle
local freeLookData = {}
local MAX_FREELOOK_UP = -45
local MAX_FREELOOK_DOWN = 45

local MIN_DIST_BACK = 24
local MIN_DIST_SIDE = 0
local MAX_DIST_BACK = 128
local MAX_DIST_SIDE = 32

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
  if (rp.TPCamera.m_conThirdPerson == false) then return end
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
  elseif self.m_conThirdPerson:GetInt() == 1 and (IsValid(LocalPlayer():GetActiveWeapon()) and not self.m_tblFirstPersonWeps[LocalPlayer():GetActiveWeapon():GetClass()]) then
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

-- function rp.TPCamera:ShouldDrawLocalPlayer()
--   if LocalPlayer():InVehicle() then
--     return false
--   end
  
--   if not IsValid( LocalPlayer():GetActiveWeapon() ) then return end
--   if rp.Camera.m_conThirdPerson:GetInt() == 1 and not rp.Camera.m_tblFirstPersonWeps[LocalPlayer():GetActiveWeapon():GetClass()] then
--     return true
--   end
-- end

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

-- local l 
-- local function s()
--   hook.Remove("CalcView","FPCalcView")
--   -- hook.Remove("ShouldDrawLocalPlayer","FPShouldDrawLocalPlayer")
--   hook.Remove("CreateMove","FPCreateMove")
--   CreateClientConVar("fp",Entity(0):GetNWInt("fp_enabledbydefault",-1),false)
--   CreateClientConVar("fp_complexity",0,true)
--   CreateClientConVar("fp_nearz",1,true)
--   local e=LocalPlayer():EyeAngles()
--   local i=e local n=LocalPlayer():GetShootPos()
--   local c=tonumber(GetConVarNumber("fp_complexity"))
--     l=GetConVarNumber("fp_nearz")
--     local a,d=Angle(),false 
--     hook.Add("InputMouseApply","rp-view", function(e,l,o,n)
--       if d then 
--         a.p=math.Clamp(a.p+o/30,-45,45)
--         a.y=math.Clamp(a.y-l/30,-60,60)
--         e:SetMouseX(0)e:SetMouseY(0)
--         return true 
--       else 
--         a.p=math.Approach(a.p,0,math.max(math.abs(a.p),.2)*FrameTime()*10)
--         a.y=math.Approach(a.y,0,math.max(math.abs(a.y),.2)*FrameTime()*10)
--       end 
--     end)
--     local function o(o)
--       local a={}
--       a.start=n 
--       a.endpos=o or n+e:Forward()*23170 
--       a.filter={
--         LocalPlayer(),
--         LocalPlayer():GetVehicle()
--       }
--         local e=util.TraceLine(a)
--         return e 
--       end 
--       local function s(e,t,o,t)
--         if e:GetViewEntity()==e and e:Alive() and not IsValid(e.CurDoor) and (not IsValid(e:GetActiveWeapon()) or e:GetActiveWeapon():GetClass()~="gmod_camera") then 
--           local r=e:LookupBone("ValveBiped.Bip01_Head1") or 6 
--           e:ManipulateBoneScale(r,Vector(0,0,0))


--           if not IsValid(e:GetVehicle()) then 
--             local t={}
--             hatpos,hatang=e:GetBonePosition(r)
--             hatpos=hatpos or LocalPlayer():GetShootPos()
--             o=o+a 
--             t.angles=o 
--             t.angles.p=math.Clamp(t.angles.p,-75,75)
--             t.origin=hatpos+o:Up()*5 
--             n=t.origin 
--             t.znear=l 
--             return t 
--           else 
--             local t={}
--             hatpos,hatang=e:GetBonePosition(r)
--             hatpos=hatpos or LocalPlayer():GetShootPos()
--             o=o+a 
--             t.angles=o 
--             t.angles.p=math.Clamp(t.angles.p,-75,75)
--             t.origin=hatpos+(not e:GetVehicle():GetNetworkedBool("Driver") and o:Up()*2 or o:Up()*-5+o:Forward()*5)
--             n=t.origin 
--             t.znear=l 
--             return t 
--           end 
--         elseif (rp.TPCamera.m_conThirdPerson == true) then
--           local r=e:LookupBone("ValveBiped.Bip01_Head1") or 6 
--           e:ManipulateBoneScale(r,Vector(1,1,1))
--         end 
--       end 
--       local function t(a)
--         d=a:KeyDown(IN_WALK)
--         e=e+a:GetViewAngles()-i
--         local o=LocalPlayer():GetVehicle()
--         if IsValid(o) then 
--           e.y=e.y-90 
--           e:Normalize()
--           e.y=math.Clamp(e.y,-110,110)
--           if o:GetNetworkedBool("saw") then 
--             e.p=math.Clamp(e.p,-75,10+35*(1-(math.abs(e.y)/135)^2))
--           else 
--             e.p=math.Clamp(e.p,-25,20*(1-(math.abs(e.y)/135)^2))
--           end 
--           e.y=e.y+90 
--         else 
--           e.p=math.Clamp(e.p,-75,75)
--         end 
--         e:Normalize()
--         a:SetViewAngles(e)
--         i=a:GetViewAngles()
--       end 
--       local 
--       function a(e)
--         if (IsValid(e) and e:Alive() and IsValid(e:GetActiveWeapon()) and e:GetActiveWeapon():GetClass() ~= "gmod_camera") then 
--           return true
--         end 
--         return false
--       end 
--       local function o(e)
--         if e:GetViewEntity()==e then 
--           e:SetNoDraw(true)
--           timer.Simple(1,function()
--             e:SetNoDraw(false)
--           end)
--         end 
--       end 
--       hook.Add("CalcView","FPCalcView",s)
--       hook.Add("ShouldDrawLocalPlayer","FPShouldDrawLocalPlayer",a)
--       hook.Add("CreateMove","FPCreateMove",t)
--       hook.Add("CameraTakePicture","FPCam",o)
--       cvars.AddChangeCallback("fp_complexity",function()
--         local e=tonumber(GetConVarNumber("fp_complexity"))
--         e=tonumber(e)
--         e=e>=0 and e or 0 
--         e=e<=2 and e or 2 
--         c=tonumber(e)
--       end)
--       cvars.AddChangeCallback("fp_nearz",
--         function()
--           l=GetConVarNumber("fp_nearz")
--           if l>25 then l=25 
--             RunConsoleCommand("fp_nearz",25)
--           end 
--           if l<1 then l=1 
--             RunConsoleCommand("fp_nearz",1)
--           end 
--         end)
--       local t={weapon_physcannon=true,weapon_physgun=true}
--       local l=false hook.Add("Think","rp-view",function()
--         local a=false 
--         local e=LocalPlayer()
--         if not IsValid(e:GetVehicle()) then 
--           local l={Vector(2,0,0),Vector(0,2,0),Vector(0,0,2),Vector(2,2,0),Vector(2,-2,0)}
--           local o=function(a)
--             if a==e or(a:GetRenderMode()==RENDERMODE_TRANSALPHA) or a:GetClass()=="prop_ragdoll" or a:GetModel() == "models/braxen/wall_door.mdl" then 
--             return false 
--           else 
--             return true 
--           end 
--         end 
--         for l,e in pairs(l) do 
--           local e=util.TraceLine({start=n+e,endpos=n-e,filter=o})
--           if e.Hit and(not IsValid(veh)or veh:GetNWBool("saw"))
--             then a=true 
--             break 
--           end 
--         end 
--         local l=e:LookupBone("ValveBiped.Bip01_Pelvis")or 0 
--         local e=util.TraceLine({start=e:GetBonePosition(l),endpos=n,filter=o})
--         if e.Hit and(not IsValid(veh)or veh:GetNWBool("saw"))
--           then a=true 
--         end 
--       end 
--       l=a 
--     end)
--       hook.Add("HUDPaint","BlackBar",function()
--         if IsValid(LocalPlayer()) and (rp.TPCamera.m_conThirdPerson == false) then 
--           local e=LocalPlayer():GetActiveWeapon()
--           local a=LocalPlayer():GetVehicle()
--             if l then 
--               draw.RoundedBox(0,-5,-5,ScrW()+10,ScrH()+10,Color(0,0,0))
--             end 
--           end
--         end)
--     end 
--     local function e()
--       if LocalPlayer()==NULL and (rp.TPCamera.m_conThirdPerson == false) then timer.Simple(1,e)
--       else 
--         if (rp.TPCamera.m_conThirdPerson == false) then
--           s()
--         end
--       end 
--     end 
--   hook.Add("PlayerLoaded", "PlayerLoaded.FirstPerson", function()
--     if IsValid(LocalPlayer()) then s() rp.TPCamera.m_conThirdPerson = false end
--   end)
  
-- hook.Add("HUDPaint","FixHead",function()
--     if IsValid(LocalPlayer()) and (rp.TPCamera.m_conThirdPerson == true) then
--       local r=LocalPlayer():LookupBone("ValveBiped.Bip01_Head1") or 6 
--       LocalPlayer():ManipulateBoneScale(r,Vector(1,1,1))
--     end
--     -- hook.Remove("HUDPaint","FixHead")
-- end)
