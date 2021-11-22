AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");
include("shared.lua");


function ENT:Initialize()
	self:SetModel("models/props_lab/box01a.mdl");
	self:PhysicsInit(SOLID_VPHYSICS);
	
	self:SetMoveType(MOVETYPE_VPHYSICS);
	self:SetSolid(SOLID_VPHYSICS);
	
	self:GetPhysicsObject():SetMass(105);
	self:GetPhysicsObject():Wake()
end;

function ENT:OnTakeDamage(dmginfo)
end;


function ENT:Use(activator, caller)
end;

local ThinkDelay = 0.1
local ThinkTimer = 0
function ENT:Think()
	if CurTime() < ThinkTimer then return end
	ThinkTimer = CurTime() + ThinkDelay

	local traceData = {}	
	traceData.start = self:GetPos();
	traceData.endpos = self:GetPos()+Vector(0, 0, -8);
	traceData.filter = self;
	local trace = util.TraceLine(traceData);

	local owner = self:GetNetVar('PropOwner')

	local match
	for k, v in pairs(ents.FindInSphere( self:GetPos(), 30 )) do
		if v:GetClass() == "matches" then
			match = v
			break
		end
	end 


	if trace.HitWorld and match ~= nil then	
		match:Remove()
		self:EmitSound("physics/surfaces/sand_impact_bullet4.wav");
		local fireplace = ents.Create("sent_vj_fireplace");
		fireplace:SetPos(self:GetPos());
		fireplace:Spawn();
		fireplace:Activate();
		fireplace.infinite = false
		self:Remove()
	end
end

