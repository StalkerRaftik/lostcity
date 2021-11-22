AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include("shared.lua")

function SWEP:DropMag()
	net.Start("TFA_CSGO_DropMag")
	net.WriteEntity(self)

	if sp then
		net.Broadcast()
	else
		net.SendOmit(self:GetOwner())
	end
end