AddCSLuaFile()

local vmanipentitypickup = nil
local VMInteractModel
local VMInteractModelTBL={}
local vmanipitemmodel
local vmanipscalelerp=0.7
local dopickupdraw=false

local clpickup = CreateConVar( "sv_vmanip_pickups", 1, { FCVAR_ARCHIVE,FCVAR_REPLICATED }, "Toggles manual pickup" )
local clpickuphalo = CreateConVar( "cl_vmanip_pickups_halo", 0, { FCVAR_ARCHIVE }, "Toggles halos" )


hook.Add( "StartCommand", "VManipPickupHook", function(ply,ucmd) --check use key for pickup hook

if ucmd:KeyDown(IN_USE) and !VManip:IsActive() and IsValid(vmanipentitypickup) and !vmanipentitypickup:IsWorld() and clpickup:GetBool() then
  vmanipitemmodel = vmanipentitypickup:GetModel()
  VManip:PlayAnim("interactslower")
	dopickupdraw=false
  timer.Simple(0.2, function() if VManip:IsActive() and IsValid(vmanipentitypickup) then net.Start("VManip_PickupEntity") net.WriteEntity(vmanipentitypickup) net.SendToServer() end end )

  timer.Simple(0.01,function() if VManip:IsActive() and IsValid(vmanipentitypickup) then
  local eyeang=ply:EyeAngles()
  local vm=ply:GetViewModel()
  VMInteractModel = ClientsideModel( vmanipitemmodel, RENDERGROUP_BOTH )
  VMInteractModel:SetPos( vm:GetPos()+vm:GetAngles():Right()*3+vm:GetAngles():Forward()*4 )
  VMInteractModel:SetAngles( ply:GetViewModel():GetAngles() )
  VMInteractModel:SetParent( ply:GetViewModel() )
  VMInteractModel:SetModelScale(0.7,0)
  VMInteractModel:FollowBone( VManip.VMGesture, VManip.VMGesture:LookupBone("ValveBiped.Bip01_L_Hand") )
  VMInteractModel:SetPredictable( false )
  VMInteractModel:SetNoDraw(true)
  table.insert(VMInteractModelTBL,VMInteractModel)
end end)



  timer.Simple(0.2, function() if IsValid(VMInteractModel) then dopickupdraw=true VMInteractModel:SetNoDraw(true) vmanipscalelerp = 0.7 end end )

end

end)


hook.Add( "PreDrawHalos", "PickupHalo", function() --FPS killing halos
if !clpickup:GetBool() or !clpickuphalo:GetBool() then return end
local ply = LocalPlayer()
if ply:Alive() and vmanipentitypickup!=nil then
  halo.Add( {vmanipentitypickup}, Color( 255, 255, 0 ), 5, 5, 2 )
end

end )

local delay=0
hook.Add("Think","VManipPickupThink",function() --pickup think helper hook
local ply = LocalPlayer()

if !clpickup:GetBool() or CurTime()<delay then return end
delay=CurTime()+0.05

if !IsValid(vmanipentitypickup) then
if type(vmanipentitypickup) == "Entity" or type(vmanipentitypickup) == "Weapon" then vmanipentitypickup=nil end end


if !VManip:IsActive() and #VMInteractModelTBL>0 then

for k,v in pairs(VMInteractModelTBL) do
	if IsValid(v) then v:Remove() end
end
VMInteractModelTBL={}

end

if vmanipentitypickup==nil then
  local tr = util.TraceLine( {
    start = ply:GetShootPos(),
    endpos = ply:GetShootPos() + ply:EyeAngles():Forward() * 100,
    filter = ply
  } )
  if !tr.Entity:IsNPC() and !tr.Entity:IsPlayer() and IsValid(tr.Entity) then
	local entclass=tr.Entity:GetClass()
	if string.find(entclass, "item_") != nil or tr.Entity:IsWeapon() then

    if ( entclass=="item_healthcharger" or entclass=="item_suitcharger" ) or string.find(entclass,"crate" ) then return end
    if ( entclass=="item_healthvial" or entclass=="item_healthkit" ) and ply:Health()>=ply:GetMaxHealth() then return end
	if ( entclass=="item_battery" ) and ply:Armor()>=100 then return end
	if ( entclass=="item_suit" ) then return end
	vmanipentitypickup=tr.Entity

    end end

  elseif vmanipentitypickup!=nil and IsValid(vmanipentitypickup) then
    local tr = util.TraceLine( {
      start = ply:GetShootPos(),
      endpos = ply:GetShootPos() + ply:EyeAngles():Forward() * 100,
      filter = ply
    } )
    if vmanipentitypickup:GetPos():DistToSqr(tr.HitPos) > 400 and !VManip:IsActive() then

      vmanipentitypickup = nil

    end
  end
end)


hook.Add("PostDrawViewModel","VManip_PickupModel",function()

if VManip:GetCurrentAnim()=="interactslower" then 
  if IsValid(VMInteractModel) and dopickupdraw then

    VMInteractModel:DrawModel()
    vmanipscalelerp = Lerp(FrameTime(), vmanipscalelerp, 0)
    if vmanipscalelerp < 0.35 then vmanipscalelerp = 0 end
    VMInteractModel:SetModelScale(math.Truncate(vmanipscalelerp,4),0)

  end
end

end)