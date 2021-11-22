AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");
include("shared.lua");

local matTable = {
68, 85, 78
}

function ENT:Initialize()
	self:SetModel("models/props_lab/box01a.mdl");
	self:PhysicsInit(SOLID_VPHYSICS);
	
	self:SetMoveType(MOVETYPE_VPHYSICS);
	self:SetSolid(SOLID_VPHYSICS);
	
	self:SetDTInt(1, 0);
	self:SetDTInt(2, FS_Lemon_Seed_Time);
	self:SetDTBool(3, false);
	self:SetDTBool(4, false);
	self:GetPhysicsObject():SetMass(105);
	self:GetPhysicsObject():Wake()
end;

function ENT:OnTakeDamage(dmginfo)
	self:VisualEffect();
	for k,v in pairs(ents.FindInSphere(self:GetPos(), 128)) do
		if (v:GetDTBool(0) and (v:GetDTInt(0) == self:EntIndex())) then
			v:GetPhysicsObject():EnableMotion(true);
			v:GetPhysicsObject():SetVelocity(v:GetForward() * 2);		
		end;			
	end;	
	self:EmitSound("physics/body/body_medium_break"..math.random(2, 4)..".wav");
	self:Remove()
end;

function ENT:SpawnFunction(ply, trace)
	local ent = ents.Create("fs_lemon_seeds");
	ent:SetPos(trace.HitPos + trace.HitNormal * 8);
	ent:Spawn();
	ent:Activate();    
	return ent;
end;

function ENT:Use(activator, caller)
local curTime = CurTime();
	if (!self.nextUse or curTime >= self.nextUse) then
		if (activator:GetEyeTrace().Entity == self) and (activator:GetPos():Distance(self:GetPos())<FS_Use_Distance) then
			if self:GetDTBool(3) and (self:GetDTInt(1) == 0) then
				self:EmitSound("physics/surfaces/sand_impact_bullet4.wav");
				self:SetModel("models/props/de_inferno/crate_fruit_break_gib2.mdl");
				self:SetMaterial("models/props_wasteland/dirtwall001a");
				self:SetPos(self:GetPos()+Vector(0, 0, -4));
				self:GetPhysicsObject():EnableMotion(false);
				self:SetDTInt(1, 1);		
			self.nextUse = curTime + 0.5;						
			elseif (self:GetDTInt(1) == 3) then
				local lemonsAround = 0;
				for k,v in pairs(ents.FindInSphere(self:GetPos(), 128)) do
					if (v:GetDTBool(0) and (v:GetDTInt(0) == self:EntIndex())) then
						lemonsAround = lemonsAround + 1;			
					end;			
				end;
				if (lemonsAround > 0) then
					local shake = ents.Create("env_shake");
					shake:SetPos(self:GetPos());
					shake:SetKeyValue("amplitude", "256");
					shake:SetKeyValue("radius", "64");
					shake:SetKeyValue("duration", "0.5");
					shake:SetKeyValue("frequency", "128");
					shake:SetKeyValue("spawnflags", "4");
					shake:Spawn();
					shake:Activate();
					shake:Fire("StartShake", "", 0);
					self:EmitSound("physics/body/body_medium_impact_hard"..math.random(1, 6)..".wav");					
					for k,v in pairs(ents.FindInSphere(self:GetPos(), 128)) do
						if (v:GetDTBool(0) and (v:GetDTInt(0) == self:EntIndex())) then
							v:GetPhysicsObject():EnableMotion(true);
							v:GetPhysicsObject():SetVelocity(activator:GetForward()*-FS_Punch_Power);		
						end;			
					end;
				end;
				self.nextUse = curTime + 0.5;			
			end;
		end;
	end;
end;

