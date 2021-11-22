--------------------------------------
--------LEAKED BY ANONYMOUS LEAKR --------------
----------------------------------------
include("shared.lua");

surface.CreateFont("methFont", {
	font = "Arial",
	size = 30,
	weight = 600,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
});

surface.CreateFont("methFont1", {
	font = "Arial",
	size = 15,
	weight = 600,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
});

function ENT:Initialize()	
	self.emitTime = CurTime();
	self.firePlace1 = ParticleEmitter(self:GetPos());
	self.firePlace2 = ParticleEmitter(self:GetPos());
	self.firePlace3 = ParticleEmitter(self:GetPos());
	self.firePlace4 = ParticleEmitter(self:GetPos());
end;


local laser = Material("cable/redlaser")
function ENT:Draw()
	self:DrawModel();
	
	local pos = self:GetPos()
	local ang = self:GetAngles()
	
	ang:RotateAroundAxis(ang:Up(), 90);
	ang:RotateAroundAxis(ang:Forward(), 90);

	if LocalPlayer():GetPos():Distance(self:GetPos()) < self:GetNWInt("distance") then
		render.SetMaterial(laser);
		--Fire Place #1
		render.DrawBeam(self:GetPos()+(self:GetUp()*20)+(self:GetForward()*2.8)+(self:GetRight()*11.5), self:GetPos()+(self:GetUp()*24)+(self:GetForward()*2.8)+(self:GetRight()*11.5), 1, 1, 1, Color(255, 0, 0, 0));
		
		--Fire Place #2
		render.DrawBeam(self:GetPos()+(self:GetUp()*20)+(self:GetForward()*2.8)+(self:GetRight()*-11.2), self:GetPos()+(self:GetUp()*24)+(self:GetForward()*2.8)+(self:GetRight()*-11.2), 1, 1, 1, Color(255, 0, 0, 0));

		--Fire Place #3
		render.DrawBeam(self:GetPos()+(self:GetUp()*20)+(self:GetForward()*-9.8)+(self:GetRight()*-11.2), self:GetPos()+(self:GetUp()*24)+(self:GetForward()*-9.8)+(self:GetRight()*-11.2), 1, 1, 1, Color(255, 0, 0, 0));
		
		--Fire Place #4
		render.DrawBeam(self:GetPos()+(self:GetUp()*20)+(self:GetForward()*-9.8)+(self:GetRight()*11.5), self:GetPos()+(self:GetUp()*24)+(self:GetForward()*-9.8)+(self:GetRight()*11.5), 1, 1, 1, Color(255, 0, 0, 0));		
		
		cam.Start3D2D(pos+ang:Up()*14.5, ang, 0.1)
		
			surface.SetDrawColor(Color(0, 0, 0, 200));
			surface.DrawRect(-215, -51, 194, 20)

			surface.SetDrawColor(Color(0, 0, 0, 200));
			surface.DrawRect(-215, -90, 48, 32)	

			--Fire Place #1
			if !self:GetNWBool("firePlace1") then
				surface.SetDrawColor(Color(255, 0, 0, 255));
			elseif self:GetNWBool("firePlace1") then
				if (self:GetNWInt("gasStorage")>0) then
					surface.SetDrawColor(Color(0, 255, 0, 255));
				else 		
					surface.SetDrawColor(Color(255, 0, 0, 255));
				end;
			end;
				surface.SetMaterial(Material( "icon16/stop.png" ));
				surface.DrawTexturedRect(-212.5, -73, 14, 14);
				
			--Fire Place #2
			if !self:GetNWBool("firePlace2") then			
				surface.SetDrawColor(Color(255, 0, 0, 255));
			elseif self:GetNWBool("firePlace2") then
				if (self:GetNWInt("gasStorage")>0) then
					surface.SetDrawColor(Color(0, 255, 0, 255));
				else 		
					surface.SetDrawColor(Color(255, 0, 0, 255));
				end;
			end;				
				surface.SetMaterial(Material( "icon16/stop.png" ));
				surface.DrawTexturedRect(-184.5, -73, 14, 14);	
				
			--Fire Place #3
			if !self:GetNWBool("firePlace3") then				
				surface.SetDrawColor(Color(255, 0, 0, 255));	
			elseif self:GetNWBool("firePlace3") then		
				if (self:GetNWInt("gasStorage")>0) then
					surface.SetDrawColor(Color(0, 255, 0, 255));
				else 		
					surface.SetDrawColor(Color(255, 0, 0, 255));
				end;
			end;	
				surface.SetMaterial(Material( "icon16/stop.png" ));		
				surface.DrawTexturedRect(-184.5, -89, 14, 14);	
			
			--Fire Place #4
			if !self:GetNWBool("firePlace4") then					
				surface.SetDrawColor(Color(255, 0, 0, 255));
			elseif self:GetNWBool("firePlace4") then			
				if (self:GetNWInt("gasStorage")>0) then
					surface.SetDrawColor(Color(0, 255, 0, 255));
				else 		
					surface.SetDrawColor(Color(255, 0, 0, 255));
				end;
			end;
				surface.SetMaterial(Material( "icon16/stop.png" ));
				surface.DrawTexturedRect(-212.5, -89, 14, 14);			
					
		cam.End3D2D()
	end;
end;