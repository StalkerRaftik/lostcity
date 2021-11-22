local meta = FindMetaTable( "Player" )

util.AddNetworkString("Cosmetics:NotifyPlayer")

function meta:CM_Notif( msg, time )
	
	local ply = self
	
	if not IsValid( ply ) or not ply:IsPlayer() then return end
	
	msg = msg or ""
	time = time or 5
	
	DarkRP.notify(ply, 4, NOTIFY_GENERIC, msg)
end