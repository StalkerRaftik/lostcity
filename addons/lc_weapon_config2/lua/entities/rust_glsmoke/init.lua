AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	local mdl = self:GetModel()

	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	local phys = self:GetPhysicsObject()
	self:NextThink(CurTime() + 0.1)

	if phys:IsValid() then
		phys:Wake()
		phys:SetMass(1)
		phys:SetDamping(0,10)
	end


	self:SetUseType(SIMPLE_USE)


	self.DestroyTime = CurTime() + 20
	self.StartTime = CurTime() + 2
	self.Started = false
end



function ENT:Think()
	self:NextThink(CurTime() + 0.1)
	if CurTime() > self.DestroyTime then
		self:Remove()
	end
	if CurTime() > self.StartTime then
		self:Explode()
		self.Started = true
		self:EmitSound( "darky_rust.smoke_loop" )
		self.StartTime = CurTime() + 5
	end
end


function ENT:Explode()
	if not IsValid(self.owner) then
		self:Remove()
		return
	end

	if self.Started then return end

	self.DestroyTime = CurTime() + 20

	
	-- self:EmitSound("darky_rust.grenade-launcher-explosion")
	-- shit code
	local positions = {
		Vector(-90,90,25), Vector(0,90,25), Vector(90,90,25), 
		Vector(-90,0,25), Vector(0,0,25), Vector(90,0,25), 
		Vector(-90,-90,25), Vector(0,-90,25), Vector(90,-90,25), 
	}

	for i=1, 9 do
		smoke = ents.Create("env_smoketrail")
		smoke:SetKeyValue("startsize", "100000")
		smoke:SetKeyValue("endsize", "90000")
		-- smoke:SetKeyValue("spawnradius", "1")
		smoke:SetKeyValue("opacity", "1")
		smoke:SetKeyValue("spawnrate", "2")
		smoke:SetKeyValue("lifetime", "5")
		smoke:SetKeyValue("startcolor", "255 255 255")
		smoke:SetKeyValue("endcolor", "255 255 255")
		smoke:SetPos(self:GetPos()+positions[i])
		smoke:SetParent(self)
		smoke:Spawn()
		smoke:Fire("kill", "", 20)
	end
end




function ENT:Use(ply, caller)
end