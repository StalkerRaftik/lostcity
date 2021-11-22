AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua')

util.AddNetworkString("TextChange")
net.Receive("TextChange", function( len )
	local entSign = net.ReadEntity()
	local strNewText = net.ReadString()
	SaveText( nil, entSign, { text = strNewText } )
end )

function ENT:Initialize()
	self:SetModel( "models/props_lab/clipboard.mdl" )

	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

	-- Wake the physics object up
	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		-- phys:EnableMotion( false )
		phys:Wake()
	end

	self:SetUseType( SIMPLE_USE )
end
