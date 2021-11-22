AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/Gibs/HGIBS.mdl")

	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	local phys = self:GetPhysicsObject()
	self:NextThink(CurTime() + 0.5)

	self.snd = self:StartLoopingSound("darky_rust.campfire-loop")

	if (phys:IsValid()) then
		phys:Wake()
		phys:SetMass(1)
	end
	self:SetAngles(Angle(math.random(0,7),math.random(0,7),math.random(0,7))*10)
	self.DestroyTime = CurTime() + math.random(10,15)
	self:SetCustomCollisionCheck(true)
end



function ENT:Think()
	if CurTime() > self.DestroyTime then
		self:StopSound("darky_rust.campfire-loop")
		self:Remove()
	end
	
	for k, v in pairs (ents.FindInSphere(self:GetPos(), 20)) do
		self:NextThink(CurTime() + 0.75)
		local p = DamageInfo()
		p:SetDamage(1.5)
		p:SetAttacker(v)
			
		if v:IsPlayer() then
			p:SetDamageType(DMG_SLOWBURN)
			v:EmitSound("darky_rust.fire")
			if GetConVar("tfa_rust_slowdown_onfire"):GetBool()then
				if not v.RustSlowDown then
							v.RustWalkSpeed = v:GetWalkSpeed()
					v.RustRunSpeed = v:GetRunSpeed()
				end
				v:SetWalkSpeed(v.RustWalkSpeed*0.4)
				v:SetRunSpeed(v.RustRunSpeed*0.4)
				v.RustSlowDown = CurTime()+1
			end
		else
			p:SetDamageType(DMG_BURN)
		end

		v:TakeDamageInfo(p)
	end
	return true
end

function ENT:OnRemove()
	self:StopSound("darky_rust.campfire-loop")
end