function ENT:Think()
local traceData = {}	
traceData.start = self:GetPos();
traceData.endpos = self:GetPos()+Vector(0, 0, -8);
traceData.filter = self;
local trace = util.TraceLine(traceData);
	if self:GetDTBool(3) and (self:GetDTInt(1) == 0) then
		self:EmitSound("physics/surfaces/sand_impact_bullet4.wav");
		self:SetModel("models/props/de_inferno/crate_fruit_break_gib2.mdl");
		self:SetMaterial("models/props_wasteland/dirtwall001a");
		self:SetPos(self:GetPos()+Vector(0, 0, -4));
		self:GetPhysicsObject():EnableMotion(false);
		self:SetDTInt(1, 1);
	end

	if (table.HasValue(matTable, trace.MatType) and (self:GetDTInt(1) == 0) and trace.HitWorld) then	
		self:SetDTBool(3, true);
	else
		self:SetDTBool(3, false);
	end;
	
	if (!self.nextSec or CurTime() >= self.nextSec) then	
		if (self:GetDTInt(1) == 1) then
			if self:GetDTInt(2)>0 then
				self:SetDTInt(2, self:GetDTInt(2)-1);
			elseif (self:GetDTInt(2) == 0) then
				self:EmitSound("physics/surfaces/sand_impact_bullet4.wav");
				self:SetModel("models/props/cs_office/plant01_p1.mdl");
				self:PhysicsInit(SOLID_VPHYSICS);
				self:SetMoveType(MOVETYPE_VPHYSICS);
				self:SetSolid(SOLID_VPHYSICS);
				self:SetCollisionGroup(COLLISION_GROUP_WORLD);
				self:SetMaterial("");
				self:SetPos(self:GetPos()+Vector(0, 0, -10));
				self:SetAngles(Angle(0,math.random(0, 360),0));
				self:GetPhysicsObject():EnableMotion(false);
				self:SetDTInt(2, FS_Lemon_Harvest_Time);
				self:SetDTInt(1, 2);
				self:GetPhysicsObject():SetMass(105);		
				self:SetColor(Color(225, 255, 0));
			end;
		end;
		if (self:GetDTInt(1) == 2) then
			if self:GetDTInt(2)>0 then
				self:SetDTInt(2, self:GetDTInt(2)-1);
			elseif (self:GetDTInt(2) == 0) then
				for i=1, FS_Lemon_Harvest_Amount do
					local apple = ents.Create("spawned_food")
					apple:SetAngles(Angle(0,math.random(0, 360),90));
					apple:SetPos(self:GetPos()+(self:GetUp()*math.random(30, 60))+(self:GetRight()*math.random(-5, 5))+(self:GetForward()*math.random(-5, 5)));		
					apple:SetModel("models/foodnhouseholditems/grapes1.mdl")				
					apple:Spawn();
					apple.SID = self.SID or nil;
					apple:SetDTInt(0, self:EntIndex());	
					apple:SetDTBool(0, true);					
					apple:GetPhysicsObject():EnableMotion(true);			
				end;	
				self:Remove()			
				-- self:GetPhysicsObject():EnableMotion(false);
				-- self:SetDTInt(1, 3);				
			end;
		end;
		if (self:GetDTInt(1) == 3) then
			local lemonsAround = 0;
			for k,v in pairs(ents.FindInSphere(self:GetPos(), 128)) do
				if (v:GetDTBool(0) and (v:GetDTInt(0) == self:EntIndex())) then
					lemonsAround = lemonsAround + 1;			
				end;			
			end;
			if (lemonsAround > 0) then
				self:SetDTBool(4, false);			
			elseif (lemonsAround == 0) then
				self:SetDTBool(4, false);
				self:SetDTInt(1, 2);
				self:SetDTInt(2, FS_Lemon_Harvest_Time);
			end;
		end;		
	self.nextSec = CurTime() + 1;
	end;	
end;

function ENT:VisualEffect()
	local effectData = EffectData();	
	effectData:SetStart(self:GetPos());
	effectData:SetOrigin(self:GetPos());
	effectData:SetScale(8);	
	util.Effect("GlassImpact", effectData, true, true);
end;

