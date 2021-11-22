AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Simple NPC"
ENT.Author = "Mactavish"
ENT.Spawnable = false
ENT.AdminSpawnable = true

function ENT:Initialize()
	self.SimpleNPC = true
	self.UsingPlayer = false
end

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "Namer")
	self:NetworkVar("String", 1, "UID")
	self:NetworkVar("String", 2, "DefAnimation")
	self:NetworkVar("Bool", 0, "InputLimit")
end

if SERVER then
	function ENT:AcceptInput(istr, ply)
		if IsValid(ply) and (!ply.UseTimer or ply.UseTimer < CurTime()) then
			
			ply.UseTimer = CurTime() + MCS.Config.UseDelay
			
			if self:GetInputLimit() then
				if self.UsingPlayer then
					return
				else
					self.UsingPlayer = ply
				end
			end
			
			net.Start("OpenMCSMenu")
				net.WriteEntity(self)
			net.Send(ply)
				
		end
	end

	function ENT:Think()
		
		if self:GetInputLimit() then
			if self.UsingPlayer != false and !IsValid(self.UsingPlayer) then
				self.UsingPlayer = false
			end
		end
		
		self:NextThink(CurTime())  
		return true
		
	end
end