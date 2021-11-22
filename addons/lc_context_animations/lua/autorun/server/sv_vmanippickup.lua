util.AddNetworkString( "VManip_PickupEntity" )

local vmanip_pickup = CreateConVar( "sv_vmanip_pickups", 1, { FCVAR_ARCHIVE,FCVAR_REPLICATED }, "Toggles manual pickup" )

net.Receive("VManip_PickupEntity", function(len, ply) -- yea you can pick shit up through walls, just don't allow cslua dumbnuts
local pickupentity = net.ReadEntity()

if IsValid(pickupentity) then
	if pickupentity:GetPos():DistToSqr(ply:GetPos())>9000 then return end
	ply.EntityToPickup = pickupentity

	pickupentity:SetPos(ply:GetPos()+Vector(0,0,32))
	local physobj=pickupentity:GetPhysicsObject()
	if IsValid(physobj) then physobj:Wake() end

end

end)



hook.Add("PlayerCanPickupItem", "VManip_PickupPCPI", function( ply, item )

if vmanip_pickup:GetBool() then
if item!=ply.EntityToPickup and item:GetClass()!="item_suit" then
	return false
end

ply.EntityToPickup = nil

end

end)


hook.Add("PlayerSpawn","VManip_PickupSpawnVar",function(ply)

ply.SpawnTimerVManip=CurTime()+1

end)


hook.Add( "PlayerCanPickupWeapon", "VManip_PickupPCPW", function( ply, wep ) --handle weapon pickup

if vmanip_pickup:GetBool() then

if IsValid(wep) and IsValid(ply) then
	if wep!=ply.EntityToPickup and
	CurTime()>ply.SpawnTimerVManip and
	wep:GetPos() != ply:GetPos() then
		return false
	end
end

end

end )

hook.Add("AllowPlayerPickup", "VManip_PickupFix", function(ply, ent)

if vmanip_pickup:GetBool() then
	local class=ent:GetClass()
	if (string.find(class,"item_") and class!="item_suit") or ent:IsWeapon() then
	return false
	end
end

end)
