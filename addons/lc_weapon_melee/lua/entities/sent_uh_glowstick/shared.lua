ENT.Type		= "anim"
ENT.PrintName 	= "Glowstick"
ENT.Category	= "Underhell"
ENT.Author		= "Krede"
ENT.Spawnable	= true

function ENT:SetupDataTables()
	self:NetworkVar( "Bool", 0, "On" )
end