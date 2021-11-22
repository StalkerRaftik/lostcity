AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:SpawnFunction(ply, tr)
	local SpawnPos = tr.HitPos + tr.HitNormal * 6
	local ent = ents.Create(self.ClassName)
	local angle = ply:GetAimVector():Angle()
	angle = Angle(0, angle.yaw, 0)
	ent:SetAngles(angle)
	ent:SetPos(SpawnPos)
	ent:Spawn()
	ent:Activate()

	return ent
end

function ENT:Initialize()
	self:SetModel( "models/zerochain/props_lawnmower/zlm_trailer.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)

	local phys = self:GetPhysicsObject()

	if (phys:IsValid()) then
		phys:EnableDrag( true )
		phys:SetDragCoefficient( 100 )
		--phys:SetMass(10)
		phys:Wake()
		phys:EnableMotion(true)
	end

	self.GravgunDisabled = true

	self.FrontAxl = self:CreateAx(1,"models/zerochain/props_lawnmower/zlm_trailer_front_ax.mdl")

	self:CreateWheel(self,3)
	self:CreateWheel(self,4)

	zlm.f.EntList_Add(self)
end

function ENT:CreateWheel(axl,attachID)

	local attach = axl:GetAttachment(attachID)

	local pos = attach.Pos
	local ang = attach.Ang

	local wheel = ents.Create( "prop_physics" )
	if ( !IsValid( wheel ) ) then return end

	wheel:SetModel("models/zerochain/props_lawnmower/zlm_wheel.mdl")
	wheel:SetPos(pos)

	ang:RotateAroundAxis(ang:Up(), 180)
	wheel:SetAngles(ang)
	wheel:Spawn()

	local phys = axl:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:EnableDrag( true )
		phys:SetDragCoefficient( 100 )
		--phys:SetMass(25)
		phys:Wake()
		phys:EnableMotion(true)
	end

	self:DeleteOnRemove(wheel)
	wheel.GravgunDisabled = true

	local dir = ang:Right()

	local lPos01 = wheel:WorldToLocal(wheel:GetPos() + dir)
	local lPos02 = axl:WorldToLocal(pos + dir * 1)

	constraint.Axis( wheel, axl, 0, 0, lPos01, lPos02, 0, 0, 0, 1, Vector(), false )

	constraint.NoCollide( wheel, self, 0, 0 )
	constraint.NoCollide( wheel, axl, 0, 0 )

	wheel.PhysgunDisabled = true
end

function ENT:CreateAx(attachID,model)
	local attach = self:GetAttachment(attachID)

	local axl = ents.Create( "prop_physics" )

	if ( !IsValid( axl ) ) then return end

	axl:SetModel(  model )
	axl:SetPos( attach.Pos + self:GetUp() * -9 )

	local ang = attach.Ang
	ang:RotateAroundAxis(ang:Up(),90)
	ang:RotateAroundAxis(attach.Ang:Right(),-90)
	axl:SetAngles( ang )

	axl:Spawn()
	axl.GravgunDisabled = true
	local phys = axl:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:EnableMotion(false)
	end

	timer.Simple(1,function()
		if IsValid(phys) then
			phys:EnableDrag( true )
			phys:SetDragCoefficient( 100 )
			--phys:SetAngleDragCoefficient( 100 )
			phys:SetMass(200)
			phys:Wake()
			phys:EnableMotion(true)
		end
	end)

	self:DeleteOnRemove(axl)

	ang = attach.Ang
	ang:RotateAroundAxis(ang:Up(),180)
	local dir = ang:Up()

	local lPos01 = axl:WorldToLocal(axl:GetPos() + dir)
	local lPos02 = self:WorldToLocal(attach.Pos + dir * 1)

	constraint.Axis( axl, self, 0, 0, lPos01, lPos02, 0, 0, 0.9, 1, Vector(), false )

	constraint.Keepupright( axl, Angle(0,0,0), 0, 200 )

	self:CreateWheel(axl,1)
	self:CreateWheel(axl,2)

	//axl.PhysgunDisabled = true

	return axl
end

function ENT:StartTouch(other)

	if IsValid(other) and other:GetClass() == "zlm_grassroll" then
		if zlm.f.CollisionCooldown(other) then return end

		local rolls = self:GetGrassRolls()

		if rolls < 5 then

			self:SetGrassRolls(rolls + 1)
			SafeRemoveEntity( other )
		end
	end
end
